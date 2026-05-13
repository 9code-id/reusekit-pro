import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaEmergencyContactsView extends StatefulWidget {
  const HcaEmergencyContactsView({super.key});

  @override
  State<HcaEmergencyContactsView> createState() => _HcaEmergencyContactsViewState();
}

class _HcaEmergencyContactsViewState extends State<HcaEmergencyContactsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedRelationship = "All";

  // Form fields for adding new contact
  String contactName = "";
  String phoneNumber = "";
  String email = "";
  String relationship = "Family";
  String address = "";
  String notes = "";
  bool isPrimary = false;
  bool isAvailable24x7 = false;

  List<Map<String, dynamic>> relationshipItems = [
    {"label": "All", "value": "All"},
    {"label": "Family", "value": "Family"},
    {"label": "Friend", "value": "Friend"},
    {"label": "Doctor", "value": "Doctor"},
    {"label": "Neighbor", "value": "Neighbor"},
    {"label": "Colleague", "value": "Colleague"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> emergencyContacts = [
    {
      "id": "1",
      "name": "Dr. Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@hospital.com",
      "relationship": "Doctor",
      "address": "123 Medical Center Dr, City, State 12345",
      "notes": "Primary care physician",
      "isPrimary": true,
      "isAvailable24x7": false,
      "lastContacted": "2024-06-10",
    },
    {
      "id": "2",
      "name": "Michael Smith",
      "phone": "+1 (555) 987-6543",
      "email": "michael.smith@email.com",
      "relationship": "Family",
      "address": "456 Oak Street, City, State 12345",
      "notes": "Brother - has medical power of attorney",
      "isPrimary": true,
      "isAvailable24x7": true,
      "lastContacted": "2024-06-15",
    },
    {
      "id": "3",
      "name": "Emergency Services",
      "phone": "911",
      "email": "",
      "relationship": "Emergency",
      "address": "Local Emergency Services",
      "notes": "Call for life-threatening emergencies",
      "isPrimary": true,
      "isAvailable24x7": true,
      "lastContacted": "Never",
    },
    {
      "id": "4",
      "name": "Jennifer Davis",
      "phone": "+1 (555) 456-7890",
      "email": "jennifer.davis@email.com",
      "relationship": "Friend",
      "address": "789 Pine Avenue, City, State 12345",
      "notes": "Close friend, nurse by profession",
      "isPrimary": false,
      "isAvailable24x7": false,
      "lastContacted": "2024-06-12",
    },
    {
      "id": "5",
      "name": "Poison Control",
      "phone": "1-800-222-1222",
      "email": "",
      "relationship": "Emergency",
      "address": "National Poison Control Center",
      "notes": "Call for poison-related emergencies",
      "isPrimary": false,
      "isAvailable24x7": true,
      "lastContacted": "Never",
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Call 911",
      "subtitle": "Life-threatening emergency",
      "icon": Icons.local_hospital,
      "color": dangerColor,
      "phone": "911",
    },
    {
      "title": "Poison Control",
      "subtitle": "Poison-related emergency",
      "icon": Icons.warning,
      "color": warningColor,
      "phone": "1-800-222-1222",
    },
    {
      "title": "Primary Contact",
      "subtitle": "Michael Smith",
      "icon": Icons.person,
      "color": primaryColor,
      "phone": "+1 (555) 987-6543",
    },
    {
      "title": "Primary Doctor",
      "subtitle": "Dr. Sarah Johnson",
      "icon": Icons.medical_services,
      "color": successColor,
      "phone": "+1 (555) 123-4567",
    },
  ];

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: action["color"] as Color,
          ),
        ),
      ),
      child: Column(
        children: [
          Icon(
            action["icon"] as IconData,
            size: 32,
            color: action["color"] as Color,
          ),
          SizedBox(height: spXs),
          Text(
            "${action["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            "${action["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Call",
              size: bs.sm,
              onPressed: () {
                // Make phone call
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: contact["isPrimary"] == true ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${contact["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (contact["isPrimary"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "PRIMARY",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              if (contact["isAvailable24x7"] == true) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "24/7",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${contact["relationship"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Last: ${contact["lastContacted"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "${contact["phone"]}",
                style: TextStyle(fontSize: 14, color: primaryColor),
              ),
            ],
          ),
          if ("${contact["email"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.email, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "${contact["email"]}",
                  style: TextStyle(fontSize: 14, color: successColor),
                ),
              ],
            ),
          ],
          if ("${contact["address"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${contact["address"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ),
              ],
            ),
          ],
          if ("${contact["notes"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Notes: ${contact["notes"]}",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call",
                  size: bs.sm,
                  onPressed: () {
                    // Make phone call
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Message",
                  size: bs.sm,
                  onPressed: () {
                    // Send message
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    // Edit contact
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCallTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emergency Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Emergency Guidelines",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "• Call 911 for life-threatening emergencies\n• Call Poison Control for poison-related incidents\n• Provide your location and medical information\n• Stay calm and follow dispatcher instructions",
                  style: TextStyle(fontSize: 14, color: dangerColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search contacts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Relationship",
                  items: relationshipItems,
                  value: selectedRelationship,
                  onChanged: (value, label) {
                    selectedRelationship = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          // Contacts List
          ...emergencyContacts.map((contact) => _buildContactCard(contact)),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Emergency Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable Emergency SMS",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Enable Emergency SMS", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto-share Location in Emergency",
                      "value": true,
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Voice Activated Emergency Call",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Voice Activated Emergency Call", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Medical Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Keep your medical information updated for emergency responders",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Medical ID",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to medical ID
                    },
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Emergency Procedures",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Review emergency procedures and first aid information",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Procedures",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to emergency procedures
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddContactTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Add Emergency Contact",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Full Name",
                  value: contactName,
                  hint: "Enter contact's full name",
                  onChanged: (value) {
                    contactName = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Phone Number",
                        value: phoneNumber,
                        hint: "+1 (555) 123-4567",
                        onChanged: (value) {
                          phoneNumber = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Relationship",
                        items: relationshipItems.where((item) => item["value"] != "All").toList(),
                        value: relationship,
                        onChanged: (value, label) {
                          relationship = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "contact@email.com",
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Address",
                  value: address,
                  hint: "Street address, City, State, ZIP",
                  onChanged: (value) {
                    address = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: notes,
                  hint: "Additional information about this contact",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Primary Emergency Contact",
                      "value": true,
                      "checked": isPrimary,
                    }
                  ],
                  value: [if (isPrimary) {"label": "Primary Emergency Contact", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isPrimary = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Available 24/7",
                      "value": true,
                      "checked": isAvailable24x7,
                    }
                  ],
                  value: [if (isAvailable24x7) {"label": "Available 24/7", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isAvailable24x7 = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Contact",
                    size: bs.md,
                    onPressed: () {
                      // Add contact logic
                      currentTab = 1;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Emergency Contacts",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Quick Call", icon: Icon(Icons.emergency)),
        Tab(text: "Contacts", icon: Icon(Icons.contacts)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Add Contact", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildQuickCallTab(),
        _buildContactsTab(),
        _buildSettingsTab(),
        _buildAddContactTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}

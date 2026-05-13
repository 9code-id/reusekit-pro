import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaEmergencyContactsView extends StatefulWidget {
  const MhaEmergencyContactsView({super.key});

  @override
  State<MhaEmergencyContactsView> createState() => _MhaEmergencyContactsViewState();
}

class _MhaEmergencyContactsViewState extends State<MhaEmergencyContactsView> {
  List<Map<String, dynamic>> emergencyContacts = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "relationship": "Primary Doctor",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@hospital.com",
      "address": "123 Medical Center Blvd, City, ST 12345",
      "specialty": "Family Medicine",
      "isPrimary": true,
      "isAvailable24h": false,
      "notes": "Regular family doctor, appointments required",
      "lastContacted": "2024-12-10",
    },
    {
      "id": 2,
      "name": "John Smith",
      "relationship": "Emergency Contact",
      "phone": "+1 (555) 987-6543",
      "email": "john.smith@email.com",
      "address": "456 Family Street, City, ST 12345",
      "specialty": "",
      "isPrimary": true,
      "isAvailable24h": true,
      "notes": "Brother - available anytime",
      "lastContacted": "2024-12-12",
    },
    {
      "id": 3,
      "name": "Emergency Services",
      "relationship": "Emergency",
      "phone": "911",
      "email": "",
      "address": "Local Emergency Response",
      "specialty": "Emergency Response",
      "isPrimary": false,
      "isAvailable24h": true,
      "notes": "Police, Fire, Medical Emergency",
      "lastContacted": "Never",
    },
    {
      "id": 4,
      "name": "Dr. Michael Chen",
      "relationship": "Specialist",
      "phone": "+1 (555) 456-7890",
      "email": "michael.chen@cardiology.com",
      "address": "789 Heart Center Dr, City, ST 12345",
      "specialty": "Cardiology",
      "isPrimary": false,
      "isAvailable24h": false,
      "notes": "Cardiologist - weekdays only",
      "lastContacted": "2024-11-28",
    },
    {
      "id": 5,
      "name": "Maria Rodriguez",
      "relationship": "Family",
      "phone": "+1 (555) 321-0987",
      "email": "maria.rodriguez@email.com",
      "address": "321 Park Avenue, City, ST 12345",
      "specialty": "",
      "isPrimary": false,
      "isAvailable24h": true,
      "notes": "Sister - backup emergency contact",
      "lastContacted": "2024-12-14",
    },
  ];

  String name = "";
  String relationship = "";
  String phone = "";
  String email = "";
  String address = "";
  String specialty = "";
  String notes = "";
  bool isPrimary = false;
  bool isAvailable24h = false;
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickActions(),
            _buildFilterSection(),
            _buildContactsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactModal();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Emergency Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  "Call 911",
                  Icons.emergency,
                  dangerColor,
                  () {
                    _makeCall("911");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Call Doctor",
                  Icons.local_hospital,
                  primaryColor,
                  () {
                    var primaryDoctor = emergencyContacts.firstWhere(
                      (contact) => contact["relationship"] == "Primary Doctor",
                      orElse: () => {},
                    );
                    if (primaryDoctor.isNotEmpty) {
                      _makeCall(primaryDoctor["phone"]);
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  "Call Family",
                  Icons.family_restroom,
                  successColor,
                  () {
                    var primaryContact = emergencyContacts.firstWhere(
                      (contact) => contact["isPrimary"] == true && contact["relationship"] != "Primary Doctor",
                      orElse: () => {},
                    );
                    if (primaryContact.isNotEmpty) {
                      _makeCall(primaryContact["phone"]);
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Share Location",
                  Icons.location_on,
                  warningColor,
                  () {
                    _shareLocation();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(40)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return QDropdownField(
      label: "Filter Contacts",
      items: [
        {"label": "All Contacts", "value": "All"},
        {"label": "Primary Contacts", "value": "Primary"},
        {"label": "Medical Professionals", "value": "Medical"},
        {"label": "Family & Friends", "value": "Family"},
        {"label": "24/7 Available", "value": "24h"},
      ],
      value: selectedFilter,
      onChanged: (value, label) {
        selectedFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildContactsList() {
    var filteredContacts = emergencyContacts;
    
    if (selectedFilter != "All") {
      if (selectedFilter == "Primary") {
        filteredContacts = emergencyContacts.where((contact) => contact["isPrimary"] == true).toList();
      } else if (selectedFilter == "Medical") {
        filteredContacts = emergencyContacts.where((contact) => 
          contact["relationship"] == "Primary Doctor" || 
          contact["relationship"] == "Specialist" ||
          contact["relationship"] == "Emergency"
        ).toList();
      } else if (selectedFilter == "Family") {
        filteredContacts = emergencyContacts.where((contact) => 
          contact["relationship"] == "Family" || 
          contact["relationship"] == "Emergency Contact"
        ).toList();
      } else if (selectedFilter == "24h") {
        filteredContacts = emergencyContacts.where((contact) => contact["isAvailable24h"] == true).toList();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Emergency Contacts",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredContacts.map((contact) => _buildContactItem(contact)).toList(),
      ],
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    Color relationshipColor = _getRelationshipColor(contact["relationship"]);
    IconData relationshipIcon = _getRelationshipIcon(contact["relationship"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: relationshipColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: relationshipColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  relationshipIcon,
                  color: relationshipColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${contact["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (contact["isPrimary"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "PRIMARY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${contact["relationship"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: relationshipColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (contact["specialty"].toString().isNotEmpty)
                      Text(
                        "${contact["specialty"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (contact["isAvailable24h"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: warningColor.withAlpha(40)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "24/7",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${contact["phone"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _makeCall(contact["phone"]),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                if (contact["email"].toString().isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: infoColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${contact["email"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _sendEmail(contact["email"]),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.mail,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (contact["address"].toString().isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: warningColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${contact["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (contact["notes"].toString().isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Text(
                      "${contact["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Text(
                      "Last contacted: ${contact["lastContacted"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _editContact(contact),
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => _deleteContact(contact),
                      child: Icon(
                        Icons.delete,
                        size: 18,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRelationshipColor(String relationship) {
    switch (relationship) {
      case "Primary Doctor": case "Specialist": return primaryColor;
      case "Emergency": return dangerColor;
      case "Emergency Contact": case "Family": return successColor;
      default: return infoColor;
    }
  }

  IconData _getRelationshipIcon(String relationship) {
    switch (relationship) {
      case "Primary Doctor": case "Specialist": return Icons.local_hospital;
      case "Emergency": return Icons.emergency;
      case "Emergency Contact": case "Family": return Icons.family_restroom;
      default: return Icons.person;
    }
  }

  void _showAddContactModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
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
                value: name,
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Relationship",
                items: [
                  {"label": "Primary Doctor", "value": "Primary Doctor"},
                  {"label": "Specialist", "value": "Specialist"},
                  {"label": "Emergency Contact", "value": "Emergency Contact"},
                  {"label": "Family", "value": "Family"},
                  {"label": "Emergency", "value": "Emergency"},
                ],
                value: relationship,
                onChanged: (value, label) {
                  relationship = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Phone Number",
                value: phone,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Email (Optional)",
                value: email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Address (Optional)",
                value: address,
                onChanged: (value) {
                  address = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Specialty (Optional)",
                value: specialty,
                hint: "e.g., Cardiology, Family Medicine",
                onChanged: (value) {
                  specialty = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Notes (Optional)",
                value: notes,
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Primary Contact",
                          "value": true,
                          "checked": isPrimary,
                        }
                      ],
                      value: [if (isPrimary) {"label": "Primary Contact", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isPrimary = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "24/7 Available",
                          "value": true,
                          "checked": isAvailable24h,
                        }
                      ],
                      value: [if (isAvailable24h) {"label": "24/7 Available", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isAvailable24h = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Contact",
                  size: bs.md,
                  onPressed: () {
                    _addContact();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addContact() {
    if (name.isNotEmpty && relationship.isNotEmpty && phone.isNotEmpty) {
      emergencyContacts.insert(0, {
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": name,
        "relationship": relationship,
        "phone": phone,
        "email": email,
        "address": address,
        "specialty": specialty,
        "isPrimary": isPrimary,
        "isAvailable24h": isAvailable24h,
        "notes": notes,
        "lastContacted": "Never",
      });

      _clearForm();
      setState(() {});
      ss("Emergency contact added successfully");
    } else {
      se("Please fill in all required fields");
    }
  }

  void _editContact(Map<String, dynamic> contact) {
    // Implementation for editing contact
    si("Edit contact feature coming soon");
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contact?");
    if (isConfirmed) {
      emergencyContacts.removeWhere((c) => c["id"] == contact["id"]);
      setState(() {});
      ss("Contact deleted successfully");
    }
  }

  void _makeCall(String phone) {
    ss("Calling $phone...");
    // Implementation for making phone call
  }

  void _sendEmail(String email) {
    ss("Opening email to $email...");
    // Implementation for sending email
  }

  void _shareLocation() {
    ss("Sharing current location...");
    // Implementation for sharing location
  }

  void _clearForm() {
    name = "";
    relationship = "";
    phone = "";
    email = "";
    address = "";
    specialty = "";
    notes = "";
    isPrimary = false;
    isAvailable24h = false;
  }
}

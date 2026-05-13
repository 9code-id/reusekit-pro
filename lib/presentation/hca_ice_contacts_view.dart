import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaIceContactsView extends StatefulWidget {
  const HcaIceContactsView({super.key});

  @override
  State<HcaIceContactsView> createState() => _HcaIceContactsViewState();
}

class _HcaIceContactsViewState extends State<HcaIceContactsView> {
  List<Map<String, dynamic>> iceContacts = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "relationship": "Daughter",
      "phone": "(555) 123-4567",
      "email": "sarah.johnson@email.com",
      "address": "123 Oak Street, Springfield, IL 62701",
      "isPrimary": true,
      "notes": "Lives nearby, available 24/7",
      "workPhone": "(555) 123-4568",
      "photo": "https://picsum.photos/60/60?random=1&keyword=woman"
    },
    {
      "id": "2",
      "name": "Michael Johnson",
      "relationship": "Son",
      "phone": "(555) 987-6543",
      "email": "mike.johnson@email.com",
      "address": "456 Pine Avenue, Chicago, IL 60601",
      "isPrimary": false,
      "notes": "Works nights, best to call after 6 PM",
      "workPhone": "(555) 987-6544",
      "photo": "https://picsum.photos/60/60?random=2&keyword=man"
    },
    {
      "id": "3",
      "name": "Dr. Emily Chen",
      "relationship": "Primary Physician",
      "phone": "(555) 456-7890",
      "email": "e.chen@citymedical.com",
      "address": "City Medical Center, Main Street",
      "isPrimary": false,
      "notes": "Emergency medical contact",
      "workPhone": "(555) 456-7890",
      "photo": "https://picsum.photos/60/60?random=3&keyword=doctor"
    },
    {
      "id": "4",
      "name": "Robert Wilson",
      "relationship": "Neighbor",
      "phone": "(555) 321-9876",
      "email": "rob.wilson@email.com",
      "address": "124 Oak Street (Next Door)",
      "isPrimary": false,
      "notes": "Has spare key, lives next door",
      "workPhone": null,
      "photo": "https://picsum.photos/60/60?random=4&keyword=senior"
    },
  ];
  
  List<Map<String, dynamic>> relationshipTypes = [
    {"label": "Spouse", "value": "spouse"},
    {"label": "Daughter", "value": "daughter"},
    {"label": "Son", "value": "son"},
    {"label": "Mother", "value": "mother"},
    {"label": "Father", "value": "father"},
    {"label": "Sister", "value": "sister"},
    {"label": "Brother", "value": "brother"},
    {"label": "Friend", "value": "friend"},
    {"label": "Neighbor", "value": "neighbor"},
    {"label": "Primary Physician", "value": "primary_physician"},
    {"label": "Caregiver", "value": "caregiver"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ICE Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              _showEmergencyCallDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddContactDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            _buildPrimaryContact(),
            _buildAllContacts(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor, infoColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.info,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "In Case of Emergency (ICE)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "ICE contacts help emergency responders reach your loved ones quickly. Keep this information updated and accessible.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryContact() {
    Map<String, dynamic>? primaryContact = iceContacts.firstWhere(
      (contact) => contact["isPrimary"] == true,
      orElse: () => {},
    );
    
    if (primaryContact.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(100), width: 2),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Primary Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildContactCard(primaryContact, isPrimary: true),
        ],
      ),
    );
  }

  Widget _buildAllContacts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.contacts,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "All ICE Contacts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${iceContacts.length} contacts",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...iceContacts.map((contact) => _buildContactCard(contact)),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact, {bool isPrimary = false}) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isPrimary ? primaryColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isPrimary ? primaryColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${contact["photo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${contact["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isPrimary ? primaryColor : null,
                          ),
                        ),
                        if (isPrimary) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "PRIMARY",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${contact["relationship"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${contact["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _callContact(contact),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  GestureDetector(
                    onTap: () => _sendMessage(contact),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (contact["email"] != null) ...[
            Row(
              children: [
                Icon(
                  Icons.email,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${contact["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${contact["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          if (contact["workPhone"] != null) ...[
            Row(
              children: [
                Icon(
                  Icons.work,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Work: ${contact["workPhone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
          if (contact["notes"] != null && contact["notes"].isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(radiusSm),
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
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    _showEditContactDialog(contact);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showContactDetailsDialog(contact);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: contact["isPrimary"] ? Icons.star : Icons.star_border,
                color: contact["isPrimary"] ? warningColor : disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  _togglePrimaryContact(contact);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.speed,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionCard(
                "Emergency Call",
                "Call primary contact",
                Icons.emergency,
                dangerColor,
                () => _emergencyCall(),
              ),
              _buildQuickActionCard(
                "Call All",
                "Contact all ICE contacts",
                Icons.people,
                warningColor,
                () => _callAllContacts(),
              ),
              _buildQuickActionCard(
                "Send Location",
                "Share current location",
                Icons.location_on,
                infoColor,
                () => _shareLocation(),
              ),
              _buildQuickActionCard(
                "Export Contacts",
                "Export ICE contact list",
                Icons.download,
                successColor,
                () => _exportContacts(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callContact(Map<String, dynamic> contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Call ${contact["name"]}"),
        content: Text("Would you like to call ${contact["name"]} at ${contact["phone"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Calling ${contact["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(Map<String, dynamic> contact) {
    String message = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message ${contact["name"]}"),
        content: QMemoField(
          label: "Message",
          value: message,
          onChanged: (value) {
            message = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Message sent to ${contact["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _togglePrimaryContact(Map<String, dynamic> contact) {
    setState(() {
      // Clear all primary flags
      for (var c in iceContacts) {
        c["isPrimary"] = false;
      }
      // Set this contact as primary
      contact["isPrimary"] = true;
    });
    ss("${contact["name"]} set as primary contact");
  }

  void _showAddContactDialog() {
    String name = "";
    String relationship = "daughter";
    String phone = "";
    String email = "";
    String address = "";
    String workPhone = "";
    String notes = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add ICE Contact"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Full Name",
                  value: name,
                  onChanged: (value) {
                    name = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Relationship",
                  items: relationshipTypes,
                  value: relationship,
                  onChanged: (value, label) {
                    relationship = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: phone,
                  onChanged: (value) {
                    phone = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Email",
                  value: email,
                  onChanged: (value) {
                    email = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Work Phone",
                  value: workPhone,
                  onChanged: (value) {
                    workPhone = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Address",
                  value: address,
                  onChanged: (value) {
                    address = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: notes,
                  onChanged: (value) {
                    notes = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Contact",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                iceContacts.add({
                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                  "name": name,
                  "relationship": relationship,
                  "phone": phone,
                  "email": email.isEmpty ? null : email,
                  "address": address,
                  "workPhone": workPhone.isEmpty ? null : workPhone,
                  "notes": notes.isEmpty ? null : notes,
                  "isPrimary": false,
                  "photo": "https://picsum.photos/60/60?random=${iceContacts.length + 5}&keyword=person",
                });
              });
              ss("ICE contact added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showEditContactDialog(Map<String, dynamic> contact) {
    String name = contact["name"];
    String relationship = contact["relationship"];
    String phone = contact["phone"];
    String email = contact["email"] ?? "";
    String address = contact["address"];
    String workPhone = contact["workPhone"] ?? "";
    String notes = contact["notes"] ?? "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ICE Contact"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Full Name",
                  value: name,
                  onChanged: (value) {
                    name = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Relationship",
                  items: relationshipTypes,
                  value: relationship,
                  onChanged: (value, label) {
                    relationship = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: phone,
                  onChanged: (value) {
                    phone = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Email",
                  value: email,
                  onChanged: (value) {
                    email = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Work Phone",
                  value: workPhone,
                  onChanged: (value) {
                    workPhone = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Address",
                  value: address,
                  onChanged: (value) {
                    address = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: notes,
                  onChanged: (value) {
                    notes = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Delete",
            color: dangerColor,
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _deleteContact(contact);
            },
          ),
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                contact["name"] = name;
                contact["relationship"] = relationship;
                contact["phone"] = phone;
                contact["email"] = email.isEmpty ? null : email;
                contact["address"] = address;
                contact["workPhone"] = workPhone.isEmpty ? null : workPhone;
                contact["notes"] = notes.isEmpty ? null : notes;
              });
              ss("Contact updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showContactDetailsDialog(Map<String, dynamic> contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${contact["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Relationship: ${contact["relationship"]}"),
            Text("Phone: ${contact["phone"]}"),
            if (contact["email"] != null) Text("Email: ${contact["email"]}"),
            if (contact["workPhone"] != null) Text("Work Phone: ${contact["workPhone"]}"),
            Text("Address: ${contact["address"]}"),
            if (contact["notes"] != null) Text("Notes: ${contact["notes"]}"),
            Text("Primary Contact: ${contact["isPrimary"] ? "Yes" : "No"}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contact?");
    if (isConfirmed) {
      setState(() {
        iceContacts.removeWhere((c) => c["id"] == contact["id"]);
      });
      ss("Contact deleted successfully");
    }
  }

  void _showEmergencyCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: dangerColor),
            SizedBox(width: spSm),
            Text("Emergency Call"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QButton(
              label: "Call 911",
              color: dangerColor,
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Calling 911");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Call Primary Contact",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _emergencyCall();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _emergencyCall() {
    Map<String, dynamic>? primaryContact = iceContacts.firstWhere(
      (contact) => contact["isPrimary"] == true,
      orElse: () => {},
    );
    
    if (primaryContact.isNotEmpty) {
      ss("Emergency call to ${primaryContact["name"]}");
    } else {
      se("No primary contact set");
    }
  }

  void _callAllContacts() {
    ss("Calling all ICE contacts");
  }

  void _shareLocation() {
    ss("Location shared with ICE contacts");
  }

  void _exportContacts() {
    ss("ICE contacts exported successfully");
  }
}

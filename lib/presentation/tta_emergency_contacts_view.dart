import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaEmergencyContactsView extends StatefulWidget {
  const TtaEmergencyContactsView({super.key});

  @override
  State<TtaEmergencyContactsView> createState() => _TtaEmergencyContactsViewState();
}

class _TtaEmergencyContactsViewState extends State<TtaEmergencyContactsView> {
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> emergencyContacts = [
    {
      "id": 1,
      "name": "Police",
      "number": "911",
      "country": "United States",
      "type": "Law Enforcement",
      "description": "Emergency police services",
      "icon": Icons.local_police,
      "color": dangerColor,
      "isGlobal": false,
    },
    {
      "id": 2,
      "name": "Fire Department",
      "number": "911",
      "country": "United States",
      "type": "Fire & Rescue",
      "description": "Fire emergency and rescue services",
      "icon": Icons.local_fire_department,
      "color": warningColor,
      "isGlobal": false,
    },
    {
      "id": 3,
      "name": "Medical Emergency",
      "number": "911",
      "country": "United States",
      "type": "Medical",
      "description": "Ambulance and medical emergency",
      "icon": Icons.local_hospital,
      "color": dangerColor,
      "isGlobal": false,
    },
    {
      "id": 4,
      "name": "US Embassy London",
      "number": "+44 20 7499 9000",
      "country": "United Kingdom",
      "type": "Embassy",
      "description": "US Embassy in London for citizen services",
      "icon": Icons.account_balance,
      "color": primaryColor,
      "isGlobal": true,
    },
    {
      "id": 5,
      "name": "Travel Insurance Hotline",
      "number": "+1 800 555 0123",
      "country": "Global",
      "type": "Insurance",
      "description": "24/7 travel insurance assistance",
      "icon": Icons.security,
      "color": successColor,
      "isGlobal": true,
    },
  ];

  List<Map<String, dynamic>> personalContacts = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "relationship": "Emergency Contact",
      "phone": "+1 555 123 4567",
      "email": "sarah.johnson@email.com",
      "address": "123 Main St, New York, NY",
      "isPrimary": true,
      "notes": "Primary emergency contact - sister",
    },
    {
      "id": 2,
      "name": "Dr. Michael Smith",
      "relationship": "Family Doctor",
      "phone": "+1 555 987 6543",
      "email": "dr.smith@medicalpractice.com",
      "address": "456 Medical Center Dr, Boston, MA",
      "isPrimary": false,
      "notes": "Family physician, knows medical history",
    },
    {
      "id": 3,
      "name": "Robert Johnson",
      "relationship": "Father",
      "phone": "+1 555 246 8135",
      "email": "robert.johnson@email.com",
      "address": "789 Oak Street, Chicago, IL",
      "isPrimary": false,
      "notes": "Secondary emergency contact",
    },
  ];

  List<Map<String, dynamic>> countryEmergencyNumbers = [
    {"country": "United States", "flag": "🇺🇸", "police": "911", "fire": "911", "medical": "911"},
    {"country": "United Kingdom", "flag": "🇬🇧", "police": "999", "fire": "999", "medical": "999"},
    {"country": "Canada", "flag": "🇨🇦", "police": "911", "fire": "911", "medical": "911"},
    {"country": "Australia", "flag": "🇦🇺", "police": "000", "fire": "000", "medical": "000"},
    {"country": "Germany", "flag": "🇩🇪", "police": "110", "fire": "112", "medical": "112"},
    {"country": "France", "flag": "🇫🇷", "police": "17", "fire": "18", "medical": "15"},
    {"country": "Japan", "flag": "🇯🇵", "police": "110", "fire": "119", "medical": "119"},
    {"country": "China", "flag": "🇨🇳", "police": "110", "fire": "119", "medical": "120"},
    {"country": "India", "flag": "🇮🇳", "police": "100", "fire": "101", "medical": "102"},
    {"country": "Thailand", "flag": "🇹🇭", "police": "191", "fire": "199", "medical": "1669"},
    {"country": "Singapore", "flag": "🇸🇬", "police": "999", "fire": "995", "medical": "995"},
    {"country": "South Korea", "flag": "🇰🇷", "police": "112", "fire": "119", "medical": "119"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (currentTab == 0) {
                _showAddPersonalContactDialog();
              } else {
                _showAddEmergencyNumberDialog();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: QTextField(
              label: "Search contacts",
              value: searchQuery,
              hint: "Enter name, number, or country",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Emergency Alert
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emergency,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency? Call Immediately!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "In life-threatening situations, contact local emergency services first",
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Call 911",
                  size: bs.sm,
                  onPressed: () {
                    _makeEmergencyCall("911");
                  },
                ),
              ],
            ),
          ),

          // Tab Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        currentTab = 0;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: currentTab == 0 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Personal Contacts",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        currentTab = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: currentTab == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Emergency Numbers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        currentTab = 2;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: currentTab == 2 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "By Country",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: spMd),

          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildPersonalContactsTab();
      case 1:
        return _buildEmergencyNumbersTab();
      case 2:
        return _buildCountryNumbersTab();
      default:
        return Container();
    }
  }

  Widget _buildPersonalContactsTab() {
    List<Map<String, dynamic>> filteredContacts = personalContacts.where((contact) {
      if (searchQuery.isEmpty) return true;
      return (contact["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (contact["relationship"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (contact["phone"] as String).contains(searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredContacts.map((contact) {
          return _buildPersonalContactCard(contact);
        }).toList(),
      ),
    );
  }

  Widget _buildPersonalContactCard(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: contact["isPrimary"] ? primaryColor : disabledOutlineBorderColor,
        ),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: contact["isPrimary"] ? primaryColor : secondaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
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
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (contact["isPrimary"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "PRIMARY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${contact["relationship"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildContactInfo(Icons.phone, "Phone", "${contact["phone"]}"),
            _buildContactInfo(Icons.email, "Email", "${contact["email"]}"),
            _buildContactInfo(Icons.location_on, "Address", "${contact["address"]}"),
            if (contact["notes"] != null && (contact["notes"] as String).isNotEmpty) ...[
              SizedBox(height: spSm),
              _buildContactInfo(Icons.note, "Notes", "${contact["notes"]}"),
            ],
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Call",
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      _makeCall(contact["phone"]);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Message",
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      _sendMessage(contact["phone"]);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    _showContactOptions(contact);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyNumbersTab() {
    List<Map<String, dynamic>> filteredNumbers = emergencyContacts.where((contact) {
      if (searchQuery.isEmpty) return true;
      return (contact["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (contact["country"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (contact["type"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredNumbers.map((contact) {
          return _buildEmergencyNumberCard(contact);
        }).toList(),
      ),
    );
  }

  Widget _buildEmergencyNumberCard(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Icon(
              contact["icon"],
              color: contact["color"],
              size: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${contact["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${contact["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: contact["color"].withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${contact["type"]}",
                          style: TextStyle(
                            fontSize: 8,
                            color: contact["color"],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${contact["country"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                Text(
                  "${contact["number"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: contact["color"],
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Call",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    _makeEmergencyCall(contact["number"]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryNumbersTab() {
    List<Map<String, dynamic>> filteredCountries = countryEmergencyNumbers.where((country) {
      if (searchQuery.isEmpty) return true;
      return (country["country"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredCountries.map((country) {
          return _buildCountryCard(country);
        }).toList(),
      ),
    );
  }

  Widget _buildCountryCard(Map<String, dynamic> country) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${country["flag"]}",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${country["country"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: _buildEmergencyNumberButton(
                    "Police",
                    "${country["police"]}",
                    Icons.local_police,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildEmergencyNumberButton(
                    "Fire",
                    "${country["fire"]}",
                    Icons.local_fire_department,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildEmergencyNumberButton(
                    "Medical",
                    "${country["medical"]}",
                    Icons.local_hospital,
                    successColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyNumberButton(String label, String number, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _makeEmergencyCall(number);
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makeCall(String number) {
    ss("Calling $number");
  }

  void _makeEmergencyCall(String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Emergency Call"),
        content: Text("Call emergency number $number?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call Now",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Calling emergency number $number");
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(String number) {
    ss("Sending message to $number");
  }

  void _showContactOptions(Map<String, dynamic> contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${contact["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Contact"),
              onTap: () {
                Navigator.pop(context);
                _editContact(contact);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text(contact["isPrimary"] ? "Remove as Primary" : "Set as Primary"),
              onTap: () {
                Navigator.pop(context);
                _togglePrimary(contact);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Contact", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                _deleteContact(contact);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPersonalContactDialog() {
    ss("Add personal contact functionality coming soon");
  }

  void _showAddEmergencyNumberDialog() {
    ss("Add emergency number functionality coming soon");
  }

  void _editContact(Map<String, dynamic> contact) {
    ss("Edit contact functionality coming soon");
  }

  void _togglePrimary(Map<String, dynamic> contact) {
    contact["isPrimary"] = !contact["isPrimary"];
    setState(() {});
    ss(contact["isPrimary"] ? "Set as primary contact" : "Removed as primary contact");
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contact?");
    if (isConfirmed) {
      personalContacts.removeWhere((c) => c["id"] == contact["id"]);
      setState(() {});
      ss("Contact deleted successfully");
    }
  }
}

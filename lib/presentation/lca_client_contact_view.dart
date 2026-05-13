import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientContactView extends StatefulWidget {
  const LcaClientContactView({super.key});

  @override
  State<LcaClientContactView> createState() => _LcaClientContactViewState();
}

class _LcaClientContactViewState extends State<LcaClientContactView> {
  bool loading = false;
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Contacts", "value": "all"},
    {"label": "Active Clients", "value": "active"},
    {"label": "Prospects", "value": "prospects"},
    {"label": "Former Clients", "value": "former"},
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Johnson Enterprises",
      "status": "active",
      "lastContact": "2024-06-18",
      "caseCount": 3,
      "totalBilled": 25000.0,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "notes": "VIP client - Corporate law specialist needed",
      "practiceArea": "Corporate Law",
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "email": "m.chen@techstartup.com",
      "phone": "+1 (555) 987-6543",
      "company": "Tech Startup Inc",
      "status": "prospect",
      "lastContact": "2024-06-17",
      "caseCount": 0,
      "totalBilled": 0.0,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "notes": "Interested in IP protection services",
      "practiceArea": "Intellectual Property",
    },
    {
      "id": "3",
      "name": "Emma Wilson",
      "email": "emma.wilson@consulting.com",
      "phone": "+1 (555) 456-7890",
      "company": "Wilson Consulting",
      "status": "active",
      "lastContact": "2024-06-16",
      "caseCount": 1,
      "totalBilled": 8500.0,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "notes": "Employment law consultation ongoing",
      "practiceArea": "Employment Law",
    },
    {
      "id": "4",
      "name": "David Rodriguez",
      "email": "david.r@familylaw.net",
      "phone": "+1 (555) 321-0987",
      "company": "Self-Employed",
      "status": "former",
      "lastContact": "2024-05-20",
      "caseCount": 2,
      "totalBilled": 12000.0,
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "notes": "Divorce case completed successfully",
      "practiceArea": "Family Law",
    },
    {
      "id": "5",
      "name": "Lisa Martinez",
      "email": "lisa.martinez@realestate.com",
      "phone": "+1 (555) 654-3210",
      "company": "Martinez Realty",
      "status": "active",
      "lastContact": "2024-06-15",
      "caseCount": 4,
      "totalBilled": 18700.0,
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "notes": "Real estate transactions specialist",
      "practiceArea": "Real Estate",
    },
    {
      "id": "6",
      "name": "Robert Taylor",
      "email": "robert.taylor@criminal.law",
      "phone": "+1 (555) 789-0123",
      "company": "Personal",
      "status": "prospect",
      "lastContact": "2024-06-14",
      "caseCount": 0,
      "totalBilled": 0.0,
      "avatar": "https://picsum.photos/60/60?random=6&keyword=man",
      "notes": "Referred by previous client for criminal defense",
      "practiceArea": "Criminal Law",
    },
  ];

  List<Map<String, dynamic>> get filteredContacts {
    List<Map<String, dynamic>> filtered = contacts;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((contact) => contact["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((contact) {
        return contact["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               contact["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               contact["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddContactDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.import_export),
            onPressed: () {
              _showImportExportMenu();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactStats(),
                  _buildSearchAndFilter(),
                  _buildContactsList(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildContactStats() {
    int totalContacts = contacts.length;
    int activeClients = contacts.where((c) => c["status"] == "active").length;
    int prospects = contacts.where((c) => c["status"] == "prospect").length;
    double totalRevenue = contacts.fold(0.0, (sum, c) => sum + (c["totalBilled"] as double));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Contacts", totalContacts.toString(), Icons.people, primaryColor),
        _buildStatCard("Active Clients", activeClients.toString(), Icons.person, successColor),
        _buildStatCard("Prospects", prospects.toString(), Icons.person_outline, warningColor),
        _buildStatCard("Total Revenue", "\$${totalRevenue.currency}", Icons.attach_money, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search contacts...",
                  value: searchQuery,
                  hint: "Search by name, email, or company",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Search is already handled by onChanged
                },
              ),
            ],
          ),
          QDropdownField(
            label: "Filter by Status",
            items: filterOptions,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.contacts, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Contact Directory",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredContacts.length} contacts",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredContacts.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.search_off, color: disabledBoldColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "No contacts found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...filteredContacts.map((contact) => _buildContactItem(contact)).toList(),
        ],
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    Color statusColor = contact["status"] == "active" ? successColor :
                       contact["status"] == "prospect" ? warningColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${contact["avatar"]}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          "${contact["name"].toString().split(' ').map((n) => n[0]).take(2).join()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      );
                    },
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${contact["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${contact["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${contact["practiceArea"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if ((contact["totalBilled"] as double) > 0)
                    Text(
                      "\$${((contact["totalBilled"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  Text(
                    "${(contact["caseCount"] as int)} cases",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Last: ${contact["lastContact"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.email, color: disabledBoldColor, size: 14),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${contact["email"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.phone, color: disabledBoldColor, size: 14),
              SizedBox(width: 4),
              Text(
                "${contact["phone"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (contact["notes"].toString().isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${contact["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: infoColor,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  icon: Icons.person,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening profile for ${contact["name"]}");
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  si("Calling ${contact["name"]}");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.email,
                size: bs.sm,
                onPressed: () {
                  si("Emailing ${contact["name"]}");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showContactMenu(contact);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog() {
    String name = "";
    String email = "";
    String phone = "";
    String company = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Full Name",
              value: name,
              validator: Validator.required,
              onChanged: (value) => name = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Email",
              value: email,
              validator: Validator.email,
              onChanged: (value) => email = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Phone",
              value: phone,
              onChanged: (value) => phone = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Company",
              value: company,
              onChanged: (value) => company = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && email.isNotEmpty) {
                Navigator.pop(context);
                ss("Contact added successfully");
                // Add contact logic here
              } else {
                se("Please fill in required fields");
              }
            },
            child: Text("Add Contact"),
          ),
        ],
      ),
    );
  }

  void _showContactMenu(Map<String, dynamic> contact) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 200, 0, 0),
      items: [
        PopupMenuItem(
          value: "edit",
          child: Text("Edit Contact"),
        ),
        PopupMenuItem(
          value: "case",
          child: Text("Create Case"),
        ),
        PopupMenuItem(
          value: "email",
          child: Text("Send Email"),
        ),
        PopupMenuItem(
          value: "meeting",
          child: Text("Schedule Meeting"),
        ),
        PopupMenuItem(
          value: "note",
          child: Text("Add Note"),
        ),
        PopupMenuItem(
          value: "delete",
          child: Text("Delete Contact"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case "delete":
            _confirmDeleteContact(contact);
            break;
          default:
            si("${value} for ${contact["name"]}");
        }
      }
    });
  }

  void _confirmDeleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${contact["name"]}?");
    if (isConfirmed) {
      setState(() {
        contacts.removeWhere((c) => c["id"] == contact["id"]);
      });
      ss("Contact deleted successfully");
    }
  }

  void _showImportExportMenu() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          value: "import_csv",
          child: Text("Import from CSV"),
        ),
        PopupMenuItem(
          value: "export_csv",
          child: Text("Export to CSV"),
        ),
        PopupMenuItem(
          value: "import_vcard",
          child: Text("Import from vCard"),
        ),
        PopupMenuItem(
          value: "sync_google",
          child: Text("Sync with Google"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        si("Selected: $value");
      }
    });
  }
}

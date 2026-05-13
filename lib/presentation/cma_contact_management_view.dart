import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactManagementView extends StatefulWidget {
  const CmaContactManagementView({super.key});

  @override
  State<CmaContactManagementView> createState() => _CmaContactManagementViewState();
}

class _CmaContactManagementViewState extends State<CmaContactManagementView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedSort = "Name A-Z";
  List<String> selectedContacts = [];
  bool isSelectionMode = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Contacts", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "VIP", "value": "VIP"},
    {"label": "Hot Leads", "value": "Hot Leads"},
    {"label": "Cold Leads", "value": "Cold Leads"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "Name A-Z"},
    {"label": "Name Z-A", "value": "Name Z-A"},
    {"label": "Recently Added", "value": "Recently Added"},
    {"label": "Last Contact", "value": "Last Contact"},
    {"label": "Lead Score", "value": "Lead Score"},
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "id": "C001",
      "firstName": "John",
      "lastName": "Doe",
      "email": "john.doe@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corporation",
      "position": "Software Engineer",
      "status": "Active",
      "leadScore": 85,
      "tags": ["VIP", "Premium"],
      "lastContact": "2024-12-18",
      "source": "Website"
    },
    {
      "id": "C002",
      "firstName": "Jane",
      "lastName": "Smith",
      "email": "jane.smith@tech.com",
      "phone": "+1 (555) 234-5678",
      "company": "Tech Solutions",
      "position": "Product Manager",
      "status": "Active",
      "leadScore": 92,
      "tags": ["Hot Lead", "Decision Maker"],
      "lastContact": "2024-12-17",
      "source": "Referral"
    },
    {
      "id": "C003",
      "firstName": "Mike",
      "lastName": "Johnson",
      "email": "mike.j@startup.io",
      "phone": "+1 (555) 345-6789",
      "company": "StartupIO",
      "position": "CTO",
      "status": "Active",
      "leadScore": 78,
      "tags": ["Developer", "Influencer"],
      "lastContact": "2024-12-16",
      "source": "Social Media"
    },
    {
      "id": "C004",
      "firstName": "Sarah",
      "lastName": "Wilson",
      "email": "sarah.w@enterprise.com",
      "phone": "+1 (555) 456-7890",
      "company": "Enterprise Corp",
      "position": "VP Sales",
      "status": "Inactive",
      "leadScore": 65,
      "tags": ["Cold Lead", "Manager"],
      "lastContact": "2024-12-10",
      "source": "Trade Show"
    },
    {
      "id": "C005",
      "firstName": "David",
      "lastName": "Brown",
      "email": "david.brown@agency.com",
      "phone": "+1 (555) 567-8901",
      "company": "Creative Agency",
      "position": "Creative Director",
      "status": "Active",
      "leadScore": 88,
      "tags": ["VIP", "Hot Lead"],
      "lastContact": "2024-12-15",
      "source": "Email Campaign"
    }
  ];

  List<Map<String, dynamic>> get filteredContacts {
    List<Map<String, dynamic>> filtered = contacts;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((contact) {
        String fullName = "${contact["firstName"]} ${contact["lastName"]}".toLowerCase();
        String email = "${contact["email"]}".toLowerCase();
        String company = "${contact["company"]}".toLowerCase();
        String query = searchQuery.toLowerCase();
        
        return fullName.contains(query) || 
               email.contains(query) || 
               company.contains(query);
      }).toList();
    }

    // Apply status filter
    if (selectedFilter != "All") {
      if (selectedFilter == "VIP" || selectedFilter == "Hot Leads" || selectedFilter == "Cold Leads") {
        filtered = filtered.where((contact) {
          List<String> tags = List<String>.from(contact["tags"]);
          return tags.contains(selectedFilter == "Hot Leads" ? "Hot Lead" : 
                              selectedFilter == "Cold Leads" ? "Cold Lead" : selectedFilter);
        }).toList();
      } else {
        filtered = filtered.where((contact) => contact["status"] == selectedFilter).toList();
      }
    }

    // Apply sorting
    switch (selectedSort) {
      case "Name A-Z":
        filtered.sort((a, b) => "${a["firstName"]} ${a["lastName"]}".compareTo("${b["firstName"]} ${b["lastName"]}"));
        break;
      case "Name Z-A":
        filtered.sort((a, b) => "${b["firstName"]} ${b["lastName"]}".compareTo("${a["firstName"]} ${a["lastName"]}"));
        break;
      case "Recently Added":
        filtered.sort((a, b) => b["id"].compareTo(a["id"]));
        break;
      case "Last Contact":
        filtered.sort((a, b) => DateTime.parse(b["lastContact"]).compareTo(DateTime.parse(a["lastContact"])));
        break;
      case "Lead Score":
        filtered.sort((a, b) => (b["leadScore"] as int).compareTo(a["leadScore"] as int));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedContacts.length} Selected" : "Contact Management"),
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteSelectedContacts();
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _showBulkActions();
              },
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                _showFilterDialog();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //navigateTo('CmaAddContactView')
              },
            ),
          ],
        ],
        leading: isSelectionMode ? IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            selectedContacts.clear();
            isSelectionMode = false;
            setState(() {});
          },
        ) : null,
      ),
      body: Column(
        children: [
          _buildSearchAndStats(),
          _buildQuickFilters(),
          Expanded(
            child: _buildContactList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('CmaAddContactView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search contacts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Search action
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard("Total", "${contacts.length}", primaryColor),
              _buildStatCard("Active", "${contacts.where((c) => c["status"] == "Active").length}", successColor),
              _buildStatCard("Hot Leads", "${contacts.where((c) => (c["tags"] as List).contains("Hot Lead")).length}", warningColor),
              _buildStatCard("VIP", "${contacts.where((c) => (c["tags"] as List).contains("VIP")).length}", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: [
          Expanded(
            child: QHorizontalScroll(
              children: filterOptions.map((filter) {
                bool isSelected = selectedFilter == filter["value"];
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${filter["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: primaryColor),
            onSelected: (value) {
              selectedSort = value;
              setState(() {});
            },
            itemBuilder: (context) {
              return sortOptions.map((option) {
                return PopupMenuItem<String>(
                  value: option["value"],
                  child: Text("${option["label"]}"),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    if (filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No contacts found",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        bool isSelected = selectedContacts.contains(contact["id"]);
        
        return GestureDetector(
          onTap: () {
            if (isSelectionMode) {
              if (isSelected) {
                selectedContacts.remove(contact["id"]);
                if (selectedContacts.isEmpty) {
                  isSelectionMode = false;
                }
              } else {
                selectedContacts.add(contact["id"]);
              }
              setState(() {});
            } else {
              //navigateTo('CmaContactDetailView')
            }
          },
          onLongPress: () {
            if (!isSelectionMode) {
              isSelectionMode = true;
              selectedContacts.add(contact["id"]);
              setState(() {});
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
            ),
            child: Row(
              children: [
                if (isSelectionMode)
                  Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? primaryColor : disabledColor,
                    ),
                  ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: primaryColor.withAlpha(20),
                  child: Text(
                    "${contact["firstName"][0]}${contact["lastName"][0]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${contact["firstName"]} ${contact["lastName"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${contact["position"]} at ${contact["company"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.email, size: 12, color: disabledColor),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${contact["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: contact["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${contact["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: contact["status"] == "Active" ? successColor : warningColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Score: ${contact["leadScore"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${DateTime.parse(contact["lastContact"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isSelectionMode)
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: disabledBoldColor),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "view",
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 16),
                            SizedBox(width: spXs),
                            Text("View Details"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "edit",
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: spXs),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "duplicate",
                        child: Row(
                          children: [
                            Icon(Icons.copy, size: 16),
                            SizedBox(width: spXs),
                            Text("Duplicate"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: dangerColor),
                            SizedBox(width: spXs),
                            Text("Delete", style: TextStyle(color: dangerColor)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      _handleContactAction(value.toString(), contact);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter & Sort Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              Text("Filter by Status"),
              ...filterOptions.map((filter) {
                return RadioListTile<String>(
                  title: Text("${filter["label"]}"),
                  value: filter["value"],
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    selectedFilter = value!;
                    setState(() {});
                    back();
                  },
                );
              }).toList(),
              Divider(),
              Text("Sort by"),
              ...sortOptions.map((sort) {
                return RadioListTile<String>(
                  title: Text("${sort["label"]}"),
                  value: sort["value"],
                  groupValue: selectedSort,
                  onChanged: (value) {
                    selectedSort = value!;
                    setState(() {});
                    back();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ListTile(
                leading: Icon(Icons.email, color: primaryColor),
                title: Text("Send Email"),
                onTap: () {
                  back();
                  _bulkEmail();
                },
              ),
              ListTile(
                leading: Icon(Icons.label, color: primaryColor),
                title: Text("Add Tags"),
                onTap: () {
                  back();
                  _bulkAddTags();
                },
              ),
              ListTile(
                leading: Icon(Icons.file_download, color: primaryColor),
                title: Text("Export Selected"),
                onTap: () {
                  back();
                  _bulkExport();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Selected"),
                onTap: () {
                  back();
                  _deleteSelectedContacts();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleContactAction(String action, Map<String, dynamic> contact) {
    switch (action) {
      case "view":
        //navigateTo('CmaContactDetailView')
        break;
      case "edit":
        //navigateTo('CmaAddContactView')
        break;
      case "duplicate":
        si("Contact duplicated successfully");
        break;
      case "delete":
        _deleteContact(contact);
        break;
    }
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${contact["firstName"]} ${contact["lastName"]}?");
    if (isConfirmed) {
      contacts.removeWhere((c) => c["id"] == contact["id"]);
      setState(() {});
      ss("Contact deleted successfully");
    }
  }

  void _deleteSelectedContacts() async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${selectedContacts.length} selected contacts?");
    if (isConfirmed) {
      contacts.removeWhere((c) => selectedContacts.contains(c["id"]));
      selectedContacts.clear();
      isSelectionMode = false;
      setState(() {});
      ss("Selected contacts deleted successfully");
    }
  }

  void _bulkEmail() {
    si("Email composer opened for ${selectedContacts.length} contacts");
  }

  void _bulkAddTags() {
    si("Tag editor opened for ${selectedContacts.length} contacts");
  }

  void _bulkExport() {
    si("Exporting ${selectedContacts.length} selected contacts");
  }
}

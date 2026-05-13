import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactListView extends StatefulWidget {
  const CmaContactListView({super.key});

  @override
  State<CmaContactListView> createState() => _CmaContactListViewState();
}

class _CmaContactListViewState extends State<CmaContactListView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedImportance = "All";
  String selectedStatus = "All";
  bool isGridView = false;
  
  List<Map<String, dynamic>> contacts = [
    {
      "id": "1",
      "firstName": "Sarah",
      "lastName": "Johnson",
      "fullName": "Sarah Johnson",
      "jobTitle": "Marketing Director",
      "company": "TechCorp Solutions",
      "email": "sarah.johnson@techcorp.com",
      "phone": "+1 (555) 123-4567",
      "mobile": "+1 (555) 987-6543",
      "address": "123 Business Ave, New York, NY 10001",
      "relationship": "Primary",
      "contactType": "Business",
      "importance": "High",
      "status": "Active",
      "preferredContact": "Email",
      "lastContact": "2024-01-15",
      "nextFollowup": "2024-01-22",
      "notes": "Key decision maker for marketing campaigns",
      "tags": ["VIP", "Decision Maker", "Marketing"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/sarahjohnson",
        "twitter": "@sarah_johnson_marketing"
      },
      "interactions": 15,
      "deals": 3,
      "revenue": 125000.0,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman"
    },
    {
      "id": "2",
      "firstName": "Michael",
      "lastName": "Chen",
      "fullName": "Michael Chen",
      "jobTitle": "CTO",
      "company": "Innovation Labs",
      "email": "m.chen@innovationlabs.io",
      "phone": "+1 (555) 234-5678",
      "mobile": "+1 (555) 876-5432",
      "address": "456 Tech Street, San Francisco, CA 94105",
      "relationship": "Decision Maker",
      "contactType": "Business",
      "importance": "High",
      "status": "Active",
      "preferredContact": "Phone",
      "lastContact": "2024-01-18",
      "nextFollowup": "2024-01-25",
      "notes": "Technical authority, prefers detailed specifications",
      "tags": ["Technical", "C-Level", "Innovation"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/michaelchen-cto",
        "twitter": "@mchen_tech"
      },
      "interactions": 22,
      "deals": 5,
      "revenue": 340000.0,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man"
    },
    {
      "id": "3",
      "firstName": "Emily",
      "lastName": "Rodriguez",
      "fullName": "Emily Rodriguez",
      "jobTitle": "Project Manager",
      "company": "BuildRight Construction",
      "email": "emily.r@buildright.com",
      "phone": "+1 (555) 345-6789",
      "mobile": "+1 (555) 765-4321",
      "address": "789 Construction Blvd, Austin, TX 78701",
      "relationship": "Secondary",
      "contactType": "Business",
      "importance": "Medium",
      "status": "Active",
      "preferredContact": "Mobile",
      "lastContact": "2024-01-12",
      "nextFollowup": "2024-01-30",
      "notes": "Manages multiple construction projects, very detail-oriented",
      "tags": ["Project Management", "Construction", "Reliable"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/emilyrodriguez-pm"
      },
      "interactions": 8,
      "deals": 2,
      "revenue": 85000.0,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman"
    },
    {
      "id": "4",
      "firstName": "David",
      "lastName": "Kim",
      "fullName": "David Kim",
      "jobTitle": "Finance Manager",
      "company": "Global Finance Group",
      "email": "david.kim@globalfinance.com",
      "phone": "+1 (555) 456-7890",
      "mobile": "+1 (555) 654-3210",
      "address": "321 Finance Tower, Chicago, IL 60601",
      "relationship": "Influencer",
      "contactType": "Business",
      "importance": "High",
      "status": "Inactive",
      "preferredContact": "Email",
      "lastContact": "2023-12-08",
      "nextFollowup": "2024-02-01",
      "notes": "Budget approval authority, quarterly review meetings",
      "tags": ["Finance", "Budget Authority", "Quarterly"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/davidkim-finance"
      },
      "interactions": 12,
      "deals": 1,
      "revenue": 200000.0,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man"
    },
    {
      "id": "5",
      "firstName": "Lisa",
      "lastName": "Thompson",
      "fullName": "Lisa Thompson",
      "jobTitle": "Operations Director",
      "company": "Logistics Pro",
      "email": "lisa.thompson@logisticspro.com",
      "phone": "+1 (555) 567-8901",
      "mobile": "+1 (555) 543-2109",
      "address": "654 Logistics Way, Denver, CO 80202",
      "relationship": "Primary",
      "contactType": "Business",
      "importance": "Medium",
      "status": "Active",
      "preferredContact": "Phone",
      "lastContact": "2024-01-20",
      "nextFollowup": "2024-01-27",
      "notes": "Focuses on operational efficiency and cost reduction",
      "tags": ["Operations", "Efficiency", "Cost Reduction"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/lisathompson-ops"
      },
      "interactions": 18,
      "deals": 4,
      "revenue": 180000.0,
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman"
    },
    {
      "id": "6",
      "firstName": "Robert",
      "lastName": "Wilson",
      "fullName": "Robert Wilson",
      "jobTitle": "Sales Director",
      "company": "Revenue Accelerators",
      "email": "robert.wilson@revenueacc.com",
      "phone": "+1 (555) 678-9012",
      "mobile": "+1 (555) 432-1098",
      "address": "987 Sales Plaza, Miami, FL 33101",
      "relationship": "Decision Maker",
      "contactType": "Business",
      "importance": "High",
      "status": "Active",
      "preferredContact": "Mobile",
      "lastContact": "2024-01-19",
      "nextFollowup": "2024-01-24",
      "notes": "Results-driven, interested in ROI and performance metrics",
      "tags": ["Sales", "ROI Focused", "Performance"],
      "socialMedia": {
        "linkedin": "linkedin.com/in/robertwilson-sales",
        "twitter": "@rwilson_sales"
      },
      "interactions": 25,
      "deals": 6,
      "revenue": 450000.0,
      "avatar": "https://picsum.photos/100/100?random=6&keyword=man"
    },
  ];
  
  List<Map<String, dynamic>> get filteredContacts {
    var filtered = contacts.where((contact) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${contact["fullName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contact["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contact["jobTitle"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contact["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" || 
          "${contact["relationship"]}" == selectedFilter;
      
      bool matchesImportance = selectedImportance == "All" || 
          "${contact["importance"]}" == selectedImportance;
      
      bool matchesStatus = selectedStatus == "All" || 
          "${contact["status"]}" == selectedStatus;
      
      return matchesSearch && matchesFilter && matchesImportance && matchesStatus;
    }).toList();
    
    // Sort by last contact date (most recent first)
    filtered.sort((a, b) => "${b["lastContact"]}".compareTo("${a["lastContact"]}"));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Directory"),
        actions: [
          QButton(
            icon: isGridView ? Icons.view_list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add contact
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatsRow(),
          Expanded(
            child: filteredContacts.isEmpty
                ? _buildEmptyState()
                : isGridView
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
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
                    ],
                  ),
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: _showFilterDialog,
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: spSm,
              children: [
                _buildFilterChip("All", selectedFilter),
                _buildFilterChip("Primary", selectedFilter),
                _buildFilterChip("Decision Maker", selectedFilter),
                _buildFilterChip("Secondary", selectedFilter),
                _buildFilterChip("Influencer", selectedFilter),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String currentValue) {
    bool isSelected = currentValue == label;
    return GestureDetector(
      onTap: () {
        selectedFilter = label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    int totalContacts = contacts.length;
    int activeContacts = contacts.where((c) => c["status"] == "Active").length;
    int highImportance = contacts.where((c) => c["importance"] == "High").length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        spacing: spMd,
        children: [
          Expanded(
            child: _buildStatCard("Total", totalContacts, primaryColor, Icons.people),
          ),
          Expanded(
            child: _buildStatCard("Active", activeContacts, successColor, Icons.check_circle),
          ),
          Expanded(
            child: _buildStatCard("High Priority", highImportance, warningColor, Icons.star),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return _buildContactListItem(contact);
      },
    );
  }

  Widget _buildContactListItem(Map<String, dynamic> contact) {
    Color statusColor = contact["status"] == "Active" ? successColor : disabledBoldColor;
    Color importanceColor = contact["importance"] == "High" 
        ? dangerColor 
        : contact["importance"] == "Medium" 
            ? warningColor 
            : infoColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(spSm),
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage("${contact["avatar"]}"),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${contact["fullName"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: importanceColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${contact["importance"]}",
                style: TextStyle(
                  color: importanceColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Text(
              "${contact["jobTitle"]} at ${contact["company"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Icon(Icons.email, size: 12, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${contact["email"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone, size: 12, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${contact["phone"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "${contact["status"]} • Last: ${DateTime.parse(contact["lastContact"]).dMMMy}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 11,
                  ),
                ),
                Spacer(),
                Text(
                  "${contact["interactions"]} interactions",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert, color: disabledBoldColor),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row(
                spacing: spSm,
                children: [
                  Icon(Icons.visibility, size: 16),
                  Text("View Details"),
                ],
              ),
              onTap: () => _viewContactDetails(contact),
            ),
            PopupMenuItem(
              child: Row(
                spacing: spSm,
                children: [
                  Icon(Icons.edit, size: 16),
                  Text("Edit Contact"),
                ],
              ),
              onTap: () => _editContact(contact),
            ),
            PopupMenuItem(
              child: Row(
                spacing: spSm,
                children: [
                  Icon(Icons.email, size: 16),
                  Text("Send Email"),
                ],
              ),
              onTap: () => _sendEmail(contact),
            ),
            PopupMenuItem(
              child: Row(
                spacing: spSm,
                children: [
                  Icon(Icons.phone, size: 16),
                  Text("Make Call"),
                ],
              ),
              onTap: () => _makeCall(contact),
            ),
            PopupMenuItem(
              child: Row(
                spacing: spSm,
                children: [
                  Icon(Icons.delete, size: 16, color: dangerColor),
                  Text("Delete", style: TextStyle(color: dangerColor)),
                ],
              ),
              onTap: () => _deleteContact(contact),
            ),
          ],
        ),
        onTap: () => _viewContactDetails(contact),
      ),
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredContacts.map((contact) {
        return _buildContactGridItem(contact);
      }).toList(),
    );
  }

  Widget _buildContactGridItem(Map<String, dynamic> contact) {
    Color statusColor = contact["status"] == "Active" ? successColor : disabledBoldColor;
    Color importanceColor = contact["importance"] == "High" 
        ? dangerColor 
        : contact["importance"] == "Medium" 
            ? warningColor 
            : infoColor;
    
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${contact["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${contact["fullName"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${contact["jobTitle"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: importanceColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${contact["importance"]}",
                  style: TextStyle(
                    color: importanceColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${contact["company"]}",
            style: TextStyle(
              color: primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(Icons.email, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${contact["email"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${contact["status"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 11,
                ),
              ),
              Spacer(),
              Text(
                "${contact["interactions"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            spacing: spXs,
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _viewContactDetails(contact),
                ),
              ),
              Expanded(
                child: QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editContact(contact),
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showContactActions(contact),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spMd,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: disabledBoldColor,
          ),
          Text(
            "No contacts found",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            searchQuery.isNotEmpty
                ? "Try adjusting your search criteria"
                : "Add your first contact to get started",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          QButton(
            label: "Add Contact",
            icon: Icons.person_add,
            onPressed: () {
              // Navigate to add contact
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Contacts"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Importance Level",
              items: [
                {"label": "All", "value": "All"},
                {"label": "High", "value": "High"},
                {"label": "Medium", "value": "Medium"},
                {"label": "Low", "value": "Low"},
              ],
              value: selectedImportance,
              onChanged: (value, label) {
                selectedImportance = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Status",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Active", "value": "Active"},
                {"label": "Inactive", "value": "Inactive"},
              ],
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _viewContactDetails(Map<String, dynamic> contact) {
    // Navigate to contact details
    si("Viewing ${contact["fullName"]} details");
  }

  void _editContact(Map<String, dynamic> contact) {
    // Navigate to edit contact
    si("Editing ${contact["fullName"]}");
  }

  void _sendEmail(Map<String, dynamic> contact) {
    ss("Email sent to ${contact["email"]}");
  }

  void _makeCall(Map<String, dynamic> contact) {
    ss("Calling ${contact["phone"]}");
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${contact["fullName"]}?");
    if (isConfirmed) {
      contacts.removeWhere((c) => c["id"] == contact["id"]);
      setState(() {});
      ss("Contact deleted successfully");
    }
  }

  void _showContactActions(Map<String, dynamic> contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${contact["fullName"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "View",
                    icon: Icons.visibility,
                    onPressed: () {
                      Navigator.pop(context);
                      _viewContactDetails(contact);
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Edit",
                    icon: Icons.edit,
                    onPressed: () {
                      Navigator.pop(context);
                      _editContact(contact);
                    },
                  ),
                ),
              ],
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Email",
                    icon: Icons.email,
                    onPressed: () {
                      Navigator.pop(context);
                      _sendEmail(contact);
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Call",
                    icon: Icons.phone,
                    onPressed: () {
                      Navigator.pop(context);
                      _makeCall(contact);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

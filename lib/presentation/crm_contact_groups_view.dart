import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmContactGroupsView extends StatefulWidget {
  const CrmContactGroupsView({super.key});

  @override
  State<CrmContactGroupsView> createState() => _CrmContactGroupsViewState();
}

class _CrmContactGroupsViewState extends State<CrmContactGroupsView> {
  String searchQuery = "";
  String selectedGroup = "all";
  bool loading = false;

  List<Map<String, dynamic>> groups = [
    {
      "id": "1",
      "name": "VIP Customers",
      "description": "High-value customers with premium status",
      "members": 45,
      "color": primaryColor,
      "created_at": "2024-01-15",
      "status": "active",
      "last_activity": "2024-06-18"
    },
    {
      "id": "2", 
      "name": "New Leads",
      "description": "Recently acquired leads from marketing campaigns",
      "members": 128,
      "color": infoColor,
      "created_at": "2024-02-20",
      "status": "active",
      "last_activity": "2024-06-19"
    },
    {
      "id": "3",
      "name": "Cold Prospects",
      "description": "Contacts that haven't engaged recently",
      "members": 89,
      "color": warningColor,
      "created_at": "2024-01-10",
      "status": "inactive",
      "last_activity": "2024-05-15"
    },
    {
      "id": "4",
      "name": "Enterprise Clients",
      "description": "Large corporate customers and partners",
      "members": 23,
      "color": successColor,
      "created_at": "2024-03-05",
      "status": "active",
      "last_activity": "2024-06-18"
    },
    {
      "id": "5",
      "name": "Newsletter Subscribers",
      "description": "Contacts subscribed to marketing newsletters",
      "members": 567,
      "color": disabledBoldColor,
      "created_at": "2024-01-01",
      "status": "active",
      "last_activity": "2024-06-19"
    },
    {
      "id": "6",
      "name": "Lost Customers",
      "description": "Previously active customers who churned",
      "members": 34,
      "color": dangerColor,
      "created_at": "2024-02-10",
      "status": "archived",
      "last_activity": "2024-04-20"
    }
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return groups.where((group) {
      final matchesSearch = "${group["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           "${group["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = selectedGroup == "all" || "${group["status"]}" == selectedGroup;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateGroupDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search groups...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Groups", "${groups.length}", primaryColor, Icons.group),
                _buildStatCard("Active Groups", "${groups.where((g) => g["status"] == "active").length}", successColor, Icons.check_circle),
                _buildStatCard("Total Contacts", "${groups.fold(0, (sum, g) => sum + (g["members"] as int))}", infoColor, Icons.people),
                _buildStatCard("Avg. per Group", "${(groups.fold(0, (sum, g) => sum + (g["members"] as int)) / groups.length).round()}", warningColor, Icons.trending_up),
              ],
            ),

            // Groups List
            if (loading)
              Center(child: CircularProgressIndicator())
            else
              ...filteredGroups.map((group) => _buildGroupCard(group)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateGroupDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
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
            color: group["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${group["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${group["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${group["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${group["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${group["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${group["members"]} members",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Last active ${_formatDate("${group["last_activity"]}")}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Contacts",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CrmGroupContactsView');
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showEditGroupDialog(group);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showGroupOptions(group);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return warningColor;
      case "archived":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;
      
      if (difference == 0) return "today";
      if (difference == 1) return "yesterday";
      if (difference < 7) return "${difference}d ago";
      if (difference < 30) return "${(difference / 7).round()}w ago";
      return "${(difference / 30).round()}mo ago";
    } catch (e) {
      return dateStr;
    }
  }

  void _showCreateGroupDialog() {
    String groupName = "";
    String groupDescription = "";
    Color selectedColor = primaryColor;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Group"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Group Name",
              value: groupName,
              onChanged: (value) => groupName = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: groupDescription,
              onChanged: (value) => groupDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (groupName.isNotEmpty) {
                Navigator.pop(context);
                _createGroup(groupName, groupDescription, selectedColor);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditGroupDialog(Map<String, dynamic> group) {
    String groupName = "${group["name"]}";
    String groupDescription = "${group["description"]}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Group"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Group Name",
              value: groupName,
              onChanged: (value) => groupName = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: groupDescription,
              onChanged: (value) => groupDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _updateGroup(group, groupName, groupDescription);
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
        title: Text("Filter Groups"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("All Groups"),
              value: "all",
              groupValue: selectedGroup,
              onChanged: (value) {
                selectedGroup = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Active"),
              value: "active",
              groupValue: selectedGroup,
              onChanged: (value) {
                selectedGroup = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Inactive"),
              value: "inactive",
              groupValue: selectedGroup,
              onChanged: (value) {
                selectedGroup = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupOptions(Map<String, dynamic> group) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Manage Contacts"),
              onTap: () {
                Navigator.pop(context);
                //navigateTo('CrmGroupContactsView');
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Send Email Campaign"),
              onTap: () {
                Navigator.pop(context);
                //navigateTo('CrmEmailCampaignView');
              },
            ),
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text("Duplicate Group"),
              onTap: () {
                Navigator.pop(context);
                _duplicateGroup(group);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Group", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this group?");
                if (isConfirmed) {
                  _deleteGroup(group);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createGroup(String name, String description, Color color) {
    final newGroup = {
      "id": "${groups.length + 1}",
      "name": name,
      "description": description,
      "members": 0,
      "color": color,
      "created_at": DateTime.now().toString(),
      "status": "active",
      "last_activity": DateTime.now().toString()
    };
    
    groups.insert(0, newGroup);
    setState(() {});
    ss("Group created successfully");
  }

  void _updateGroup(Map<String, dynamic> group, String name, String description) {
    group["name"] = name;
    group["description"] = description;
    setState(() {});
    ss("Group updated successfully");
  }

  void _duplicateGroup(Map<String, dynamic> group) {
    final duplicatedGroup = Map<String, dynamic>.from(group);
    duplicatedGroup["id"] = "${groups.length + 1}";
    duplicatedGroup["name"] = "${group["name"]} (Copy)";
    duplicatedGroup["members"] = 0;
    duplicatedGroup["created_at"] = DateTime.now().toString();
    
    groups.insert(0, duplicatedGroup);
    setState(() {});
    ss("Group duplicated successfully");
  }

  void _deleteGroup(Map<String, dynamic> group) {
    groups.removeWhere((g) => g["id"] == group["id"]);
    setState(() {});
    ss("Group deleted successfully");
  }
}

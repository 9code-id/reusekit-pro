import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmUserPermissionsView extends StatefulWidget {
  const CrmUserPermissionsView({super.key});

  @override
  State<CrmUserPermissionsView> createState() => _CrmUserPermissionsViewState();
}

class _CrmUserPermissionsViewState extends State<CrmUserPermissionsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedRole = "";
  String selectedDepartment = "";

  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "John Smith",
      "email": "john.smith@company.com",
      "role": "Admin",
      "department": "IT",
      "status": "Active",
      "lastLogin": "2024-01-15 14:30",
      "permissions": ["all"],
      "avatar": "https://picsum.photos/40/40?random=1&person"
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "role": "Sales Manager",
      "department": "Sales",
      "status": "Active",
      "lastLogin": "2024-01-15 12:15",
      "permissions": ["leads", "contacts", "deals", "reports"],
      "avatar": "https://picsum.photos/40/40?random=2&person"
    },
    {
      "id": 3,
      "name": "Mike Davis",
      "email": "mike.davis@company.com",
      "role": "Sales Rep",
      "department": "Sales",
      "status": "Active",
      "lastLogin": "2024-01-15 10:45",
      "permissions": ["leads", "contacts", "deals"],
      "avatar": "https://picsum.photos/40/40?random=3&person"
    },
    {
      "id": 4,
      "name": "Emily Brown",
      "email": "emily.brown@company.com",
      "role": "Marketing Manager",
      "department": "Marketing",
      "status": "Inactive",
      "lastLogin": "2024-01-10 16:20",
      "permissions": ["campaigns", "analytics", "contacts"],
      "avatar": "https://picsum.photos/40/40?random=4&person"
    },
  ];

  final List<Map<String, dynamic>> roles = [
    {
      "id": 1,
      "name": "Admin",
      "description": "Full system access and user management",
      "userCount": 2,
      "permissions": ["all"],
      "color": primaryColor,
    },
    {
      "id": 2,
      "name": "Sales Manager",
      "description": "Manage sales team and view all sales data",
      "userCount": 3,
      "permissions": ["leads", "contacts", "deals", "reports", "team_management"],
      "color": successColor,
    },
    {
      "id": 3,
      "name": "Sales Rep",
      "description": "Access to leads, contacts, and own deals",
      "userCount": 8,
      "permissions": ["leads", "contacts", "deals"],
      "color": infoColor,
    },
    {
      "id": 4,
      "name": "Marketing Manager",
      "description": "Manage marketing campaigns and analytics",
      "userCount": 2,
      "permissions": ["campaigns", "analytics", "contacts", "reports"],
      "color": warningColor,
    },
    {
      "id": 5,
      "name": "Support Agent",
      "description": "Handle customer support tickets",
      "userCount": 5,
      "permissions": ["tickets", "contacts", "knowledge_base"],
      "color": disabledBoldColor,
    },
  ];

  final List<Map<String, dynamic>> permissions = [
    {"name": "leads", "label": "Leads Management", "category": "Sales"},
    {"name": "contacts", "label": "Contacts Management", "category": "Sales"},
    {"name": "deals", "label": "Deals Management", "category": "Sales"},
    {"name": "reports", "label": "Sales Reports", "category": "Sales"},
    {"name": "team_management", "label": "Team Management", "category": "Sales"},
    {"name": "campaigns", "label": "Marketing Campaigns", "category": "Marketing"},
    {"name": "analytics", "label": "Analytics & Insights", "category": "Marketing"},
    {"name": "tickets", "label": "Support Tickets", "category": "Support"},
    {"name": "knowledge_base", "label": "Knowledge Base", "category": "Support"},
    {"name": "user_management", "label": "User Management", "category": "Admin"},
    {"name": "system_settings", "label": "System Settings", "category": "Admin"},
    {"name": "integrations", "label": "Integrations", "category": "Admin"},
  ];

  final List<Map<String, dynamic>> roleItems = [
    {"label": "All Roles", "value": ""},
    {"label": "Admin", "value": "Admin"},
    {"label": "Sales Manager", "value": "Sales Manager"},
    {"label": "Sales Rep", "value": "Sales Rep"},
    {"label": "Marketing Manager", "value": "Marketing Manager"},
    {"label": "Support Agent", "value": "Support Agent"},
  ];

  final List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": ""},
    {"label": "IT", "value": "IT"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Support", "value": "Support"},
    {"label": "HR", "value": "HR"},
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return users.where((user) {
      final matchesSearch = searchQuery.isEmpty ||
          user["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          user["email"].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRole = selectedRole.isEmpty || user["role"] == selectedRole;
      final matchesDepartment = selectedDepartment.isEmpty || user["department"] == selectedDepartment;
      
      return matchesSearch && matchesRole && matchesDepartment;
    }).toList();
  }

  void _editUserPermissions(Map<String, dynamic> user) async {
    // Show user permissions dialog
    ss("User permissions updated for ${user["name"]}");
  }

  void _createRole() async {
    ss("New role created successfully");
  }

  void _editRole(Map<String, dynamic> role) async {
    ss("Role '${role["name"]}' updated successfully");
  }

  void _deleteRole(Map<String, dynamic> role) async {
    bool isConfirmed = await confirm("Are you sure you want to delete the '${role["name"]}' role?");
    if (isConfirmed) {
      ss("Role '${role["name"]}' deleted successfully");
    }
  }

  Widget _buildUsersTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search users...",
                value: searchQuery,
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
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter by Role",
                items: roleItems,
                value: selectedRole,
                onChanged: (value, label) {
                  selectedRole = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Filter by Department",
                items: departmentItems,
                value: selectedDepartment,
                onChanged: (value, label) {
                  selectedDepartment = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${user["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${user["email"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: user["status"] == "Active" 
                                      ? successColor.withAlpha(20)
                                      : dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${user["role"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: user["status"] == "Active" 
                                        ? successColor
                                        : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${user["department"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: user["status"] == "Active" 
                                ? successColor
                                : dangerColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () => _editUserPermissions(user),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRolesTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Manage user roles and permissions",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
            ),
            QButton(
              label: "Create Role",
              icon: Icons.add,
              size: bs.sm,
              onPressed: _createRole,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: roles.length,
            itemBuilder: (context, index) {
              final role = roles[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (role["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.group,
                            color: role["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${role["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${role["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (role["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${role["userCount"]} users",
                            style: TextStyle(
                              fontSize: 12,
                              color: role["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () => _editRole(role),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () => _deleteRole(role),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Permissions:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (role["permissions"] as List<String>).map((permission) {
                        if (permission == "all") {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "All Permissions",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                        
                        final permissionData = permissions.firstWhere(
                          (p) => p["name"] == permission,
                          orElse: () => {"label": permission, "category": "Other"},
                        );
                        
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${permissionData["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionsTab() {
    final groupedPermissions = <String, List<Map<String, dynamic>>>{};
    for (final permission in permissions) {
      final category = permission["category"];
      if (!groupedPermissions.containsKey(category)) {
        groupedPermissions[category] = [];
      }
      groupedPermissions[category]!.add(permission);
    }

    return Column(
      spacing: spMd,
      children: [
        Text(
          "System Permissions Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Expanded(
          child: ListView(
            children: groupedPermissions.entries.map((entry) {
              final category = entry.key;
              final categoryPermissions = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category == "Sales" ? Icons.trending_up :
                          category == "Marketing" ? Icons.campaign :
                          category == "Support" ? Icons.support_agent :
                          Icons.admin_panel_settings,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${categoryPermissions.length} permissions",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...categoryPermissions.map((permission) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${permission["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "User Permissions",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Users", icon: Icon(Icons.people)),
        Tab(text: "Roles", icon: Icon(Icons.group)),
        Tab(text: "Permissions", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildUsersTab(),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildRolesTab(),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildPermissionsTab(),
        ),
      ],
      onInit: (tabController) {
        // Access to TabController if needed
      },
    );
  }
}

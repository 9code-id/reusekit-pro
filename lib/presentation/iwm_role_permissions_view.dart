import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmRolePermissionsView extends StatefulWidget {
  const IwmRolePermissionsView({super.key});

  @override
  State<IwmRolePermissionsView> createState() => _IwmRolePermissionsViewState();
}

class _IwmRolePermissionsViewState extends State<IwmRolePermissionsView> {
  int selectedTab = 0;
  String selectedRole = "employee";
  String searchQuery = "";
  
  // Form fields for role creation/editing
  String roleName = "";
  String roleDescription = "";
  bool roleActive = true;
  
  List<Map<String, dynamic>> roles = [
    {
      "id": "admin",
      "name": "Administrator",
      "description": "Full system access with all permissions",
      "userCount": 3,
      "status": "Active",
      "color": dangerColor,
      "icon": Icons.admin_panel_settings,
      "permissions": {
        "inventory": ["read", "write", "delete", "admin"],
        "users": ["read", "write", "delete", "admin"],
        "reports": ["read", "write", "delete", "admin"],
        "settings": ["read", "write", "delete", "admin"],
        "warehouse": ["read", "write", "delete", "admin"],
        "mobile": ["read", "write", "delete", "admin"]
      }
    },
    {
      "id": "manager",
      "name": "Manager",
      "description": "Management level access with most permissions",
      "userCount": 8,
      "status": "Active",
      "color": primaryColor,
      "icon": Icons.manage_accounts,
      "permissions": {
        "inventory": ["read", "write", "delete"],
        "users": ["read", "write"],
        "reports": ["read", "write", "delete"],
        "settings": ["read", "write"],
        "warehouse": ["read", "write", "delete"],
        "mobile": ["read", "write"]
      }
    },
    {
      "id": "supervisor",
      "name": "Supervisor",
      "description": "Supervisory access with limited administrative permissions",
      "userCount": 15,
      "status": "Active",
      "color": warningColor,
      "icon": Icons.supervisor_account,
      "permissions": {
        "inventory": ["read", "write"],
        "users": ["read"],
        "reports": ["read", "write"],
        "settings": ["read"],
        "warehouse": ["read", "write"],
        "mobile": ["read", "write"]
      }
    },
    {
      "id": "employee",
      "name": "Employee",
      "description": "Basic employee access for daily operations",
      "userCount": 184,
      "status": "Active",
      "color": successColor,
      "icon": Icons.person,
      "permissions": {
        "inventory": ["read"],
        "users": [],
        "reports": ["read"],
        "settings": [],
        "warehouse": ["read", "write"],
        "mobile": ["read", "write"]
      }
    },
    {
      "id": "viewer",
      "name": "Viewer",
      "description": "Read-only access for viewing information",
      "userCount": 12,
      "status": "Active",
      "color": infoColor,
      "icon": Icons.visibility,
      "permissions": {
        "inventory": ["read"],
        "users": [],
        "reports": ["read"],
        "settings": [],
        "warehouse": ["read"],
        "mobile": ["read"]
      }
    },
    {
      "id": "temp",
      "name": "Temporary Worker",
      "description": "Limited access for temporary staff",
      "userCount": 5,
      "status": "Inactive",
      "color": disabledBoldColor,
      "icon": Icons.schedule,
      "permissions": {
        "inventory": [],
        "users": [],
        "reports": [],
        "settings": [],
        "warehouse": ["read"],
        "mobile": ["read"]
      }
    },
  ];

  List<Map<String, dynamic>> permissionCategories = [
    {
      "id": "inventory",
      "name": "Inventory Management",
      "description": "Access to inventory data and operations",
      "icon": Icons.inventory,
      "permissions": [
        {"id": "read", "name": "View Inventory", "description": "View inventory levels and item details"},
        {"id": "write", "name": "Edit Inventory", "description": "Add, edit inventory items and adjust quantities"},
        {"id": "delete", "name": "Delete Items", "description": "Remove inventory items and records"},
        {"id": "admin", "name": "Admin Access", "description": "Full administrative control over inventory"}
      ]
    },
    {
      "id": "users",
      "name": "User Management",
      "description": "Access to user accounts and management",
      "icon": Icons.people,
      "permissions": [
        {"id": "read", "name": "View Users", "description": "View user profiles and information"},
        {"id": "write", "name": "Manage Users", "description": "Create, edit, and modify user accounts"},
        {"id": "delete", "name": "Delete Users", "description": "Remove user accounts from system"},
        {"id": "admin", "name": "Admin Access", "description": "Full user management and security settings"}
      ]
    },
    {
      "id": "reports",
      "name": "Reports & Analytics",
      "description": "Access to reports and analytics data",
      "icon": Icons.analytics,
      "permissions": [
        {"id": "read", "name": "View Reports", "description": "View existing reports and analytics"},
        {"id": "write", "name": "Create Reports", "description": "Generate and customize reports"},
        {"id": "delete", "name": "Delete Reports", "description": "Remove reports and report templates"},
        {"id": "admin", "name": "Admin Access", "description": "Full reporting system administration"}
      ]
    },
    {
      "id": "settings",
      "name": "System Settings",
      "description": "Access to system configuration and settings",
      "icon": Icons.settings,
      "permissions": [
        {"id": "read", "name": "View Settings", "description": "View system configuration and settings"},
        {"id": "write", "name": "Edit Settings", "description": "Modify system settings and configuration"},
        {"id": "delete", "name": "Reset Settings", "description": "Reset settings to default values"},
        {"id": "admin", "name": "Admin Access", "description": "Full system administration access"}
      ]
    },
    {
      "id": "warehouse",
      "name": "Warehouse Operations",
      "description": "Access to warehouse management functions",
      "icon": Icons.warehouse,
      "permissions": [
        {"id": "read", "name": "View Operations", "description": "View warehouse operations and status"},
        {"id": "write", "name": "Manage Operations", "description": "Create and manage warehouse operations"},
        {"id": "delete", "name": "Cancel Operations", "description": "Cancel or remove warehouse operations"},
        {"id": "admin", "name": "Admin Access", "description": "Full warehouse administration access"}
      ]
    },
    {
      "id": "mobile",
      "name": "Mobile App Access",
      "description": "Access to mobile application features",
      "icon": Icons.phone_android,
      "permissions": [
        {"id": "read", "name": "View Mobile Data", "description": "View data through mobile application"},
        {"id": "write", "name": "Mobile Operations", "description": "Perform operations through mobile app"},
        {"id": "delete", "name": "Mobile Admin", "description": "Administrative functions in mobile app"},
        {"id": "admin", "name": "Full Mobile Access", "description": "Complete mobile application control"}
      ]
    },
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Administrator", "value": "admin"},
    {"label": "Manager", "value": "manager"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Employee", "value": "employee"},
    {"label": "Viewer", "value": "viewer"},
  ];

  List<Map<String, dynamic>> recentChanges = [
    {
      "user": "John Smith",
      "action": "Modified Manager role permissions",
      "details": "Added delete permission to Reports",
      "timestamp": "2024-01-15 10:30",
      "type": "modify"
    },
    {
      "user": "Emily Davis", 
      "action": "Created new role",
      "details": "Created 'Quality Inspector' role",
      "timestamp": "2024-01-15 09:15",
      "type": "create"
    },
    {
      "user": "Sarah Johnson",
      "action": "Disabled role",
      "details": "Disabled 'Temporary Worker' role",
      "timestamp": "2024-01-14 16:45",
      "type": "disable"
    },
    {
      "user": "Michael Chen",
      "action": "Updated role assignment",
      "details": "Changed 5 users from Employee to Supervisor",
      "timestamp": "2024-01-14 14:20",
      "type": "assign"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Roles & Permissions",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Roles", icon: Icon(Icons.admin_panel_settings)),
        Tab(text: "Permissions", icon: Icon(Icons.security)),
        Tab(text: "Create Role", icon: Icon(Icons.add_circle)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildRolesTab(),
        _buildPermissionsTab(),
        _buildCreateRoleTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildRolesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRoleStats(),
          _buildRolesList(),
        ],
      ),
    );
  }

  Widget _buildPermissionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPermissionFilters(),
          _buildPermissionMatrix(),
        ],
      ),
    );
  }

  Widget _buildCreateRoleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRoleForm(),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActivityFilters(),
          _buildActivityList(),
        ],
      ),
    );
  }

  Widget _buildRoleStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Total Roles", "value": "6", "icon": Icons.admin_panel_settings, "color": primaryColor},
      {"title": "Active Roles", "value": "5", "icon": Icons.check_circle, "color": successColor},
      {"title": "Total Users", "value": "227", "icon": Icons.people, "color": infoColor},
      {"title": "Recent Changes", "value": "12", "icon": Icons.update, "color": warningColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (stat["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              stat["icon"],
              color: stat["color"],
              size: 24,
            ),
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRolesList() {
    return Column(
      spacing: spSm,
      children: roles.map((role) => _buildRoleCard(role)).toList(),
    );
  }

  Widget _buildRoleCard(Map<String, dynamic> role) {
    Color statusColor = role["status"] == "Active" ? successColor : disabledBoldColor;
    Map<String, dynamic> permissions = role["permissions"];
    int totalPermissions = permissions.values.fold(0, (sum, perms) => sum + (perms as List).length);

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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (role["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  role["icon"],
                  color: role["color"],
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
                        Text(
                          "${role["name"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${role["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
            ],
          ),
          Row(
            children: [
              _buildInfoChip("${role["userCount"]} users", Icons.people),
              SizedBox(width: spSm),
              _buildInfoChip("$totalPermissions permissions", Icons.security),
              Spacer(),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.copy,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Permissions Overview:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: permissions.entries.map((entry) {
                    List perms = entry.value;
                    if (perms.isEmpty) return Container();
                    
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${entry.key}: ${perms.length}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: disabledBoldColor,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionFilters() {
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
          Text(
            "Permission Matrix",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Role to View",
            items: roleOptions,
            value: selectedRole,
            onChanged: (value, label) {
              selectedRole = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionMatrix() {
    Map<String, dynamic> selectedRoleData = roles.firstWhere(
      (role) => role["id"] == selectedRole,
      orElse: () => roles.first,
    );
    
    Map<String, dynamic> rolePermissions = selectedRoleData["permissions"];

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
              Text(
                "Permissions for ${selectedRoleData["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit Permissions",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...permissionCategories.map((category) => _buildPermissionCategory(category, rolePermissions)),
        ],
      ),
    );
  }

  Widget _buildPermissionCategory(Map<String, dynamic> category, Map<String, dynamic> rolePermissions) {
    List categoryPerms = rolePermissions[category["id"]] ?? [];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                category["icon"],
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${category["description"]}",
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
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: (category["permissions"] as List).map((permission) {
              bool hasPermission = categoryPerms.contains(permission["id"]);
              
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: hasPermission ? successColor.withAlpha(20) : disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: hasPermission ? successColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hasPermission ? Icons.check_circle : Icons.cancel,
                      color: hasPermission ? successColor : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${permission["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: hasPermission ? successColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${permission["description"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: hasPermission ? successColor : disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleForm() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Role",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Role Name",
            value: roleName,
            hint: "Enter role name (e.g., Quality Inspector)",
            onChanged: (value) {
              roleName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Role Description",
            value: roleDescription,
            hint: "Describe the role's responsibilities and scope",
            onChanged: (value) {
              roleDescription = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Active Role",
                "value": true,
                "checked": roleActive,
              }
            ],
            value: [if (roleActive) {"label": "Active Role", "value": true, "checked": true}],
            onChanged: (values, ids) {
              roleActive = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Permissions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Choose the permissions for this role. You can modify these later.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                ...permissionCategories.map((category) => _buildPermissionSelector(category)),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    _clearRoleForm();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Role",
                  size: bs.md,
                  onPressed: () {
                    _createRole();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSelector(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                category["icon"],
                color: primaryColor,
                size: 18,
              ),
              SizedBox(width: spSm),
              Text(
                "${category["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: (category["permissions"] as List).map((permission) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Text(
                  "${permission["name"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search Activity",
              value: searchQuery,
              hint: "Search by user or action...",
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    return Column(
      spacing: spSm,
      children: recentChanges.map((change) => _buildActivityItem(change)).toList(),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> change) {
    Color typeColor = _getActivityTypeColor(change["type"]);
    IconData typeIcon = _getActivityTypeIcon(change["type"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: typeColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
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
                    Text(
                      "${change["user"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${change["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${change["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${change["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case 'create':
        return successColor;
      case 'modify':
        return warningColor;
      case 'disable':
        return dangerColor;
      case 'assign':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActivityTypeIcon(String type) {
    switch (type) {
      case 'create':
        return Icons.add_circle;
      case 'modify':
        return Icons.edit;
      case 'disable':
        return Icons.block;
      case 'assign':
        return Icons.assignment_ind;
      default:
        return Icons.info;
    }
  }

  void _clearRoleForm() {
    roleName = "";
    roleDescription = "";
    roleActive = true;
    setState(() {});
  }

  void _createRole() {
    if (roleName.isEmpty || roleDescription.isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    ss("Role '${roleName}' created successfully");
    _clearRoleForm();
  }
}

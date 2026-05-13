import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaRoleManagementView extends StatefulWidget {
  const PmaRoleManagementView({super.key});

  @override
  State<PmaRoleManagementView> createState() => _PmaRoleManagementViewState();
}

class _PmaRoleManagementViewState extends State<PmaRoleManagementView> {
  String searchQuery = "";
  String selectedDepartment = "all";
  bool showCreateRoleForm = false;

  // Create Role Form Fields
  String newRoleName = "";
  String newRoleDescription = "";
  String newRoleDepartment = "";
  List<String> newRolePermissions = [];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> roles = [
    {
      "id": 1,
      "name": "Team Lead",
      "description": "Leads a team of developers and manages project delivery",
      "department": "engineering",
      "memberCount": 5,
      "permissions": [
        "manage_team", "view_reports", "edit_projects", "view_projects",
        "approve_requests", "access_admin_panel"
      ],
      "createdAt": "2024-01-15",
      "isActive": true,
      "color": primaryColor,
    },
    {
      "id": 2,
      "name": "Senior Developer",
      "description": "Experienced developer with advanced technical skills",
      "department": "engineering",
      "memberCount": 12,
      "permissions": [
        "edit_projects", "view_projects", "code_review", "mentor_juniors"
      ],
      "createdAt": "2024-01-20",
      "isActive": true,
      "color": successColor,
    },
    {
      "id": 3,
      "name": "Developer",
      "description": "Mid-level developer working on assigned projects",
      "department": "engineering",
      "memberCount": 18,
      "permissions": [
        "edit_projects", "view_projects", "create_tasks"
      ],
      "createdAt": "2024-02-01",
      "isActive": true,
      "color": infoColor,
    },
    {
      "id": 4,
      "name": "Junior Developer",
      "description": "Entry-level developer learning and contributing",
      "department": "engineering",
      "memberCount": 8,
      "permissions": [
        "view_projects", "create_tasks"
      ],
      "createdAt": "2024-02-15",
      "isActive": true,
      "color": warningColor,
    },
    {
      "id": 5,
      "name": "UI/UX Designer",
      "description": "Creates user interfaces and user experience designs",
      "department": "design",
      "memberCount": 6,
      "permissions": [
        "design_projects", "view_projects", "prototype_access", "user_research"
      ],
      "createdAt": "2024-03-01",
      "isActive": true,
      "color": secondaryColor,
    },
    {
      "id": 6,
      "name": "QA Engineer",
      "description": "Ensures quality through testing and validation",
      "department": "engineering",
      "memberCount": 4,
      "permissions": [
        "test_projects", "view_projects", "bug_reporting", "test_automation"
      ],
      "createdAt": "2024-03-10",
      "isActive": true,
      "color": dangerColor,
    },
    {
      "id": 7,
      "name": "Project Manager",
      "description": "Manages project timelines and team coordination",
      "department": "engineering",
      "memberCount": 3,
      "permissions": [
        "manage_projects", "view_reports", "team_coordination", "budget_access"
      ],
      "createdAt": "2024-03-20",
      "isActive": false,
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> permissions = [
    {
      "id": "view_projects",
      "name": "View Projects",
      "description": "Can view project details and progress",
      "category": "Projects"
    },
    {
      "id": "edit_projects",
      "name": "Edit Projects",
      "description": "Can modify project details and settings",
      "category": "Projects"
    },
    {
      "id": "delete_projects",
      "name": "Delete Projects",
      "description": "Can delete projects and all associated data",
      "category": "Projects"
    },
    {
      "id": "manage_projects",
      "name": "Manage Projects",
      "description": "Full project management capabilities",
      "category": "Projects"
    },
    {
      "id": "manage_team",
      "name": "Manage Team",
      "description": "Can add, remove, and modify team members",
      "category": "Team"
    },
    {
      "id": "view_reports",
      "name": "View Reports",
      "description": "Access to analytics and reporting features",
      "category": "Reports"
    },
    {
      "id": "code_review",
      "name": "Code Review",
      "description": "Can review and approve code changes",
      "category": "Development"
    },
    {
      "id": "approve_requests",
      "name": "Approve Requests",
      "description": "Can approve various system requests",
      "category": "Administration"
    },
    {
      "id": "access_admin_panel",
      "name": "Admin Panel Access",
      "description": "Access to administrative functions",
      "category": "Administration"
    },
  ];

  List<Map<String, dynamic>> get filteredRoles {
    return roles.where((role) {
      bool matchesDepartment = selectedDepartment == "all" || role["department"] == selectedDepartment;
      bool matchesSearch = searchQuery.isEmpty || 
          role["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          role["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesDepartment && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Role Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              showCreateRoleForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showCreateRoleForm ? _buildCreateRoleForm() : _buildRolesList(),
    );
  }

  Widget _buildRolesList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search roles...",
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

          SizedBox(height: spMd),

          QDropdownField(
            label: "Department Filter",
            items: departmentOptions,
            value: selectedDepartment,
            onChanged: (value, label) {
              selectedDepartment = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Roles Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Roles Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard("Total Roles", "${roles.length}", primaryColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard("Active", "${roles.where((r) => r["isActive"] == true).length}", successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard("Total Members", "${roles.fold(0, (sum, role) => sum + (role["memberCount"] as int))}", infoColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Results Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Roles (${filteredRoles.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Roles Grid
          if (filteredRoles.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              child: Column(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No roles found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Try adjusting your filters or create a new role",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredRoles.map((role) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      top: BorderSide(
                        width: 4,
                        color: role["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${role["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${role["department"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: role["color"] as Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: role["isActive"] == true
                                        ? successColor.withAlpha(20)
                                        : disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    role["isActive"] == true ? "ACTIVE" : "INACTIVE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: role["isActive"] == true ? successColor : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Description
                            Text(
                              "${role["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: spMd),

                            // Member Count
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (role["color"] as Color).withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: (role["color"] as Color).withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 20,
                                    color: role["color"] as Color,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${role["memberCount"]} members",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: role["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Permissions Count
                            Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(role["permissions"] as List).length} permissions",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse("${role["createdAt"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Top Permissions Preview
                            Text(
                              "Key Permissions:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (role["permissions"] as List).take(3).map((permission) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: primaryColor.withAlpha(30)),
                                  ),
                                  child: Text(
                                    _getPermissionName(permission),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            if ((role["permissions"] as List).length > 3)
                              Padding(
                                padding: EdgeInsets.only(top: spXs),
                                child: Text(
                                  "+${(role["permissions"] as List).length - 3} more",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Container(
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  _showRoleDetails(role);
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.edit,
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

  Widget _buildCreateRoleForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              QButton(
                icon: Icons.arrow_back,
                size: bs.sm,
                onPressed: () {
                  showCreateRoleForm = false;
                  setState(() {});
                },
              ),
              SizedBox(width: spMd),
              Text(
                "Create New Role",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Basic Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                QTextField(
                  label: "Role Name",
                  value: newRoleName,
                  validator: Validator.required,
                  onChanged: (value) {
                    newRoleName = value;
                    setState(() {});
                  },
                ),

                SizedBox(height: spMd),

                QTextField(
                  label: "Description",
                  value: newRoleDescription,
                  validator: Validator.required,
                  onChanged: (value) {
                    newRoleDescription = value;
                    setState(() {});
                  },
                ),

                SizedBox(height: spMd),

                QDropdownField(
                  label: "Department",
                  items: departmentOptions.where((d) => d["value"] != "all").toList(),
                  value: newRoleDepartment,
                  onChanged: (value, label) {
                    newRoleDepartment = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Permissions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Permissions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                // Group permissions by category
                ...permissions.fold<Map<String, List<Map<String, dynamic>>>>({}, (map, permission) {
                  String category = permission["category"];
                  if (!map.containsKey(category)) {
                    map[category] = [];
                  }
                  map[category]!.add(permission);
                  return map;
                }).entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QSwitch(
                        items: entry.value.map((permission) {
                          return {
                            "label": permission["name"],
                            "value": permission["id"],
                            "checked": newRolePermissions.contains(permission["id"]),
                          };
                        }).toList(),
                        value: newRolePermissions.where((p) => 
                            entry.value.any((permission) => permission["id"] == p)
                        ).map((permission) {
                          Map<String, dynamic> permissionData = entry.value.firstWhere((p) => p["id"] == permission);
                          return {
                            "label": permissionData["name"],
                            "value": permission,
                            "checked": true,
                          };
                        }).toList(),
                        onChanged: (values, ids) {
                          // Remove old permissions from this category
                          newRolePermissions.removeWhere((p) => 
                              entry.value.any((permission) => permission["id"] == p)
                          );
                          // Add new selected permissions
                          newRolePermissions.addAll(values.map((v) => v["value"].toString()));
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    showCreateRoleForm = false;
                    _resetForm();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Create Role",
                  size: bs.md,
                  onPressed: _createRole,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
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
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getPermissionName(String permissionId) {
    return permissions.firstWhere(
      (p) => p["id"] == permissionId,
      orElse: () => {"name": permissionId},
    )["name"];
  }

  void _showRoleDetails(Map<String, dynamic> role) {
    // Show role details dialog or navigate to details page
    ss("Viewing details for ${role["name"]}");
  }

  void _createRole() {
    if (newRoleName.isNotEmpty && newRoleDescription.isNotEmpty && newRoleDepartment.isNotEmpty) {
      // Create role logic here
      ss("Role '${newRoleName}' created successfully!");
      showCreateRoleForm = false;
      _resetForm();
      setState(() {});
    } else {
      se("Please fill in all required fields");
    }
  }

  void _resetForm() {
    newRoleName = "";
    newRoleDescription = "";
    newRoleDepartment = "";
    newRolePermissions = [];
  }
}

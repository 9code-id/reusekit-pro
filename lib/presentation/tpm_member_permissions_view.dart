import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmMemberPermissionsView extends StatefulWidget {
  const TpmMemberPermissionsView({super.key});

  @override
  State<TpmMemberPermissionsView> createState() => _TpmMemberPermissionsViewState();
}

class _TpmMemberPermissionsViewState extends State<TpmMemberPermissionsView> {
  Map<String, dynamic> selectedMember = {
    "id": "1",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@company.com",
    "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
    "role": "Project Manager",
    "joinedAt": "2024-01-15",
    "department": "Engineering",
    "status": "active"
  };

  Map<String, List<Map<String, dynamic>>> permissionCategories = {
    "Workspace Management": [
      {
        "id": "workspace_settings",
        "name": "Manage workspace settings",
        "description": "Change workspace name, description, and general settings",
        "enabled": true,
        "level": "admin"
      },
      {
        "id": "billing_management",
        "name": "Manage billing and subscriptions",
        "description": "Access billing information and manage subscriptions",
        "enabled": false,
        "level": "owner"
      },
      {
        "id": "workspace_analytics",
        "name": "View workspace analytics",
        "description": "Access workspace-wide analytics and reports",
        "enabled": true,
        "level": "admin"
      },
    ],
    "Member Management": [
      {
        "id": "invite_members",
        "name": "Invite new members",
        "description": "Send invitations to new team members",
        "enabled": true,
        "level": "admin"
      },
      {
        "id": "remove_members",
        "name": "Remove members",
        "description": "Remove members from the workspace",
        "enabled": false,
        "level": "admin"
      },
      {
        "id": "manage_roles",
        "name": "Manage member roles",
        "description": "Assign and change member roles and permissions",
        "enabled": true,
        "level": "admin"
      },
      {
        "id": "view_member_details",
        "name": "View member details",
        "description": "Access detailed information about team members",
        "enabled": true,
        "level": "manager"
      },
    ],
    "Project Management": [
      {
        "id": "create_projects",
        "name": "Create new projects",
        "description": "Create and initialize new projects",
        "enabled": true,
        "level": "manager"
      },
      {
        "id": "delete_projects",
        "name": "Delete projects",
        "description": "Permanently delete projects from workspace",
        "enabled": false,
        "level": "admin"
      },
      {
        "id": "manage_all_projects",
        "name": "Manage all projects",
        "description": "Access and modify all projects in workspace",
        "enabled": true,
        "level": "manager"
      },
      {
        "id": "archive_projects",
        "name": "Archive projects",
        "description": "Archive completed or inactive projects",
        "enabled": true,
        "level": "manager"
      },
      {
        "id": "export_project_data",
        "name": "Export project data",
        "description": "Export project information and reports",
        "enabled": true,
        "level": "manager"
      },
    ],
    "Task Management": [
      {
        "id": "create_tasks",
        "name": "Create tasks",
        "description": "Create new tasks and assignments",
        "enabled": true,
        "level": "member"
      },
      {
        "id": "assign_tasks",
        "name": "Assign tasks to others",
        "description": "Assign tasks to team members",
        "enabled": true,
        "level": "manager"
      },
      {
        "id": "delete_tasks",
        "name": "Delete tasks",
        "description": "Delete tasks from projects",
        "enabled": false,
        "level": "manager"
      },
      {
        "id": "modify_task_status",
        "name": "Modify task status",
        "description": "Change task status and completion",
        "enabled": true,
        "level": "member"
      },
    ],
    "File Management": [
      {
        "id": "upload_files",
        "name": "Upload files",
        "description": "Upload files and documents to projects",
        "enabled": true,
        "level": "member"
      },
      {
        "id": "delete_files",
        "name": "Delete files",
        "description": "Delete files and documents from projects",
        "enabled": false,
        "level": "manager"
      },
      {
        "id": "manage_file_permissions",
        "name": "Manage file permissions",
        "description": "Control who can access specific files",
        "enabled": false,
        "level": "manager"
      },
    ],
    "Communication": [
      {
        "id": "comment_projects",
        "name": "Comment on projects",
        "description": "Add comments to projects and tasks",
        "enabled": true,
        "level": "member"
      },
      {
        "id": "mention_members",
        "name": "Mention team members",
        "description": "Use @mentions to notify team members",
        "enabled": true,
        "level": "member"
      },
      {
        "id": "moderate_comments",
        "name": "Moderate comments",
        "description": "Edit or delete comments from others",
        "enabled": false,
        "level": "manager"
      },
    ],
  };

  String searchQuery = "";
  String selectedCategory = "All";

  List<String> get categories => ["All"] + permissionCategories.keys.toList();

  List<Map<String, dynamic>> get allPermissions {
    List<Map<String, dynamic>> all = [];
    permissionCategories.forEach((category, permissions) {
      for (var permission in permissions) {
        all.add({
          ...permission,
          "category": category,
        });
      }
    });
    return all;
  }

  List<Map<String, dynamic>> get filteredPermissions {
    List<Map<String, dynamic>> filtered = allPermissions;

    if (selectedCategory != "All") {
      filtered = filtered.where((permission) => permission["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((permission) {
        return "${permission["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
            "${permission["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  Color getLevelColor(String level) {
    switch (level) {
      case "owner":
        return dangerColor;
      case "admin":
        return warningColor;
      case "manager":
        return primaryColor;
      case "member":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String getLevelText(String level) {
    switch (level) {
      case "owner":
        return "Owner Only";
      case "admin":
        return "Admin";
      case "manager":
        return "Manager";
      case "member":
        return "Member";
      default:
        return "Unknown";
    }
  }

  void _togglePermission(String permissionId, bool enabled) {
    // Find and update the permission
    permissionCategories.forEach((category, permissions) {
      for (var permission in permissions) {
        if (permission["id"] == permissionId) {
          permission["enabled"] = enabled;
          break;
        }
      }
    });
    
    setState(() {});
    
    String message = enabled ? "Permission granted" : "Permission revoked";
    ss(message);
  }

  void _bulkUpdatePermissions(String action) async {
    bool isConfirmed = false;
    String message = "";
    
    switch (action) {
      case "enable_all":
        message = "Are you sure you want to enable all permissions for ${selectedMember["name"]}?";
        break;
      case "disable_all":
        message = "Are you sure you want to disable all permissions for ${selectedMember["name"]}?";
        break;
      case "reset_default":
        message = "Are you sure you want to reset permissions to default for ${selectedMember["name"]}?";
        break;
    }

    isConfirmed = await confirm(message);
    
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      
      permissionCategories.forEach((category, permissions) {
        for (var permission in permissions) {
          switch (action) {
            case "enable_all":
              permission["enabled"] = true;
              break;
            case "disable_all":
              permission["enabled"] = false;
              break;
            case "reset_default":
              // Reset to default based on member's role
              if (selectedMember["role"] == "Project Manager") {
                permission["enabled"] = permission["level"] == "member" || permission["level"] == "manager";
              } else {
                permission["enabled"] = permission["level"] == "member";
              }
              break;
          }
        }
      });
      
      hideLoading();
      setState(() {});
      
      String successMessage = "";
      switch (action) {
        case "enable_all":
          successMessage = "All permissions enabled successfully";
          break;
        case "disable_all":
          successMessage = "All permissions disabled successfully";
          break;
        case "reset_default":
          successMessage = "Permissions reset to default successfully";
          break;
      }
      ss(successMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    int enabledCount = allPermissions.where((p) => p["enabled"] == true).length;
    int totalCount = allPermissions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Member Permissions"),
        actions: [
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showBulkActionsSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Member Info Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${selectedMember["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedMember["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${selectedMember["role"]} • ${selectedMember["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${selectedMember["email"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "$enabledCount",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "of $totalCount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "permissions",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Progress Bar
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: enabledCount / totalCount,
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${((enabledCount / totalCount) * 100).toInt()}% permissions enabled",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search permissions...",
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
                SizedBox(height: spSm),
                QCategoryPicker(
                  items: categories.map((category) => {
                    "label": category,
                    "value": category,
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Permissions List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedCategory == "All")
                    ...permissionCategories.entries.map((entry) {
                      String categoryName = entry.key;
                      List<Map<String, dynamic>> categoryPermissions = entry.value;
                      
                      // Filter by search query
                      if (searchQuery.isNotEmpty) {
                        categoryPermissions = categoryPermissions.where((permission) {
                          return "${permission["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                              "${permission["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
                        }).toList();
                      }
                      
                      if (categoryPermissions.isEmpty) return Container();
                      
                      return _buildPermissionCategory(categoryName, categoryPermissions);
                    }).toList()
                  else
                    _buildPermissionCategory(selectedCategory, filteredPermissions),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionCategory(String categoryName, List<Map<String, dynamic>> permissions) {
    int enabledInCategory = permissions.where((p) => p["enabled"] == true).length;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$enabledInCategory/${permissions.length} enabled",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Permissions List
          ...permissions.map((permission) {
            bool isEnabled = permission["enabled"] == true;
            Color levelColor = getLevelColor("${permission["level"]}");
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledColor, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${permission["name"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isEnabled ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: levelColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                getLevelText("${permission["level"]}"),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: levelColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${permission["description"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Switch(
                    value: isEnabled,
                    onChanged: (value) {
                      _togglePermission("${permission["id"]}", value);
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showBulkActionsSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${selectedMember["avatar"]}"),
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
                          "Bulk Permission Actions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "For ${selectedMember["name"]}",
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
              SizedBox(height: spMd),
              _buildActionTile(Icons.check_circle, "Enable All Permissions", () {
                back();
                _bulkUpdatePermissions("enable_all");
              }),
              _buildActionTile(Icons.cancel, "Disable All Permissions", () {
                back();
                _bulkUpdatePermissions("disable_all");
              }),
              _buildActionTile(Icons.refresh, "Reset to Default", () {
                back();
                _bulkUpdatePermissions("reset_default");
              }),
              _buildActionTile(Icons.copy, "Copy from Another Member", () {
                back();
                _showCopyPermissionsDialog();
              }),
            ],
          ),
        );
      },
    );
  }

  void _showCopyPermissionsDialog() {
    List<Map<String, dynamic>> otherMembers = [
      {
        "id": "2",
        "name": "Michael Chen",
        "email": "michael.chen@company.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
        "role": "Senior Developer"
      },
      {
        "id": "3",
        "name": "Emily Rodriguez",
        "email": "emily.rodriguez@company.com",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=woman", 
        "role": "UI Designer"
      },
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Copy Permissions"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a member to copy permissions from:",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(height: spMd),
              ...otherMembers.map((member) {
                return GestureDetector(
                  onTap: () {
                    back();
                    _copyPermissionsFrom(member);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${member["avatar"]}"),
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
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${member["role"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _copyPermissionsFrom(Map<String, dynamic> fromMember) async {
    bool isConfirmed = await confirm("Copy all permissions from ${fromMember["name"]} to ${selectedMember["name"]}?");
    
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      
      // Simulate copying permissions (in real app, this would fetch from API)
      // For demo, we'll randomly set some permissions
      permissionCategories.forEach((category, permissions) {
        for (var permission in permissions) {
          permission["enabled"] = DateTime.now().millisecond % 2 == 0;
        }
      });
      
      hideLoading();
      setState(() {});
      ss("Permissions copied from ${fromMember["name"]} successfully");
    }
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

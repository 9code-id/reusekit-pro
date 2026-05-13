import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmMemberRolesView extends StatefulWidget {
  const TpmMemberRolesView({super.key});

  @override
  State<TpmMemberRolesView> createState() => _TpmMemberRolesViewState();
}

class _TpmMemberRolesViewState extends State<TpmMemberRolesView> {
  List<Map<String, dynamic>> roles = [
    {
      "id": "1",
      "name": "Owner",
      "description": "Full administrative access to the workspace",
      "color": "#FF4444",
      "memberCount": 1,
      "isSystem": true,
      "permissions": [
        "Manage workspace settings",
        "Manage billing and subscriptions",
        "Add/remove members",
        "Manage all projects",
        "Assign roles and permissions",
        "Delete workspace"
      ]
    },
    {
      "id": "2",
      "name": "Admin",
      "description": "Administrative access with some restrictions",
      "color": "#FF8800",
      "memberCount": 2,
      "isSystem": true,
      "permissions": [
        "Manage workspace settings",
        "Add/remove members",
        "Manage all projects",
        "Assign member roles",
        "View analytics and reports"
      ]
    },
    {
      "id": "3",
      "name": "Project Manager",
      "description": "Can create and manage projects",
      "color": "#0088FF",
      "memberCount": 5,
      "isSystem": false,
      "permissions": [
        "Create new projects",
        "Manage assigned projects",
        "Add members to projects",
        "View project analytics",
        "Export project data"
      ]
    },
    {
      "id": "4",
      "name": "Team Lead",
      "description": "Can lead teams and review work",
      "color": "#8800FF",
      "memberCount": 8,
      "isSystem": false,
      "permissions": [
        "Manage team members",
        "Review and approve work",
        "Create tasks and assignments",
        "View team performance",
        "Comment on all projects"
      ]
    },
    {
      "id": "5",
      "name": "Developer",
      "description": "Can contribute to development tasks",
      "color": "#00AA44",
      "memberCount": 15,
      "isSystem": false,
      "permissions": [
        "Create and edit tasks",
        "Upload files and documents",
        "Comment on projects",
        "View assigned projects",
        "Track time and progress"
      ]
    },
    {
      "id": "6",
      "name": "Designer",
      "description": "Can work on design-related tasks",
      "color": "#FF00AA",
      "memberCount": 6,
      "isSystem": false,
      "permissions": [
        "Create and edit design tasks",
        "Upload design assets",
        "Comment on projects",
        "View design projects",
        "Share design feedback"
      ]
    },
    {
      "id": "7",
      "name": "Member",
      "description": "Basic access to assigned projects",
      "color": "#666666",
      "memberCount": 20,
      "isSystem": true,
      "permissions": [
        "View assigned projects",
        "Create personal tasks",
        "Comment on allowed projects",
        "Upload files to tasks",
        "Edit own profile"
      ]
    }
  ];

  String selectedRoleId = "";
  bool showCreateRoleDialog = false;

  List<Map<String, dynamic>> membersByRole = [
    {
      "roleId": "3",
      "members": [
        {
          "id": "1",
          "name": "Sarah Johnson",
          "email": "sarah.johnson@company.com",
          "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
          "joinedAt": "2024-01-15"
        },
        {
          "id": "2", 
          "name": "Michael Chen",
          "email": "michael.chen@company.com",
          "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
          "joinedAt": "2024-02-20"
        }
      ]
    },
    {
      "roleId": "5",
      "members": [
        {
          "id": "3",
          "name": "Emily Rodriguez", 
          "email": "emily.rodriguez@company.com",
          "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
          "joinedAt": "2024-01-10"
        },
        {
          "id": "4",
          "name": "David Kim",
          "email": "david.kim@company.com", 
          "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
          "joinedAt": "2024-03-05"
        }
      ]
    }
  ];

  Color _getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
  }

  List<Map<String, dynamic>> _getMembersForRole(String roleId) {
    var roleMembers = membersByRole.firstWhere(
      (item) => item["roleId"] == roleId,
      orElse: () => {"members": []},
    );
    return List<Map<String, dynamic>>.from(roleMembers["members"] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Member Roles"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showCreateRoleDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.security,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Workspace Roles",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Manage roles and permissions for team members",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${roles.fold(0, (sum, role) => sum + (role["memberCount"] as int))} Members",
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

            SizedBox(height: spMd),

            // Roles List
            Text(
              "Available Roles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...roles.map((role) {
              List<Map<String, dynamic>> roleMembers = _getMembersForRole("${role["id"]}");
              Color roleColor = _getColorFromHex("${role["color"]}");

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
                    // Role Header
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: roleColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${role["name"]}".substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: roleColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${role["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (role["isSystem"] == true)
                                      Container(
                                        margin: EdgeInsets.only(left: spSm),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "SYSTEM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${role["description"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: roleColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${role["memberCount"]} ${(role["memberCount"] as int) == 1 ? 'member' : 'members'}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: roleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (role["isSystem"] != true)
                                GestureDetector(
                                  onTap: () => _showRoleOptionsSheet(role),
                                  child: Container(
                                    margin: EdgeInsets.only(top: spXs),
                                    padding: EdgeInsets.all(spXs),
                                    child: Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Permissions
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Permissions:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (role["permissions"] as List<String>).map((permission) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  permission,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Members with this role
                    if (roleMembers.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Members with this role:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...roleMembers.take(3).map((member) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
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
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${member["email"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Joined ${member["joinedAt"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            if (roleMembers.length > 3)
                              GestureDetector(
                                onTap: () => _showAllMembersSheet(role, roleMembers),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spXs),
                                  child: Text(
                                    "View all ${roleMembers.length} members",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showCreateRoleDialog() {
    String roleName = "";
    String roleDescription = "";
    String roleColor = "#0088FF";
    List<String> selectedPermissions = [];

    List<String> availablePermissions = [
      "Manage workspace settings",
      "Add/remove members",
      "Manage all projects",
      "Create new projects",
      "Assign member roles",
      "View analytics and reports",
      "Manage team members",
      "Review and approve work",
      "Create tasks and assignments",
      "View team performance",
      "Upload files and documents",
      "Comment on projects",
      "Track time and progress",
      "Export project data"
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Create New Role"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QTextField(
                      label: "Role Name",
                      value: roleName,
                      onChanged: (value) {
                        roleName = value;
                        setDialogState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Description",
                      value: roleDescription,
                      onChanged: (value) {
                        roleDescription = value;
                        setDialogState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Select Permissions:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: availablePermissions.map((permission) {
                            bool isSelected = selectedPermissions.contains(permission);
                            return GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  selectedPermissions.remove(permission);
                                } else {
                                  selectedPermissions.add(permission);
                                }
                                setDialogState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                      color: isSelected ? primaryColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        permission,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => back(),
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Create Role",
                  size: bs.sm,
                  onPressed: roleName.isNotEmpty && selectedPermissions.isNotEmpty
                      ? () {
                          // Add new role
                          Map<String, dynamic> newRole = {
                            "id": DateTime.now().millisecondsSinceEpoch.toString(),
                            "name": roleName,
                            "description": roleDescription.isNotEmpty ? roleDescription : "Custom role",
                            "color": roleColor,
                            "memberCount": 0,
                            "isSystem": false,
                            "permissions": selectedPermissions,
                          };
                          
                          roles.add(newRole);
                          setState(() {});
                          back();
                          ss("Role created successfully");
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showRoleOptionsSheet(Map<String, dynamic> role) {
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getColorFromHex("${role["color"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${role["name"]}".substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getColorFromHex("${role["color"]}"),
                        ),
                      ),
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${role["memberCount"]} ${(role["memberCount"] as int) == 1 ? 'member' : 'members'}",
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
              _buildActionTile(Icons.edit, "Edit Role", () {
                back();
                _editRole(role);
              }),
              _buildActionTile(Icons.people, "Manage Members", () {
                back();
                _manageMembersInRole(role);
              }),
              _buildActionTile(Icons.copy, "Duplicate Role", () {
                back();
                _duplicateRole(role);
              }),
              _buildActionTile(Icons.delete, "Delete Role", () {
                back();
                _confirmDeleteRole(role);
              }, isDestructive: true),
            ],
          ),
        );
      },
    );
  }

  void _showAllMembersSheet(Map<String, dynamic> role, List<Map<String, dynamic>> members) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
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
              Text(
                "${role["name"]} Members (${members.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
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
                                  "${member["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Joined ${member["joinedAt"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.person_remove,
                            size: bs.sm,
                            onPressed: () {
                              // Remove member from role
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isDestructive ? dangerColor : primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editRole(Map<String, dynamic> role) {
    // Navigate to edit role screen
    si("Edit role functionality would be implemented here");
  }

  void _manageMembersInRole(Map<String, dynamic> role) {
    // Navigate to manage members screen
    si("Manage members functionality would be implemented here");
  }

  void _duplicateRole(Map<String, dynamic> role) {
    Map<String, dynamic> duplicatedRole = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": "${role["name"]} Copy",
      "description": "${role["description"]} (Copy)",
      "color": role["color"],
      "memberCount": 0,
      "isSystem": false,
      "permissions": List<String>.from(role["permissions"]),
    };
    
    roles.add(duplicatedRole);
    setState(() {});
    ss("Role duplicated successfully");
  }

  void _confirmDeleteRole(Map<String, dynamic> role) async {
    if ((role["memberCount"] as int) > 0) {
      se("Cannot delete role with assigned members. Please reassign members first.");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to delete the ${role["name"]} role? This action cannot be undone.");
    if (isConfirmed) {
      roles.removeWhere((r) => r["id"] == role["id"]);
      setState(() {});
      ss("Role deleted successfully");
    }
  }
}

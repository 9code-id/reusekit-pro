import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmWorkspaceMembersView extends StatefulWidget {
  const TpmWorkspaceMembersView({super.key});

  @override
  State<TpmWorkspaceMembersView> createState() => _TpmWorkspaceMembersViewState();
}

class _TpmWorkspaceMembersViewState extends State<TpmWorkspaceMembersView> {
  List<Map<String, dynamic>> members = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "role": "Project Manager",
      "status": "active",
      "lastActive": "2 hours ago",
      "projects": 5,
      "department": "Engineering"
    },
    {
      "id": "2", 
      "name": "Michael Chen",
      "email": "michael.chen@company.com", 
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "role": "Senior Developer",
      "status": "active",
      "lastActive": "30 minutes ago",
      "projects": 3,
      "department": "Engineering"
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "role": "UI Designer",
      "status": "offline",
      "lastActive": "1 day ago",
      "projects": 4,
      "department": "Design"
    },
    {
      "id": "4",
      "name": "David Kim",
      "email": "david.kim@company.com",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "role": "DevOps Engineer",
      "status": "active",
      "lastActive": "5 minutes ago",
      "projects": 2,
      "department": "Operations"
    },
    {
      "id": "5",
      "name": "Lisa Anderson",
      "email": "lisa.anderson@company.com",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "role": "Business Analyst",
      "status": "away",
      "lastActive": "4 hours ago",
      "projects": 6,
      "department": "Business"
    }
  ];

  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Business", "value": "Business"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Away", "value": "away"},
    {"label": "Offline", "value": "offline"},
  ];

  List<Map<String, dynamic>> get filteredMembers {
    return members.where((member) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${member["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${member["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${member["role"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesDepartment = selectedDepartment == "All" ||
          "${member["department"]}" == selectedDepartment;

      bool matchesStatus = selectedStatus == "All" ||
          "${member["status"]}" == selectedStatus;

      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'away':
        return warningColor;
      case 'offline':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active';
      case 'away':
        return 'Away';
      case 'offline':
        return 'Offline';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workspace Members"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              //navigateTo('TpmInviteMembersView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
                        label: "Search members...",
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
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentItems,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusItems,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team Members (${filteredMembers.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${members.where((m) => m["status"] == "active").length} Active",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...filteredMembers.map((member) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage("${member["avatar"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    bottom: 2,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: getStatusColor("${member["status"]}"),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${member["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${member["role"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${member["email"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showMemberOptionsSheet(member);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${member["projects"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Projects",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        getStatusText("${member["status"]}"),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: getStatusColor("${member["status"]}"),
                                        ),
                                      ),
                                      Text(
                                        "${member["lastActive"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.business,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                      Text(
                                        "${member["department"]}",
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
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMemberOptionsSheet(Map<String, dynamic> member) {
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${member["role"]}",
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
              _buildActionTile(Icons.person, "View Profile", () {
                back();
              }),
              _buildActionTile(Icons.edit, "Edit Member", () {
                back();
              }),
              _buildActionTile(Icons.security, "Manage Permissions", () {
                back();
                //navigateTo('TpmMemberPermissionsView')
              }),
              _buildActionTile(Icons.group, "Change Role", () {
                back();
                //navigateTo('TpmMemberRolesView')
              }),
              _buildActionTile(Icons.remove_circle, "Remove from Workspace", () {
                back();
                _confirmRemoveMember(member);
              }, isDestructive: true),
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

  void _confirmRemoveMember(Map<String, dynamic> member) async {
    bool isConfirmed = await confirm("Are you sure you want to remove ${member["name"]} from this workspace? This action cannot be undone.");
    if (isConfirmed) {
      members.removeWhere((m) => m["id"] == member["id"]);
      setState(() {});
      ss("Member removed successfully");
    }
  }
}

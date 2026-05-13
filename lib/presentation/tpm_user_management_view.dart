import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmUserManagementView extends StatefulWidget {
  const TpmUserManagementView({super.key});

  @override
  State<TpmUserManagementView> createState() => _TpmUserManagementViewState();
}

class _TpmUserManagementViewState extends State<TpmUserManagementView> {
  String searchQuery = "";
  String selectedRole = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> roleOptions = [
    {"label": "All", "value": "All"},
    {"label": "Admin", "value": "Admin"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Member", "value": "Member"},
    {"label": "Guest", "value": "Guest"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "John Smith",
      "email": "john.smith@company.com",
      "role": "Admin",
      "status": "Active",
      "lastLogin": "2025-06-19 10:30:00",
      "joinDate": "2024-01-15",
      "projects": 12,
      "plan": "Enterprise",
      "avatar": "https://picsum.photos/40/40?random=1",
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "email": "sarah.johnson@startup.io",
      "role": "Manager",
      "status": "Active",
      "lastLogin": "2025-06-19 09:15:00",
      "joinDate": "2024-03-22",
      "projects": 8,
      "plan": "Professional",
      "avatar": "https://picsum.photos/40/40?random=2",
    },
    {
      "id": 3,
      "name": "Mike Wilson",
      "email": "mike.wilson@tech.com",
      "role": "Member",
      "status": "Active",
      "lastLogin": "2025-06-18 16:45:00",
      "joinDate": "2024-05-10",
      "projects": 5,
      "plan": "Professional",
      "avatar": "https://picsum.photos/40/40?random=3",
    },
    {
      "id": 4,
      "name": "Emily Chen",
      "email": "emily.chen@agency.com",
      "role": "Member",
      "status": "Inactive",
      "lastLogin": "2025-06-15 14:20:00",
      "joinDate": "2024-02-28",
      "projects": 3,
      "plan": "Free",
      "avatar": "https://picsum.photos/40/40?random=4",
    },
    {
      "id": 5,
      "name": "David Brown",
      "email": "david.brown@consulting.com",
      "role": "Guest",
      "status": "Pending",
      "lastLogin": null,
      "joinDate": "2025-06-18",
      "projects": 0,
      "plan": "Free",
      "avatar": "https://picsum.photos/40/40?random=5",
    },
    {
      "id": 6,
      "name": "Lisa Rodriguez",
      "email": "lisa.rodriguez@corp.com",
      "role": "Manager",
      "status": "Suspended",
      "lastLogin": "2025-06-10 11:30:00",
      "joinDate": "2024-07-12",
      "projects": 7,
      "plan": "Professional",
      "avatar": "https://picsum.photos/40/40?random=6",
    },
  ];

  Map<String, dynamic> userStats = {
    "totalUsers": 847,
    "activeUsers": 698,
    "newThisMonth": 45,
    "suspendedUsers": 12,
  };

  List<Map<String, dynamic>> get filteredUsers {
    return users.where((user) {
      bool matchesSearch = searchQuery.isEmpty ||
          user["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          user["email"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesRole = selectedRole == "All" || user["role"] == selectedRole;
      bool matchesStatus = selectedStatus == "All" || user["status"] == selectedStatus;
      
      return matchesSearch && matchesRole && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _showAddUserDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildUserStatsGrid(),
            _buildFiltersCard(),
            _buildUsersListCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard(
          title: "Total Users",
          value: "${userStats["totalUsers"]}",
          icon: Icons.people,
          color: primaryColor,
        ),
        _buildStatCard(
          title: "Active Users",
          value: "${userStats["activeUsers"]}",
          icon: Icons.person,
          color: successColor,
        ),
        _buildStatCard(
          title: "New This Month",
          value: "${userStats["newThisMonth"]}",
          icon: Icons.person_add,
          color: infoColor,
        ),
        _buildStatCard(
          title: "Suspended",
          value: "${userStats["suspendedUsers"]}",
          icon: Icons.block,
          color: dangerColor,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Search & Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search users...",
                  value: searchQuery,
                  hint: "Name or email",
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
                  si("Searching users...");
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Role",
                  items: roleOptions,
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
                  label: "Status",
                  items: statusOptions,
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
    );
  }

  Widget _buildUsersListCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "Users List",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${filteredUsers.length} users",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredUsers.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No users found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filteredUsers.map((user) => _buildUserCard(user)),
          ],
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    Color statusColor = _getStatusColor(user["status"]);
    Color roleColor = _getRoleColor(user["role"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${user["avatar"]}"),
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
                            "${user["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${user["email"]}",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: roleColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["role"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: roleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["plan"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.folder,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${user["projects"]} projects",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Joined ${DateTime.parse(user["joinDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (user["lastLogin"] != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.login,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last login: ${DateTime.parse(user["lastLogin"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Icon(
                            Icons.login,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Never logged in",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () => _showEditUserDialog(user),
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () => _showUserActionsDialog(user),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      case "Pending":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "Admin":
        return dangerColor;
      case "Manager":
        return warningColor;
      case "Member":
        return primaryColor;
      case "Guest":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAddUserDialog() {
    String name = "";
    String email = "";
    String role = "Member";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Full Name",
              value: name,
              onChanged: (value) => name = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Email Address",
              value: email,
              onChanged: (value) => email = value,
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Role",
              items: roleOptions.where((option) => option["value"] != "All").toList(),
              value: role,
              onChanged: (value, label) => role = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && email.isNotEmpty) {
                Navigator.pop(context);
                ss("User invitation sent to $email");
              }
            },
            child: Text("Send Invitation"),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit User"),
        content: Text("Edit user details for ${user["name"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("User details updated");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _showUserActionsDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("User Actions"),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              si("Viewing user details for ${user["name"]}");
            },
            child: Row(
              children: [
                Icon(Icons.visibility, size: 20),
                SizedBox(width: spSm),
                Text("View Details"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              if (user["status"] == "Active") {
                sw("User ${user["name"]} suspended");
              } else {
                ss("User ${user["name"]} activated");
              }
            },
            child: Row(
              children: [
                Icon(
                  user["status"] == "Active" ? Icons.block : Icons.check_circle,
                  size: 20,
                  color: user["status"] == "Active" ? dangerColor : successColor,
                ),
                SizedBox(width: spSm),
                Text(user["status"] == "Active" ? "Suspend User" : "Activate User"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              si("Password reset email sent to ${user["email"]}");
            },
            child: Row(
              children: [
                Icon(Icons.lock_reset, size: 20),
                SizedBox(width: spSm),
                Text("Reset Password"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              bool isConfirmed = await confirm("Are you sure you want to delete user ${user["name"]}?");
              if (isConfirmed) {
                users.removeWhere((u) => u["id"] == user["id"]);
                setState(() {});
                ss("User deleted successfully");
              }
            },
            child: Row(
              children: [
                Icon(Icons.delete, size: 20, color: dangerColor),
                SizedBox(width: spSm),
                Text(
                  "Delete User",
                  style: TextStyle(color: dangerColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

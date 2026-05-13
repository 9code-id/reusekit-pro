import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaUserAccessControlView extends StatefulWidget {
  const FmaUserAccessControlView({super.key});

  @override
  State<FmaUserAccessControlView> createState() => _FmaUserAccessControlViewState();
}

class _FmaUserAccessControlViewState extends State<FmaUserAccessControlView> {
  String selectedRole = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> users = [
    {
      "id": "user_001",
      "name": "John Doe",
      "email": "john.doe@company.com",
      "role": "Administrator",
      "department": "IT",
      "status": "Active",
      "lastLogin": "2025-06-19T10:30:00Z",
      "permissions": ["Full Access", "User Management", "System Settings"],
      "avatar": "https://picsum.photos/100/100?random=1"
    },
    {
      "id": "user_002",
      "name": "Jane Smith",
      "email": "jane.smith@company.com",
      "role": "Manager",
      "department": "Operations",
      "status": "Active",
      "lastLogin": "2025-06-19T09:15:00Z",
      "permissions": ["Read Access", "File Management", "Reports"],
      "avatar": "https://picsum.photos/100/100?random=2"
    },
    {
      "id": "user_003",
      "name": "Bob Johnson",
      "email": "bob.johnson@company.com",
      "role": "User",
      "department": "Sales",
      "status": "Inactive",
      "lastLogin": "2025-06-15T14:22:00Z",
      "permissions": ["Read Access"],
      "avatar": "https://picsum.photos/100/100?random=3"
    },
    {
      "id": "user_004",
      "name": "Alice Brown",
      "email": "alice.brown@company.com",
      "role": "Supervisor",
      "department": "HR",
      "status": "Active",
      "lastLogin": "2025-06-19T11:45:00Z",
      "permissions": ["Read Access", "User Management"],
      "avatar": "https://picsum.photos/100/100?random=4"
    }
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": "all"},
    {"label": "Administrator", "value": "Administrator"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Supervisor", "value": "Supervisor"},
    {"label": "User", "value": "User"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"}
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return users.where((user) {
      bool matchesRole = selectedRole == "all" || user["role"] == selectedRole;
      bool matchesStatus = selectedStatus == "all" || user["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (user["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user["email"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesRole && matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Access Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // navigateTo('AddUserView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.people,
                          color: primaryColor,
                          size: 24,
                        ),
                        Text(
                          "Total Users",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${users.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        Text(
                          "Active Users",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${users.where((u) => u["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: warningColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.admin_panel_settings,
                          color: warningColor,
                          size: 24,
                        ),
                        Text(
                          "Admins",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${users.where((u) => u["role"] == "Administrator").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Users",
                          value: searchQuery,
                          hint: "Search by name or email",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Role",
                          items: roleOptions,
                          value: selectedRole,
                          onChanged: (value, label) {
                            selectedRole = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
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
            ),

            // User List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                        "Users (${filteredUsers.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add User",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('AddUserView')
                        },
                      ),
                    ],
                  ),
                  ...filteredUsers.map((user) {
                    Color statusColor = (user["status"] as String) == "Active" 
                        ? successColor 
                        : (user["status"] as String) == "Inactive" 
                            ? warningColor 
                            : dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${user["avatar"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${user["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${user["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                                Row(
                                  children: [
                                    Text(
                                      "${user["role"]} • ${user["department"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Last login: ${DateTime.parse(user["lastLogin"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (user["permissions"] as List).map<Widget>((permission) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(
                                          color: infoColor.withAlpha(50),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "$permission",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            children: [
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('EditUserView', arguments: user)
                                },
                              ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showUserActions(user);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserActions(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "User Actions - ${user["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Edit User",
                  onPressed: () {
                    back();
                    // navigateTo('EditUserView', arguments: user)
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Reset Password",
                  onPressed: () {
                    back();
                    ss("Password reset link sent to ${user["email"]}");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: (user["status"] as String) == "Active" ? "Deactivate User" : "Activate User",
                  onPressed: () {
                    back();
                    String action = (user["status"] as String) == "Active" ? "deactivated" : "activated";
                    ss("User ${user["name"]} has been $action");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Delete User",
                  onPressed: () async {
                    back();
                    bool isConfirmed = await confirm("Are you sure you want to delete ${user["name"]}? This action cannot be undone.");
                    if (isConfirmed) {
                      ss("User ${user["name"]} has been deleted");
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

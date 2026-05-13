import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmUserManagementView extends StatefulWidget {
  const IwmUserManagementView({super.key});

  @override
  State<IwmUserManagementView> createState() => _IwmUserManagementViewState();
}

class _IwmUserManagementViewState extends State<IwmUserManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedRole = "all";
  String selectedStatus = "all";
  String selectedDepartment = "all";
  
  // Form fields for user creation/editing
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userRole = "employee";
  String userDepartment = "warehouse";
  bool userActive = true;
  bool sendWelcomeEmail = true;

  List<Map<String, dynamic>> roleFilterOptions = [
    {"label": "All Roles", "value": "all"},
    {"label": "Administrator", "value": "admin"},
    {"label": "Manager", "value": "manager"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Employee", "value": "employee"},
    {"label": "Viewer", "value": "viewer"},
  ];

  List<Map<String, dynamic>> statusFilterOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Pending", "value": "pending"},
    {"label": "Suspended", "value": "suspended"},
  ];

  List<Map<String, dynamic>> departmentFilterOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Warehouse Operations", "value": "warehouse"},
    {"label": "Receiving", "value": "receiving"},
    {"label": "Shipping", "value": "shipping"},
    {"label": "Quality Control", "value": "qc"},
    {"label": "IT Support", "value": "it"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Employee", "value": "employee"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Manager", "value": "manager"},
    {"label": "Administrator", "value": "admin"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "Warehouse Operations", "value": "warehouse"},
    {"label": "Receiving", "value": "receiving"},
    {"label": "Shipping", "value": "shipping"},
    {"label": "Quality Control", "value": "qc"},
    {"label": "IT Support", "value": "it"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> users = [
    {
      "id": "U001",
      "name": "John Smith",
      "email": "john.smith@warehouse.com",
      "phone": "+1 555-0101",
      "role": "Manager",
      "department": "Warehouse Operations",
      "status": "Active",
      "lastLogin": "2024-01-15 09:30",
      "permissions": ["Read", "Write", "Delete", "Admin"],
      "avatar": "https://picsum.photos/64/64?random=1&keyword=person"
    },
    {
      "id": "U002",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@warehouse.com",
      "phone": "+1 555-0102",
      "role": "Supervisor",
      "department": "Receiving",
      "status": "Active",
      "lastLogin": "2024-01-15 08:45",
      "permissions": ["Read", "Write"],
      "avatar": "https://picsum.photos/64/64?random=2&keyword=person"
    },
    {
      "id": "U003",
      "name": "Michael Chen",
      "email": "michael.chen@warehouse.com",
      "phone": "+1 555-0103",
      "role": "Employee",
      "department": "Shipping",
      "status": "Active",
      "lastLogin": "2024-01-15 07:15",
      "permissions": ["Read"],
      "avatar": "https://picsum.photos/64/64?random=3&keyword=person"
    },
    {
      "id": "U004",
      "name": "Emily Davis",
      "email": "emily.davis@warehouse.com",
      "phone": "+1 555-0104",
      "role": "Administrator",
      "department": "IT Support",
      "status": "Active",
      "lastLogin": "2024-01-15 10:20",
      "permissions": ["Read", "Write", "Delete", "Admin", "System"],
      "avatar": "https://picsum.photos/64/64?random=4&keyword=person"
    },
    {
      "id": "U005",
      "name": "Robert Wilson",
      "email": "robert.wilson@warehouse.com",
      "phone": "+1 555-0105",
      "role": "Employee",
      "department": "Quality Control",
      "status": "Inactive",
      "lastLogin": "2024-01-10 16:30",
      "permissions": ["Read"],
      "avatar": "https://picsum.photos/64/64?random=5&keyword=person"
    },
    {
      "id": "U006",
      "name": "Lisa Anderson",
      "email": "lisa.anderson@warehouse.com",
      "phone": "+1 555-0106",
      "role": "Supervisor",
      "department": "Warehouse Operations",
      "status": "Pending",
      "lastLogin": "Never",
      "permissions": ["Read", "Write"],
      "avatar": "https://picsum.photos/64/64?random=6&keyword=person"
    },
  ];

  List<Map<String, dynamic>> userStats = [
    {
      "title": "Total Users",
      "value": "247",
      "change": "+12",
      "trend": "up",
      "icon": Icons.people,
      "color": primaryColor
    },
    {
      "title": "Active Users",
      "value": "231",
      "change": "+8",
      "trend": "up",
      "icon": Icons.person_add,
      "color": successColor
    },
    {
      "title": "Pending Approval",
      "value": "8",
      "change": "+3",
      "trend": "up",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Inactive Users",
      "value": "8",
      "change": "-2",
      "trend": "down",
      "icon": Icons.person_off,
      "color": dangerColor
    },
  ];

  List<Map<String, dynamic>> bulkActions = [
    {"label": "Activate Selected", "value": "activate", "icon": Icons.check_circle},
    {"label": "Deactivate Selected", "value": "deactivate", "icon": Icons.block},
    {"label": "Delete Selected", "value": "delete", "icon": Icons.delete},
    {"label": "Export Selected", "value": "export", "icon": Icons.download},
    {"label": "Send Email", "value": "email", "icon": Icons.email},
  ];

  Set<String> selectedUsers = {};

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "User Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Users", icon: Icon(Icons.people)),
        Tab(text: "Add User", icon: Icon(Icons.person_add)),
        Tab(text: "Bulk Actions", icon: Icon(Icons.checklist)),
        Tab(text: "Activity Log", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildUsersTab(),
        _buildAddUserTab(),
        _buildBulkActionsTab(),
        _buildActivityLogTab(),
      ],
    );
  }

  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildUserStats(),
          _buildUserFilters(),
          _buildUsersList(),
        ],
      ),
    );
  }

  Widget _buildAddUserTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildUserForm(),
        ],
      ),
    );
  }

  Widget _buildBulkActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBulkActionControls(),
          _buildSelectedUsersList(),
        ],
      ),
    );
  }

  Widget _buildActivityLogTab() {
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

  Widget _buildUserStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: userStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    Color trendColor = stat["trend"] == "up" ? successColor : dangerColor;
    IconData trendIcon = stat["trend"] == "up" ? Icons.trending_up : Icons.trending_down;

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
          Row(
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
                  size: 20,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    trendIcon,
                    color: trendColor,
                    size: 16,
                  ),
                  Text(
                    "${stat["change"]}",
                    style: TextStyle(
                      color: trendColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
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

  Widget _buildUserFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Users",
            value: searchQuery,
            hint: "Search by name, email, or ID...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Role",
                  items: roleFilterOptions,
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
                  items: statusFilterOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentFilterOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
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

  Widget _buildUsersList() {
    return Column(
      spacing: spSm,
      children: users.map((user) => _buildUserCard(user)).toList(),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    Color statusColor = _getStatusColor(user["status"]);
    bool isSelected = selectedUsers.contains(user["id"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedUsers.remove(user["id"]);
                  } else {
                    selectedUsers.add(user["id"]);
                  }
                  setState(() {});
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 14)
                      : null,
                ),
              ),
              SizedBox(width: spSm),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("${user["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 16,
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
                            "${user["status"]}",
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
                      "${user["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${user["role"]} • ${user["department"]}",
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
          Row(
            children: [
              Text(
                "ID: ${user["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Last login: ${user["lastLogin"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Wrap(
                    spacing: spXs,
                    children: (user["permissions"] as List).map((permission) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          permission,
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Row(
                children: [
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserForm() {
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
            "Add New User",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Full Name",
            value: userName,
            hint: "Enter user's full name",
            onChanged: (value) {
              userName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: userEmail,
            hint: "Enter email address",
            onChanged: (value) {
              userEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: userPhone,
            hint: "Enter phone number",
            onChanged: (value) {
              userPhone = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Role",
                  items: roleOptions,
                  value: userRole,
                  onChanged: (value, label) {
                    userRole = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentOptions,
                  value: userDepartment,
                  onChanged: (value, label) {
                    userDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Active User",
                "value": true,
                "checked": userActive,
              }
            ],
            value: [if (userActive) {"label": "Active User", "value": true, "checked": true}],
            onChanged: (values, ids) {
              userActive = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Send Welcome Email",
                "value": true,
                "checked": sendWelcomeEmail,
              }
            ],
            value: [if (sendWelcomeEmail) {"label": "Send Welcome Email", "value": true, "checked": true}],
            onChanged: (values, ids) {
              sendWelcomeEmail = values.isNotEmpty;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    _clearForm();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create User",
                  size: bs.md,
                  onPressed: () {
                    _createUser();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionControls() {
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
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${selectedUsers.length} selected",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (selectedUsers.isNotEmpty)
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: bulkActions.map((action) {
                return QButton(
                  label: "${action["label"]}",
                  icon: action["icon"],
                  size: bs.sm,
                  onPressed: () {
                    _performBulkAction(action["value"]);
                  },
                );
              }).toList(),
            ),
          if (selectedUsers.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Select users from the Users tab to perform bulk actions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedUsersList() {
    List<Map<String, dynamic>> selectedUserData = users
        .where((user) => selectedUsers.contains(user["id"]))
        .toList();

    if (selectedUserData.isEmpty) {
      return Container();
    }

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
            "Selected Users",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...selectedUserData.map((user) => _buildSelectedUserItem(user)),
        ],
      ),
    );
  }

  Widget _buildSelectedUserItem(Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${user["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${user["role"]} • ${user["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedUsers.remove(user["id"]);
              setState(() {});
            },
            child: Icon(
              Icons.close,
              color: dangerColor,
              size: 20,
            ),
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
    List<Map<String, dynamic>> activities = [
      {
        "user": "John Smith",
        "action": "Updated user permissions",
        "target": "Sarah Johnson",
        "timestamp": "2024-01-15 10:30",
        "type": "permission",
        "icon": Icons.security
      },
      {
        "user": "Emily Davis",
        "action": "Created new user",
        "target": "Robert Wilson",
        "timestamp": "2024-01-15 09:15",
        "type": "create",
        "icon": Icons.person_add
      },
      {
        "user": "Sarah Johnson",
        "action": "Deactivated user",
        "target": "Lisa Anderson",
        "timestamp": "2024-01-15 08:45",
        "type": "deactivate",
        "icon": Icons.person_off
      },
      {
        "user": "System",
        "action": "Bulk password reset",
        "target": "15 users",
        "timestamp": "2024-01-14 16:20",
        "type": "system",
        "icon": Icons.lock_reset
      },
    ];

    return Column(
      spacing: spSm,
      children: activities.map((activity) => _buildActivityItem(activity)).toList(),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color typeColor = _getActivityTypeColor(activity["type"]);

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
              activity["icon"],
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
                      "${activity["user"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${activity["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Target: ${activity["target"]}",
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return dangerColor;
      case 'pending':
        return warningColor;
      case 'suspended':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case 'create':
        return successColor;
      case 'deactivate':
        return dangerColor;
      case 'permission':
        return warningColor;
      case 'system':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  void _clearForm() {
    userName = "";
    userEmail = "";
    userPhone = "";
    userRole = "employee";
    userDepartment = "warehouse";
    userActive = true;
    sendWelcomeEmail = true;
    setState(() {});
  }

  void _createUser() {
    if (userName.isEmpty || userEmail.isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    ss("User created successfully");
    _clearForm();
  }

  void _performBulkAction(String action) {
    if (selectedUsers.isEmpty) {
      sw("No users selected");
      return;
    }

    switch (action) {
      case 'activate':
        ss("${selectedUsers.length} users activated");
        break;
      case 'deactivate':
        ss("${selectedUsers.length} users deactivated");
        break;
      case 'delete':
        ss("${selectedUsers.length} users deleted");
        break;
      case 'export':
        ss("User data exported successfully");
        break;
      case 'email':
        ss("Email sent to ${selectedUsers.length} users");
        break;
    }
    
    selectedUsers.clear();
    setState(() {});
  }
}

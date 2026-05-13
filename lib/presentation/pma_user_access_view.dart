import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaUserAccessView extends StatefulWidget {
  const PmaUserAccessView({super.key});

  @override
  State<PmaUserAccessView> createState() => _PmaUserAccessViewState();
}

class _PmaUserAccessViewState extends State<PmaUserAccessView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedRole = "";
  String selectedStatus = "";
  String selectedDepartment = "";
  bool loading = false;

  List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "John Smith",
      "email": "john.smith@company.com",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "role": "Admin",
      "department": "IT",
      "status": "Active",
      "lastLogin": "2024-02-14 09:30:00",
      "permissions": ["project.view", "project.create", "project.delete", "user.manage"],
      "accessLevel": "Full Access",
      "loginCount": 245,
      "failedAttempts": 0,
      "accountCreated": "2023-01-15",
      "lastPasswordChange": "2024-01-20",
      "twoFactorEnabled": true,
      "sessionTimeout": 60
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "role": "Project Manager",
      "department": "Operations",
      "status": "Active",
      "lastLogin": "2024-02-14 08:15:00",
      "permissions": ["project.view", "project.create", "task.assign"],
      "accessLevel": "Project Access",
      "loginCount": 189,
      "failedAttempts": 1,
      "accountCreated": "2023-03-10",
      "lastPasswordChange": "2024-02-01",
      "twoFactorEnabled": true,
      "sessionTimeout": 45
    },
    {
      "id": 3,
      "name": "Mike Davis",
      "email": "mike.davis@company.com",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "role": "Team Lead",
      "department": "Development",
      "status": "Active",
      "lastLogin": "2024-02-13 17:45:00",
      "permissions": ["project.view", "task.view", "task.assign"],
      "accessLevel": "Team Access",
      "loginCount": 156,
      "failedAttempts": 0,
      "accountCreated": "2023-05-22",
      "lastPasswordChange": "2024-01-15",
      "twoFactorEnabled": false,
      "sessionTimeout": 30
    },
    {
      "id": 4,
      "name": "Emily Chen",
      "email": "emily.chen@company.com",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "role": "Developer",
      "department": "Development",
      "status": "Inactive",
      "lastLogin": "2024-02-10 14:20:00",
      "permissions": ["project.view", "task.view"],
      "accessLevel": "Limited Access",
      "loginCount": 98,
      "failedAttempts": 3,
      "accountCreated": "2023-08-14",
      "lastPasswordChange": "2023-12-20",
      "twoFactorEnabled": false,
      "sessionTimeout": 30
    },
    {
      "id": 5,
      "name": "Robert Wilson",
      "email": "robert.wilson@company.com",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "role": "Finance Manager",
      "department": "Finance",
      "status": "Active",
      "lastLogin": "2024-02-14 10:00:00",
      "permissions": ["report.financial", "project.view"],
      "accessLevel": "Financial Access",
      "loginCount": 134,
      "failedAttempts": 0,
      "accountCreated": "2023-02-28",
      "lastPasswordChange": "2024-01-25",
      "twoFactorEnabled": true,
      "sessionTimeout": 60
    },
    {
      "id": 6,
      "name": "Lisa Anderson",
      "email": "lisa.anderson@company.com",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
      "role": "HR Manager",
      "department": "Human Resources",
      "status": "Locked",
      "lastLogin": "2024-02-12 16:30:00",
      "permissions": ["user.manage", "project.view"],
      "accessLevel": "HR Access",
      "loginCount": 87,
      "failedAttempts": 5,
      "accountCreated": "2023-04-05",
      "lastPasswordChange": "2023-11-10",
      "twoFactorEnabled": false,
      "sessionTimeout": 45
    }
  ];

  List<String> roles = ["Admin", "Project Manager", "Team Lead", "Developer", "Finance Manager", "HR Manager"];
  List<String> departments = ["IT", "Operations", "Development", "Finance", "Human Resources"];
  List<String> statuses = ["Active", "Inactive", "Locked"];

  List<Map<String, dynamic>> get filteredUsers {
    return users.where((user) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${user["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${user["email"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesRole = selectedRole.isEmpty || "${user["role"]}" == selectedRole;
      bool matchesStatus = selectedStatus.isEmpty || "${user["status"]}" == selectedStatus;
      bool matchesDepartment = selectedDepartment.isEmpty || "${user["department"]}" == selectedDepartment;

      return matchesSearch && matchesRole && matchesStatus && matchesDepartment;
    }).toList();
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    Color statusColor = "${user["status"]}" == "Active"
        ? successColor
        : "${user["status"]}" == "Inactive"
            ? warningColor
            : dangerColor;

    String accessLevel = "${user["accessLevel"]}";
    bool hasHighRisk = (user["failedAttempts"] as int) > 2 || !user["twoFactorEnabled"];

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: hasHighRisk
            ? Border.all(color: dangerColor.withAlpha(50), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
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
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs / 2),
                    Text(
                      "${user["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs / 2),
                    Row(
                      children: [
                        Text(
                          "${user["role"]} • ${user["department"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (hasHighRisk) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.warning,
                            size: 14,
                            color: dangerColor,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.security, size: 14, color: infoColor),
                SizedBox(width: spXs / 2),
                Text(
                  accessLevel,
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "${(user["permissions"] as List).length} permissions",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.login, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs / 2),
                    Text(
                      "Last: ${DateTime.parse("${user["lastLogin"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (user["twoFactorEnabled"] as bool)
                    Icon(Icons.verified_user, size: 14, color: successColor)
                  else
                    Icon(Icons.security, size: 14, color: disabledColor),
                  SizedBox(width: spXs / 2),
                  Text(
                    "2FA: ${user["twoFactorEnabled"] ? "On" : "Off"}",
                    style: TextStyle(
                      fontSize: 11,
                      color: user["twoFactorEnabled"] ? successColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if ((user["failedAttempts"] as int) > 0) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, size: 12, color: dangerColor),
                  SizedBox(width: spXs / 2),
                  Text(
                    "${user["failedAttempts"]} failed login attempts",
                    style: TextStyle(
                      fontSize: 10,
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showUserDetailsDialog(user);
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showEditAccessDialog(user);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: "${user["status"]}" == "Active" ? Icons.block : Icons.check_circle,
                size: bs.sm,
                onPressed: () {
                  _toggleUserStatus(user);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    int totalUsers = users.length;
    int activeUsers = users.where((u) => "${u["status"]}" == "Active").length;
    int lockedUsers = users.where((u) => "${u["status"]}" == "Locked").length;
    int usersWithoutTwoFA = users.where((u) => !(u["twoFactorEnabled"] as bool)).length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatsCard("Total Users", "$totalUsers", Icons.people, primaryColor),
              _buildStatsCard("Active Users", "$activeUsers", Icons.check_circle, successColor),
              _buildStatsCard("Locked Accounts", "$lockedUsers", Icons.lock, dangerColor),
              _buildStatsCard("Without 2FA", "$usersWithoutTwoFA", Icons.security, warningColor),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Access Overview by Department",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: departments.map((dept) {
                int deptUsers = users.where((u) => "${u["department"]}" == dept).length;
                int activeDeptUsers = users.where((u) => "${u["department"]}" == dept && "${u["status"]}" == "Active").length;
                double percentage = deptUsers > 0 ? (activeDeptUsers / deptUsers) * 100 : 0;

                return Container(
                  padding: EdgeInsets.symmetric(vertical: spXs),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: dept != departments.last ? disabledOutlineBorderColor : Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dept,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "$activeDeptUsers of $deptUsers users active",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                        decoration: BoxDecoration(
                          color: percentage >= 80 
                              ? successColor.withAlpha(20)
                              : percentage >= 60 
                                  ? warningColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${percentage.toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: percentage >= 80 
                                ? successColor
                                : percentage >= 60 
                                    ? warningColor
                                    : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spLg),
          Text(
            "Security Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High Risk Accounts",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${users.where((u) => (u["failedAttempts"] as int) > 2).length} accounts with multiple failed attempts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Review",
                      size: bs.sm,
                      onPressed: () {
                        selectedStatus = "Locked";
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.security, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Two-Factor Authentication",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "$usersWithoutTwoFA users haven't enabled 2FA",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Notify",
                      size: bs.sm,
                      onPressed: () {
                        ss("2FA reminder sent to users");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search users...",
                      value: searchQuery,
                      hint: "Search by name or email",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      _showCreateUserDialog();
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Role",
                      items: [
                        {"label": "All Roles", "value": ""},
                        ...roles.map((role) => {"label": role, "value": role}),
                      ],
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
                      items: [
                        {"label": "All Status", "value": ""},
                        ...statuses.map((status) => {"label": status, "value": status}),
                      ],
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
          child: loading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: filteredUsers.isEmpty
                        ? [
                            SizedBox(height: 100),
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: disabledColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No users found",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ]
                        : filteredUsers.map((user) => _buildUserCard(user)).toList(),
                  ),
                ),
        ),
      ],
    );
  }

  void _showUserDetailsDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "User Access Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
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
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${user["email"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${user["role"]} • ${user["department"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spLg),
                Text(
                  "Account Information",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Status", "${user["status"]}", Icons.info),
                _buildDetailRow("Access Level", "${user["accessLevel"]}", Icons.security),
                _buildDetailRow("Login Count", "${user["loginCount"]}", Icons.login),
                _buildDetailRow("Failed Attempts", "${user["failedAttempts"]}", Icons.error),
                _buildDetailRow("Session Timeout", "${user["sessionTimeout"]} min", Icons.timer),
                _buildDetailRow("2FA Enabled", user["twoFactorEnabled"] ? "Yes" : "No", Icons.verified_user),
                SizedBox(height: spSm),
                Text(
                  "Permissions",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (user["permissions"] as List).map((permission) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$permission",
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs / 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spXs),
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAccessDialog(Map<String, dynamic> user) {
    String selectedUserRole = "${user["role"]}";
    String userDepartment = "${user["department"]}";
    int sessionTimeout = user["sessionTimeout"] as int;
    bool twoFactorEnabled = user["twoFactorEnabled"] as bool;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            "Edit User Access",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QDropdownField(
                    label: "Role",
                    items: roles.map((role) => {"label": role, "value": role}).toList(),
                    value: selectedUserRole,
                    onChanged: (value, label) {
                      selectedUserRole = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Department",
                    items: departments.map((dept) => {"label": dept, "value": dept}).toList(),
                    value: userDepartment,
                    onChanged: (value, label) {
                      userDepartment = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QNumberField(
                    label: "Session Timeout (minutes)",
                    value: sessionTimeout.toString(),
                    onChanged: (value) {
                      sessionTimeout = int.tryParse(value) ?? 30;
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Two-Factor Authentication",
                        "value": true,
                        "checked": twoFactorEnabled,
                      }
                    ],
                    value: [if (twoFactorEnabled) {"label": "Enable Two-Factor Authentication", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      twoFactorEnabled = values.isNotEmpty;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Update",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("User access updated successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateUserDialog() {
    String name = "";
    String email = "";
    String selectedUserRole = roles.first;
    String userDepartment = departments.first;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            "Create New User",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QTextField(
                    label: "Full Name",
                    value: name,
                    hint: "Enter user's full name",
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter user's email address",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Role",
                    items: roles.map((role) => {"label": role, "value": role}).toList(),
                    value: selectedUserRole,
                    onChanged: (value, label) {
                      selectedUserRole = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Department",
                    items: departments.map((dept) => {"label": dept, "value": dept}).toList(),
                    value: userDepartment,
                    onChanged: (value, label) {
                      userDepartment = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
            ),
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
                if (name.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(context);
                  ss("User created successfully");
                } else {
                  se("Please fill all required fields");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleUserStatus(Map<String, dynamic> user) async {
    String currentStatus = "${user["status"]}";
    String newStatus = currentStatus == "Active" ? "Inactive" : "Active";
    String action = newStatus == "Active" ? "activate" : "deactivate";

    bool isConfirmed = await confirm("Are you sure you want to $action ${user["name"]}?");
    if (isConfirmed) {
      user["status"] = newStatus;
      setState(() {});
      ss("User ${action}d successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "User Access Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Users", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildUsersTab(),
      ],
    );
  }
}

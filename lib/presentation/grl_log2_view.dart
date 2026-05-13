import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog2View extends StatefulWidget {
  @override
  State<GrlLog2View> createState() => _GrlLog2ViewState();
}

class _GrlLog2ViewState extends State<GrlLog2View> {
  String searchQuery = "";
  String selectedAction = "All";
  String selectedUserType = "All";

  List<Map<String, dynamic>> auditLogs = [
    {
      "auditId": "AUD-001",
      "timestamp": "2024-12-20 16:45:32",
      "userId": "USR-12345",
      "username": "john.smith@company.com",
      "userType": "Admin",
      "action": "User Created",
      "resource": "User Management",
      "resourceId": "USR-67890",
      "ipAddress": "192.168.1.105",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
      "sessionId": "SES-789012",
      "status": "Success",
      "details": "Created new user account for sarah.johnson@company.com",
      "changes": {
        "before": null,
        "after": {
          "username": "sarah.johnson@company.com",
          "role": "Employee",
          "department": "Marketing"
        }
      },
    },
    {
      "auditId": "AUD-002",
      "timestamp": "2024-12-20 16:30:15",
      "userId": "USR-54321",
      "username": "mike.wilson@company.com",
      "userType": "Manager",
      "action": "Password Changed",
      "resource": "User Profile",
      "resourceId": "USR-54321",
      "ipAddress": "192.168.1.102",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
      "sessionId": "SES-789013",
      "status": "Success",
      "details": "User changed their password successfully",
      "changes": {
        "before": {"password": "***"},
        "after": {"password": "***", "lastPasswordChange": "2024-12-20 16:30:15"}
      },
    },
    {
      "auditId": "AUD-003",
      "timestamp": "2024-12-20 16:15:28",
      "userId": "USR-98765",
      "username": "lisa.chen@company.com",
      "userType": "Employee",
      "action": "Data Export",
      "resource": "Customer Database",
      "resourceId": "DB-CUSTOMERS",
      "ipAddress": "192.168.1.108",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0",
      "sessionId": "SES-789014",
      "status": "Success",
      "details": "Exported customer list (250 records) to CSV format",
      "changes": {
        "before": null,
        "after": {"exportType": "CSV", "recordCount": 250, "fileName": "customers_20241220.csv"}
      },
    },
    {
      "auditId": "AUD-004",
      "timestamp": "2024-12-20 16:00:45",
      "userId": "USR-11111",
      "username": "hacker@external.com",
      "userType": "Unknown",
      "action": "Unauthorized Access",
      "resource": "Admin Panel",
      "resourceId": "ADMIN-PANEL",
      "ipAddress": "203.45.67.89",
      "userAgent": "curl/7.68.0",
      "sessionId": "",
      "status": "Failed",
      "details": "Attempted to access admin panel without proper authentication",
      "changes": {
        "before": null,
        "after": null
      },
    },
    {
      "auditId": "AUD-005",
      "timestamp": "2024-12-20 15:45:12",
      "userId": "USR-22222",
      "username": "david.brown@company.com",
      "userType": "Admin",
      "action": "Settings Modified",
      "resource": "System Configuration",
      "resourceId": "CFG-SECURITY",
      "ipAddress": "192.168.1.110",
      "userAgent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
      "sessionId": "SES-789015",
      "status": "Success",
      "details": "Updated security settings - enabled two-factor authentication",
      "changes": {
        "before": {"twoFactorAuth": false, "sessionTimeout": 3600},
        "after": {"twoFactorAuth": true, "sessionTimeout": 7200}
      },
    },
  ];

  List<Map<String, dynamic>> get filteredAuditLogs {
    return auditLogs.where((log) {
      final matchesSearch = log["username"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["action"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["resource"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["auditId"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesAction = selectedAction == "All" || log["action"] == selectedAction;
      final matchesUserType = selectedUserType == "All" || log["userType"] == selectedUserType;
      return matchesSearch && matchesAction && matchesUserType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildAuditStats(),
            _buildAuditLogList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search audit logs",
                value: searchQuery,
                hint: "Search by user, action, resource...",
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
                label: "Action Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "User Created", "value": "User Created"},
                  {"label": "Password Changed", "value": "Password Changed"},
                  {"label": "Data Export", "value": "Data Export"},
                  {"label": "Unauthorized Access", "value": "Unauthorized Access"},
                  {"label": "Settings Modified", "value": "Settings Modified"},
                ],
                value: selectedAction,
                onChanged: (value, label) {
                  selectedAction = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "User Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Admin", "value": "Admin"},
                  {"label": "Manager", "value": "Manager"},
                  {"label": "Employee", "value": "Employee"},
                  {"label": "Unknown", "value": "Unknown"},
                ],
                value: selectedUserType,
                onChanged: (value, label) {
                  selectedUserType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuditStats() {
    final successCount = auditLogs.where((log) => log["status"] == "Success").length;
    final failedCount = auditLogs.where((log) => log["status"] == "Failed").length;
    final adminActions = auditLogs.where((log) => log["userType"] == "Admin").length;
    final securityEvents = auditLogs.where((log) => 
        log["action"] == "Unauthorized Access" || 
        log["action"] == "Password Changed" ||
        log["action"] == "Settings Modified").length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Success",
            successCount.toString(),
            Icons.check_circle,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Failed",
            failedCount.toString(),
            Icons.error,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Admin Actions",
            adminActions.toString(),
            Icons.admin_panel_settings,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Security Events",
            securityEvents.toString(),
            Icons.security,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLogList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Audit Logs (${filteredAuditLogs.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredAuditLogs.length,
          itemBuilder: (context, index) {
            final log = filteredAuditLogs[index];
            return _buildAuditLogCard(log);
          },
        ),
      ],
    );
  }

  Widget _buildAuditLogCard(Map<String, dynamic> log) {
    final isSuccess = log["status"] == "Success";
    final changes = log["changes"] as Map<String, dynamic>;
    final hasChanges = changes["before"] != null || changes["after"] != null;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getUserTypeColor(log["userType"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${log["auditId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${log["timestamp"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getUserTypeColor(log["userType"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${log["userType"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getUserTypeColor(log["userType"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSuccess ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${log["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSuccess ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${log["username"]} (${log["userId"]})",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getActionColor(log["action"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["action"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _getActionColor(log["action"]),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Resource: ${log["resource"]} (${log["resourceId"]})",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                if (log["details"].toString().isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${log["details"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.computer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "IP: ${log["ipAddress"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              if (log["sessionId"].toString().isNotEmpty) ...[
                SizedBox(width: spSm),
                Icon(
                  Icons.fingerprint,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Session: ${log["sessionId"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          if (hasChanges) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.change_history,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Changes Made",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  if (changes["before"] != null) ...[
                    Text(
                      "Before: ${changes["before"].toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        color: dangerColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                  if (changes["after"] != null) ...[
                    Text(
                      "After: ${changes["after"].toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          Row(
            children: [
              Text(
                "${log["userAgent"].toString().substring(0, log["userAgent"].toString().length > 30 ? 30 : log["userAgent"].toString().length)}...",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getUserTypeColor(String userType) {
    switch (userType) {
      case "Admin":
        return dangerColor;
      case "Manager":
        return warningColor;
      case "Employee":
        return infoColor;
      case "Unknown":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "Unauthorized Access":
        return dangerColor;
      case "Settings Modified":
      case "Password Changed":
        return warningColor;
      case "Data Export":
        return infoColor;
      case "User Created":
        return successColor;
      default:
        return primaryColor;
    }
  }
}

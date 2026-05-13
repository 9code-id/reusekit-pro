import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmAuditLogsView extends StatefulWidget {
  const TpmAuditLogsView({super.key});

  @override
  State<TpmAuditLogsView> createState() => _TpmAuditLogsViewState();
}

class _TpmAuditLogsViewState extends State<TpmAuditLogsView> {
  String selectedTimeRange = "last_7_days";
  String selectedLogLevel = "all";
  String selectedCategory = "all";
  String selectedUser = "all";
  String searchQuery = "";
  bool showAdvancedFilters = false;

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 24 Hours", "value": "last_24_hours"},
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 90 Days", "value": "last_90_days"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> logLevelOptions = [
    {"label": "All Levels", "value": "all"},
    {"label": "Info", "value": "info"},
    {"label": "Warning", "value": "warning"},
    {"label": "Error", "value": "error"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Authentication", "value": "auth"},
    {"label": "Data Access", "value": "data_access"},
    {"label": "System Changes", "value": "system"},
    {"label": "User Management", "value": "user_mgmt"},
    {"label": "Security", "value": "security"},
    {"label": "API Calls", "value": "api"},
  ];

  List<Map<String, dynamic>> userOptions = [
    {"label": "All Users", "value": "all"},
    {"label": "Admin Users", "value": "admin"},
    {"label": "Regular Users", "value": "regular"},
    {"label": "System", "value": "system"},
  ];

  List<Map<String, dynamic>> auditLogs = [
    {
      "id": "audit_001",
      "timestamp": "2024-01-15 14:30:25",
      "user": "john.doe@company.com",
      "action": "User Login",
      "category": "auth",
      "level": "info",
      "ip_address": "192.168.1.100",
      "details": "Successful login from Chrome browser",
      "resource": "Authentication System",
      "result": "Success"
    },
    {
      "id": "audit_002",
      "timestamp": "2024-01-15 14:25:12",
      "user": "admin@company.com",
      "action": "Project Created",
      "category": "data_access",
      "level": "info",
      "ip_address": "192.168.1.50",
      "details": "Created project 'Mobile App Development'",
      "resource": "Project Management",
      "result": "Success"
    },
    {
      "id": "audit_003",
      "timestamp": "2024-01-15 14:20:45",
      "user": "system",
      "action": "Database Backup",
      "category": "system",
      "level": "info",
      "ip_address": "localhost",
      "details": "Automated daily backup completed",
      "resource": "Database System",
      "result": "Success"
    },
    {
      "id": "audit_004",
      "timestamp": "2024-01-15 14:15:33",
      "user": "jane.smith@company.com",
      "action": "Failed Login Attempt",
      "category": "security",
      "level": "warning",
      "ip_address": "203.0.113.45",
      "details": "Invalid password entered 3 times",
      "resource": "Authentication System",
      "result": "Failed"
    },
    {
      "id": "audit_005",
      "timestamp": "2024-01-15 14:10:18",
      "user": "admin@company.com",
      "action": "User Role Modified",
      "category": "user_mgmt",
      "level": "warning",
      "ip_address": "192.168.1.50",
      "details": "Changed role for user 'bob.wilson@company.com' from User to Admin",
      "resource": "User Management",
      "result": "Success"
    },
    {
      "id": "audit_006",
      "timestamp": "2024-01-15 14:05:22",
      "user": "api_service",
      "action": "Data Export",
      "category": "api",
      "level": "info",
      "ip_address": "192.168.1.200",
      "details": "Exported 500 user records via API",
      "resource": "Data Export API",
      "result": "Success"
    },
    {
      "id": "audit_007",
      "timestamp": "2024-01-15 14:00:15",
      "user": "system",
      "action": "Security Scan",
      "category": "security",
      "level": "error",
      "ip_address": "localhost",
      "details": "Detected 3 potential security vulnerabilities",
      "resource": "Security Scanner",
      "result": "Alert"
    },
    {
      "id": "audit_008",
      "timestamp": "2024-01-15 13:55:30",
      "user": "mike.johnson@company.com",
      "action": "File Deleted",
      "category": "data_access",
      "level": "warning",
      "ip_address": "192.168.1.75",
      "details": "Permanently deleted file 'project_docs.pdf'",
      "resource": "File System",
      "result": "Success"
    }
  ];

  List<Map<String, dynamic>> get filteredLogs {
    return auditLogs.where((log) {
      bool matchesSearch = searchQuery.isEmpty ||
          log["action"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["user"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["details"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesLevel = selectedLogLevel == "all" || log["level"] == selectedLogLevel;
      bool matchesCategory = selectedCategory == "all" || log["category"] == selectedCategory;
      bool matchesUser = selectedUser == "all" || 
          (selectedUser == "admin" && log["user"].toString().contains("admin")) ||
          (selectedUser == "system" && log["user"] == "system") ||
          (selectedUser == "regular" && !log["user"].toString().contains("admin") && log["user"] != "system");

      return matchesSearch && matchesLevel && matchesCategory && matchesUser;
    }).toList();
  }

  Color _getLogLevelColor(String level) {
    switch (level) {
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "error":
        return dangerColor;
      case "critical":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getLogLevelIcon(String level) {
    switch (level) {
      case "info":
        return Icons.info;
      case "warning":
        return Icons.warning;
      case "error":
        return Icons.error;
      case "critical":
        return Icons.dangerous;
      default:
        return Icons.circle;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "auth":
        return primaryColor;
      case "data_access":
        return infoColor;
      case "system":
        return successColor;
      case "user_mgmt":
        return warningColor;
      case "security":
        return dangerColor;
      case "api":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _exportLogs() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Audit logs exported successfully");
  }

  void _viewLogDetails(Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Audit Log Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Log ID", "${log["id"]}"),
              _buildDetailRow("Timestamp", "${log["timestamp"]}"),
              _buildDetailRow("User", "${log["user"]}"),
              _buildDetailRow("Action", "${log["action"]}"),
              _buildDetailRow("Category", "${log["category"]}"),
              _buildDetailRow("Level", "${log["level"]}"),
              _buildDetailRow("IP Address", "${log["ip_address"]}"),
              _buildDetailRow("Resource", "${log["resource"]}"),
              _buildDetailRow("Result", "${log["result"]}"),
              _buildDetailRow("Details", "${log["details"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportLogs,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search logs...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: showAdvancedFilters ? Icons.expand_less : Icons.expand_more,
                        size: bs.sm,
                        onPressed: () {
                          showAdvancedFilters = !showAdvancedFilters;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  if (showAdvancedFilters) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Time Range",
                            items: timeRangeOptions,
                            value: selectedTimeRange,
                            onChanged: (value, label) {
                              selectedTimeRange = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Log Level",
                            items: logLevelOptions,
                            value: selectedLogLevel,
                            onChanged: (value, label) {
                              selectedLogLevel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categoryOptions,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "User Type",
                            items: userOptions,
                            value: selectedUser,
                            onChanged: (value, label) {
                              selectedUser = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Showing ${filteredLogs.length} of ${auditLogs.length} audit logs",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Audit Logs List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Audit Trail",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (filteredLogs.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No audit logs found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search criteria or filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredLogs.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final log = filteredLogs[index];
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              // Level Indicator
                              Container(
                                width: 4,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: _getLogLevelColor("${log["level"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Level Icon
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _getLogLevelColor("${log["level"]}").withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getLogLevelIcon("${log["level"]}"),
                                  color: _getLogLevelColor("${log["level"]}"),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Log Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${log["action"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getCategoryColor("${log["category"]}").withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${log["category"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: _getCategoryColor("${log["category"]}"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${log["user"]} • ${log["timestamp"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${log["details"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Action Button
                              QButton(
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () => _viewLogDetails(log),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                Container(
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
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Info",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${auditLogs.where((log) => log["level"] == "info").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Warnings",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${auditLogs.where((log) => log["level"] == "warning").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.error,
                            color: dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Errors",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${auditLogs.where((log) => log["level"] == "error").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.analytics,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Logs",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${auditLogs.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

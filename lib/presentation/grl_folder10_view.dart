import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder10View extends StatefulWidget {
  @override
  State<GrlFolder10View> createState() => _GrlFolder10ViewState();
}

class _GrlFolder10ViewState extends State<GrlFolder10View> {
  String searchQuery = "";
  String selectedTimeframe = "Last 7 Days";
  bool showSystemActions = false;

  List<Map<String, dynamic>> auditLogs = [
    {
      "id": 1,
      "action": "File Created",
      "userName": "John Smith",
      "userEmail": "john@company.com",
      "resourceName": "project_proposal.pdf",
      "resourceType": "File",
      "resourcePath": "/Documents/Projects/",
      "timestamp": "2024-01-17 14:30:25",
      "ipAddress": "192.168.1.100",
      "deviceInfo": "Chrome on Windows",
      "actionType": "create",
      "success": true,
      "isSystemAction": false,
      "details": "Created new PDF document",
    },
    {
      "id": 2,
      "action": "Permission Granted",
      "userName": "Sarah Wilson",
      "userEmail": "sarah@company.com",
      "resourceName": "Marketing Folder",
      "resourceType": "Folder",
      "resourcePath": "/Marketing/",
      "timestamp": "2024-01-17 13:45:12",
      "ipAddress": "192.168.1.105",
      "deviceInfo": "Safari on MacOS",
      "actionType": "permission",
      "success": true,
      "isSystemAction": false,
      "details": "Granted Editor permission to Sarah Wilson",
    },
    {
      "id": 3,
      "action": "File Downloaded",
      "userName": "Mike Johnson",
      "userEmail": "mike@company.com",
      "resourceName": "budget_report.xlsx",
      "resourceType": "File",
      "resourcePath": "/Documents/Finance/",
      "timestamp": "2024-01-17 12:15:30",
      "ipAddress": "192.168.1.89",
      "deviceInfo": "Edge on Windows",
      "actionType": "download",
      "success": true,
      "isSystemAction": false,
      "details": "Downloaded file to local device",
    },
    {
      "id": 4,
      "action": "Auto Backup",
      "userName": "System",
      "userEmail": "system@company.com",
      "resourceName": "All Documents",
      "resourceType": "System",
      "resourcePath": "/",
      "timestamp": "2024-01-17 02:00:00",
      "ipAddress": "127.0.0.1",
      "deviceInfo": "System Process",
      "actionType": "backup",
      "success": true,
      "isSystemAction": true,
      "details": "Automated daily backup completed",
    },
    {
      "id": 5,
      "action": "File Deleted",
      "userName": "Lisa Garcia",
      "userEmail": "lisa@company.com",
      "resourceName": "old_template.docx",
      "resourceType": "File",
      "resourcePath": "/Documents/Templates/",
      "timestamp": "2024-01-16 16:20:45",
      "ipAddress": "192.168.1.112",
      "deviceInfo": "Firefox on Linux",
      "actionType": "delete",
      "success": true,
      "isSystemAction": false,
      "details": "Moved file to trash",
    },
    {
      "id": 6,
      "action": "Login Failed",
      "userName": "Unknown",
      "userEmail": "unknown@external.com",
      "resourceName": "System Access",
      "resourceType": "System",
      "resourcePath": "/",
      "timestamp": "2024-01-16 15:30:12",
      "ipAddress": "203.45.67.89",
      "deviceInfo": "Chrome on Unknown",
      "actionType": "login",
      "success": false,
      "isSystemAction": false,
      "details": "Failed login attempt - Invalid credentials",
    },
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  Color getActionTypeColor(String actionType) {
    switch (actionType.toLowerCase()) {
      case 'create':
        return successColor;
      case 'download':
        return primaryColor;
      case 'delete':
        return dangerColor;
      case 'permission':
        return warningColor;
      case 'backup':
        return infoColor;
      case 'login':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getActionTypeIcon(String actionType) {
    switch (actionType.toLowerCase()) {
      case 'create':
        return Icons.add_circle;
      case 'download':
        return Icons.download;
      case 'delete':
        return Icons.delete;
      case 'permission':
        return Icons.security;
      case 'backup':
        return Icons.backup;
      case 'login':
        return Icons.login;
      default:
        return Icons.info;
    }
  }

  List<Map<String, dynamic>> get filteredLogs {
    return auditLogs.where((log) {
      bool matchesSearch = log["action"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["userName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["resourceName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSystem = showSystemActions || !(log["isSystemAction"] as bool);
      return matchesSearch && matchesSystem;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Log"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search audit logs",
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Include System Actions",
                        "value": true,
                        "checked": showSystemActions,
                      }
                    ],
                    value: [if (showSystemActions) {"label": "Include System Actions", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showSystemActions = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Audit Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Activity Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${auditLogs.where((log) => log["success"] == true).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Successful",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${auditLogs.where((log) => log["success"] == false).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Failed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${auditLogs.where((log) => log["isSystemAction"] == true).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "System",
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
                ],
              ),
            ),

            // Action Type Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Action Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: ['create', 'download', 'delete', 'permission', 'backup', 'login'].map((actionType) {
                      int count = auditLogs.where((log) => log["actionType"] == actionType).length;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: getActionTypeColor(actionType).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  getActionTypeIcon(actionType),
                                  color: getActionTypeColor(actionType),
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  actionType.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: getActionTypeColor(actionType),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$count",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: getActionTypeColor(actionType),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Export Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Export Logs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Download filtered audit logs for compliance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Export CSV",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Audit Logs List
            Text(
              "Activity Log (${filteredLogs.length} entries)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredLogs.map((log) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: log["success"] == false 
                      ? Border.all(color: dangerColor.withAlpha(50), width: 1)
                      : log["isSystemAction"] == true
                          ? Border.all(color: infoColor.withAlpha(50), width: 1)
                          : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Action Header
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getActionTypeColor("${log["actionType"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            getActionTypeIcon("${log["actionType"]}"),
                            color: getActionTypeColor("${log["actionType"]}"),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
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
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: log["success"] == true 
                                          ? successColor.withAlpha(30) 
                                          : dangerColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      log["success"] == true ? "SUCCESS" : "FAILED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: log["success"] == true ? successColor : dangerColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${log["timestamp"]}",
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

                    // User Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${log["userName"]} (${log["userEmail"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (log["isSystemAction"] == true)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "SYSTEM",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: infoColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.devices, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${log["deviceInfo"]} • ${log["ipAddress"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Resource Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                log["resourceType"] == "Folder" ? Icons.folder : 
                                log["resourceType"] == "System" ? Icons.settings : Icons.insert_drive_file,
                                color: primaryColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${log["resourceName"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.folder_outlined, color: primaryColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${log["resourcePath"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Details
                    if (log["details"] != null && log["details"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${log["details"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Action Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        QButton(
                          label: "View Details",
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
            if (filteredLogs.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.assignment, color: disabledColor, size: 64),
                    SizedBox(height: spMd),
                    Text(
                      "No Logs Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No audit logs match your current filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive7View extends StatefulWidget {
  @override
  State<GrlArchive7View> createState() => _GrlArchive7ViewState();
}

class _GrlArchive7ViewState extends State<GrlArchive7View> {
  String searchQuery = "";
  String selectedDateRange = "All Time";
  String selectedAction = "All Actions";
  String selectedUser = "All Users";

  List<Map<String, dynamic>> auditLogs = [
    {
      "id": "LOG-001",
      "timestamp": "2024-12-15 14:30:25",
      "user": "Sarah Johnson",
      "userRole": "Manager",
      "action": "Archive File",
      "target": "Annual Financial Report 2024.pdf",
      "category": "Financial",
      "status": "Success",
      "ipAddress": "192.168.1.45",
      "details": "File archived to Financial/2024 folder",
      "severity": "Low",
      "source": "Web Portal",
    },
    {
      "id": "LOG-002",
      "timestamp": "2024-12-15 13:15:10",
      "user": "Mike Wilson",
      "userRole": "Admin",
      "action": "Bulk Delete",
      "target": "Old Marketing Materials (15 files)",
      "category": "Marketing",
      "status": "Success",
      "ipAddress": "192.168.1.32",
      "details": "Permanently deleted 15 files from Marketing/Archive folder",
      "severity": "Medium",
      "source": "Admin Panel",
    },
    {
      "id": "LOG-003",
      "timestamp": "2024-12-15 12:45:33",
      "user": "Emma Davis",
      "userRole": "Editor",
      "action": "Restore File",
      "target": "Project Alpha Documentation.zip",
      "category": "Technical",
      "status": "Success",
      "ipAddress": "192.168.1.78",
      "details": "File restored from archive to active workspace",
      "severity": "Low",
      "source": "Desktop App",
    },
    {
      "id": "LOG-004",
      "timestamp": "2024-12-15 11:20:15",
      "user": "Robert Lee",
      "userRole": "User",
      "action": "Download File",
      "target": "Legal Contract Template.docx",
      "category": "Legal",
      "status": "Success",
      "ipAddress": "192.168.1.91",
      "details": "File downloaded successfully",
      "severity": "Low",
      "source": "Mobile App",
    },
    {
      "id": "LOG-005",
      "timestamp": "2024-12-15 10:55:42",
      "user": "Lisa Chen",
      "userRole": "Manager",
      "action": "Access Denied",
      "target": "Confidential HR Records.pdf",
      "category": "HR",
      "status": "Failed",
      "ipAddress": "192.168.1.156",
      "details": "User attempted to access restricted file without permission",
      "severity": "High",
      "source": "Web Portal",
    },
    {
      "id": "LOG-006",
      "timestamp": "2024-12-15 09:30:18",
      "user": "John Smith",
      "userRole": "Admin",
      "action": "Permission Change",
      "target": "Training Materials Folder",
      "category": "HR",
      "status": "Success",
      "ipAddress": "192.168.1.25",
      "details": "Changed folder permissions from Private to Internal",
      "severity": "Medium",
      "source": "Admin Panel",
    },
    {
      "id": "LOG-007",
      "timestamp": "2024-12-15 08:15:07",
      "user": "System",
      "userRole": "System",
      "action": "Auto Archive",
      "target": "Batch: 25 files processed",
      "category": "System",
      "status": "Success",
      "ipAddress": "127.0.0.1",
      "details": "Automated archival of files older than 90 days",
      "severity": "Low",
      "source": "System Task",
    },
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "Today"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
  ];

  List<Map<String, dynamic>> actionOptions = [
    {"label": "All Actions", "value": "All Actions"},
    {"label": "Archive File", "value": "Archive File"},
    {"label": "Restore File", "value": "Restore File"},
    {"label": "Delete File", "value": "Delete File"},
    {"label": "Download File", "value": "Download File"},
    {"label": "Access Denied", "value": "Access Denied"},
    {"label": "Permission Change", "value": "Permission Change"},
  ];

  List<Map<String, dynamic>> userOptions = [
    {"label": "All Users", "value": "All Users"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Emma Davis", "value": "Emma Davis"},
    {"label": "Robert Lee", "value": "Robert Lee"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "System", "value": "System"},
  ];

  List<Map<String, dynamic>> get filteredLogs {
    return auditLogs.where((log) {
      bool matchesSearch = searchQuery.isEmpty ||
          log["target"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["user"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["action"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["details"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesAction = selectedAction == "All Actions" ||
          log["action"] == selectedAction;

      bool matchesUser = selectedUser == "All Users" ||
          log["user"] == selectedUser;

      return matchesSearch && matchesAction && matchesUser;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Handle export logs
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search logs...",
                  value: searchQuery,
                  hint: "Search by user, action, target, or details",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Date Range",
                        items: dateRangeOptions,
                        value: selectedDateRange,
                        onChanged: (value, label) {
                          selectedDateRange = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Action",
                        items: actionOptions,
                        value: selectedAction,
                        onChanged: (value, label) {
                          selectedAction = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "User",
                  items: userOptions,
                  value: selectedUser,
                  onChanged: (value, label) {
                    selectedUser = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Results Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredLogs.length} log entries",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedAction != "All Actions" || selectedUser != "All Users")
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedAction = "All Actions";
                      selectedUser = "All Users";
                      selectedDateRange = "All Time";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Logs List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                final log = filteredLogs[index];
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
                        color: _getSeverityColor(log["severity"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with ID and Status
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${log["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(log["severity"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${log["severity"]} Risk",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getSeverityColor(log["severity"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(log["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${log["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(log["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Action and Target
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _getActionIcon(log["action"]),
                            color: _getActionColor(log["action"]),
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${log["action"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXxs),
                                Text(
                                  "Target: ${log["target"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Details
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${log["details"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),

                      // User and Time Info
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 12,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${log["user"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${log["userRole"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: disabledColor,
                          ),
                          SizedBox(width: spXxs),
                          Text(
                            "${log["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Additional Info
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 10,
                                  color: infoColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${log["ipAddress"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getSourceIcon(log["source"]),
                                  size: 10,
                                  color: warningColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${log["source"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (log["category"] != "System")
                            SizedBox(width: spXs),
                          if (log["category"] != "System")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${log["category"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
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
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Success":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "Archive File":
        return primaryColor;
      case "Restore File":
        return successColor;
      case "Delete File":
      case "Bulk Delete":
        return dangerColor;
      case "Download File":
        return infoColor;
      case "Access Denied":
        return dangerColor;
      case "Permission Change":
        return warningColor;
      case "Auto Archive":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case "Archive File":
      case "Auto Archive":
        return Icons.archive;
      case "Restore File":
        return Icons.restore;
      case "Delete File":
      case "Bulk Delete":
        return Icons.delete;
      case "Download File":
        return Icons.download;
      case "Access Denied":
        return Icons.block;
      case "Permission Change":
        return Icons.security;
      default:
        return Icons.info;
    }
  }

  IconData _getSourceIcon(String source) {
    switch (source) {
      case "Web Portal":
        return Icons.web;
      case "Mobile App":
        return Icons.phone_android;
      case "Desktop App":
        return Icons.computer;
      case "Admin Panel":
        return Icons.admin_panel_settings;
      case "System Task":
        return Icons.settings;
      default:
        return Icons.device_unknown;
    }
  }
}

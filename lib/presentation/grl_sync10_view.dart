import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync10View extends StatefulWidget {
  @override
  State<GrlSync10View> createState() => _GrlSync10ViewState();
}

class _GrlSync10ViewState extends State<GrlSync10View> {
  bool isLoading = false;
  List<Map<String, dynamic>> syncLogs = [
    {
      "id": 1,
      "timestamp": "2024-06-22 14:35:42",
      "level": "INFO",
      "message": "Sync operation completed successfully",
      "category": "Sync",
      "details": "15,420 files synchronized in 5m 30s"
    },
    {
      "id": 2,
      "timestamp": "2024-06-22 14:30:15",
      "level": "INFO",
      "message": "Starting automatic sync operation",
      "category": "Sync",
      "details": "Initiating sync for all enabled categories"
    },
    {
      "id": 3,
      "timestamp": "2024-06-22 14:28:33",
      "level": "WARNING",
      "message": "Slow network connection detected",
      "category": "Network",
      "details": "Latency: 850ms, Download: 2.1 Mbps"
    },
    {
      "id": 4,
      "timestamp": "2024-06-22 14:25:11",
      "level": "ERROR",
      "message": "Failed to sync document: report.pdf",
      "category": "Sync",
      "details": "File size exceeds limit (250MB > 100MB)"
    },
    {
      "id": 5,
      "timestamp": "2024-06-22 14:20:05",
      "level": "INFO",
      "message": "Backup process initiated",
      "category": "Backup",
      "details": "Creating incremental backup of user data"
    },
    {
      "id": 6,
      "timestamp": "2024-06-22 14:15:22",
      "level": "DEBUG",
      "message": "Connection established to primary server",
      "category": "Network",
      "details": "Server: us-east-1.example.com:443"
    },
    {
      "id": 7,
      "timestamp": "2024-06-22 14:12:45",
      "level": "WARNING",
      "message": "Authentication token will expire soon",
      "category": "Auth",
      "details": "Token expires in 2 hours, auto-refresh enabled"
    },
    {
      "id": 8,
      "timestamp": "2024-06-22 14:10:18",
      "level": "INFO",
      "message": "User preferences synchronized",
      "category": "Sync",
      "details": "156 settings updated successfully"
    },
    {
      "id": 9,
      "timestamp": "2024-06-22 14:05:33",
      "level": "ERROR",
      "message": "Server temporarily unavailable",
      "category": "Network",
      "details": "HTTP 503 - Service Unavailable, retrying in 30s"
    },
    {
      "id": 10,
      "timestamp": "2024-06-22 14:00:00",
      "level": "INFO",
      "message": "Application started",
      "category": "System",
      "details": "Version 2.1.5 initialized successfully"
    }
  ];

  String selectedLevel = "ALL";
  String selectedCategory = "ALL";
  String searchQuery = "";
  
  List<String> logLevels = ["ALL", "INFO", "WARNING", "ERROR", "DEBUG"];
  List<String> categories = ["ALL", "Sync", "Network", "Backup", "Auth", "System"];

  List<Map<String, dynamic>> get filteredLogs {
    return syncLogs.where((log) {
      bool matchesLevel = selectedLevel == "ALL" || log["level"] == selectedLevel;
      bool matchesCategory = selectedCategory == "ALL" || log["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (log["message"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (log["details"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesLevel && matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'INFO':
        return infoColor;
      case 'WARNING':
        return warningColor;
      case 'ERROR':
        return dangerColor;
      case 'DEBUG':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getLevelIcon(String level) {
    switch (level) {
      case 'INFO':
        return Icons.info;
      case 'WARNING':
        return Icons.warning;
      case 'ERROR':
        return Icons.error;
      case 'DEBUG':
        return Icons.bug_report;
      default:
        return Icons.help;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Sync':
        return primaryColor;
      case 'Network':
        return infoColor;
      case 'Backup':
        return successColor;
      case 'Auth':
        return warningColor;
      case 'System':
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _exportLogs() async {
    bool isConfirmed = await confirm("Export sync logs to file?");
    if (!isConfirmed) return;

    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});
    
    ss("Sync logs exported successfully");
  }

  void _clearLogs() async {
    bool isConfirmed = await confirm("This will permanently delete all sync logs. Continue?");
    if (!isConfirmed) return;

    syncLogs.clear();
    setState(() {});
    
    ss("Sync logs cleared");
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayLogs = filteredLogs;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportLogs,
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: syncLogs.isNotEmpty ? _clearLogs : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Log Statistics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Log Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: logLevels.where((level) => level != "ALL").map((level) {
                      int count = syncLogs.where((log) => log["level"] == level).length;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getLevelColor(level).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: _getLevelColor(level).withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getLevelIcon(level),
                                  color: _getLevelColor(level),
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  level,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _getLevelColor(level),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _getLevelColor(level),
                              ),
                            ),
                            Text(
                              "entries",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Search logs",
                    value: searchQuery,
                    hint: "Search by message or details...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Log Level",
                          items: logLevels.map((level) => {
                            "label": level,
                            "value": level,
                          }).toList(),
                          value: selectedLevel,
                          onChanged: (value, label) {
                            selectedLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories.map((category) => {
                            "label": category,
                            "value": category,
                          }).toList(),
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (displayLogs.length != syncLogs.length)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Showing ${displayLogs.length} of ${syncLogs.length} entries",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Log Entries
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Log Entries",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${displayLogs.length} entries",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (displayLogs.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No logs found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...displayLogs.map((log) {
                      DateTime timestamp = DateTime.parse("${log["timestamp"]}");
                      String level = "${log["level"]}";
                      String category = "${log["category"]}";
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: _getLevelColor(level).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getLevelColor(level),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: _getLevelColor(level).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    _getLevelIcon(level),
                                    color: _getLevelColor(level),
                                    size: 14,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: spXxs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getLevelColor(level),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    level,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: spXxs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(category),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  timestamp.dMMMy,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${log["message"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            if ((log["details"] as String).isNotEmpty)
                              Text(
                                "${log["details"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Actions
            if (syncLogs.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: isLoading ? "Exporting..." : "Export Logs",
                      icon: Icons.file_download,
                      size: bs.md,
                      onPressed: isLoading ? null : _exportLogs,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Clear All",
                      icon: Icons.delete_sweep,
                      size: bs.md,
                      onPressed: _clearLogs,
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

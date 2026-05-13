import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog1View extends StatefulWidget {
  @override
  State<GrlLog1View> createState() => _GrlLog1ViewState();
}

class _GrlLog1ViewState extends State<GrlLog1View> {
  String searchQuery = "";
  String selectedLevel = "All";
  String selectedSource = "All";

  List<Map<String, dynamic>> systemLogs = [
    {
      "logId": "LOG-001",
      "timestamp": "2024-12-20 15:30:45",
      "level": "ERROR",
      "source": "Database",
      "module": "UserService",
      "message": "Connection timeout while executing query",
      "details": "Failed to connect to database server 192.168.1.100:5432 after 30 seconds",
      "userId": "USR-12345",
      "requestId": "REQ-789012",
      "stackTrace": "SQLException: Connection timeout at DatabaseManager.execute()",
      "resolved": false,
    },
    {
      "logId": "LOG-002",
      "timestamp": "2024-12-20 15:25:12",
      "level": "WARNING",
      "source": "Authentication",
      "module": "LoginService",
      "message": "Multiple failed login attempts detected",
      "details": "User 'admin@company.com' attempted login 5 times in 2 minutes",
      "userId": "USR-54321",
      "requestId": "REQ-789013",
      "stackTrace": "",
      "resolved": true,
    },
    {
      "logId": "LOG-003",
      "timestamp": "2024-12-20 15:20:33",
      "level": "INFO",
      "source": "API Gateway",
      "module": "RequestHandler",
      "message": "API endpoint accessed successfully",
      "details": "GET /api/v1/users/profile executed in 250ms",
      "userId": "USR-67890",
      "requestId": "REQ-789014",
      "stackTrace": "",
      "resolved": true,
    },
    {
      "logId": "LOG-004",
      "timestamp": "2024-12-20 15:15:08",
      "level": "CRITICAL",
      "source": "File System",
      "module": "StorageManager",
      "message": "Disk space critically low",
      "details": "Available disk space: 2.1 GB (5% remaining) on /var/log partition",
      "userId": "SYSTEM",
      "requestId": "REQ-789015",
      "stackTrace": "",
      "resolved": false,
    },
    {
      "logId": "LOG-005",
      "timestamp": "2024-12-20 15:10:22",
      "level": "DEBUG",
      "source": "Cache",
      "module": "RedisManager",
      "message": "Cache miss for user profile data",
      "details": "Key 'user:profile:12345' not found in Redis cache, fetching from database",
      "userId": "USR-12345",
      "requestId": "REQ-789016",
      "stackTrace": "",
      "resolved": true,
    },
  ];

  List<Map<String, dynamic>> get filteredLogs {
    return systemLogs.where((log) {
      final matchesSearch = log["message"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["module"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["logId"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesLevel = selectedLevel == "All" || log["level"] == selectedLevel;
      final matchesSource = selectedSource == "All" || log["source"] == selectedSource;
      return matchesSearch && matchesLevel && matchesSource;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
            _buildLogStats(),
            _buildLogList(),
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
                label: "Search logs",
                value: searchQuery,
                hint: "Search by message, module, log ID...",
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
                label: "Log Level",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "CRITICAL", "value": "CRITICAL"},
                  {"label": "ERROR", "value": "ERROR"},
                  {"label": "WARNING", "value": "WARNING"},
                  {"label": "INFO", "value": "INFO"},
                  {"label": "DEBUG", "value": "DEBUG"},
                ],
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
                label: "Source",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Database", "value": "Database"},
                  {"label": "Authentication", "value": "Authentication"},
                  {"label": "API Gateway", "value": "API Gateway"},
                  {"label": "File System", "value": "File System"},
                  {"label": "Cache", "value": "Cache"},
                ],
                value: selectedSource,
                onChanged: (value, label) {
                  selectedSource = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogStats() {
    final criticalCount = systemLogs.where((log) => log["level"] == "CRITICAL").length;
    final errorCount = systemLogs.where((log) => log["level"] == "ERROR").length;
    final warningCount = systemLogs.where((log) => log["level"] == "WARNING").length;
    final unresolvedCount = systemLogs.where((log) => !(log["resolved"] as bool)).length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Critical",
            criticalCount.toString(),
            Icons.error,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Errors",
            errorCount.toString(),
            Icons.warning,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Warnings",
            warningCount.toString(),
            Icons.info,
            infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Unresolved",
            unresolvedCount.toString(),
            Icons.pending,
            secondaryColor,
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

  Widget _buildLogList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "System Logs (${filteredLogs.length})",
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
          itemCount: filteredLogs.length,
          itemBuilder: (context, index) {
            final log = filteredLogs[index];
            return _buildLogCard(log);
          },
        ),
      ],
    );
  }

  Widget _buildLogCard(Map<String, dynamic> log) {
    final isResolved = log["resolved"] as bool;
    final hasStackTrace = log["stackTrace"].toString().isNotEmpty;

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
            color: _getLevelColor(log["level"]),
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
                      "${log["logId"]}",
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
                      color: _getLevelColor(log["level"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${log["level"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getLevelColor(log["level"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isResolved ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      isResolved ? "Resolved" : "Unresolved",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isResolved ? successColor : dangerColor,
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
                Icons.source,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${log["source"]} - ${log["module"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["message"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
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
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "User: ${log["userId"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.fingerprint,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Request: ${log["requestId"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (hasStackTrace) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: dangerColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bug_report,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Stack Trace",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${log["stackTrace"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              if (!isResolved) ...[
                QButton(
                  label: "Mark Resolved",
                  size: bs.sm,
                  onPressed: () {
                    log["resolved"] = true;
                    setState(() {});
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
              Spacer(),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "CRITICAL":
        return dangerColor;
      case "ERROR":
        return warningColor;
      case "WARNING":
        return infoColor;
      case "INFO":
        return successColor;
      case "DEBUG":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog4View extends StatefulWidget {
  @override
  State<GrlLog4View> createState() => _GrlLog4ViewState();
}

class _GrlLog4ViewState extends State<GrlLog4View> {
  String searchQuery = "";
  String selectedLogLevel = "All";
  String selectedTimeRange = "Today";
  String selectedCategory = "All";
  bool showDetails = false;

  List<Map<String, dynamic>> logLevels = [
    {"label": "All", "value": "All"},
    {"label": "Info", "value": "Info"},
    {"label": "Warning", "value": "Warning"},
    {"label": "Error", "value": "Error"},
    {"label": "Debug", "value": "Debug"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Authentication", "value": "Authentication"},
    {"label": "Database", "value": "Database"},
    {"label": "API", "value": "API"},
    {"label": "Payment", "value": "Payment"},
  ];

  List<Map<String, dynamic>> applicationLogs = [
    {
      "id": 1,
      "timestamp": "2024-01-15 10:30:25",
      "level": "Info",
      "category": "Authentication",
      "message": "User login successful",
      "details": "User ID: 1001, IP: 192.168.1.100",
      "source": "AuthService",
      "session": "SESSION_12345"
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 10:28:15",
      "level": "Warning",
      "category": "Database",
      "message": "Database connection timeout",
      "details": "Connection attempt failed after 30 seconds",
      "source": "DatabaseManager",
      "session": "SESSION_12346"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 10:25:45",
      "level": "Error",
      "category": "API",
      "message": "API rate limit exceeded",
      "details": "Exceeded 100 requests per minute limit",
      "source": "APIGateway",
      "session": "SESSION_12347"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh logs
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export logs
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Log Level",
                    items: logLevels,
                    value: selectedLogLevel,
                    onChanged: (value, label) {
                      selectedLogLevel = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRanges,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
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
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Advanced Filters",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Stats Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Logs", "2,847", Icons.description, primaryColor),
                _buildStatCard("Errors", "23", Icons.error, dangerColor),
                _buildStatCard("Warnings", "156", Icons.warning, warningColor),
                _buildStatCard("Info", "2,668", Icons.info, infoColor),
              ],
            ),

            // Logs List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.list, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Application Logs",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDetails = !showDetails;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              showDetails ? "Hide Details" : "Show Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: applicationLogs.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final log = applicationLogs[index];
                      return _buildLogItem(log);
                    },
                  ),
                ],
              ),
            ),

            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Logs",
                size: bs.md,
                onPressed: () {
                  // Load more logs
                },
              ),
            ),
          ],
        ),
      ),
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
                child: Icon(icon, color: color, size: 16),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(Map<String, dynamic> log) {
    Color levelColor = _getLogLevelColor(log["level"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: levelColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        "${log["message"]}",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: levelColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["level"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: levelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
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
      children: showDetails ? [
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
                  Text(
                    "Source:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${log["source"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Session:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${log["session"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Details:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${log["details"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ] : [],
    );
  }

  Color _getLogLevelColor(String level) {
    switch (level) {
      case "Error":
        return dangerColor;
      case "Warning":
        return warningColor;
      case "Info":
        return infoColor;
      case "Debug":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}

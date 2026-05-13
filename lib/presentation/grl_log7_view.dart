import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog7View extends StatefulWidget {
  @override
  State<GrlLog7View> createState() => _GrlLog7ViewState();
}

class _GrlLog7ViewState extends State<GrlLog7View> {
  String searchQuery = "";
  String selectedSeverity = "All";
  String selectedStatus = "All";
  String selectedModule = "All";
  String selectedTimeRange = "Today";

  List<Map<String, dynamic>> severityLevels = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> modules = [
    {"label": "All", "value": "All"},
    {"label": "Authentication", "value": "Authentication"},
    {"label": "Database", "value": "Database"},
    {"label": "Payment Gateway", "value": "Payment Gateway"},
    {"label": "API Service", "value": "API Service"},
    {"label": "File Upload", "value": "File Upload"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "Today"},
    {"label": "Last 24 hours", "value": "Last 24 hours"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
  ];

  List<Map<String, dynamic>> errorLogs = [
    {
      "id": 1,
      "timestamp": "2024-01-15 15:45:23",
      "severity": "Critical",
      "status": "Open",
      "module": "Payment Gateway",
      "error_code": "PAY_001",
      "message": "Payment processing failed for transaction",
      "description": "Credit card validation service returned timeout error",
      "stack_trace": "PaymentService.processPayment() line 89\nCardValidator.validate() line 45",
      "affected_users": 15,
      "first_occurrence": "2024-01-15 15:45:23",
      "last_occurrence": "2024-01-15 15:47:12",
      "occurrence_count": 3,
      "assigned_to": "Tech Team",
      "resolution_time": null
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 15:30:15",
      "severity": "High",
      "status": "In Progress",
      "module": "Database",
      "error_code": "DB_002",
      "message": "Database connection pool exhausted",
      "description": "Maximum number of database connections reached",
      "stack_trace": "DatabaseManager.getConnection() line 156\nUserService.findUser() line 23",
      "affected_users": 45,
      "first_occurrence": "2024-01-15 14:30:00",
      "last_occurrence": "2024-01-15 15:30:15",
      "occurrence_count": 12,
      "assigned_to": "Database Team",
      "resolution_time": "ETA: 30 minutes"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 15:20:45",
      "severity": "Medium",
      "status": "Resolved",
      "module": "Authentication",
      "error_code": "AUTH_003",
      "message": "OAuth token validation failed",
      "description": "External authentication provider returned invalid response",
      "stack_trace": "AuthService.validateToken() line 78\nOAuthProvider.verify() line 134",
      "affected_users": 8,
      "first_occurrence": "2024-01-15 15:00:00",
      "last_occurrence": "2024-01-15 15:20:45",
      "occurrence_count": 5,
      "assigned_to": "Security Team",
      "resolution_time": "25 minutes"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.bug_report),
            onPressed: () {
              // Report new error
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Error analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Error notifications
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
                    label: "Search errors...",
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

            // Filter Row 1
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityLevels,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
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

            // Filter Row 2
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Module",
                    items: modules,
                    value: selectedModule,
                    onChanged: (value, label) {
                      selectedModule = value;
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

            // Error Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Errors", "1,234", Icons.error, dangerColor),
                _buildStatCard("Critical", "23", Icons.priority_high, dangerColor),
                _buildStatCard("Open Issues", "156", Icons.bug_report, warningColor),
                _buildStatCard("Resolved Today", "45", Icons.check_circle, successColor),
              ],
            ),

            // Error Tracking Chart
            Container(
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
                      Icon(Icons.trending_up, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Error Trend (Last 7 Days)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBarChart("Mon", 45, dangerColor),
                        _buildBarChart("Tue", 32, warningColor),
                        _buildBarChart("Wed", 28, infoColor),
                        _buildBarChart("Thu", 56, dangerColor),
                        _buildBarChart("Fri", 23, successColor),
                        _buildBarChart("Sat", 18, successColor),
                        _buildBarChart("Sun", 34, warningColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Error List
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
                        Icon(Icons.error_outline, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Error Reports",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${errorLogs.length} Errors",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: errorLogs.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final error = errorLogs[index];
                      return _buildErrorItem(error);
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Create error report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Alerts",
                    icon: Icons.add_alert,
                    size: bs.md,
                    onPressed: () {
                      // Set error alerts
                    },
                  ),
                ),
              ],
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

  Widget _buildBarChart(String day, int value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          width: 20,
          height: ((value / 60) * 80).toDouble(),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          day,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorItem(Map<String, dynamic> error) {
    Color severityColor = _getSeverityColor(error["severity"]);
    Color statusColor = _getStatusColor(error["status"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: severityColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(Icons.error, color: severityColor, size: 18),
      ),
      title: Text(
        "${error["error_code"]}: ${error["message"]}",
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
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${error["severity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${error["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
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
                  "${error["module"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${error["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.people, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${error["affected_users"]} users affected",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${error["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Text(
                "Stack Trace:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${error["stack_trace"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: dangerColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Occurrences: ${error["occurrence_count"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Assigned: ${error["assigned_to"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              if (error["resolution_time"] != null)
                Text(
                  "Resolution: ${error["resolution_time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              Row(
                children: [
                  QButton(
                    label: "Assign",
                    icon: Icons.person_add,
                    size: bs.sm,
                    onPressed: () {
                      // Assign error
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Resolve",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      // Mark as resolved
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}

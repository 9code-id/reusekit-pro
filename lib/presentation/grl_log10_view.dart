import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog10View extends StatefulWidget {
  @override
  State<GrlLog10View> createState() => _GrlLog10ViewState();
}

class _GrlLog10ViewState extends State<GrlLog10View> {
  String searchQuery = "";
  String selectedSeverity = "All";
  String selectedStatus = "All";
  String selectedCategory = "All";
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
    {"label": "Active", "value": "Active"},
    {"label": "Acknowledged", "value": "Acknowledged"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Scheduled", "value": "Scheduled"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Performance", "value": "Performance"},
    {"label": "Security", "value": "Security"},
    {"label": "System Health", "value": "System Health"},
    {"label": "Business Logic", "value": "Business Logic"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "Today"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> alertRules = [
    {
      "id": 1,
      "name": "High CPU Usage Alert",
      "description": "Triggers when CPU usage exceeds 80% for 5 minutes",
      "category": "Performance",
      "severity": "High",
      "status": "Active",
      "condition": "cpu_usage > 80%",
      "duration": "5 minutes",
      "notification_channels": ["Email", "Slack", "SMS"],
      "last_triggered": "2 hours ago",
      "trigger_count": 23,
      "created_by": "Admin",
      "escalation_enabled": true
    },
    {
      "id": 2,
      "name": "Database Connection Pool Alert",
      "description": "Alerts when database connections exceed 90% of pool size",
      "category": "System Health",
      "severity": "Critical",
      "status": "Active",
      "condition": "db_connections > 90%",
      "duration": "2 minutes",
      "notification_channels": ["Email", "Phone Call"],
      "last_triggered": "1 day ago",
      "trigger_count": 5,
      "created_by": "DBA Team",
      "escalation_enabled": true
    },
    {
      "id": 3,
      "name": "Failed Login Attempts",
      "description": "Monitors multiple failed login attempts from same IP",
      "category": "Security",
      "severity": "Medium",
      "status": "Acknowledged",
      "condition": "failed_logins > 5 in 10 minutes",
      "duration": "Immediate",
      "notification_channels": ["Email", "Security Dashboard"],
      "last_triggered": "30 minutes ago",
      "trigger_count": 12,
      "created_by": "Security Team",
      "escalation_enabled": false
    },
    {
      "id": 4,
      "name": "Payment Processing Error Rate",
      "description": "Triggers when payment error rate exceeds 2%",
      "category": "Business Logic",
      "severity": "Critical",
      "status": "Resolved",
      "condition": "payment_error_rate > 2%",
      "duration": "1 minute",
      "notification_channels": ["Email", "Slack", "Phone Call"],
      "last_triggered": "3 days ago",
      "trigger_count": 8,
      "created_by": "Payment Team",
      "escalation_enabled": true
    },
  ];

  List<Map<String, dynamic>> recentAlerts = [
    {
      "id": 1,
      "alert_name": "High CPU Usage Alert",
      "timestamp": "2024-01-15 18:45:23",
      "severity": "High",
      "status": "Active",
      "message": "CPU usage has reached 85% on Web Server 1",
      "value": "85%",
      "threshold": "80%",
      "affected_service": "Web Server 1",
      "duration": "7 minutes",
      "acknowledged_by": null
    },
    {
      "id": 2,
      "alert_name": "Failed Login Attempts",
      "timestamp": "2024-01-15 18:30:15",
      "severity": "Medium",
      "status": "Acknowledged",
      "message": "5 failed login attempts detected from IP 192.168.1.100",
      "value": "5 attempts",
      "threshold": "5 attempts",
      "affected_service": "Authentication Service",
      "duration": "Immediate",
      "acknowledged_by": "Security Team"
    },
    {
      "id": 3,
      "alert_name": "Database Connection Pool Alert",
      "timestamp": "2024-01-15 18:15:45",
      "severity": "Critical",
      "status": "Resolved",
      "message": "Database connection pool reached 95% capacity",
      "value": "95%",
      "threshold": "90%",
      "affected_service": "Database Server",
      "duration": "3 minutes",
      "acknowledged_by": "DBA Team"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              // Create new alert
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Notification settings
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Alert settings
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
                    label: "Search alerts...",
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

            // Alert Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Alerts", "156", Icons.notifications, primaryColor),
                _buildStatCard("Active", "23", Icons.warning, dangerColor),
                _buildStatCard("Acknowledged", "45", Icons.check_circle, warningColor),
                _buildStatCard("Resolved Today", "88", Icons.done_all, successColor),
              ],
            ),

            // Alert Rules Management
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
                        Icon(Icons.rule, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Alert Rules",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Create Rule",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            // Create new alert rule
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: alertRules.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final rule = alertRules[index];
                      return _buildAlertRuleItem(rule);
                    },
                  ),
                ],
              ),
            ),

            // Recent Alerts
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.notifications_active, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Alerts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${recentAlerts.where((a) => a["status"] == "Active").length} Active",
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
                    itemCount: recentAlerts.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final alert = recentAlerts[index];
                      return _buildRecentAlertItem(alert);
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
                    label: "Acknowledge All",
                    icon: Icons.done_all,
                    size: bs.md,
                    onPressed: () {
                      // Acknowledge all active alerts
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      // Export alert report
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

  Widget _buildAlertRuleItem(Map<String, dynamic> rule) {
    Color severityColor = _getSeverityColor(rule["severity"]);
    Color statusColor = _getStatusColor(rule["status"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: severityColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(Icons.rule, color: severityColor, size: 18),
      ),
      title: Text(
        "${rule["name"]}",
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
                  "${rule["severity"]}",
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
                  "${rule["status"]}",
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
                  "${rule["category"]}",
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
            "${rule["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Triggered: ${rule["trigger_count"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Last: ${rule["last_triggered"]}",
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
              Row(
                children: [
                  Text(
                    "Condition:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${rule["condition"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Duration:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${rule["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Notification Channels:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                children: (rule["notification_channels"] as List).map((channel) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$channel",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              Row(
                children: [
                  Text(
                    "Created by: ${rule["created_by"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  if (rule["escalation_enabled"] == true)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Escalation Enabled",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  QButton(
                    label: "Edit",
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      // Edit alert rule
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Test",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      // Test alert rule
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: rule["status"] == "Active" ? "Disable" : "Enable",
                    icon: rule["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      // Toggle rule status
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

  Widget _buildRecentAlertItem(Map<String, dynamic> alert) {
    Color severityColor = _getSeverityColor(alert["severity"]);
    Color statusColor = _getStatusColor(alert["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(Icons.notification_important, color: severityColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${alert["alert_name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${alert["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["severity"]}",
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
                        "${alert["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Value: ${alert["value"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Threshold: ${alert["threshold"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${alert["timestamp"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (alert["status"] == "Active")
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    // Acknowledge alert
                  },
                ),
              if (alert["status"] != "Resolved")
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () {
                    // Resolve alert
                  },
                ),
            ],
          ),
        ],
      ),
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
      case "Active":
        return dangerColor;
      case "Acknowledged":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}

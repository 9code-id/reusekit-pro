import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog8View extends StatefulWidget {
  @override
  State<GrlLog8View> createState() => _GrlLog8ViewState();
}

class _GrlLog8ViewState extends State<GrlLog8View> {
  String selectedMetric = "CPU Usage";
  String selectedTimeRange = "Last Hour";
  String selectedNode = "All Nodes";
  bool realTimeMode = true;

  List<Map<String, dynamic>> metrics = [
    {"label": "CPU Usage", "value": "CPU Usage"},
    {"label": "Memory Usage", "value": "Memory Usage"},
    {"label": "Network I/O", "value": "Network I/O"},
    {"label": "Disk I/O", "value": "Disk I/O"},
    {"label": "Response Time", "value": "Response Time"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last Hour", "value": "Last Hour"},
    {"label": "Last 6 Hours", "value": "Last 6 Hours"},
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
  ];

  List<Map<String, dynamic>> nodes = [
    {"label": "All Nodes", "value": "All Nodes"},
    {"label": "Web Server 1", "value": "Web Server 1"},
    {"label": "Web Server 2", "value": "Web Server 2"},
    {"label": "Database Server", "value": "Database Server"},
    {"label": "Cache Server", "value": "Cache Server"},
  ];

  List<Map<String, dynamic>> realTimeMetrics = [
    {
      "name": "CPU Usage",
      "current": 67.5,
      "threshold": 80.0,
      "unit": "%",
      "status": "Normal",
      "trend": "up",
      "history": [45, 52, 48, 55, 62, 67]
    },
    {
      "name": "Memory Usage", 
      "current": 4.2,
      "threshold": 8.0,
      "unit": "GB",
      "status": "Normal",
      "trend": "stable",
      "history": [3.8, 4.0, 4.1, 4.0, 4.2, 4.2]
    },
    {
      "name": "Network I/O",
      "current": 125.8,
      "threshold": 500.0,
      "unit": "Mbps",
      "status": "Normal",
      "trend": "down",
      "history": [180, 165, 150, 140, 130, 125]
    },
    {
      "name": "Response Time",
      "current": 245,
      "threshold": 1000,
      "unit": "ms",
      "status": "Good",
      "trend": "stable",
      "history": [250, 240, 245, 250, 248, 245]
    },
  ];

  List<Map<String, dynamic>> systemAlerts = [
    {
      "id": 1,
      "timestamp": "2024-01-15 16:45:23",
      "type": "Performance",
      "severity": "Warning",
      "message": "High CPU usage detected on Web Server 1",
      "threshold": "80%",
      "current": "85%",
      "node": "Web Server 1",
      "status": "Active"
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 16:40:15",
      "type": "Memory",
      "severity": "Critical",
      "message": "Memory usage exceeded threshold on Database Server",
      "threshold": "8GB",
      "current": "9.2GB",
      "node": "Database Server",
      "status": "Acknowledged"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 16:35:45",
      "type": "Network",
      "severity": "Info",
      "message": "Network traffic spike detected",
      "threshold": "200Mbps",
      "current": "350Mbps",
      "node": "Web Server 2",
      "status": "Resolved"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real-time Monitoring"),
        actions: [
          IconButton(
            icon: Icon(realTimeMode ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              realTimeMode = !realTimeMode;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Monitoring settings
            },
          ),
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () {
              // Dashboard view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Real-time Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: realTimeMode ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: realTimeMode ? successColor : warningColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: realTimeMode ? successColor : warningColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    realTimeMode ? "Real-time monitoring active" : "Real-time monitoring paused",
                    style: TextStyle(
                      color: realTimeMode ? successColor : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Updated: ${DateTime.now().toString().substring(11, 19)}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
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
                    label: "Node",
                    items: nodes,
                    value: selectedNode,
                    onChanged: (value, label) {
                      selectedNode = value;
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
                        Icon(Icons.tune, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Custom Metrics",
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

            // Real-time Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: realTimeMetrics.map((metric) => _buildMetricCard(metric)).toList(),
            ),

            // Performance Chart
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
                      Icon(Icons.timeline, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Performance Timeline - $selectedMetric",
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
                          selectedTimeRange,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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
                      children: _buildTimelineChart(),
                    ),
                  ),
                ],
              ),
            ),

            // System Alerts
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
                        Icon(Icons.warning, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "System Alerts",
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
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${systemAlerts.where((a) => a["status"] == "Active").length} Active",
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
                    itemCount: systemAlerts.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final alert = systemAlerts[index];
                      return _buildAlertItem(alert);
                    },
                  ),
                ],
              ),
            ),

            // Monitoring Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Data",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      // Export monitoring data
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Threshold",
                    icon: Icons.tune,
                    size: bs.md,
                    onPressed: () {
                      // Set performance thresholds
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

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    double percentage = ((metric["current"] as num) / (metric["threshold"] as num) * 100);
    Color statusColor = _getStatusColor(percentage);
    IconData trendIcon = _getTrendIcon(metric["trend"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(trendIcon, color: statusColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${metric["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${metric["current"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${metric["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Threshold: ${metric["threshold"]} ${metric["unit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
          SizedBox(height: spXs),
          Text(
            "${percentage.toStringAsFixed(1)}% of threshold",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimelineChart() {
    List<double> values = [65, 70, 68, 72, 75, 67, 69, 73];
    double maxValue = values.reduce((a, b) => a > b ? a : b);
    
    return values.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value;
      Color color = _getStatusColor(value);
      
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value.toInt().toString(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: 15,
            height: ((value / maxValue) * 80).toDouble(),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${index + 1}h",
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor = _getSeverityColor(alert["severity"]);
    Color statusColor = _getAlertStatusColor(alert["status"]);
    
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
            child: Icon(Icons.warning, color: severityColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${alert["message"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
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
                      "Current: ${alert["current"]}",
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
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.check,
                size: bs.sm,
                onPressed: () {
                  // Acknowledge alert
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(double percentage) {
    if (percentage >= 90) return dangerColor;
    if (percentage >= 70) return warningColor;
    if (percentage >= 50) return infoColor;
    return successColor;
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.timeline;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "Warning":
        return warningColor;
      case "Info":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertStatusColor(String status) {
    switch (status) {
      case "Active":
        return dangerColor;
      case "Acknowledged":
        return warningColor;
      case "Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}

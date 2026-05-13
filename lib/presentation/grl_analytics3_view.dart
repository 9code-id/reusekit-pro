import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics3View extends StatefulWidget {
  @override
  State<GrlAnalytics3View> createState() => _GrlAnalytics3ViewState();
}

class _GrlAnalytics3ViewState extends State<GrlAnalytics3View> {
  String selectedTimeframe = "week";
  String selectedMetric = "performance";

  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Performance", "value": "performance"},
    {"label": "Engagement", "value": "engagement"},
    {"label": "Growth", "value": "growth"},
    {"label": "Quality", "value": "quality"},
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "System Uptime",
      "value": 99.97,
      "target": 99.90,
      "unit": "%",
      "icon": Icons.cloud_done,
      "color": Colors.green,
      "trend": "up"
    },
    {
      "title": "Response Time",
      "value": 145.2,
      "target": 200.0,
      "unit": "ms",
      "icon": Icons.speed,
      "color": Colors.blue,
      "trend": "down"
    },
    {
      "title": "Error Rate",
      "value": 0.12,
      "target": 0.50,
      "unit": "%",
      "icon": Icons.error_outline,
      "color": Colors.orange,
      "trend": "down"
    },
    {
      "title": "Throughput",
      "value": 1250.8,
      "target": 1000.0,
      "unit": "req/min",
      "icon": Icons.trending_up,
      "color": Colors.purple,
      "trend": "up"
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "title": "High Memory Usage",
      "description": "Server 3 memory usage at 92%",
      "severity": "warning",
      "time": "2 minutes ago",
      "resolved": false
    },
    {
      "title": "SSL Certificate Expiring",
      "description": "Certificate expires in 7 days",
      "severity": "info",
      "time": "1 hour ago",
      "resolved": false
    },
    {
      "title": "Database Connection Lost",
      "description": "Replica database connection timeout",
      "severity": "critical",
      "time": "3 hours ago",
      "resolved": true
    },
    {
      "title": "Backup Completed",
      "description": "Daily backup process finished successfully",
      "severity": "success",
      "time": "6 hours ago",
      "resolved": true
    },
  ];

  List<Map<String, dynamic>> servers = [
    {
      "name": "Web Server 1",
      "status": "healthy",
      "cpu": 45.2,
      "memory": 68.5,
      "disk": 32.1,
      "uptime": "15d 8h 32m"
    },
    {
      "name": "Web Server 2",
      "status": "healthy",
      "cpu": 52.8,
      "memory": 71.2,
      "disk": 28.9,
      "uptime": "15d 8h 32m"
    },
    {
      "name": "Database Server",
      "status": "warning",
      "cpu": 78.4,
      "memory": 89.1,
      "disk": 75.6,
      "uptime": "22d 14h 15m"
    },
    {
      "name": "Cache Server",
      "status": "healthy",
      "cpu": 23.1,
      "memory": 45.8,
      "disk": 15.2,
      "uptime": "8d 6h 45m"
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "critical":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "success":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "healthy":
        return successColor;
      case "warning":
        return warningColor;
      case "critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Analytics"),
        actions: [
          Icon(Icons.refresh),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframes,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Metric Type",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: kpiData.map((kpi) {
                bool isMeetingTarget = kpi["title"] == "Error Rate" 
                    ? (kpi["value"] as double) <= (kpi["target"] as double)
                    : (kpi["value"] as double) >= (kpi["target"] as double);
                    
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: isMeetingTarget ? successColor : warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (kpi["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              kpi["icon"] as IconData,
                              color: kpi["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            kpi["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            color: kpi["trend"] == "up" ? successColor : warningColor,
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${kpi["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(kpi["value"] as double).toStringAsFixed(kpi["unit"] == "ms" ? 1 : 2)}${kpi["unit"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Target: ${(kpi["target"] as double).toStringAsFixed(kpi["unit"] == "ms" ? 1 : 2)}${kpi["unit"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              width: double.infinity,
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
                      Text(
                        "System Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alerts.where((a) => !(a["resolved"] as bool)).length} active",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...alerts.map((alert) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getSeverityColor(alert["severity"] as String).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getSeverityColor(alert["severity"] as String),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(alert["severity"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              alert["severity"] == "critical" ? Icons.error :
                              alert["severity"] == "warning" ? Icons.warning :
                              alert["severity"] == "success" ? Icons.check_circle :
                              Icons.info,
                              color: _getSeverityColor(alert["severity"] as String),
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alert["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${alert["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${alert["time"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (alert["resolved"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Resolved",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Server Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...servers.map((server) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(server["status"] as String).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(server["status"] as String),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${server["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${server["uptime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CPU",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(server["cpu"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Memory",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(server["memory"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Disk",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(server["disk"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
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
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

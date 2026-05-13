import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats9View extends StatefulWidget {
  @override
  State<GrlStats9View> createState() => _GrlStats9ViewState();
}

class _GrlStats9ViewState extends State<GrlStats9View> {
  String selectedServer = "all";
  String selectedTimeRange = "24h";
  
  List<Map<String, dynamic>> serverItems = [
    {"label": "All Servers", "value": "all"},
    {"label": "Web Server 1", "value": "web1"},
    {"label": "Web Server 2", "value": "web2"},
    {"label": "Database Server", "value": "db1"},
    {"label": "API Server", "value": "api1"},
  ];

  List<Map<String, dynamic>> timeRangeItems = [
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
  ];

  List<Map<String, dynamic>> get systemMetrics => [
    {
      "title": "System Uptime",
      "value": "99.9%",
      "trend": "+0.1%",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Response Time",
      "value": "145ms",
      "trend": "-12ms",
      "icon": Icons.speed,
      "color": infoColor,
    },
    {
      "title": "CPU Usage",
      "value": "68%",
      "trend": "+5%",
      "icon": Icons.memory,
      "color": warningColor,
    },
    {
      "title": "Memory Usage",
      "value": "72%",
      "trend": "+3%",
      "icon": Icons.storage,
      "color": warningColor,
    },
    {
      "title": "Active Users",
      "value": "2.4K",
      "trend": "+180",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Error Rate",
      "value": "0.05%",
      "trend": "-0.02%",
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> get serverStatus => [
    {
      "name": "Web Server 1",
      "status": "Healthy",
      "cpu": 45,
      "memory": 68,
      "disk": 32,
      "uptime": "15 days",
      "load": 2.3,
      "requests": 1245,
    },
    {
      "name": "Web Server 2", 
      "status": "Healthy",
      "cpu": 52,
      "memory": 71,
      "disk": 28,
      "uptime": "15 days",
      "load": 2.8,
      "requests": 1186,
    },
    {
      "name": "Database Server",
      "status": "Warning",
      "cpu": 78,
      "memory": 85,
      "disk": 45,
      "uptime": "8 days",
      "load": 4.2,
      "requests": 892,
    },
    {
      "name": "API Server",
      "status": "Healthy",
      "cpu": 38,
      "memory": 55,
      "disk": 25,
      "uptime": "22 days",
      "load": 1.8,
      "requests": 2156,
    },
  ];

  List<Map<String, dynamic>> get serviceHealth => [
    {
      "service": "Authentication API",
      "status": "Online",
      "responseTime": 98,
      "successRate": 99.8,
      "lastCheck": "2 min ago",
      "dependencies": 3,
    },
    {
      "service": "Payment Gateway",
      "status": "Online",
      "responseTime": 156,
      "successRate": 99.5,
      "lastCheck": "1 min ago",
      "dependencies": 2,
    },
    {
      "service": "Email Service",
      "status": "Degraded",
      "responseTime": 485,
      "successRate": 97.2,
      "lastCheck": "30 sec ago",
      "dependencies": 1,
    },
    {
      "service": "File Storage",
      "status": "Online",
      "responseTime": 234,
      "successRate": 99.9,
      "lastCheck": "45 sec ago",
      "dependencies": 0,
    },
    {
      "service": "Search Engine",
      "status": "Online",
      "responseTime": 67,
      "successRate": 99.7,
      "lastCheck": "1 min ago",
      "dependencies": 2,
    },
  ];

  List<Map<String, dynamic>> get recentAlerts => [
    {
      "alert": "High CPU Usage",
      "server": "Database Server",
      "severity": "Warning",
      "time": "5 min ago",
      "value": "78%",
      "threshold": "75%",
    },
    {
      "alert": "Memory Usage Critical",
      "server": "Database Server", 
      "severity": "Critical",
      "time": "12 min ago",
      "value": "85%",
      "threshold": "80%",
    },
    {
      "alert": "Slow Response Time",
      "server": "Email Service",
      "severity": "Warning",
      "time": "18 min ago",
      "value": "485ms",
      "threshold": "300ms",
    },
    {
      "alert": "Disk Space Low",
      "server": "Database Server",
      "severity": "Info",
      "time": "25 min ago",
      "value": "45%",
      "threshold": "50%",
    },
  ];

  Color _getServerStatusColor(String status) {
    switch (status) {
      case "Healthy":
        return successColor;
      case "Warning":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getServiceStatusColor(String status) {
    switch (status) {
      case "Online":
        return successColor;
      case "Degraded":
        return warningColor;
      case "Offline":
        return dangerColor;
      default:
        return disabledBoldColor;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Performance"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ss("Alert center opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Server",
                    items: serverItems,
                    value: selectedServer,
                    onChanged: (value, label) {
                      selectedServer = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRangeItems,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // System Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: systemMetrics.map((metric) {
                bool isPositive = !(metric["trend"] as String).startsWith('-') || 
                                 (metric["title"] == "Error Rate" && (metric["trend"] as String).startsWith('-'));
                return Container(
                  padding: EdgeInsets.all(spMd),
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
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPositive ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: isPositive ? successColor : dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${metric["trend"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Server Status
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Server Status",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.computer,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: serverStatus.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final server = serverStatus[index];
                      Color statusColor = _getServerStatusColor(server["status"] as String);
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${server["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${server["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                        "CPU: ${server["cpu"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (server["cpu"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (server["cpu"] as int) > 70 
                                                ? dangerColor 
                                                : (server["cpu"] as int) > 50 
                                                  ? warningColor 
                                                  : successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Memory: ${server["memory"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (server["memory"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (server["memory"] as int) > 80 
                                                ? dangerColor 
                                                : (server["memory"] as int) > 60 
                                                  ? warningColor 
                                                  : successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "Uptime: ${server["uptime"]} • ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Load: ${server["load"]} • ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${server["requests"]} req/min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Service Health
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Service Health",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.health_and_safety,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: serviceHealth.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final service = serviceHealth[index];
                      Color statusColor = _getServiceStatusColor(service["status"] as String);
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["service"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${service["responseTime"]}ms • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${service["successRate"]}% • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (service["successRate"] as double) > 99 
                                            ? successColor 
                                            : warningColor,
                                        ),
                                      ),
                                      Text(
                                        "${service["lastCheck"]}",
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${service["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                if ((service["dependencies"] as int) > 0)
                                  Text(
                                    "${service["dependencies"]} deps",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Recent Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${recentAlerts.length} alerts",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
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
                      Color severityColor = _getSeverityColor(alert["severity"] as String);
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: severityColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${alert["alert"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${alert["server"]} • ${alert["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
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
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: severityColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${alert["severity"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: severityColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${alert["value"]} > ${alert["threshold"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Logs",
                    icon: Icons.list_alt,
                    size: bs.md,
                    onPressed: () {
                      ss("System logs opened");
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
                      ss("Performance report exported");
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
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaApiSettingsView extends StatefulWidget {
  const PmaApiSettingsView({super.key});

  @override
  State<PmaApiSettingsView> createState() => _PmaApiSettingsViewState();
}

class _PmaApiSettingsViewState extends State<PmaApiSettingsView> {
  String baseUrl = "https://api.example.com/v1";
  String apiKey = "sk_live_********************************";
  String timeout = "30";
  bool enableLogging = true;
  bool enableCaching = true;
  bool enableRetry = true;
  String retryAttempts = "3";
  String cacheExpiry = "300";

  List<Map<String, dynamic>> endpoints = [
    {
      "id": 1,
      "name": "User Authentication",
      "path": "/auth/login",
      "method": "POST",
      "status": "Active",
      "responseTime": 245,
      "successRate": 99.2,
      "lastTested": "2024-01-22 10:30",
      "version": "v1",
    },
    {
      "id": 2,
      "name": "Get Projects",
      "path": "/projects",
      "method": "GET",
      "status": "Active",
      "responseTime": 156,
      "successRate": 98.8,
      "lastTested": "2024-01-22 10:25",
      "version": "v1",
    },
    {
      "id": 3,
      "name": "Create Task",
      "path": "/tasks",
      "method": "POST",
      "status": "Active",
      "responseTime": 189,
      "successRate": 97.5,
      "lastTested": "2024-01-22 10:20",
      "version": "v1",
    },
    {
      "id": 4,
      "name": "Upload File",
      "path": "/files/upload",
      "method": "POST",
      "status": "Warning",
      "responseTime": 1234,
      "successRate": 95.1,
      "lastTested": "2024-01-22 09:45",
      "version": "v1",
    },
    {
      "id": 5,
      "name": "Send Notification",
      "path": "/notifications",
      "method": "POST",
      "status": "Error",
      "responseTime": 0,
      "successRate": 12.3,
      "lastTested": "2024-01-21 16:20",
      "version": "v1",
    },
    {
      "id": 6,
      "name": "Generate Report",
      "path": "/reports/generate",
      "method": "POST",
      "status": "Active",
      "responseTime": 567,
      "successRate": 96.7,
      "lastTested": "2024-01-22 08:15",
      "version": "v1",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Warning":
        return warningColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMethodColor(String method) {
    switch (method) {
      case "GET":
        return infoColor;
      case "POST":
        return successColor;
      case "PUT":
        return warningColor;
      case "DELETE":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    double avgResponseTime = endpoints.map((e) => e["responseTime"] as int).reduce((a, b) => a + b) / endpoints.length;
    double avgSuccessRate = endpoints.map((e) => e["successRate"] as double).reduce((a, b) => a + b) / endpoints.length;
    int activeEndpoints = endpoints.where((e) => e["status"] == "Active").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("API Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // API Configuration
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "API Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Base URL",
                    value: baseUrl,
                    onChanged: (value) {
                      baseUrl = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "API Key",
                    value: apiKey,
                    onChanged: (value) {
                      apiKey = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Timeout (seconds)",
                          value: timeout,
                          onChanged: (value) {
                            timeout = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Retry Attempts",
                          value: retryAttempts,
                          onChanged: (value) {
                            retryAttempts = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // API Features
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "API Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Request Logging",
                        "value": "logging",
                        "checked": enableLogging,
                      }
                    ],
                    value: enableLogging ? [{"label": "Enable Request Logging", "value": "logging", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableLogging = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Response Caching",
                        "value": "caching",
                        "checked": enableCaching,
                      }
                    ],
                    value: enableCaching ? [{"label": "Enable Response Caching", "value": "caching", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableCaching = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (enableCaching)
                    QNumberField(
                      label: "Cache Expiry (seconds)",
                      value: cacheExpiry,
                      onChanged: (value) {
                        cacheExpiry = value;
                        setState(() {});
                      },
                    ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Auto Retry",
                        "value": "retry",
                        "checked": enableRetry,
                      }
                    ],
                    value: enableRetry ? [{"label": "Enable Auto Retry", "value": "retry", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableRetry = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // API Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "API Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$activeEndpoints/${endpoints.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Active Endpoints",
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
                          children: [
                            Text(
                              "${avgResponseTime.round()}ms",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Avg Response",
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
                          children: [
                            Text(
                              "${avgSuccessRate.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Success Rate",
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

            // Endpoint Monitoring
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Endpoint Monitoring",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Test All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: endpoints.map((endpoint) {
                      Color statusColor = _getStatusColor(endpoint["status"]);
                      Color methodColor = _getMethodColor(endpoint["method"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: statusColor.withAlpha(40),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: methodColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${endpoint["method"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${endpoint["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${endpoint["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${endpoint["path"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontFamily: "monospace",
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${endpoint["version"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${endpoint["responseTime"]}ms",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: successColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${endpoint["successRate"]}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Last: ${endpoint["lastTested"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // API Documentation
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "API Documentation",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Swagger UI",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Download OpenAPI",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "API Logs",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Rate Limits",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
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

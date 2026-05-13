import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSevereWeatherView extends StatefulWidget {
  const WcaSevereWeatherView({super.key});

  @override
  State<WcaSevereWeatherView> createState() => _WcaSevereWeatherViewState();
}

class _WcaSevereWeatherViewState extends State<WcaSevereWeatherView> {
  String selectedAlertType = "All";
  String selectedSeverity = "All";
  bool autoRefresh = true;

  List<Map<String, dynamic>> alertTypeOptions = [
    {"label": "All Alerts", "value": "All"},
    {"label": "Tornado Warning", "value": "Tornado"},
    {"label": "Severe Thunderstorm", "value": "Thunderstorm"},
    {"label": "Flash Flood", "value": "Flood"},
    {"label": "Winter Storm", "value": "Winter"},
    {"label": "High Wind", "value": "Wind"},
  ];

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severity", "value": "All"},
    {"label": "Watch", "value": "Watch"},
    {"label": "Warning", "value": "Warning"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  List<Map<String, dynamic>> currentAlerts = [
    {
      "type": "Tornado Warning",
      "severity": "Emergency",
      "title": "Tornado Warning in Effect",
      "description": "Tornado sighted 5 miles SW of downtown. Take shelter immediately.",
      "area": "Jefferson County",
      "issuedTime": "2:45 PM",
      "expiresTime": "3:15 PM",
      "urgency": "Immediate",
      "certainty": "Confirmed",
      "windSpeed": "150+ mph",
      "affectedPopulation": "250,000",
      "shelterAdvice": "Go to lowest floor, stay away from windows",
    },
    {
      "type": "Severe Thunderstorm Warning",
      "severity": "Warning",
      "title": "Severe Thunderstorm Warning",
      "description": "Damaging winds and large hail possible. Seek shelter indoors.",
      "area": "Madison County",
      "issuedTime": "2:20 PM",
      "expiresTime": "3:45 PM",
      "urgency": "Expected",
      "certainty": "Likely",
      "windSpeed": "70 mph",
      "affectedPopulation": "180,000",
      "shelterAdvice": "Stay indoors, avoid windows",
    },
    {
      "type": "Flash Flood Warning",
      "severity": "Warning",
      "title": "Flash Flood Warning",
      "description": "Heavy rainfall causing rapid water rise. Avoid flooded roads.",
      "area": "Franklin County",
      "issuedTime": "1:30 PM",
      "expiresTime": "4:00 PM",
      "urgency": "Expected",
      "certainty": "Likely",
      "rainfall": "2-4 inches",
      "affectedPopulation": "120,000",
      "shelterAdvice": "Move to higher ground, never drive through flood waters",
    },
    {
      "type": "Winter Storm Watch",
      "severity": "Watch",
      "title": "Winter Storm Watch",
      "description": "Heavy snow and blizzard conditions possible tonight.",
      "area": "Hamilton County",
      "issuedTime": "12:00 PM",
      "expiresTime": "6:00 AM Tomorrow",
      "urgency": "Future",
      "certainty": "Possible",
      "snowfall": "8-12 inches",
      "affectedPopulation": "320,000",
      "shelterAdvice": "Prepare for travel disruptions, stock supplies",
    },
  ];

  List<Map<String, dynamic>> severityLevels = [
    {
      "level": "Emergency",
      "description": "Immediate threat to life and property",
      "action": "Take action immediately",
      "color": dangerColor,
      "count": 1,
    },
    {
      "level": "Warning",
      "description": "Dangerous weather occurring or imminent",
      "action": "Take protective action now",
      "color": dangerColor,
      "count": 2,
    },
    {
      "level": "Watch",
      "description": "Conditions favorable for severe weather",
      "action": "Be prepared to take action",
      "color": warningColor,
      "count": 1,
    },
    {
      "level": "Advisory",
      "description": "Hazardous weather possible",
      "action": "Use caution",
      "color": infoColor,
      "count": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Severe Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: () {
              si("Alert notifications enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Opening weather radar map");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(80)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency,
                    color: dangerColor,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SEVERE WEATHER ACTIVE",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Multiple severe weather warnings in your area. Stay alert.",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Alert Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Alerts Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...severityLevels.map((level) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (level["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: level["color"],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "${level["count"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${level["level"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: level["color"],
                                ),
                              ),
                              Text(
                                "${level["description"]}",
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
                  )),
                ],
              ),
            ),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Alert Type",
                    items: alertTypeOptions,
                    value: selectedAlertType,
                    onChanged: (value, label) {
                      selectedAlertType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityOptions,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              label: "Auto Refresh",
              items: [
                {
                  "label": "Automatically refresh alerts",
                  "value": true,
                  "checked": autoRefresh,
                }
              ],
              value: [
                if (autoRefresh)
                  {
                    "label": "Automatically refresh alerts",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                autoRefresh = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Current Alerts
            Text(
              "Current Weather Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...currentAlerts.map((alert) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getSeverityColor(alert["severity"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSeverityColor(alert["severity"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${alert["severity"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _getSeverityColor(alert["severity"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${alert["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${alert["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _getAlertIcon(alert["type"]),
                        color: _getSeverityColor(alert["severity"]),
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${alert["description"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Area: ${alert["area"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Issued: ${alert["issuedTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Expires: ${alert["expiresTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Affected: ${alert["affectedPopulation"]} people",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Urgency: ${alert["urgency"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Certainty: ${alert["certainty"]}",
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
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Protective Action:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["shelterAdvice"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Map",
                          size: bs.sm,
                          onPressed: () {
                            si("Opening radar map for ${alert["area"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Get Updates",
                          size: bs.sm,
                          onPressed: () {
                            ss("Alert updates enabled for ${alert["type"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

            // Emergency Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call 911",
                          size: bs.sm,
                          onPressed: () {
                            si("Emergency services contacted");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Emergency Kit",
                          size: bs.sm,
                          onPressed: () {
                            si("Opening emergency preparedness guide");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Safety Guidelines
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Severe Weather Safety",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Monitor weather alerts continuously",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Have multiple ways to receive warnings",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Know your safe locations for different threats",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep emergency supplies readily available",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "emergency":
        return dangerColor;
      case "warning":
        return dangerColor;
      case "watch":
        return warningColor;
      case "advisory":
        return infoColor;
      default:
        return infoColor;
    }
  }

  IconData _getAlertIcon(String alertType) {
    if (alertType.toLowerCase().contains("tornado")) {
      return Icons.cyclone;
    } else if (alertType.toLowerCase().contains("thunderstorm")) {
      return Icons.thunderstorm;
    } else if (alertType.toLowerCase().contains("flood")) {
      return Icons.flood;
    } else if (alertType.toLowerCase().contains("winter")) {
      return Icons.ac_unit;
    } else if (alertType.toLowerCase().contains("wind")) {
      return Icons.air;
    } else {
      return Icons.warning;
    }
  }
}

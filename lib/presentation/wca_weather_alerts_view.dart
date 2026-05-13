import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWeatherAlertsView extends StatefulWidget {
  const WcaWeatherAlertsView({super.key});

  @override
  State<WcaWeatherAlertsView> createState() => _WcaWeatherAlertsViewState();
}

class _WcaWeatherAlertsViewState extends State<WcaWeatherAlertsView> {
  String selectedAlertType = "All";
  String selectedLocation = "Current Location";
  bool enablePushNotifications = true;
  bool enableEmailAlerts = false;
  bool enableSMSAlerts = true;

  List<Map<String, dynamic>> alertTypeOptions = [
    {"label": "All Weather Alerts", "value": "All"},
    {"label": "Severe Weather", "value": "Severe"},
    {"label": "Rain & Storms", "value": "Rain"},
    {"label": "Snow & Ice", "value": "Snow"},
    {"label": "Wind Alerts", "value": "Wind"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Air Quality", "value": "Air Quality"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Current Location", "value": "Current Location"},
    {"label": "Home - Chicago, IL", "value": "Chicago"},
    {"label": "Work - Downtown", "value": "Downtown"},
    {"label": "Family - Springfield", "value": "Springfield"},
  ];

  List<Map<String, dynamic>> activeAlerts = [
    {
      "id": "1",
      "type": "Winter Storm Warning",
      "severity": "High",
      "title": "Heavy Snow Expected Tonight",
      "message": "6-10 inches of snow expected. Travel will be dangerous.",
      "location": "Chicago, IL",
      "startTime": "8:00 PM Today",
      "endTime": "6:00 AM Tomorrow",
      "issuedTime": "2:30 PM",
      "priority": "High",
      "category": "Snow",
      "status": "Active",
    },
    {
      "id": "2",
      "type": "Wind Advisory",
      "severity": "Moderate",
      "title": "High Wind Advisory",
      "message": "Winds gusting up to 45 mph. Secure loose objects.",
      "location": "Lake County, IL",
      "startTime": "6:00 PM Today",
      "endTime": "2:00 AM Tomorrow",
      "issuedTime": "1:15 PM",
      "priority": "Medium",
      "category": "Wind",
      "status": "Active",
    },
    {
      "id": "3",
      "type": "Air Quality Alert",
      "severity": "Moderate",
      "title": "Unhealthy Air Quality",
      "message": "Air quality is unhealthy for sensitive groups.",
      "location": "Cook County, IL",
      "startTime": "Now",
      "endTime": "11:59 PM Today",
      "issuedTime": "9:00 AM",
      "priority": "Medium",
      "category": "Air Quality",
      "status": "Active",
    },
  ];

  List<Map<String, dynamic>> recentAlerts = [
    {
      "id": "4",
      "type": "Thunderstorm Warning",
      "severity": "High",
      "title": "Severe Thunderstorm",
      "message": "Damaging winds and large hail possible.",
      "location": "DuPage County, IL",
      "issuedTime": "Yesterday 3:45 PM",
      "endedTime": "Yesterday 4:30 PM",
      "status": "Expired",
    },
    {
      "id": "5",
      "type": "Heat Advisory",
      "severity": "Moderate",
      "title": "Excessive Heat",
      "message": "Heat index values up to 105°F expected.",
      "location": "Chicago Metro",
      "issuedTime": "Dec 10, 2:00 PM",
      "endedTime": "Dec 10, 8:00 PM",
      "status": "Expired",
    },
  ];

  List<Map<String, dynamic>> alertPreferences = [
    {
      "type": "Severe Weather",
      "enabled": true,
      "threshold": "High",
      "advance": "30 minutes",
    },
    {
      "type": "Rain & Storms",
      "enabled": true,
      "threshold": "Moderate",
      "advance": "15 minutes",
    },
    {
      "type": "Snow & Ice",
      "enabled": true,
      "threshold": "Low",
      "advance": "2 hours",
    },
    {
      "type": "Wind Alerts",
      "enabled": false,
      "threshold": "High",
      "advance": "1 hour",
    },
    {
      "type": "Temperature",
      "enabled": true,
      "threshold": "Extreme",
      "advance": "1 hour",
    },
    {
      "type": "Air Quality",
      "enabled": true,
      "threshold": "Unhealthy",
      "advance": "Morning",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Opening alert settings");
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              si("Creating custom alert");
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
            // Alert Status Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activeAlerts.length} Active Weather Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Stay informed about weather conditions in your area",
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

            // Notification Settings
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
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    label: "Push Notifications",
                    items: [
                      {
                        "label": "Receive instant weather alerts",
                        "value": true,
                        "checked": enablePushNotifications,
                      }
                    ],
                    value: [
                      if (enablePushNotifications)
                        {
                          "label": "Receive instant weather alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enablePushNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Email Alerts",
                    items: [
                      {
                        "label": "Get detailed alerts via email",
                        "value": true,
                        "checked": enableEmailAlerts,
                      }
                    ],
                    value: [
                      if (enableEmailAlerts)
                        {
                          "label": "Get detailed alerts via email",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableEmailAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "SMS Alerts",
                    items: [
                      {
                        "label": "Emergency alerts via text message",
                        "value": true,
                        "checked": enableSMSAlerts,
                      }
                    ],
                    value: [
                      if (enableSMSAlerts)
                        {
                          "label": "Emergency alerts via text message",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableSMSAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Filter Options
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
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Active Alerts
            Text(
              "Active Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            if (activeAlerts.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No Active Alerts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "All weather conditions are currently normal",
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
              )
            else
              ...activeAlerts.map((alert) => Container(
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
                          _getCategoryIcon(alert["category"]),
                          color: _getSeverityColor(alert["severity"]),
                          size: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${alert["message"]}",
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
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${alert["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "From ${alert["startTime"]} to ${alert["endTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Issued at ${alert["issuedTime"]}",
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Viewing details for ${alert["title"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Dismiss",
                            size: bs.sm,
                            onPressed: () {
                              sw("Alert dismissed");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),

            // Alert Preferences
            Text(
              "Alert Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: alertPreferences.map((pref) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pref["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Threshold: ${pref["threshold"]} • Advance: ${pref["advance"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: pref["enabled"],
                        onChanged: (value) {
                          pref["enabled"] = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),

            // Recent Alerts
            Text(
              "Recent Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...recentAlerts.map((alert) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${alert["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${alert["location"]} • ${alert["issuedTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Expired",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )),

            // Emergency Contacts
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
                        "Emergency Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• For life-threatening emergencies, call 911",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Have multiple ways to receive weather alerts",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep emergency supplies ready",
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
      case "high":
        return dangerColor;
      case "moderate":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return infoColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "snow":
        return Icons.ac_unit;
      case "wind":
        return Icons.air;
      case "rain":
        return Icons.water_drop;
      case "air quality":
        return Icons.air_outlined;
      case "temperature":
        return Icons.thermostat;
      default:
        return Icons.warning;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWarningNotificationsView extends StatefulWidget {
  const WcaWarningNotificationsView({super.key});

  @override
  State<WcaWarningNotificationsView> createState() => _WcaWarningNotificationsViewState();
}

class _WcaWarningNotificationsViewState extends State<WcaWarningNotificationsView> {
  bool enableSevereWeatherAlerts = true;
  bool enableTornadoWarnings = true;
  bool enableFloodAlerts = true;
  bool enableHurricaneWarnings = true;
  bool enableWinterStormAlerts = true;
  bool enableHeatWarnings = false;
  bool enableSoundAlerts = true;
  bool enableVibrationAlerts = true;
  bool enablePushNotifications = true;
  String alertRadius = "50";
  String notificationTime = "immediate";

  List<Map<String, dynamic>> radiusOptions = [
    {"label": "10 km", "value": "10"},
    {"label": "25 km", "value": "25"},
    {"label": "50 km", "value": "50"},
    {"label": "75 km", "value": "75"},
    {"label": "100 km", "value": "100"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "Immediate", "value": "immediate"},
    {"label": "5 minutes before", "value": "5min"},
    {"label": "15 minutes before", "value": "15min"},
    {"label": "30 minutes before", "value": "30min"},
    {"label": "1 hour before", "value": "1hour"},
  ];

  List<Map<String, dynamic>> recentWarnings = [
    {
      "type": "Severe Thunderstorm",
      "severity": "Warning",
      "time": "2 hours ago",
      "location": "Downtown Area",
      "description": "Damaging winds up to 70 mph possible",
      "icon": Icons.thunderstorm,
      "color": Colors.orange,
      "isActive": false,
    },
    {
      "type": "Flash Flood",
      "severity": "Watch",
      "time": "5 hours ago",
      "location": "River Valley",
      "description": "Heavy rainfall may cause flooding",
      "icon": Icons.water,
      "color": Colors.blue,
      "isActive": false,
    },
    {
      "type": "Heat Advisory",
      "severity": "Advisory",
      "time": "1 day ago",
      "location": "Metropolitan Area",
      "description": "Heat index up to 105°F expected",
      "icon": Icons.wb_sunny,
      "color": Colors.red,
      "isActive": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warning Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Configure alert preferences for severe weather warnings");
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
                    Icons.warning,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weather Alert System",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Stay informed about severe weather conditions in your area",
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

            Text(
              "Alert Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Severe Weather Alerts",
                        "value": true,
                        "checked": enableSevereWeatherAlerts,
                      }
                    ],
                    value: [
                      if (enableSevereWeatherAlerts)
                        {
                          "label": "Severe Weather Alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableSevereWeatherAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Tornado Warnings",
                        "value": true,
                        "checked": enableTornadoWarnings,
                      }
                    ],
                    value: [
                      if (enableTornadoWarnings)
                        {
                          "label": "Tornado Warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableTornadoWarnings = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Flood Alerts",
                        "value": true,
                        "checked": enableFloodAlerts,
                      }
                    ],
                    value: [
                      if (enableFloodAlerts)
                        {
                          "label": "Flood Alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableFloodAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Hurricane Warnings",
                        "value": true,
                        "checked": enableHurricaneWarnings,
                      }
                    ],
                    value: [
                      if (enableHurricaneWarnings)
                        {
                          "label": "Hurricane Warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableHurricaneWarnings = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Winter Storm Alerts",
                        "value": true,
                        "checked": enableWinterStormAlerts,
                      }
                    ],
                    value: [
                      if (enableWinterStormAlerts)
                        {
                          "label": "Winter Storm Alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableWinterStormAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Heat Warnings",
                        "value": true,
                        "checked": enableHeatWarnings,
                      }
                    ],
                    value: [
                      if (enableHeatWarnings)
                        {
                          "label": "Heat Warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableHeatWarnings = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Text(
              "Notification Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Sound Alerts",
                        "value": true,
                        "checked": enableSoundAlerts,
                      }
                    ],
                    value: [
                      if (enableSoundAlerts)
                        {
                          "label": "Sound Alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableSoundAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Vibration Alerts",
                        "value": true,
                        "checked": enableVibrationAlerts,
                      }
                    ],
                    value: [
                      if (enableVibrationAlerts)
                        {
                          "label": "Vibration Alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableVibrationAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Push Notifications",
                        "value": true,
                        "checked": enablePushNotifications,
                      }
                    ],
                    value: [
                      if (enablePushNotifications)
                        {
                          "label": "Push Notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enablePushNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Alert Radius",
                          items: radiusOptions,
                          value: alertRadius,
                          onChanged: (value, label) {
                            alertRadius = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Notification Timing",
                          items: timeOptions,
                          value: notificationTime,
                          onChanged: (value, label) {
                            notificationTime = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Text(
              "Recent Warnings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              children: recentWarnings.map((warning) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (warning["isActive"] as bool)
                        ? Border.all(color: warningColor, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (warning["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          warning["icon"] as IconData,
                          color: warning["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${warning["type"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warning["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${warning["severity"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (warning["isActive"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "ACTIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${warning["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: disabledBoldColor,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${warning["location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${warning["time"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

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
                        "Alert System Info",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Alerts are sourced from National Weather Service",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Critical warnings bypass Do Not Disturb settings",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Location services must be enabled for accurate alerts",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Test Alert System",
              size: bs.md,
              onPressed: () {
                showLoading();
                Future.delayed(Duration(seconds: 2), () {
                  hideLoading();
                  ss("Test alert sent successfully!");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

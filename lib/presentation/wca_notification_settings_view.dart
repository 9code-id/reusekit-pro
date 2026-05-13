import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaNotificationSettingsView extends StatefulWidget {
  const WcaNotificationSettingsView({super.key});

  @override
  State<WcaNotificationSettingsView> createState() => _WcaNotificationSettingsViewState();
}

class _WcaNotificationSettingsViewState extends State<WcaNotificationSettingsView> {
  bool pushNotifications = true;
  bool weatherAlerts = true;
  bool severeForecast = true;
  bool dailyForecast = false;
  bool hourlyForecast = false;
  bool rainAlerts = true;
  bool snowAlerts = true;
  bool windAlerts = true;
  bool temperatureAlerts = false;
  bool uvAlerts = true;
  bool airQualityAlerts = true;
  bool morningBriefing = true;
  bool eveningBriefing = false;
  bool weekendForecast = true;
  bool travelWeatherAlert = false;
  bool precipitationReminder = true;
  
  String alertTiming = "Immediate";
  String briefingTime = "08:00";
  String eveningTime = "18:00";
  String quietHoursStart = "22:00";
  String quietHoursEnd = "07:00";
  bool enableQuietHours = true;
  bool vibration = true;
  bool sound = true;
  String notificationTone = "Default";

  List<Map<String, dynamic>> alertTimingItems = [
    {"label": "Immediate", "value": "Immediate"},
    {"label": "5 minutes before", "value": "5min"},
    {"label": "15 minutes before", "value": "15min"},
    {"label": "30 minutes before", "value": "30min"},
    {"label": "1 hour before", "value": "1hour"},
  ];

  List<Map<String, dynamic>> toneItems = [
    {"label": "Default", "value": "Default"},
    {"label": "Rain Drop", "value": "RainDrop"},
    {"label": "Thunder", "value": "Thunder"},
    {"label": "Wind Chime", "value": "WindChime"},
    {"label": "Nature Sounds", "value": "Nature"},
    {"label": "Silent", "value": "Silent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              si("Test notification sent!");
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
            // Master Control Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Push Notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    label: "Enable Notifications",
                    items: [
                      {
                        "label": "Receive weather notifications",
                        "value": true,
                        "checked": pushNotifications,
                      }
                    ],
                    value: [
                      if (pushNotifications)
                        {
                          "label": "Receive weather notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      pushNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Weather Alerts Section
            Text(
              "Weather Alerts",
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
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Severe Weather Alerts",
                    items: [
                      {
                        "label": "Storm warnings, tornado alerts, severe weather",
                        "value": true,
                        "checked": severeForecast,
                      }
                    ],
                    value: [
                      if (severeForecast)
                        {
                          "label": "Storm warnings, tornado alerts, severe weather",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      severeForecast = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Rain Alerts",
                    items: [
                      {
                        "label": "Rain and precipitation warnings",
                        "value": true,
                        "checked": rainAlerts,
                      }
                    ],
                    value: [
                      if (rainAlerts)
                        {
                          "label": "Rain and precipitation warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      rainAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Snow Alerts",
                    items: [
                      {
                        "label": "Snow and winter weather warnings",
                        "value": true,
                        "checked": snowAlerts,
                      }
                    ],
                    value: [
                      if (snowAlerts)
                        {
                          "label": "Snow and winter weather warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      snowAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Wind Alerts",
                    items: [
                      {
                        "label": "High wind speed warnings",
                        "value": true,
                        "checked": windAlerts,
                      }
                    ],
                    value: [
                      if (windAlerts)
                        {
                          "label": "High wind speed warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      windAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Temperature Alerts",
                    items: [
                      {
                        "label": "Extreme temperature warnings",
                        "value": true,
                        "checked": temperatureAlerts,
                      }
                    ],
                    value: [
                      if (temperatureAlerts)
                        {
                          "label": "Extreme temperature warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      temperatureAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "UV Index Alerts",
                    items: [
                      {
                        "label": "High UV index warnings",
                        "value": true,
                        "checked": uvAlerts,
                      }
                    ],
                    value: [
                      if (uvAlerts)
                        {
                          "label": "High UV index warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      uvAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Air Quality Alerts",
                    items: [
                      {
                        "label": "Poor air quality warnings",
                        "value": true,
                        "checked": airQualityAlerts,
                      }
                    ],
                    value: [
                      if (airQualityAlerts)
                        {
                          "label": "Poor air quality warnings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      airQualityAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Forecast Notifications Section
            Text(
              "Forecast Notifications",
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
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Daily Forecast",
                    items: [
                      {
                        "label": "Daily weather summary notifications",
                        "value": true,
                        "checked": dailyForecast,
                      }
                    ],
                    value: [
                      if (dailyForecast)
                        {
                          "label": "Daily weather summary notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      dailyForecast = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Hourly Forecast",
                    items: [
                      {
                        "label": "Hourly weather update notifications",
                        "value": true,
                        "checked": hourlyForecast,
                      }
                    ],
                    value: [
                      if (hourlyForecast)
                        {
                          "label": "Hourly weather update notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      hourlyForecast = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Morning Briefing",
                    items: [
                      {
                        "label": "Daily morning weather briefing",
                        "value": true,
                        "checked": morningBriefing,
                      }
                    ],
                    value: [
                      if (morningBriefing)
                        {
                          "label": "Daily morning weather briefing",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      morningBriefing = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Evening Briefing",
                    items: [
                      {
                        "label": "Evening weather summary and tomorrow's forecast",
                        "value": true,
                        "checked": eveningBriefing,
                      }
                    ],
                    value: [
                      if (eveningBriefing)
                        {
                          "label": "Evening weather summary and tomorrow's forecast",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      eveningBriefing = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Weekend Forecast",
                    items: [
                      {
                        "label": "Weekly weekend weather forecast",
                        "value": true,
                        "checked": weekendForecast,
                      }
                    ],
                    value: [
                      if (weekendForecast)
                        {
                          "label": "Weekly weekend weather forecast",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      weekendForecast = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Timing Settings Section
            Text(
              "Timing Settings",
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
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Alert Timing",
                    items: alertTimingItems,
                    value: alertTiming,
                    onChanged: (value, label) {
                      alertTiming = value;
                      setState(() {});
                    },
                  ),
                  
                  QTimePicker(
                    label: "Morning Briefing Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 08:00:00")),
                    onChanged: (value) {
                      briefingTime = value!.kkmm;
                      setState(() {});
                    },
                  ),
                  
                  QTimePicker(
                    label: "Evening Briefing Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 18:00:00")),
                    onChanged: (value) {
                      eveningTime = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quiet Hours Section
            Text(
              "Quiet Hours",
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
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Enable Quiet Hours",
                    items: [
                      {
                        "label": "Silence non-critical notifications during quiet hours",
                        "value": true,
                        "checked": enableQuietHours,
                      }
                    ],
                    value: [
                      if (enableQuietHours)
                        {
                          "label": "Silence non-critical notifications during quiet hours",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableQuietHours = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QTimePicker(
                          label: "Quiet Hours Start",
                          value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 22:00:00")),
                          onChanged: (value) {
                            quietHoursStart = value!.kkmm;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Quiet Hours End",
                          value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 07:00:00")),
                          onChanged: (value) {
                            quietHoursEnd = value!.kkmm;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sound & Vibration Section
            Text(
              "Sound & Vibration",
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
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Sound",
                    items: [
                      {
                        "label": "Play notification sound",
                        "value": true,
                        "checked": sound,
                      }
                    ],
                    value: [
                      if (sound)
                        {
                          "label": "Play notification sound",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      sound = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Vibration",
                    items: [
                      {
                        "label": "Vibrate for notifications",
                        "value": true,
                        "checked": vibration,
                      }
                    ],
                    value: [
                      if (vibration)
                        {
                          "label": "Vibrate for notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      vibration = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Notification Tone",
                    items: toneItems,
                    value: notificationTone,
                    onChanged: (value, label) {
                      notificationTone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Notification Settings",
              size: bs.md,
              onPressed: () {
                ss("Notification settings saved successfully!");
              },
            ),
          ],
        ),
      ),
    );
  }
}

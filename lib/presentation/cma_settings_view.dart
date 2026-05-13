import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSettingsView extends StatefulWidget {
  const CmaSettingsView({super.key});

  @override
  State<CmaSettingsView> createState() => _CmaSettingsViewState();
}

class _CmaSettingsViewState extends State<CmaSettingsView> {
  bool notificationsEnabled = true;
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool locationTracking = true;
  bool automaticReports = true;
  bool dataSharing = false;
  bool biometricLogin = true;
  String language = "en";
  String temperatureUnit = "fahrenheit";
  String distanceUnit = "miles";
  String currency = "usd";
  String timezone = "pst";
  String reportFrequency = "weekly";
  String dataRetention = "1year";
  
  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
  ];

  List<Map<String, dynamic>> temperatureUnits = [
    {"label": "Fahrenheit (°F)", "value": "fahrenheit"},
    {"label": "Celsius (°C)", "value": "celsius"},
  ];

  List<Map<String, dynamic>> distanceUnits = [
    {"label": "Miles", "value": "miles"},
    {"label": "Kilometers", "value": "kilometers"},
  ];

  List<Map<String, dynamic>> currencies = [
    {"label": "US Dollar (USD)", "value": "usd"},
    {"label": "Euro (EUR)", "value": "eur"},
    {"label": "British Pound (GBP)", "value": "gbp"},
    {"label": "Canadian Dollar (CAD)", "value": "cad"},
    {"label": "Australian Dollar (AUD)", "value": "aud"},
  ];

  List<Map<String, dynamic>> timezones = [
    {"label": "Pacific Standard Time", "value": "pst"},
    {"label": "Eastern Standard Time", "value": "est"},
    {"label": "Central Standard Time", "value": "cst"},
    {"label": "Mountain Standard Time", "value": "mst"},
    {"label": "Greenwich Mean Time", "value": "gmt"},
  ];

  List<Map<String, dynamic>> reportFrequencies = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> dataRetentionOptions = [
    {"label": "6 Months", "value": "6months"},
    {"label": "1 Year", "value": "1year"},
    {"label": "2 Years", "value": "2years"},
    {"label": "5 Years", "value": "5years"},
    {"label": "Forever", "value": "forever"},
  ];

  List<Map<String, dynamic>> connectedServices = [
    {
      "name": "Google Drive",
      "description": "Backup reports and data",
      "connected": true,
      "icon": Icons.cloud,
      "status": "Active"
    },
    {
      "name": "Microsoft OneDrive",
      "description": "Document synchronization",
      "connected": false,
      "icon": Icons.cloud_queue,
      "status": "Disconnected"
    },
    {
      "name": "Dropbox",
      "description": "File storage and sharing",
      "connected": true,
      "icon": Icons.cloud_upload,
      "status": "Active"
    },
    {
      "name": "Slack",
      "description": "Team notifications",
      "connected": false,
      "icon": Icons.chat,
      "status": "Disconnected"
    },
    {
      "name": "Microsoft Teams",
      "description": "Collaboration platform",
      "connected": true,
      "icon": Icons.group,
      "status": "Active"
    }
  ];

  List<Map<String, dynamic>> accountInfo = [
    {
      "label": "Account Type",
      "value": "Premium",
      "icon": Icons.star,
      "editable": false
    },
    {
      "label": "Organization",
      "value": "TechCorp Fleet Services",
      "icon": Icons.business,
      "editable": true
    },
    {
      "label": "License",
      "value": "Fleet Manager Pro",
      "icon": Icons.assignment,
      "editable": false
    },
    {
      "label": "Subscription",
      "value": "Valid until Dec 2024",
      "icon": Icons.event,
      "editable": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Account Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Account Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...accountInfo.map((info) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            info["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${info["label"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${info["value"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (info["editable"] == true)
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Notification Settings
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
                  Row(
                    children: [
                      Icon(Icons.notifications, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Notification Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable Notifications",
                              "value": true,
                              "checked": notificationsEnabled,
                            }
                          ],
                          value: [
                            if (notificationsEnabled)
                              {
                                "label": "Enable Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            notificationsEnabled = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (notificationsEnabled) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Push Notifications",
                                "value": true,
                                "checked": pushNotifications,
                              }
                            ],
                            value: [
                              if (pushNotifications)
                                {
                                  "label": "Push Notifications",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              pushNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Email Notifications",
                                "value": true,
                                "checked": emailNotifications,
                              }
                            ],
                            value: [
                              if (emailNotifications)
                                {
                                  "label": "Email Notifications",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              emailNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "SMS Notifications",
                                "value": true,
                                "checked": smsNotifications,
                              }
                            ],
                            value: [
                              if (smsNotifications)
                                {
                                  "label": "SMS Notifications",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              smsNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Privacy & Security
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
                  Row(
                    children: [
                      Icon(Icons.security, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy & Security",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Location Tracking",
                              "value": true,
                              "checked": locationTracking,
                            }
                          ],
                          value: [
                            if (locationTracking)
                              {
                                "label": "Location Tracking",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            locationTracking = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Data Sharing with Partners",
                              "value": true,
                              "checked": dataSharing,
                            }
                          ],
                          value: [
                            if (dataSharing)
                              {
                                "label": "Data Sharing with Partners",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            dataSharing = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Biometric Login",
                              "value": true,
                              "checked": biometricLogin,
                            }
                          ],
                          value: [
                            if (biometricLogin)
                              {
                                "label": "Biometric Login",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            biometricLogin = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Data Retention Period",
                    items: dataRetentionOptions,
                    value: dataRetention,
                    onChanged: (value, label) {
                      dataRetention = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // App Preferences
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
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "App Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languages,
                          value: language,
                          onChanged: (value, label) {
                            language = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Timezone",
                          items: timezones,
                          value: timezone,
                          onChanged: (value, label) {
                            timezone = value;
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
                          label: "Temperature Unit",
                          items: temperatureUnits,
                          value: temperatureUnit,
                          onChanged: (value, label) {
                            temperatureUnit = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Distance Unit",
                          items: distanceUnits,
                          value: distanceUnit,
                          onChanged: (value, label) {
                            distanceUnit = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Currency",
                    items: currencies,
                    value: currency,
                    onChanged: (value, label) {
                      currency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Report Settings
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
                  Row(
                    children: [
                      Icon(Icons.assessment, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Report Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Automatic Reports",
                              "value": true,
                              "checked": automaticReports,
                            }
                          ],
                          value: [
                            if (automaticReports)
                              {
                                "label": "Automatic Reports",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            automaticReports = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (automaticReports)
                    QDropdownField(
                      label: "Report Frequency",
                      items: reportFrequencies,
                      value: reportFrequency,
                      onChanged: (value, label) {
                        reportFrequency = value;
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Connected Services
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.link, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Connected Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...connectedServices.map((service) {
                    Color statusColor = service["connected"] ? successColor : disabledBoldColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              service["icon"] as IconData,
                              color: statusColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${service["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${service["status"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${service["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: service["connected"] ? Icons.link_off : Icons.link,
                            size: bs.sm,
                            onPressed: () {
                              service["connected"] = !service["connected"];
                              service["status"] = service["connected"] ? "Active" : "Disconnected";
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // System Information
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
                  Row(
                    children: [
                      Icon(Icons.info, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "System Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "App Version",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "2.1.4",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Build Number",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "20240619.1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Last Updated",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "June 19, 2024",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Settings",
                        icon: Icons.file_download,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reset to Default",
                        icon: Icons.refresh,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Settings",
                    icon: Icons.save,
                    onPressed: () {},
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

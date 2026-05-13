import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSystemConfigurationView extends StatefulWidget {
  const FmaSystemConfigurationView({super.key});

  @override
  State<FmaSystemConfigurationView> createState() => _FmaSystemConfigurationViewState();
}

class _FmaSystemConfigurationViewState extends State<FmaSystemConfigurationView> {
  String systemName = "File Management System";
  String systemVersion = "v2.1.4";
  String organizationName = "TechCorp Solutions";
  String adminEmail = "admin@techcorp.com";
  String timeZone = "UTC+7";
  String dateFormat = "DD/MM/YYYY";
  String language = "en";
  String maxFileSize = "100";
  String sessionTimeout = "30";
  String backupSchedule = "daily";
  bool maintenanceMode = false;
  bool emailNotifications = true;
  bool systemLogging = true;
  bool debugMode = false;
  bool autoUpdates = true;
  
  List<Map<String, dynamic>> timeZoneOptions = [
    {"label": "UTC+7 (Jakarta)", "value": "UTC+7"},
    {"label": "UTC+8 (Singapore)", "value": "UTC+8"},
    {"label": "UTC+9 (Tokyo)", "value": "UTC+9"},
    {"label": "UTC+0 (London)", "value": "UTC+0"},
    {"label": "UTC-5 (New York)", "value": "UTC-5"}
  ];

  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
    {"label": "DD-MM-YYYY", "value": "DD-MM-YYYY"}
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Indonesian", "value": "id"},
    {"label": "Japanese", "value": "ja"},
    {"label": "Chinese", "value": "zh"}
  ];

  List<Map<String, dynamic>> fileSizeOptions = [
    {"label": "50 MB", "value": "50"},
    {"label": "100 MB", "value": "100"},
    {"label": "200 MB", "value": "200"},
    {"label": "500 MB", "value": "500"},
    {"label": "1 GB", "value": "1000"}
  ];

  List<Map<String, dynamic>> sessionOptions = [
    {"label": "15 Minutes", "value": "15"},
    {"label": "30 Minutes", "value": "30"},
    {"label": "1 Hour", "value": "60"},
    {"label": "2 Hours", "value": "120"}
  ];

  List<Map<String, dynamic>> backupOptions = [
    {"label": "Every 6 Hours", "value": "6hours"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Configuration"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveConfiguration();
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
            // System Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.info,
                        color: primaryColor,
                        size: 24,
                      ),
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
                  QTextField(
                    label: "System Name",
                    value: systemName,
                    onChanged: (value) {
                      systemName = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "System Version",
                          value: systemVersion,
                          onChanged: (value) {
                            systemVersion = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QTextField(
                          label: "Organization Name",
                          value: organizationName,
                          onChanged: (value) {
                            organizationName = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Admin Email",
                    value: adminEmail,
                    onChanged: (value) {
                      adminEmail = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Regional Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Regional Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Zone",
                          items: timeZoneOptions,
                          value: timeZone,
                          onChanged: (value, label) {
                            timeZone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Format",
                          items: dateFormatOptions,
                          value: dateFormat,
                          onChanged: (value, label) {
                            dateFormat = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Default Language",
                    items: languageOptions,
                    value: language,
                    onChanged: (value, label) {
                      language = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // File Management Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.folder,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "File Management Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Maximum File Size",
                          items: fileSizeOptions,
                          value: maxFileSize,
                          onChanged: (value, label) {
                            maxFileSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Session Timeout",
                          items: sessionOptions,
                          value: sessionTimeout,
                          onChanged: (value, label) {
                            sessionTimeout = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Backup Schedule",
                    items: backupOptions,
                    value: backupSchedule,
                    onChanged: (value, label) {
                      backupSchedule = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // System Modes
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "System Modes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Maintenance Mode",
                        "value": true,
                        "checked": maintenanceMode,
                      }
                    ],
                    value: [
                      if (maintenanceMode)
                        {
                          "label": "Maintenance Mode",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      maintenanceMode = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Debug Mode",
                        "value": true,
                        "checked": debugMode,
                      }
                    ],
                    value: [
                      if (debugMode)
                        {
                          "label": "Debug Mode",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      debugMode = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Auto Updates",
                        "value": true,
                        "checked": autoUpdates,
                      }
                    ],
                    value: [
                      if (autoUpdates)
                        {
                          "label": "Auto Updates",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoUpdates = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Notification Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 24,
                      ),
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
                  QSwitch(
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
                  QSwitch(
                    items: [
                      {
                        "label": "System Logging",
                        "value": true,
                        "checked": systemLogging,
                      }
                    ],
                    value: [
                      if (systemLogging)
                        {
                          "label": "System Logging",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      systemLogging = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Configuration",
                    onPressed: () {
                      _saveConfiguration();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Reset to Default",
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to reset all settings to default values?");
                      if (isConfirmed) {
                        _resetToDefaults();
                      }
                    },
                  ),
                ),
              ],
            ),

            // System Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.monitor_heart,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "System Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: successColor,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "System Health",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Excellent",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: infoColor,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "Uptime",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "99.9%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: warningColor,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "Storage Used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "78%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
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

  void _saveConfiguration() {
    ss("System configuration saved successfully");
  }

  void _resetToDefaults() {
    setState(() {
      systemName = "File Management System";
      systemVersion = "v2.1.4";
      organizationName = "TechCorp Solutions";
      adminEmail = "admin@techcorp.com";
      timeZone = "UTC+7";
      dateFormat = "DD/MM/YYYY";
      language = "en";
      maxFileSize = "100";
      sessionTimeout = "30";
      backupSchedule = "daily";
      maintenanceMode = false;
      emailNotifications = true;
      systemLogging = true;
      debugMode = false;
      autoUpdates = true;
    });
    ss("Configuration reset to default values");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaSettingsView extends StatefulWidget {
  const PmaSettingsView({super.key});

  @override
  State<PmaSettingsView> createState() => _PmaSettingsViewState();
}

class _PmaSettingsViewState extends State<PmaSettingsView> {
  String selectedLanguage = "English";
  String selectedTheme = "Auto";
  String selectedTimeZone = "UTC+7 (Asia/Jakarta)";
  String selectedDateFormat = "DD/MM/YYYY";
  String selectedTimeFormat = "24 Hour";
  String projectPrefix = "PMA";
  String taskPrefix = "TSK";
  
  bool enableNotifications = true;
  bool enableEmailAlerts = true;
  bool enablePushNotifications = false;
  bool enableSoundAlerts = true;
  bool enableDesktopNotifications = true;
  
  bool enableTwoFactor = false;
  bool requirePasswordChange = false;
  bool enableSessionTimeout = true;
  bool allowMultipleSessions = true;
  
  bool enableDataExport = true;
  bool enableDataImport = false;
  bool enableAutoBackup = true;
  bool enableAuditLog = true;
  
  String sessionTimeout = "30";
  String passwordExpiryDays = "90";
  String maxLoginAttempts = "5";

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "English"},
    {"label": "Indonesian", "value": "Indonesian"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
  ];

  List<Map<String, dynamic>> themes = [
    {"label": "Auto", "value": "Auto"},
    {"label": "Light", "value": "Light"},
    {"label": "Dark", "value": "Dark"},
  ];

  List<Map<String, dynamic>> timeZones = [
    {"label": "UTC+7 (Asia/Jakarta)", "value": "UTC+7 (Asia/Jakarta)"},
    {"label": "UTC+0 (London)", "value": "UTC+0 (London)"},
    {"label": "UTC-5 (New York)", "value": "UTC-5 (New York)"},
    {"label": "UTC+9 (Tokyo)", "value": "UTC+9 (Tokyo)"},
  ];

  List<Map<String, dynamic>> dateFormats = [
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
  ];

  List<Map<String, dynamic>> timeFormats = [
    {"label": "24 Hour", "value": "24 Hour"},
    {"label": "12 Hour", "value": "12 Hour"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () => _saveSettings(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildGeneralSettings(),
            _buildNotificationSettings(),
            _buildSecuritySettings(),
            _buildDataManagement(),
            _buildSystemConfiguration(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "General Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Language",
            items: languages,
            value: selectedLanguage,
            onChanged: (value, label) {
              selectedLanguage = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Theme",
            items: themes,
            value: selectedTheme,
            onChanged: (value, label) {
              selectedTheme = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Time Zone",
            items: timeZones,
            value: selectedTimeZone,
            onChanged: (value, label) {
              selectedTimeZone = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Date Format",
                  items: dateFormats,
                  value: selectedDateFormat,
                  onChanged: (value, label) {
                    selectedDateFormat = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Time Format",
                  items: timeFormats,
                  value: selectedTimeFormat,
                  onChanged: (value, label) {
                    selectedTimeFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Project Prefix",
                  value: projectPrefix,
                  onChanged: (value) {
                    projectPrefix = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Task Prefix",
                  value: taskPrefix,
                  onChanged: (value) {
                    taskPrefix = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.notifications, color: warningColor, size: 20),
              SizedBox(width: spXs),
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
          Column(
            spacing: spXs,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Enable notifications",
                    "value": true,
                    "checked": enableNotifications,
                  }
                ],
                value: [if (enableNotifications) {"label": "Enable notifications", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableNotifications = values.isNotEmpty;
                  setState(() {});
                },
              ),
              if (enableNotifications) ...[
                QSwitch(
                  items: [
                    {
                      "label": "Email alerts",
                      "value": true,
                      "checked": enableEmailAlerts,
                    }
                  ],
                  value: [if (enableEmailAlerts) {"label": "Email alerts", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    enableEmailAlerts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Push notifications",
                      "value": true,
                      "checked": enablePushNotifications,
                    }
                  ],
                  value: [if (enablePushNotifications) {"label": "Push notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    enablePushNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Sound alerts",
                      "value": true,
                      "checked": enableSoundAlerts,
                    }
                  ],
                  value: [if (enableSoundAlerts) {"label": "Sound alerts", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    enableSoundAlerts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Desktop notifications",
                      "value": true,
                      "checked": enableDesktopNotifications,
                    }
                  ],
                  value: [if (enableDesktopNotifications) {"label": "Desktop notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    enableDesktopNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ],
          ),
          if (!enableNotifications)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "You won't receive any notifications when disabled",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: dangerColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Security Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Enable two-factor authentication",
                    "value": true,
                    "checked": enableTwoFactor,
                  }
                ],
                value: [if (enableTwoFactor) {"label": "Enable two-factor authentication", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableTwoFactor = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Require periodic password change",
                    "value": true,
                    "checked": requirePasswordChange,
                  }
                ],
                value: [if (requirePasswordChange) {"label": "Require periodic password change", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  requirePasswordChange = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable session timeout",
                    "value": true,
                    "checked": enableSessionTimeout,
                  }
                ],
                value: [if (enableSessionTimeout) {"label": "Enable session timeout", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableSessionTimeout = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Allow multiple sessions",
                    "value": true,
                    "checked": allowMultipleSessions,
                  }
                ],
                value: [if (allowMultipleSessions) {"label": "Allow multiple sessions", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  allowMultipleSessions = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              QTextField(
                label: "Session Timeout (minutes)",
                value: sessionTimeout,
                onChanged: (value) {
                  sessionTimeout = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Password Expiry (days)",
                value: passwordExpiryDays,
                onChanged: (value) {
                  passwordExpiryDays = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Max Login Attempts",
                value: maxLoginAttempts,
                onChanged: (value) {
                  maxLoginAttempts = value;
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.shield, color: dangerColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Security Status",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Two-factor authentication: ${enableTwoFactor ? 'Enabled' : 'Disabled'}",
                  style: TextStyle(
                    fontSize: 11,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Last password change: 15 days ago",
                  style: TextStyle(
                    fontSize: 11,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagement() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.storage, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Data Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Enable data export",
                    "value": true,
                    "checked": enableDataExport,
                  }
                ],
                value: [if (enableDataExport) {"label": "Enable data export", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableDataExport = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable data import",
                    "value": true,
                    "checked": enableDataImport,
                  }
                ],
                value: [if (enableDataImport) {"label": "Enable data import", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableDataImport = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable automatic backup",
                    "value": true,
                    "checked": enableAutoBackup,
                  }
                ],
                value: [if (enableAutoBackup) {"label": "Enable automatic backup", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableAutoBackup = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable audit logging",
                    "value": true,
                    "checked": enableAuditLog,
                  }
                ],
                value: [if (enableAuditLog) {"label": "Enable audit logging", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  enableAuditLog = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionButton(
                "Export Data",
                "Download all project data",
                Icons.download,
                infoColor,
                enableDataExport,
                () => _exportData(),
              ),
              _buildActionButton(
                "Import Data",
                "Upload data from file",
                Icons.upload,
                successColor,
                enableDataImport,
                () => _importData(),
              ),
              _buildActionButton(
                "Clear Cache",
                "Clear application cache",
                Icons.clear_all,
                warningColor,
                true,
                () => _clearCache(),
              ),
              _buildActionButton(
                "Reset Settings",
                "Reset to default settings",
                Icons.restart_alt,
                dangerColor,
                true,
                () => _resetSettings(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, String description, IconData icon, Color color, bool enabled, VoidCallback onTap) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: enabled ? color.withAlpha(5) : disabledColor.withAlpha(5),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: enabled ? color.withAlpha(20) : disabledOutlineBorderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Icon(
              icon, 
              color: enabled ? color : disabledBoldColor, 
              size: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: enabled ? color : disabledBoldColor,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: enabled ? disabledBoldColor : disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemConfiguration() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.build, color: secondaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "System Configuration",
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
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "System Information",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 150,
                  children: [
                    _buildSystemInfo("Version", "1.2.3"),
                    _buildSystemInfo("Build", "20240619"),
                    _buildSystemInfo("Environment", "Production"),
                    _buildSystemInfo("Database", "PostgreSQL 15"),
                    _buildSystemInfo("Cache", "Redis 7.0"),
                    _buildSystemInfo("Storage", "AWS S3"),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Check Updates",
                  size: bs.sm,
                  onPressed: () => _checkUpdates(),
                ),
              ),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () => _showSystemInfo(),
              ),
              QButton(
                icon: Icons.bug_report,
                size: bs.sm,
                onPressed: () => _reportBug(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _saveSettings() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Settings saved successfully");
    });
  }

  void _exportData() {
    showLoading();
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Data export completed successfully");
    });
  }

  void _importData() {
    si("Opening file picker for data import");
  }

  void _clearCache() async {
    final confirmed = await confirm("Clear all application cache? This may slow down the app temporarily.");
    if (confirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Cache cleared successfully");
      });
    }
  }

  void _resetSettings() async {
    final confirmed = await confirm("Reset all settings to default values? This action cannot be undone.");
    if (confirmed) {
      setState(() {
        selectedLanguage = "English";
        selectedTheme = "Auto";
        selectedTimeZone = "UTC+7 (Asia/Jakarta)";
        selectedDateFormat = "DD/MM/YYYY";
        selectedTimeFormat = "24 Hour";
        projectPrefix = "PMA";
        taskPrefix = "TSK";
        enableNotifications = true;
        enableEmailAlerts = true;
        enablePushNotifications = false;
        enableSoundAlerts = true;
        enableDesktopNotifications = true;
        enableTwoFactor = false;
        requirePasswordChange = false;
        enableSessionTimeout = true;
        allowMultipleSessions = true;
        enableDataExport = true;
        enableDataImport = false;
        enableAutoBackup = true;
        enableAuditLog = true;
        sessionTimeout = "30";
        passwordExpiryDays = "90";
        maxLoginAttempts = "5";
      });
      ss("Settings reset to default values");
    }
  }

  void _checkUpdates() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      si("You are running the latest version");
    });
  }

  void _showSystemInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("System Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Version: 1.2.3"),
            Text("Build: 20240619"),
            Text("Environment: Production"),
            Text("Database: PostgreSQL 15"),
            Text("Cache: Redis 7.0"),
            Text("Storage: AWS S3"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _reportBug() {
    si("Opening bug report form");
  }
}

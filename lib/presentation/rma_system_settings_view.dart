import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSystemSettingsView extends StatefulWidget {
  const RmaSystemSettingsView({super.key});

  @override
  State<RmaSystemSettingsView> createState() => _RmaSystemSettingsViewState();
}

class _RmaSystemSettingsViewState extends State<RmaSystemSettingsView> {
  bool autoAcceptOrders = false;
  bool lowStockAlerts = true;
  bool orderNotifications = true;
  bool paymentAlerts = true;
  bool systemMaintenance = false;
  String selectedLanguage = "english";
  String selectedTimeZone = "UTC";
  String autoBackupFrequency = "daily";
  String orderRetentionPeriod = "365";
  String reportRetentionPeriod = "1095";
  bool enableDebugMode = false;
  bool enableAnalytics = true;
  bool enableCrashReporting = true;
  String maxConcurrentOrders = "50";
  String sessionTimeout = "30";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
  ];

  List<Map<String, dynamic>> timeZoneOptions = [
    {"label": "UTC (Coordinated Universal Time)", "value": "UTC"},
    {"label": "EST (Eastern Standard Time)", "value": "EST"},
    {"label": "PST (Pacific Standard Time)", "value": "PST"},
    {"label": "CST (Central Standard Time)", "value": "CST"},
    {"label": "MST (Mountain Standard Time)", "value": "MST"},
  ];

  List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildOrderManagementSection(),
            _buildSystemPreferencesSection(),
            _buildDataManagementSection(),
            _buildPerformanceSection(),
            _buildDeveloperSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderManagementSection() {
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
          Text(
            "Order Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "System Automation",
            items: [
              {
                "label": "Auto-accept orders",
                "value": "auto_accept",
                "checked": autoAcceptOrders,
              },
              {
                "label": "Low stock alerts",
                "value": "low_stock",
                "checked": lowStockAlerts,
              },
              {
                "label": "Order notifications",
                "value": "order_notifications",
                "checked": orderNotifications,
              },
              {
                "label": "Payment alerts",
                "value": "payment_alerts",
                "checked": paymentAlerts,
              },
            ],
            value: [
              if (autoAcceptOrders) {"label": "Auto-accept orders", "value": "auto_accept", "checked": true},
              if (lowStockAlerts) {"label": "Low stock alerts", "value": "low_stock", "checked": true},
              if (orderNotifications) {"label": "Order notifications", "value": "order_notifications", "checked": true},
              if (paymentAlerts) {"label": "Payment alerts", "value": "payment_alerts", "checked": true},
            ],
            onChanged: (values, ids) {
              autoAcceptOrders = values.any((v) => v["value"] == "auto_accept");
              lowStockAlerts = values.any((v) => v["value"] == "low_stock");
              orderNotifications = values.any((v) => v["value"] == "order_notifications");
              paymentAlerts = values.any((v) => v["value"] == "payment_alerts");
              setState(() {});
            },
          ),
          QNumberField(
            label: "Max Concurrent Orders",
            value: maxConcurrentOrders,
            hint: "Maximum orders processed simultaneously",
            onChanged: (value) {
              maxConcurrentOrders = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSystemPreferencesSection() {
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
          Text(
            "System Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "System Language",
            items: languageOptions,
            value: selectedLanguage,
            onChanged: (value, label) {
              selectedLanguage = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Time Zone",
            items: timeZoneOptions,
            value: selectedTimeZone,
            onChanged: (value, label) {
              selectedTimeZone = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Session Timeout (minutes)",
            value: sessionTimeout,
            hint: "Automatic logout after inactivity",
            onChanged: (value) {
              sessionTimeout = value;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Maintenance Mode",
            items: [
              {
                "label": "Enable system maintenance mode",
                "value": true,
                "checked": systemMaintenance,
              }
            ],
            value: [if (systemMaintenance) {"label": "Enable system maintenance mode", "value": true, "checked": true}],
            onChanged: (values, ids) {
              systemMaintenance = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
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
          Text(
            "Data Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Auto Backup Frequency",
            items: backupFrequencyOptions,
            value: autoBackupFrequency,
            onChanged: (value, label) {
              autoBackupFrequency = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Order Retention (days)",
                  value: orderRetentionPeriod,
                  onChanged: (value) {
                    orderRetentionPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Report Retention (days)",
                  value: reportRetentionPeriod,
                  onChanged: (value) {
                    reportRetentionPeriod = value;
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

  Widget _buildPerformanceSection() {
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
          Text(
            "Performance & Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "Performance Settings",
            items: [
              {
                "label": "Enable analytics",
                "value": "analytics",
                "checked": enableAnalytics,
              },
              {
                "label": "Crash reporting",
                "value": "crash_reporting",
                "checked": enableCrashReporting,
              },
            ],
            value: [
              if (enableAnalytics) {"label": "Enable analytics", "value": "analytics", "checked": true},
              if (enableCrashReporting) {"label": "Crash reporting", "value": "crash_reporting", "checked": true},
            ],
            onChanged: (values, ids) {
              enableAnalytics = values.any((v) => v["value"] == "analytics");
              enableCrashReporting = values.any((v) => v["value"] == "crash_reporting");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperSection() {
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
          Text(
            "Developer Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
          QSwitch(
            label: "Debug Mode",
            items: [
              {
                "label": "Enable debug mode (not recommended for production)",
                "value": true,
                "checked": enableDebugMode,
              }
            ],
            value: [if (enableDebugMode) {"label": "Enable debug mode (not recommended for production)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableDebugMode = values.isNotEmpty;
              setState(() {});
            },
          ),
          Row(
            children: [
              QButton(
                label: "Export Logs",
                size: bs.sm,
                onPressed: () => _exportLogs(),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Clear Cache",
                color: warningColor,
                size: bs.sm,
                onPressed: () => _clearCache(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save All Settings",
            onPressed: () => _saveSettings(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Reset to Factory Defaults",
            color: dangerColor,
            onPressed: () => _resetToDefaults(),
          ),
        ),
      ],
    );
  }

  void _saveSettings() {
    ss("System settings saved successfully");
  }

  void _exportLogs() {
    si("System logs exported successfully");
  }

  void _clearCache() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all system cache?");
    if (isConfirmed) {
      ss("System cache cleared successfully");
    }
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to factory defaults? This action cannot be undone.");
    if (isConfirmed) {
      autoAcceptOrders = false;
      lowStockAlerts = true;
      orderNotifications = true;
      paymentAlerts = true;
      systemMaintenance = false;
      selectedLanguage = "english";
      selectedTimeZone = "UTC";
      autoBackupFrequency = "daily";
      orderRetentionPeriod = "365";
      reportRetentionPeriod = "1095";
      enableDebugMode = false;
      enableAnalytics = true;
      enableCrashReporting = true;
      maxConcurrentOrders = "50";
      sessionTimeout = "30";
      setState(() {});
      si("Settings reset to factory defaults");
    }
  }
}

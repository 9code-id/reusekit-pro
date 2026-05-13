import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSettingsView extends StatefulWidget {
  const IwmSettingsView({super.key});

  @override
  State<IwmSettingsView> createState() => _IwmSettingsViewState();
}

class _IwmSettingsViewState extends State<IwmSettingsView> {
  int selectedTab = 0;
  
  // General Settings
  bool enableNotifications = true;
  bool enableEmailAlerts = true;
  bool enableSMSAlerts = false;
  bool enableDarkMode = false;
  bool enableAutoBackup = true;
  bool requireTwoFactor = false;
  String defaultLanguage = "en";
  String timeZone = "UTC";
  String currency = "USD";
  
  // Inventory Settings
  bool enableLowStockAlerts = true;
  bool enableExpiryAlerts = true;
  bool autoCalculateReorderPoint = true;
  bool requireApprovalForAdjustments = true;
  String lowStockThreshold = "10";
  String reorderLeadTime = "7";
  String defaultLocation = "main";
  
  // Mobile App Settings
  bool enableOfflineMode = true;
  bool enableBarcodeScanning = true;
  bool enableVoiceCommands = false;
  bool enableHapticFeedback = true;
  bool autoSyncData = true;
  String syncFrequency = "15";
  String cameraQuality = "high";
  
  // Security Settings
  bool enableSessionTimeout = true;
  bool enableAuditLogging = true;
  bool requirePasswordChange = false;
  String sessionTimeout = "30";
  String passwordPolicy = "medium";
  String backupFrequency = "daily";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC", "value": "UTC"},
    {"label": "EST (Eastern)", "value": "EST"},
    {"label": "PST (Pacific)", "value": "PST"},
    {"label": "CST (Central)", "value": "CST"},
    {"label": "GMT (Greenwich)", "value": "GMT"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "JPY - Japanese Yen", "value": "JPY"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Secondary Storage", "value": "secondary"},
    {"label": "Receiving Dock", "value": "receiving"},
    {"label": "Shipping Area", "value": "shipping"},
  ];

  List<Map<String, dynamic>> syncFrequencyOptions = [
    {"label": "Every 5 minutes", "value": "5"},
    {"label": "Every 15 minutes", "value": "15"},
    {"label": "Every 30 minutes", "value": "30"},
    {"label": "Every hour", "value": "60"},
    {"label": "Manual only", "value": "manual"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "High Quality", "value": "high"},
    {"label": "Medium Quality", "value": "medium"},
    {"label": "Low Quality", "value": "low"},
  ];

  List<Map<String, dynamic>> timeoutOptions = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "2 hours", "value": "120"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> policyOptions = [
    {"label": "Basic (6+ characters)", "value": "basic"},
    {"label": "Medium (8+ chars, mixed case)", "value": "medium"},
    {"label": "Strong (12+ chars, symbols)", "value": "strong"},
  ];

  List<Map<String, dynamic>> backupOptions = [
    {"label": "Every hour", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Manual only", "value": "manual"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "System Settings",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Mobile", icon: Icon(Icons.phone_android)),
        Tab(text: "Security", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildInventoryTab(),
        _buildMobileTab(),
        _buildSecurityTab(),
      ],
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildNotificationSettings(),
          _buildDisplaySettings(),
          _buildRegionalSettings(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAlertSettings(),
          _buildInventoryRules(),
          _buildDefaultSettings(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildMobileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMobileFeatures(),
          _buildSyncSettings(),
          _buildCameraSettings(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSecurityFeatures(),
          _buildPasswordSettings(),
          _buildBackupSettings(),
          _buildSaveButton(),
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Push Notifications",
                "value": true,
                "checked": enableNotifications,
              }
            ],
            value: [if (enableNotifications) {"label": "Enable Push Notifications", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Email Alerts",
                "value": true,
                "checked": enableEmailAlerts,
              }
            ],
            value: [if (enableEmailAlerts) {"label": "Email Alerts", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableEmailAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "SMS Alerts",
                "value": true,
                "checked": enableSMSAlerts,
              }
            ],
            value: [if (enableSMSAlerts) {"label": "SMS Alerts", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableSMSAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDisplaySettings() {
    return Container(
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
          Text(
            "Display Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Dark Mode",
                "value": true,
                "checked": enableDarkMode,
              }
            ],
            value: [if (enableDarkMode) {"label": "Enable Dark Mode", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableDarkMode = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Language",
            items: languageOptions,
            value: defaultLanguage,
            onChanged: (value, label) {
              defaultLanguage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalSettings() {
    return Container(
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
          Text(
            "Regional Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Time Zone",
            items: timezoneOptions,
            value: timeZone,
            onChanged: (value, label) {
              timeZone = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Default Currency",
            items: currencyOptions,
            value: currency,
            onChanged: (value, label) {
              currency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSettings() {
    return Container(
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
          Text(
            "Stock Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Low Stock Alerts",
                "value": true,
                "checked": enableLowStockAlerts,
              }
            ],
            value: [if (enableLowStockAlerts) {"label": "Low Stock Alerts", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableLowStockAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Expiry Date Alerts",
                "value": true,
                "checked": enableExpiryAlerts,
              }
            ],
            value: [if (enableExpiryAlerts) {"label": "Expiry Date Alerts", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableExpiryAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Low Stock Threshold",
            value: lowStockThreshold,
            onChanged: (value) {
              lowStockThreshold = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryRules() {
    return Container(
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
          Text(
            "Inventory Rules",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-calculate Reorder Points",
                "value": true,
                "checked": autoCalculateReorderPoint,
              }
            ],
            value: [if (autoCalculateReorderPoint) {"label": "Auto-calculate Reorder Points", "value": true, "checked": true}],
            onChanged: (values, ids) {
              autoCalculateReorderPoint = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Require Approval for Adjustments",
                "value": true,
                "checked": requireApprovalForAdjustments,
              }
            ],
            value: [if (requireApprovalForAdjustments) {"label": "Require Approval for Adjustments", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requireApprovalForAdjustments = values.isNotEmpty;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Default Reorder Lead Time (days)",
            value: reorderLeadTime,
            onChanged: (value) {
              reorderLeadTime = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSettings() {
    return Container(
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
          Text(
            "Default Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Default Location",
            items: locationOptions,
            value: defaultLocation,
            onChanged: (value, label) {
              defaultLocation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFeatures() {
    return Container(
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
          Text(
            "Mobile Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Offline Mode",
                "value": true,
                "checked": enableOfflineMode,
              }
            ],
            value: [if (enableOfflineMode) {"label": "Enable Offline Mode", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableOfflineMode = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Barcode Scanning",
                "value": true,
                "checked": enableBarcodeScanning,
              }
            ],
            value: [if (enableBarcodeScanning) {"label": "Barcode Scanning", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableBarcodeScanning = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Voice Commands",
                "value": true,
                "checked": enableVoiceCommands,
              }
            ],
            value: [if (enableVoiceCommands) {"label": "Voice Commands", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableVoiceCommands = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Haptic Feedback",
                "value": true,
                "checked": enableHapticFeedback,
              }
            ],
            value: [if (enableHapticFeedback) {"label": "Haptic Feedback", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableHapticFeedback = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSettings() {
    return Container(
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
          Text(
            "Data Synchronization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-sync Data",
                "value": true,
                "checked": autoSyncData,
              }
            ],
            value: [if (autoSyncData) {"label": "Auto-sync Data", "value": true, "checked": true}],
            onChanged: (values, ids) {
              autoSyncData = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Sync Frequency",
            items: syncFrequencyOptions,
            value: syncFrequency,
            onChanged: (value, label) {
              syncFrequency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCameraSettings() {
    return Container(
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
          Text(
            "Camera Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Camera Quality",
            items: qualityOptions,
            value: cameraQuality,
            onChanged: (value, label) {
              cameraQuality = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFeatures() {
    return Container(
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
          Text(
            "Security Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Two-Factor Authentication",
                "value": true,
                "checked": requireTwoFactor,
              }
            ],
            value: [if (requireTwoFactor) {"label": "Two-Factor Authentication", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requireTwoFactor = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Session Timeout",
                "value": true,
                "checked": enableSessionTimeout,
              }
            ],
            value: [if (enableSessionTimeout) {"label": "Session Timeout", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableSessionTimeout = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Audit Logging",
                "value": true,
                "checked": enableAuditLogging,
              }
            ],
            value: [if (enableAuditLogging) {"label": "Audit Logging", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableAuditLogging = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSettings() {
    return Container(
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
          Text(
            "Password Policy",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Session Timeout",
            items: timeoutOptions,
            value: sessionTimeout,
            onChanged: (value, label) {
              sessionTimeout = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Password Strength",
            items: policyOptions,
            value: passwordPolicy,
            onChanged: (value, label) {
              passwordPolicy = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Require Periodic Password Change",
                "value": true,
                "checked": requirePasswordChange,
              }
            ],
            value: [if (requirePasswordChange) {"label": "Require Periodic Password Change", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requirePasswordChange = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackupSettings() {
    return Container(
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
          Text(
            "Backup & Recovery",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Auto Backup",
                "value": true,
                "checked": enableAutoBackup,
              }
            ],
            value: [if (enableAutoBackup) {"label": "Enable Auto Backup", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableAutoBackup = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Backup Frequency",
            items: backupOptions,
            value: backupFrequency,
            onChanged: (value, label) {
              backupFrequency = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Backup Now",
                  icon: Icons.backup,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Restore",
                  icon: Icons.restore,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Save Settings",
        icon: Icons.save,
        size: bs.md,
        onPressed: () {
          ss("Settings saved successfully");
        },
      ),
    );
  }
}

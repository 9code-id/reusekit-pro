import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSystemConfigurationView extends StatefulWidget {
  const IwmSystemConfigurationView({super.key});

  @override
  State<IwmSystemConfigurationView> createState() => _IwmSystemConfigurationViewState();
}

class _IwmSystemConfigurationViewState extends State<IwmSystemConfigurationView> {
  int selectedTab = 0;
  
  // General Settings
  String systemName = "Inventory Management System";
  String companyName = "TechCorp Industries";
  String systemEmail = "admin@techcorp.com";
  String timezone = "Asia/Jakarta";
  String dateFormat = "DD/MM/YYYY";
  String currency = "USD";
  
  // Security Settings
  bool twoFactorAuth = true;
  bool passwordComplexity = true;
  int sessionTimeout = 30;
  int maxLoginAttempts = 5;
  bool auditLogging = true;
  
  // Notification Settings
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;
  bool inventoryAlerts = true;
  bool lowStockAlerts = true;
  bool expiryAlerts = true;
  
  // System Preferences
  String defaultLanguage = "en";
  int recordsPerPage = 25;
  bool autoBackup = true;
  String backupFrequency = "daily";
  bool maintenanceMode = false;
  
  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "Asia/Jakarta", "value": "Asia/Jakarta"},
    {"label": "Asia/Singapore", "value": "Asia/Singapore"},
    {"label": "Asia/Tokyo", "value": "Asia/Tokyo"},
    {"label": "Europe/London", "value": "Europe/London"},
    {"label": "America/New_York", "value": "America/New_York"},
  ];
  
  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
  ];
  
  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "IDR - Indonesian Rupiah", "value": "IDR"},
    {"label": "SGD - Singapore Dollar", "value": "SGD"},
  ];
  
  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Indonesian", "value": "id"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];
  
  List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];
  
  List<Map<String, dynamic>> recordsPerPageOptions = [
    {"label": "10 records", "value": "10"},
    {"label": "25 records", "value": "25"},
    {"label": "50 records", "value": "50"},
    {"label": "100 records", "value": "100"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "System Configuration",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Security", icon: Icon(Icons.security)),
        Tab(text: "Notifications", icon: Icon(Icons.notifications)),
        Tab(text: "Preferences", icon: Icon(Icons.tune)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildSecurityTab(),
        _buildNotificationsTab(),
        _buildPreferencesTab(),
      ],
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralSection(),
          _buildCompanySection(),
          _buildSystemInfoSection(),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthenticationSection(),
          _buildPasswordSection(),
          _buildSessionSection(),
          _buildAuditSection(),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNotificationChannels(),
          _buildInventoryNotifications(),
          _buildAlertSettings(),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDisplaySettings(),
          _buildBackupSettings(),
          _buildMaintenanceSettings(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildGeneralSection() {
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
            "General Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "System Name",
            value: systemName,
            onChanged: (value) {
              systemName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "System Email",
            value: systemEmail,
            onChanged: (value) {
              systemEmail = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timezone",
                  items: timezoneOptions,
                  value: timezone,
                  onChanged: (value, label) {
                    timezone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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

  Widget _buildCompanySection() {
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
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Company Name",
            value: companyName,
            onChanged: (value) {
              companyName = value;
              setState(() {});
            },
          ),
          QImagePicker(
            label: "Company Logo",
            value: "https://picsum.photos/100/100?random=1&keyword=logo",
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSystemInfoSection() {
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
            "System Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("System Version", "v2.1.0"),
          _buildInfoRow("Database Version", "PostgreSQL 14.2"),
          _buildInfoRow("Last Updated", "2024-01-15 10:30 AM"),
          _buildInfoRow("System Status", "Online", statusColor: successColor),
        ],
      ),
    );
  }

  Widget _buildAuthenticationSection() {
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
            "Authentication Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Two-Factor Authentication",
                "value": true,
                "checked": twoFactorAuth,
              }
            ],
            value: [
              if (twoFactorAuth)
                {
                  "label": "Enable Two-Factor Authentication",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              twoFactorAuth = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enforce Password Complexity",
                "value": true,
                "checked": passwordComplexity,
              }
            ],
            value: [
              if (passwordComplexity)
                {
                  "label": "Enforce Password Complexity",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              passwordComplexity = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSection() {
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
          QNumberField(
            label: "Maximum Login Attempts",
            value: maxLoginAttempts.toString(),
            onChanged: (value) {
              maxLoginAttempts = int.tryParse(value) ?? 5;
              setState(() {});
            },
          ),
          _buildInfoRow("Minimum Password Length", "8 characters"),
          _buildInfoRow("Password Expiry", "90 days"),
          _buildInfoRow("Password History", "Last 5 passwords"),
        ],
      ),
    );
  }

  Widget _buildSessionSection() {
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
            "Session Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Session Timeout (minutes)",
            value: sessionTimeout.toString(),
            onChanged: (value) {
              sessionTimeout = int.tryParse(value) ?? 30;
              setState(() {});
            },
          ),
          _buildInfoRow("Concurrent Sessions", "Unlimited"),
          _buildInfoRow("Remember Me Duration", "30 days"),
        ],
      ),
    );
  }

  Widget _buildAuditSection() {
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
            "Audit & Logging",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Audit Logging",
                "value": true,
                "checked": auditLogging,
              }
            ],
            value: [
              if (auditLogging)
                {
                  "label": "Enable Audit Logging",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              auditLogging = values.isNotEmpty;
              setState(() {});
            },
          ),
          _buildInfoRow("Log Retention", "1 year"),
          _buildInfoRow("Log Location", "/var/logs/iwm/"),
        ],
      ),
    );
  }

  Widget _buildNotificationChannels() {
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
            "Notification Channels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
          QSwitch(
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
        ],
      ),
    );
  }

  Widget _buildInventoryNotifications() {
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
            "Inventory Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "General Inventory Alerts",
                "value": true,
                "checked": inventoryAlerts,
              }
            ],
            value: [
              if (inventoryAlerts)
                {
                  "label": "General Inventory Alerts",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              inventoryAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Low Stock Alerts",
                "value": true,
                "checked": lowStockAlerts,
              }
            ],
            value: [
              if (lowStockAlerts)
                {
                  "label": "Low Stock Alerts",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              lowStockAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Expiry Date Alerts",
                "value": true,
                "checked": expiryAlerts,
              }
            ],
            value: [
              if (expiryAlerts)
                {
                  "label": "Expiry Date Alerts",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              expiryAlerts = values.isNotEmpty;
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
            "Alert Thresholds",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Low Stock Threshold", "10 units"),
          _buildInfoRow("Critical Stock Threshold", "5 units"),
          _buildInfoRow("Expiry Warning", "30 days before"),
          _buildInfoRow("Critical Expiry", "7 days before"),
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
          QDropdownField(
            label: "Default Language",
            items: languageOptions,
            value: defaultLanguage,
            onChanged: (value, label) {
              defaultLanguage = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Records Per Page",
            items: recordsPerPageOptions,
            value: recordsPerPage.toString(),
            onChanged: (value, label) {
              recordsPerPage = int.tryParse(value) ?? 25;
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
            "Backup Settings",
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
                "checked": autoBackup,
              }
            ],
            value: [
              if (autoBackup)
                {
                  "label": "Enable Auto Backup",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              autoBackup = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Backup Frequency",
            items: backupFrequencyOptions,
            value: backupFrequency,
            onChanged: (value, label) {
              backupFrequency = value;
              setState(() {});
            },
          ),
          _buildInfoRow("Last Backup", "2024-01-15 02:00 AM"),
          _buildInfoRow("Backup Location", "Cloud Storage"),
        ],
      ),
    );
  }

  Widget _buildMaintenanceSettings() {
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
            "Maintenance Mode",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Maintenance Mode",
                "value": true,
                "checked": maintenanceMode,
              }
            ],
            value: [
              if (maintenanceMode)
                {
                  "label": "Enable Maintenance Mode",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              maintenanceMode = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (maintenanceMode)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "System is in maintenance mode. Only administrators can access.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
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

  Widget _buildActionButtons() {
    return Container(
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
              Expanded(
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: () {
                    ss("Configuration saved successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset to Default",
                  size: bs.md,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default?");
                    if (isConfirmed) {
                      _resetToDefault();
                      ss("Settings reset to default");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? statusColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: statusColor ?? primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _resetToDefault() {
    setState(() {
      systemName = "Inventory Management System";
      companyName = "TechCorp Industries";
      systemEmail = "admin@techcorp.com";
      timezone = "Asia/Jakarta";
      dateFormat = "DD/MM/YYYY";
      currency = "USD";
      twoFactorAuth = true;
      passwordComplexity = true;
      sessionTimeout = 30;
      maxLoginAttempts = 5;
      auditLogging = true;
      emailNotifications = true;
      smsNotifications = false;
      pushNotifications = true;
      inventoryAlerts = true;
      lowStockAlerts = true;
      expiryAlerts = true;
      defaultLanguage = "en";
      recordsPerPage = 25;
      autoBackup = true;
      backupFrequency = "daily";
      maintenanceMode = false;
    });
  }
}

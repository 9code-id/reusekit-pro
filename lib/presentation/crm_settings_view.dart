import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSettingsView extends StatefulWidget {
  const CrmSettingsView({super.key});

  @override
  State<CrmSettingsView> createState() => _CrmSettingsViewState();
}

class _CrmSettingsViewState extends State<CrmSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // General Settings
  String crmName = "My CRM System";
  String selectedTimezone = "UTC-05:00 (EST)";
  String selectedLanguage = "English";
  String selectedCurrency = "USD";
  String dateFormat = "MM/dd/yyyy";
  
  // Security Settings
  bool twoFactorAuth = true;
  bool sessionTimeout = true;
  String sessionDuration = "8 hours";
  bool passwordExpiry = false;
  String passwordDays = "90";
  bool loginNotifications = true;
  
  // Notification Settings
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool leadNotifications = true;
  bool dealNotifications = true;
  bool taskNotifications = true;
  bool systemNotifications = false;
  
  // Privacy Settings
  bool dataEncryption = true;
  bool auditLogging = true;
  bool anonymizeData = false;
  bool gdprCompliance = true;
  bool dataRetention = true;
  String retentionPeriod = "7 years";
  
  // Email Configuration
  String smtpServer = "smtp.gmail.com";
  String smtpPort = "587";
  String smtpUsername = "noreply@company.com";
  String smtpPassword = "";
  bool smtpSSL = true;
  
  // Database Settings
  String dbHost = "localhost";
  String dbPort = "5432";
  String dbName = "crm_database";
  String dbUsername = "crm_user";
  String dbPassword = "";
  bool autoBackup = true;
  String backupFrequency = "Daily";

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC-12:00 (Baker Island)", "value": "UTC-12:00"},
    {"label": "UTC-08:00 (PST)", "value": "UTC-08:00"},
    {"label": "UTC-05:00 (EST)", "value": "UTC-05:00"},
    {"label": "UTC+00:00 (GMT)", "value": "UTC+00:00"},
    {"label": "UTC+01:00 (CET)", "value": "UTC+01:00"},
    {"label": "UTC+08:00 (SGT)", "value": "UTC+08:00"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD", "value": "USD"},
    {"label": "EUR", "value": "EUR"},
    {"label": "GBP", "value": "GBP"},
    {"label": "JPY", "value": "JPY"},
    {"label": "CAD", "value": "CAD"},
    {"label": "AUD", "value": "AUD"},
  ];

  List<Map<String, dynamic>> sessionOptions = [
    {"label": "2 hours", "value": "2"},
    {"label": "4 hours", "value": "4"},
    {"label": "8 hours", "value": "8"},
    {"label": "12 hours", "value": "12"},
    {"label": "24 hours", "value": "24"},
  ];

  List<Map<String, dynamic>> backupOptions = [
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  int currentTab = 0;

  void _saveSettings() {
    if (formKey.currentState!.validate()) {
      ss("Settings saved successfully");
    }
  }

  void _resetSettings() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default?");
    if (isConfirmed) {
      sw("Settings have been reset to default values");
    }
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "General Configuration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "CRM Name",
                    value: crmName,
                    hint: "Enter your CRM system name",
                    validator: Validator.required,
                    onChanged: (value) {
                      crmName = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Timezone",
                    items: timezoneOptions,
                    value: selectedTimezone,
                    onChanged: (value, label) {
                      selectedTimezone = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languageOptions,
                          value: selectedLanguage,
                          onChanged: (value, label) {
                            selectedLanguage = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Currency",
                          items: currencyOptions,
                          value: selectedCurrency,
                          onChanged: (value, label) {
                            selectedCurrency = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Date Format",
                    value: dateFormat,
                    hint: "e.g., MM/dd/yyyy or dd/MM/yyyy",
                    onChanged: (value) {
                      dateFormat = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save General Settings",
                size: bs.md,
                onPressed: _saveSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Two-Factor Authentication",
                            "value": true,
                            "checked": twoFactorAuth,
                          }
                        ],
                        value: [
                          if (twoFactorAuth)
                            {
                              "label": "Two-Factor Authentication",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          twoFactorAuth = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Session Timeout",
                            "value": true,
                            "checked": sessionTimeout,
                          }
                        ],
                        value: [
                          if (sessionTimeout)
                            {
                              "label": "Session Timeout",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          sessionTimeout = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                if (sessionTimeout) ...[
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Session Duration",
                    items: sessionOptions,
                    value: sessionDuration,
                    onChanged: (value, label) {
                      sessionDuration = value;
                      setState(() {});
                    },
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Password Expiry",
                            "value": true,
                            "checked": passwordExpiry,
                          }
                        ],
                        value: [
                          if (passwordExpiry)
                            {
                              "label": "Password Expiry",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          passwordExpiry = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                if (passwordExpiry) ...[
                  SizedBox(height: spSm),
                  QNumberField(
                    label: "Password Expiry (Days)",
                    value: passwordDays,
                    hint: "Number of days before password expires",
                    onChanged: (value) {
                      passwordDays = value;
                      setState(() {});
                    },
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Login Notifications",
                            "value": true,
                            "checked": loginNotifications,
                          }
                        ],
                        value: [
                          if (loginNotifications)
                            {
                              "label": "Login Notifications",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          loginNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Security Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Notification Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Delivery Methods",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
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
                SizedBox(height: spXs),
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
                SizedBox(height: spXs),
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
                SizedBox(height: spSm),
                Text(
                  "Notification Types",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "New Lead Notifications",
                            "value": true,
                            "checked": leadNotifications,
                          }
                        ],
                        value: [
                          if (leadNotifications)
                            {
                              "label": "New Lead Notifications",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          leadNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Deal Updates",
                            "value": true,
                            "checked": dealNotifications,
                          }
                        ],
                        value: [
                          if (dealNotifications)
                            {
                              "label": "Deal Updates",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          dealNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Task Reminders",
                            "value": true,
                            "checked": taskNotifications,
                          }
                        ],
                        value: [
                          if (taskNotifications)
                            {
                              "label": "Task Reminders",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          taskNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "System Alerts",
                            "value": true,
                            "checked": systemNotifications,
                          }
                        ],
                        value: [
                          if (systemNotifications)
                            {
                              "label": "System Alerts",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          systemNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Notification Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.privacy_tip, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Privacy & Compliance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Data Encryption",
                            "value": true,
                            "checked": dataEncryption,
                          }
                        ],
                        value: [
                          if (dataEncryption)
                            {
                              "label": "Data Encryption",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          dataEncryption = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Audit Logging",
                            "value": true,
                            "checked": auditLogging,
                          }
                        ],
                        value: [
                          if (auditLogging)
                            {
                              "label": "Audit Logging",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          auditLogging = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Anonymize Personal Data",
                            "value": true,
                            "checked": anonymizeData,
                          }
                        ],
                        value: [
                          if (anonymizeData)
                            {
                              "label": "Anonymize Personal Data",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          anonymizeData = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "GDPR Compliance",
                            "value": true,
                            "checked": gdprCompliance,
                          }
                        ],
                        value: [
                          if (gdprCompliance)
                            {
                              "label": "GDPR Compliance",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          gdprCompliance = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Data Retention Policy",
                            "value": true,
                            "checked": dataRetention,
                          }
                        ],
                        value: [
                          if (dataRetention)
                            {
                              "label": "Data Retention Policy",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          dataRetention = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                if (dataRetention) ...[
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Retention Period",
                    value: retentionPeriod,
                    hint: "e.g., 7 years, 5 years",
                    onChanged: (value) {
                      retentionPeriod = value;
                      setState(() {});
                    },
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Privacy Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, color: successColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Email Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "SMTP Server",
                  value: smtpServer,
                  hint: "e.g., smtp.gmail.com",
                  onChanged: (value) {
                    smtpServer = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "SMTP Port",
                        value: smtpPort,
                        hint: "e.g., 587, 465",
                        onChanged: (value) {
                          smtpPort = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "SSL/TLS",
                            "value": true,
                            "checked": smtpSSL,
                          }
                        ],
                        value: [
                          if (smtpSSL)
                            {
                              "label": "SSL/TLS",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          smtpSSL = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "SMTP Username",
                  value: smtpUsername,
                  hint: "Email address for authentication",
                  onChanged: (value) {
                    smtpUsername = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "SMTP Password",
                  value: smtpPassword,
                  hint: "Password or app-specific password",
                  obscureText: true,
                  onChanged: (value) {
                    smtpPassword = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.storage, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Database Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Database Host",
                        value: dbHost,
                        hint: "e.g., localhost, 192.168.1.100",
                        onChanged: (value) {
                          dbHost = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Port",
                        value: dbPort,
                        hint: "e.g., 5432",
                        onChanged: (value) {
                          dbPort = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Database Name",
                  value: dbName,
                  hint: "Name of the CRM database",
                  onChanged: (value) {
                    dbName = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Username",
                  value: dbUsername,
                  hint: "Database user account",
                  onChanged: (value) {
                    dbUsername = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Password",
                  value: dbPassword,
                  hint: "Database password",
                  obscureText: true,
                  onChanged: (value) {
                    dbPassword = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Auto Backup",
                            "value": true,
                            "checked": autoBackup,
                          }
                        ],
                        value: [
                          if (autoBackup)
                            {
                              "label": "Auto Backup",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          autoBackup = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                if (autoBackup) ...[
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Backup Frequency",
                    items: backupOptions,
                    value: backupFrequency,
                    onChanged: (value, label) {
                      backupFrequency = value;
                      setState(() {});
                    },
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test Configuration",
                  size: bs.md,
                  onPressed: () {
                    si("Configuration test initiated");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Advanced Settings",
                  size: bs.md,
                  onPressed: _saveSettings,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Danger Zone",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "These actions cannot be undone. Please proceed with caution.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Reset All Settings",
                  size: bs.md,
                  onPressed: _resetSettings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "CRM Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Security", icon: Icon(Icons.security)),
        Tab(text: "Notifications", icon: Icon(Icons.notifications)),
        Tab(text: "Privacy", icon: Icon(Icons.privacy_tip)),
        Tab(text: "Advanced", icon: Icon(Icons.build)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildSecurityTab(),
        _buildNotificationsTab(),
        _buildPrivacyTab(),
        _buildAdvancedTab(),
      ],
      onInit: (tabController) {},
    );
  }
}

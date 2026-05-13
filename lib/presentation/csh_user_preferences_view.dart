import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshUserPreferencesView extends StatefulWidget {
  const CshUserPreferencesView({super.key});

  @override
  State<CshUserPreferencesView> createState() => _CshUserPreferencesViewState();
}

class _CshUserPreferencesViewState extends State<CshUserPreferencesView> {
  final formKey = GlobalKey<FormState>();
  
  String displayName = "John Smith";
  String email = "john.smith@company.com";
  String phoneNumber = "+1234567890";
  String language = "en";
  String dateFormat = "MM/DD/YYYY";
  String timeFormat = "12";
  String currency = "USD";
  String timeZone = "UTC-5";
  String theme = "light";
  String emailSignature = "Best regards,\nJohn Smith\nSenior Developer";
  
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool desktopNotifications = true;
  bool weeklyReports = true;
  bool monthlyReports = false;
  bool systemAlerts = true;
  bool marketingEmails = false;
  bool twoFactorAuth = true;
  bool sessionAlerts = true;
  bool autoLogout = true;
  bool rememberDevice = false;  
  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];
  
  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
  ];
  
  List<Map<String, dynamic>> timeFormatOptions = [
    {"label": "12 Hour", "value": "12"},
    {"label": "24 Hour", "value": "24"},
  ];
  
  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Japanese Yen (JPY)", "value": "JPY"},
  ];
  
  List<Map<String, dynamic>> timeZoneOptions = [
    {"label": "UTC-12 (Baker Island)", "value": "UTC-12"},
    {"label": "UTC-8 (PST)", "value": "UTC-8"},
    {"label": "UTC-5 (EST)", "value": "UTC-5"},
    {"label": "UTC+0 (GMT)", "value": "UTC+0"},
    {"label": "UTC+8 (CST)", "value": "UTC+8"},
    {"label": "UTC+9 (JST)", "value": "UTC+9"},
  ];
  
  List<Map<String, dynamic>> themeOptions = [
    {"label": "Light", "value": "light"},
    {"label": "Dark", "value": "dark"},
    {"label": "System", "value": "system"},
  ];

  void _savePreferences() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("User preferences saved successfully");
    }
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all preferences to default values?");
    if (isConfirmed) {
      setState(() {
        language = "en";
        dateFormat = "MM/DD/YYYY";
        timeFormat = "12";
        currency = "USD";
        timeZone = "UTC-5";
        theme = "light";
        emailNotifications = true;
        pushNotifications = true;
        smsNotifications = false;
        desktopNotifications = true;
        weeklyReports = true;
        monthlyReports = false;
        systemAlerts = true;
        marketingEmails = false;
        twoFactorAuth = true;
        sessionAlerts = true;
        autoLogout = true;
        rememberDevice = false;
      });
      si("Preferences reset to default values");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Preferences"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Information Section
              Text(
                "Profile Information",
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
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            si("Edit profile functionality");
                          },
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Display Name",
                      value: displayName,
                      validator: Validator.required,
                      onChanged: (value) {
                        displayName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Regional Settings Section
              Text(
                "Regional & Display Settings",
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
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Language",
                            items: languageOptions,
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
                            label: "Time Zone",
                            items: timeZoneOptions,
                            value: timeZone,
                            onChanged: (value, label) {
                              timeZone = value;
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
                            label: "Date Format",
                            items: dateFormatOptions,
                            value: dateFormat,
                            onChanged: (value, label) {
                              dateFormat = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Time Format",
                            items: timeFormatOptions,
                            value: timeFormat,
                            onChanged: (value, label) {
                              timeFormat = value;
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
                            label: "Currency",
                            items: currencyOptions,
                            value: currency,
                            onChanged: (value, label) {
                              currency = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Theme",
                            items: themeOptions,
                            value: theme,
                            onChanged: (value, label) {
                              theme = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Notification Preferences Section
              Text(
                "Notification Preferences",
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
                            value: [if (emailNotifications) {"label": "Email Notifications", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              emailNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Push Notifications",
                                "value": true,
                                "checked": pushNotifications,
                              }
                            ],
                            value: [if (pushNotifications) {"label": "Push Notifications", "value": true, "checked": true}],
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
                                "label": "SMS Notifications",
                                "value": true,
                                "checked": smsNotifications,
                              }
                            ],
                            value: [if (smsNotifications) {"label": "SMS Notifications", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              smsNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Desktop Notifications",
                                "value": true,
                                "checked": desktopNotifications,
                              }
                            ],
                            value: [if (desktopNotifications) {"label": "Desktop Notifications", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              desktopNotifications = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Report Preferences Section
              Text(
                "Report & Communication Preferences",
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
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Weekly Reports",
                                "value": true,
                                "checked": weeklyReports,
                              }
                            ],
                            value: [if (weeklyReports) {"label": "Weekly Reports", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              weeklyReports = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Monthly Reports",
                                "value": true,
                                "checked": monthlyReports,
                              }
                            ],
                            value: [if (monthlyReports) {"label": "Monthly Reports", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              monthlyReports = values.isNotEmpty;
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
                                "label": "System Alerts",
                                "value": true,
                                "checked": systemAlerts,
                              }
                            ],
                            value: [if (systemAlerts) {"label": "System Alerts", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              systemAlerts = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Marketing Emails",
                                "value": true,
                                "checked": marketingEmails,
                              }
                            ],
                            value: [if (marketingEmails) {"label": "Marketing Emails", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              marketingEmails = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Email Signature",
                      value: emailSignature,
                      hint: "Enter your email signature",
                      onChanged: (value) {
                        emailSignature = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Security Preferences Section
              Text(
                "Security Preferences",
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
                            value: [if (twoFactorAuth) {"label": "Two-Factor Authentication", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              twoFactorAuth = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Session Alerts",
                                "value": true,
                                "checked": sessionAlerts,
                              }
                            ],
                            value: [if (sessionAlerts) {"label": "Session Alerts", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              sessionAlerts = values.isNotEmpty;
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
                                "label": "Auto Logout",
                                "value": true,
                                "checked": autoLogout,
                              }
                            ],
                            value: [if (autoLogout) {"label": "Auto Logout", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              autoLogout = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Remember Device",
                                "value": true,
                                "checked": rememberDevice,
                              }
                            ],
                            value: [if (rememberDevice) {"label": "Remember Device", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              rememberDevice = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Preferences",
                  size: bs.md,
                  onPressed: _savePreferences,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Export Settings",
                  size: bs.sm,
                  color: infoColor,
                  onPressed: () {
                    si("Exporting preferences...");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

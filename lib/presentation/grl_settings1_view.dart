import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings1View extends StatefulWidget {
  @override
  State<GrlSettings1View> createState() => _GrlSettings1ViewState();
}

class _GrlSettings1ViewState extends State<GrlSettings1View> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool locationEnabled = true;
  bool biometricEnabled = false;
  bool autoBackup = true;
  String language = "English";
  String currency = "USD";
  String timezone = "UTC";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Español", "value": "Spanish"},
    {"label": "Français", "value": "French"},
    {"label": "Deutsch", "value": "German"},
    {"label": "中文", "value": "Chinese"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "JPY - Japanese Yen", "value": "JPY"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC - Coordinated Universal Time", "value": "UTC"},
    {"label": "EST - Eastern Standard Time", "value": "EST"},
    {"label": "PST - Pacific Standard Time", "value": "PST"},
    {"label": "GMT - Greenwich Mean Time", "value": "GMT"},
    {"label": "JST - Japan Standard Time", "value": "JST"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              si("Help and support coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Profile Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Smith",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "john.smith@email.com",
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
                      si("Profile editing feature coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Preferences Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Notifications Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Push Notifications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Receive alerts and updates",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          notificationsEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(height: spLg),
                  
                  // Dark Mode Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dark Mode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Use dark theme",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: darkModeEnabled,
                        onChanged: (value) {
                          darkModeEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(height: spLg),
                  
                  // Location Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location Services",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Allow location access",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: locationEnabled,
                        onChanged: (value) {
                          locationEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Security Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Biometric Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Biometric Authentication",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Use fingerprint or face ID",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: biometricEnabled,
                        onChanged: (value) {
                          biometricEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(height: spLg),
                  
                  // Auto Backup Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.backup,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto Backup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Automatically backup data",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoBackup,
                        onChanged: (value) {
                          autoBackup = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Language & Region Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Language & Region",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  QDropdownField(
                    label: "Language",
                    items: languageOptions,
                    value: language,
                    onChanged: (value, label) {
                      language = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Currency",
                    items: currencyOptions,
                    value: currency,
                    onChanged: (value, label) {
                      currency = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Timezone",
                    items: timezoneOptions,
                    value: timezone,
                    onChanged: (value, label) {
                      timezone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Change Password",
                    size: bs.md,
                    onPressed: () {
                      si("Password change feature coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Data",
                    size: bs.md,
                    onPressed: () {
                      si("Data export feature coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sign Out",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to sign out?");
                      if (isConfirmed) {
                        ss("Signed out successfully");
                      }
                    },
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

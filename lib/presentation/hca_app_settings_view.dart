import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAppSettingsView extends StatefulWidget {
  const HcaAppSettingsView({super.key});

  @override
  State<HcaAppSettingsView> createState() => _HcaAppSettingsViewState();
}

class _HcaAppSettingsViewState extends State<HcaAppSettingsView> {
  int currentTab = 0;
  bool notificationsEnabled = true;
  bool medicationReminders = true;
  bool appointmentReminders = true;
  bool healthTips = false;
  bool emergencyAlerts = true;
  bool biometricAuth = false;
  bool darkMode = false;
  bool autoBackup = true;
  String language = "English";
  String timeZone = "America/New_York";
  String units = "Imperial";
  String emergencyContact = "";
  String doctorName = "";
  String doctorPhone = "";
  String insuranceProvider = "";
  String policyNumber = "";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Chinese", "value": "Chinese"},
  ];

  List<Map<String, dynamic>> timeZoneOptions = [
    {"label": "Eastern Time", "value": "America/New_York"},
    {"label": "Central Time", "value": "America/Chicago"},
    {"label": "Mountain Time", "value": "America/Denver"},
    {"label": "Pacific Time", "value": "America/Los_Angeles"},
    {"label": "UTC", "value": "UTC"},
  ];

  List<Map<String, dynamic>> unitOptions = [
    {"label": "Imperial (lb, ft, °F)", "value": "Imperial"},
    {"label": "Metric (kg, cm, °C)", "value": "Metric"},
  ];

  List<Map<String, dynamic>> privacySettings = [
    {
      "title": "Data Sharing",
      "description": "Share anonymized health data for research",
      "enabled": false,
    },
    {
      "title": "Usage Analytics",
      "description": "Help improve the app by sharing usage statistics",
      "enabled": true,
    },
    {
      "title": "Location Services",
      "description": "Use location for nearby healthcare providers",
      "enabled": true,
    },
    {
      "title": "Third-party Integration",
      "description": "Connect with fitness trackers and health apps",
      "enabled": false,
    },
  ];

  List<Map<String, dynamic>> syncOptions = [
    {
      "service": "Google Health",
      "connected": true,
      "icon": Icons.cloud,
      "description": "Sync with Google Fit and Health Connect",
    },
    {
      "service": "Apple Health",
      "connected": false,
      "icon": Icons.phone_iphone,
      "description": "Sync with Apple HealthKit",
    },
    {
      "service": "Fitbit",
      "connected": true,
      "icon": Icons.watch,
      "description": "Import activity and health data",
    },
    {
      "service": "MyChart",
      "connected": false,
      "icon": Icons.local_hospital,
      "description": "Connect with hospital records",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "App Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Health", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Privacy", icon: Icon(Icons.privacy_tip)),
        Tab(text: "Sync", icon: Icon(Icons.sync)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildHealthTab(),
        _buildPrivacyTab(),
        _buildSyncTab(),
      ],
      onInit: (tabController) {
        // TabController initialization if needed
      },
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Preferences
          Container(
            width: double.infinity,
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
                    Icon(Icons.settings, color: primaryColor, size: 24),
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
                  label: "Time Zone",
                  items: timeZoneOptions,
                  value: timeZone,
                  onChanged: (value, label) {
                    timeZone = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Units",
                  items: unitOptions,
                  value: units,
                  onChanged: (value, label) {
                    units = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Display Settings
          Container(
            width: double.infinity,
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
                      "label": "Dark Mode",
                      "value": true,
                      "checked": darkMode,
                    }
                  ],
                  value: [if (darkMode) {"label": "Dark Mode", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    darkMode = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Security Settings
          Container(
            width: double.infinity,
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
                  "Security Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Biometric Authentication",
                      "value": true,
                      "checked": biometricAuth,
                    }
                  ],
                  value: [if (biometricAuth) {"label": "Biometric Authentication", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    biometricAuth = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto Backup",
                      "value": true,
                      "checked": autoBackup,
                    }
                  ],
                  value: [if (autoBackup) {"label": "Auto Backup", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    autoBackup = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Notification Settings
          Container(
            width: double.infinity,
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
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable Notifications",
                      "value": true,
                      "checked": notificationsEnabled,
                    }
                  ],
                  value: [if (notificationsEnabled) {"label": "Enable Notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    notificationsEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (notificationsEnabled) ...[
                  QSwitch(
                    items: [
                      {
                        "label": "Medication Reminders",
                        "value": true,
                        "checked": medicationReminders,
                      }
                    ],
                    value: [if (medicationReminders) {"label": "Medication Reminders", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      medicationReminders = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Appointment Reminders",
                        "value": true,
                        "checked": appointmentReminders,
                      }
                    ],
                    value: [if (appointmentReminders) {"label": "Appointment Reminders", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      appointmentReminders = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Health Tips",
                        "value": true,
                        "checked": healthTips,
                      }
                    ],
                    value: [if (healthTips) {"label": "Health Tips", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      healthTips = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Emergency Alerts",
                        "value": true,
                        "checked": emergencyAlerts,
                      }
                    ],
                    value: [if (emergencyAlerts) {"label": "Emergency Alerts", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      emergencyAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emergency Contact
          Container(
            width: double.infinity,
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
                    Icon(Icons.emergency, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Emergency Contact",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Emergency Contact",
                  value: emergencyContact,
                  hint: "Name and phone number",
                  onChanged: (value) {
                    emergencyContact = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Emergency Contact",
                    size: bs.md,
                    onPressed: () {
                      ss("Emergency contact updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Healthcare Provider
          Container(
            width: double.infinity,
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
                    Icon(Icons.local_hospital, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Healthcare Provider",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Primary Doctor",
                  value: doctorName,
                  hint: "Dr. John Smith",
                  onChanged: (value) {
                    doctorName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Doctor's Phone",
                  value: doctorPhone,
                  hint: "(555) 123-4567",
                  onChanged: (value) {
                    doctorPhone = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Provider Info",
                    size: bs.md,
                    onPressed: () {
                      ss("Provider information updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Insurance Information
          Container(
            width: double.infinity,
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
                    Icon(Icons.credit_card, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Insurance Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Insurance Provider",
                  value: insuranceProvider,
                  hint: "Blue Cross Blue Shield",
                  onChanged: (value) {
                    insuranceProvider = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Policy Number",
                  value: policyNumber,
                  hint: "ABC123456789",
                  onChanged: (value) {
                    policyNumber = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Insurance Info",
                    size: bs.md,
                    onPressed: () {
                      ss("Insurance information updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Health Data Management
          Container(
            width: double.infinity,
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
                  "Health Data Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        size: bs.sm,
                        onPressed: () {
                          ss("Health data exported");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Import Data",
                        size: bs.sm,
                        onPressed: () {
                          ss("Data import started");
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Delete All Data",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to delete all health data? This action cannot be undone.");
                      if (isConfirmed) {
                        se("All health data deleted");
                      }
                    },
                  ),
                ),
              ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...privacySettings.map((setting) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${setting["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${setting["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: setting["enabled"] as bool,
                        onChanged: (value) {
                          setState(() {
                            setting["enabled"] = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // Privacy Policy
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Privacy Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Your health data is encrypted and stored securely. We never share personal health information without your explicit consent.",
                  style: TextStyle(
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Privacy Policy",
                        size: bs.sm,
                        onPressed: () {
                          si("Privacy policy opened");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Terms of Service",
                        size: bs.sm,
                        onPressed: () {
                          si("Terms of service opened");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Connected Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...syncOptions.map((option) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: (option["connected"] as bool) ? successColor : disabledColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (option["connected"] as bool) 
                            ? successColor.withAlpha(20) 
                            : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          option["icon"],
                          color: (option["connected"] as bool) ? successColor : disabledBoldColor,
                          size: 24,
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
                                  "${option["service"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: (option["connected"] as bool) 
                                      ? successColor.withAlpha(20) 
                                      : disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    (option["connected"] as bool) ? "Connected" : "Not Connected",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (option["connected"] as bool) ? successColor : disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${option["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: (option["connected"] as bool) ? "Disconnect" : "Connect",
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          option["connected"] = !(option["connected"] as bool);
                        });
                        String action = (option["connected"] as bool) ? "connected to" : "disconnected from";
                        ss("${option["service"]} $action");
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Sync Status
          Container(
            width: double.infinity,
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
                    Icon(Icons.sync, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Sync Status",
                      style: TextStyle(
                        fontSize: fsH6,
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
                      "Last sync: 2 hours ago",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Up to date",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sync Now",
                    size: bs.md,
                    onPressed: () {
                      ss("Data synchronized successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

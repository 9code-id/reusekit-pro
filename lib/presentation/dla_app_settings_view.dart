import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaAppSettingsView extends StatefulWidget {
  const DlaAppSettingsView({super.key});

  @override
  State<DlaAppSettingsView> createState() => _DlaAppSettingsViewState();
}

class _DlaAppSettingsViewState extends State<DlaAppSettingsView> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool locationTracking = true;
  bool biometricAuth = false;
  bool autoBackup = true;
  bool darkMode = false;
  String language = "en";
  String currency = "usd";
  String timezone = "utc";
  
  final List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
  ];

  final List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (\$)", "value": "usd"},
    {"label": "Euro (€)", "value": "eur"},
    {"label": "British Pound (£)", "value": "gbp"},
    {"label": "Japanese Yen (¥)", "value": "jpy"},
    {"label": "Canadian Dollar (C\$)", "value": "cad"},
  ];

  final List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC", "value": "utc"},
    {"label": "Eastern Time", "value": "est"},
    {"label": "Pacific Time", "value": "pst"},
    {"label": "Central European Time", "value": "cet"},
    {"label": "Asia/Tokyo", "value": "jst"},
  ];

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
              Icon(
                Icons.notifications,
                color: primaryColor,
                size: 20,
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
                "label": "Push Notifications",
                "value": "push",
                "checked": pushNotifications,
              }
            ],
            value: [if (pushNotifications) {"label": "Push Notifications", "value": "push", "checked": true}],
            onChanged: (values, ids) {
              pushNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Email Notifications",
                "value": "email",
                "checked": emailNotifications,
              }
            ],
            value: [if (emailNotifications) {"label": "Email Notifications", "value": "email", "checked": true}],
            onChanged: (values, ids) {
              emailNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "SMS Notifications",
                "value": "sms",
                "checked": smsNotifications,
              }
            ],
            value: [if (smsNotifications) {"label": "SMS Notifications", "value": "sms", "checked": true}],
            onChanged: (values, ids) {
              smsNotifications = values.isNotEmpty;
              setState(() {});
            },
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
              Icon(
                Icons.security,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Security & Privacy",
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
                "label": "Biometric Authentication",
                "value": "biometric",
                "checked": biometricAuth,
              }
            ],
            value: [if (biometricAuth) {"label": "Biometric Authentication", "value": "biometric", "checked": true}],
            onChanged: (values, ids) {
              biometricAuth = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Location Tracking",
                "value": "location",
                "checked": locationTracking,
              }
            ],
            value: [if (locationTracking) {"label": "Location Tracking", "value": "location", "checked": true}],
            onChanged: (values, ids) {
              locationTracking = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Change Password",
              icon: Icons.lock,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                si("Navigating to change password");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
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
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
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
          QSwitch(
            items: [
              {
                "label": "Dark Mode",
                "value": "dark",
                "checked": darkMode,
              }
            ],
            value: [if (darkMode) {"label": "Dark Mode", "value": "dark", "checked": true}],
            onChanged: (values, ids) {
              darkMode = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Backup",
                "value": "backup",
                "checked": autoBackup,
              }
            ],
            value: [if (autoBackup) {"label": "Auto Backup", "value": "backup", "checked": true}],
            onChanged: (values, ids) {
              autoBackup = values.isNotEmpty;
              setState(() {});
            },
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
    );
  }

  Widget _buildSupportSection() {
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
              Icon(
                Icons.help,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Support & Help",
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
                child: QButton(
                  label: "Help Center",
                  icon: Icons.help_outline,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening help center");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Contact Support",
                  icon: Icons.contact_support,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Contacting support team");
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Terms of Service",
                  icon: Icons.description,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening terms of service");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Privacy Policy",
                  icon: Icons.privacy_tip,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening privacy policy");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions() {
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
            "Account Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export Data",
              icon: Icons.download,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                si("Exporting user data");
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Clear Cache",
              icon: Icons.clear,
              color: warningColor,
              size: bs.sm,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to clear app cache?");
                if (isConfirmed) {
                  ss("Cache cleared successfully");
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Delete Account",
              icon: Icons.delete_forever,
              color: dangerColor,
              size: bs.sm,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
                if (isConfirmed) {
                  sw("Account deletion request submitted");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              ss("Settings saved successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildNotificationSettings(),
            _buildSecuritySettings(),
            _buildAppPreferences(),
            _buildSupportSection(),
            _buildAccountActions(),
          ],
        ),
      ),
    );
  }
}

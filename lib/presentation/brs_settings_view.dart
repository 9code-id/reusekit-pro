import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsSettingsView extends StatefulWidget {
  const BrsSettingsView({super.key});

  @override
  State<BrsSettingsView> createState() => _BrsSettingsViewState();
}

class _BrsSettingsViewState extends State<BrsSettingsView> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool bookingReminders = true;
  bool promotionalOffers = false;
  bool locationServices = true;
  bool biometricAuth = true;
  bool autoBackup = true;

  String selectedLanguage = "english";
  String selectedTheme = "light";
  String selectedCurrency = "usd";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
  ];

  List<Map<String, dynamic>> themeOptions = [
    {"label": "Light", "value": "light"},
    {"label": "Dark", "value": "dark"},
    {"label": "System", "value": "system"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD (\$)", "value": "usd"},
    {"label": "EUR (€)", "value": "eur"},
    {"label": "GBP (£)", "value": "gbp"},
    {"label": "CAD (C\$)", "value": "cad"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildNotificationSettings(),
            _buildAppPreferences(),
            _buildPrivacySettings(),
            _buildAccountSettings(),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSwitchTile(
            "Push Notifications",
            "Receive notifications on your device",
            pushNotifications,
            (value) {
              pushNotifications = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "Email Notifications",
            "Receive booking confirmations via email",
            emailNotifications,
            (value) {
              emailNotifications = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "SMS Notifications",
            "Receive booking reminders via SMS",
            smsNotifications,
            (value) {
              smsNotifications = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "Booking Reminders",
            "Get reminded before your appointments",
            bookingReminders,
            (value) {
              bookingReminders = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "Promotional Offers",
            "Receive special deals and offers",
            promotionalOffers,
            (value) {
              promotionalOffers = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                size: 24,
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
          QDropdownField(
            label: "Language",
            items: languageOptions,
            value: selectedLanguage,
            onChanged: (value, label) {
              selectedLanguage = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Theme",
            items: themeOptions,
            value: selectedTheme,
            onChanged: (value, label) {
              selectedTheme = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Currency",
            items: currencyOptions,
            value: selectedCurrency,
            onChanged: (value, label) {
              selectedCurrency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                Icons.privacy_tip,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Privacy & Security",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSwitchTile(
            "Location Services",
            "Allow app to access your location",
            locationServices,
            (value) {
              locationServices = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "Biometric Authentication",
            "Use fingerprint or face ID to login",
            biometricAuth,
            (value) {
              biometricAuth = value;
              setState(() {});
            },
          ),
          _buildSwitchTile(
            "Auto Backup",
            "Automatically backup your data",
            autoBackup,
            (value) {
              autoBackup = value;
              setState(() {});
            },
          ),
          _buildMenuTile(
            "Change Password",
            "Update your account password",
            Icons.lock,
            () => si("Navigate to Change Password"),
          ),
          _buildMenuTile(
            "Two-Factor Authentication",
            "Add extra security to your account",
            Icons.security,
            () => si("Navigate to Two-Factor Auth"),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                Icons.account_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildMenuTile(
            "Account Security",
            "Manage your account security settings",
            Icons.shield,
            () => si("Navigate to Account Security"),
          ),
          _buildMenuTile(
            "Data & Privacy",
            "Control your data and privacy settings",
            Icons.data_usage,
            () => si("Navigate to Data & Privacy"),
          ),
          _buildMenuTile(
            "Backup & Restore",
            "Backup and restore your app data",
            Icons.backup,
            () => si("Navigate to Backup & Restore"),
          ),
          _buildMenuTile(
            "Delete Account",
            "Permanently delete your account",
            Icons.delete_forever,
            () => _deleteAccount(),
            textColor: dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Support",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildMenuTile(
            "Help Center",
            "Find answers to common questions",
            Icons.help_center,
            () => si("Navigate to Help Center"),
          ),
          _buildMenuTile(
            "Contact Support",
            "Get help from our support team",
            Icons.support_agent,
            () => si("Navigate to Contact Support"),
          ),
          _buildMenuTile(
            "Rate App",
            "Rate our app on the app store",
            Icons.star_rate,
            () => si("Navigate to Rate App"),
          ),
          _buildMenuTile(
            "About",
            "App version and legal information",
            Icons.info,
            () => si("Navigate to About"),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (!isConfirmed) return;
    
    sw("Account deletion is a serious action. Please contact support for assistance.");
  }
}

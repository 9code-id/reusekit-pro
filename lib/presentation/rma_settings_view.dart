import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSettingsView extends StatefulWidget {
  const RmaSettingsView({super.key});

  @override
  State<RmaSettingsView> createState() => _RmaSettingsViewState();
}

class _RmaSettingsViewState extends State<RmaSettingsView> {
  bool darkMode = false;
  bool notifications = true;
  bool emailNotifications = true;
  bool pushNotifications = false;
  bool biometricAuth = true;
  bool autoSync = true;
  String language = "en";
  String currency = "USD";
  String dateFormat = "dd/mm/yyyy";
  String timeFormat = "24h";

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Italian", "value": "it"},
    {"label": "Portuguese", "value": "pt"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
    {"label": "Australian Dollar (AUD)", "value": "AUD"},
    {"label": "Japanese Yen (JPY)", "value": "JPY"},
  ];

  List<Map<String, dynamic>> dateFormatOptions = [
    {"label": "DD/MM/YYYY", "value": "dd/mm/yyyy"},
    {"label": "MM/DD/YYYY", "value": "mm/dd/yyyy"},
    {"label": "YYYY-MM-DD", "value": "yyyy-mm-dd"},
    {"label": "DD-MM-YYYY", "value": "dd-mm-yyyy"},
  ];

  List<Map<String, dynamic>> timeFormatOptions = [
    {"label": "24 Hour", "value": "24h"},
    {"label": "12 Hour (AM/PM)", "value": "12h"},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Application Settings",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Customize your real estate app experience",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // General Settings Section
            _buildSettingsSection(
              "General Settings",
              Icons.settings,
              [
                _buildSwitchSetting(
                  "Dark Mode",
                  "Enable dark theme for better viewing in low light",
                  darkMode,
                  Icons.dark_mode,
                  (value) {
                    darkMode = value;
                    setState(() {});
                  },
                ),
                _buildDropdownSetting(
                  "Language",
                  "Select your preferred language",
                  language,
                  languageOptions,
                  Icons.language,
                  (value) {
                    language = value;
                    setState(() {});
                  },
                ),
                _buildDropdownSetting(
                  "Currency",
                  "Default currency for property prices",
                  currency,
                  currencyOptions,
                  Icons.attach_money,
                  (value) {
                    currency = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Notification Settings Section
            _buildSettingsSection(
              "Notifications",
              Icons.notifications,
              [
                _buildSwitchSetting(
                  "Enable Notifications",
                  "Receive app notifications",
                  notifications,
                  Icons.notifications,
                  (value) {
                    notifications = value;
                    setState(() {});
                  },
                ),
                _buildSwitchSetting(
                  "Email Notifications",
                  "Receive notifications via email",
                  emailNotifications,
                  Icons.email,
                  (value) {
                    emailNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSwitchSetting(
                  "Push Notifications",
                  "Receive push notifications on device",
                  pushNotifications,
                  Icons.notification_important,
                  (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Security Settings Section
            _buildSettingsSection(
              "Security & Privacy",
              Icons.security,
              [
                _buildSwitchSetting(
                  "Biometric Authentication",
                  "Use fingerprint or face ID to secure app",
                  biometricAuth,
                  Icons.fingerprint,
                  (value) {
                    biometricAuth = value;
                    setState(() {});
                  },
                ),
                _buildSwitchSetting(
                  "Auto Sync",
                  "Automatically sync data across devices",
                  autoSync,
                  Icons.sync,
                  (value) {
                    autoSync = value;
                    setState(() {});
                  },
                ),
                _buildActionSetting(
                  "Change Password",
                  "Update your account password",
                  Icons.lock,
                  () {
                    ss("Navigate to change password");
                  },
                ),
                _buildActionSetting(
                  "Privacy Policy",
                  "View our privacy policy",
                  Icons.privacy_tip,
                  () {
                    ss("Opening privacy policy");
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Format Settings Section
            _buildSettingsSection(
              "Date & Time",
              Icons.schedule,
              [
                _buildDropdownSetting(
                  "Date Format",
                  "Choose how dates are displayed",
                  dateFormat,
                  dateFormatOptions,
                  Icons.calendar_today,
                  (value) {
                    dateFormat = value;
                    setState(() {});
                  },
                ),
                _buildDropdownSetting(
                  "Time Format",
                  "Choose 12 or 24 hour time format",
                  timeFormat,
                  timeFormatOptions,
                  Icons.access_time,
                  (value) {
                    timeFormat = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Support Settings Section
            _buildSettingsSection(
              "Support & Help",
              Icons.help,
              [
                _buildActionSetting(
                  "Help Center",
                  "Get help and support",
                  Icons.help_center,
                  () {
                    ss("Opening help center");
                  },
                ),
                _buildActionSetting(
                  "Contact Support",
                  "Contact our support team",
                  Icons.support_agent,
                  () {
                    ss("Opening contact support");
                  },
                ),
                _buildActionSetting(
                  "Send Feedback",
                  "Share your feedback with us",
                  Icons.feedback,
                  () {
                    ss("Opening feedback form");
                  },
                ),
                _buildActionSetting(
                  "Rate App",
                  "Rate us on the app store",
                  Icons.star_rate,
                  () {
                    ss("Opening app store rating");
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Account Settings Section
            _buildSettingsSection(
              "Account",
              Icons.account_circle,
              [
                _buildActionSetting(
                  "Backup Data",
                  "Backup your account data",
                  Icons.backup,
                  () {
                    ss("Navigate to backup settings");
                  },
                ),
                _buildActionSetting(
                  "Export Data",
                  "Export your data",
                  Icons.download,
                  () {
                    ss("Starting data export");
                  },
                ),
                _buildActionSetting(
                  "Delete Account",
                  "Permanently delete your account",
                  Icons.delete_forever,
                  () {
                    _showDeleteAccountDialog();
                  },
                  isDestructive: true,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // App Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "Real Estate Manager",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Version 2.1.0 (Build 210)",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "© 2024 Real Estate Manager. All rights reserved.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(spMd, spMd, spMd, spSm),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spMd),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    bool value,
    IconData icon,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildDropdownSetting(
    String title,
    String subtitle,
    String value,
    List<Map<String, dynamic>> options,
    IconData icon,
    Function(String) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: spSm),
                QDropdownField(
                  label: "",
                  items: options,
                  value: value,
                  onChanged: (newValue, label) {
                    onChanged(newValue);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSetting(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    Color textColor = isDestructive ? dangerColor : primaryColor;
    Color iconColor = isDestructive ? dangerColor : disabledBoldColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
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

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Delete Account",
          style: TextStyle(color: dangerColor),
        ),
        content: Text(
          "Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              se("Account deletion cancelled");
            },
            child: Text(
              "Delete",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }
}

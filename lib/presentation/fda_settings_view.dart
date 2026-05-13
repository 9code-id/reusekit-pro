import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSettingsView extends StatefulWidget {
  const FdaSettingsView({super.key});

  @override
  State<FdaSettingsView> createState() => _FdaSettingsViewState();
}

class _FdaSettingsViewState extends State<FdaSettingsView> {
  // Notification Settings
  bool orderNotifications = true;
  bool promotionalNotifications = true;
  bool deliveryNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  
  // App Preferences
  String language = "english";
  String currency = "usd";
  String temperatureUnit = "celsius";
  bool darkMode = false;
  bool biometricAuth = true;
  
  // Privacy Settings
  bool locationServices = true;
  bool analytics = true;
  bool personalizedAds = false;
  bool shareData = false;
  
  // Delivery Preferences
  String defaultDeliveryTime = "asap";
  bool contactlessDelivery = true;
  bool deliveryInstructions = true;

  final List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
    {"label": "Portuguese", "value": "portuguese"},
  ];

  final List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD (\$)", "value": "usd"},
    {"label": "EUR (€)", "value": "eur"},
    {"label": "GBP (£)", "value": "gbp"},
    {"label": "CAD (C\$)", "value": "cad"},
    {"label": "AUD (A\$)", "value": "aud"},
  ];

  final List<Map<String, dynamic>> deliveryTimeOptions = [
    {"label": "As Soon As Possible", "value": "asap"},
    {"label": "15 minutes", "value": "15min"},
    {"label": "30 minutes", "value": "30min"},
    {"label": "1 hour", "value": "1hour"},
    {"label": "Schedule for later", "value": "schedule"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _buildSectionHeader("Account", Icons.person),
            _buildAccountSettings(),
            
            SizedBox(height: spLg),
            
            // Notifications Section
            _buildSectionHeader("Notifications", Icons.notifications),
            _buildNotificationSettings(),
            
            SizedBox(height: spLg),
            
            // App Preferences Section
            _buildSectionHeader("App Preferences", Icons.settings),
            _buildAppPreferences(),
            
            SizedBox(height: spLg),
            
            // Delivery Preferences Section
            _buildSectionHeader("Delivery Preferences", Icons.delivery_dining),
            _buildDeliveryPreferences(),
            
            SizedBox(height: spLg),
            
            // Privacy & Security Section
            _buildSectionHeader("Privacy & Security", Icons.privacy_tip),
            _buildPrivacySettings(),
            
            SizedBox(height: spLg),
            
            // Support Section
            _buildSectionHeader("Support", Icons.help),
            _buildSupportOptions(),
            
            SizedBox(height: spLg),
            
            // App Information
            _buildSectionHeader("App Information", Icons.info),
            _buildAppInformation(),
            
            SizedBox(height: spLg),
            
            // Danger Zone
            _buildSectionHeader("Account Management", Icons.warning, color: dangerColor),
            _buildDangerZone(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: color ?? primaryColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color ?? primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            title: "Edit Profile",
            subtitle: "Update your personal information",
            icon: Icons.edit,
            onTap: () => {
              //navigateTo('edit_profile_view')
            },
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Address Book",
            subtitle: "Manage delivery addresses",
            icon: Icons.location_on,
            onTap: () => {
              //navigateTo('address_book_view')
            },
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Payment Methods",
            subtitle: "Manage cards and payment options",
            icon: Icons.payment,
            onTap: () => {
              //navigateTo('payment_cards_view')
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: "Order Updates",
            subtitle: "Get notified about order status changes",
            value: orderNotifications,
            onChanged: (value) => setState(() => orderNotifications = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Promotional Offers",
            subtitle: "Receive deals and discount notifications",
            value: promotionalNotifications,
            onChanged: (value) => setState(() => promotionalNotifications = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Delivery Updates",
            subtitle: "Track your delivery in real-time",
            value: deliveryNotifications,
            onChanged: (value) => setState(() => deliveryNotifications = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Email Notifications",
            subtitle: "Receive updates via email",
            value: emailNotifications,
            onChanged: (value) => setState(() => emailNotifications = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "SMS Notifications",
            subtitle: "Get text messages for important updates",
            value: smsNotifications,
            onChanged: (value) => setState(() => smsNotifications = value),
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildDropdownTile(
            title: "Language",
            subtitle: "Choose your preferred language",
            icon: Icons.language,
            value: language,
            options: languageOptions,
            onChanged: (value) => setState(() => language = value),
          ),
          Divider(height: 1),
          _buildDropdownTile(
            title: "Currency",
            subtitle: "Select display currency",
            icon: Icons.attach_money,
            value: currency,
            options: currencyOptions,
            onChanged: (value) => setState(() => currency = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Dark Mode",
            subtitle: "Use dark theme throughout the app",
            value: darkMode,
            onChanged: (value) => setState(() => darkMode = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Biometric Authentication",
            subtitle: "Use fingerprint or face unlock",
            value: biometricAuth,
            onChanged: (value) => setState(() => biometricAuth = value),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPreferences() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildDropdownTile(
            title: "Default Delivery Time",
            subtitle: "Preferred delivery timing",
            icon: Icons.schedule,
            value: defaultDeliveryTime,
            options: deliveryTimeOptions,
            onChanged: (value) => setState(() => defaultDeliveryTime = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Contactless Delivery",
            subtitle: "Leave orders at door by default",
            value: contactlessDelivery,
            onChanged: (value) => setState(() => contactlessDelivery = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Save Delivery Instructions",
            subtitle: "Remember special delivery notes",
            value: deliveryInstructions,
            onChanged: (value) => setState(() => deliveryInstructions = value),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: "Location Services",
            subtitle: "Allow app to access your location",
            value: locationServices,
            onChanged: (value) => setState(() => locationServices = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Analytics & Crash Reports",
            subtitle: "Help improve the app experience",
            value: analytics,
            onChanged: (value) => setState(() => analytics = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Personalized Ads",
            subtitle: "Show relevant advertisements",
            value: personalizedAds,
            onChanged: (value) => setState(() => personalizedAds = value),
          ),
          Divider(height: 1),
          _buildSwitchTile(
            title: "Share Usage Data",
            subtitle: "Share anonymous usage statistics",
            value: shareData,
            onChanged: (value) => setState(() => shareData = value),
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Privacy Policy",
            subtitle: "Read our privacy policy",
            icon: Icons.policy,
            onTap: () => {
              //navigateTo('privacy_policy_view')
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            title: "Help Center",
            subtitle: "Browse frequently asked questions",
            icon: Icons.help_center,
            onTap: () => {
              //navigateTo('help_center_view')
            },
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Contact Support",
            subtitle: "Get help from our support team",
            icon: Icons.support_agent,
            onTap: () => {
              //navigateTo('contact_support_view')
            },
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Report a Bug",
            subtitle: "Let us know about issues you've found",
            icon: Icons.bug_report,
            onTap: () => _showBugReportDialog(),
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Rate the App",
            subtitle: "Share your feedback on the app store",
            icon: Icons.star_rate,
            onTap: () => si("Opening app store..."),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInformation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            title: "App Version",
            subtitle: "2.5.0 (Build 250)",
            icon: Icons.info_outline,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Latest",
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Terms of Service",
            subtitle: "Read our terms and conditions",
            icon: Icons.description,
            onTap: () => {
              //navigateTo('terms_of_service_view')
            },
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Open Source Licenses",
            subtitle: "View third-party licenses",
            icon: Icons.code,
            onTap: () => _showLicensesDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            title: "Clear Cache",
            subtitle: "Free up storage space",
            icon: Icons.cleaning_services,
            iconColor: warningColor,
            onTap: _clearCache,
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Sign Out",
            subtitle: "Sign out from your account",
            icon: Icons.logout,
            iconColor: warningColor,
            onTap: _signOut,
          ),
          Divider(height: 1),
          _buildSettingsTile(
            title: "Delete Account",
            subtitle: "Permanently delete your account",
            icon: Icons.delete_forever,
            iconColor: dangerColor,
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String subtitle,
    required IconData icon,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? disabledBoldColor,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: disabledBoldColor,
        ),
      ),
      trailing: trailing ?? (onTap != null ? Icon(Icons.chevron_right, color: disabledBoldColor) : null),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: disabledBoldColor,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<Map<String, dynamic>> options,
    required Function(String) onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: disabledBoldColor,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: disabledBoldColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            options.firstWhere((option) => option["value"] == value)["label"],
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spXs),
          Icon(Icons.chevron_right, color: disabledBoldColor),
        ],
      ),
      onTap: () => _showDropdownDialog(title, value, options, onChanged),
    );
  }

  void _showDropdownDialog(String title, String currentValue, List<Map<String, dynamic>> options, Function(String) onChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: option["value"],
                groupValue: currentValue,
                onChanged: (value) {
                  onChanged(value!);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showBugReportDialog() {
    String bugDescription = "";
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Report a Bug"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Describe the issue you encountered:"),
              SizedBox(height: spMd),
              QMemoField(
                label: "Bug Description",
                value: bugDescription,
                hint: "Please provide detailed information about the bug...",
                onChanged: (value) => bugDescription = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ss("Bug report submitted. Thank you!");
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _showLicensesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Source Licenses"),
          content: Text("This app uses various open source libraries. View detailed license information in the app's legal section."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all settings to default values?");
    if (isConfirmed) {
      setState(() {
        // Reset all settings to defaults
        orderNotifications = true;
        promotionalNotifications = true;
        deliveryNotifications = true;
        emailNotifications = false;
        smsNotifications = true;
        language = "english";
        currency = "usd";
        darkMode = false;
        biometricAuth = true;
        locationServices = true;
        analytics = true;
        personalizedAds = false;
        shareData = false;
        defaultDeliveryTime = "asap";
        contactlessDelivery = true;
        deliveryInstructions = true;
      });
      ss("Settings reset to defaults");
    }
  }

  void _clearCache() async {
    bool isConfirmed = await confirm("Clear app cache? This will free up storage space but may slow down the app temporarily.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Cache cleared successfully");
    }
  }

  void _signOut() async {
    bool isConfirmed = await confirm("Sign out of your account?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      //navigateTo('login_view')
      ss("Signed out successfully");
    }
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.");
    if (isConfirmed) {
      se("Account deletion is not available in demo mode");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSettingsView extends StatefulWidget {
  const EcsSettingsView({super.key});

  @override
  State<EcsSettingsView> createState() => _EcsSettingsViewState();
}

class _EcsSettingsViewState extends State<EcsSettingsView> {
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool promotionalEmails = false;
  bool orderUpdates = true;
  bool darkMode = false;
  bool biometricAuth = false;
  bool autoSync = true;
  String selectedLanguage = "English";
  String selectedCurrency = "USD";

  void _signOut() async {
    bool isConfirmed = await confirm("Are you sure you want to sign out?");
    if (!isConfirmed) return;

    // Simulate sign out process
    await Future.delayed(Duration(seconds: 1));
    
    ss("Signed out successfully");
    // Navigate to login
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (!isConfirmed) return;

    // Navigate to account deletion confirmation
    sw("Account deletion requires additional verification");
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: children,
          ),
        ),
        SizedBox(height: spMd),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (iconColor ?? primaryColor).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? primaryColor,
                  size: 20,
                ),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? iconColor,
  }) {
    return _buildSettingsItem(
      icon: icon,
      title: title,
      subtitle: subtitle,
      iconColor: iconColor,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Account Settings
            _buildSettingsSection(
              "Account",
              [
                _buildSettingsItem(
                  icon: Icons.person,
                  title: "Profile",
                  subtitle: "Edit your personal information",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to profile page"),
                ),
                _buildSettingsItem(
                  icon: Icons.location_on,
                  title: "Address Book",
                  subtitle: "Manage shipping addresses",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to address book"),
                ),
                _buildSettingsItem(
                  icon: Icons.credit_card,
                  title: "Payment Methods",
                  subtitle: "Manage payment cards",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to payment methods"),
                ),
                _buildSettingsItem(
                  icon: Icons.security,
                  title: "Security",
                  subtitle: "Password and authentication",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to security settings"),
                ),
              ],
            ),

            // Notification Settings
            _buildSettingsSection(
              "Notifications",
              [
                _buildSwitchItem(
                  icon: Icons.notifications,
                  title: "Push Notifications",
                  subtitle: "Receive notifications on your device",
                  value: pushNotifications,
                  onChanged: (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.email,
                  title: "Email Notifications",
                  subtitle: "Receive order updates via email",
                  value: emailNotifications,
                  onChanged: (value) {
                    emailNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.local_offer,
                  title: "Promotional Emails",
                  subtitle: "Receive offers and deals",
                  value: promotionalEmails,
                  onChanged: (value) {
                    promotionalEmails = value;
                    setState(() {});
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.shopping_bag,
                  title: "Order Updates",
                  subtitle: "Notifications about order status",
                  value: orderUpdates,
                  onChanged: (value) {
                    orderUpdates = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // App Settings
            _buildSettingsSection(
              "App Preferences",
              [
                _buildSettingsItem(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: selectedLanguage,
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to language settings"),
                ),
                _buildSettingsItem(
                  icon: Icons.attach_money,
                  title: "Currency",
                  subtitle: selectedCurrency,
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to currency settings"),
                ),
                _buildSettingsItem(
                  icon: Icons.palette,
                  title: "Theme",
                  subtitle: darkMode ? "Dark" : "Light",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to theme settings"),
                ),
                _buildSwitchItem(
                  icon: Icons.fingerprint,
                  title: "Biometric Authentication",
                  subtitle: "Use fingerprint or face ID",
                  value: biometricAuth,
                  onChanged: (value) {
                    biometricAuth = value;
                    setState(() {});
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.sync,
                  title: "Auto Sync",
                  subtitle: "Automatically sync data",
                  value: autoSync,
                  onChanged: (value) {
                    autoSync = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Support & Legal
            _buildSettingsSection(
              "Support & Legal",
              [
                _buildSettingsItem(
                  icon: Icons.help,
                  title: "Help Center",
                  subtitle: "FAQs and support articles",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to help center"),
                ),
                _buildSettingsItem(
                  icon: Icons.chat,
                  title: "Contact Support",
                  subtitle: "Get help from our team",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to contact support"),
                ),
                _buildSettingsItem(
                  icon: Icons.description,
                  title: "Terms of Service",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to terms of service"),
                ),
                _buildSettingsItem(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to privacy policy"),
                ),
                _buildSettingsItem(
                  icon: Icons.info,
                  title: "About",
                  subtitle: "App version and information",
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                  onTap: () => si("Navigate to about page"),
                ),
              ],
            ),

            // Account Actions
            _buildSettingsSection(
              "Account Actions",
              [
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: "Sign Out",
                  subtitle: "Sign out of your account",
                  iconColor: warningColor,
                  onTap: _signOut,
                ),
                _buildSettingsItem(
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                  subtitle: "Permanently delete your account",
                  iconColor: dangerColor,
                  onTap: _deleteAccount,
                ),
              ],
            ),

            // App Version
            Container(
              padding: EdgeInsets.all(spSm),
              child: Text(
                "Version 1.0.0 (Build 100)",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

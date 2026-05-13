import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaSettingsView extends StatefulWidget {
  const DlaSettingsView({super.key});

  @override
  State<DlaSettingsView> createState() => _DlaSettingsViewState();
}

class _DlaSettingsViewState extends State<DlaSettingsView> {
  // Notification Settings
  bool pushNotifications = true;
  bool newDeliveryAlerts = true;
  bool routeUpdates = true;
  bool emergencyAlerts = true;
  bool promotionalNotifications = false;

  // App Preferences
  bool autoOptimizeRoute = true;
  bool offlineMode = false;
  bool highContrastMode = false;
  bool voiceGuidance = true;
  String mapStyle = "standard";
  String language = "english";
  String units = "metric";

  // Privacy Settings
  bool shareLocation = true;
  bool shareDeliveryStats = true;
  bool allowAnalytics = true;
  bool personalizedAds = false;

  // Performance Settings
  String imageQuality = "medium";
  bool autoUploadPhotos = true;
  bool backgroundSync = true;
  String cacheSize = "50mb";

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
            _buildSectionCard(
              title: "Notifications",
              icon: Icons.notifications,
              color: primaryColor,
              children: [
                _buildSwitchTile(
                  title: "Push Notifications",
                  subtitle: "Enable all push notifications",
                  value: pushNotifications,
                  onChanged: (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "New Delivery Alerts",
                  subtitle: "Notify when new deliveries are assigned",
                  value: newDeliveryAlerts,
                  onChanged: (value) {
                    newDeliveryAlerts = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Route Updates",
                  subtitle: "Notify about route changes and optimization",
                  value: routeUpdates,
                  onChanged: (value) {
                    routeUpdates = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Emergency Alerts",
                  subtitle: "Important safety and emergency notifications",
                  value: emergencyAlerts,
                  onChanged: (value) {
                    emergencyAlerts = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Promotional Notifications",
                  subtitle: "Offers, tips, and company updates",
                  value: promotionalNotifications,
                  onChanged: (value) {
                    promotionalNotifications = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            _buildSectionCard(
              title: "App Preferences",
              icon: Icons.tune,
              color: infoColor,
              children: [
                _buildSwitchTile(
                  title: "Auto Optimize Route",
                  subtitle: "Automatically optimize delivery routes",
                  value: autoOptimizeRoute,
                  onChanged: (value) {
                    autoOptimizeRoute = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Offline Mode",
                  subtitle: "Enable offline functionality when available",
                  value: offlineMode,
                  onChanged: (value) {
                    offlineMode = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "High Contrast Mode",
                  subtitle: "Improve visibility with high contrast colors",
                  value: highContrastMode,
                  onChanged: (value) {
                    highContrastMode = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Voice Guidance",
                  subtitle: "Enable voice navigation and instructions",
                  value: voiceGuidance,
                  onChanged: (value) {
                    voiceGuidance = value;
                    setState(() {});
                  },
                ),
                _buildDropdownTile(
                  title: "Map Style",
                  subtitle: "Choose your preferred map appearance",
                  value: mapStyle,
                  items: [
                    {"label": "Standard", "value": "standard"},
                    {"label": "Satellite", "value": "satellite"},
                    {"label": "Terrain", "value": "terrain"},
                    {"label": "Dark Mode", "value": "dark"},
                  ],
                  onChanged: (value) {
                    mapStyle = value;
                    setState(() {});
                  },
                ),
                _buildDropdownTile(
                  title: "Language",
                  subtitle: "App display language",
                  value: language,
                  items: [
                    {"label": "English", "value": "english"},
                    {"label": "Spanish", "value": "spanish"},
                    {"label": "French", "value": "french"},
                    {"label": "German", "value": "german"},
                  ],
                  onChanged: (value) {
                    language = value;
                    setState(() {});
                  },
                ),
                _buildDropdownTile(
                  title: "Units",
                  subtitle: "Distance and measurement units",
                  value: units,
                  items: [
                    {"label": "Metric (km, m)", "value": "metric"},
                    {"label": "Imperial (mi, ft)", "value": "imperial"},
                  ],
                  onChanged: (value) {
                    units = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            _buildSectionCard(
              title: "Privacy & Security",
              icon: Icons.security,
              color: warningColor,
              children: [
                _buildSwitchTile(
                  title: "Share Location",
                  subtitle: "Allow location sharing for delivery tracking",
                  value: shareLocation,
                  onChanged: (value) {
                    shareLocation = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Share Delivery Statistics",
                  subtitle: "Help improve service with anonymous delivery data",
                  value: shareDeliveryStats,
                  onChanged: (value) {
                    shareDeliveryStats = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Analytics",
                  subtitle: "Allow app usage analytics for improvement",
                  value: allowAnalytics,
                  onChanged: (value) {
                    allowAnalytics = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Personalized Ads",
                  subtitle: "Show ads based on your preferences",
                  value: personalizedAds,
                  onChanged: (value) {
                    personalizedAds = value;
                    setState(() {});
                  },
                ),
                _buildActionTile(
                  title: "Clear Personal Data",
                  subtitle: "Remove all personal data from the app",
                  icon: Icons.delete_outline,
                  color: dangerColor,
                  onTap: () {
                    // Clear personal data
                  },
                ),
              ],
            ),

            _buildSectionCard(
              title: "Performance",
              icon: Icons.speed,
              color: successColor,
              children: [
                _buildDropdownTile(
                  title: "Image Quality",
                  subtitle: "Quality of photos taken during delivery",
                  value: imageQuality,
                  items: [
                    {"label": "High Quality", "value": "high"},
                    {"label": "Medium Quality", "value": "medium"},
                    {"label": "Low Quality", "value": "low"},
                  ],
                  onChanged: (value) {
                    imageQuality = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Auto Upload Photos",
                  subtitle: "Automatically upload delivery photos",
                  value: autoUploadPhotos,
                  onChanged: (value) {
                    autoUploadPhotos = value;
                    setState(() {});
                  },
                ),
                _buildSwitchTile(
                  title: "Background Sync",
                  subtitle: "Sync data when app is in background",
                  value: backgroundSync,
                  onChanged: (value) {
                    backgroundSync = value;
                    setState(() {});
                  },
                ),
                _buildDropdownTile(
                  title: "Cache Size",
                  subtitle: "Amount of data stored locally",
                  value: cacheSize,
                  items: [
                    {"label": "25 MB", "value": "25mb"},
                    {"label": "50 MB", "value": "50mb"},
                    {"label": "100 MB", "value": "100mb"},
                    {"label": "200 MB", "value": "200mb"},
                  ],
                  onChanged: (value) {
                    cacheSize = value;
                    setState(() {});
                  },
                ),
                _buildActionTile(
                  title: "Clear Cache",
                  subtitle: "Free up storage space by clearing cache",
                  icon: Icons.cleaning_services,
                  color: infoColor,
                  onTap: () {
                    // Clear cache
                    ss("Cache cleared successfully");
                  },
                ),
              ],
            ),

            _buildSectionCard(
              title: "About",
              icon: Icons.info_outline,
              color: secondaryColor,
              children: [
                _buildInfoTile(
                  title: "App Version",
                  value: "2.1.4",
                ),
                _buildInfoTile(
                  title: "Build Number",
                  value: "214",
                ),
                _buildInfoTile(
                  title: "Last Updated",
                  value: "June 15, 2024",
                ),
                _buildActionTile(
                  title: "Check for Updates",
                  subtitle: "Look for app updates",
                  icon: Icons.system_update,
                  color: primaryColor,
                  onTap: () {
                    // Check for updates
                    si("You're using the latest version");
                  },
                ),
                _buildActionTile(
                  title: "Terms of Service",
                  subtitle: "Read our terms and conditions",
                  icon: Icons.description,
                  color: disabledBoldColor,
                  onTap: () {
                    // Navigate to terms
                  },
                ),
                _buildActionTile(
                  title: "Privacy Policy",
                  subtitle: "Learn about our privacy practices",
                  icon: Icons.privacy_tip,
                  color: disabledBoldColor,
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
              ],
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign Out",
                size: bs.md,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Are you sure you want to sign out?");
                  if (isConfirmed) {
                    // Sign out
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<Map<String, String>> items,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          QDropdownField(
            label: "",
            items: items,
            value: value,
            onChanged: (newValue, label) {
              onChanged(newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildInfoTile({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}

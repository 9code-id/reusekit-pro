import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPrivacySettingsView extends StatefulWidget {
  const SpaPrivacySettingsView({super.key});

  @override
  State<SpaPrivacySettingsView> createState() => _SpaPrivacySettingsViewState();
}

class _SpaPrivacySettingsViewState extends State<SpaPrivacySettingsView> {
  bool profileVisibility = true;
  bool dataSharing = false;
  bool marketingEmails = true;
  bool pushNotifications = true;
  bool locationTracking = false;
  bool analyticsTracking = true;
  bool thirdPartySharing = false;
  bool socialMediaSync = false;
  bool reviewSharing = true;
  bool appointmentReminders = true;
  
  String selectedVisibilityLevel = "friends";
  String selectedDataRetention = "2_years";
  
  List<Map<String, dynamic>> visibilityItems = [
    {"label": "Public", "value": "public"},
    {"label": "Friends Only", "value": "friends"},
    {"label": "Private", "value": "private"},
  ];
  
  List<Map<String, dynamic>> dataRetentionItems = [
    {"label": "1 Year", "value": "1_year"},
    {"label": "2 Years", "value": "2_years"},
    {"label": "5 Years", "value": "5_years"},
    {"label": "Forever", "value": "forever"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showPrivacyHelp(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPrivacyOverviewSection(),
            _buildProfilePrivacySection(),
            _buildDataSharingSection(),
            _buildCommunicationSection(),
            _buildTrackingSection(),
            _buildDataRetentionSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPrivacyOverviewSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
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
              Expanded(
                child: Text(
                  "Privacy Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Control how your personal information is used and shared. We respect your privacy and give you full control over your data.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildPrivacyScore(),
              ),
              SizedBox(width: spMd),
              QButton(
                label: "Review Policy",
                size: bs.sm,
                onPressed: () => _reviewPrivacyPolicy(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacyScore() {
    int activeSettings = 0;
    if (!profileVisibility) activeSettings++;
    if (!dataSharing) activeSettings++;
    if (!locationTracking) activeSettings++;
    if (!thirdPartySharing) activeSettings++;
    
    double score = (activeSettings / 4) * 100;
    Color scoreColor = score >= 75 ? successColor : score >= 50 ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: scoreColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "Privacy Score",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${score.toInt()}%",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfilePrivacySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Privacy",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Profile Visibility",
            items: visibilityItems,
            value: selectedVisibilityLevel,
            onChanged: (value, label) {
              selectedVisibilityLevel = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Profile Visibility",
            "Allow others to see your profile information",
            profileVisibility,
            Icons.visibility,
            (value) {
              profileVisibility = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Review Sharing",
            "Share your reviews and ratings publicly",
            reviewSharing,
            Icons.star,
            (value) {
              reviewSharing = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Social Media Sync",
            "Sync your profile with social media accounts",
            socialMediaSync,
            Icons.share,
            (value) {
              socialMediaSync = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDataSharingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Sharing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSettingItem(
            "Data Sharing",
            "Share anonymous usage data to improve our services",
            dataSharing,
            Icons.share_outlined,
            (value) {
              dataSharing = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Third-party Sharing",
            "Allow sharing data with trusted partners",
            thirdPartySharing,
            Icons.group,
            (value) {
              thirdPartySharing = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Analytics Tracking",
            "Help us improve by sharing usage analytics",
            analyticsTracking,
            Icons.analytics,
            (value) {
              analyticsTracking = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildCommunicationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Communication Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSettingItem(
            "Marketing Emails",
            "Receive promotional emails and offers",
            marketingEmails,
            Icons.email,
            (value) {
              marketingEmails = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Push Notifications",
            "Get notifications about appointments and updates",
            pushNotifications,
            Icons.notifications,
            (value) {
              pushNotifications = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Appointment Reminders",
            "Receive reminders about upcoming appointments",
            appointmentReminders,
            Icons.schedule,
            (value) {
              appointmentReminders = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTrackingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tracking Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSettingItem(
            "Location Tracking",
            "Allow location access for nearby spa recommendations",
            locationTracking,
            Icons.location_on,
            (value) {
              locationTracking = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Location data is only used to suggest nearby spas and is never shared with third parties.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDataRetentionSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Retention",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Data Retention Period",
            items: dataRetentionItems,
            value: selectedDataRetention,
            onChanged: (value, label) {
              selectedDataRetention = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Data Retention Information",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Account data is kept for the selected period after account deletion\n• Payment history is retained for tax and legal compliance\n• You can request data deletion at any time",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingItem(String title, String description, bool value, IconData icon, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? primaryColor : disabledBoldColor,
            size: 20,
          ),
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
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
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
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Privacy Settings",
            size: bs.md,
            onPressed: () => _savePrivacySettings(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Export My Data",
            size: bs.md,
            onPressed: () => _exportData(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Delete My Account",
            size: bs.md,
            onPressed: () => _deleteAccount(),
          ),
        ),
      ],
    );
  }
  
  void _showPrivacyHelp() {
    si("Privacy help information available");
  }
  
  void _reviewPrivacyPolicy() {
    si("Opening privacy policy");
  }
  
  void _savePrivacySettings() {
    ss("Privacy settings saved successfully");
  }
  
  void _exportData() async {
    bool isConfirmed = await confirm("Export all your data? This may take a few minutes to prepare.");
    if (isConfirmed) {
      si("Data export initiated. You'll receive an email when ready.");
    }
  }
  
  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (isConfirmed) {
      se("Account deletion initiated. Please contact support if you need assistance.");
    }
  }
}

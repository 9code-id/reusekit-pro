import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaPrivacySettingsView extends StatefulWidget {
  const FwaPrivacySettingsView({super.key});

  @override
  State<FwaPrivacySettingsView> createState() => _FwaPrivacySettingsViewState();
}

class _FwaPrivacySettingsViewState extends State<FwaPrivacySettingsView> {
  bool shareDataWithPartners = false;
  bool allowAnalytics = true;
  bool shareWorkoutData = false;
  bool shareHealthMetrics = false;
  bool publicProfile = false;
  bool showInLeaderboards = true;
  bool allowFriendRequests = true;
  bool shareLocation = false;
  bool crashReporting = true;
  bool usageAnalytics = true;
  bool marketingEmails = false;
  bool researchParticipation = false;
  
  String dataRetention = "2_years";
  String profileVisibility = "friends_only";
  String workoutVisibility = "private";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Data Sharing
            _buildDataSharingSection(),
            
            // Profile Privacy
            _buildProfilePrivacySection(),
            
            // Health Data Privacy
            _buildHealthDataPrivacySection(),
            
            // Social Features
            _buildSocialFeaturesSection(),
            
            // Analytics & Reporting
            _buildAnalyticsSection(),
            
            // Data Management
            _buildDataManagementSection(),
            
            // Privacy Actions
            _buildPrivacyActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSharingSection() {
    return Container(
      width: double.infinity,
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
                Icons.share,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Data Sharing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Control how your data is shared with third parties and partners",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildPrivacyToggle(
            title: "Share Data with Partners",
            subtitle: "Allow sharing anonymized data with fitness partners",
            value: shareDataWithPartners,
            onChanged: (value) {
              setState(() {
                shareDataWithPartners = value;
              });
              ss(value ? "Partner data sharing enabled" : "Partner data sharing disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Analytics Data",
            subtitle: "Help improve the app with usage analytics",
            value: allowAnalytics,
            onChanged: (value) {
              setState(() {
                allowAnalytics = value;
              });
              ss(value ? "Analytics enabled" : "Analytics disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Research Participation",
            subtitle: "Participate in fitness research studies",
            value: researchParticipation,
            onChanged: (value) {
              setState(() {
                researchParticipation = value;
              });
              ss(value ? "Research participation enabled" : "Research participation disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePrivacySection() {
    return Container(
      width: double.infinity,
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
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Profile Privacy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Manage who can see your profile and activity",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QDropdownField(
            label: "Profile Visibility",
            items: [
              {"label": "Public", "value": "public"},
              {"label": "Friends Only", "value": "friends_only"},
              {"label": "Private", "value": "private"},
            ],
            value: profileVisibility,
            onChanged: (value, label) {
              profileVisibility = value;
              setState(() {});
              ss("Profile visibility set to $label");
            },
          ),
          QDropdownField(
            label: "Workout Visibility",
            items: [
              {"label": "Public", "value": "public"},
              {"label": "Friends Only", "value": "friends_only"},
              {"label": "Private", "value": "private"},
            ],
            value: workoutVisibility,
            onChanged: (value, label) {
              workoutVisibility = value;
              setState(() {});
              ss("Workout visibility set to $label");
            },
          ),
          _buildPrivacyToggle(
            title: "Public Profile",
            subtitle: "Make your profile discoverable by other users",
            value: publicProfile,
            onChanged: (value) {
              setState(() {
                publicProfile = value;
              });
              ss(value ? "Public profile enabled" : "Public profile disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHealthDataPrivacySection() {
    return Container(
      width: double.infinity,
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
                Icons.favorite,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Health Data Privacy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Control sharing of sensitive health and fitness data",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildPrivacyToggle(
            title: "Share Workout Data",
            subtitle: "Allow sharing workout statistics with connections",
            value: shareWorkoutData,
            onChanged: (value) {
              setState(() {
                shareWorkoutData = value;
              });
              ss(value ? "Workout data sharing enabled" : "Workout data sharing disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Share Health Metrics",
            subtitle: "Share heart rate, weight, and other health metrics",
            value: shareHealthMetrics,
            onChanged: (value) {
              setState(() {
                shareHealthMetrics = value;
              });
              ss(value ? "Health metrics sharing enabled" : "Health metrics sharing disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Location Sharing",
            subtitle: "Share workout locations with other users",
            value: shareLocation,
            onChanged: (value) {
              setState(() {
                shareLocation = value;
              });
              ss(value ? "Location sharing enabled" : "Location sharing disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialFeaturesSection() {
    return Container(
      width: double.infinity,
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
                Icons.groups,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Social Features",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Manage social interactions and community features",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildPrivacyToggle(
            title: "Show in Leaderboards",
            subtitle: "Appear in fitness leaderboards and challenges",
            value: showInLeaderboards,
            onChanged: (value) {
              setState(() {
                showInLeaderboards = value;
              });
              ss(value ? "Leaderboard participation enabled" : "Leaderboard participation disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Allow Friend Requests",
            subtitle: "Let other users send you friend requests",
            value: allowFriendRequests,
            onChanged: (value) {
              setState(() {
                allowFriendRequests = value;
              });
              ss(value ? "Friend requests enabled" : "Friend requests disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      width: double.infinity,
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
                Icons.analytics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Analytics & Reporting",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Help us improve the app with anonymous data",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildPrivacyToggle(
            title: "Crash Reporting",
            subtitle: "Automatically send crash reports to help fix bugs",
            value: crashReporting,
            onChanged: (value) {
              setState(() {
                crashReporting = value;
              });
              ss(value ? "Crash reporting enabled" : "Crash reporting disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Usage Analytics",
            subtitle: "Share anonymous usage data to improve features",
            value: usageAnalytics,
            onChanged: (value) {
              setState(() {
                usageAnalytics = value;
              });
              ss(value ? "Usage analytics enabled" : "Usage analytics disabled");
            },
          ),
          _buildPrivacyToggle(
            title: "Marketing Communications",
            subtitle: "Receive personalized fitness tips and offers",
            value: marketingEmails,
            onChanged: (value) {
              setState(() {
                marketingEmails = value;
              });
              ss(value ? "Marketing emails enabled" : "Marketing emails disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
    return Container(
      width: double.infinity,
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
                Icons.storage,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Data Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Control how long your data is stored",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QDropdownField(
            label: "Data Retention Period",
            items: [
              {"label": "6 Months", "value": "6_months"},
              {"label": "1 Year", "value": "1_year"},
              {"label": "2 Years", "value": "2_years"},
              {"label": "5 Years", "value": "5_years"},
              {"label": "Indefinite", "value": "indefinite"},
            ],
            value: dataRetention,
            onChanged: (value, label) {
              dataRetention = value;
              setState(() {});
              ss("Data retention set to $label");
            },
          ),
          _buildPrivacyAction(
            icon: Icons.download,
            title: "Download My Data",
            subtitle: "Get a copy of all your stored data",
            onTap: () {
              ss("Data export request initiated");
            },
          ),
          _buildPrivacyAction(
            icon: Icons.delete_forever,
            title: "Delete All Data",
            subtitle: "Permanently remove all your data",
            isDestructive: true,
            onTap: () async {
              bool isConfirmed = await confirm("Are you sure you want to delete all your data? This action cannot be undone.");
              if (isConfirmed) {
                bool finalConfirm = await confirm("This will permanently delete your account and all associated data. Are you absolutely sure?");
                if (finalConfirm) {
                  se("Data deletion request initiated. You will receive a confirmation email.");
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyActionsSection() {
    return Container(
      width: double.infinity,
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
                Icons.security,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Privacy Resources",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildPrivacyAction(
            icon: Icons.policy,
            title: "Privacy Policy",
            subtitle: "Read our complete privacy policy",
            onTap: () {
              ss("Open privacy policy");
            },
          ),
          _buildPrivacyAction(
            icon: Icons.description,
            title: "Data Usage Terms",
            subtitle: "Understand how we use your data",
            onTap: () {
              ss("Open data usage terms");
            },
          ),
          _buildPrivacyAction(
            icon: Icons.help,
            title: "Privacy Help",
            subtitle: "Get help with privacy settings",
            onTap: () {
              ss("Open privacy help center");
            },
          ),
          _buildPrivacyAction(
            icon: Icons.feedback,
            title: "Privacy Feedback",
            subtitle: "Share feedback about our privacy practices",
            onTap: () {
              ss("Open privacy feedback form");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyToggle({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
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
              ],
            ),
          ),
          SizedBox(width: spSm),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDestructive ? dangerColor.withAlpha(50) : disabledOutlineBorderColor,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? dangerColor : null,
                    ),
                  ),
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
}

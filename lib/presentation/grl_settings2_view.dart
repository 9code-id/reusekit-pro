import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings2View extends StatefulWidget {
  @override
  State<GrlSettings2View> createState() => _GrlSettings2ViewState();
}

class _GrlSettings2ViewState extends State<GrlSettings2View> {
  int currentTab = 0;
  
  // Account Settings
  String firstName = "Sarah";
  String lastName = "Johnson";
  String email = "sarah.johnson@email.com";
  String phone = "+1 (555) 123-4567";
  String bio = "Software engineer passionate about mobile development";
  
  // Privacy Settings
  bool profileVisibility = true;
  bool emailVisibility = false;
  bool phoneVisibility = false;
  bool onlineStatus = true;
  bool readReceipts = true;
  bool lastSeen = false;
  
  // Notification Settings
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = false;
  bool weeklyDigest = true;
  bool securityAlerts = true;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Account Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Profile", icon: Icon(Icons.person)),
        Tab(text: "Privacy", icon: Icon(Icons.security)),
        Tab(text: "Notifications", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        _buildProfileTab(),
        _buildPrivacyTab(),
        _buildNotificationsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Profile Picture Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXl),
                        border: Border.all(color: primaryColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXl),
                        child: Image.network(
                          "https://picsum.photos/200/200?random=1&keyword=portrait",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Change Photo",
                  size: bs.sm,
                  onPressed: () {
                    si("Photo upload feature coming soon");
                  },
                ),
              ],
            ),
          ),

          // Personal Information
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
                  "Personal Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "First Name",
                        value: firstName,
                        onChanged: (value) {
                          firstName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTextField(
                        label: "Last Name",
                        value: lastName,
                        onChanged: (value) {
                          lastName = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                QTextField(
                  label: "Email Address",
                  value: email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Phone Number",
                  value: phone,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Bio",
                  value: bio,
                  hint: "Tell us about yourself",
                  onChanged: (value) {
                    bio = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Save Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () {
                ss("Profile updated successfully");
              },
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
        children: [
          // Profile Visibility
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
                  "Profile Visibility",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildPrivacyToggle(
                  Icons.public,
                  "Public Profile",
                  "Make your profile visible to everyone",
                  profileVisibility,
                  (value) {
                    profileVisibility = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildPrivacyToggle(
                  Icons.email,
                  "Show Email",
                  "Display email address on profile",
                  emailVisibility,
                  (value) {
                    emailVisibility = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildPrivacyToggle(
                  Icons.phone,
                  "Show Phone Number",
                  "Display phone number on profile",
                  phoneVisibility,
                  (value) {
                    phoneVisibility = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Activity Status
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
                  "Activity Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildPrivacyToggle(
                  Icons.circle,
                  "Online Status",
                  "Show when you're active",
                  onlineStatus,
                  (value) {
                    onlineStatus = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildPrivacyToggle(
                  Icons.check_circle,
                  "Read Receipts",
                  "Show when messages are read",
                  readReceipts,
                  (value) {
                    readReceipts = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildPrivacyToggle(
                  Icons.access_time,
                  "Last Seen",
                  "Show your last activity time",
                  lastSeen,
                  (value) {
                    lastSeen = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Privacy Actions
          Column(
            spacing: spSm,
            children: [
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Download My Data",
                  size: bs.md,
                  onPressed: () {
                    si("Data download feature coming soon");
                  },
                ),
              ),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Delete Account",
                  size: bs.md,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
                    if (isConfirmed) {
                      se("Account deletion requested");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Push Notifications
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
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildNotificationToggle(
                  Icons.notifications,
                  "Push Notifications",
                  "Receive push notifications on your device",
                  pushNotifications,
                  (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildNotificationToggle(
                  Icons.security,
                  "Security Alerts",
                  "Important security notifications",
                  securityAlerts,
                  (value) {
                    securityAlerts = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Email Notifications
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
                  "Email Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildNotificationToggle(
                  Icons.email,
                  "Email Notifications",
                  "Receive notifications via email",
                  emailNotifications,
                  (value) {
                    emailNotifications = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildNotificationToggle(
                  Icons.campaign,
                  "Marketing Emails",
                  "Promotional and marketing content",
                  marketingEmails,
                  (value) {
                    marketingEmails = value;
                    setState(() {});
                  },
                ),
                
                Divider(height: spLg),
                
                _buildNotificationToggle(
                  Icons.schedule,
                  "Weekly Digest",
                  "Weekly summary of activity",
                  weeklyDigest,
                  (value) {
                    weeklyDigest = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // SMS Notifications
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
                  "SMS Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildNotificationToggle(
                  Icons.sms,
                  "SMS Notifications",
                  "Receive notifications via SMS",
                  smsNotifications,
                  (value) {
                    smsNotifications = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Notification Settings",
              size: bs.md,
              onPressed: () {
                ss("Notification settings saved");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaUserProfileView extends StatefulWidget {
  const SpaUserProfileView({Key? key}) : super(key: key);

  @override
  State<SpaUserProfileView> createState() => _SpaUserProfileViewState();
}

class _SpaUserProfileViewState extends State<SpaUserProfileView> {
  final formKey = GlobalKey<FormState>();
  
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
  String fullName = "Sarah Johnson";
  String email = "sarah.johnson@email.com";
  String phone = "+1 (555) 123-4567";
  String dateOfBirth = "1990-05-15";
  String gender = "Female";
  String skinType = "Combination";
  String skinConcerns = "Aging, Dryness";
  String allergies = "None";
  String preferredLanguage = "English";
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;
  bool marketingEmails = true;

  Map<String, dynamic> userStats = {
    "totalBookings": 24,
    "completedTreatments": 22,
    "favoriteSpas": 5,
    "totalSpent": 1850.00,
    "memberSince": "2022-03-15",
    "loyaltyPoints": 420,
    "currentTier": "Gold",
    "reviewsWritten": 8,
    "averageRating": 4.8,
  };

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "booking",
      "title": "Hydrating Facial booked",
      "subtitle": "Luxury Spa & Wellness",
      "date": "2024-06-15",
      "icon": Icons.calendar_today,
      "color": primaryColor,
    },
    {
      "type": "review",
      "title": "Review submitted",
      "subtitle": "Anti-Aging Facial - 5 stars",
      "date": "2024-06-12",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "type": "favorite",
      "title": "Added to favorites",
      "subtitle": "Natural Spa Retreat",
      "date": "2024-06-10",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
    {
      "type": "points",
      "title": "Points earned",
      "subtitle": "+50 loyalty points",
      "date": "2024-06-08",
      "icon": Icons.stars,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Female", "value": "Female"},
    {"label": "Male", "value": "Male"},
    {"label": "Other", "value": "Other"},
    {"label": "Prefer not to say", "value": "NotSpecified"},
  ];

  List<Map<String, dynamic>> skinTypeOptions = [
    {"label": "Normal", "value": "Normal"},
    {"label": "Dry", "value": "Dry"},
    {"label": "Oily", "value": "Oily"},
    {"label": "Combination", "value": "Combination"},
    {"label": "Sensitive", "value": "Sensitive"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Italian", "value": "Italian"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Profile",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Profile", icon: Icon(Icons.person)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildProfileTab(),
        _buildActivityTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Profile Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Profile Image
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profileImage),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  fullName,
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.diamond,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${userStats["currentTier"]} Member",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats Cards
          ResponsiveGridView(
            minItemWidth: 160,
            children: [
              _buildStatCard(
                "Total Bookings",
                userStats["totalBookings"].toString(),
                Icons.calendar_today,
                primaryColor,
              ),
              _buildStatCard(
                "Treatments",
                userStats["completedTreatments"].toString(),
                Icons.spa,
                successColor,
              ),
              _buildStatCard(
                "Total Spent",
                "\$${(userStats["totalSpent"] as double).toStringAsFixed(0)}",
                Icons.attach_money,
                infoColor,
              ),
              _buildStatCard(
                "Loyalty Points",
                userStats["loyaltyPoints"].toString(),
                Icons.stars,
                warningColor,
              ),
            ],
          ),

          // Personal Information
          _buildProfileSection(
            title: "Personal Information",
            icon: Icons.person,
            child: Form(
              key: formKey,
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Full Name",
                    value: fullName,
                    validator: Validator.required,
                    onChanged: (value) {
                      fullName = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Email Address",
                    value: email,
                    validator: Validator.email,
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
                  QDatePicker(
                    label: "Date of Birth",
                    value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                    onChanged: (value) {
                      dateOfBirth = value.toIso8601String();
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Gender",
                    items: genderOptions,
                    value: gender,
                    onChanged: (value, label) {
                      gender = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),

          // Beauty Profile
          _buildProfileSection(
            title: "Beauty Profile",
            icon: Icons.face,
            child: Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Skin Type",
                  items: skinTypeOptions,
                  value: skinType,
                  onChanged: (value, label) {
                    skinType = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Skin Concerns",
                  value: skinConcerns,
                  hint: "e.g., Aging, Acne, Dryness, Sensitivity",
                  onChanged: (value) {
                    skinConcerns = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Allergies",
                  value: allergies,
                  hint: "List any known allergies or sensitivities",
                  onChanged: (value) {
                    allergies = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Preferences
          _buildProfileSection(
            title: "Preferences",
            icon: Icons.tune,
            child: Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Preferred Language",
                  items: languageOptions,
                  value: preferredLanguage,
                  onChanged: (value, label) {
                    preferredLanguage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Membership Information
          _buildMembershipInfo(),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Profile",
                  size: bs.md,
                  icon: Icons.edit,
                  onPressed: () {
                    _editProfile();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  color: successColor,
                  icon: Icons.save,
                  onPressed: () {
                    _saveProfile();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Activity Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Activity Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildActivityStat(
                        "Reviews Written",
                        userStats["reviewsWritten"].toString(),
                        Icons.rate_review,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildActivityStat(
                        "Avg Rating Given",
                        "${userStats["averageRating"]}",
                        Icons.star,
                        warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildActivityStat(
                        "Favorite Spas",
                        userStats["favoriteSpas"].toString(),
                        Icons.favorite,
                        dangerColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildActivityStat(
                        "Member Since",
                        "${DateTime.parse(userStats["memberSince"]).year}",
                        Icons.calendar_today,
                        infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Activity
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Text(
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        color: secondaryColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                ...recentActivity.map((activity) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (activity["color"] as Color).withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            activity["icon"] as IconData,
                            color: activity["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${activity["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${DateTime.parse(activity["date"]).day}/${DateTime.parse(activity["date"]).month}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Notification Settings
          _buildSettingsSection(
            title: "Notifications",
            icon: Icons.notifications,
            child: Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "Email notifications",
                      "value": "email",
                      "checked": emailNotifications,
                    }
                  ],
                  value: emailNotifications
                      ? [
                          {
                            "label": "Email notifications",
                            "value": "email",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "SMS notifications",
                      "value": "sms",
                      "checked": smsNotifications,
                    }
                  ],
                  value: smsNotifications
                      ? [
                          {
                            "label": "SMS notifications",
                            "value": "sms",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    smsNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Push notifications",
                      "value": "push",
                      "checked": pushNotifications,
                    }
                  ],
                  value: pushNotifications
                      ? [
                          {
                            "label": "Push notifications",
                            "value": "push",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    pushNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Marketing emails",
                      "value": "marketing",
                      "checked": marketingEmails,
                    }
                  ],
                  value: marketingEmails
                      ? [
                          {
                            "label": "Marketing emails",
                            "value": "marketing",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    marketingEmails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Account Settings
          _buildSettingsSection(
            title: "Account",
            icon: Icons.account_circle,
            child: Column(
              spacing: spSm,
              children: [
                _buildSettingsItem(
                  "Change Password",
                  "Update your account password",
                  Icons.lock,
                  () => _changePassword(),
                ),
                _buildSettingsItem(
                  "Privacy Settings",
                  "Control your privacy preferences",
                  Icons.privacy_tip,
                  () => _privacySettings(),
                ),
                _buildSettingsItem(
                  "Two-Factor Authentication",
                  "Add extra security to your account",
                  Icons.security,
                  () => _twoFactorAuth(),
                ),
              ],
            ),
          ),

          // Support Settings
          _buildSettingsSection(
            title: "Support",
            icon: Icons.help,
            child: Column(
              spacing: spSm,
              children: [
                _buildSettingsItem(
                  "Help Center",
                  "Find answers to common questions",
                  Icons.help_center,
                  () => _helpCenter(),
                ),
                _buildSettingsItem(
                  "Contact Support",
                  "Get help from our support team",
                  Icons.support_agent,
                  () => _contactSupport(),
                ),
                _buildSettingsItem(
                  "App Feedback",
                  "Share your thoughts about the app",
                  Icons.feedback,
                  () => _appFeedback(),
                ),
              ],
            ),
          ),

          // Danger Zone
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: dangerColor.withAlpha(100),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Danger Zone",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildSettingsItem(
                  "Delete Account",
                  "Permanently delete your account and data",
                  Icons.delete_forever,
                  () => _deleteAccount(),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              color: color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.diamond,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "${userStats["currentTier"]} Membership",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${userStats["loyaltyPoints"]} points available",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "580 points needed for Platinum",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.42,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
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
              Icons.chevron_right,
              color: disabledBoldColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    si("Profile editing enabled");
  }

  void _saveProfile() {
    if (formKey.currentState!.validate()) {
      ss("Profile saved successfully!");
    }
  }

  void _changePassword() {
    si("Navigate to change password");
  }

  void _privacySettings() {
    si("Navigate to privacy settings");
  }

  void _twoFactorAuth() {
    si("Navigate to two-factor authentication");
  }

  void _helpCenter() {
    si("Navigate to help center");
  }

  void _contactSupport() {
    si("Navigate to contact support");
  }

  void _appFeedback() {
    si("Navigate to app feedback");
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (isConfirmed) {
      sw("Account deletion process started");
    }
  }
}

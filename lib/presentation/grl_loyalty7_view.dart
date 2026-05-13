import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty7View extends StatefulWidget {
  @override
  State<GrlLoyalty7View> createState() => _GrlLoyalty7ViewState();
}

class _GrlLoyalty7ViewState extends State<GrlLoyalty7View> {
  String fullName = "John Doe";
  String email = "john.doe@email.com";
  String phone = "+1 (555) 123-4567";
  String birthDate = "1990-06-15";
  String address = "123 Main Street, City, State 12345";
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = true;
  bool weeklyReports = true;
  bool pointsExpiryReminder = true;

  List<Map<String, dynamic>> membershipBenefits = [
    {
      "title": "Early Access",
      "description": "Get early access to new products and sales",
      "icon": Icons.access_time,
      "color": Colors.blue,
      "active": true,
    },
    {
      "title": "Free Shipping",
      "description": "Free shipping on orders over \$50",
      "icon": Icons.local_shipping,
      "color": Colors.green,
      "active": true,
    },
    {
      "title": "Birthday Rewards",
      "description": "Special bonus points on your birthday",
      "icon": Icons.cake,
      "color": Colors.pink,
      "active": true,
    },
    {
      "title": "VIP Support",
      "description": "Priority customer support",
      "icon": Icons.support_agent,
      "color": Colors.purple,
      "active": false,
    },
    {
      "title": "Exclusive Events",
      "description": "Invitations to member-only events",
      "icon": Icons.event,
      "color": Colors.orange,
      "active": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editProfile();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: spLg),
            _buildPersonalInfo(),
            SizedBox(height: spLg),
            _buildNotificationSettings(),
            SizedBox(height: spLg),
            _buildMembershipBenefits(),
            SizedBox(height: spLg),
            _buildAccountActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
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
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white.withAlpha(40),
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            fullName,
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 16,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.military_tech,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Gold Member",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
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
            "Personal Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoItem("Full Name", fullName, Icons.person),
          _buildInfoItem("Email Address", email, Icons.email),
          _buildInfoItem("Phone Number", phone, Icons.phone),
          _buildInfoItem("Birth Date", birthDate, Icons.cake),
          _buildInfoItem("Address", address, Icons.location_on),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Update Information",
              size: bs.sm,
              onPressed: () {
                _updatePersonalInfo();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
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
            "Notification Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildNotificationToggle(
            "Email Notifications",
            "Receive notifications via email",
            emailNotifications,
            Icons.email,
            (value) {
              emailNotifications = value;
              setState(() {});
            },
          ),
          _buildNotificationToggle(
            "Push Notifications",
            "Receive push notifications on your device",
            pushNotifications,
            Icons.notifications,
            (value) {
              pushNotifications = value;
              setState(() {});
            },
          ),
          _buildNotificationToggle(
            "SMS Notifications",
            "Receive SMS notifications",
            smsNotifications,
            Icons.sms,
            (value) {
              smsNotifications = value;
              setState(() {});
            },
          ),
          _buildNotificationToggle(
            "Marketing Emails",
            "Receive promotional emails and offers",
            marketingEmails,
            Icons.local_offer,
            (value) {
              marketingEmails = value;
              setState(() {});
            },
          ),
          _buildNotificationToggle(
            "Weekly Reports",
            "Receive weekly points summary",
            weeklyReports,
            Icons.bar_chart,
            (value) {
              weeklyReports = value;
              setState(() {});
            },
          ),
          _buildNotificationToggle(
            "Points Expiry Reminder",
            "Get notified before points expire",
            pointsExpiryReminder,
            Icons.schedule,
            (value) {
              pointsExpiryReminder = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String description,
    bool value,
    IconData icon,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor.withAlpha(50) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? primaryColor : disabledBoldColor,
            size: 24,
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
                    fontWeight: FontWeight.bold,
                    color: value ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  description,
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

  Widget _buildMembershipBenefits() {
    return Container(
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
            "Membership Benefits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: membershipBenefits.map((benefit) {
              bool isActive = benefit["active"] == true;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isActive ? (benefit["color"] as Color).withAlpha(10) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isActive ? (benefit["color"] as Color).withAlpha(50) : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isActive ? (benefit["color"] as Color) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        benefit["icon"] as IconData,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${benefit["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isActive ? (benefit["color"] as Color) : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${benefit["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isActive ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        isActive ? "ACTIVE" : "LOCKED",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions() {
    return Container(
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
            "Account Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildActionButton(
            "Change Password",
            "Update your account password",
            Icons.lock,
            primaryColor,
            () {
              _changePassword();
            },
          ),
          _buildActionButton(
            "Privacy Settings",
            "Manage your privacy preferences",
            Icons.privacy_tip,
            infoColor,
            () {
              _privacySettings();
            },
          ),
          _buildActionButton(
            "Download Data",
            "Download your account data",
            Icons.download,
            successColor,
            () {
              _downloadData();
            },
          ),
          _buildActionButton(
            "Delete Account",
            "Permanently delete your account",
            Icons.delete_forever,
            dangerColor,
            () {
              _deleteAccount();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radiusSm),
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: color.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: color.withAlpha(50),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
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
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        description,
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
                  color: color,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    ss("Opening profile editor...");
  }

  void _updatePersonalInfo() {
    ss("Personal information updated successfully!");
  }

  void _changePassword() {
    ss("Opening password change dialog...");
  }

  void _privacySettings() {
    ss("Opening privacy settings...");
  }

  void _downloadData() {
    ss("Preparing data download...");
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (isConfirmed) {
      se("Account deletion requested. Please check your email for confirmation.");
    }
  }
}

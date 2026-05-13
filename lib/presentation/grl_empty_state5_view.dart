import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState5View extends StatefulWidget {
  @override
  State<GrlEmptyState5View> createState() => _GrlEmptyState5ViewState();
}

class _GrlEmptyState5ViewState extends State<GrlEmptyState5View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              infoColor.withAlpha(5),
              primaryColor.withAlpha(5),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: 60),
              
              // Bell Illustration with Ripple Effect
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_off,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spXl),
              
              // Title
              Text(
                "All caught up!",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: Text(
                  "You have no new notifications. We'll let you know when something important happens.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Notification Settings Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.tune,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Notification Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildPreferenceItem(
                      "Push Notifications",
                      "Get notified instantly",
                      Icons.phone_android,
                      true,
                    ),
                    _buildPreferenceItem(
                      "Email Updates",
                      "Receive weekly summaries",
                      Icons.email,
                      false,
                    ),
                    _buildPreferenceItem(
                      "SMS Alerts",
                      "Important updates only",
                      Icons.sms,
                      true,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Notification Types
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What you'll be notified about",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ResponsiveGridView(
                      minItemWidth: 140,
                      children: [
                        _buildNotificationTypeCard(
                          "Messages",
                          Icons.chat,
                          successColor,
                        ),
                        _buildNotificationTypeCard(
                          "Updates",
                          Icons.system_update,
                          infoColor,
                        ),
                        _buildNotificationTypeCard(
                          "Reminders",
                          Icons.alarm,
                          warningColor,
                        ),
                        _buildNotificationTypeCard(
                          "Security",
                          Icons.security,
                          dangerColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Notification Settings",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(NotificationSettingsView());
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Test Notification",
                      size: bs.md,
                      onPressed: () {
                        // Send test notification
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "History",
                      size: bs.md,
                      onPressed: () {
                        // navigateTo(NotificationHistoryView());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceItem(String title, String subtitle, IconData icon, bool enabled) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: enabled ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              size: 20,
              color: enabled ? primaryColor : disabledBoldColor,
            ),
          ),
          SizedBox(width: spMd),
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
          Container(
            width: 20,
            height: 12,
            decoration: BoxDecoration(
              color: enabled ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: enabled 
                ? Icon(Icons.check, size: 10, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTypeCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: color.withAlpha(60),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

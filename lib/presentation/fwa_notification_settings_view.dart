import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaNotificationSettingsView extends StatefulWidget {
  const FwaNotificationSettingsView({super.key});

  @override
  State<FwaNotificationSettingsView> createState() => _FwaNotificationSettingsViewState();
}

class _FwaNotificationSettingsViewState extends State<FwaNotificationSettingsView> {
  // Push Notifications
  bool pushNotifications = true;
  bool workoutReminders = true;
  bool goalAchievements = true;
  bool socialUpdates = false;
  bool challengeInvites = true;
  bool friendActivity = false;
  bool weeklyReports = true;
  bool healthAlerts = true;
  
  // Email Notifications
  bool emailNotifications = true;
  bool weeklyEmail = true;
  bool monthlyEmail = true;
  bool promotionalEmails = false;
  bool newsUpdates = false;
  bool tipsAndTricks = true;
  
  // In-App Notifications
  bool inAppNotifications = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool badgeEnabled = true;
  
  // Schedule Settings
  String quietHoursStart = "22:00";
  String quietHoursEnd = "08:00";
  bool quietHoursEnabled = true;
  List<String> selectedDays = ["monday", "tuesday", "wednesday", "thursday", "friday"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Push Notifications
            _buildPushNotificationsSection(),
            
            // Email Notifications
            _buildEmailNotificationsSection(),
            
            // In-App Notifications
            _buildInAppNotificationsSection(),
            
            // Quiet Hours
            _buildQuietHoursSection(),
            
            // Workout Reminders
            _buildWorkoutRemindersSection(),
            
            // Notification Actions
            _buildNotificationActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPushNotificationsSection() {
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
                Icons.notifications,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Push Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Receive notifications on your device",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildNotificationToggle(
            title: "Enable Push Notifications",
            subtitle: "Allow the app to send push notifications",
            value: pushNotifications,
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
              ss(value ? "Push notifications enabled" : "Push notifications disabled");
            },
          ),
          if (pushNotifications) ...[
            _buildNotificationToggle(
              title: "Workout Reminders",
              subtitle: "Get reminded about scheduled workouts",
              value: workoutReminders,
              onChanged: (value) {
                setState(() {
                  workoutReminders = value;
                });
                ss(value ? "Workout reminders enabled" : "Workout reminders disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Goal Achievements",
              subtitle: "Celebrate when you reach your goals",
              value: goalAchievements,
              onChanged: (value) {
                setState(() {
                  goalAchievements = value;
                });
                ss(value ? "Goal achievement notifications enabled" : "Goal achievement notifications disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Health Alerts",
              subtitle: "Important health and safety notifications",
              value: healthAlerts,
              onChanged: (value) {
                setState(() {
                  healthAlerts = value;
                });
                ss(value ? "Health alerts enabled" : "Health alerts disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Weekly Reports",
              subtitle: "Your weekly fitness summary",
              value: weeklyReports,
              onChanged: (value) {
                setState(() {
                  weeklyReports = value;
                });
                ss(value ? "Weekly reports enabled" : "Weekly reports disabled");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmailNotificationsSection() {
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
                Icons.email,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Email Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Receive updates and reports via email",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildNotificationToggle(
            title: "Enable Email Notifications",
            subtitle: "Allow the app to send emails",
            value: emailNotifications,
            onChanged: (value) {
              setState(() {
                emailNotifications = value;
              });
              ss(value ? "Email notifications enabled" : "Email notifications disabled");
            },
          ),
          if (emailNotifications) ...[
            _buildNotificationToggle(
              title: "Weekly Summary",
              subtitle: "Weekly fitness progress report",
              value: weeklyEmail,
              onChanged: (value) {
                setState(() {
                  weeklyEmail = value;
                });
                ss(value ? "Weekly email reports enabled" : "Weekly email reports disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Monthly Report",
              subtitle: "Detailed monthly analysis",
              value: monthlyEmail,
              onChanged: (value) {
                setState(() {
                  monthlyEmail = value;
                });
                ss(value ? "Monthly email reports enabled" : "Monthly email reports disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Tips & Tricks",
              subtitle: "Helpful fitness tips and advice",
              value: tipsAndTricks,
              onChanged: (value) {
                setState(() {
                  tipsAndTricks = value;
                });
                ss(value ? "Tips & tricks emails enabled" : "Tips & tricks emails disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Promotional Emails",
              subtitle: "Special offers and promotions",
              value: promotionalEmails,
              onChanged: (value) {
                setState(() {
                  promotionalEmails = value;
                });
                ss(value ? "Promotional emails enabled" : "Promotional emails disabled");
              },
            ),
            _buildNotificationToggle(
              title: "News & Updates",
              subtitle: "App updates and fitness news",
              value: newsUpdates,
              onChanged: (value) {
                setState(() {
                  newsUpdates = value;
                });
                ss(value ? "News updates enabled" : "News updates disabled");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInAppNotificationsSection() {
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
                Icons.notifications_active,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "In-App Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Customize how notifications appear in the app",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildNotificationToggle(
            title: "In-App Notifications",
            subtitle: "Show notifications while using the app",
            value: inAppNotifications,
            onChanged: (value) {
              setState(() {
                inAppNotifications = value;
              });
              ss(value ? "In-app notifications enabled" : "In-app notifications disabled");
            },
          ),
          if (inAppNotifications) ...[
            _buildNotificationToggle(
              title: "Sound",
              subtitle: "Play sound for notifications",
              value: soundEnabled,
              onChanged: (value) {
                setState(() {
                  soundEnabled = value;
                });
                ss(value ? "Notification sounds enabled" : "Notification sounds disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Vibration",
              subtitle: "Vibrate for notifications",
              value: vibrationEnabled,
              onChanged: (value) {
                setState(() {
                  vibrationEnabled = value;
                });
                ss(value ? "Notification vibration enabled" : "Notification vibration disabled");
              },
            ),
            _buildNotificationToggle(
              title: "Badge Count",
              subtitle: "Show notification count on app icon",
              value: badgeEnabled,
              onChanged: (value) {
                setState(() {
                  badgeEnabled = value;
                });
                ss(value ? "Badge count enabled" : "Badge count disabled");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuietHoursSection() {
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
                Icons.bedtime,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Quiet Hours",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Set times when you don't want to receive notifications",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildNotificationToggle(
            title: "Enable Quiet Hours",
            subtitle: "Silence notifications during specified times",
            value: quietHoursEnabled,
            onChanged: (value) {
              setState(() {
                quietHoursEnabled = value;
              });
              ss(value ? "Quiet hours enabled" : "Quiet hours disabled");
            },
          ),
          if (quietHoursEnabled) ...[
            Row(
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $quietHoursStart:00")),
                    onChanged: (value) {
                      quietHoursStart = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $quietHoursEnd:00")),
                    onChanged: (value) {
                      quietHoursEnd = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Quiet hours: $quietHoursStart - $quietHoursEnd",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkoutRemindersSection() {
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
                Icons.schedule,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Workout Reminders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Set days when you want to receive workout reminders",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QCategoryPicker(
            label: "Reminder Days",
            items: [
              {"label": "Mon", "value": "monday"},
              {"label": "Tue", "value": "tuesday"},
              {"label": "Wed", "value": "wednesday"},
              {"label": "Thu", "value": "thursday"},
              {"label": "Fri", "value": "friday"},
              {"label": "Sat", "value": "saturday"},
              {"label": "Sun", "value": "sunday"},
            ],
            value: "monday",
            onChanged: (index, label, value, item) {
              ss("Workout reminder days updated");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationActionsSection() {
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
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Notification Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildNotificationAction(
            icon: Icons.biotech,
            title: "Test Notifications",
            subtitle: "Send a test notification to see how it appears",
            onTap: () {
              ss("Test notification sent!");
            },
          ),
          _buildNotificationAction(
            icon: Icons.history,
            title: "Notification History",
            subtitle: "View your recent notifications",
            onTap: () {
              ss("Open notification history");
            },
          ),
          _buildNotificationAction(
            icon: Icons.clear_all,
            title: "Clear All Notifications",
            subtitle: "Remove all pending notifications",
            onTap: () async {
              bool isConfirmed = await confirm("Clear all pending notifications?");
              if (isConfirmed) {
                ss("All notifications cleared");
              }
            },
          ),
          _buildNotificationAction(
            icon: Icons.settings_applications,
            title: "System Notification Settings",
            subtitle: "Open device notification settings",
            onTap: () {
              ss("Open system notification settings");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle({
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

  Widget _buildNotificationAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          border: Border.all(color: disabledOutlineBorderColor),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
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

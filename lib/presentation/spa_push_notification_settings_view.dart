import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPushNotificationSettingsView extends StatefulWidget {
  const SpaPushNotificationSettingsView({super.key});

  @override
  State<SpaPushNotificationSettingsView> createState() => _SpaPushNotificationSettingsViewState();
}

class _SpaPushNotificationSettingsViewState extends State<SpaPushNotificationSettingsView> {
  bool pushNotificationsEnabled = true;
  bool appointmentReminders = true;
  bool promotionalOffers = false;
  bool loyaltyRewards = true;
  bool systemUpdates = false;
  bool smsNotifications = true;
  bool emailNotifications = true;
  bool inAppNotifications = true;
  
  String reminderTiming = "15_minutes";
  String quietHoursStart = "22:00";
  String quietHoursEnd = "08:00";
  bool quietHoursEnabled = true;
  bool weekendPromotions = false;
  
  List<Map<String, dynamic>> categorySettings = [
    {
      "title": "Appointment Reminders",
      "description": "Get notified about upcoming spa appointments",
      "key": "appointmentReminders",
      "icon": Icons.event_available,
      "enabled": true,
      "category": "essential",
    },
    {
      "title": "Promotional Offers",
      "description": "Receive notifications about special deals and discounts",
      "key": "promotionalOffers",
      "icon": Icons.local_offer,
      "enabled": false,
      "category": "marketing",
    },
    {
      "title": "Loyalty Rewards",
      "description": "Updates on points earned and rewards available",
      "key": "loyaltyRewards",
      "icon": Icons.star,
      "enabled": true,
      "category": "rewards",
    },
    {
      "title": "System Updates",
      "description": "Important app updates and maintenance notifications",
      "key": "systemUpdates",
      "icon": Icons.system_update,
      "enabled": false,
      "category": "system",
    },
    {
      "title": "Booking Confirmations",
      "description": "Instant confirmation when bookings are made or changed",
      "key": "bookingConfirmations",
      "icon": Icons.check_circle,
      "enabled": true,
      "category": "essential",
    },
    {
      "title": "Treatment Recommendations",
      "description": "Personalized treatment suggestions based on your preferences",
      "key": "treatmentRecommendations",
      "icon": Icons.psychology,
      "enabled": false,
      "category": "personalized",
    },
  ];

  List<Map<String, dynamic>> reminderOptions = [
    {"label": "5 minutes before", "value": "5_minutes"},
    {"label": "15 minutes before", "value": "15_minutes"},
    {"label": "30 minutes before", "value": "30_minutes"},
    {"label": "1 hour before", "value": "1_hour"},
    {"label": "2 hours before", "value": "2_hours"},
    {"label": "1 day before", "value": "1_day"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notifications"),
        actions: [
          QButton(
            icon: Icons.restore,
            size: bs.sm,
            onPressed: () {
              _resetToDefaults();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildNotificationHeader(),
            _buildMasterToggle(),
            if (pushNotificationsEnabled) ...[
              _buildCategorySettings(),
              _buildChannelSettings(),
              _buildTimingSettings(),
              _buildQuietHours(),
              _buildAdvancedSettings(),
            ],
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay Connected",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Customize your notification preferences to stay updated on what matters most to you",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterToggle() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: pushNotificationsEnabled ? primaryColor : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: pushNotificationsEnabled ? primaryColor : disabledColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              pushNotificationsEnabled ? Icons.notifications : Icons.notifications_off,
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
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  pushNotificationsEnabled 
                      ? "You'll receive notifications based on your preferences below"
                      : "All push notifications are disabled",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: pushNotificationsEnabled,
            onChanged: (value) {
              pushNotificationsEnabled = value;
              setState(() {});
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notification Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Choose which types of notifications you want to receive",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...categorySettings.map((setting) {
            return _buildCategoryToggle(setting);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryToggle(Map<String, dynamic> setting) {
    final isEnabled = _getCategoryValue(setting["key"]);
    final category = setting["category"] as String;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isEnabled ? _getCategoryColor(category).withAlpha(25) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isEnabled ? _getCategoryColor(category) : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isEnabled ? _getCategoryColor(category) : disabledColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              setting["icon"] as IconData,
              color: Colors.white,
              size: 18,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${setting["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isEnabled ? Colors.black : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${setting["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              _setCategoryValue(setting["key"], value);
            },
            activeColor: _getCategoryColor(category),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notification Channels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Select how you want to receive notifications",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          _buildChannelToggle("Push Notifications", "Receive notifications directly to your device", 
              Icons.phone_android, inAppNotifications, (value) {
            inAppNotifications = value;
            setState(() {});
          }),
          
          _buildChannelToggle("SMS Messages", "Get text messages for important updates", 
              Icons.sms, smsNotifications, (value) {
            smsNotifications = value;
            setState(() {});
          }),
          
          _buildChannelToggle("Email Notifications", "Receive detailed notifications via email", 
              Icons.email, emailNotifications, (value) {
            emailNotifications = value;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildChannelToggle(String title, String description, IconData icon, 
      bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(25) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value ? primaryColor : disabledColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: value ? Colors.black : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
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

  Widget _buildTimingSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Reminder Timing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Choose when you want to receive appointment reminders",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          QDropdownField(
            label: "Default Reminder Time",
            items: reminderOptions,
            value: reminderTiming,
            onChanged: (value, label) {
              if (appointmentReminders) {
                reminderTiming = value;
                setState(() {});
              }
            },
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 18),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "You can set custom reminder times for individual appointments when booking.",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                      height: 1.3,
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

  Widget _buildQuietHours() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quiet Hours",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Disable non-urgent notifications during these hours",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: quietHoursEnabled,
                onChanged: (value) {
                  quietHoursEnabled = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          
          if (quietHoursEnabled) ...[
            Row(
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursStart:00")),
                    onChanged: (value) {
                      quietHoursStart = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursEnd:00")),
                    onChanged: (value) {
                      quietHoursEnd = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.bedtime, color: warningColor, size: 18),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Emergency notifications and appointment reminders will still be delivered during quiet hours.",
                      style: TextStyle(
                        fontSize: 13,
                        color: warningColor,
                        height: 1.3,
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

  Widget _buildAdvancedSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Advanced Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          _buildAdvancedToggle(
            "Weekend Promotions",
            "Receive special weekend offers and deals",
            Icons.weekend,
            weekendPromotions,
            (value) {
              weekendPromotions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedToggle(String title, String description, IconData icon,
      bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? successColor.withAlpha(25) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? successColor : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value ? successColor : disabledColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: value ? Colors.black : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: successColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Save Notification Preferences",
        size: bs.md,
        onPressed: () {
          _saveSettings();
        },
      ),
    );
  }

  bool _getCategoryValue(String key) {
    switch (key) {
      case "appointmentReminders":
        return appointmentReminders;
      case "promotionalOffers":
        return promotionalOffers;
      case "loyaltyRewards":
        return loyaltyRewards;
      case "systemUpdates":
        return systemUpdates;
      case "bookingConfirmations":
        return true; // Always enabled for essential notifications
      case "treatmentRecommendations":
        return false; // Default disabled
      default:
        return false;
    }
  }

  void _setCategoryValue(String key, bool value) {
    setState(() {
      switch (key) {
        case "appointmentReminders":
          appointmentReminders = value;
          break;
        case "promotionalOffers":
          promotionalOffers = value;
          break;
        case "loyaltyRewards":
          loyaltyRewards = value;
          break;
        case "systemUpdates":
          systemUpdates = value;
          break;
      }
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "essential":
        return primaryColor;
      case "marketing":
        return warningColor;
      case "rewards":
        return successColor;
      case "system":
        return infoColor;
      case "personalized":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _resetToDefaults() {
    setState(() {
      pushNotificationsEnabled = true;
      appointmentReminders = true;
      promotionalOffers = false;
      loyaltyRewards = true;
      systemUpdates = false;
      smsNotifications = true;
      emailNotifications = true;
      inAppNotifications = true;
      reminderTiming = "15_minutes";
      quietHoursStart = "22:00";
      quietHoursEnd = "08:00";
      quietHoursEnabled = true;
      weekendPromotions = false;
    });
    ss("Settings reset to defaults");
  }

  void _saveSettings() {
    ss("Notification preferences saved successfully");
    //navigateTo ( previous view or settings menu )
  }
}

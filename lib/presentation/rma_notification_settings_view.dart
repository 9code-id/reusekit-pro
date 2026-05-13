import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaNotificationSettingsView extends StatefulWidget {
  const RmaNotificationSettingsView({Key? key}) : super(key: key);

  @override
  State<RmaNotificationSettingsView> createState() => _RmaNotificationSettingsViewState();
}

class _RmaNotificationSettingsViewState extends State<RmaNotificationSettingsView> {
  // General Notification Settings
  bool pushNotificationsEnabled = true;
  bool emailNotificationsEnabled = true;
  bool smsNotificationsEnabled = false;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  // Property Alert Categories
  bool priceDropAlerts = true;
  bool priceIncreaseAlerts = true;
  bool newListingAlerts = true;
  bool marketTrendAlerts = false;
  bool availabilityAlerts = true;
  bool investmentAlerts = true;

  // Timing Settings
  String quietHoursStart = "22:00";
  String quietHoursEnd = "08:00";
  bool quietHoursEnabled = true;
  String notificationFrequency = "immediate";

  // Contact Settings
  String emailAddress = "user@example.com";
  String phoneNumber = "+1 (555) 123-4567";
  bool emailVerified = true;
  bool phoneVerified = false;

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Immediate", "value": "immediate"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily digest", "value": "daily"},
    {"label": "Weekly digest", "value": "weekly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          QButton(
            icon: Icons.restore,
            size: bs.sm,
            onPressed: () => _resetToDefaults(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Settings Section
            _buildSectionHeader("General Settings", Icons.settings),
            _buildGeneralSettings(),

            // Property Alert Categories
            _buildSectionHeader("Property Alert Types", Icons.home),
            _buildPropertyAlertSettings(),

            // Timing and Frequency
            _buildSectionHeader("Timing & Frequency", Icons.schedule),
            _buildTimingSettings(),

            // Contact Information
            _buildSectionHeader("Contact Information", Icons.contact_phone),
            _buildContactSettings(),

            // Advanced Settings
            _buildSectionHeader("Advanced Settings", Icons.tune),
            _buildAdvancedSettings(),

            // Test Notifications
            _buildSectionHeader("Test Notifications", Icons.notifications_active),
            _buildTestSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildSettingRow(
            "Push Notifications",
            "Receive notifications on your device",
            Icons.notifications,
            pushNotificationsEnabled,
            (value) {
              pushNotificationsEnabled = value;
              setState(() {});
              if (!value) {
                // Disable other notification types if push is disabled
                emailNotificationsEnabled = true; // Keep email as fallback
                ss("Push notifications disabled. Email notifications will be your primary method.");
              }
            },
          ),
          
          _buildSettingRow(
            "Email Notifications",
            "Receive notifications via email",
            Icons.email,
            emailNotificationsEnabled,
            (value) {
              emailNotificationsEnabled = value;
              setState(() {});
            },
          ),
          
          _buildSettingRow(
            "SMS Notifications",
            "Receive notifications via text message",
            Icons.sms,
            smsNotificationsEnabled,
            (value) {
              if (value && !phoneVerified) {
                sw("Please verify your phone number first");
                return;
              }
              smsNotificationsEnabled = value;
              setState(() {});
            },
          ),

          Divider(height: spMd),

          _buildSettingRow(
            "Sound",
            "Play sound for notifications",
            Icons.volume_up,
            soundEnabled,
            (value) {
              soundEnabled = value;
              setState(() {});
            },
          ),
          
          _buildSettingRow(
            "Vibration",
            "Vibrate device for notifications",
            Icons.vibration,
            vibrationEnabled,
            (value) {
              vibrationEnabled = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyAlertSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildSettingRow(
            "Price Drop Alerts",
            "Get notified when property prices decrease",
            Icons.trending_down,
            priceDropAlerts,
            (value) {
              priceDropAlerts = value;
              setState(() {});
            },
            dangerColor,
          ),
          
          _buildSettingRow(
            "Price Increase Alerts",
            "Get notified when property prices increase",
            Icons.trending_up,
            priceIncreaseAlerts,
            (value) {
              priceIncreaseAlerts = value;
              setState(() {});
            },
            successColor,
          ),
          
          _buildSettingRow(
            "New Listing Alerts",
            "Get notified about new property listings",
            Icons.new_releases,
            newListingAlerts,
            (value) {
              newListingAlerts = value;
              setState(() {});
            },
            infoColor,
          ),
          
          _buildSettingRow(
            "Market Trend Alerts",
            "Get notified about market trends and analysis",
            Icons.analytics,
            marketTrendAlerts,
            (value) {
              marketTrendAlerts = value;
              setState(() {});
            },
            warningColor,
          ),
          
          _buildSettingRow(
            "Availability Alerts",
            "Get notified when properties become available",
            Icons.check_circle,
            availabilityAlerts,
            (value) {
              availabilityAlerts = value;
              setState(() {});
            },
            successColor,
          ),
          
          _buildSettingRow(
            "Investment Opportunity Alerts",
            "Get notified about high-potential investments",
            Icons.monetization_on,
            investmentAlerts,
            (value) {
              investmentAlerts = value;
              setState(() {});
            },
            primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTimingSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Quiet Hours Toggle
          _buildSettingRow(
            "Quiet Hours",
            "Pause notifications during specified hours",
            Icons.bedtime,
            quietHoursEnabled,
            (value) {
              quietHoursEnabled = value;
              setState(() {});
            },
          ),

          // Quiet Hours Time Settings
          if (quietHoursEnabled) ...[
            Row(
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Quiet Hours Start",
                    value: quietHoursStart.timeOfDay,
                    onChanged: (value) {
                      quietHoursStart = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "Quiet Hours End",
                    value: quietHoursEnd.timeOfDay,
                    onChanged: (value) {
                      quietHoursEnd = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],

          // Notification Frequency
          QDropdownField(
            label: "Notification Frequency",
            items: frequencyOptions,
            value: notificationFrequency,
            onChanged: (value, label) {
              notificationFrequency = value;
              setState(() {});
            },
          ),

          // Frequency Description
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    _getFrequencyDescription(),
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
      ),
    );
  }

  Widget _buildContactSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Email Settings
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: emailAddress,
                  onChanged: (value) {
                    emailAddress = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: emailVerified ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: emailVerified ? successColor.withAlpha(60) : warningColor.withAlpha(60),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      emailVerified ? Icons.verified : Icons.warning,
                      size: 12,
                      color: emailVerified ? successColor : warningColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      emailVerified ? "Verified" : "Not Verified",
                      style: TextStyle(
                        fontSize: 10,
                        color: emailVerified ? successColor : warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Phone Settings
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: phoneNumber,
                  onChanged: (value) {
                    phoneNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: phoneVerified ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: phoneVerified ? successColor.withAlpha(60) : warningColor.withAlpha(60),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      phoneVerified ? Icons.verified : Icons.warning,
                      size: 12,
                      color: phoneVerified ? successColor : warningColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      phoneVerified ? "Verified" : "Not Verified",
                      style: TextStyle(
                        fontSize: 10,
                        color: phoneVerified ? successColor : warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Verification Actions
          Row(
            children: [
              if (!emailVerified)
                Expanded(
                  child: QButton(
                    label: "Verify Email",
                    size: bs.sm,
                    onPressed: () {
                      ss("Verification email sent");
                    },
                  ),
                ),
              if (!emailVerified && !phoneVerified) SizedBox(width: spSm),
              if (!phoneVerified)
                Expanded(
                  child: QButton(
                    label: "Verify Phone",
                    size: bs.sm,
                    onPressed: () {
                      ss("Verification SMS sent");
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          GestureDetector(
            onTap: () {
              //navigateTo('NotificationHistoryView')
            },
            child: Row(
              children: [
                Icon(Icons.history, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "View all past notifications",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
          ),

          Divider(height: spMd),

          GestureDetector(
            onTap: () => _showExportOptions(),
            child: Row(
              children: [
                Icon(Icons.download, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Export Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Download your notification preferences",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
          ),

          Divider(height: spMd),

          GestureDetector(
            onTap: () => _showImportOptions(),
            child: Row(
              children: [
                Icon(Icons.upload, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Import Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Restore notification preferences from backup",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Test your notification settings to ensure they're working correctly",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test Push",
                  icon: Icons.notifications,
                  size: bs.sm,
                  onPressed: () {
                    if (pushNotificationsEnabled) {
                      ss("Test push notification sent");
                    } else {
                      sw("Push notifications are disabled");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Test Email",
                  icon: Icons.email,
                  size: bs.sm,
                  onPressed: () {
                    if (emailNotificationsEnabled && emailVerified) {
                      ss("Test email sent to $emailAddress");
                    } else {
                      sw("Email notifications not available");
                    }
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test SMS",
                  icon: Icons.sms,
                  size: bs.sm,
                  onPressed: () {
                    if (smsNotificationsEnabled && phoneVerified) {
                      ss("Test SMS sent to $phoneNumber");
                    } else {
                      sw("SMS notifications not available");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Test All",
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    _testAllNotifications();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    String title,
    String description,
    IconData icon,
    bool value,
    Function(bool) onChanged,
    [Color? iconColor]
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? primaryColor, size: 20),
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
          activeColor: iconColor ?? primaryColor,
        ),
      ],
    );
  }

  String _getFrequencyDescription() {
    switch (notificationFrequency) {
      case "immediate":
        return "Notifications are sent immediately when triggered";
      case "15min":
        return "Notifications are batched and sent every 15 minutes";
      case "hourly":
        return "Notifications are batched and sent once per hour";
      case "daily":
        return "Daily summary of all notifications sent at 9:00 AM";
      case "weekly":
        return "Weekly summary sent every Monday at 9:00 AM";
      default:
        return "";
    }
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all notification settings to default values?");
    if (isConfirmed) {
      pushNotificationsEnabled = true;
      emailNotificationsEnabled = true;
      smsNotificationsEnabled = false;
      soundEnabled = true;
      vibrationEnabled = true;
      priceDropAlerts = true;
      priceIncreaseAlerts = true;
      newListingAlerts = true;
      marketTrendAlerts = false;
      availabilityAlerts = true;
      investmentAlerts = true;
      quietHoursEnabled = true;
      quietHoursStart = "22:00";
      quietHoursEnd = "08:00";
      notificationFrequency = "immediate";
      
      setState(() {});
      ss("Settings reset to defaults");
    }
  }

  void _testAllNotifications() {
    List<String> testResults = [];
    
    if (pushNotificationsEnabled) {
      testResults.add("Push notification sent");
    }
    
    if (emailNotificationsEnabled && emailVerified) {
      testResults.add("Email sent to $emailAddress");
    }
    
    if (smsNotificationsEnabled && phoneVerified) {
      testResults.add("SMS sent to $phoneNumber");
    }
    
    if (testResults.isEmpty) {
      sw("No notification methods are currently enabled and verified");
    } else {
      ss("Test notifications sent via: ${testResults.join(', ')}");
    }
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Text(
                "Export Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            // Options
            GestureDetector(
              onTap: () {
                back();
                ss("Settings exported as JSON");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  children: [
                    Icon(Icons.code, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Export as JSON", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                back();
                ss("Settings exported to CSV");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  children: [
                    Icon(Icons.table_chart, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Export as CSV", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showImportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Text(
                "Import Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            // Options
            GestureDetector(
              onTap: () {
                back();
                ss("Settings imported from file");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  children: [
                    Icon(Icons.file_upload, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Import from File", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                back();
                ss("Settings restored from cloud backup");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  children: [
                    Icon(Icons.cloud_download, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Restore from Cloud", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

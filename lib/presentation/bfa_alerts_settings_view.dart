import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaAlertsSettingsView extends StatefulWidget {
  const BfaAlertsSettingsView({super.key});

  @override
  State<BfaAlertsSettingsView> createState() => _BfaAlertsSettingsViewState();
}

class _BfaAlertsSettingsViewState extends State<BfaAlertsSettingsView> {
  bool pushNotifications = true;
  bool emailAlerts = true;
  bool smsAlerts = false;
  bool transactionAlerts = true;
  bool lowBalanceAlerts = true;
  bool billReminders = true;
  bool marketUpdates = false;
  bool securityAlerts = true;
  bool promotionalOffers = false;
  bool monthlyStatements = true;
  
  double lowBalanceThreshold = 1000.0;
  String alertFrequency = "immediate";
  String preferredTime = "09:00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Settings"),
        actions: [
          TextButton(
            onPressed: () {
              ss("Alert settings saved successfully");
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stay Informed",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Customize your alert preferences to stay updated on your financial activities.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
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
                  Text(
                    "Notification Channels",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(Icons.phone_android, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Push Notifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Switch(
                        value: pushNotifications,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          pushNotifications = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.email, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Email Alerts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Switch(
                        value: emailAlerts,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          emailAlerts = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.sms, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "SMS Alerts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Switch(
                        value: smsAlerts,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          smsAlerts = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
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
                  Text(
                    "Alert Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  _buildAlertToggle(
                    icon: Icons.swap_horiz,
                    title: "Transaction Alerts",
                    subtitle: "Get notified for all transactions",
                    value: transactionAlerts,
                    onChanged: (value) {
                      transactionAlerts = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.account_balance_wallet,
                    title: "Low Balance Alerts",
                    subtitle: "When balance falls below threshold",
                    value: lowBalanceAlerts,
                    onChanged: (value) {
                      lowBalanceAlerts = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.receipt,
                    title: "Bill Reminders",
                    subtitle: "Upcoming bill payment reminders",
                    value: billReminders,
                    onChanged: (value) {
                      billReminders = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.trending_up,
                    title: "Market Updates",
                    subtitle: "Stock and investment updates",
                    value: marketUpdates,
                    onChanged: (value) {
                      marketUpdates = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.security,
                    title: "Security Alerts",
                    subtitle: "Login and security notifications",
                    value: securityAlerts,
                    onChanged: (value) {
                      securityAlerts = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.local_offer,
                    title: "Promotional Offers",
                    subtitle: "Special deals and offers",
                    value: promotionalOffers,
                    onChanged: (value) {
                      promotionalOffers = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildAlertToggle(
                    icon: Icons.description,
                    title: "Monthly Statements",
                    subtitle: "Monthly account statements",
                    value: monthlyStatements,
                    onChanged: (value) {
                      monthlyStatements = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Container(
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
                    "Alert Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  QNumberField(
                    label: "Low Balance Threshold (\$)",
                    value: lowBalanceThreshold.toString(),
                    hint: "Set minimum balance for alerts",
                    onChanged: (value) {
                      lowBalanceThreshold = double.tryParse(value) ?? 1000.0;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Alert Frequency",
                    items: [
                      {"label": "Immediate", "value": "immediate"},
                      {"label": "Daily Summary", "value": "daily"},
                      {"label": "Weekly Summary", "value": "weekly"},
                    ],
                    value: alertFrequency,
                    onChanged: (value, label) {
                      alertFrequency = value;
                      setState(() {});
                    },
                  ),
                  
                  QTimePicker(
                    label: "Preferred Alert Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${preferredTime}:00")),
                    onChanged: (value) {
                      preferredTime = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Security alerts cannot be disabled for your protection. You will always receive notifications for login attempts and security-related activities.",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Test Notifications",
                size: bs.md,
                icon: Icons.notification_add,
                onPressed: () {
                  si("Test notification sent to your enabled channels");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(50),
        ),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: value ? primaryColor : disabledBoldColor,
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
            activeColor: primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

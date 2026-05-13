import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership9View extends StatefulWidget {
  const GrlMembership9View({Key? key}) : super(key: key);

  @override
  State<GrlMembership9View> createState() => _GrlMembership9ViewState();
}

class _GrlMembership9ViewState extends State<GrlMembership9View> {
  bool notificationSettings = true;
  bool emailReminders = true;
  bool smsNotifications = false;
  bool marketingEmails = true;
  bool productUpdates = true;
  bool billingNotifications = true;
  String language = "en";
  String timezone = "UTC-8";
  String currency = "USD";
  bool autoRenewal = true;
  bool downloadInvoices = false;

  Map<String, dynamic> profileData = {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "+1 (555) 123-4567",
    "company": "Tech Solutions Inc",
    "position": "Product Manager",
    "memberSince": "2023-03-15",
    "lastLogin": "2024-06-20 14:30",
  };

  Map<String, dynamic> currentPlan = {
    "name": "Professional",
    "price": 29.99,
    "nextBilling": "2024-07-15",
    "status": "active",
  };

  List<Map<String, dynamic>> securityLog = [
    {
      "action": "Login",
      "device": "Chrome on Windows",
      "location": "San Francisco, CA",
      "timestamp": "2024-06-20 14:30",
      "status": "success",
    },
    {
      "action": "Password Changed",
      "device": "Mobile App",
      "location": "San Francisco, CA",
      "timestamp": "2024-06-18 09:15",
      "status": "success",
    },
    {
      "action": "Login Attempt",
      "device": "Unknown Device",
      "location": "New York, NY",
      "timestamp": "2024-06-15 22:45",
      "status": "failed",
    },
    {
      "action": "Plan Upgrade",
      "device": "Chrome on Windows",
      "location": "San Francisco, CA",
      "timestamp": "2024-06-10 16:20",
      "status": "success",
    },
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"value": "en", "label": "English"},
    {"value": "es", "label": "Español"},
    {"value": "fr", "label": "Français"},
    {"value": "de", "label": "Deutsch"},
    {"value": "zh", "label": "中文"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"value": "UTC-12", "label": "(GMT-12:00) International Date Line West"},
    {"value": "UTC-8", "label": "(GMT-08:00) Pacific Time (US & Canada)"},
    {"value": "UTC-5", "label": "(GMT-05:00) Eastern Time (US & Canada)"},
    {"value": "UTC+0", "label": "(GMT+00:00) Greenwich Mean Time"},
    {"value": "UTC+8", "label": "(GMT+08:00) Beijing, Singapore"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"value": "USD", "label": "USD - US Dollar"},
    {"value": "EUR", "label": "EUR - Euro"},
    {"value": "GBP", "label": "GBP - British Pound"},
    {"value": "JPY", "label": "JPY - Japanese Yen"},
    {"value": "CAD", "label": "CAD - Canadian Dollar"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Contact our support team!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            Text(
              "Profile Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${profileData["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${profileData["email"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${profileData["company"]} • ${profileData["position"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening profile editor");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Member Since",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${profileData["memberSince"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Login",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${profileData["lastLogin"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Current Plan
            Text(
              "Current Plan",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${currentPlan["name"]} Plan",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$${(currentPlan["price"] as num).toStringAsFixed(2)}/month • Next billing: ${currentPlan["nextBilling"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Manage",
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening plan management");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Notification Settings
            Text(
              "Notification Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Email reminders",
                              "value": true,
                              "checked": emailReminders,
                            }
                          ],
                          value: [
                            if (emailReminders)
                              {
                                "label": "Email reminders",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            emailReminders = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "SMS notifications",
                              "value": true,
                              "checked": smsNotifications,
                            }
                          ],
                          value: [
                            if (smsNotifications)
                              {
                                "label": "SMS notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            smsNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Marketing emails",
                              "value": true,
                              "checked": marketingEmails,
                            }
                          ],
                          value: [
                            if (marketingEmails)
                              {
                                "label": "Marketing emails",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            marketingEmails = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Product updates",
                              "value": true,
                              "checked": productUpdates,
                            }
                          ],
                          value: [
                            if (productUpdates)
                              {
                                "label": "Product updates",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            productUpdates = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Billing notifications",
                              "value": true,
                              "checked": billingNotifications,
                            }
                          ],
                          value: [
                            if (billingNotifications)
                              {
                                "label": "Billing notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            billingNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Preferences
            Text(
              "Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  QDropdownField(
                    label: "Language",
                    items: languageOptions,
                    value: language,
                    onChanged: (value, label) {
                      language = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Timezone",
                    items: timezoneOptions,
                    value: timezone,
                    onChanged: (value, label) {
                      timezone = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Currency",
                    items: currencyOptions,
                    value: currency,
                    onChanged: (value, label) {
                      currency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Billing Preferences
            Text(
              "Billing Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Auto-renewal",
                              "value": true,
                              "checked": autoRenewal,
                            }
                          ],
                          value: [
                            if (autoRenewal)
                              {
                                "label": "Auto-renewal",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            autoRenewal = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Auto-download invoices",
                              "value": true,
                              "checked": downloadInvoices,
                            }
                          ],
                          value: [
                            if (downloadInvoices)
                              {
                                "label": "Auto-download invoices",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            downloadInvoices = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Security & Activity
            Text(
              "Security & Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Change",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening password change");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Two-Factor Authentication",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Enable",
                        size: bs.sm,
                        onPressed: () {
                          ss("Setting up 2FA");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Recent Activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...securityLog.take(3).map((log) {
              final isSuccess = log["status"] == "success";
              final statusColor = isSuccess ? successColor : dangerColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${log["action"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${log["device"]} • ${log["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${log["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            GestureDetector(
              onTap: () {
                si("Viewing full security log");
              },
              child: Text(
                "View all activity",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: spLg),

            // Danger Zone
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: dangerColor.withAlpha(50)),
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete Account",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Permanently delete your account and all data",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: dangerColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          label: "Delete",
                          size: bs.sm,
                          color: Colors.white,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
                            if (isConfirmed) {
                              ss("Account deletion initiated");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Save Button
            QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () {
                ss("Settings saved successfully!");
              },
            ),
            SizedBox(height: spSm),
            Text(
              "Changes are automatically saved when you modify settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

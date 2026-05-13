import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAccountSecurityView extends StatefulWidget {
  const BrsAccountSecurityView({super.key});

  @override
  State<BrsAccountSecurityView> createState() => _BrsAccountSecurityViewState();
}

class _BrsAccountSecurityViewState extends State<BrsAccountSecurityView> {
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  bool twoFactorEnabled = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool loginAlerts = true;

  final List<Map<String, dynamic>> loginHistory = [
    {
      "device": "iPhone 13 Pro",
      "location": "New York, NY",
      "date": "2024-06-15",
      "time": "10:30 AM",
      "status": "success",
    },
    {
      "device": "Chrome Browser",
      "location": "Brooklyn, NY",
      "date": "2024-06-14",
      "time": "02:15 PM",
      "status": "success",
    },
    {
      "device": "Android Phone",
      "location": "Unknown Location",
      "date": "2024-06-13",
      "time": "11:45 PM",
      "status": "failed",
    },
    {
      "device": "Safari Browser",
      "location": "Manhattan, NY",
      "date": "2024-06-12",
      "time": "09:20 AM",
      "status": "success",
    },
  ];

  final List<Map<String, dynamic>> securityTips = [
    {
      "title": "Use Strong Passwords",
      "description": "Include uppercase, lowercase, numbers, and special characters",
      "icon": Icons.lock,
    },
    {
      "title": "Enable Two-Factor Authentication",
      "description": "Add an extra layer of security to your account",
      "icon": Icons.security,
    },
    {
      "title": "Regular Security Checks",
      "description": "Review your account activity regularly",
      "icon": Icons.visibility,
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Security"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Security Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: successColor,
                    size: 30,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Secure",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Your account security score: 8/10",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Change Password Section
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
                    "Change Password",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        QTextField(
                          label: "Current Password",
                          value: currentPassword,
                          obscureText: true,
                          validator: Validator.required,
                          onChanged: (value) {
                            currentPassword = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "New Password",
                          value: newPassword,
                          obscureText: true,
                          validator: Validator.required,
                          hint: "At least 8 characters",
                          onChanged: (value) {
                            newPassword = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Confirm New Password",
                          value: confirmPassword,
                          obscureText: true,
                          validator: Validator.required,
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Update Password",
                            size: bs.md,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _updatePassword();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Two-Factor Authentication
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
                    "Two-Factor Authentication",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable 2FA for extra security",
                              "value": true,
                              "checked": twoFactorEnabled,
                            }
                          ],
                          value: [
                            if (twoFactorEnabled)
                              {
                                "label": "Enable 2FA for extra security",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            twoFactorEnabled = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (twoFactorEnabled) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Use Google Authenticator or SMS for verification",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Setup Authenticator App",
                        size: bs.sm,
                        onPressed: () {
                          si("Redirecting to authenticator setup...");
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Notification Settings
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
                    "Security Notifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Email notifications",
                              "value": "email",
                              "checked": emailNotifications,
                            }
                          ],
                          value: [
                            if (emailNotifications)
                              {
                                "label": "Email notifications",
                                "value": "email",
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            emailNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "SMS notifications",
                              "value": "sms",
                              "checked": smsNotifications,
                            }
                          ],
                          value: [
                            if (smsNotifications)
                              {
                                "label": "SMS notifications",
                                "value": "sms",
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
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Login alerts",
                              "value": "login",
                              "checked": loginAlerts,
                            }
                          ],
                          value: [
                            if (loginAlerts)
                              {
                                "label": "Login alerts",
                                "value": "login",
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            loginAlerts = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Login History
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("Loading all login history...");
                        },
                      ),
                    ],
                  ),
                  ...loginHistory.take(3).map((login) {
                    final isSuccess = login["status"] == "success";
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: isSuccess 
                            ? successColor.withAlpha(10) 
                            : dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSuccess 
                              ? successColor.withAlpha(50) 
                              : dangerColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSuccess ? Icons.check_circle : Icons.error,
                            color: isSuccess ? successColor : dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${login["device"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${login["location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${login["date"]} at ${login["time"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isSuccess)
                            QButton(
                              label: "Report",
                              size: bs.sm,
                              onPressed: () {
                                sw("Suspicious activity reported");
                              },
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Security Tips
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
                    "Security Tips",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...securityTips.map((tip) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              tip["icon"] as IconData,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tip["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${tip["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Emergency Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Emergency Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "Use these options only if your account has been compromised",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Sign Out All Devices",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Sign out from all devices? You'll need to log in again.");
                            if (isConfirmed) {
                              ss("Signed out from all devices");
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Reset Account",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("This will reset all security settings. Continue?");
                            if (isConfirmed) {
                              sw("Account security reset initiated");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePassword() async {
    if (newPassword != confirmPassword) {
      se("Passwords do not match");
      return;
    }
    
    if (newPassword.length < 8) {
      se("Password must be at least 8 characters");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to update your password?");
    if (isConfirmed) {
      ss("Password updated successfully");
      currentPassword = "";
      newPassword = "";
      confirmPassword = "";
      setState(() {});
    }
  }
}

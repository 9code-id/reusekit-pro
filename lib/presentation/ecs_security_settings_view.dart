import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSecuritySettingsView extends StatefulWidget {
  const EcsSecuritySettingsView({super.key});

  @override
  State<EcsSecuritySettingsView> createState() => _EcsSecuritySettingsViewState();
}

class _EcsSecuritySettingsViewState extends State<EcsSecuritySettingsView> {
  bool twoFactorAuth = false;
  bool biometricLogin = true;
  bool deviceTracking = true;
  bool loginNotifications = true;
  bool suspiciousActivityAlerts = true;
  bool autoLogout = false;
  String autoLogoutTime = "15";
  bool rememberDevice = true;
  bool privacyMode = false;

  List<Map<String, dynamic>> autoLogoutOptions = [
    {"label": "5 minutes", "value": "5"},
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> sessions = [
    {
      "device": "iPhone 14 Pro",
      "location": "New York, USA",
      "lastActive": "Active now",
      "isCurrent": true,
    },
    {
      "device": "Chrome on Windows",
      "location": "New York, USA", 
      "lastActive": "2 hours ago",
      "isCurrent": false,
    },
    {
      "device": "Samsung Galaxy S23",
      "location": "Los Angeles, USA",
      "lastActive": "1 day ago",
      "isCurrent": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          QButton(
            icon: Icons.shield,
            size: bs.sm,
            onPressed: () {
              // Security check
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Authentication Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Authentication",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.security, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Two-Factor Authentication",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Add an extra layer of security",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: twoFactorAuth,
                        onChanged: (value) {
                          setState(() {
                            twoFactorAuth = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.fingerprint, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Biometric Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Use fingerprint or face recognition",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: biometricLogin,
                        onChanged: (value) {
                          setState(() {
                            biometricLogin = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Privacy & Tracking Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Privacy & Tracking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.track_changes, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Device Tracking",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Track login devices for security",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: deviceTracking,
                        onChanged: (value) {
                          setState(() {
                            deviceTracking = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.visibility_off, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Mode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Hide sensitive information",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: privacyMode,
                        onChanged: (value) {
                          setState(() {
                            privacyMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Notifications Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      Icon(Icons.login, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login Notifications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Get notified of new logins",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: loginNotifications,
                        onChanged: (value) {
                          setState(() {
                            loginNotifications = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suspicious Activity Alerts",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Alert for unusual account activity",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: suspiciousActivityAlerts,
                        onChanged: (value) {
                          setState(() {
                            suspiciousActivityAlerts = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Session Management Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically logout after inactivity",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoLogout,
                        onChanged: (value) {
                          setState(() {
                            autoLogout = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (autoLogout) ...[
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Auto Logout Time",
                      items: autoLogoutOptions,
                      value: autoLogoutTime,
                      onChanged: (value, label) {
                        autoLogoutTime = value;
                        setState(() {});
                      },
                    ),
                  ],
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.devices, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Remember Device",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Keep you logged in on this device",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: rememberDevice,
                        onChanged: (value) {
                          setState(() {
                            rememberDevice = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Sessions Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Active Sessions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Logout All",
                        size: bs.sm,
                        color: dangerColor,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Logout from all devices?");
                          if (isConfirmed) {
                            ss("Logged out from all devices");
                          }
                        },
                      ),
                    ],
                  ),
                  ...sessions.map((session) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(top: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            session["device"].toString().contains("iPhone") ? Icons.phone_iphone :
                            session["device"].toString().contains("Chrome") ? Icons.laptop :
                            Icons.phone_android,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${session["device"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (session["isCurrent"] as bool) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Current",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${session["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${session["lastActive"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!(session["isCurrent"] as bool))
                            QButton(
                              icon: Icons.logout,
                              size: bs.sm,
                              color: dangerColor,
                              onPressed: () async {
                                bool isConfirmed = await confirm("Logout this device?");
                                if (isConfirmed) {
                                  ss("Device logged out successfully");
                                }
                              },
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Security Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Change Password",
                    size: bs.md,
                    icon: Icons.lock,
                    onPressed: () {
                      // Navigate to change password
                    },
                  ),
                  QButton(
                    label: "Security Checkup",
                    size: bs.md,
                    icon: Icons.security,
                    onPressed: () {
                      // Navigate to security checkup
                    },
                  ),
                  QButton(
                    label: "Download Security Report",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: () {
                      ss("Security report downloaded");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

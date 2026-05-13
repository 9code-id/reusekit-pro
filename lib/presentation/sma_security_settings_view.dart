import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSecuritySettingsView extends StatefulWidget {
  const SmaSecuritySettingsView({super.key});

  @override
  State<SmaSecuritySettingsView> createState() => _SmaSecuritySettingsViewState();
}

class _SmaSecuritySettingsViewState extends State<SmaSecuritySettingsView> {
  bool twoFactorAuth = false;
  bool loginNotifications = true;
  bool unknownDeviceAlert = true;
  bool sessionTimeout = false;
  bool biometricLogin = false;
  bool autoLogout = false;
  bool securePassword = true;
  bool passwordExpiry = false;
  bool loginHistory = true;
  bool suspiciousActivityAlert = true;

  String lastLogin = "2024-06-16 10:30 AM";
  String activeSessionsCount = "3";

  List<Map<String, dynamic>> securityFeatures = [
    {
      "category": "Authentication",
      "icon": Icons.verified_user,
      "color": Colors.green,
      "settings": [
        {
          "key": "twoFactorAuth",
          "title": "Two-Factor Authentication",
          "description": "Add an extra layer of security to your account",
          "icon": Icons.security,
          "critical": true,
        },
        {
          "key": "biometricLogin",
          "title": "Biometric Login",
          "description": "Use fingerprint or face recognition to log in",
          "icon": Icons.fingerprint,
          "critical": false,
        },
        {
          "key": "securePassword",
          "title": "Strong Password Required",
          "description": "Enforce complex password requirements",
          "icon": Icons.lock,
          "critical": true,
        },
        {
          "key": "passwordExpiry",
          "title": "Password Expiry",
          "description": "Require password change every 90 days",
          "icon": Icons.schedule,
          "critical": false,
        },
      ]
    },
    {
      "category": "Login Protection",
      "icon": Icons.login,
      "color": Colors.blue,
      "settings": [
        {
          "key": "loginNotifications",
          "title": "Login Notifications",
          "description": "Get notified when someone logs into your account",
          "icon": Icons.notifications,
          "critical": true,
        },
        {
          "key": "unknownDeviceAlert",
          "title": "Unknown Device Alert",
          "description": "Alert when logging in from new devices",
          "icon": Icons.devices,
          "critical": true,
        },
        {
          "key": "loginHistory",
          "title": "Login History Tracking",
          "description": "Keep a record of all login attempts",
          "icon": Icons.history,
          "critical": false,
        },
      ]
    },
    {
      "category": "Session Management",
      "icon": Icons.timer,
      "color": Colors.orange,
      "settings": [
        {
          "key": "sessionTimeout",
          "title": "Auto Session Timeout",
          "description": "Automatically log out after 30 minutes of inactivity",
          "icon": Icons.timer_off,
          "critical": false,
        },
        {
          "key": "autoLogout",
          "title": "Remote Logout",
          "description": "Log out from all devices remotely",
          "icon": Icons.logout,
          "critical": false,
        },
      ]
    },
    {
      "category": "Threat Detection",
      "icon": Icons.warning,
      "color": Colors.red,
      "settings": [
        {
          "key": "suspiciousActivityAlert",
          "title": "Suspicious Activity Alert",
          "description": "Get notified of unusual account activity",
          "icon": Icons.report,
          "critical": true,
        },
      ]
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "Login",
      "device": "iPhone 14 Pro",
      "location": "New York, USA",
      "time": "2 hours ago",
      "status": "success",
      "ip": "192.168.1.100"
    },
    {
      "action": "Password Changed",
      "device": "MacBook Pro",
      "location": "New York, USA",
      "time": "1 day ago",
      "status": "success",
      "ip": "192.168.1.105"
    },
    {
      "action": "Failed Login Attempt",
      "device": "Unknown Device",
      "location": "London, UK",
      "time": "3 days ago",
      "status": "blocked",
      "ip": "10.0.0.1"
    },
    {
      "action": "Profile Updated",
      "device": "Android Phone",
      "location": "New York, USA",
      "time": "1 week ago",
      "status": "success",
      "ip": "192.168.1.110"
    },
  ];

  bool _getSwitchValue(String key) {
    switch (key) {
      case 'twoFactorAuth': return twoFactorAuth;
      case 'loginNotifications': return loginNotifications;
      case 'unknownDeviceAlert': return unknownDeviceAlert;
      case 'sessionTimeout': return sessionTimeout;
      case 'biometricLogin': return biometricLogin;
      case 'autoLogout': return autoLogout;
      case 'securePassword': return securePassword;
      case 'passwordExpiry': return passwordExpiry;
      case 'loginHistory': return loginHistory;
      case 'suspiciousActivityAlert': return suspiciousActivityAlert;
      default: return false;
    }
  }

  void _setSwitchValue(String key, bool value) {
    setState(() {
      switch (key) {
        case 'twoFactorAuth':
          twoFactorAuth = value;
          break;
        case 'loginNotifications':
          loginNotifications = value;
          break;
        case 'unknownDeviceAlert':
          unknownDeviceAlert = value;
          break;
        case 'sessionTimeout':
          sessionTimeout = value;
          break;
        case 'biometricLogin':
          biometricLogin = value;
          break;
        case 'autoLogout':
          autoLogout = value;
          break;
        case 'securePassword':
          securePassword = value;
          break;
        case 'passwordExpiry':
          passwordExpiry = value;
          break;
        case 'loginHistory':
          loginHistory = value;
          break;
        case 'suspiciousActivityAlert':
          suspiciousActivityAlert = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              ss("Security settings saved successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Security Status Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor.withAlpha(20), successColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Status: Good",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
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
                              lastLogin,
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
                              "Active Sessions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              activeSessionsCount,
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

            // Security Features
            ...securityFeatures.map((category) {
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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: category["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    ...(category["settings"] as List).map((setting) {
                      final bool currentValue = _getSwitchValue(setting["key"]);
                      final bool isCritical = setting["critical"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCritical 
                              ? (currentValue ? successColor.withAlpha(10) : warningColor.withAlpha(10))
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isCritical 
                                ? (currentValue ? successColor.withAlpha(50) : warningColor.withAlpha(50))
                                : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              setting["icon"] as IconData,
                              color: isCritical 
                                  ? (currentValue ? successColor : warningColor)
                                  : (currentValue ? primaryColor : disabledBoldColor),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${setting["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isCritical) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: currentValue ? successColor : warningColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            currentValue ? "ACTIVE" : "CRITICAL",
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
                                  Text(
                                    "${setting["description"]}",
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
                              value: currentValue,
                              onChanged: (value) {
                                _setSwitchValue(setting["key"], value);
                              },
                              activeColor: isCritical ? successColor : primaryColor,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),

            // Recent Security Activity
            Container(
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
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Security Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...recentActivity.map((activity) {
                    Color statusColor = activity["status"] == "success" 
                        ? successColor 
                        : activity["status"] == "blocked" 
                            ? dangerColor 
                            : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: statusColor.withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${activity["action"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${activity["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.devices,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${activity["device"]} • ${activity["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${activity["time"]} • IP: ${activity["ip"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Security Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Change Password",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('ChangePasswordView')
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Active Sessions",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('ActiveSessionsView')
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download Security Report",
                      size: bs.sm,
                      onPressed: () {
                        ss("Security report download started");
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Log Out All Devices",
                      size: bs.sm,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to log out from all devices?");
                        if (isConfirmed) {
                          ss("Logged out from all devices successfully");
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
    );
  }
}

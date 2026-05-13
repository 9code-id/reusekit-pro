import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshSecuritySettingsView extends StatefulWidget {
  const CshSecuritySettingsView({super.key});

  @override
  State<CshSecuritySettingsView> createState() => _CshSecuritySettingsViewState();
}

class _CshSecuritySettingsViewState extends State<CshSecuritySettingsView> {
  bool twoFactorAuth = true;
  bool biometricLogin = false;
  bool singleSignOn = true;
  bool sessionTimeout = true;
  bool loginNotifications = true;
  bool suspiciousActivityAlert = true;
  bool accountLockout = true;
  bool passwordExpiration = false;
  String sessionTimeoutDuration = "30 minutes";
  String passwordPolicy = "Medium";
  String encryptionLevel = "AES-256";
  String loginAttempts = "5";
  String lockoutDuration = "15 minutes";
  
  List<Map<String, dynamic>> timeoutOptions = [
    {"label": "15 minutes", "value": "15 minutes"},
    {"label": "30 minutes", "value": "30 minutes"},
    {"label": "1 hour", "value": "1 hour"},
    {"label": "2 hours", "value": "2 hours"},
    {"label": "4 hours", "value": "4 hours"},
    {"label": "8 hours", "value": "8 hours"},
  ];
  
  List<Map<String, dynamic>> passwordPolicyOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Enterprise", "value": "Enterprise"},
  ];
  
  List<Map<String, dynamic>> encryptionOptions = [
    {"label": "AES-128", "value": "AES-128"},
    {"label": "AES-256", "value": "AES-256"},
    {"label": "RSA-2048", "value": "RSA-2048"},
    {"label": "RSA-4096", "value": "RSA-4096"},
  ];
  
  List<Map<String, dynamic>> attemptOptions = [
    {"label": "3", "value": "3"},
    {"label": "5", "value": "5"},
    {"label": "7", "value": "7"},
    {"label": "10", "value": "10"},
  ];
  
  List<Map<String, dynamic>> lockoutOptions = [
    {"label": "5 minutes", "value": "5 minutes"},
    {"label": "15 minutes", "value": "15 minutes"},
    {"label": "30 minutes", "value": "30 minutes"},
    {"label": "1 hour", "value": "1 hour"},
    {"label": "24 hours", "value": "24 hours"},
  ];

  List<Map<String, dynamic>> securityLogs = [
    {
      "action": "Successful login",
      "timestamp": "2024-01-15 09:30:25",
      "ipAddress": "192.168.1.100",
      "location": "New York, US",
      "device": "Chrome on Windows",
      "status": "Success"
    },
    {
      "action": "Failed login attempt",
      "timestamp": "2024-01-15 09:25:12",
      "ipAddress": "192.168.1.101",
      "location": "Unknown",
      "device": "Unknown Browser",
      "status": "Failed"
    },
    {
      "action": "Password changed",
      "timestamp": "2024-01-14 14:20:15",
      "ipAddress": "192.168.1.100",
      "location": "New York, US",
      "device": "Chrome on Windows",
      "status": "Success"
    },
    {
      "action": "Two-factor enabled",
      "timestamp": "2024-01-14 10:15:30",
      "ipAddress": "192.168.1.100",
      "location": "New York, US",
      "device": "Chrome on Windows",
      "status": "Success"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          IconButton(
            onPressed: () {
              _saveSecuritySettings();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Authentication Settings Section
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
                    "Authentication Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Two-Factor Authentication",
                    items: [
                      {
                        "label": "Enable two-factor authentication",
                        "value": true,
                        "checked": twoFactorAuth,
                      }
                    ],
                    value: [if (twoFactorAuth) {"label": "Enable two-factor authentication", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      twoFactorAuth = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Biometric Login",
                    items: [
                      {
                        "label": "Enable biometric authentication",
                        "value": true,
                        "checked": biometricLogin,
                      }
                    ],
                    value: [if (biometricLogin) {"label": "Enable biometric authentication", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      biometricLogin = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Single Sign-On (SSO)",
                    items: [
                      {
                        "label": "Enable SSO integration",
                        "value": true,
                        "checked": singleSignOn,
                      }
                    ],
                    value: [if (singleSignOn) {"label": "Enable SSO integration", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      singleSignOn = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Session Management Section
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
                    "Session Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Session Timeout",
                    items: [
                      {
                        "label": "Enable automatic session timeout",
                        "value": true,
                        "checked": sessionTimeout,
                      }
                    ],
                    value: [if (sessionTimeout) {"label": "Enable automatic session timeout", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      sessionTimeout = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Session Timeout Duration",
                    items: timeoutOptions,
                    value: sessionTimeoutDuration,
                    onChanged: (value, label) {
                      sessionTimeoutDuration = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Password Policies Section
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
                    "Password Policies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Password Policy Level",
                    items: passwordPolicyOptions,
                    value: passwordPolicy,
                    onChanged: (value, label) {
                      passwordPolicy = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Password Expiration",
                    items: [
                      {
                        "label": "Require periodic password changes",
                        "value": true,
                        "checked": passwordExpiration,
                      }
                    ],
                    value: [if (passwordExpiration) {"label": "Require periodic password changes", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      passwordExpiration = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Security Monitoring Section
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
                    "Security Monitoring",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Login Notifications",
                    items: [
                      {
                        "label": "Notify on successful logins",
                        "value": true,
                        "checked": loginNotifications,
                      }
                    ],
                    value: [if (loginNotifications) {"label": "Notify on successful logins", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      loginNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Suspicious Activity Alerts",
                    items: [
                      {
                        "label": "Alert on suspicious activities",
                        "value": true,
                        "checked": suspiciousActivityAlert,
                      }
                    ],
                    value: [if (suspiciousActivityAlert) {"label": "Alert on suspicious activities", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      suspiciousActivityAlert = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Account Protection Section
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
                    "Account Protection",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Account Lockout",
                    items: [
                      {
                        "label": "Lock account after failed attempts",
                        "value": true,
                        "checked": accountLockout,
                      }
                    ],
                    value: [if (accountLockout) {"label": "Lock account after failed attempts", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      accountLockout = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Max Login Attempts",
                    items: attemptOptions,
                    value: loginAttempts,
                    onChanged: (value, label) {
                      loginAttempts = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Lockout Duration",
                    items: lockoutOptions,
                    value: lockoutDuration,
                    onChanged: (value, label) {
                      lockoutDuration = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Encryption Settings Section
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
                    "Encryption Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Encryption Level",
                    items: encryptionOptions,
                    value: encryptionLevel,
                    onChanged: (value, label) {
                      encryptionLevel = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Security Activity Log Section
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
                    children: [
                      Text(
                        "Recent Security Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _viewFullLog();
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(securityLogs.length, (index) {
                    final log = securityLogs[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (log["status"] == "Success") ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (log["status"] == "Success") ? successColor.withAlpha(100) : dangerColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                (log["status"] == "Success") ? Icons.check_circle : Icons.error,
                                color: (log["status"] == "Success") ? successColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${log["action"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${log["timestamp"]} • ${log["ipAddress"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${log["location"]} • ${log["device"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Change Password",
                          icon: Icons.lock,
                          size: bs.md,
                          onPressed: () {
                            _changePassword();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Security Audit",
                          icon: Icons.security,
                          size: bs.md,
                          onPressed: () {
                            _runSecurityAudit();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Security Settings",
                      icon: Icons.shield,
                      size: bs.md,
                      onPressed: () {
                        _saveSecuritySettings();
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

  void _changePassword() {
    ss("Password change dialog opened");
  }

  void _runSecurityAudit() {
    ss("Security audit initiated");
  }

  void _viewFullLog() {
    ss("Full security log opened");
  }

  void _saveSecuritySettings() {
    ss("Security settings saved successfully");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings4View extends StatefulWidget {
  @override
  State<GrlSettings4View> createState() => _GrlSettings4ViewState();
}

class _GrlSettings4ViewState extends State<GrlSettings4View> {
  bool twoFactorEnabled = false;
  bool biometricEnabled = true;
  bool autoLockEnabled = true;
  String autoLockDuration = "5 minutes";
  bool loginNotifications = true;
  bool suspiciousActivityAlerts = true;
  bool dataEncryption = true;
  bool secureBackup = false;
  
  List<Map<String, dynamic>> autoLockOptions = [
    {"label": "Immediately", "value": "immediately"},
    {"label": "30 seconds", "value": "30 seconds"},
    {"label": "1 minute", "value": "1 minute"},
    {"label": "5 minutes", "value": "5 minutes"},
    {"label": "15 minutes", "value": "15 minutes"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "type": "login",
      "description": "Successful login from new device",
      "location": "New York, US",
      "timestamp": "2 hours ago",
      "icon": Icons.login,
      "status": "success"
    },
    {
      "type": "password_change",
      "description": "Password changed successfully",
      "location": "Current device",
      "timestamp": "1 day ago",
      "icon": Icons.key,
      "status": "success"
    },
    {
      "type": "failed_login",
      "description": "Failed login attempt",
      "location": "Unknown location",
      "timestamp": "3 days ago",
      "icon": Icons.warning,
      "status": "warning"
    },
    {
      "type": "device_added",
      "description": "New device authorized",
      "location": "Los Angeles, US",
      "timestamp": "1 week ago",
      "icon": Icons.devices,
      "status": "info"
    },
  ];

  List<Map<String, dynamic>> trustedDevices = [
    {
      "name": "iPhone 14 Pro",
      "type": "Mobile",
      "location": "Current device",
      "lastUsed": "Active now",
      "icon": Icons.phone_iphone,
    },
    {
      "name": "MacBook Pro",
      "type": "Desktop",
      "location": "New York, US",
      "lastUsed": "2 hours ago",
      "icon": Icons.laptop_mac,
    },
    {
      "name": "iPad Air",
      "type": "Tablet",
      "location": "Home",
      "lastUsed": "Yesterday",
      "icon": Icons.tablet_mac,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          QButton(
            icon: Icons.security,
            size: bs.sm,
            onPressed: () {
              si("Security scan feature coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Security Status Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.verified_user,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Security Score",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "85/100",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      _buildSecurityMetric("Strong", successColor),
                      SizedBox(width: spSm),
                      _buildSecurityMetric("2FA Enabled", twoFactorEnabled ? successColor : warningColor),
                      SizedBox(width: spSm),
                      _buildSecurityMetric("Encrypted", dataEncryption ? successColor : dangerColor),
                    ],
                  ),
                ],
              ),
            ),

            // Authentication Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Authentication",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildSecurityToggle(
                    Icons.security,
                    "Two-Factor Authentication",
                    "Add an extra layer of security",
                    twoFactorEnabled,
                    (value) {
                      twoFactorEnabled = value;
                      setState(() {});
                      if (value) {
                        ss("Two-factor authentication enabled");
                      } else {
                        sw("Two-factor authentication disabled");
                      }
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildSecurityToggle(
                    Icons.fingerprint,
                    "Biometric Login",
                    "Use fingerprint or face recognition",
                    biometricEnabled,
                    (value) {
                      biometricEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildSecurityToggle(
                    Icons.timer,
                    "Auto Lock",
                    "Automatically lock the app",
                    autoLockEnabled,
                    (value) {
                      autoLockEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  if (autoLockEnabled) ...[
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Auto Lock Duration",
                      items: autoLockOptions,
                      value: autoLockDuration,
                      onChanged: (value, label) {
                        autoLockDuration = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Security Alerts
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildSecurityToggle(
                    Icons.login,
                    "Login Notifications",
                    "Alert when someone logs into your account",
                    loginNotifications,
                    (value) {
                      loginNotifications = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildSecurityToggle(
                    Icons.warning,
                    "Suspicious Activity Alerts",
                    "Notify about unusual account activity",
                    suspiciousActivityAlerts,
                    (value) {
                      suspiciousActivityAlerts = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Data Protection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Protection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildSecurityToggle(
                    Icons.enhanced_encryption,
                    "Data Encryption",
                    "Encrypt all stored data",
                    dataEncryption,
                    (value) {
                      dataEncryption = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildSecurityToggle(
                    Icons.cloud_upload,
                    "Secure Cloud Backup",
                    "Encrypted backups to cloud storage",
                    secureBackup,
                    (value) {
                      secureBackup = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Security Activity
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Recent Security Activity",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("Security activity log coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...securityEvents.take(3).map((event) => _buildSecurityEvent(event)),
                ],
              ),
            ),

            // Trusted Devices
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.devices,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Trusted Devices",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Manage",
                        size: bs.sm,
                        onPressed: () {
                          si("Device management coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...trustedDevices.map((device) => _buildTrustedDevice(device)),
                ],
              ),
            ),

            // Security Actions
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Change Password",
                    size: bs.md,
                    onPressed: () {
                      si("Password change feature coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Download Security Report",
                    size: bs.md,
                    onPressed: () {
                      si("Security report download coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sign Out All Devices",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Sign out from all devices? You'll need to sign in again on all your devices.");
                      if (isConfirmed) {
                        ss("Signed out from all devices");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityMetric(String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSecurityEvent(Map<String, dynamic> event) {
    Color statusColor = primaryColor;
    if (event["status"] == "success") statusColor = successColor;
    if (event["status"] == "warning") statusColor = warningColor;
    if (event["status"] == "info") statusColor = infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              event["icon"],
              color: statusColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${event["location"]} • ${event["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedDevice(Map<String, dynamic> device) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              device["icon"],
              color: primaryColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${device["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${device["type"]} • ${device["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${device["lastUsed"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("Device options coming soon");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

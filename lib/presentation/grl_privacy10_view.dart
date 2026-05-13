import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy10View extends StatefulWidget {
  @override
  State<GrlPrivacy10View> createState() => _GrlPrivacy10ViewState();
}

class _GrlPrivacy10ViewState extends State<GrlPrivacy10View> {
  bool biometricEnabled = false;
  bool twoFactorEnabled = true;
  bool sessionMonitoring = true;
  bool deviceVerification = true;
  String selectedSessionTimeout = "30_minutes";
  String selectedPasswordStrength = "strong";
  
  List<Map<String, dynamic>> sessionTimeoutOptions = [
    {"label": "15 minutes", "value": "15_minutes"},
    {"label": "30 minutes", "value": "30_minutes"},
    {"label": "1 hour", "value": "1_hour"},
    {"label": "4 hours", "value": "4_hours"},
    {"label": "Never (not recommended)", "value": "never"},
  ];
  
  List<Map<String, dynamic>> passwordStrengthOptions = [
    {"label": "Basic (8+ characters)", "value": "basic"},
    {"label": "Strong (12+ characters, mixed case, numbers)", "value": "strong"},
    {"label": "Maximum (16+ characters, symbols required)", "value": "maximum"},
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "type": "Login Success",
      "description": "Successful login from mobile device",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
      "location": "New York, NY",
      "device": "iPhone 13 Pro",
      "ipAddress": "192.168.1.100",
      "riskLevel": "low",
      "verified": true,
      "icon": Icons.login,
    },
    {
      "type": "Password Changed",
      "description": "Account password was updated",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "location": "New York, NY",
      "device": "MacBook Pro",
      "ipAddress": "192.168.1.101",
      "riskLevel": "low",
      "verified": true,
      "icon": Icons.key,
    },
    {
      "type": "New Device Added",
      "description": "New device registered to account",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "location": "New York, NY",
      "device": "iPad Air",
      "ipAddress": "192.168.1.102",
      "riskLevel": "medium",
      "verified": true,
      "icon": Icons.devices,
    },
    {
      "type": "Suspicious Login Blocked",
      "description": "Login attempt from unrecognized location",
      "timestamp": DateTime.now().subtract(Duration(days: 3)),
      "location": "Los Angeles, CA",
      "device": "Unknown Device",
      "ipAddress": "203.0.113.1",
      "riskLevel": "high",
      "verified": false,
      "icon": Icons.block,
    },
    {
      "type": "2FA Enabled",
      "description": "Two-factor authentication activated",
      "timestamp": DateTime.now().subtract(Duration(days: 7)),
      "location": "New York, NY",
      "device": "iPhone 13 Pro",
      "ipAddress": "192.168.1.100",
      "riskLevel": "low",
      "verified": true,
      "icon": Icons.verified_user,
    },
  ];

  List<Map<String, dynamic>> trustedDevices = [
    {
      "name": "iPhone 13 Pro",
      "type": "Mobile",
      "lastAccess": DateTime.now().subtract(Duration(minutes: 15)),
      "location": "New York, NY",
      "status": "active",
      "fingerprint": "a1:b2:c3:d4:e5:f6",
      "addedDate": DateTime.now().subtract(Duration(days: 30)),
      "icon": Icons.phone_iphone,
    },
    {
      "name": "MacBook Pro",
      "type": "Computer",
      "lastAccess": DateTime.now().subtract(Duration(hours: 6)),
      "location": "New York, NY", 
      "status": "active",
      "fingerprint": "f6:e5:d4:c3:b2:a1",
      "addedDate": DateTime.now().subtract(Duration(days: 45)),
      "icon": Icons.laptop_mac,
    },
    {
      "name": "iPad Air",
      "type": "Tablet",
      "lastAccess": DateTime.now().subtract(Duration(days: 2)),
      "location": "New York, NY",
      "status": "inactive",
      "fingerprint": "b3:c4:d5:e6:f7:a8",
      "addedDate": DateTime.now().subtract(Duration(days: 2)),
      "icon": Icons.tablet_mac,
    },
  ];

  List<Map<String, dynamic>> securityRecommendations = [
    {
      "title": "Enable Biometric Authentication",
      "description": "Use fingerprint or face recognition for faster, secure access",
      "priority": "high",
      "implemented": false,
      "icon": Icons.fingerprint,
    },
    {
      "title": "Review Trusted Devices",
      "description": "Remove devices you no longer use or recognize",
      "priority": "medium",
      "implemented": false,
      "icon": Icons.devices,
    },
    {
      "title": "Update Recovery Email",
      "description": "Ensure your recovery email is current and accessible",
      "priority": "medium",
      "implemented": true,
      "icon": Icons.email,
    },
    {
      "title": "Enable Login Notifications",
      "description": "Get notified of all login attempts to your account",
      "priority": "low",
      "implemented": true,
      "icon": Icons.notifications,
    },
  ];

  Color getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'inactive':
        return warningColor;
      case 'blocked':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Security"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor,
                    successColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Security Center",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Manage your account security settings",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Strong",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Security Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings_applications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Biometric Authentication
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Biometric Authentication",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Use fingerprint or face recognition",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: biometricEnabled,
                        onChanged: (value) {
                          biometricEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(color: disabledColor),
                  
                  // Two-Factor Authentication
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Two-Factor Authentication",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Recommended",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Extra security with SMS or authenticator app",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: twoFactorEnabled,
                        onChanged: (value) {
                          twoFactorEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(color: disabledColor),
                  
                  // Session Monitoring
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Session Monitoring",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Monitor for unusual account activity",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: sessionMonitoring,
                        onChanged: (value) {
                          sessionMonitoring = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Divider(color: disabledColor),
                  
                  // Device Verification
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Device Verification",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Verify new devices before allowing access",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: deviceVerification,
                        onChanged: (value) {
                          deviceVerification = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  // Session Timeout
                  QDropdownField(
                    label: "Session Timeout",
                    items: sessionTimeoutOptions,
                    value: selectedSessionTimeout,
                    onChanged: (value, label) {
                      selectedSessionTimeout = value;
                      setState(() {});
                    },
                  ),
                  
                  // Password Strength
                  QDropdownField(
                    label: "Password Requirements",
                    items: passwordStrengthOptions,
                    value: selectedPasswordStrength,
                    onChanged: (value, label) {
                      selectedPasswordStrength = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Trusted Devices
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.devices,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trusted Devices",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${trustedDevices.length} Devices",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  ...trustedDevices.map((device) {
                    DateTime lastAccess = device["lastAccess"] as DateTime;
                    DateTime addedDate = device["addedDate"] as DateTime;
                    Color statusColor = getStatusColor(device["status"]);
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  device["icon"] as IconData,
                                  color: statusColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${device["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${device["status"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
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
                            ],
                          ),
                          
                          // Device Details
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Last Access: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${lastAccess.dMMMykkss}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Added: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${addedDate.dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Fingerprint: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${device["fingerprint"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Device Actions
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: device["status"] == "active" ? "Deactivate" : "Activate",
                                  size: bs.sm,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("${device["status"] == "active" ? "Deactivate" : "Activate"} this device?");
                                    if (isConfirmed) {
                                      si("Device ${device["status"] == "active" ? "deactivated" : "activated"} successfully");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Remove Device",
                                  size: bs.sm,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Remove this device from your trusted devices?");
                                    if (isConfirmed) {
                                      sw("Device removed from trusted devices");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Recent Security Events
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Security Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  ...securityEvents.take(3).map((event) {
                    DateTime timestamp = event["timestamp"] as DateTime;
                    Color riskColor = getRiskColor(event["riskLevel"]);
                    bool isVerified = event["verified"] as bool;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: riskColor.withAlpha(60),
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: riskColor.withAlpha(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: riskColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              event["icon"] as IconData,
                              color: riskColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${event["type"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (isVerified)
                                      Icon(
                                        Icons.verified,
                                        size: 16,
                                        color: successColor,
                                      ),
                                  ],
                                ),
                                Text(
                                  "${event["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${timestamp.dMMMykkss} • ${event["location"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: riskColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${event["riskLevel"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: riskColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View All Security Events",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to full security log
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Security Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Recommendations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  ...securityRecommendations.map((recommendation) {
                    Color priorityColor = getPriorityColor(recommendation["priority"]);
                    bool isImplemented = recommendation["implemented"] as bool;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isImplemented ? successColor.withAlpha(60) : priorityColor.withAlpha(60),
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: isImplemented ? successColor.withAlpha(10) : priorityColor.withAlpha(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isImplemented 
                                  ? successColor.withAlpha(20) 
                                  : priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isImplemented 
                                  ? Icons.check_circle 
                                  : recommendation["icon"] as IconData,
                              color: isImplemented ? successColor : priorityColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${recommendation["title"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: priorityColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${recommendation["priority"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: priorityColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${recommendation["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isImplemented)
                            GestureDetector(
                              onTap: () {
                                // Implement recommendation
                                si("Security recommendation implemented");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
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
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: dangerColor.withAlpha(40),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Security Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "If you suspect your account has been compromised, take immediate action to secure it.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Change Password",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to password change
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Lock Account",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Temporarily lock your account? You'll need to contact support to unlock it.");
                            if (isConfirmed) {
                              se("Account locked successfully. Contact support to unlock.");
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
}

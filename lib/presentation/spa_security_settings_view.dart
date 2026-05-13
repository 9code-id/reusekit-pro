import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaSecuritySettingsView extends StatefulWidget {
  const SpaSecuritySettingsView({super.key});

  @override
  State<SpaSecuritySettingsView> createState() => _SpaSecuritySettingsViewState();
}

class _SpaSecuritySettingsViewState extends State<SpaSecuritySettingsView> {
  bool twoFactorEnabled = false;
  bool biometricLoginEnabled = true;
  bool loginNotifications = true;
  bool deviceManagementEnabled = true;
  bool sessionTimeoutEnabled = true;
  bool autoLockEnabled = false;
  
  String sessionTimeout = "30_minutes";
  String autoLockTimeout = "5_minutes";
  String securityLevel = "high";
  
  List<Map<String, dynamic>> connectedDevices = [
    {
      "id": 1,
      "deviceName": "iPhone 14 Pro",
      "deviceType": "mobile",
      "platform": "iOS 17.2",
      "lastAccess": "2024-01-19T14:30:00Z",
      "location": "New York, NY",
      "current": true,
      "trusted": true,
    },
    {
      "id": 2,
      "deviceName": "MacBook Pro",
      "deviceType": "desktop",
      "platform": "macOS Sonoma",
      "lastAccess": "2024-01-18T09:15:00Z",
      "location": "New York, NY",
      "current": false,
      "trusted": true,
    },
    {
      "id": 3,
      "deviceName": "iPad Air",
      "deviceType": "tablet",
      "platform": "iPadOS 17.1",
      "lastAccess": "2024-01-15T16:45:00Z",
      "location": "Los Angeles, CA",
      "current": false,
      "trusted": false,
    },
    {
      "id": 4,
      "deviceName": "Chrome Browser",
      "deviceType": "web",
      "platform": "Windows 11",
      "lastAccess": "2024-01-12T11:20:00Z",
      "location": "Chicago, IL",
      "current": false,
      "trusted": false,
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "id": 1,
      "type": "login_success",
      "description": "Successful login from iPhone 14 Pro",
      "timestamp": "2024-01-19T14:30:00Z",
      "location": "New York, NY",
      "riskLevel": "low",
    },
    {
      "id": 2,
      "type": "password_change",
      "description": "Password changed successfully",
      "timestamp": "2024-01-17T10:15:00Z",
      "location": "New York, NY",
      "riskLevel": "low",
    },
    {
      "id": 3,
      "type": "failed_login",
      "description": "Failed login attempt from unknown device",
      "timestamp": "2024-01-15T22:30:00Z",
      "location": "Unknown Location",
      "riskLevel": "high",
    },
    {
      "id": 4,
      "type": "device_added",
      "description": "New device added: iPad Air",
      "timestamp": "2024-01-14T16:45:00Z",
      "location": "Los Angeles, CA",
      "riskLevel": "medium",
    },
  ];

  List<Map<String, dynamic>> timeoutOptions = [
    {"label": "15 minutes", "value": "15_minutes"},
    {"label": "30 minutes", "value": "30_minutes"},
    {"label": "1 hour", "value": "1_hour"},
    {"label": "2 hours", "value": "2_hours"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> autoLockOptions = [
    {"label": "1 minute", "value": "1_minute"},
    {"label": "5 minutes", "value": "5_minutes"},
    {"label": "10 minutes", "value": "10_minutes"},
    {"label": "15 minutes", "value": "15_minutes"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> securityLevelOptions = [
    {"label": "Basic", "value": "basic"},
    {"label": "Standard", "value": "standard"},
    {"label": "High", "value": "high"},
    {"label": "Maximum", "value": "maximum"},
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
              _runSecurityScan();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSecurityHeader(),
            _buildSecurityLevel(),
            _buildAuthenticationSettings(),
            _buildSessionSettings(),
            _buildConnectedDevices(),
            _buildSecurityActivity(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader() {
    final riskScore = _calculateRiskScore();
    final riskColor = _getRiskColor(riskScore);
    final riskLabel = _getRiskLabel(riskScore);
    
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.security,
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
                      "Account Security",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Protect your account with advanced security features",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.white.withAlpha(100), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: riskColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getRiskIcon(riskScore),
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
                        "Security Score: $riskScore/100",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "$riskLabel Security Level",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    _showSecurityInfo();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityLevel() {
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
              Icon(Icons.tune, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Security Level",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Choose your preferred security level for account protection",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          QDropdownField(
            label: "Security Level",
            items: securityLevelOptions,
            value: securityLevel,
            onChanged: (value, label) {
              securityLevel = value;
              setState(() {});
            },
          ),
          
          _buildSecurityLevelInfo(),
        ],
      ),
    );
  }

  Widget _buildSecurityLevelInfo() {
    final levelColor = _getSecurityLevelColor(securityLevel);
    final levelDescription = _getSecurityLevelDescription(securityLevel);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: levelColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: levelColor, width: 1),
      ),
      child: Column(
        spacing: spXs,
        children: [
        Row(
          children: [
            Icon(Icons.info, color: levelColor, size: 18),
            SizedBox(width: spSm),
            Text(
              "${securityLevel.toUpperCase()} Security Level",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: levelColor,
              ),
            ),
          ],
        ),
        Text(
          levelDescription,
          style: TextStyle(
            fontSize: 13,
            color: levelColor,
            height: 1.3,
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildAuthenticationSettings() {
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
              Icon(Icons.fingerprint, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Authentication Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          _buildAuthToggle(
            "Two-Factor Authentication",
            "Add an extra layer of security with SMS or app verification",
            Icons.security,
            twoFactorEnabled,
            (value) {
              twoFactorEnabled = value;
              setState(() {});
            },
            hasSetup: true,
          ),
          
          _buildAuthToggle(
            "Biometric Login",
            "Use fingerprint or face recognition for quick access",
            Icons.fingerprint,
            biometricLoginEnabled,
            (value) {
              biometricLoginEnabled = value;
              setState(() {});
            },
            hasSetup: true,
          ),
          
          _buildAuthToggle(
            "Login Notifications",
            "Get notified when someone signs into your account",
            Icons.notifications,
            loginNotifications,
            (value) {
              loginNotifications = value;
              setState(() {});
            },
            hasSetup: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthToggle(String title, String description, IconData icon,
      bool value, Function(bool) onChanged, {required bool hasSetup}) {
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
      child: Column(
        spacing: spSm,
        children: [
          Row(
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
          
          if (hasSetup && value) ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Configure",
                    size: bs.sm,
                    onPressed: () {
                      _configureAuthentication(title);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Test",
                    size: bs.sm,
                    onPressed: () {
                      _testAuthentication(title);
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSessionSettings() {
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
              Icon(Icons.timer, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Session & Auto-Lock",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto Session Timeout",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Automatically sign out after inactivity",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: sessionTimeoutEnabled,
                onChanged: (value) {
                  sessionTimeoutEnabled = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          
          if (sessionTimeoutEnabled) ...[
            QDropdownField(
              label: "Session Timeout",
              items: timeoutOptions,
              value: sessionTimeout,
              onChanged: (value, label) {
                sessionTimeout = value;
                setState(() {});
              },
            ),
          ],
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto-Lock Screen",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Lock app when not in use",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: autoLockEnabled,
                onChanged: (value) {
                  autoLockEnabled = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          
          if (autoLockEnabled) ...[
            QDropdownField(
              label: "Auto-Lock Timeout",
              items: autoLockOptions,
              value: autoLockTimeout,
              onChanged: (value, label) {
                autoLockTimeout = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnectedDevices() {
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
              Icon(Icons.devices, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Connected Devices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  _refreshDevices();
                },
              ),
            ],
          ),
          Text(
            "Manage devices that have access to your account",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...connectedDevices.map((device) {
            return _buildDeviceCard(device);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    final isCurrent = device["current"] as bool;
    final isTrusted = device["trusted"] as bool;
    final lastAccess = DateTime.parse(device["timestamp"] ?? device["lastAccess"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCurrent ? primaryColor.withAlpha(25) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isCurrent ? primaryColor : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getDeviceColor(device["deviceType"]),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getDeviceIcon(device["deviceType"]),
                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${device["deviceName"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isCurrent) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "CURRENT",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        if (isTrusted) ...[
                          SizedBox(width: spXs),
                          Icon(Icons.verified, color: successColor, size: 16),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${device["platform"]} • ${device["location"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last access: ${lastAccess.dMMMy} ${lastAccess.dMMMykkss.split(' ')[1]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (!isCurrent) ...[
            Row(
              children: [
                if (!isTrusted) ...[
                  Expanded(
                    child: QButton(
                      label: "Trust Device",
                      size: bs.sm,
                      onPressed: () {
                        _trustDevice(device["id"]);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: "Remove Access",
                    size: bs.sm,
                    onPressed: () {
                      _removeDeviceAccess(device["id"]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSecurityActivity() {
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
              Icon(Icons.history, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Recent Security Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.more_horiz,
                size: bs.sm,
                onPressed: () {
                  _viewAllActivity();
                },
              ),
            ],
          ),
          
          ...securityEvents.take(3).map((event) {
            return _buildActivityItem(event);
          }).toList(),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "View All Activity",
              size: bs.sm,
              onPressed: () {
                _viewAllActivity();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> event) {
    final timestamp = DateTime.parse(event["timestamp"]);
    final riskLevel = event["riskLevel"] as String;
    final riskColor = _getActivityRiskColor(riskLevel);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: riskColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: riskColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: riskColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getActivityIcon(event["type"]),
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${timestamp.dMMMy} • ${event["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: riskColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              riskLevel.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Security Settings",
            size: bs.md,
            onPressed: () {
              _saveSecuritySettings();
            },
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Change Password",
                size: bs.sm,
                onPressed: () {
                  _changePassword();
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: "Sign Out All Devices",
                size: bs.sm,
                onPressed: () {
                  _signOutAllDevices();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _calculateRiskScore() {
    int score = 50; // Base score
    
    if (twoFactorEnabled) score += 20;
    if (biometricLoginEnabled) score += 15;
    if (loginNotifications) score += 10;
    if (sessionTimeoutEnabled) score += 10;
    if (autoLockEnabled) score += 5;
    
    // Reduce score for security risks
    final recentFailedLogins = securityEvents.where((e) => e["type"] == "failed_login").length;
    score -= recentFailedLogins * 5;
    
    return score.clamp(0, 100);
  }

  String _getRiskLabel(int score) {
    if (score >= 80) return "Excellent";
    if (score >= 60) return "Good";
    if (score >= 40) return "Fair";
    return "Poor";
  }

  Color _getRiskColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return primaryColor;
    if (score >= 40) return warningColor;
    return dangerColor;
  }

  IconData _getRiskIcon(int score) {
    if (score >= 80) return Icons.shield;
    if (score >= 60) return Icons.security;
    if (score >= 40) return Icons.warning;
    return Icons.dangerous;
  }

  Color _getSecurityLevelColor(String level) {
    switch (level) {
      case "basic":
        return warningColor;
      case "standard":
        return infoColor;
      case "high":
        return successColor;
      case "maximum":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getSecurityLevelDescription(String level) {
    switch (level) {
      case "basic":
        return "Basic password protection with minimal security features enabled.";
      case "standard":
        return "Standard security with session timeouts and login notifications.";
      case "high":
        return "Enhanced security with two-factor authentication and biometric login.";
      case "maximum":
        return "Maximum security with all features enabled and strict timeout policies.";
      default:
        return "Unknown security level.";
    }
  }

  Color _getDeviceColor(String deviceType) {
    switch (deviceType) {
      case "mobile":
        return primaryColor;
      case "desktop":
        return infoColor;
      case "tablet":
        return successColor;
      case "web":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getDeviceIcon(String deviceType) {
    switch (deviceType) {
      case "mobile":
        return Icons.smartphone;
      case "desktop":
        return Icons.computer;
      case "tablet":
        return Icons.tablet;
      case "web":
        return Icons.web;
      default:
        return Icons.device_unknown;
    }
  }

  Color _getActivityRiskColor(String riskLevel) {
    switch (riskLevel) {
      case "low":
        return successColor;
      case "medium":
        return warningColor;
      case "high":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "login_success":
        return Icons.login;
      case "password_change":
        return Icons.key;
      case "failed_login":
        return Icons.error;
      case "device_added":
        return Icons.add_circle;
      default:
        return Icons.info;
    }
  }

  void _runSecurityScan() {
    ss("Running security scan");
    //navigateTo ( SecurityScanView )
  }

  void _showSecurityInfo() {
    ss("Showing security information");
    //navigateTo ( SecurityInfoView )
  }

  void _configureAuthentication(String method) {
    ss("Configuring $method");
    //navigateTo ( AuthConfigView )
  }

  void _testAuthentication(String method) {
    ss("Testing $method");
    //navigateTo ( AuthTestView )
  }

  void _refreshDevices() {
    ss("Refreshing connected devices");
    setState(() {});
  }

  void _trustDevice(int deviceId) {
    setState(() {
      final index = connectedDevices.indexWhere((d) => d["id"] == deviceId);
      if (index != -1) {
        connectedDevices[index]["trusted"] = true;
      }
    });
    ss("Device trusted successfully");
  }

  void _removeDeviceAccess(int deviceId) {
    setState(() {
      connectedDevices.removeWhere((d) => d["id"] == deviceId);
    });
    ss("Device access removed");
  }

  void _viewAllActivity() {
    ss("Viewing all security activity");
    //navigateTo ( SecurityActivityView )
  }

  void _saveSecuritySettings() {
    ss("Security settings saved successfully");
    //navigateTo ( previous view )
  }

  void _changePassword() {
    ss("Change password requested");
    //navigateTo ( ChangePasswordView )
  }

  void _signOutAllDevices() {
    ss("All devices signed out");
    //navigateTo ( LoginView )
  }
}

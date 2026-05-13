import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud9View extends StatefulWidget {
  @override
  State<GrlCloud9View> createState() => _GrlCloud9ViewState();
}

class _GrlCloud9ViewState extends State<GrlCloud9View> {
  bool loading = false;
  bool twoFactorEnabled = true;
  bool emailNotifications = true;
  bool accessLogging = true;
  bool autoLockEnabled = false;
  String autoLockDuration = "5min";
  
  List<Map<String, dynamic>> trustedDevices = [
    {
      "id": "1",
      "name": "MacBook Pro",
      "type": "laptop",
      "os": "macOS Monterey",
      "lastAccess": "2024-06-22T10:30:00Z",
      "location": "New York, NY",
      "trusted": true,
      "current": true,
    },
    {
      "id": "2",
      "name": "iPhone 13",
      "type": "mobile",
      "os": "iOS 16.5",
      "lastAccess": "2024-06-22T09:45:00Z",
      "location": "New York, NY",
      "trusted": true,
      "current": false,
    },
    {
      "id": "3",
      "name": "iPad Air",
      "type": "tablet",
      "os": "iPadOS 16.5",
      "lastAccess": "2024-06-21T18:20:00Z",
      "location": "New York, NY",
      "trusted": true,
      "current": false,
    },
    {
      "id": "4",
      "name": "Unknown Device",
      "type": "unknown",
      "os": "Windows 11",
      "lastAccess": "2024-06-20T14:15:00Z",
      "location": "Chicago, IL",
      "trusted": false,
      "current": false,
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "id": "1",
      "type": "login_success",
      "device": "MacBook Pro",
      "location": "New York, NY",
      "timestamp": "2024-06-22T10:30:00Z",
      "ip": "192.168.1.100",
    },
    {
      "id": "2",
      "type": "login_failed",
      "device": "Unknown Device",
      "location": "Chicago, IL",
      "timestamp": "2024-06-20T14:15:00Z",
      "ip": "203.0.113.45",
    },
    {
      "id": "3",
      "type": "password_changed",
      "device": "iPhone 13",
      "location": "New York, NY",
      "timestamp": "2024-06-19T16:45:00Z",
      "ip": "192.168.1.105",
    },
    {
      "id": "4",
      "type": "2fa_enabled",
      "device": "MacBook Pro",
      "location": "New York, NY",
      "timestamp": "2024-06-18T11:30:00Z",
      "ip": "192.168.1.100",
    },
  ];

  List<Map<String, dynamic>> lockDurationOptions = [
    {"label": "1 minute", "value": "1min"},
    {"label": "5 minutes", "value": "5min"},
    {"label": "15 minutes", "value": "15min"},
    {"label": "30 minutes", "value": "30min"},
    {"label": "1 hour", "value": "1h"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showSecurityHelp,
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSecurityOverview(),
                SizedBox(height: spLg),
                _buildSecuritySettings(),
                SizedBox(height: spLg),
                _buildTrustedDevices(),
                SizedBox(height: spLg),
                _buildSecurityEvents(),
              ],
            ),
          ),
    );
  }

  Widget _buildSecurityOverview() {
    int trustedDeviceCount = trustedDevices.where((d) => d["trusted"] as bool).length;
    int recentEvents = securityEvents.where((e) {
      DateTime eventDate = DateTime.parse("${e["timestamp"]}");
      return DateTime.now().difference(eventDate).inDays < 7;
    }).length;

    return Container(
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
                Icons.security,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Security Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getSecurityScoreColor().withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${_getSecurityScore()}% Secure",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getSecurityScoreColor(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "2FA Status",
                  twoFactorEnabled ? "Enabled" : "Disabled",
                  Icons.verified_user,
                  twoFactorEnabled ? successColor : dangerColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Trusted Devices",
                  "$trustedDeviceCount",
                  Icons.devices,
                  primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Recent Events",
                  "$recentEvents",
                  Icons.timeline,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Access Logging",
                  accessLogging ? "Active" : "Inactive",
                  Icons.list_alt,
                  accessLogging ? successColor : warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Security Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSecuritySettingRow(
            "Two-Factor Authentication",
            "Add an extra layer of security to your account",
            Icons.verified_user,
            Switch(
              value: twoFactorEnabled,
              onChanged: (value) {
                twoFactorEnabled = value;
                setState(() {});
                _toggle2FA(value);
              },
              activeColor: primaryColor,
            ),
          ),
          Divider(height: spLg),
          _buildSecuritySettingRow(
            "Email Notifications",
            "Get notified of security events via email",
            Icons.email,
            Switch(
              value: emailNotifications,
              onChanged: (value) {
                emailNotifications = value;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
          Divider(height: spLg),
          _buildSecuritySettingRow(
            "Access Logging",
            "Keep a log of all account access attempts",
            Icons.list_alt,
            Switch(
              value: accessLogging,
              onChanged: (value) {
                accessLogging = value;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
          Divider(height: spLg),
          _buildSecuritySettingRow(
            "Auto Lock",
            "Automatically lock account after inactivity",
            Icons.lock_clock,
            Switch(
              value: autoLockEnabled,
              onChanged: (value) {
                autoLockEnabled = value;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
          if (autoLockEnabled) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  "Lock after:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: _showLockDurationSelector,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getLockDurationLabel(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSecuritySettingRow(String title, String subtitle, IconData icon, Widget trailing) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            size: 20,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spMd),
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
        SizedBox(width: spSm),
        trailing,
      ],
    );
  }

  Widget _buildTrustedDevices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Trusted Devices (${trustedDevices.where((d) => d["trusted"] as bool).length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _manageAllDevices,
              child: Text(
                "Manage All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...trustedDevices.map((device) => _buildDeviceItem(device)).toList(),
      ],
    );
  }

  Widget _buildDeviceItem(Map<String, dynamic> device) {
    bool isTrusted = device["trusted"] as bool;
    bool isCurrent = device["current"] as bool;
    IconData deviceIcon = _getDeviceIcon(device["type"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isCurrent 
          ? Border.all(color: primaryColor, width: 2)
          : Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (isTrusted ? successColor : warningColor).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              deviceIcon,
              size: 24,
              color: isTrusted ? successColor : warningColor,
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
                      "${device["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (isCurrent) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "CURRENT",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${device["os"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Last access: ${DateTime.parse("${device["lastAccess"]}").dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${device["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (isTrusted ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isTrusted ? "TRUSTED" : "UNTRUSTED",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isTrusted ? successColor : dangerColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              if (!isCurrent)
                GestureDetector(
                  onTap: () => _removeDevice(device),
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Security Events",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...securityEvents.take(5).map((event) => _buildSecurityEventItem(event)).toList(),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "View All Events",
            size: bs.sm,
            onPressed: _viewAllSecurityEvents,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityEventItem(Map<String, dynamic> event) {
    Color eventColor = _getEventColor(event["type"] as String);
    IconData eventIcon = _getEventIcon(event["type"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: eventColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: eventColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              eventIcon,
              size: 20,
              color: eventColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getEventTitle(event["type"] as String),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "From ${event["device"]} in ${event["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "IP: ${event["ip"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateTime.parse("${event["timestamp"]}").dMMMy,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSecurityScoreColor() {
    int score = _getSecurityScore();
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  int _getSecurityScore() {
    int score = 0;
    if (twoFactorEnabled) score += 40;
    if (emailNotifications) score += 20;
    if (accessLogging) score += 20;
    if (autoLockEnabled) score += 20;
    return score;
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case "laptop":
        return Icons.laptop;
      case "mobile":
        return Icons.phone_android;
      case "tablet":
        return Icons.tablet;
      case "desktop":
        return Icons.desktop_windows;
      default:
        return Icons.device_unknown;
    }
  }

  Color _getEventColor(String type) {
    switch (type) {
      case "login_success":
        return successColor;
      case "login_failed":
        return dangerColor;
      case "password_changed":
        return warningColor;
      case "2fa_enabled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case "login_success":
        return Icons.login;
      case "login_failed":
        return Icons.error;
      case "password_changed":
        return Icons.vpn_key;
      case "2fa_enabled":
        return Icons.verified_user;
      default:
        return Icons.info;
    }
  }

  String _getEventTitle(String type) {
    switch (type) {
      case "login_success":
        return "Successful Login";
      case "login_failed":
        return "Failed Login Attempt";
      case "password_changed":
        return "Password Changed";
      case "2fa_enabled":
        return "Two-Factor Authentication Enabled";
      default:
        return "Security Event";
    }
  }

  String _getLockDurationLabel() {
    return lockDurationOptions
        .firstWhere((option) => option["value"] == autoLockDuration)["label"] as String;
  }

  void _toggle2FA(bool enabled) {
    if (enabled) {
      ss("Two-factor authentication enabled");
    } else {
      sw("Two-factor authentication disabled");
    }
  }

  void _showLockDurationSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Auto Lock Duration",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...lockDurationOptions.map((option) => ListTile(
              title: Text("${option["label"]}"),
              trailing: autoLockDuration == option["value"]
                  ? Icon(Icons.check, color: primaryColor)
                  : null,
              onTap: () {
                autoLockDuration = option["value"] as String;
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _manageAllDevices() {
    si("Feature coming soon - Manage all trusted devices");
  }

  void _removeDevice(Map<String, dynamic> device) async {
    bool isConfirmed = await confirm("Remove ${device["name"]} from trusted devices?");
    if (isConfirmed) {
      trustedDevices.remove(device);
      setState(() {});
      sw("Device removed from trusted list");
    }
  }

  void _viewAllSecurityEvents() {
    si("Feature coming soon - View complete security event log");
  }

  void _showSecurityHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Security Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Two-Factor Authentication: Adds extra security layer"),
            Text("• Email Notifications: Alerts you of security events"),
            Text("• Access Logging: Records all login attempts"),
            Text("• Auto Lock: Automatically secures account when inactive"),
            Text("• Trusted Devices: Devices you regularly use"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

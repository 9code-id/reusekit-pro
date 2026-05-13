import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity5View extends StatefulWidget {
  @override
  State<GrlSecurity5View> createState() => _GrlSecurity5ViewState();
}

class _GrlSecurity5ViewState extends State<GrlSecurity5View> {
  String selectedTab = 'activity';
  
  List<Map<String, dynamic>> loginActivity = [
    {
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "time": "2 minutes ago",
      "status": "active",
      "ip": "192.168.1.1",
      "browser": "Mobile App",
    },
    {
      "device": "MacBook Pro",
      "location": "New York, NY", 
      "time": "1 hour ago",
      "status": "inactive",
      "ip": "192.168.1.5",
      "browser": "Chrome 119.0",
    },
    {
      "device": "Windows PC",
      "location": "Chicago, IL",
      "time": "3 hours ago",
      "status": "inactive",
      "ip": "10.0.0.15",
      "browser": "Edge 118.0",
    },
    {
      "device": "iPad",
      "location": "Boston, MA",
      "time": "Yesterday",
      "status": "suspicious",
      "ip": "203.45.67.89",
      "browser": "Safari 17.0",
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "type": "login_success",
      "title": "Successful Login",
      "description": "Login from iPhone 14 Pro in New York, NY",
      "time": "2 minutes ago",
      "severity": "info",
      "icon": Icons.login,
    },
    {
      "type": "password_change",
      "title": "Password Updated", 
      "description": "Account password was successfully changed",
      "time": "2 days ago",
      "severity": "success",
      "icon": Icons.key,
    },
    {
      "type": "failed_login",
      "title": "Failed Login Attempt",
      "description": "Multiple failed login attempts from unknown device",
      "time": "3 days ago",
      "severity": "warning",
      "icon": Icons.warning,
    },
    {
      "type": "suspicious_activity",
      "title": "Suspicious Location",
      "description": "Login detected from unusual location (Boston, MA)",
      "time": "5 days ago",
      "severity": "danger",
      "icon": Icons.location_off,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Monitor"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Security data refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'activity';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'activity' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Login Activity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'activity' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'events';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'events' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Security Events",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'events' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: selectedTab == 'activity' ? _buildActivityView() : _buildEventsView(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Session
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.devices,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Current Session",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "ACTIVE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${loginActivity[0]["device"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.white70,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${loginActivity[0]["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Activity Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${loginActivity.where((a) => a["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active Sessions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${loginActivity.where((a) => a["status"] == "suspicious").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Suspicious",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Recent Activity
          Text(
            "Recent Login Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...loginActivity.map((activity) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: activity["status"] == "suspicious"
                  ? Border.all(color: dangerColor.withAlpha(102))
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getStatusColor(activity["status"]).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          _getDeviceIcon(activity["device"]),
                          color: _getStatusColor(activity["status"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["device"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${activity["browser"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(activity["status"]).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${activity["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(activity["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "IP: ${activity["ip"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                  if (activity["status"] == "suspicious") ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: dangerColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: QButton(
                              label: "Block Device",
                              size: bs.sm,
                              onPressed: () async {
                                bool isConfirmed = await confirm("Block this device from accessing your account?");
                                if (isConfirmed) {
                                  ss("Device blocked successfully");
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Mark Safe",
                            size: bs.sm,
                            onPressed: () {
                              activity["status"] = "inactive";
                              setState(() {});
                              ss("Device marked as safe");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildEventsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${securityEvents.where((e) => e["severity"] == "danger" || e["severity"] == "warning").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Security Alerts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${securityEvents.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Events",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Security Timeline
          Text(
            "Security Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...securityEvents.map((event) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getSeverityColor(event["severity"]),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getSeverityColor(event["severity"]).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      event["icon"] as IconData,
                      color: _getSeverityColor(event["severity"]),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (event["severity"] == "warning" || event["severity"] == "danger")
                    QButton(
                      label: "Review",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Export Options
          Container(
            width: double.infinity,
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
                  "Security Report",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Export detailed security activity and event logs",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export PDF",
                        size: bs.sm,
                        onPressed: () {
                          ss("Security report exported as PDF");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QButton(
                          label: "Email Report",
                          size: bs.sm,
                          onPressed: () {
                            ss("Security report sent to your email");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'suspicious':
        return dangerColor;
      case 'inactive':
      default:
        return disabledBoldColor;
    }
  }

  IconData _getDeviceIcon(String device) {
    if (device.toLowerCase().contains('iphone') || device.toLowerCase().contains('mobile')) {
      return Icons.phone_iphone;
    } else if (device.toLowerCase().contains('ipad') || device.toLowerCase().contains('tablet')) {
      return Icons.tablet_mac;
    } else if (device.toLowerCase().contains('mac')) {
      return Icons.laptop_mac;
    } else {
      return Icons.computer;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'danger':
        return dangerColor;
      case 'warning':
        return warningColor;
      case 'success':
        return successColor;
      case 'info':
      default:
        return primaryColor;
    }
  }
}

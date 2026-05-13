import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsDeviceManagementView extends StatefulWidget {
  const BrsDeviceManagementView({super.key});

  @override
  State<BrsDeviceManagementView> createState() => _BrsDeviceManagementViewState();
}

class _BrsDeviceManagementViewState extends State<BrsDeviceManagementView> {
  String currentDeviceId = "device_001";
  
  List<Map<String, dynamic>> devices = [
    {
      "id": "device_001",
      "name": "iPhone 14 Pro",
      "type": "mobile",
      "os": "iOS 16.4",
      "browser": "Safari",
      "location": "New York, NY",
      "lastActive": "2024-06-14 10:30:00",
      "ipAddress": "192.168.1.100",
      "isCurrent": true,
      "isTrusted": true,
    },
    {
      "id": "device_002", 
      "name": "MacBook Pro",
      "type": "desktop",
      "os": "macOS Sonoma",
      "browser": "Chrome",
      "location": "New York, NY",
      "lastActive": "2024-06-14 09:15:00",
      "ipAddress": "192.168.1.101",
      "isCurrent": false,
      "isTrusted": true,
    },
    {
      "id": "device_003",
      "name": "Samsung Galaxy S23",
      "type": "mobile",
      "os": "Android 13",
      "browser": "Chrome Mobile",
      "location": "Brooklyn, NY",
      "lastActive": "2024-06-13 22:45:00",
      "ipAddress": "192.168.1.102",
      "isCurrent": false,
      "isTrusted": false,
    },
    {
      "id": "device_004",
      "name": "Windows PC",
      "type": "desktop",
      "os": "Windows 11",
      "browser": "Edge",
      "location": "Unknown Location",
      "lastActive": "2024-06-12 14:20:00",
      "ipAddress": "203.0.113.45",
      "isCurrent": false,
      "isTrusted": false,
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "type": "login",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
      "timestamp": "2024-06-14 10:30:00",
      "status": "success",
    },
    {
      "type": "login_failed",
      "device": "Unknown Device",
      "location": "Los Angeles, CA",
      "timestamp": "2024-06-13 18:15:00",
      "status": "failed",
    },
    {
      "type": "password_change",
      "device": "MacBook Pro",
      "location": "New York, NY",
      "timestamp": "2024-06-12 16:45:00",
      "status": "success",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshDevices();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Manage and monitor all devices that have access to your account. Remove access from devices you don't recognize.",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trusted Devices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${devices.where((d) => d["isTrusted"] as bool).length} devices",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            ...devices.map((device) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: (device["isCurrent"] as bool) ? primaryColor : disabledOutlineBorderColor,
                    width: (device["isCurrent"] as bool) ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getDeviceColor(device["type"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getDeviceIcon(device["type"] as String),
                            color: _getDeviceColor(device["type"] as String),
                            size: 24,
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
                                  if (device["isCurrent"] as bool) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Current",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${device["os"]} • ${device["browser"]}",
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
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (device["isTrusted"] as bool) ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            (device["isTrusted"] as bool) ? "Trusted" : "Untrusted",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${device["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "IP: ${device["ipAddress"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Last active: ${DateTime.parse(device["lastActive"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    if (!(device["isCurrent"] as bool)) ...[
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          if (!(device["isTrusted"] as bool))
                            Expanded(
                              child: QButton(
                                label: "Trust Device",
                                size: bs.sm,
                                onPressed: () {
                                  _trustDevice(device["id"] as String);
                                },
                              ),
                            ),
                          if (!(device["isTrusted"] as bool))
                            SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Remove Access",
                              size: bs.sm,
                              onPressed: () {
                                _removeDevice(device["id"] as String);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spLg),
            Text(
              "Recent Security Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: securityEvents.map((event) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getEventColor(event["status"] as String).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getEventColor(event["status"] as String).withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getEventIcon(event["type"] as String),
                          color: _getEventColor(event["status"] as String),
                          size: 20,
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${event["device"]} from ${event["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${DateTime.parse(event["timestamp"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            QButton(
              label: "Sign Out All Other Devices",
              size: bs.md,
              onPressed: () {
                _signOutAllDevices();
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case 'mobile':
        return Icons.smartphone;
      case 'desktop':
        return Icons.computer;
      case 'tablet':
        return Icons.tablet;
      default:
        return Icons.device_unknown;
    }
  }

  Color _getDeviceColor(String type) {
    switch (type) {
      case 'mobile':
        return primaryColor;
      case 'desktop':
        return successColor;
      case 'tablet':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'login':
        return Icons.login;
      case 'login_failed':
        return Icons.error;
      case 'password_change':
        return Icons.security;
      default:
        return Icons.info;
    }
  }

  Color _getEventColor(String status) {
    switch (status) {
      case 'success':
        return successColor;
      case 'failed':
        return dangerColor;
      default:
        return infoColor;
    }
  }

  String _getEventTitle(String type) {
    switch (type) {
      case 'login':
        return "Successful Login";
      case 'login_failed':
        return "Failed Login Attempt";
      case 'password_change':
        return "Password Changed";
      default:
        return "Security Event";
    }
  }

  void _trustDevice(String deviceId) async {
    bool isConfirmed = await confirm("Trust this device? This will allow it to access your account without additional verification.");
    if (isConfirmed) {
      setState(() {
        devices.firstWhere((d) => d["id"] == deviceId)["isTrusted"] = true;
      });
      ss("Device marked as trusted");
    }
  }

  void _removeDevice(String deviceId) async {
    bool isConfirmed = await confirm("Remove access for this device? The user will need to sign in again.");
    if (isConfirmed) {
      setState(() {
        devices.removeWhere((d) => d["id"] == deviceId);
      });
      ss("Device access removed");
    }
  }

  void _signOutAllDevices() async {
    bool isConfirmed = await confirm("Sign out all other devices? This will require users to sign in again on those devices.");
    if (isConfirmed) {
      setState(() {
        devices.removeWhere((d) => !(d["isCurrent"] as bool));
      });
      ss("Signed out from all other devices");
    }
  }

  void _refreshDevices() {
    // Simulate refresh
    ss("Device list refreshed");
  }
}

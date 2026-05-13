import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaDeviceConnectionView extends StatefulWidget {
  const FwaDeviceConnectionView({super.key});

  @override
  State<FwaDeviceConnectionView> createState() => _FwaDeviceConnectionViewState();
}

class _FwaDeviceConnectionViewState extends State<FwaDeviceConnectionView> {
  bool scanning = false;
  bool bluetoothEnabled = true;
  
  List<Map<String, dynamic>> connectedDevices = [
    {
      "id": "apple_watch_1",
      "name": "Apple Watch Series 8",
      "type": "smartwatch",
      "brand": "Apple",
      "icon": Icons.watch,
      "batteryLevel": 78,
      "connected": true,
      "lastSync": "2025-06-15 14:30:00",
      "signalStrength": 4,
      "features": ["Heart Rate", "GPS", "Sleep Tracking", "Workout Detection"],
    },
    {
      "id": "fitbit_charge_1",
      "name": "Fitbit Charge 5",
      "type": "fitness_tracker",
      "brand": "Fitbit",
      "icon": Icons.watch,
      "batteryLevel": 92,
      "connected": true,
      "lastSync": "2025-06-15 13:15:00",
      "signalStrength": 3,
      "features": ["Steps", "Heart Rate", "Sleep", "Stress"],
    },
  ];

  List<Map<String, dynamic>> availableDevices = [
    {
      "id": "garmin_1",
      "name": "Garmin Forerunner 945",
      "type": "smartwatch",
      "brand": "Garmin",
      "icon": Icons.watch,
      "distance": 2.5,
      "features": ["GPS", "Heart Rate", "Training Modes"],
    },
    {
      "id": "polar_1",
      "name": "Polar H10",
      "type": "heart_rate_monitor",
      "brand": "Polar",
      "icon": Icons.favorite,
      "distance": 1.2,
      "features": ["Heart Rate", "Bluetooth", "ANT+"],
    },
    {
      "id": "samsung_1",
      "name": "Galaxy Watch 5",
      "type": "smartwatch",
      "brand": "Samsung",
      "icon": Icons.watch,
      "distance": 3.8,
      "features": ["Heart Rate", "Sleep", "GPS", "SpO2"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Connections"),
        actions: [
          QButton(
            icon: scanning ? Icons.stop : Icons.search,
            size: bs.sm,
            onPressed: () {
              if (scanning) {
                _stopScanning();
              } else {
                _startScanning();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Bluetooth Status
            _buildBluetoothStatusSection(),
            
            // Connected Devices
            _buildConnectedDevicesSection(),
            
            // Available Devices
            _buildAvailableDevicesSection(),
            
            // Device Management
            _buildDeviceManagementSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothStatusSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: bluetoothEnabled 
                ? primaryColor.withAlpha(20) 
                : disabledColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bluetooth,
              color: bluetoothEnabled ? primaryColor : disabledColor,
              size: 40,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            bluetoothEnabled ? "Bluetooth Enabled" : "Bluetooth Disabled",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: bluetoothEnabled ? primaryColor : disabledColor,
            ),
          ),
          Text(
            bluetoothEnabled 
              ? "Ready to connect devices"
              : "Enable Bluetooth to connect devices",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          if (!bluetoothEnabled) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Enable Bluetooth",
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    bluetoothEnabled = true;
                  });
                  ss("Bluetooth enabled");
                },
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: scanning ? "Stop Scanning" : "Scan Devices",
                    size: bs.sm,
                    onPressed: () {
                      if (scanning) {
                        _stopScanning();
                      } else {
                        _startScanning();
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Settings",
                    size: bs.sm,
                    onPressed: () {
                      ss("Open Bluetooth settings");
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

  Widget _buildConnectedDevicesSection() {
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
              Icon(
                Icons.link,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Connected Devices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${connectedDevices.length}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (connectedDevices.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.devices,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Connected Devices",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Scan for devices to get started",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...connectedDevices.map((device) {
              return _buildDeviceCard(device, isConnected: true);
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvailableDevicesSection() {
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
              Icon(
                scanning ? Icons.radar : Icons.bluetooth_searching,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                scanning ? "Scanning for Devices..." : "Available Devices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (scanning) ...[
                SizedBox(width: spSm),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: primaryColor,
                  ),
                ),
              ],
            ],
          ),
          if (!scanning && availableDevices.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.bluetooth_disabled,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Devices Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Make sure your device is in pairing mode",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...availableDevices.map((device) {
              return _buildDeviceCard(device, isConnected: false);
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildDeviceManagementSection() {
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
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Device Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildManagementAction(
            icon: Icons.help,
            title: "Connection Help",
            subtitle: "Get help connecting your device",
            onTap: () {
              ss("Open connection help guide");
            },
          ),
          _buildManagementAction(
            icon: Icons.sync,
            title: "Sync All Devices",
            subtitle: "Sync data from all connected devices",
            onTap: () {
              ss("Syncing all devices...");
            },
          ),
          _buildManagementAction(
            icon: Icons.bluetooth_connected,
            title: "Bluetooth Settings",
            subtitle: "Manage Bluetooth preferences",
            onTap: () {
              ss("Open Bluetooth settings");
            },
          ),
          _buildManagementAction(
            icon: Icons.device_hub,
            title: "Supported Devices",
            subtitle: "View list of compatible devices",
            onTap: () {
              ss("View supported devices list");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device, {required bool isConnected}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(
          color: isConnected ? successColor.withAlpha(100) : disabledOutlineBorderColor,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  device["icon"] as IconData,
                  color: primaryColor,
                  size: 24,
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
                        if (isConnected) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "CONNECTED",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${device["brand"]} • ${device["type"].toString().replaceAll('_', ' ').toUpperCase()}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (isConnected) ...[
                      Row(
                        children: [
                          if (device["batteryLevel"] != null) ...[
                            Icon(
                              Icons.battery_std,
                              color: _getBatteryColor(device["batteryLevel"]),
                              size: 14,
                            ),
                            Text(
                              "${device["batteryLevel"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          ...List.generate(5, (index) {
                            return Icon(
                              Icons.signal_cellular_4_bar,
                              color: index < (device["signalStrength"] ?? 0) 
                                ? successColor 
                                : disabledColor,
                              size: 12,
                            );
                          }),
                        ],
                      ),
                    ] else ...[
                      Text(
                        "${device["distance"]}m away",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              QButton(
                icon: isConnected ? Icons.settings : Icons.add,
                size: bs.sm,
                onPressed: () {
                  if (isConnected) {
                    _showDeviceSettings(device);
                  } else {
                    _connectDevice(device);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Wrap(
              spacing: spXs,
              children: (device["features"] as List).map<Widget>((feature) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$feature",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          border: Border.all(color: disabledOutlineBorderColor),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _startScanning() {
    setState(() {
      scanning = true;
    });
    
    // Simulate scanning
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        scanning = false;
      });
      ss("Scan completed. Found ${availableDevices.length} devices");
    });
  }

  void _stopScanning() {
    setState(() {
      scanning = false;
    });
    ss("Scanning stopped");
  }

  void _connectDevice(Map<String, dynamic> device) async {
    showLoading();
    
    // Simulate connection process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    setState(() {
      device["connected"] = true;
      device["lastSync"] = DateTime.now().toString();
      device["batteryLevel"] = 85;
      device["signalStrength"] = 4;
      connectedDevices.add(device);
      availableDevices.remove(device);
    });
    
    ss("${device["name"]} connected successfully");
  }

  void _showDeviceSettings(Map<String, dynamic> device) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "${device["name"]} Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.sync),
                title: Text("Sync Now"),
                onTap: () {
                  back();
                  ss("Syncing ${device["name"]}...");
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Device Settings"),
                onTap: () {
                  back();
                  ss("Open ${device["name"]} settings");
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("Device Info"),
                onTap: () {
                  back();
                  _showDeviceInfo(device);
                },
              ),
              ListTile(
                leading: Icon(Icons.link_off, color: dangerColor),
                title: Text("Disconnect", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  back();
                  bool isConfirmed = await confirm("Disconnect ${device["name"]}?");
                  if (isConfirmed) {
                    setState(() {
                      connectedDevices.remove(device);
                      device["connected"] = false;
                      availableDevices.add(device);
                    });
                    ss("${device["name"]} disconnected");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeviceInfo(Map<String, dynamic> device) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${device["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brand: ${device["brand"]}"),
              Text("Type: ${device["type"]}"),
              Text("Battery: ${device["batteryLevel"]}%"),
              Text("Last Sync: ${_formatDateTime(device["lastSync"])}"),
              SizedBox(height: spSm),
              Text("Features:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...(device["features"] as List).map((feature) => Text("• $feature")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Color _getBatteryColor(int level) {
    if (level > 50) return successColor;
    if (level > 20) return warningColor;
    return dangerColor;
  }

  String _formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      final now = DateTime.now();
      final difference = now.difference(dt);
      
      if (difference.inMinutes < 1) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else {
        return "${difference.inDays}d ago";
      }
    } catch (e) {
      return dateTime;
    }
  }
}

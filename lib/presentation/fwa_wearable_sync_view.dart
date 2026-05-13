import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWearableSyncView extends StatefulWidget {
  const FwaWearableSyncView({super.key});

  @override
  State<FwaWearableSyncView> createState() => _FwaWearableSyncViewState();
}

class _FwaWearableSyncViewState extends State<FwaWearableSyncView> {
  bool autoSync = true;
  bool realtimeSync = false;
  bool syncWorkouts = true;
  bool syncHealthMetrics = true;
  bool syncSleepData = true;
  bool syncNutrition = false;
  String syncFrequency = "hourly";
  bool syncing = false;

  List<Map<String, dynamic>> wearableDevices = [
    {
      "id": "apple_watch_1",
      "name": "Apple Watch Series 8",
      "brand": "Apple",
      "type": "smartwatch",
      "icon": Icons.watch,
      "connected": true,
      "syncEnabled": true,
      "lastSync": "2025-06-15 14:30:00",
      "dataTypes": {
        "heart_rate": {"enabled": true, "count": 2400, "lastSync": "2025-06-15 14:30:00"},
        "steps": {"enabled": true, "count": 8750, "lastSync": "2025-06-15 14:30:00"},
        "workouts": {"enabled": true, "count": 3, "lastSync": "2025-06-15 12:00:00"},
        "sleep": {"enabled": true, "count": 1, "lastSync": "2025-06-15 08:00:00"},
        "calories": {"enabled": true, "count": 1850, "lastSync": "2025-06-15 14:30:00"},
      },
      "batteryLevel": 78,
      "status": "synced",
    },
    {
      "id": "fitbit_charge_1",
      "name": "Fitbit Charge 5",
      "brand": "Fitbit",
      "type": "fitness_tracker",
      "icon": Icons.fitness_center,
      "connected": true,
      "syncEnabled": true,
      "lastSync": "2025-06-15 13:15:00",
      "dataTypes": {
        "heart_rate": {"enabled": true, "count": 1890, "lastSync": "2025-06-15 13:15:00"},
        "steps": {"enabled": true, "count": 7245, "lastSync": "2025-06-15 13:15:00"},
        "sleep": {"enabled": true, "count": 1, "lastSync": "2025-06-15 08:30:00"},
        "stress": {"enabled": true, "count": 24, "lastSync": "2025-06-15 13:15:00"},
      },
      "batteryLevel": 92,
      "status": "synced",
    },
    {
      "id": "garmin_1",
      "name": "Garmin Forerunner 945",
      "brand": "Garmin",
      "type": "sports_watch",
      "icon": Icons.directions_run,
      "connected": false,
      "syncEnabled": false,
      "lastSync": null,
      "dataTypes": {},
      "batteryLevel": null,
      "status": "disconnected",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wearable Sync"),
        actions: [
          QButton(
            icon: Icons.sync,
            size: bs.sm,
            onPressed: syncing ? null : () {
              _syncAllDevices();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Sync Overview
            _buildSyncOverviewSection(),
            
            // Sync Settings
            _buildSyncSettingsSection(),
            
            // Connected Wearables
            _buildConnectedWearablesSection(),
            
            // Data Type Settings
            _buildDataTypeSettingsSection(),
            
            // Sync History
            _buildSyncHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncOverviewSection() {
    int connectedCount = wearableDevices.where((d) => d["connected"] == true).length;
    int totalDataPoints = 0;
    
    for (var device in wearableDevices) {
      if (device["connected"] == true) {
        Map<String, dynamic> dataTypes = device["dataTypes"] as Map<String, dynamic>;
        for (var data in dataTypes.values) {
          totalDataPoints += (data["count"] as int? ?? 0);
        }
      }
    }

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
          if (syncing) ...[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    color: primaryColor,
                  ),
                  Icon(
                    Icons.sync,
                    color: primaryColor,
                    size: 32,
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Syncing Wearables...",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Pulling data from connected devices",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOverviewStat(
                  icon: Icons.devices,
                  title: "Connected",
                  value: "$connectedCount",
                  color: successColor,
                ),
                _buildOverviewStat(
                  icon: Icons.data_usage,
                  title: "Data Points",
                  value: "${(totalDataPoints / 1000).toStringAsFixed(1)}K",
                  color: primaryColor,
                ),
                _buildOverviewStat(
                  icon: Icons.sync,
                  title: "Last Sync",
                  value: "30m ago",
                  color: infoColor,
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: syncing ? "Syncing..." : "Sync All Devices",
              size: bs.md,
              onPressed: syncing ? null : () {
                _syncAllDevices();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSyncSettingsSection() {
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
                "Sync Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSyncToggle(
            title: "Auto Sync",
            subtitle: "Automatically sync data from wearables",
            value: autoSync,
            onChanged: (value) {
              setState(() {
                autoSync = value;
              });
              ss(value ? "Auto sync enabled" : "Auto sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Real-time Sync",
            subtitle: "Sync data as soon as it's available",
            value: realtimeSync,
            onChanged: (value) {
              setState(() {
                realtimeSync = value;
              });
              ss(value ? "Real-time sync enabled" : "Real-time sync disabled");
            },
          ),
          QDropdownField(
            label: "Sync Frequency",
            items: [
              {"label": "Real-time", "value": "realtime"},
              {"label": "Every 15 minutes", "value": "15min"},
              {"label": "Every 30 minutes", "value": "30min"},
              {"label": "Hourly", "value": "hourly"},
              {"label": "Daily", "value": "daily"},
            ],
            value: syncFrequency,
            onChanged: (value, label) {
              syncFrequency = value;
              setState(() {});
              ss("Sync frequency set to $label");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedWearablesSection() {
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
                Icons.watch,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Connected Wearables",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Navigate to device connections");
                },
                child: Text(
                  "Manage",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...wearableDevices.map((device) {
            return _buildWearableCard(device);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildWearableCard(Map<String, dynamic> device) {
    bool isConnected = device["connected"] as bool;
    Color statusColor = device["status"] == "synced" 
      ? successColor 
      : device["status"] == "error"
        ? dangerColor
        : device["status"] == "syncing"
          ? warningColor
          : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(
          color: isConnected ? statusColor.withAlpha(100) : disabledOutlineBorderColor,
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${device["status"]}".toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
                          Text(
                            "Last sync: ${_formatDateTime(device["lastSync"])}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              QButton(
                icon: isConnected ? Icons.sync : Icons.link,
                size: bs.sm,
                onPressed: () {
                  if (isConnected) {
                    _syncDevice(device);
                  } else {
                    _connectDevice(device);
                  }
                },
              ),
            ],
          ),
          if (isConnected && (device["dataTypes"] as Map).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                children: [
                  Text(
                    "Data Types",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (device["dataTypes"] as Map).entries.map<Widget>((entry) {
                      String dataType = entry.key;
                      Map data = entry.value;
                      bool enabled = data["enabled"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: enabled 
                            ? successColor.withAlpha(20) 
                            : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${dataType.replaceAll('_', ' ').toUpperCase()}: ${data["count"]}",
                          style: TextStyle(
                            fontSize: 9,
                            color: enabled ? successColor : disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDataTypeSettingsSection() {
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
                Icons.data_usage,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Data Type Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Choose which data types to sync from your wearables",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          _buildSyncToggle(
            title: "Workout Data",
            subtitle: "Exercise sessions, duration, and intensity",
            value: syncWorkouts,
            onChanged: (value) {
              setState(() {
                syncWorkouts = value;
              });
              ss(value ? "Workout sync enabled" : "Workout sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Health Metrics",
            subtitle: "Heart rate, steps, calories, and vital signs",
            value: syncHealthMetrics,
            onChanged: (value) {
              setState(() {
                syncHealthMetrics = value;
              });
              ss(value ? "Health metrics sync enabled" : "Health metrics sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Sleep Data",
            subtitle: "Sleep duration, quality, and sleep stages",
            value: syncSleepData,
            onChanged: (value) {
              setState(() {
                syncSleepData = value;
              });
              ss(value ? "Sleep data sync enabled" : "Sleep data sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Nutrition Data",
            subtitle: "Calorie intake, water consumption, and meals",
            value: syncNutrition,
            onChanged: (value) {
              setState(() {
                syncNutrition = value;
              });
              ss(value ? "Nutrition sync enabled" : "Nutrition sync disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSyncHistorySection() {
    List<Map<String, dynamic>> syncHistory = [
      {
        "timestamp": "2025-06-15 14:30:00",
        "device": "Apple Watch Series 8",
        "status": "success",
        "dataCount": 1250,
        "duration": "2.3s",
        "dataTypes": ["Heart Rate", "Steps", "Workouts"],
      },
      {
        "timestamp": "2025-06-15 13:15:00",
        "device": "Fitbit Charge 5",
        "status": "success",
        "dataCount": 890,
        "duration": "1.8s",
        "dataTypes": ["Steps", "Sleep", "Stress"],
      },
      {
        "timestamp": "2025-06-15 12:00:00",
        "device": "Apple Watch Series 8",
        "status": "success",
        "dataCount": 340,
        "duration": "1.2s",
        "dataTypes": ["Workouts"],
      },
      {
        "timestamp": "2025-06-15 10:30:00",
        "device": "Garmin Forerunner 945",
        "status": "error",
        "dataCount": 0,
        "duration": "0.5s",
        "dataTypes": [],
      },
    ];

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
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recent Sync Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("View full sync history");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...syncHistory.take(4).map((history) {
            Color statusColor = history["status"] == "success" 
              ? successColor 
              : dangerColor;
            IconData statusIcon = history["status"] == "success"
              ? Icons.check_circle
              : Icons.error;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        statusIcon,
                        color: statusColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${history["device"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${_formatDateTime(history["timestamp"])} • ${history["dataCount"]} records • ${history["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${history["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if ((history["dataTypes"] as List).isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Wrap(
                        spacing: spXs,
                        children: (history["dataTypes"] as List).map<Widget>((dataType) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$dataType",
                              style: TextStyle(
                                fontSize: 9,
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSyncToggle({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
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
          SizedBox(width: spSm),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _syncAllDevices() async {
    setState(() {
      syncing = true;
    });

    showLoading();
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 4));
    
    hideLoading();
    
    setState(() {
      syncing = false;
      // Update last sync times
      for (var device in wearableDevices) {
        if (device["connected"] == true) {
          device["lastSync"] = DateTime.now().toString();
          device["status"] = "synced";
        }
      }
    });
    
    ss("All devices synced successfully");
  }

  void _syncDevice(Map<String, dynamic> device) async {
    showLoading();
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    setState(() {
      device["lastSync"] = DateTime.now().toString();
      device["status"] = "synced";
    });
    
    ss("${device["name"]} synced successfully");
  }

  void _connectDevice(Map<String, dynamic> device) async {
    showLoading();
    
    // Simulate connection process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    setState(() {
      device["connected"] = true;
      device["syncEnabled"] = true;
      device["lastSync"] = DateTime.now().toString();
      device["status"] = "synced";
      device["batteryLevel"] = 85;
    });
    
    ss("${device["name"]} connected and synced");
  }

  Color _getBatteryColor(int? level) {
    if (level == null) return disabledColor;
    if (level > 50) return successColor;
    if (level > 20) return warningColor;
    return dangerColor;
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return "Never";
    
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaDataSyncView extends StatefulWidget {
  const FwaDataSyncView({super.key});

  @override
  State<FwaDataSyncView> createState() => _FwaDataSyncViewState();
}

class _FwaDataSyncViewState extends State<FwaDataSyncView> {
  bool autoSync = true;
  bool wifiOnlySync = true;
  bool backgroundSync = false;
  String syncFrequency = "hourly";
  String lastSyncTime = "2025-06-15 14:30:00";
  bool syncing = false;
  
  List<Map<String, dynamic>> syncServices = [
    {
      "name": "Apple Health",
      "icon": Icons.favorite,
      "connected": true,
      "lastSync": "2025-06-15 14:30:00",
      "dataTypes": ["Heart Rate", "Steps", "Sleep", "Workouts"],
      "status": "synced",
    },
    {
      "name": "Google Fit",
      "icon": Icons.fitness_center,
      "connected": true,
      "lastSync": "2025-06-15 14:25:00",
      "dataTypes": ["Steps", "Distance", "Calories", "Activities"],
      "status": "synced",
    },
    {
      "name": "Strava",
      "icon": Icons.directions_run,
      "connected": false,
      "lastSync": null,
      "dataTypes": ["Running", "Cycling", "Swimming"],
      "status": "disconnected",
    },
    {
      "name": "MyFitnessPal",
      "icon": Icons.restaurant,
      "connected": true,
      "lastSync": "2025-06-15 12:15:00",
      "dataTypes": ["Nutrition", "Water Intake", "Weight"],
      "status": "error",
    },
  ];

  List<Map<String, dynamic>> syncHistory = [
    {
      "timestamp": "2025-06-15 14:30:00",
      "service": "Apple Health",
      "status": "success",
      "dataCount": 1250,
      "duration": "2.3s",
    },
    {
      "timestamp": "2025-06-15 14:25:00",
      "service": "Google Fit",
      "status": "success",
      "dataCount": 890,
      "duration": "1.8s",
    },
    {
      "timestamp": "2025-06-15 13:30:00",
      "service": "Auto Sync",
      "status": "success",
      "dataCount": 2140,
      "duration": "4.1s",
    },
    {
      "timestamp": "2025-06-15 12:15:00",
      "service": "MyFitnessPal",
      "status": "error",
      "dataCount": 0,
      "duration": "0.5s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Sync"),
        actions: [
          QButton(
            icon: Icons.sync,
            size: bs.sm,
            onPressed: syncing ? null : () {
              _performManualSync();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Sync Status
            _buildSyncStatusSection(),
            
            // Sync Settings
            _buildSyncSettingsSection(),
            
            // Connected Services
            _buildConnectedServicesSection(),
            
            // Sync History
            _buildSyncHistorySection(),
            
            // Data Management
            _buildDataManagementSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatusSection() {
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
              "Syncing Data...",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Please wait while we sync your data",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ] else ...[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: successColor,
                size: 40,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Data Synced",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "Last sync: ${_formatDateTime(lastSyncTime)}",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Sync Now",
                  size: bs.sm,
                  onPressed: syncing ? null : () {
                    _performManualSync();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Sync Settings",
                  size: bs.sm,
                  onPressed: () {
                    ss("Navigate to advanced sync settings");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
            subtitle: "Automatically sync data in background",
            value: autoSync,
            onChanged: (value) {
              setState(() {
                autoSync = value;
              });
              ss(value ? "Auto sync enabled" : "Auto sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Wi-Fi Only",
            subtitle: "Only sync when connected to Wi-Fi",
            value: wifiOnlySync,
            onChanged: (value) {
              setState(() {
                wifiOnlySync = value;
              });
              ss(value ? "Wi-Fi only sync enabled" : "Wi-Fi only sync disabled");
            },
          ),
          _buildSyncToggle(
            title: "Background Sync",
            subtitle: "Allow syncing when app is in background",
            value: backgroundSync,
            onChanged: (value) {
              setState(() {
                backgroundSync = value;
              });
              ss(value ? "Background sync enabled" : "Background sync disabled");
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
              {"label": "Manual only", "value": "manual"},
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

  Widget _buildConnectedServicesSection() {
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
                "Connected Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Add new service integration");
                },
                child: Text(
                  "Add Service",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...syncServices.map((service) {
            Color statusColor = service["status"] == "synced" 
              ? successColor 
              : service["status"] == "error"
                ? dangerColor
                : disabledBoldColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      service["icon"] as IconData,
                      color: primaryColor,
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
                            Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spXs),
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
                                "${service["status"]}".toUpperCase(),
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
                          service["connected"] 
                            ? service["lastSync"] != null
                              ? "Last sync: ${_formatDateTime(service["lastSync"])}"
                              : "Not synced yet"
                            : "Not connected",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          (service["dataTypes"] as List).join(", "),
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: service["connected"] ? Icons.settings : Icons.link,
                    size: bs.sm,
                    onPressed: () {
                      _showServiceOptions(service);
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSyncHistorySection() {
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
                "Sync History",
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
              child: Row(
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
                          "${history["service"]}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
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
                Icons.storage,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Data Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildDataAction(
            icon: Icons.refresh,
            title: "Force Full Sync",
            subtitle: "Re-sync all data from connected services",
            onTap: () async {
              bool isConfirmed = await confirm("This will re-sync all data and may take several minutes. Continue?");
              if (isConfirmed) {
                _performFullSync();
              }
            },
          ),
          _buildDataAction(
            icon: Icons.cloud_download,
            title: "Export Sync Data",
            subtitle: "Download all synced data as backup",
            onTap: () {
              ss("Export sync data initiated");
            },
          ),
          _buildDataAction(
            icon: Icons.healing,
            title: "Repair Sync Issues",
            subtitle: "Fix sync conflicts and data inconsistencies",
            onTap: () {
              ss("Sync repair process started");
            },
          ),
          _buildDataAction(
            icon: Icons.clear_all,
            title: "Clear Sync Cache",
            subtitle: "Remove temporary sync data",
            onTap: () async {
              bool isConfirmed = await confirm("Clear all sync cache data?");
              if (isConfirmed) {
                ss("Sync cache cleared");
              }
            },
          ),
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

  Widget _buildDataAction({
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

  void _performManualSync() async {
    setState(() {
      syncing = true;
    });

    showLoading();
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    setState(() {
      syncing = false;
      lastSyncTime = DateTime.now().toString();
    });
    
    ss("Data sync completed successfully");
  }

  void _performFullSync() async {
    setState(() {
      syncing = true;
    });

    showLoading();
    
    // Simulate full sync process
    await Future.delayed(Duration(seconds: 5));
    
    hideLoading();
    
    setState(() {
      syncing = false;
      lastSyncTime = DateTime.now().toString();
    });
    
    ss("Full sync completed successfully");
  }

  void _showServiceOptions(Map<String, dynamic> service) {
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
                "${service["name"]} Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (service["connected"]) ...[
                ListTile(
                  leading: Icon(Icons.sync),
                  title: Text("Sync Now"),
                  onTap: () {
                    back();
                    ss("Syncing ${service["name"]}...");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Configure"),
                  onTap: () {
                    back();
                    ss("Configure ${service["name"]} settings");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.link_off, color: dangerColor),
                  title: Text("Disconnect", style: TextStyle(color: dangerColor)),
                  onTap: () async {
                    back();
                    bool isConfirmed = await confirm("Disconnect ${service["name"]}?");
                    if (isConfirmed) {
                      setState(() {
                        service["connected"] = false;
                      });
                      ss("${service["name"]} disconnected");
                    }
                  },
                ),
              ] else ...[
                ListTile(
                  leading: Icon(Icons.link),
                  title: Text("Connect"),
                  onTap: () {
                    back();
                    setState(() {
                      service["connected"] = true;
                    });
                    ss("${service["name"]} connected successfully");
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
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

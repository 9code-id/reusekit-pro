import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync1View extends StatefulWidget {
  @override
  State<GrlSync1View> createState() => _GrlSync1ViewState();
}

class _GrlSync1ViewState extends State<GrlSync1View> {
  bool loading = false;
  String selectedDevice = "all";
  
  List<Map<String, dynamic>> syncDevices = [
    {
      "id": "1",
      "name": "MacBook Pro",
      "type": "laptop",
      "os": "macOS Monterey",
      "lastSync": "2024-06-22T10:30:00Z",
      "status": "online",
      "syncProgress": 100,
      "filesCount": 1245,
      "totalSize": 15.7,
      "version": "2.1.4",
    },
    {
      "id": "2",
      "name": "iPhone 13",
      "type": "mobile",
      "os": "iOS 16.5",
      "lastSync": "2024-06-22T09:45:00Z",
      "status": "syncing",
      "syncProgress": 67,
      "filesCount": 892,
      "totalSize": 8.3,
      "version": "2.1.4",
    },
    {
      "id": "3",
      "name": "iPad Air",
      "type": "tablet",
      "os": "iPadOS 16.5",
      "lastSync": "2024-06-21T18:20:00Z",
      "status": "offline",
      "syncProgress": 0,
      "filesCount": 567,
      "totalSize": 12.1,
      "version": "2.1.3",
    },
    {
      "id": "4",
      "name": "Windows Desktop",
      "type": "desktop",
      "os": "Windows 11",
      "lastSync": "2024-06-22T08:15:00Z",
      "status": "error",
      "syncProgress": 25,
      "filesCount": 2134,
      "totalSize": 28.9,
      "version": "2.1.4",
    },
    {
      "id": "5",
      "name": "Android Phone",
      "type": "mobile",
      "os": "Android 13",
      "lastSync": "2024-06-22T07:30:00Z",
      "status": "online",
      "syncProgress": 100,
      "filesCount": 456,
      "totalSize": 6.2,
      "version": "2.1.2",
    },
  ];

  List<Map<String, dynamic>> recentSyncs = [
    {
      "id": "1",
      "fileName": "presentation.pdf",
      "deviceFrom": "MacBook Pro",
      "deviceTo": "iPhone 13",
      "timestamp": "2024-06-22T10:30:00Z",
      "size": 2.5,
      "status": "completed",
      "type": "file",
    },
    {
      "id": "2",
      "fileName": "Photo Library",
      "deviceFrom": "iPhone 13",
      "deviceTo": "All Devices",
      "timestamp": "2024-06-22T09:45:00Z",
      "size": 125.8,
      "status": "syncing",
      "type": "folder",
    },
    {
      "id": "3",
      "fileName": "Documents",
      "deviceFrom": "Windows Desktop",
      "deviceTo": "MacBook Pro",
      "timestamp": "2024-06-22T08:15:00Z",
      "size": 45.2,
      "status": "failed",
      "type": "folder",
    },
    {
      "id": "4",
      "fileName": "music-playlist.m3u",
      "deviceFrom": "iPad Air",
      "deviceTo": "Android Phone",
      "timestamp": "2024-06-21T16:20:00Z",
      "size": 0.3,
      "status": "completed",
      "type": "file",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Sync"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshSync,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSyncSettings,
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
                _buildSyncOverview(),
                SizedBox(height: spLg),
                _buildDeviceFilter(),
                SizedBox(height: spMd),
                _buildSyncDevices(),
                SizedBox(height: spLg),
                _buildRecentSyncs(),
                SizedBox(height: spLg),
                _buildSyncActions(),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewDevice,
        icon: Icon(Icons.add),
        label: Text("Add Device"),
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget _buildSyncOverview() {
    int onlineDevices = syncDevices.where((d) => d["status"] == "online").length;
    int syncingDevices = syncDevices.where((d) => d["status"] == "syncing").length;
    double totalSize = syncDevices.fold(0.0, (sum, d) => sum + (d["totalSize"] as double));
    int totalFiles = syncDevices.fold(0, (sum, d) => sum + (d["filesCount"] as int));

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
                Icons.sync,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sync Overview",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${syncDevices.length} Devices",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
                  "Online",
                  "$onlineDevices",
                  Icons.devices,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Syncing",
                  "$syncingDevices",
                  Icons.sync,
                  infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Total Files",
                  "${(totalFiles / 1000).toStringAsFixed(1)}K",
                  Icons.insert_drive_file,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Total Size",
                  "${totalSize.toStringAsFixed(1)} GB",
                  Icons.storage,
                  warningColor,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceFilter() {
    List<String> filterOptions = ["all", "online", "syncing", "offline", "error"];
    
    return Row(
      children: [
        Text(
          "Filter:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            height: 40,
            child: QHorizontalScroll(
              children: filterOptions.map((filter) {
                bool isSelected = selectedDevice == filter;
                return GestureDetector(
                  onTap: () {
                    selectedDevice = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Text(
                      filter.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncDevices() {
    List<Map<String, dynamic>> filteredDevices = _getFilteredDevices();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sync Devices (${filteredDevices.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...filteredDevices.map((device) => _buildDeviceItem(device)).toList(),
      ],
    );
  }

  Widget _buildDeviceItem(Map<String, dynamic> device) {
    Color statusColor = _getStatusColor(device["status"] as String);
    IconData deviceIcon = _getDeviceIcon(device["type"] as String);
    int progress = device["syncProgress"] as int;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
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
                  deviceIcon,
                  size: 24,
                  color: statusColor,
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
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${device["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${device["os"]} • v${device["version"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                onSelected: (value) => _handleDeviceAction(value, device),
                itemBuilder: (context) => [
                  PopupMenuItem(value: "sync", child: Text("Force Sync")),
                  PopupMenuItem(value: "pause", child: Text("Pause Sync")),
                  PopupMenuItem(value: "settings", child: Text("Device Settings")),
                  PopupMenuItem(value: "remove", child: Text("Remove Device")),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (device["status"] == "syncing") ...[
            Row(
              children: [
                Text(
                  "Sync Progress",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "$progress%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: infoColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
            SizedBox(height: spMd),
          ],
          Row(
            children: [
              Expanded(
                child: _buildDeviceMetric(
                  "Files",
                  "${device["filesCount"]}",
                  Icons.insert_drive_file,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildDeviceMetric(
                  "Size",
                  "${((device["totalSize"] as double)).toStringAsFixed(1)} GB",
                  Icons.storage,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildDeviceMetric(
                  "Last Sync",
                  _getLastSyncTime(device["lastSync"] as String),
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceMetric(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentSyncs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
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
              onTap: _viewAllSyncs,
              child: Text(
                "View All",
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
        ...recentSyncs.map((sync) => _buildSyncActivityItem(sync)).toList(),
      ],
    );
  }

  Widget _buildSyncActivityItem(Map<String, dynamic> sync) {
    Color statusColor = _getSyncStatusColor(sync["status"] as String);
    IconData typeIcon = sync["type"] == "folder" ? Icons.folder : Icons.insert_drive_file;
    
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
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              size: 20,
              color: statusColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${sync["fileName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${sync["deviceFrom"]} → ${sync["deviceTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${((sync["size"] as double)).toStringAsFixed(1)} MB • ${DateTime.parse("${sync["timestamp"]}").dMMMy}",
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
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${sync["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncActions() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Sync All Devices",
            size: bs.md,
            icon: Icons.sync,
            onPressed: _syncAllDevices,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Pause All",
                size: bs.sm,
                onPressed: _pauseAllSync,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Conflict Resolution",
                size: bs.sm,
                onPressed: _openConflictResolution,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return successColor;
      case "syncing":
        return infoColor;
      case "offline":
        return disabledBoldColor;
      case "error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSyncStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "syncing":
        return infoColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
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

  String _getLastSyncTime(String timestamp) {
    DateTime syncTime = DateTime.parse(timestamp);
    Duration diff = DateTime.now().difference(syncTime);
    
    if (diff.inMinutes < 1) return "Now";
    if (diff.inHours < 1) return "${diff.inMinutes}m";
    if (diff.inDays < 1) return "${diff.inHours}h";
    return "${diff.inDays}d";
  }

  List<Map<String, dynamic>> _getFilteredDevices() {
    if (selectedDevice == "all") {
      return syncDevices;
    }
    
    return syncDevices.where((device) => device["status"] == selectedDevice).toList();
  }

  void _refreshSync() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Sync status refreshed");
    });
  }

  void _openSyncSettings() {
    si("Feature coming soon - Sync settings configuration");
  }

  void _addNewDevice() {
    si("Feature coming soon - Add new device for sync");
  }

  void _handleDeviceAction(String action, Map<String, dynamic> device) {
    switch (action) {
      case "sync":
        _forceSync(device);
        break;
      case "pause":
        _pauseSync(device);
        break;
      case "settings":
        _openDeviceSettings(device);
        break;
      case "remove":
        _removeDevice(device);
        break;
    }
  }

  void _forceSync(Map<String, dynamic> device) {
    device["status"] = "syncing";
    device["syncProgress"] = 0;
    setState(() {});
    
    ss("Force sync started for ${device["name"]}");
    
    // Simulate sync progress
    _simulateSyncProgress(device);
  }

  void _simulateSyncProgress(Map<String, dynamic> device) {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (device["syncProgress"] < 100) {
        device["syncProgress"] = (device["syncProgress"] as int) + 5;
        setState(() {});
      } else {
        device["status"] = "online";
        device["lastSync"] = DateTime.now().toIso8601String();
        setState(() {});
        timer.cancel();
        ss("Sync completed for ${device["name"]}");
      }
    });
  }

  void _pauseSync(Map<String, dynamic> device) {
    if (device["status"] == "syncing") {
      device["status"] = "online";
      setState(() {});
      sw("Sync paused for ${device["name"]}");
    }
  }

  void _openDeviceSettings(Map<String, dynamic> device) {
    si("Feature coming soon - Device settings for ${device["name"]}");
  }

  void _removeDevice(Map<String, dynamic> device) async {
    bool isConfirmed = await confirm("Remove ${device["name"]} from sync?");
    if (isConfirmed) {
      syncDevices.remove(device);
      setState(() {});
      sw("Device removed from sync");
    }
  }

  void _viewAllSyncs() {
    si("Feature coming soon - View complete sync activity log");
  }

  void _syncAllDevices() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("All devices sync initiated");
    });
  }

  void _pauseAllSync() async {
    bool isConfirmed = await confirm("Pause sync for all devices?");
    if (isConfirmed) {
      for (var device in syncDevices) {
        if (device["status"] == "syncing") {
          device["status"] = "online";
        }
      }
      setState(() {});
      sw("All sync operations paused");
    }
  }

  void _openConflictResolution() {
    si("Feature coming soon - Sync conflict resolution");
  }
}

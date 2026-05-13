import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud6View extends StatefulWidget {
  @override
  State<GrlCloud6View> createState() => _GrlCloud6ViewState();
}

class _GrlCloud6ViewState extends State<GrlCloud6View> {
  bool loading = false;
  bool syncEnabled = true;
  bool autoSync = true;
  bool wifiOnly = false;
  String syncFrequency = "15min";
  
  List<Map<String, dynamic>> syncFolders = [
    {
      "id": "1",
      "name": "Documents",
      "path": "/Documents",
      "enabled": true,
      "lastSync": "2024-06-22T10:30:00Z",
      "fileCount": 245,
      "size": 125.7,
      "status": "Synced",
    },
    {
      "id": "2",
      "name": "Photos",
      "path": "/Photos",
      "enabled": true,
      "lastSync": "2024-06-22T09:45:00Z",
      "fileCount": 1024,
      "size": 2100.3,
      "status": "Syncing",
    },
    {
      "id": "3",
      "name": "Music",
      "path": "/Music",
      "enabled": false,
      "lastSync": "2024-06-21T18:20:00Z",
      "fileCount": 567,
      "size": 890.1,
      "status": "Paused",
    },
    {
      "id": "4",
      "name": "Videos",
      "path": "/Videos",
      "enabled": true,
      "lastSync": "2024-06-22T08:15:00Z",
      "fileCount": 89,
      "size": 3450.8,
      "status": "Error",
    },
    {
      "id": "5",
      "name": "Downloads",
      "path": "/Downloads",
      "enabled": true,
      "lastSync": "2024-06-22T10:00:00Z",
      "fileCount": 156,
      "size": 678.2,
      "status": "Synced",
    },
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "5 minutes", "value": "5min"},
    {"label": "15 minutes", "value": "15min"},
    {"label": "30 minutes", "value": "30min"},
    {"label": "1 hour", "value": "1h"},
    {"label": "6 hours", "value": "6h"},
    {"label": "12 hours", "value": "12h"},
    {"label": "24 hours", "value": "24h"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showSyncHelp,
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
                _buildSyncStatus(),
                SizedBox(height: spLg),
                _buildSyncSettings(),
                SizedBox(height: spLg),
                _buildSyncFolders(),
                SizedBox(height: spLg),
                _buildSyncActions(),
              ],
            ),
          ),
    );
  }

  Widget _buildSyncStatus() {
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
                syncEnabled ? Icons.cloud_done : Icons.cloud_off,
                color: syncEnabled ? successColor : disabledBoldColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Sync Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Switch(
                value: syncEnabled,
                onChanged: (value) {
                  syncEnabled = value;
                  setState(() {});
                  _toggleSync(value);
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatusMetric(
                  "Total Files",
                  "${syncFolders.fold(0, (sum, folder) => sum + (folder["fileCount"] as int))}",
                  Icons.insert_drive_file,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusMetric(
                  "Total Size",
                  "${(syncFolders.fold(0.0, (sum, folder) => sum + (folder["size"] as double)) / 1024).toStringAsFixed(1)} GB",
                  Icons.storage,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatusMetric(
                  "Active Folders",
                  "${syncFolders.where((f) => f["enabled"] as bool).length}",
                  Icons.folder,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusMetric(
                  "Last Sync",
                  _getLastSyncTime(),
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
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
                color: primaryColor,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSettings() {
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
            "Sync Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSettingRow(
            "Auto Sync",
            "Automatically sync files when changes are detected",
            Icons.sync,
            Switch(
              value: autoSync,
              onChanged: (value) {
                autoSync = value;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
          Divider(height: spLg),
          _buildSettingRow(
            "WiFi Only",
            "Only sync when connected to WiFi",
            Icons.wifi,
            Switch(
              value: wifiOnly,
              onChanged: (value) {
                wifiOnly = value;
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
          Divider(height: spLg),
          _buildSettingRow(
            "Sync Frequency",
            "How often to check for changes",
            Icons.schedule,
            GestureDetector(
              onTap: _showFrequencySelector,
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
                      _getFrequencyLabel(),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String title, String subtitle, IconData icon, Widget trailing) {
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

  Widget _buildSyncFolders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Sync Folders (${syncFolders.where((f) => f["enabled"] as bool).length}/${syncFolders.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _addSyncFolder,
              child: Text(
                "Add Folder",
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
        ...syncFolders.map((folder) => _buildSyncFolderItem(folder)).toList(),
      ],
    );
  }

  Widget _buildSyncFolderItem(Map<String, dynamic> folder) {
    bool isEnabled = folder["enabled"] as bool;
    Color statusColor = _getStatusColor(folder["status"] as String);
    
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getFolderIcon(folder["name"] as String),
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${folder["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${folder["path"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: (value) {
                  folder["enabled"] = value;
                  setState(() {});
                  _toggleFolderSync(folder, value);
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildFolderMetric(
                  "${folder["fileCount"]} files",
                  Icons.insert_drive_file,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildFolderMetric(
                  "${((folder["size"] as double)).toStringAsFixed(1)} MB",
                  Icons.storage,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${folder["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Last sync: ${DateTime.parse("${folder["lastSync"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (folder["status"] == "Error")
                GestureDetector(
                  onTap: () => _retrySync(folder),
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFolderMetric(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSyncActions() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Sync All Now",
            size: bs.md,
            icon: Icons.sync,
            onPressed: _syncAllNow,
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
                label: "Reset Settings",
                size: bs.sm,
                onPressed: _resetSettings,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Synced":
        return successColor;
      case "Syncing":
        return infoColor;
      case "Paused":
        return warningColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFolderIcon(String folderName) {
    switch (folderName.toLowerCase()) {
      case "documents":
        return Icons.description;
      case "photos":
        return Icons.photo;
      case "music":
        return Icons.music_note;
      case "videos":
        return Icons.video_library;
      case "downloads":
        return Icons.download;
      default:
        return Icons.folder;
    }
  }

  String _getLastSyncTime() {
    if (syncFolders.isEmpty) return "Never";
    
    DateTime? lastSync;
    for (var folder in syncFolders) {
      if (folder["enabled"] as bool) {
        DateTime folderSync = DateTime.parse("${folder["lastSync"]}");
        if (lastSync == null || folderSync.isAfter(lastSync)) {
          lastSync = folderSync;
        }
      }
    }
    
    if (lastSync == null) return "Never";
    
    Duration diff = DateTime.now().difference(lastSync);
    if (diff.inMinutes < 1) return "Just now";
    if (diff.inHours < 1) return "${diff.inMinutes}m ago";
    if (diff.inDays < 1) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  String _getFrequencyLabel() {
    return frequencyOptions
        .firstWhere((option) => option["value"] == syncFrequency)["label"] as String;
  }

  void _toggleSync(bool enabled) {
    if (enabled) {
      ss("Sync enabled");
    } else {
      sw("Sync disabled");
    }
  }

  void _toggleFolderSync(Map<String, dynamic> folder, bool enabled) {
    if (enabled) {
      ss("${folder["name"]} sync enabled");
    } else {
      sw("${folder["name"]} sync disabled");
    }
  }

  void _showFrequencySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sync Frequency",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...frequencyOptions.map((option) => ListTile(
              title: Text("${option["label"]}"),
              trailing: syncFrequency == option["value"] 
                  ? Icon(Icons.check, color: primaryColor) 
                  : null,
              onTap: () {
                syncFrequency = option["value"] as String;
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _syncAllNow() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("All folders synced successfully");
    });
  }

  void _pauseAllSync() async {
    bool isConfirmed = await confirm("Pause sync for all folders?");
    if (isConfirmed) {
      for (var folder in syncFolders) {
        folder["enabled"] = false;
      }
      setState(() {});
      sw("All sync operations paused");
    }
  }

  void _resetSettings() async {
    bool isConfirmed = await confirm("Reset all sync settings to default?");
    if (isConfirmed) {
      syncEnabled = true;
      autoSync = true;
      wifiOnly = false;
      syncFrequency = "15min";
      setState(() {});
      ss("Settings reset to default");
    }
  }

  void _retrySync(Map<String, dynamic> folder) {
    folder["status"] = "Syncing";
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      folder["status"] = "Synced";
      setState(() {});
      ss("${folder["name"]} synced successfully");
    });
  }

  void _addSyncFolder() {
    si("Feature coming soon - Add custom sync folders");
  }

  void _showSyncHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sync Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Auto Sync: Automatically detects and syncs file changes"),
            Text("• WiFi Only: Prevents data usage on mobile networks"),
            Text("• Sync Frequency: How often to check for new changes"),
            Text("• Folder Status: Shows current sync state of each folder"),
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

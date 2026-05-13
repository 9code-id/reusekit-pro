import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup5View extends StatefulWidget {
  @override
  State<GrlBackup5View> createState() => _GrlBackup5ViewState();
}

class _GrlBackup5ViewState extends State<GrlBackup5View> {
  bool isBackingUp = false;
  int backupProgress = 0;
  String currentBackupFile = "";
  
  List<Map<String, dynamic>> backupCategories = [
    {
      "name": "Photos & Videos",
      "icon": Icons.photo_library,
      "size": "1.2 GB",
      "items": 2847,
      "enabled": true,
      "lastBackup": DateTime.now().subtract(Duration(hours: 6)),
    },
    {
      "name": "Documents",
      "icon": Icons.description,
      "size": "456 MB",
      "items": 128,
      "enabled": true,
      "lastBackup": DateTime.now().subtract(Duration(hours: 12)),
    },
    {
      "name": "App Data",
      "icon": Icons.apps,
      "size": "324 MB",
      "items": 45,
      "enabled": true,
      "lastBackup": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "name": "Contacts",
      "icon": Icons.contacts,
      "size": "12 MB",
      "items": 247,
      "enabled": true,
      "lastBackup": DateTime.now().subtract(Duration(hours: 8)),
    },
    {
      "name": "Messages",
      "icon": Icons.message,
      "size": "89 MB",
      "items": 1523,
      "enabled": false,
      "lastBackup": DateTime.now().subtract(Duration(days: 7)),
    },
    {
      "name": "Settings",
      "icon": Icons.settings,
      "size": "5 MB",
      "items": 1,
      "enabled": true,
      "lastBackup": DateTime.now().subtract(Duration(hours: 4)),
    },
  ];

  List<Map<String, dynamic>> backupDevices = [
    {
      "name": "iPhone 14 Pro",
      "type": "mobile",
      "icon": Icons.phone_iphone,
      "status": "online",
      "lastSync": DateTime.now().subtract(Duration(minutes: 30)),
      "storage": "512 GB",
      "used": "287 GB",
    },
    {
      "name": "MacBook Air",
      "type": "laptop",
      "icon": Icons.laptop_mac,
      "status": "online",
      "lastSync": DateTime.now().subtract(Duration(hours: 2)),
      "storage": "1 TB",
      "used": "456 GB",
    },
    {
      "name": "iPad Pro",
      "type": "tablet",
      "icon": Icons.tablet_mac,
      "status": "offline",
      "lastSync": DateTime.now().subtract(Duration(days: 2)),
      "storage": "256 GB",
      "used": "123 GB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Device Backup"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: _syncAllDevices,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Progress (if backing up)
            if (isBackingUp) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.backup,
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
                                "Backup in Progress",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                currentBackupFile,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "$backupProgress%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    LinearProgressIndicator(
                      value: backupProgress / 100,
                      backgroundColor: primaryColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Device Overview
            Text(
              "Connected Devices",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QHorizontalScroll(
              children: backupDevices.map((device) => Container(
                width: 280,
                margin: EdgeInsets.only(right: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: device["status"] == "online"
                      ? Border.all(color: successColor.withAlpha(100))
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: device["status"] == "online" 
                                ? successColor.withAlpha(20) 
                                : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            device["icon"] as IconData,
                            color: device["status"] == "online" 
                                ? successColor 
                                : disabledBoldColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${device["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${device["type"]}".toUpperCase(),
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
                            color: device["status"] == "online" 
                                ? successColor.withAlpha(20) 
                                : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${device["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: device["status"] == "online" 
                                  ? successColor 
                                  : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          Icons.storage,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${device["used"]} / ${device["storage"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Last sync: ${_getRelativeTime(device["lastSync"] as DateTime)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: device["status"] == "online" ? "Backup Now" : "Reconnect",
                        size: bs.sm,
                        icon: device["status"] == "online" ? Icons.backup : Icons.refresh,
                        onPressed: device["status"] == "online" 
                            ? () => _backupDevice(device)
                            : () => _reconnectDevice(device),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Backup Categories
            Text(
              "Backup Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...backupCategories.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: category["enabled"] as bool
                    ? Border.all(color: primaryColor.withAlpha(100))
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: category["enabled"] as bool
                            ? primaryColor.withAlpha(20)
                            : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        category["icon"] as IconData,
                        color: category["enabled"] as bool
                            ? primaryColor
                            : disabledBoldColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: category["enabled"] as bool
                                  ? Colors.black
                                  : disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${category["items"]} items • ${category["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Last backup: ${_getRelativeTime(category["lastBackup"] as DateTime)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: category["enabled"] as bool,
                      onChanged: (value) {
                        category["enabled"] = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Backup Statistics
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
                    "Backup Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${_getTotalSize()}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Size",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${_getTotalItems()}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Items",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${backupCategories.where((c) => c["enabled"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Categories",
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
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: isBackingUp ? "Cancel Backup" : "Start Full Backup",
                    size: bs.md,
                    icon: isBackingUp ? Icons.cancel : Icons.backup,
                    onPressed: isBackingUp ? _cancelBackup : _startFullBackup,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Backup",
                    size: bs.md,
                    icon: Icons.schedule,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  String _getTotalSize() {
    // Calculate total size from enabled categories
    double totalMB = 0;
    for (var category in backupCategories) {
      if (category["enabled"] as bool) {
        String size = category["size"];
        if (size.contains("GB")) {
          totalMB += (double.tryParse(size.replaceAll(" GB", "")) ?? 0) * 1024;
        } else if (size.contains("MB")) {
          totalMB += double.tryParse(size.replaceAll(" MB", "")) ?? 0;
        }
      }
    }
    
    if (totalMB > 1024) {
      return "${(totalMB / 1024).toStringAsFixed(1)} GB";
    } else {
      return "${totalMB.toInt()} MB";
    }
  }

  int _getTotalItems() {
    return backupCategories
        .where((c) => c["enabled"] as bool)
        .fold(0, (sum, category) => sum + (category["items"] as int));
  }

  void _syncAllDevices() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // Update device sync times
    for (var device in backupDevices) {
      if (device["status"] == "online") {
        device["lastSync"] = DateTime.now();
      }
    }
    
    setState(() {});
    ss("All devices synced successfully!");
  }

  void _backupDevice(Map<String, dynamic> device) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    device["lastSync"] = DateTime.now();
    setState(() {});
    
    ss("${device["name"]} backup completed!");
  }

  void _reconnectDevice(Map<String, dynamic> device) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    device["status"] = "online";
    device["lastSync"] = DateTime.now();
    setState(() {});
    
    ss("${device["name"]} reconnected successfully!");
  }

  void _startFullBackup() async {
    isBackingUp = true;
    backupProgress = 0;
    setState(() {});
    
    List<String> files = [
      "Syncing photos...",
      "Backing up documents...",
      "Saving app data...",
      "Copying contacts...",
      "Archiving settings...",
      "Finalizing backup...",
    ];
    
    for (int i = 0; i < files.length; i++) {
      currentBackupFile = files[i];
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      
      backupProgress = ((i + 1) / files.length * 100).round();
      setState(() {});
    }
    
    isBackingUp = false;
    setState(() {});
    
    ss("Full backup completed successfully!");
  }

  void _cancelBackup() {
    isBackingUp = false;
    backupProgress = 0;
    currentBackupFile = "";
    setState(() {});
    
    sw("Backup cancelled");
  }
}

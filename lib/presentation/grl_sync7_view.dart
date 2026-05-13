import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync7View extends StatefulWidget {
  @override
  State<GrlSync7View> createState() => _GrlSync7ViewState();
}

class _GrlSync7ViewState extends State<GrlSync7View> {
  bool isLoading = false;
  String backupStatus = "success";
  String lastBackupTime = "2024-06-22 14:30:00";
  double backupProgress = 1.0;
  int totalFiles = 15420;
  int backedUpFiles = 15420;
  String backupSize = "2.8 GB";
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": 1,
      "date": "2024-06-22 14:30:00",
      "status": "success",
      "size": "2.8 GB",
      "files": 15420,
      "duration": "5m 30s",
      "type": "Auto Backup"
    },
    {
      "id": 2,
      "date": "2024-06-21 14:30:00",
      "status": "success",
      "size": "2.7 GB",
      "files": 15280,
      "duration": "5m 15s",
      "type": "Auto Backup"
    },
    {
      "id": 3,
      "date": "2024-06-20 19:45:00",
      "status": "partial",
      "size": "1.2 GB",
      "files": 8450,
      "duration": "3m 20s",
      "type": "Manual Backup"
    },
    {
      "id": 4,
      "date": "2024-06-20 14:30:00",
      "status": "failed",
      "size": "0 GB",
      "files": 0,
      "duration": "1m 10s",
      "type": "Auto Backup"
    },
    {
      "id": 5,
      "date": "2024-06-19 14:30:00",
      "status": "success",
      "size": "2.6 GB",
      "files": 14920,
      "duration": "4m 50s",
      "type": "Auto Backup"
    }
  ];

  List<Map<String, dynamic>> backupCategories = [
    {
      "name": "Documents",
      "icon": Icons.description,
      "files": 5420,
      "size": "850 MB",
      "enabled": true,
      "lastBackup": "2 hours ago"
    },
    {
      "name": "Photos",
      "icon": Icons.photo,
      "files": 3250,
      "size": "1.2 GB",
      "enabled": true,
      "lastBackup": "2 hours ago"
    },
    {
      "name": "Videos",
      "icon": Icons.videocam,
      "files": 120,
      "size": "650 MB",
      "enabled": false,
      "lastBackup": "Never"
    },
    {
      "name": "Contacts",
      "icon": Icons.contacts,
      "files": 342,
      "size": "2.1 MB",
      "enabled": true,
      "lastBackup": "2 hours ago"
    },
    {
      "name": "Settings",
      "icon": Icons.settings,
      "files": 156,
      "size": "1.5 MB",
      "enabled": true,
      "lastBackup": "2 hours ago"
    },
    {
      "name": "App Data",
      "icon": Icons.apps,
      "files": 6132,
      "size": "95 MB",
      "enabled": true,
      "lastBackup": "2 hours ago"
    }
  ];

  Future<void> _startBackup() async {
    isLoading = true;
    backupProgress = 0.0;
    setState(() {});
    
    // Simulate backup progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 300));
      backupProgress = i / 100.0;
      backedUpFiles = ((totalFiles * backupProgress).round());
      setState(() {});
    }
    
    backupStatus = "success";
    lastBackupTime = DateTime.now().toString();
    isLoading = false;
    setState(() {});
    
    ss("Backup completed successfully");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
        return successColor;
      case 'partial':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'success':
        return 'Completed';
      case 'partial':
        return 'Partial';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime lastBackup = DateTime.parse(lastBackupTime);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to backup settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Backup Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(backupStatus).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.backup,
                          color: _getStatusColor(backupStatus),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Backup Status",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last backup: ${lastBackup.dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(backupStatus),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusText(backupStatus),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isLoading) ...[
                    SizedBox(height: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Backing up files...",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(backupProgress * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: backupProgress,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                        Text(
                          "${backedUpFiles} of ${totalFiles} files",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Files",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${totalFiles.toString()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Size",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              backupSize,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Cloud",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Backup Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isLoading ? "Backing up..." : "Backup Now",
                          icon: Icons.backup,
                          size: bs.md,
                          onPressed: isLoading ? null : _startBackup,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Restore",
                          icon: Icons.restore,
                          size: bs.md,
                          onPressed: () {
                            // Navigate to restore
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Backup Categories
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Backup Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: backupCategories.map((category) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (category["enabled"] as bool) 
                              ? primaryColor.withAlpha(5)
                              : disabledColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: (category["enabled"] as bool) 
                                ? primaryColor.withAlpha(30)
                                : disabledColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    category["icon"] as IconData,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  (category["enabled"] as bool) 
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: (category["enabled"] as bool) 
                                      ? successColor
                                      : dangerColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            Text(
                              "${category["files"]} files • ${category["size"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Last backup: ${category["lastBackup"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Backup History
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Backup History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...backupHistory.map((backup) {
                    DateTime backupDate = DateTime.parse("${backup["date"]}");
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${backup["status"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getStatusColor("${backup["status"]}"),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${backup["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      backupDate.dMMMy,
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
                                  vertical: spXxs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${backup["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText("${backup["status"]}"),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.storage,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${backup["size"]} • ${backup["files"]} files",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${backup["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile8View extends StatefulWidget {
  @override
  State<GrlFile8View> createState() => _GrlFile8ViewState();
}

class _GrlFile8ViewState extends State<GrlFile8View> {
  bool autoBackup = true;
  bool wifiOnly = true;
  bool compressImages = false;
  bool deleteAfterBackup = false;
  String backupFrequency = "Daily";
  String storageLocation = "Cloud Storage";
  String maxFileSize = "100 MB";
  
  List<Map<String, dynamic>> frequencyItems = [
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> storageItems = [
    {"label": "Cloud Storage", "value": "Cloud Storage"},
    {"label": "External Drive", "value": "External Drive"},
    {"label": "Network Storage", "value": "Network Storage"},
    {"label": "Local Backup", "value": "Local Backup"},
  ];

  List<Map<String, dynamic>> sizeItems = [
    {"label": "50 MB", "value": "50 MB"},
    {"label": "100 MB", "value": "100 MB"},
    {"label": "500 MB", "value": "500 MB"},
    {"label": "1 GB", "value": "1 GB"},
    {"label": "No Limit", "value": "No Limit"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "date": "2024-06-22",
      "time": "08:30 AM",
      "files": 1247,
      "size": "2.4 GB",
      "status": "Success",
      "duration": "12 minutes",
    },
    {
      "date": "2024-06-21",
      "time": "08:30 AM",
      "files": 1240,
      "size": "2.3 GB",
      "status": "Success",
      "duration": "11 minutes",
    },
    {
      "date": "2024-06-20",
      "time": "08:30 AM",
      "files": 1235,
      "size": "2.3 GB",
      "status": "Failed",
      "duration": "5 minutes",
      "error": "Network connection lost",
    },
    {
      "date": "2024-06-19",
      "time": "08:30 AM",
      "files": 1232,
      "size": "2.2 GB",
      "status": "Success",
      "duration": "10 minutes",
    },
  ];

  List<Map<String, dynamic>> folderSettings = [
    {
      "name": "Documents",
      "path": "/Documents",
      "enabled": true,
      "size": "850 MB",
      "files": 245,
      "icon": Icons.description,
    },
    {
      "name": "Pictures",
      "path": "/Pictures",
      "enabled": true,
      "size": "1.2 GB",
      "files": 892,
      "icon": Icons.image,
    },
    {
      "name": "Videos",
      "path": "/Videos",
      "enabled": false,
      "size": "8.9 GB",
      "files": 34,
      "icon": Icons.video_file,
    },
    {
      "name": "Music",
      "path": "/Music",
      "enabled": true,
      "size": "2.1 GB",
      "files": 76,
      "icon": Icons.audio_file,
    },
    {
      "name": "Downloads",
      "path": "/Downloads",
      "enabled": false,
      "size": "3.4 GB",
      "files": 156,
      "icon": Icons.download,
    },
  ];

  bool isBackingUp = false;
  double backupProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
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
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
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
                        autoBackup ? Icons.cloud_done : Icons.cloud_off,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              autoBackup ? "Auto Backup Enabled" : "Auto Backup Disabled",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              autoBackup 
                                ? "Last backup: Today at 8:30 AM"
                                : "Enable backup to protect your files",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isBackingUp) ...[
                    SizedBox(height: spMd),
                    Text(
                      "Backing up... ${(backupProgress * 100).toInt()}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: backupProgress,
                      backgroundColor: Colors.white.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ],
              ),
            ),

            // Backup Settings
            Text(
              "Backup Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QSwitch(
              items: [
                {
                  "label": "Enable Auto Backup",
                  "value": true,
                  "checked": autoBackup,
                }
              ],
              value: [if (autoBackup) {"label": "Enable Auto Backup", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  autoBackup = values.isNotEmpty;
                });
              },
            ),

            if (autoBackup) ...[
              QDropdownField(
                label: "Backup Frequency",
                items: frequencyItems,
                value: backupFrequency,
                onChanged: (value, label) {
                  backupFrequency = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Storage Location",
                items: storageItems,
                value: storageLocation,
                onChanged: (value, label) {
                  storageLocation = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Max File Size",
                items: sizeItems,
                value: maxFileSize,
                onChanged: (value, label) {
                  maxFileSize = value;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Wi-Fi only",
                    "value": true,
                    "checked": wifiOnly,
                  }
                ],
                value: [if (wifiOnly) {"label": "Wi-Fi only", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setState(() {
                    wifiOnly = values.isNotEmpty;
                  });
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Compress images to save space",
                    "value": true,
                    "checked": compressImages,
                  }
                ],
                value: [if (compressImages) {"label": "Compress images to save space", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setState(() {
                    compressImages = values.isNotEmpty;
                  });
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Delete local files after backup",
                    "value": true,
                    "checked": deleteAfterBackup,
                  }
                ],
                value: [if (deleteAfterBackup) {"label": "Delete local files after backup", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setState(() {
                    deleteAfterBackup = values.isNotEmpty;
                  });
                },
              ),
            ],

            // Folder Selection
            Text(
              "Folders to Backup",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: folderSettings.map((folder) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (folder["enabled"] as bool ? primaryColor : disabledColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          folder["icon"] as IconData,
                          color: folder["enabled"] as bool ? primaryColor : disabledColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${folder["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${folder["path"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${folder["files"]} files • ${folder["size"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: folder["enabled"] as bool,
                        onChanged: (value) {
                          folder["enabled"] = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Manual Backup Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isBackingUp ? "Backing up..." : "Start Manual Backup",
                size: bs.md,
                onPressed: isBackingUp ? null : () {
                  isBackingUp = true;
                  backupProgress = 0.0;
                  setState(() {});
                  _simulateBackup();
                },
              ),
            ),

            // Backup History
            Text(
              "Backup History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: backupHistory.map((backup) {
                final isSuccess = backup["status"] == "Success";
                final statusColor = isSuccess ? Colors.green : Colors.red;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isSuccess ? Icons.check_circle : Icons.error,
                          color: statusColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${DateTime.parse(backup["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${backup["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${backup["files"]} files • ${backup["size"]} • ${backup["duration"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (!isSuccess && backup["error"] != null) ...[
                              SizedBox(height: spXs),
                              Text(
                                "${backup["error"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // View All History Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All History",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateBackup() {
    if (backupProgress < 1.0) {
      Future.delayed(Duration(milliseconds: 300), () {
        backupProgress += 0.15;
        if (backupProgress > 1.0) backupProgress = 1.0;
        setState(() {});
        
        if (backupProgress < 1.0) {
          _simulateBackup();
        } else {
          Future.delayed(Duration(seconds: 1), () {
            isBackingUp = false;
            setState(() {});
            ss("Backup completed successfully!");
          });
        }
      });
    }
  }
}

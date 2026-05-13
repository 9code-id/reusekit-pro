import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload5View extends StatefulWidget {
  @override
  State<GrlUpload5View> createState() => _GrlUpload5ViewState();
}

class _GrlUpload5ViewState extends State<GrlUpload5View> {
  String selectedCloud = "google_drive";
  String syncFrequency = "daily";
  bool autoSync = true;
  bool compressFiles = true;
  bool deleteAfterSync = false;
  String encryptionLevel = "standard";
  
  List<Map<String, dynamic>> cloudServices = [
    {"label": "Google Drive", "value": "google_drive"},
    {"label": "Dropbox", "value": "dropbox"},
    {"label": "OneDrive", "value": "onedrive"},
    {"label": "iCloud", "value": "icloud"},
    {"label": "Amazon S3", "value": "s3"},
  ];

  List<Map<String, dynamic>> syncFrequencyItems = [
    {"label": "Real-time", "value": "realtime"},
    {"label": "Every Hour", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Manual", "value": "manual"},
  ];

  List<Map<String, dynamic>> encryptionItems = [
    {"label": "None", "value": "none"},
    {"label": "Standard", "value": "standard"},
    {"label": "High", "value": "high"},
    {"label": "Military Grade", "value": "military"},
  ];

  List<Map<String, dynamic>> syncedFolders = [
    {
      "name": "Documents",
      "path": "/Documents",
      "size": "2.4 GB",
      "files": 1247,
      "lastSync": "2 minutes ago",
      "status": "synced",
      "icon": Icons.folder
    },
    {
      "name": "Photos",
      "path": "/Photos",
      "size": "15.7 GB",
      "files": 3829,
      "lastSync": "5 minutes ago",
      "status": "syncing",
      "icon": Icons.photo_library
    },
    {
      "name": "Projects",
      "path": "/Work/Projects",
      "size": "8.2 GB",
      "files": 892,
      "lastSync": "1 hour ago",
      "status": "synced",
      "icon": Icons.work
    },
    {
      "name": "Backup",
      "path": "/Backup",
      "size": "45.1 GB",
      "files": 156,
      "lastSync": "3 hours ago",
      "status": "error",
      "icon": Icons.backup
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Sync"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
            // Sync Status Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_done,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Cloud Storage Sync",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "ACTIVE",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "71.4 GB",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Synced",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "6,124",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Files Synced",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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

            // Cloud Service Selection
            Text(
              "Cloud Service",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Select Cloud Provider",
                    items: cloudServices,
                    value: selectedCloud,
                    onChanged: (value, label) {
                      selectedCloud = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Connected",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "john.doe@gmail.com",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Change",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sync Settings
            Text(
              "Sync Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Sync Frequency",
                    items: syncFrequencyItems,
                    value: syncFrequency,
                    onChanged: (value, label) {
                      syncFrequency = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Encryption Level",
                    items: encryptionItems,
                    value: encryptionLevel,
                    onChanged: (value, label) {
                      encryptionLevel = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Auto Sync",
                              "value": true,
                              "checked": autoSync,
                            }
                          ],
                          value: [
                            if (autoSync)
                              {
                                "label": "Auto Sync",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            autoSync = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Compress Files",
                              "value": true,
                              "checked": compressFiles,
                            }
                          ],
                          value: [
                            if (compressFiles)
                              {
                                "label": "Compress Files",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            compressFiles = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Delete After Sync",
                              "value": true,
                              "checked": deleteAfterSync,
                            }
                          ],
                          value: [
                            if (deleteAfterSync)
                              {
                                "label": "Delete After Sync",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            deleteAfterSync = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Synced Folders
            Text(
              "Synced Folders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...syncedFolders.map((folder) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getFolderStatusColor(folder["status"]).withAlpha(50),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          folder["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getFolderStatusColor(folder["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${folder["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${folder["size"]} • ${folder["files"]} files",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "Last sync: ${folder["lastSync"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (folder["status"] == "syncing") ...[
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ],
              ),
            )),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Folder",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Sync Now",
                    size: bs.md,
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

  Color _getFolderStatusColor(String status) {
    switch (status) {
      case "synced":
        return successColor;
      case "syncing":
        return primaryColor;
      case "error":
        return dangerColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}

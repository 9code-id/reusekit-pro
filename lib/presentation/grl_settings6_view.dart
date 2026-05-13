import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings6View extends StatefulWidget {
  @override
  State<GrlSettings6View> createState() => _GrlSettings6ViewState();
}

class _GrlSettings6ViewState extends State<GrlSettings6View> {
  bool autoBackup = true;
  bool cloudSync = true;
  bool wifiOnlyBackup = true;
  String backupFrequency = "Daily";
  String storageLocation = "Google Drive";
  double storageUsed = 2.4; // GB
  double storageTotal = 15.0; // GB
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Real-time", "value": "Real-time"},
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];
  
  List<Map<String, dynamic>> storageOptions = [
    {"label": "Google Drive", "value": "Google Drive"},
    {"label": "iCloud", "value": "iCloud"},
    {"label": "Dropbox", "value": "Dropbox"},
    {"label": "OneDrive", "value": "OneDrive"},
    {"label": "Local Storage", "value": "Local Storage"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "date": "Today, 3:45 PM",
      "type": "Automatic",
      "size": "45.2 MB",
      "status": "Success",
      "duration": "1m 23s",
      "items": 1247
    },
    {
      "date": "Yesterday, 3:45 PM",
      "type": "Automatic",
      "size": "42.8 MB",
      "status": "Success",
      "duration": "1m 15s",
      "items": 1235
    },
    {
      "date": "Dec 19, 3:45 PM",
      "type": "Manual",
      "size": "38.5 MB",
      "status": "Success",
      "duration": "58s",
      "items": 1198
    },
    {
      "date": "Dec 18, 3:45 PM",
      "type": "Automatic",
      "size": "41.2 MB",
      "status": "Failed",
      "duration": "N/A",
      "items": 0
    },
    {
      "date": "Dec 17, 3:45 PM",
      "type": "Automatic",
      "size": "39.7 MB",
      "status": "Success",
      "duration": "1m 02s",
      "items": 1189
    },
  ];

  List<Map<String, dynamic>> dataCategories = [
    {
      "name": "User Profile",
      "description": "Personal information and preferences",
      "size": "2.1 MB",
      "lastBackup": "3 hours ago",
      "icon": Icons.person,
      "enabled": true,
      "encrypted": true
    },
    {
      "name": "Messages",
      "description": "Chat history and conversations",
      "size": "126.5 MB",
      "lastBackup": "3 hours ago",
      "icon": Icons.message,
      "enabled": true,
      "encrypted": true
    },
    {
      "name": "Media Files",
      "description": "Photos, videos and documents",
      "size": "1.8 GB",
      "lastBackup": "3 hours ago",
      "icon": Icons.photo_library,
      "enabled": true,
      "encrypted": false
    },
    {
      "name": "App Settings",
      "description": "Configuration and preferences",
      "size": "0.8 MB",
      "lastBackup": "3 hours ago",
      "icon": Icons.settings,
      "enabled": true,
      "encrypted": true
    },
    {
      "name": "Contacts",
      "description": "Address book and contact information",
      "size": "5.2 MB",
      "lastBackup": "3 hours ago",
      "icon": Icons.contacts,
      "enabled": false,
      "encrypted": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Storage"),
        actions: [
          QButton(
            icon: Icons.backup,
            size: bs.sm,
            onPressed: () {
              _performManualBackup();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Storage Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cloud Storage",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${storageUsed.toStringAsFixed(1)} GB of ${storageTotal.toStringAsFixed(0)} GB used",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: LinearProgressIndicator(
                      value: storageUsed / storageTotal,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${((storageUsed / storageTotal) * 100).toStringAsFixed(1)}% used",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${(storageTotal - storageUsed).toStringAsFixed(1)} GB available",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Backup Settings
            Container(
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
                        Icons.backup,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Backup Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildBackupToggle(
                    Icons.cloud_upload,
                    "Automatic Backup",
                    "Automatically backup your data",
                    autoBackup,
                    (value) {
                      autoBackup = value;
                      setState(() {});
                      if (value) {
                        ss("Automatic backup enabled");
                      } else {
                        sw("Automatic backup disabled");
                      }
                    },
                  ),
                  
                  if (autoBackup) ...[
                    Divider(height: spLg),
                    
                    _buildBackupToggle(
                      Icons.sync,
                      "Cloud Sync",
                      "Sync data across all devices",
                      cloudSync,
                      (value) {
                        cloudSync = value;
                        setState(() {});
                      },
                    ),
                    
                    Divider(height: spLg),
                    
                    _buildBackupToggle(
                      Icons.wifi,
                      "WiFi Only",
                      "Only backup when connected to WiFi",
                      wifiOnlyBackup,
                      (value) {
                        wifiOnlyBackup = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Backup Configuration
            if (autoBackup) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Backup Configuration",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Backup Frequency",
                      items: frequencyOptions,
                      value: backupFrequency,
                      onChanged: (value, label) {
                        backupFrequency = value;
                        setState(() {});
                        si("Backup frequency changed to ${label}");
                      },
                    ),
                    
                    QDropdownField(
                      label: "Storage Location",
                      items: storageOptions,
                      value: storageLocation,
                      onChanged: (value, label) {
                        storageLocation = value;
                        setState(() {});
                        si("Storage location changed to ${label}");
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Data Categories
            Container(
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
                        Icons.folder,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "What to Backup",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Select All",
                        size: bs.sm,
                        onPressed: () {
                          for (var category in dataCategories) {
                            category["enabled"] = true;
                          }
                          setState(() {});
                          ss("All categories selected for backup");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...dataCategories.map((category) => _buildDataCategory(category)),
                ],
              ),
            ),

            // Recent Backups
            Container(
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
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Backup History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("Full backup history coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...backupHistory.take(3).map((backup) => _buildBackupHistoryItem(backup)),
                ],
              ),
            ),

            // Storage Management
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
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
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildStorageOption(
                    Icons.delete_sweep,
                    "Clear Old Backups",
                    "Remove backups older than 30 days",
                    () async {
                      bool isConfirmed = await confirm("Delete old backups? This action cannot be undone.");
                      if (isConfirmed) {
                        ss("Old backups cleared successfully");
                      }
                    },
                  ),
                  
                  _buildStorageOption(
                    Icons.compress,
                    "Optimize Storage",
                    "Compress backups to save space",
                    () {
                      si("Storage optimization feature coming soon");
                    },
                  ),
                  
                  _buildStorageOption(
                    Icons.cloud_download,
                    "Download Backup",
                    "Download a local copy of your backup",
                    () {
                      si("Backup download feature coming soon");
                    },
                  ),
                  
                  _buildStorageOption(
                    Icons.upgrade,
                    "Upgrade Storage",
                    "Get more cloud storage space",
                    () {
                      si("Storage upgrade coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Backup Now",
                    size: bs.md,
                    onPressed: () {
                      _performManualBackup();
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Restore from Backup",
                    size: bs.md,
                    onPressed: () {
                      si("Restore feature coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Backup Settings",
                    size: bs.md,
                    onPressed: () {
                      si("Settings export feature coming soon");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
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
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDataCategory(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              category["icon"],
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
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    if (category["encrypted"])
                      Icon(
                        Icons.lock,
                        color: successColor,
                        size: 14,
                      ),
                  ],
                ),
                Text(
                  "${category["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${category["size"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " • Last backup: ${category["lastBackup"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Switch(
            value: category["enabled"],
            onChanged: (value) {
              category["enabled"] = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    Color statusColor = primaryColor;
    IconData statusIcon = Icons.check_circle;
    
    if (backup["status"] == "Success") {
      statusColor = successColor;
      statusIcon = Icons.check_circle;
    } else if (backup["status"] == "Failed") {
      statusColor = dangerColor;
      statusIcon = Icons.error;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 16,
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
                      "${backup["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${backup["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${backup["size"]} • ${backup["items"]} items • ${backup["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("Backup options coming soon");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStorageOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
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

  void _performManualBackup() {
    showLoading();
    
    // Simulate backup process
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Manual backup completed successfully");
      
      // Add to backup history
      backupHistory.insert(0, {
        "date": "Now",
        "type": "Manual",
        "size": "47.3 MB",
        "status": "Success",
        "duration": "1m 35s",
        "items": 1251
      });
      setState(() {});
    });
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup1View extends StatefulWidget {
  @override
  State<GrlBackup1View> createState() => _GrlBackup1ViewState();
}

class _GrlBackup1ViewState extends State<GrlBackup1View> {
  String selectedBackupType = "cloud";
  String cloudProvider = "google_drive";
  String backupFrequency = "daily";
  bool autoBackup = true;
  bool includeMedia = true;
  bool includeSettings = true;
  bool includeMessages = true;
  bool encryptBackup = true;
  String backupPassword = "";
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "BKP-001",
      "date": "2024-06-22 08:30",
      "type": "Automatic",
      "size": "2.4 GB",
      "status": "completed",
      "location": "Google Drive",
      "duration": "3m 42s",
    },
    {
      "id": "BKP-002", 
      "date": "2024-06-21 08:30",
      "type": "Automatic",
      "size": "2.3 GB",
      "status": "completed",
      "location": "Google Drive",
      "duration": "3m 18s",
    },
    {
      "id": "BKP-003",
      "date": "2024-06-20 14:15",
      "type": "Manual",
      "size": "2.2 GB",
      "status": "completed",
      "location": "Local Storage",
      "duration": "2m 56s",
    },
    {
      "id": "BKP-004",
      "date": "2024-06-19 08:30",
      "type": "Automatic",
      "size": "2.1 GB",
      "status": "failed",
      "location": "Google Drive",
      "duration": "0s",
      "error": "Insufficient storage space",
    },
  ];

  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "google_drive", "icon": Icons.cloud},
    {"label": "iCloud", "value": "icloud", "icon": Icons.cloud},
    {"label": "Dropbox", "value": "dropbox", "icon": Icons.cloud},
    {"label": "OneDrive", "value": "onedrive", "icon": Icons.cloud},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Manual Only", "value": "manual"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo(BackupSettingsView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
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
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.backup,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Backup",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "Today at 8:30 AM",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "2.4 GB • Google Drive",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "✓ Auto backup enabled • Next backup: Tomorrow 8:30 AM",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.backup,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Backup Now",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Start",
                          size: bs.sm,
                          onPressed: () async {
                            await _performBackup();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.restore,
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Restore",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Browse",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(RestoreView());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Backup Settings
            Text(
              "Backup Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Backup Type
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
                    "Backup Location",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedBackupType = "cloud";
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: selectedBackupType == "cloud" 
                                  ? primaryColor.withAlpha(20) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: selectedBackupType == "cloud" 
                                    ? primaryColor 
                                    : disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud,
                                  color: selectedBackupType == "cloud" 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Cloud",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selectedBackupType == "cloud" 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedBackupType = "local";
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: selectedBackupType == "local" 
                                  ? primaryColor.withAlpha(20) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: selectedBackupType == "local" 
                                    ? primaryColor 
                                    : disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.storage,
                                  color: selectedBackupType == "local" 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Local",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selectedBackupType == "local" 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Cloud Provider (if cloud selected)
            if (selectedBackupType == "cloud") ...[
              QDropdownField(
                label: "Cloud Provider",
                items: cloudProviders,
                value: cloudProvider,
                onChanged: (value, label) {
                  cloudProvider = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
            ],
            
            // Backup Frequency
            QDropdownField(
              label: "Backup Frequency",
              items: frequencyOptions,
              value: backupFrequency,
              onChanged: (value, label) {
                backupFrequency = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Backup Options
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
                    "Backup Options",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Auto Backup",
                        "value": "auto",
                        "checked": autoBackup,
                      },
                      {
                        "label": "Include Media Files",
                        "value": "media",
                        "checked": includeMedia,
                      },
                      {
                        "label": "Include App Settings",
                        "value": "settings",
                        "checked": includeSettings,
                      },
                      {
                        "label": "Include Messages",
                        "value": "messages",
                        "checked": includeMessages,
                      },
                      {
                        "label": "Encrypt Backup",
                        "value": "encrypt",
                        "checked": encryptBackup,
                      },
                    ],
                    value: [
                      if (autoBackup) {"label": "Auto Backup", "value": "auto", "checked": true},
                      if (includeMedia) {"label": "Include Media Files", "value": "media", "checked": true},
                      if (includeSettings) {"label": "Include App Settings", "value": "settings", "checked": true},
                      if (includeMessages) {"label": "Include Messages", "value": "messages", "checked": true},
                      if (encryptBackup) {"label": "Encrypt Backup", "value": "encrypt", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      autoBackup = values.any((v) => v["value"] == "auto");
                      includeMedia = values.any((v) => v["value"] == "media");
                      includeSettings = values.any((v) => v["value"] == "settings");
                      includeMessages = values.any((v) => v["value"] == "messages");
                      encryptBackup = values.any((v) => v["value"] == "encrypt");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            if (encryptBackup) ...[
              SizedBox(height: spMd),
              
              QTextField(
                label: "Backup Password",
                value: backupPassword,
                hint: "Enter encryption password",
                obscureText: true,
                onChanged: (value) {
                  backupPassword = value;
                  setState(() {});
                },
              ),
            ],
            
            SizedBox(height: spLg),
            
            // Backup History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Backups",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(BackupHistoryView());
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            ...backupHistory.take(3).map((backup) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getBackupStatusColor(backup["status"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getBackupStatusColor(backup["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getBackupStatusIcon(backup["status"]),
                        color: _getBackupStatusColor(backup["status"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${backup["id"]} • ${backup["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${backup["date"]} • ${backup["size"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (backup["error"] != null) ...[
                            SizedBox(height: spXs),
                            Text(
                              "${backup["error"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getBackupStatusColor(backup["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            backup["status"].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getBackupStatusColor(backup["status"]),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${backup["location"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
            
            SizedBox(height: spLg),
            
            // Storage Usage
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
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Storage Usage",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Used: 12.8 GB",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Available: 2.2 GB",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "85% Full",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackupStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      case "in_progress":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getBackupStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "failed":
        return Icons.error;
      case "in_progress":
        return Icons.hourglass_empty;
      default:
        return Icons.backup;
    }
  }

  Future<void> _performBackup() async {
    showLoading();
    
    // Simulate backup process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Backup completed successfully!");
    
    // Add new backup to history
    backupHistory.insert(0, {
      "id": "BKP-${(backupHistory.length + 1).toString().padLeft(3, '0')}",
      "date": DateTime.now().toString().substring(0, 16),
      "type": "Manual",
      "size": "2.5 GB",
      "status": "completed",
      "location": selectedBackupType == "cloud" ? cloudProvider.replaceAll("_", " ").toUpperCase() : "Local Storage",
      "duration": "4m 12s",
    });
    
    setState(() {});
  }
}

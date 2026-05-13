import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBackupRestoreView extends StatefulWidget {
  const FwaBackupRestoreView({super.key});

  @override
  State<FwaBackupRestoreView> createState() => _FwaBackupRestoreViewState();
}

class _FwaBackupRestoreViewState extends State<FwaBackupRestoreView> {
  bool autoBackupEnabled = true;
  String lastBackupDate = "2024-12-10 14:30:00";
  String backupFrequency = "daily";
  bool includeMedia = true;
  bool includeSettings = true;
  bool includeUserData = true;
  bool cloudBackupEnabled = false;
  String selectedCloudProvider = "google_drive";
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "date": "2024-12-10 14:30:00",
      "size": "2.5 GB",
      "status": "completed",
      "type": "auto",
      "location": "Local Storage"
    },
    {
      "date": "2024-12-09 14:30:00", 
      "size": "2.4 GB",
      "status": "completed",
      "type": "auto",
      "location": "Local Storage"
    },
    {
      "date": "2024-12-08 14:30:00",
      "size": "2.3 GB", 
      "status": "completed",
      "type": "manual",
      "location": "Google Drive"
    },
    {
      "date": "2024-12-07 14:30:00",
      "size": "2.2 GB",
      "status": "failed",
      "type": "auto",
      "location": "Local Storage"
    }
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Manual Only", "value": "manual"}
  ];

  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "google_drive"},
    {"label": "iCloud", "value": "icloud"},
    {"label": "OneDrive", "value": "onedrive"},
    {"label": "Dropbox", "value": "dropbox"}
  ];

  void _createBackup() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Backup created successfully");
    
    // Add new backup to history
    backupHistory.insert(0, {
      "date": DateTime.now().toString().substring(0, 19),
      "size": "2.6 GB",
      "status": "completed", 
      "type": "manual",
      "location": cloudBackupEnabled ? "Cloud Storage" : "Local Storage"
    });
    setState(() {});
  }

  void _restoreFromBackup(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("Are you sure you want to restore from this backup? Current data will be replaced.");
    if (!isConfirmed) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    ss("Data restored successfully from backup");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      case "in_progress":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icon(Icons.check_circle, color: successColor, size: 20);
      case "failed":
        return Icon(Icons.error, color: dangerColor, size: 20);
      case "in_progress":
        return Icon(Icons.hourglass_empty, color: warningColor, size: 20);
      default:
        return Icon(Icons.help, color: disabledColor, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              si("Backup includes all app data, settings, and media files");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          label: "Create Backup",
                          icon: Icons.backup,
                          onPressed: _createBackup,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Import Backup",
                          icon: Icons.file_upload,
                          onPressed: () {
                            si("File picker will open here");
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Last backup: ${DateTime.parse(lastBackupDate).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Backup Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Auto Backup",
                        "value": true,
                        "checked": autoBackupEnabled,
                      }
                    ],
                    value: [
                      if (autoBackupEnabled)
                        {"label": "Enable Auto Backup", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      autoBackupEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (autoBackupEnabled) ...[
                    QDropdownField(
                      label: "Backup Frequency",
                      items: frequencyOptions,
                      value: backupFrequency,
                      onChanged: (value, label) {
                        backupFrequency = value;
                        setState(() {});
                      },
                    ),
                  ],
                  Text(
                    "Include in Backup",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "User Data",
                        "value": "user_data",
                        "checked": includeUserData,
                      },
                      {
                        "label": "App Settings",
                        "value": "settings",
                        "checked": includeSettings,
                      },
                      {
                        "label": "Media Files",
                        "value": "media",
                        "checked": includeMedia,
                      }
                    ],
                    value: [
                      if (includeUserData)
                        {"label": "User Data", "value": "user_data", "checked": true},
                      if (includeSettings)
                        {"label": "App Settings", "value": "settings", "checked": true},
                      if (includeMedia)
                        {"label": "Media Files", "value": "media", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      includeUserData = values.any((v) => v["value"] == "user_data");
                      includeSettings = values.any((v) => v["value"] == "settings");
                      includeMedia = values.any((v) => v["value"] == "media");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Cloud Backup Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cloud Backup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Cloud Backup",
                        "value": true,
                        "checked": cloudBackupEnabled,
                      }
                    ],
                    value: [
                      if (cloudBackupEnabled)
                        {"label": "Enable Cloud Backup", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      cloudBackupEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (cloudBackupEnabled) ...[
                    QDropdownField(
                      label: "Cloud Provider",
                      items: cloudProviders,
                      value: selectedCloudProvider,
                      onChanged: (value, label) {
                        selectedCloudProvider = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.cloud, color: warningColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Cloud backups are encrypted and stored securely",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Backup History
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                        label: "Clear History",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Clear all backup history records?");
                          if (isConfirmed) {
                            backupHistory.clear();
                            setState(() {});
                            ss("Backup history cleared");
                          }
                        },
                      ),
                    ],
                  ),
                  if (backupHistory.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      alignment: Alignment.center,
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(Icons.history, size: 48, color: disabledColor),
                          Text(
                            "No backup history",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...backupHistory.map((backup) {
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
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${backup["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: _getStatusIcon("${backup["status"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${DateTime.parse("${backup["date"]}").dMMMy}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: backup["type"] == "auto" 
                                              ? infoColor.withAlpha(20) 
                                              : warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${backup["type"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: backup["type"] == "auto" 
                                                ? infoColor 
                                                : warningColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${backup["size"]} • ${backup["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (backup["status"] == "completed") ...[
                              SizedBox(width: spSm),
                              QButton(
                                label: "Restore",
                                size: bs.sm,
                                onPressed: () => _restoreFromBackup(backup),
                              ),
                            ],
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

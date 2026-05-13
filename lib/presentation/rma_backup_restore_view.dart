import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaBackupRestoreView extends StatefulWidget {
  const RmaBackupRestoreView({super.key});

  @override
  State<RmaBackupRestoreView> createState() => _RmaBackupRestoreViewState();
}

class _RmaBackupRestoreViewState extends State<RmaBackupRestoreView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  String backupTime = "02:00 AM";
  bool includeImages = true;
  bool includeReports = true;
  bool includeSettings = true;
  String cloudProvider = "google_drive";
  double storageUsed = 2.4; // GB
  double storageLimit = 15.0; // GB
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "backup_001",
      "date": "2024-01-15",
      "time": "02:15 AM",
      "size": "145 MB",
      "status": "completed",
      "type": "automatic",
    },
    {
      "id": "backup_002", 
      "date": "2024-01-14",
      "time": "02:12 AM",
      "size": "138 MB",
      "status": "completed",
      "type": "automatic",
    },
    {
      "id": "backup_003",
      "date": "2024-01-13",
      "time": "10:30 AM",
      "size": "142 MB", 
      "status": "completed",
      "type": "manual",
    },
    {
      "id": "backup_004",
      "date": "2024-01-12",
      "time": "02:08 AM",
      "size": "135 MB",
      "status": "failed",
      "type": "automatic",
    },
    {
      "id": "backup_005",
      "date": "2024-01-11",
      "time": "02:05 AM",
      "size": "140 MB",
      "status": "completed",
      "type": "automatic",
    },
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "12:00 AM", "value": "00:00 AM"},
    {"label": "01:00 AM", "value": "01:00 AM"},
    {"label": "02:00 AM", "value": "02:00 AM"},
    {"label": "03:00 AM", "value": "03:00 AM"},
  ];

  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "google_drive"},
    {"label": "iCloud", "value": "icloud"},
    {"label": "OneDrive", "value": "onedrive"},
    {"label": "Dropbox", "value": "dropbox"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              _performManualBackup();
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
            // Storage Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cloud, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Cloud Storage",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${storageUsed.toStringAsFixed(1)} GB used of ${storageLimit.toStringAsFixed(0)} GB",
                    style: TextStyle(color: Colors.white.withAlpha(230)),
                  ),
                  SizedBox(height: spSm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: LinearProgressIndicator(
                      value: storageUsed / storageLimit,
                      backgroundColor: Colors.white.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${((storageLimit - storageUsed)).toStringAsFixed(1)} GB available",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Backup Now",
                    icon: Icons.backup,
                    size: bs.md,
                    onPressed: () {
                      _performManualBackup();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Restore Data",
                    icon: Icons.restore,
                    color: successColor,
                    size: bs.md,
                    onPressed: () {
                      _showRestoreDialog();
                    },
                  ),
                ),
              ],
            ),

            // Backup Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Automatic Backup",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Switch(
                        value: autoBackupEnabled,
                        onChanged: (value) {
                          autoBackupEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
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
                    QDropdownField(
                      label: "Backup Time",
                      items: timeOptions,
                      value: backupTime,
                      onChanged: (value, label) {
                        backupTime = value;
                        setState(() {});
                      },
                    ),
                  ],
                  QDropdownField(
                    label: "Cloud Provider",
                    items: cloudProviders,
                    value: cloudProvider,
                    onChanged: (value, label) {
                      cloudProvider = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Backup Content
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "What to Backup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.image, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Images & Documents", style: TextStyle(fontSize: 16)),
                            Text("Photos, PDFs, and attachments", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Switch(
                        value: includeImages,
                        onChanged: (value) {
                          includeImages = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.analytics, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Reports & Analytics", style: TextStyle(fontSize: 16)),
                            Text("Generated reports and data analytics", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Switch(
                        value: includeReports,
                        onChanged: (value) {
                          includeReports = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Settings & Preferences", style: TextStyle(fontSize: 16)),
                            Text("App settings and user preferences", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Switch(
                        value: includeSettings,
                        onChanged: (value) {
                          includeSettings = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Backup History
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Text(
                        "Backup History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          si("Refreshing backup history...");
                        },
                        child: Icon(Icons.refresh, color: primaryColor),
                      ),
                    ],
                  ),
                  Divider(),
                  ...backupHistory.map((backup) => _buildBackupHistoryItem(backup)),
                ],
              ),
            ),

            // Export/Import Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Advanced Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Divider(),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          icon: Icons.file_download,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            si("Exporting data to local storage...");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Import Data",
                          icon: Icons.file_upload,
                          color: warningColor,
                          size: bs.sm,
                          onPressed: () {
                            si("Select file to import...");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Factory Reset",
                          icon: Icons.restore_page,
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () {
                            _showFactoryResetDialog();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Manage Storage",
                          icon: Icons.storage,
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening storage management...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    Color statusColor = backup["status"] == "completed" 
        ? successColor 
        : backup["status"] == "failed" 
            ? dangerColor 
            : warningColor;

    IconData statusIcon = backup["status"] == "completed"
        ? Icons.check_circle
        : backup["status"] == "failed"
            ? Icons.error
            : Icons.schedule;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${backup["date"]} at ${backup["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: backup["type"] == "manual" ? primaryColor : disabledBoldColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${backup["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Size: ${backup["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (backup["status"] == "completed")
                      GestureDetector(
                        onTap: () {
                          _showRestoreConfirmation(backup);
                        },
                        child: Text(
                          "Restore",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _performManualBackup() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Manual backup completed successfully");
      // Add new backup to history
      setState(() {
        backupHistory.insert(0, {
          "id": "backup_${DateTime.now().millisecondsSinceEpoch}",
          "date": DateTime.now().toString().split(' ')[0],
          "time": TimeOfDay.now().format(context),
          "size": "148 MB",
          "status": "completed",
          "type": "manual",
        });
      });
    });
  }

  void _showRestoreDialog() {
    // Show restore dialog implementation
    si("Select a backup to restore from history");
  }

  void _showRestoreConfirmation(Map<String, dynamic> backup) {
    // Show restore confirmation dialog
    si("Restore from backup ${backup["date"]}?");
  }

  void _showFactoryResetDialog() {
    // Show factory reset confirmation
    sw("Factory reset will delete all data permanently!");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshDataBackupView extends StatefulWidget {
  const CshDataBackupView({super.key});

  @override
  State<CshDataBackupView> createState() => _CshDataBackupViewState();
}

class _CshDataBackupViewState extends State<CshDataBackupView> {
  bool autoBackup = true;
  bool cloudSync = true;
  bool encryptBackups = true;
  bool compressBackups = false;
  bool retainOldBackups = true;
  String backupFrequency = "Daily";
  String backupTime = "02:00 AM";
  String cloudProvider = "AWS S3";
  String retentionPeriod = "30 days";
  String encryptionLevel = "AES-256";
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Every 6 hours", "value": "Every 6 hours"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];
  
  List<Map<String, dynamic>> timeOptions = [
    {"label": "12:00 AM", "value": "00:00 AM"},
    {"label": "02:00 AM", "value": "02:00 AM"},
    {"label": "04:00 AM", "value": "04:00 AM"},
    {"label": "06:00 AM", "value": "06:00 AM"},
  ];
  
  List<Map<String, dynamic>> cloudProviderOptions = [
    {"label": "AWS S3", "value": "AWS S3"},
    {"label": "Google Cloud Storage", "value": "Google Cloud Storage"},
    {"label": "Azure Blob Storage", "value": "Azure Blob Storage"},
    {"label": "Dropbox", "value": "Dropbox"},
  ];
  
  List<Map<String, dynamic>> retentionOptions = [
    {"label": "7 days", "value": "7 days"},
    {"label": "30 days", "value": "30 days"},
    {"label": "90 days", "value": "90 days"},
    {"label": "1 year", "value": "1 year"},
    {"label": "Forever", "value": "Forever"},
  ];
  
  List<Map<String, dynamic>> encryptionOptions = [
    {"label": "AES-128", "value": "AES-128"},
    {"label": "AES-256", "value": "AES-256"},
    {"label": "RSA-2048", "value": "RSA-2048"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "date": "2024-01-15",
      "time": "02:00 AM",
      "size": "2.4 GB",
      "type": "Automatic",
      "status": "Completed",
      "duration": "12 minutes",
      "location": "AWS S3"
    },
    {
      "date": "2024-01-14",
      "time": "02:00 AM",
      "size": "2.3 GB",
      "type": "Automatic",
      "status": "Completed",
      "duration": "11 minutes",
      "location": "AWS S3"
    },
    {
      "date": "2024-01-13",
      "time": "10:30 AM",
      "size": "2.3 GB",
      "type": "Manual",
      "status": "Completed",
      "duration": "15 minutes",
      "location": "Local Storage"
    },
    {
      "date": "2024-01-13",
      "time": "02:00 AM",
      "size": "2.2 GB",
      "type": "Automatic",
      "status": "Failed",
      "duration": "5 minutes",
      "location": "AWS S3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Backup"),
        actions: [
          IconButton(
            onPressed: () {
              _refreshBackupStatus();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Backup Status Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Backup Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(100)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Last backup: Jan 15, 2024 at 02:00 AM",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spLg,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Backups",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "147",
                              style: TextStyle(
                                fontSize: 24,
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
                              "Total Size",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "342.8 GB",
                              style: TextStyle(
                                fontSize: 24,
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
                              "Success Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "98.6%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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

            // Automatic Backup Settings Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Automatic Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Auto Backup",
                    items: [
                      {
                        "label": "Enable automatic backups",
                        "value": true,
                        "checked": autoBackup,
                      }
                    ],
                    value: [if (autoBackup) {"label": "Enable automatic backups", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoBackup = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
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
              ),
            ),

            // Cloud Sync Settings Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Cloud Storage Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Cloud Sync",
                    items: [
                      {
                        "label": "Sync backups to cloud storage",
                        "value": true,
                        "checked": cloudSync,
                      }
                    ],
                    value: [if (cloudSync) {"label": "Sync backups to cloud storage", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      cloudSync = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Cloud Provider",
                    items: cloudProviderOptions,
                    value: cloudProvider,
                    onChanged: (value, label) {
                      cloudProvider = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Backup Security Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Backup Security",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Encrypt Backups",
                    items: [
                      {
                        "label": "Enable backup encryption",
                        "value": true,
                        "checked": encryptBackups,
                      }
                    ],
                    value: [if (encryptBackups) {"label": "Enable backup encryption", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      encryptBackups = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Encryption Level",
                    items: encryptionOptions,
                    value: encryptionLevel,
                    onChanged: (value, label) {
                      encryptionLevel = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Compress Backups",
                    items: [
                      {
                        "label": "Compress backups to save space",
                        "value": true,
                        "checked": compressBackups,
                      }
                    ],
                    value: [if (compressBackups) {"label": "Compress backups to save space", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      compressBackups = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Retention Policy Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Retention Policy",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Retain Old Backups",
                    items: [
                      {
                        "label": "Keep historical backup versions",
                        "value": true,
                        "checked": retainOldBackups,
                      }
                    ],
                    value: [if (retainOldBackups) {"label": "Keep historical backup versions", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      retainOldBackups = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Retention Period",
                    items: retentionOptions,
                    value: retentionPeriod,
                    onChanged: (value, label) {
                      retentionPeriod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Backup History Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                        "Recent Backup History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _viewFullHistory();
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(backupHistory.length, (index) {
                    final backup = backupHistory[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (backup["status"] == "Completed") ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (backup["status"] == "Completed") ? successColor.withAlpha(100) : dangerColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            (backup["status"] == "Completed") ? Icons.check_circle : Icons.error,
                            color: (backup["status"] == "Completed") ? successColor : dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${backup["date"]} at ${backup["time"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
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
                                  "${backup["size"]} • ${backup["duration"]} • ${backup["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (backup["status"] == "Completed")
                            GestureDetector(
                              onTap: () {
                                _restoreBackup(backup);
                              },
                              child: Icon(
                                Icons.restore,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Backup Now",
                          icon: Icons.backup,
                          size: bs.md,
                          onPressed: () {
                            _createBackupNow();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Restore Data",
                          icon: Icons.restore,
                          size: bs.md,
                          onPressed: () {
                            _showRestoreOptions();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Backup Settings",
                      icon: Icons.save,
                      size: bs.md,
                      onPressed: () {
                        _saveBackupSettings();
                      },
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

  void _refreshBackupStatus() {
    ss("Backup status refreshed");
  }

  void _createBackupNow() async {
    bool isConfirmed = await confirm("Create a manual backup now?");
    if (isConfirmed) {
      ss("Manual backup initiated");
    }
  }

  void _showRestoreOptions() {
    ss("Restore options dialog opened");
  }

  void _restoreBackup(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("Restore data from backup on ${backup["date"]}?");
    if (isConfirmed) {
      ss("Data restore initiated");
    }
  }

  void _viewFullHistory() {
    ss("Full backup history opened");
  }

  void _saveBackupSettings() {
    ss("Backup settings saved successfully");
  }
}

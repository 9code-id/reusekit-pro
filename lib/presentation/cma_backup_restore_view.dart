import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaBackupRestoreView extends StatefulWidget {
  const CmaBackupRestoreView({super.key});

  @override
  State<CmaBackupRestoreView> createState() => _CmaBackupRestoreViewState();
}

class _CmaBackupRestoreViewState extends State<CmaBackupRestoreView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "weekly";
  String backupLocation = "cloud";
  bool includeUserData = true;
  bool includeVehicleData = true;
  bool includeSettings = true;
  bool includeTripHistory = false;
  bool includeMaintenanceRecords = true;
  String cloudProvider = "google_drive";
  String selectedBackupFile = "";
  bool isBackingUp = false;
  bool isRestoring = false;
  double backupProgress = 0.0;
  double restoreProgress = 0.0;

  final List<Map<String, dynamic>> backupHistory = [
    {
      "id": "1",
      "name": "Full Backup - 2024-01-15",
      "type": "full",
      "size": "156.2 MB",
      "date": "2024-01-15 14:30:00",
      "location": "Google Drive",
      "status": "completed",
      "includes": ["User Data", "Vehicle Data", "Settings", "Maintenance Records"],
    },
    {
      "id": "2",
      "name": "Settings Backup - 2024-01-12",
      "type": "partial",
      "size": "2.4 MB",
      "date": "2024-01-12 09:15:00",
      "location": "Local Storage",
      "status": "completed",
      "includes": ["Settings", "User Preferences"],
    },
    {
      "id": "3",
      "name": "Vehicle Data Backup - 2024-01-10",
      "type": "partial",
      "size": "89.1 MB",
      "date": "2024-01-10 16:45:00",
      "location": "iCloud",
      "status": "completed",
      "includes": ["Vehicle Data", "Trip History"],
    },
    {
      "id": "4",
      "name": "Emergency Backup - 2024-01-08",
      "type": "full",
      "size": "142.8 MB",
      "date": "2024-01-08 11:20:00",
      "location": "Google Drive",
      "status": "failed",
      "includes": ["User Data", "Vehicle Data", "Settings"],
    },
  ];

  final List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Manual Only", "value": "manual"},
  ];

  final List<Map<String, dynamic>> locationOptions = [
    {"label": "Cloud Storage", "value": "cloud"},
    {"label": "Local Device", "value": "local"},
    {"label": "External Storage", "value": "external"},
  ];

  final List<Map<String, dynamic>> cloudProviderOptions = [
    {"label": "Google Drive", "value": "google_drive"},
    {"label": "iCloud", "value": "icloud"},
    {"label": "Dropbox", "value": "dropbox"},
    {"label": "OneDrive", "value": "onedrive"},
  ];

  void _startBackup() async {
    setState(() {
      isBackingUp = true;
      backupProgress = 0.0;
    });

    // Simulate backup progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        backupProgress = i / 100;
      });
    }

    setState(() {
      isBackingUp = false;
      backupProgress = 0.0;
    });

    ss("Backup completed successfully");
  }

  void _startRestore(String backupId) async {
    setState(() {
      isRestoring = true;
      restoreProgress = 0.0;
      selectedBackupFile = backupId;
    });

    // Simulate restore progress
    for (int i = 0; i <= 100; i += 8) {
      await Future.delayed(Duration(milliseconds: 250));
      setState(() {
        restoreProgress = i / 100;
      });
    }

    setState(() {
      isRestoring = false;
      restoreProgress = 0.0;
      selectedBackupFile = "";
    });

    ss("Data restored successfully");
  }

  void _deleteBackup(String backupId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this backup? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        backupHistory.removeWhere((backup) => backup["id"] == backupId);
      });
      ss("Backup deleted successfully");
    }
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
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "full":
        return Icons.backup;
      case "partial":
        return Icons.backup_table;
      default:
        return Icons.file_copy;
    }
  }

  String _calculateTotalBackupSize() {
    double totalSize = 0.0;
    for (var backup in backupHistory) {
      if (backup["status"] == "completed") {
        String sizeStr = backup["size"].toString().replaceAll(" MB", "");
        totalSize += double.tryParse(sizeStr) ?? 0.0;
      }
    }
    return "${totalSize.toStringAsFixed(1)} MB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Backup & Restore helps you save and recover your data safely");
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
            // Backup Status Section
            Container(
              width: double.infinity,
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
                      Icon(Icons.cloud_upload, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Backup Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 32),
                              SizedBox(height: spXs),
                              Text(
                                "Last Backup",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Jan 15, 2:30 PM",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.storage, color: infoColor, size: 32),
                              SizedBox(height: spXs),
                              Text(
                                "Total Size",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                _calculateTotalBackupSize(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  if (isBackingUp) ...[
                    SizedBox(height: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Backing up...",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
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
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: backupProgress,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Auto Backup Settings
            Container(
              width: double.infinity,
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
                    "Auto Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable Auto Backup",
                              "value": true,
                              "checked": autoBackupEnabled,
                            }
                          ],
                          value: [
                            if (autoBackupEnabled)
                              {
                                "label": "Enable Auto Backup",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            autoBackupEnabled = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
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
                      label: "Backup Location",
                      items: locationOptions,
                      value: backupLocation,
                      onChanged: (value, label) {
                        backupLocation = value;
                        setState(() {});
                      },
                    ),
                    
                    if (backupLocation == "cloud") ...[
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
                  ],
                ],
              ),
            ),

            // Backup Content Selection
            Container(
              width: double.infinity,
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
                    "What to Include in Backup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "User Profile & Settings",
                              "value": true,
                              "checked": includeUserData,
                            }
                          ],
                          value: [
                            if (includeUserData)
                              {
                                "label": "User Profile & Settings",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeUserData = values.isNotEmpty;
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
                              "label": "Vehicle Data & Diagnostics",
                              "value": true,
                              "checked": includeVehicleData,
                            }
                          ],
                          value: [
                            if (includeVehicleData)
                              {
                                "label": "Vehicle Data & Diagnostics",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeVehicleData = values.isNotEmpty;
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
                              "label": "App Settings & Preferences",
                              "value": true,
                              "checked": includeSettings,
                            }
                          ],
                          value: [
                            if (includeSettings)
                              {
                                "label": "App Settings & Preferences",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeSettings = values.isNotEmpty;
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
                              "label": "Trip History & Analytics",
                              "value": true,
                              "checked": includeTripHistory,
                            }
                          ],
                          value: [
                            if (includeTripHistory)
                              {
                                "label": "Trip History & Analytics",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeTripHistory = values.isNotEmpty;
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
                              "label": "Maintenance Records",
                              "value": true,
                              "checked": includeMaintenanceRecords,
                            }
                          ],
                          value: [
                            if (includeMaintenanceRecords)
                              {
                                "label": "Maintenance Records",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeMaintenanceRecords = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Manual Backup Section
            Container(
              width: double.infinity,
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
                    "Manual Backup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "Create a backup now with your current settings and selected data.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: isBackingUp ? "Backing Up..." : "Create Backup",
                          size: bs.md,
                          onPressed: isBackingUp ? null : _startBackup,
                        ),
                      ),
                      QButton(
                        icon: Icons.schedule,
                        size: bs.md,
                        onPressed: () {
                          si("Backup scheduled for next available time");
                        },
                      ),
                    ],
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
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Backup History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${backupHistory.length} backups",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...backupHistory.map((backup) {
                    bool isSelected = selectedBackupFile == backup["id"];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(20) 
                            : Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getTypeIcon(backup["type"]),
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${backup["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(backup["status"]).withAlpha(40),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${backup["status"].toString().toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(backup["status"]),
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
                              SizedBox(width: spSm),
                              Text(
                                "Location: ${backup["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "Date: ${backup["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          Wrap(
                            spacing: spXs,
                            children: (backup["includes"] as List).map((item) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          if (isRestoring && isSelected) ...[
                            SizedBox(height: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Restoring...",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(restoreProgress * 100).toInt()}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: restoreProgress,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                              ],
                            ),
                          ],
                          
                          if (!isRestoring && backup["status"] == "completed") ...[
                            SizedBox(height: spSm),
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Restore",
                                    size: bs.sm,
                                    onPressed: () => _startRestore(backup["id"]),
                                  ),
                                ),
                                QButton(
                                  icon: Icons.download,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Backup file downloaded");
                                  },
                                ),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _deleteBackup(backup["id"]),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Emergency Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "These actions will permanently delete data and cannot be undone.",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                    ),
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset All Data",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Are you sure you want to reset all data? This will delete everything and cannot be undone.");
                            if (isConfirmed) {
                              se("All data has been reset");
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Clear Backups",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Are you sure you want to delete all backup files? This cannot be undone.");
                            if (isConfirmed) {
                              setState(() {
                                backupHistory.clear();
                              });
                              ss("All backups cleared");
                            }
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
}

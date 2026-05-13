import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaBackupRestoreView extends StatefulWidget {
  const HcaBackupRestoreView({super.key});

  @override
  State<HcaBackupRestoreView> createState() => _HcaBackupRestoreViewState();
}

class _HcaBackupRestoreViewState extends State<HcaBackupRestoreView> {
  int currentTab = 0;
  
  // Backup state
  bool isBackupInProgress = false;
  String backupStatus = "";
  
  // Restore state
  bool isRestoreInProgress = false;
  String restoreStatus = "";
  
  // Settings
  bool autoBackup = true;
  String backupFrequency = "weekly";
  bool includeHealthData = true;
  bool includeAppointments = true;
  bool includeMedications = true;
  bool includeNotes = true;
  bool includeLabs = true;
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "1",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "size": "25.4 MB",
      "type": "Automatic",
      "status": "Completed",
      "data_types": ["Health Data", "Appointments", "Medications", "Notes"]
    },
    {
      "id": "2",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "size": "23.8 MB",
      "type": "Automatic",
      "status": "Completed",
      "data_types": ["Health Data", "Appointments", "Medications"]
    },
    {
      "id": "3",
      "date": DateTime.now().subtract(Duration(days: 14)),
      "size": "24.1 MB",
      "type": "Manual",
      "status": "Completed",
      "data_types": ["Health Data", "Appointments", "Medications", "Notes", "Labs"]
    },
    {
      "id": "4",
      "date": DateTime.now().subtract(Duration(days: 30)),
      "size": "22.7 MB",
      "type": "Automatic",
      "status": "Failed",
      "data_types": ["Health Data", "Appointments"]
    },
  ];
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Backup & Restore",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Backup", icon: Icon(Icons.backup)),
        Tab(text: "Restore", icon: Icon(Icons.restore)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildBackupTab(),
        _buildRestoreTab(),
        _buildSettingsTab(),
      ],
    );
  }
  
  Widget _buildBackupTab() {
    return SingleChildScrollView(
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      color: primaryColor,
                      size: 24,
                    ),
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
                Text(
                  isBackupInProgress ? "Backup in progress..." : "Last backup: Yesterday, 11:30 PM",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (isBackupInProgress) ...[
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    backupStatus,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Quick Actions
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
              spacing: spMd,
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
                        label: "Backup Now",
                        size: bs.md,
                        onPressed: isBackupInProgress ? null : _performBackup,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Schedule Backup",
                        size: bs.md,
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                          });
                        },
                      ),
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
              spacing: spMd,
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
                        // Clear history
                      },
                      child: Text(
                        "Clear History",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                ...backupHistory.map((backup) => _buildBackupHistoryItem(backup)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRestoreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Restore Status Card
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
                    Icon(
                      Icons.cloud_download,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Restore Data",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  isRestoreInProgress ? "Restore in progress..." : "Select a backup to restore your data",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (isRestoreInProgress) ...[
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    restoreStatus,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Warning Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: warningColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Important Notice",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Restoring data will overwrite your current data. Make sure to backup your current data before restoring.",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Available Backups
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
              spacing: spMd,
              children: [
                Text(
                  "Available Backups",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...backupHistory.where((backup) => backup["status"] == "Completed").map((backup) => _buildRestoreItem(backup)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
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
              spacing: spMd,
              children: [
                Text(
                  "Automatic Backup",
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
                            "label": "Enable automatic backup",
                            "value": true,
                            "checked": autoBackup,
                          }
                        ],
                        value: [
                          if (autoBackup)
                            {
                              "label": "Enable automatic backup",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          setState(() {
                            autoBackup = values.isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (autoBackup) ...[
                  QDropdownField(
                    label: "Backup Frequency",
                    items: frequencyOptions,
                    value: backupFrequency,
                    onChanged: (value, label) {
                      setState(() {
                        backupFrequency = value;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
          
          // Data Selection
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
              spacing: spMd,
              children: [
                Text(
                  "Data to Include",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Health Data",
                      "value": "health_data",
                      "checked": includeHealthData,
                    },
                    {
                      "label": "Appointments",
                      "value": "appointments",
                      "checked": includeAppointments,
                    },
                    {
                      "label": "Medications",
                      "value": "medications",
                      "checked": includeMedications,
                    },
                    {
                      "label": "Notes",
                      "value": "notes",
                      "checked": includeNotes,
                    },
                    {
                      "label": "Lab Results",
                      "value": "labs",
                      "checked": includeLabs,
                    },
                  ],
                  value: [
                    if (includeHealthData)
                      {"label": "Health Data", "value": "health_data", "checked": true},
                    if (includeAppointments)
                      {"label": "Appointments", "value": "appointments", "checked": true},
                    if (includeMedications)
                      {"label": "Medications", "value": "medications", "checked": true},
                    if (includeNotes)
                      {"label": "Notes", "value": "notes", "checked": true},
                    if (includeLabs)
                      {"label": "Lab Results", "value": "labs", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      includeHealthData = values.any((v) => v["value"] == "health_data");
                      includeAppointments = values.any((v) => v["value"] == "appointments");
                      includeMedications = values.any((v) => v["value"] == "medications");
                      includeNotes = values.any((v) => v["value"] == "notes");
                      includeLabs = values.any((v) => v["value"] == "labs");
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Storage Info
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
              spacing: spMd,
              children: [
                Text(
                  "Storage Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Used Storage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "127.3 MB",
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
                            "Available Storage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "4.87 GB",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: 0.025,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
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
                backup["status"] == "Completed" ? Icons.check_circle : Icons.error,
                color: backup["status"] == "Completed" ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${(backup["date"] as DateTime).dMMMy} • ${backup["size"]}",
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
                  color: backup["type"] == "Automatic" ? infoColor : primaryColor,
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
          Text(
            "${(backup["data_types"] as List).join(", ")}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRestoreItem(Map<String, dynamic> backup) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${(backup["date"] as DateTime).dMMMy} • ${backup["size"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(backup["data_types"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Restore",
            size: bs.sm,
            onPressed: isRestoreInProgress ? null : () => _performRestore(backup),
          ),
        ],
      ),
    );
  }
  
  void _performBackup() async {
    setState(() {
      isBackupInProgress = true;
      backupStatus = "Preparing backup...";
    });
    
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      backupStatus = "Backing up health data...";
    });
    
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      backupStatus = "Backing up appointments...";
    });
    
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      backupStatus = "Finalizing backup...";
    });
    
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isBackupInProgress = false;
      backupStatus = "";
    });
    
    // Add new backup to history
    backupHistory.insert(0, {
      "id": "${DateTime.now().millisecondsSinceEpoch}",
      "date": DateTime.now(),
      "size": "25.8 MB",
      "type": "Manual",
      "status": "Completed",
      "data_types": ["Health Data", "Appointments", "Medications", "Notes", "Labs"]
    });
    
    ss("Backup completed successfully!");
  }
  
  void _performRestore(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("Are you sure you want to restore this backup? This will overwrite your current data.");
    
    if (!isConfirmed) return;
    
    setState(() {
      isRestoreInProgress = true;
      restoreStatus = "Preparing restore...";
    });
    
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      restoreStatus = "Restoring health data...";
    });
    
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      restoreStatus = "Restoring appointments...";
    });
    
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      restoreStatus = "Finalizing restore...";
    });
    
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isRestoreInProgress = false;
      restoreStatus = "";
    });
    
    ss("Data restored successfully!");
  }
}

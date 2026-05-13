import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmBackupRestoreView extends StatefulWidget {
  const TpmBackupRestoreView({super.key});

  @override
  State<TpmBackupRestoreView> createState() => _TpmBackupRestoreViewState();
}

class _TpmBackupRestoreViewState extends State<TpmBackupRestoreView> {
  int currentTab = 0;
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  String backupRetention = "30";
  bool includeFiles = true;
  bool includeDatabase = true;
  bool includeConfigurations = true;
  bool encryptBackups = true;
  String selectedRestorePoint = "";
  
  List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "7 days", "value": "7"},
    {"label": "30 days", "value": "30"},
    {"label": "90 days", "value": "90"},
    {"label": "1 year", "value": "365"},
    {"label": "Forever", "value": "0"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "backup_20250619_143000",
      "timestamp": "2025-06-19 14:30:00",
      "type": "Automatic",
      "size": 2.5,
      "status": "Completed",
      "duration": "5m 32s",
      "includes": ["Database", "Files", "Configurations"],
    },
    {
      "id": "backup_20250618_143000",
      "timestamp": "2025-06-18 14:30:00",
      "type": "Automatic",
      "size": 2.4,
      "status": "Completed",
      "duration": "5m 18s",
      "includes": ["Database", "Files", "Configurations"],
    },
    {
      "id": "backup_20250618_100000",
      "timestamp": "2025-06-18 10:00:00",
      "type": "Manual",
      "size": 2.4,
      "status": "Completed",
      "duration": "4m 55s",
      "includes": ["Database", "Files"],
    },
    {
      "id": "backup_20250617_143000",
      "timestamp": "2025-06-17 14:30:00",
      "type": "Automatic",
      "size": 2.3,
      "status": "Failed",
      "duration": "2m 15s",
      "includes": ["Database", "Files", "Configurations"],
      "error": "Insufficient storage space",
    },
    {
      "id": "backup_20250616_143000",
      "timestamp": "2025-06-16 14:30:00",
      "type": "Automatic",
      "size": 2.2,
      "status": "Completed",
      "duration": "5m 45s",
      "includes": ["Database", "Files", "Configurations"],
    },
  ];

  Map<String, dynamic> backupStats = {
    "totalBackups": 47,
    "successfulBackups": 45,
    "failedBackups": 2,
    "totalSize": 112.8,
    "lastBackup": "2025-06-19 14:30:00",
    "nextBackup": "2025-06-20 14:30:00",
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Backup & Restore",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Backup", icon: Icon(Icons.backup)),
        Tab(text: "Restore", icon: Icon(Icons.restore)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildBackupTab(),
        _buildRestoreTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildBackupTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBackupStatsCard(),
          _buildBackupSettingsCard(),
          _buildManualBackupCard(),
          _buildBackupContentCard(),
        ],
      ),
    );
  }

  Widget _buildBackupStatsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Backup Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildWhiteStatCard("Total Backups", "${backupStats["totalBackups"]}", Icons.backup),
              _buildWhiteStatCard("Successful", "${backupStats["successfulBackups"]}", Icons.check_circle),
              _buildWhiteStatCard("Failed", "${backupStats["failedBackups"]}", Icons.error),
              _buildWhiteStatCard("Total Size", "${((backupStats["totalSize"] as num).toDouble()).toStringAsFixed(1)} GB", Icons.storage),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: Colors.white.withAlpha(180),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Last backup: ${DateTime.parse(backupStats["lastBackup"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(180),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: Colors.white.withAlpha(180),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Next backup: ${DateTime.parse(backupStats["nextBackup"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(180),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white.withAlpha(180),
                size: 20,
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupSettingsCard() {
    return Container(
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
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Automatic Backup Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable automatic backups",
                "value": true,
                "checked": autoBackupEnabled,
              }
            ],
            value: [if (autoBackupEnabled) {"label": "Enable automatic backups", "value": true, "checked": true}],
            onChanged: (values, ids) {
              autoBackupEnabled = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (autoBackupEnabled) ...[
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Backup Frequency",
                    items: backupFrequencyOptions,
                    value: backupFrequency,
                    onChanged: (value, label) {
                      backupFrequency = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Retention Period",
                    items: retentionOptions,
                    value: backupRetention,
                    onChanged: (value, label) {
                      backupRetention = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Encrypt backups",
                "value": true,
                "checked": encryptBackups,
              }
            ],
            value: [if (encryptBackups) {"label": "Encrypt backups", "value": true, "checked": true}],
            onChanged: (values, ids) {
              encryptBackups = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Backup Settings",
              size: bs.sm,
              onPressed: () {
                ss("Backup settings saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualBackupCard() {
    return Container(
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
                Icons.backup,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Manual Backup",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Create an immediate backup of your data. This will not affect your automatic backup schedule.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Backup Now",
              size: bs.md,
              onPressed: () async {
                bool isConfirmed = await confirm("Start manual backup now? This may take several minutes.");
                if (isConfirmed) {
                  showLoading();
                  // Simulate backup process
                  await Future.delayed(Duration(seconds: 3));
                  hideLoading();
                  ss("Manual backup completed successfully");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupContentCard() {
    return Container(
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
            "Backup Content",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select what to include in your backups:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Database (Projects, Tasks, Users)",
                "value": true,
                "checked": includeDatabase,
              }
            ],
            value: [if (includeDatabase) {"label": "Database (Projects, Tasks, Users)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeDatabase = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Files & Attachments",
                "value": true,
                "checked": includeFiles,
              }
            ],
            value: [if (includeFiles) {"label": "Files & Attachments", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeFiles = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "System Configurations",
                "value": true,
                "checked": includeConfigurations,
              }
            ],
            value: [if (includeConfigurations) {"label": "System Configurations", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeConfigurations = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRestoreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRestoreWarningCard(),
          _buildRestorePointsCard(),
        ],
      ),
    );
  }

  Widget _buildRestoreWarningCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
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
                "Important Warning",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "Restoring from a backup will replace all current data with the data from the selected backup point. This action cannot be undone.",
            style: TextStyle(
              fontSize: 12,
              color: warningColor,
            ),
          ),
          Text(
            "We strongly recommend creating a manual backup before proceeding with any restore operation.",
            style: TextStyle(
              fontSize: 12,
              color: warningColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestorePointsCard() {
    return Container(
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
            "Available Restore Points",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select a backup to restore from:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...backupHistory.where((backup) => backup["status"] == "Completed").map((backup) => _buildRestorePointCard(backup)),
          if (selectedRestorePoint.isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Restore from Selected Backup",
                size: bs.md,
                onPressed: () async {
                  bool isConfirmed = await confirm("Are you sure you want to restore from this backup? This will replace all current data and cannot be undone.");
                  if (isConfirmed) {
                    showLoading();
                    // Simulate restore process
                    await Future.delayed(Duration(seconds: 5));
                    hideLoading();
                    ss("System restored successfully from backup $selectedRestorePoint");
                    selectedRestorePoint = "";
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRestorePointCard(Map<String, dynamic> backup) {
    bool isSelected = selectedRestorePoint == backup["id"];
    
    return GestureDetector(
      onTap: () {
        selectedRestorePoint = isSelected ? "" : backup["id"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
          color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(
                  backup["type"] == "Automatic" ? Icons.schedule : Icons.backup,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${DateTime.parse(backup["timestamp"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: backup["type"] == "Automatic" ? infoColor.withAlpha(20) : successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${backup["type"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: backup["type"] == "Automatic" ? infoColor : successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Size: ${((backup["size"] as num).toDouble()).toStringAsFixed(1)} GB",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(" • ", style: TextStyle(color: disabledBoldColor)),
                Text(
                  "Duration: ${backup["duration"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Text(
              "Includes: ${(backup["includes"] as List).join(", ")}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBackupHistoryCard(),
        ],
      ),
    );
  }

  Widget _buildBackupHistoryCard() {
    return Container(
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
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  si("Refreshing backup history...");
                },
              ),
            ],
          ),
          ...backupHistory.map((backup) => _buildHistoryCard(backup)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> backup) {
    Color statusColor = backup["status"] == "Completed" ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                backup["type"] == "Automatic" ? Icons.schedule : Icons.backup,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${backup["id"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${backup["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Type: ${backup["type"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(" • ", style: TextStyle(color: disabledBoldColor)),
              Text(
                "Size: ${((backup["size"] as num).toDouble()).toStringAsFixed(1)} GB",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(" • ", style: TextStyle(color: disabledBoldColor)),
              Text(
                "Duration: ${backup["duration"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${DateTime.parse(backup["timestamp"]).dMMMy}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          if (backup["error"] != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Error: ${backup["error"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (backup["status"] == "Completed") ...[
            Row(
              children: [
                Expanded(child: SizedBox()),
                QButton(
                  label: "Download",
                  size: bs.sm,
                  onPressed: () {
                    si("Downloading backup ${backup["id"]}...");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  label: "Delete",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Delete this backup? This action cannot be undone.");
                    if (isConfirmed) {
                      backupHistory.removeWhere((b) => b["id"] == backup["id"]);
                      setState(() {});
                      ss("Backup deleted successfully");
                    }
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

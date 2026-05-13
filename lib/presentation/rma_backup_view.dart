import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaBackupView extends StatefulWidget {
  const RmaBackupView({super.key});

  @override
  State<RmaBackupView> createState() => _RmaBackupViewState();
}

class _RmaBackupViewState extends State<RmaBackupView> {
  bool autoBackup = true;
  bool cloudBackup = false;
  String backupFrequency = "daily";
  String lastBackupDate = "2024-06-15";
  bool isBackingUp = false;
  double backupProgress = 0.0;

  List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Manual Only", "value": "manual"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "backup1",
      "date": "2024-06-15",
      "time": "14:30",
      "type": "Automatic",
      "size": "2.4 GB",
      "status": "Completed",
      "items": 1250,
    },
    {
      "id": "backup2",
      "date": "2024-06-14",
      "time": "14:30",
      "type": "Automatic",
      "size": "2.3 GB",
      "status": "Completed",
      "items": 1198,
    },
    {
      "id": "backup3",
      "date": "2024-06-13",
      "time": "09:15",
      "type": "Manual",
      "size": "2.3 GB",
      "status": "Completed",
      "items": 1195,
    },
    {
      "id": "backup4",
      "date": "2024-06-12",
      "time": "14:30",
      "type": "Automatic",
      "size": "2.2 GB",
      "status": "Failed",
      "items": 0,
    },
    {
      "id": "backup5",
      "date": "2024-06-11",
      "time": "14:30",
      "type": "Automatic",
      "size": "2.2 GB",
      "status": "Completed",
      "items": 1156,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.backup,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Backup & Restore",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Keep your real estate data safe and secure",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      _buildStatCard("2.4 GB", "Last Backup", Icons.cloud_upload),
                      SizedBox(width: spMd),
                      _buildStatCard("1,250", "Items Backed Up", Icons.inventory),
                      SizedBox(width: spMd),
                      _buildStatCard("98%", "Success Rate", Icons.check_circle),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _startBackup(),
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.backup,
                            color: successColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Backup Now",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Create manual backup",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
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
                    onTap: () => _showRestoreDialog(),
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: infoColor.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restore,
                            color: infoColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Restore Data",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Restore from backup",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Backup Progress (if backing up)
            if (isBackingUp) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.backup,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Backup in Progress",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Creating backup of your data...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(backupProgress * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    LinearProgressIndicator(
                      value: backupProgress,
                      backgroundColor: warningColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation(warningColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
            ],

            // Backup Settings
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
                children: [
                  Text(
                    "Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Auto Backup Toggle
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Automatic Backup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Enable scheduled automatic backups",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoBackup,
                        onChanged: (value) {
                          autoBackup = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Cloud Backup Toggle
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cloud Backup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Store backups in cloud storage",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: cloudBackup,
                        onChanged: (value) {
                          cloudBackup = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Backup Frequency
                  QDropdownField(
                    label: "Backup Frequency",
                    items: backupFrequencyOptions,
                    value: backupFrequency,
                    onChanged: (value, label) {
                      backupFrequency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Backup History
            Text(
              "Backup History",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Column(
              children: backupHistory.map((backup) => _buildBackupHistoryCard(backup)).toList(),
            ),

            SizedBox(height: spLg),

            // Storage Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Storage Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStorageInfo("Local Storage", "8.2 GB", "15.6 GB", 0.52),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: _buildStorageInfo("Cloud Storage", "12.4 GB", "50.0 GB", 0.25),
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

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(200),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupHistoryCard(Map<String, dynamic> backup) {
    Color statusColor = backup["status"] == "Completed" 
        ? successColor 
        : backup["status"] == "Failed" 
            ? dangerColor 
            : warningColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              backup["status"] == "Completed" 
                  ? Icons.check_circle 
                  : backup["status"] == "Failed" 
                      ? Icons.error 
                      : Icons.hourglass_empty,
              color: statusColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${backup["date"]} at ${backup["time"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${backup["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${backup["type"]} • ${backup["size"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (backup["status"] == "Completed") ...[
                      Text(
                        " • ${backup["items"]} items",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_vert,
            color: disabledBoldColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo(String title, String used, String total, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: infoColor,
          ),
        ),
        SizedBox(height: spSm),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: infoColor.withAlpha(50),
          valueColor: AlwaysStoppedAnimation(infoColor),
        ),
        SizedBox(height: spSm),
        Text(
          "$used / $total used",
          style: TextStyle(
            fontSize: 12,
            color: infoColor,
          ),
        ),
      ],
    );
  }

  void _startBackup() {
    isBackingUp = true;
    backupProgress = 0.0;
    setState(() {});

    // Simulate backup progress
    for (int i = 0; i <= 100; i++) {
      Future.delayed(Duration(milliseconds: i * 30), () {
        if (mounted) {
          backupProgress = i / 100;
          setState(() {});
          
          if (i == 100) {
            isBackingUp = false;
            ss("Backup completed successfully");
            setState(() {});
          }
        }
      });
    }
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Restore Data"),
        content: Text("Select a backup to restore from:"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Restore initiated");
            },
            child: Text("Restore"),
          ),
        ],
      ),
    );
  }
}

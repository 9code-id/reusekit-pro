import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBackupView extends StatefulWidget {
  const PpaBackupView({super.key});

  @override
  State<PpaBackupView> createState() => _PpaBackupViewState();
}

class _PpaBackupViewState extends State<PpaBackupView> {
  bool autoBackupEnabled = true;
  bool localBackupEnabled = false;
  bool cloudBackupEnabled = true;
  String backupFrequency = "Daily";
  String backupQuality = "Original";
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Real-time", "value": "Real-time"},
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Original Quality", "value": "Original"},
    {"label": "High Quality", "value": "High"},
    {"label": "Standard Quality", "value": "Standard"},
    {"label": "Compressed", "value": "Compressed"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "backup_001",
      "type": "Auto Backup",
      "status": "Completed",
      "date": "2024-06-16",
      "time": "10:30 AM",
      "filesCount": 125,
      "size": "2.4 GB",
      "location": "Google Drive",
      "duration": "15 minutes",
    },
    {
      "id": "backup_002",
      "type": "Manual Backup",
      "status": "In Progress",
      "date": "2024-06-16",
      "time": "11:15 AM",
      "filesCount": 89,
      "size": "1.8 GB",
      "location": "Local Storage",
      "duration": "8 minutes",
      "progress": 45,
    },
    {
      "id": "backup_003",
      "type": "Scheduled Backup",
      "status": "Failed",
      "date": "2024-06-15",
      "time": "9:00 PM",
      "filesCount": 200,
      "size": "3.2 GB",
      "location": "OneDrive",
      "duration": "Failed after 5 minutes",
      "error": "Insufficient storage space",
    },
    {
      "id": "backup_004",
      "type": "Auto Backup",
      "status": "Completed",
      "date": "2024-06-15",
      "time": "6:00 AM",
      "filesCount": 156,
      "size": "2.9 GB",
      "location": "Dropbox",
      "duration": "18 minutes",
    },
  ];

  double localStorageUsed = 12.3;
  double localStorageTotal = 64.0;
  double cloudStorageUsed = 15.6;
  double cloudStorageTotal = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              _showRestoreDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showBackupSettings();
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
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.backup,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Backup & Restore Center",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Keep your precious memories safe with automatic backups",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: _buildStorageCard("Local Storage", localStorageUsed, localStorageTotal, Icons.storage),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStorageCard("Cloud Storage", cloudStorageUsed, cloudStorageTotal, Icons.cloud),
                ),
              ],
            ),

            Text(
              "Backup Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Auto Backup",
                    items: [
                      {
                        "label": "Automatically backup new photos",
                        "value": true,
                        "checked": autoBackupEnabled,
                      }
                    ],
                    value: [
                      if (autoBackupEnabled)
                        {
                          "label": "Automatically backup new photos",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoBackupEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Local Backup",
                    items: [
                      {
                        "label": "Create local backup copies",
                        "value": true,
                        "checked": localBackupEnabled,
                      }
                    ],
                    value: [
                      if (localBackupEnabled)
                        {
                          "label": "Create local backup copies",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      localBackupEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Cloud Backup",
                    items: [
                      {
                        "label": "Backup to cloud storage",
                        "value": true,
                        "checked": cloudBackupEnabled,
                      }
                    ],
                    value: [
                      if (cloudBackupEnabled)
                        {
                          "label": "Backup to cloud storage",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      cloudBackupEnabled = values.isNotEmpty;
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
                    label: "Backup Quality",
                    items: qualityOptions,
                    value: backupQuality,
                    onChanged: (value, label) {
                      backupQuality = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Backup Now",
                    size: bs.md,
                    icon: Icons.backup,
                    onPressed: () {
                      _startManualBackup();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Restore",
                    size: bs.md,
                    icon: Icons.restore,
                    onPressed: () {
                      _showRestoreDialog();
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Backup History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: backupHistory.length,
              itemBuilder: (context, index) {
                final backup = backupHistory[index];
                return _buildBackupHistoryCard(backup);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageCard(String title, double used, double total, IconData icon) {
    double usedPercentage = used / total;
    Color progressColor = usedPercentage > 0.8 ? dangerColor : 
                         usedPercentage > 0.6 ? warningColor : successColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          LinearProgressIndicator(
            value: usedPercentage,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${used.toStringAsFixed(1)} GB / ${total.toStringAsFixed(0)} GB",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          
          Text(
            "${(usedPercentage * 100).toStringAsFixed(0)}% used",
            style: TextStyle(
              color: progressColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupHistoryCard(Map<String, dynamic> backup) {
    Color statusColor = _getBackupStatusColor(backup["status"]);
    IconData statusIcon = _getBackupStatusIcon(backup["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                statusIcon,
                color: statusColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${backup["type"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${backup["date"]} at ${backup["time"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${backup["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          if (backup["status"] == "In Progress" && backup["progress"] != null) ...[
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (backup["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${backup["progress"]}%",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],
          
          Row(
            children: [
              Icon(
                Icons.photo_library,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${backup["filesCount"]} files",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                Icons.storage,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${backup["size"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${backup["location"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                Icons.schedule,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${backup["duration"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          if (backup["error"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(50)),
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
                      "${backup["error"]}",
                      style: TextStyle(
                        color: dangerColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              if (backup["status"] == "Completed") ...[
                QButton(
                  label: "Restore",
                  size: bs.sm,
                  icon: Icons.restore,
                  onPressed: () {
                    _restoreFromBackup(backup["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              if (backup["status"] == "Failed") ...[
                QButton(
                  label: "Retry",
                  size: bs.sm,
                  icon: Icons.refresh,
                  onPressed: () {
                    _retryBackup(backup["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: "Details",
                size: bs.sm,
                icon: Icons.info,
                onPressed: () {
                  _showBackupDetails(backup);
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _deleteBackup(backup["id"]);
                },
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getBackupStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getBackupStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "In Progress":
        return Icons.sync;
      case "Failed":
        return Icons.error;
      default:
        return Icons.backup;
    }
  }

  void _startManualBackup() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Manual backup started successfully!");
    });
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Restore from Backup"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select a backup to restore your photos from:"),
              SizedBox(height: spSm),
              DropdownButton<String>(
                isExpanded: true,
                items: backupHistory
                    .where((backup) => backup["status"] == "Completed")
                    .map((backup) => DropdownMenuItem<String>(
                          value: backup["id"],
                          child: Text("${backup["date"]} - ${backup["filesCount"]} files"),
                        ))
                    .toList(),
                onChanged: (value) {},
                hint: Text("Select backup"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Restore",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Restore process started!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showBackupSettings() {
    si("Opening backup settings");
  }

  void _showBackupDetails(Map<String, dynamic> backup) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Backup Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Type: ${backup["type"]}"),
              Text("Status: ${backup["status"]}"),
              Text("Date: ${backup["date"]}"),
              Text("Time: ${backup["time"]}"),
              Text("Files: ${backup["filesCount"]}"),
              Text("Size: ${backup["size"]}"),
              Text("Location: ${backup["location"]}"),
              Text("Duration: ${backup["duration"]}"),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _restoreFromBackup(String backupId) {
    ss("Restoring from backup...");
  }

  void _retryBackup(String backupId) {
    si("Retrying backup...");
  }

  void _deleteBackup(String backupId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this backup?");
    if (isConfirmed) {
      ss("Backup deleted successfully");
    }
  }
}

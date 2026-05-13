import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsDataBackupView extends StatefulWidget {
  const EcsDataBackupView({super.key});

  @override
  State<EcsDataBackupView> createState() => _EcsDataBackupViewState();
}

class _EcsDataBackupViewState extends State<EcsDataBackupView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  String backupLocation = "cloud";
  bool includeMedia = true;
  bool includeSettings = true;
  bool includeMessages = false;
  bool loading = false;
  bool backupInProgress = false;
  double backupProgress = 0.0;

  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "1",
      "date": "2024-01-15T02:00:00Z",
      "size": "2.4 GB",
      "status": "completed",
      "type": "automatic",
      "duration": "12 minutes",
      "location": "Google Drive",
    },
    {
      "id": "2",
      "date": "2024-01-14T02:00:00Z",
      "size": "2.3 GB",
      "status": "completed",
      "type": "automatic",
      "duration": "11 minutes",
      "location": "Google Drive",
    },
    {
      "id": "3",
      "date": "2024-01-13T14:30:00Z",
      "size": "2.5 GB",
      "status": "completed",
      "type": "manual",
      "duration": "15 minutes",
      "location": "Local Storage",
    },
    {
      "id": "4",
      "date": "2024-01-12T02:00:00Z",
      "size": "2.2 GB",
      "status": "failed",
      "type": "automatic",
      "duration": "8 minutes",
      "location": "Google Drive",
      "error": "Network connection lost",
    },
    {
      "id": "5",
      "date": "2024-01-11T02:00:00Z",
      "size": "2.1 GB",
      "status": "completed",
      "type": "automatic",
      "duration": "10 minutes",
      "location": "Google Drive",
    },
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Cloud Storage", "value": "cloud"},
    {"label": "Local Storage", "value": "local"},
    {"label": "External Drive", "value": "external"},
  ];

  void _startBackup() async {
    backupInProgress = true;
    backupProgress = 0.0;
    setState(() {});

    // Simulate backup progress
    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(Duration(milliseconds: 200));
      backupProgress = i / 100;
      setState(() {});
    }

    // Add new backup to history
    Map<String, dynamic> newBackup = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "date": DateTime.now().toIso8601String(),
      "size": "2.6 GB",
      "status": "completed",
      "type": "manual",
      "duration": "13 minutes",
      "location": backupLocation == "cloud" ? "Google Drive" : "Local Storage",
    };

    backupHistory.insert(0, newBackup);
    backupInProgress = false;
    setState(() {});

    ss("Backup completed successfully");
  }

  void _saveSettings() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Backup settings saved successfully");
  }

  void _restoreFromBackup(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("Are you sure you want to restore from this backup? This will overwrite your current data.");
    
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();
      ss("Data restored from backup: ${DateTime.parse(backup["date"] as String).dMMMy}");
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

  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    String status = backup["status"] as String;
    Color statusColor = _getStatusColor(status);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Container(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  status == "completed" ? Icons.check_circle :
                  status == "failed" ? Icons.error :
                  Icons.hourglass_empty,
                  color: statusColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.parse("${backup["date"]}").dMMMykkss,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${backup["type"]} backup",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Size: ${backup["size"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Location: ${backup["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Duration: ${backup["duration"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (status == "completed")
                  QButton(
                    label: "Restore",
                    size: bs.sm,
                    onPressed: () => _restoreFromBackup(backup),
                  ),
              ],
            ),

            if (backup["error"] != null) ...[
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Error: ${backup["error"]}",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataTypeOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Container(
        padding: EdgeInsets.all(spSm),
        child: Row(
          children: [
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
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Backup"),
        actions: [
          GestureDetector(
            onTap: _saveSettings,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: spMd),
                  Text(
                    "Saving backup settings...",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Backup Status
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: backupInProgress ? warningColor.withAlpha(25) : successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: backupInProgress ? warningColor.withAlpha(100) : successColor.withAlpha(100),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              backupInProgress ? Icons.backup : Icons.cloud_done,
                              color: backupInProgress ? warningColor : successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    backupInProgress ? "Backup in Progress" : "Last Backup Completed",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: backupInProgress ? warningColor : successColor,
                                    ),
                                  ),
                                  if (!backupInProgress)
                                    Text(
                                      backupHistory.isNotEmpty 
                                          ? DateTime.parse("${backupHistory[0]["date"]}").dMMMykkss
                                          : "No backups yet",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: backupInProgress ? warningColor : successColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (backupInProgress) ...[
                          SizedBox(height: spSm),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: warningColor,
                                    ),
                                  ),
                                  Text(
                                    "${(backupProgress * 100).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: backupProgress,
                                backgroundColor: warningColor.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Manual Backup
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: backupInProgress ? "Backup in Progress..." : "Start Manual Backup",
                      icon: Icons.backup,
                      onPressed: backupInProgress ? null : _startBackup,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Auto Backup Settings
                  Text(
                    "Auto Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spSm),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Enable Auto Backup",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Switch(
                              value: autoBackupEnabled,
                              onChanged: (value) {
                                autoBackupEnabled = value;
                                setState(() {});
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),

                        if (autoBackupEnabled) ...[
                          SizedBox(height: spSm),
                          QDropdownField(
                            label: "Backup Frequency",
                            items: frequencyOptions,
                            value: backupFrequency,
                            onChanged: (value, label) {
                              backupFrequency = value;
                              setState(() {});
                            },
                          ),

                          SizedBox(height: spSm),

                          QDropdownField(
                            label: "Backup Location",
                            items: locationOptions,
                            value: backupLocation,
                            onChanged: (value, label) {
                              backupLocation = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Data Types to Backup
                  Text(
                    "Data Types to Backup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spSm),

                  _buildDataTypeOption(
                    "Application Settings",
                    "User preferences, themes, and configurations",
                    includeSettings,
                    (value) {
                      includeSettings = value;
                      setState(() {});
                    },
                  ),

                  _buildDataTypeOption(
                    "Media Files",
                    "Photos, videos, and other media content",
                    includeMedia,
                    (value) {
                      includeMedia = value;
                      setState(() {});
                    },
                  ),

                  _buildDataTypeOption(
                    "Messages & Chats",
                    "Chat history and message attachments",
                    includeMessages,
                    (value) {
                      includeMessages = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Backup History
                  Text(
                    "Backup History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spSm),

                  if (backupHistory.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No backup history",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Your backup history will appear here",
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: backupHistory
                          .map((backup) => _buildBackupHistoryItem(backup))
                          .toList(),
                    ),

                  SizedBox(height: spMd),

                  // Storage Usage
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Storage Usage",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "• Cloud Storage: 12.5 GB / 15 GB used\n• Local Storage: 5.2 GB available\n• Last backup size: 2.4 GB",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
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
}

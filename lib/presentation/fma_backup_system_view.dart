import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBackupSystemView extends StatefulWidget {
  const FmaBackupSystemView({super.key});

  @override
  State<FmaBackupSystemView> createState() => _FmaBackupSystemViewState();
}

class _FmaBackupSystemViewState extends State<FmaBackupSystemView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  String backupLocation = "cloud";
  bool compressionEnabled = true;
  bool encryptionEnabled = true;
  String retentionPeriod = "30";
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": "backup_001",
      "type": "Full Backup",
      "date": "2025-06-19T10:30:00Z",
      "size": "2.5 GB",
      "status": "Completed",
      "duration": "45 minutes",
      "location": "AWS S3"
    },
    {
      "id": "backup_002", 
      "type": "Incremental",
      "date": "2025-06-18T22:00:00Z",
      "size": "450 MB",
      "status": "Completed",
      "duration": "12 minutes",
      "location": "AWS S3"
    },
    {
      "id": "backup_003",
      "type": "Full Backup",
      "date": "2025-06-17T10:30:00Z",
      "size": "2.4 GB",
      "status": "Failed",
      "duration": "N/A",
      "location": "AWS S3"
    },
    {
      "id": "backup_004",
      "type": "Incremental",
      "date": "2025-06-16T22:00:00Z",
      "size": "320 MB",
      "status": "Completed",
      "duration": "8 minutes",
      "location": "AWS S3"
    }
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Every Hour", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"}
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Cloud Storage", "value": "cloud"},
    {"label": "Local Server", "value": "local"},
    {"label": "External Drive", "value": "external"}
  ];

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "7 Days", "value": "7"},
    {"label": "30 Days", "value": "30"},
    {"label": "90 Days", "value": "90"},
    {"label": "1 Year", "value": "365"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup System"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Backup status refreshed");
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
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.backup,
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
                            spacing: spXs,
                            children: [
                              Text(
                                "Last Backup",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "June 19, 10:30 AM",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                            spacing: spXs,
                            children: [
                              Text(
                                "Next Backup",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "June 20, 10:30 AM",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Backup Configuration
            Container(
              width: double.infinity,
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
                    "Backup Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Automatic Backup",
                        "value": true,
                        "checked": autoBackupEnabled,
                      }
                    ],
                    value: [
                      if (autoBackupEnabled)
                        {
                          "label": "Enable Automatic Backup",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoBackupEnabled = values.isNotEmpty;
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
                    label: "Backup Location",
                    items: locationOptions,
                    value: backupLocation,
                    onChanged: (value, label) {
                      backupLocation = value;
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
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Compression",
                        "value": true,
                        "checked": compressionEnabled,
                      }
                    ],
                    value: [
                      if (compressionEnabled)
                        {
                          "label": "Enable Compression",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      compressionEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Encryption",
                        "value": true,
                        "checked": encryptionEnabled,
                      }
                    ],
                    value: [
                      if (encryptionEnabled)
                        {
                          "label": "Enable Encryption",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      encryptionEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Backup Now",
                    onPressed: () {
                      ss("Backup started successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Configuration",
                    onPressed: () {
                      ss("Configuration saved");
                    },
                  ),
                ),
              ],
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
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Backup History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...backupHistory.map((backup) {
                    Color statusColor = (backup["status"] as String) == "Completed" 
                        ? successColor 
                        : (backup["status"] as String) == "Failed" 
                            ? dangerColor 
                            : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: statusColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${backup["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${backup["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${DateTime.parse(backup["date"] as String).dMMMykkss}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
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
                                      "Duration: ${backup["duration"]}",
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
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {
                              ss("Downloading backup ${backup["id"]}");
                            },
                          ),
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

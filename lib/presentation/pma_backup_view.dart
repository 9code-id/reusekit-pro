import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaBackupView extends StatefulWidget {
  const PmaBackupView({super.key});

  @override
  State<PmaBackupView> createState() => _PmaBackupViewState();
}

class _PmaBackupViewState extends State<PmaBackupView> {
  bool autoBackup = true;
  bool cloudBackup = true;
  bool localBackup = false;
  String backupFrequency = "Daily";
  String retentionPeriod = "30";
  String cloudProvider = "Google Drive";

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "Google Drive"},
    {"label": "Dropbox", "value": "Dropbox"},
    {"label": "AWS S3", "value": "AWS S3"},
    {"label": "OneDrive", "value": "OneDrive"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "id": 1,
      "date": "2024-01-22 08:00",
      "type": "Automatic",
      "location": "Google Drive",
      "size": "2.3 GB",
      "status": "Completed",
      "duration": "4m 32s",
      "files": 1247,
    },
    {
      "id": 2,
      "date": "2024-01-21 08:00",
      "type": "Automatic",
      "location": "Google Drive",
      "size": "2.2 GB",
      "status": "Completed",
      "duration": "4m 18s",
      "files": 1239,
    },
    {
      "id": 3,
      "date": "2024-01-20 15:30",
      "type": "Manual",
      "location": "Local Storage",
      "size": "2.1 GB",
      "status": "Completed",
      "duration": "2m 45s",
      "files": 1225,
    },
    {
      "id": 4,
      "date": "2024-01-20 08:00",
      "type": "Automatic",
      "location": "Google Drive",
      "size": "2.1 GB",
      "status": "Failed",
      "duration": "0m 0s",
      "files": 0,
    },
    {
      "id": 5,
      "date": "2024-01-19 08:00",
      "type": "Automatic",
      "location": "Google Drive",
      "size": "2.0 GB",
      "status": "Completed",
      "duration": "3m 56s",
      "files": 1203,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Failed":
        return dangerColor;
      case "In Progress":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int completedBackups = backupHistory.where((b) => b["status"] == "Completed").length;
    double totalSize = backupHistory
        .where((b) => b["status"] == "Completed")
        .map((b) => double.tryParse(b["size"].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0)
        .fold(0.0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.backup),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Configuration
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
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
                        "value": "auto",
                        "checked": autoBackup,
                      }
                    ],
                    value: autoBackup ? [{"label": "Enable Automatic Backup", "value": "auto", "checked": true}] : [],
                    onChanged: (values, ids) {
                      autoBackup = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (autoBackup)
                    QDropdownField(
                      label: "Backup Frequency",
                      items: frequencyOptions,
                      value: backupFrequency,
                      onChanged: (value, label) {
                        backupFrequency = value;
                        setState(() {});
                      },
                    ),
                  QNumberField(
                    label: "Retention Period (days)",
                    value: retentionPeriod,
                    onChanged: (value) {
                      retentionPeriod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Backup Locations
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Backup Locations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Cloud Backup",
                        "value": "cloud",
                        "checked": cloudBackup,
                      }
                    ],
                    value: cloudBackup ? [{"label": "Cloud Backup", "value": "cloud", "checked": true}] : [],
                    onChanged: (values, ids) {
                      cloudBackup = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (cloudBackup)
                    QDropdownField(
                      label: "Cloud Provider",
                      items: cloudProviders,
                      value: cloudProvider,
                      onChanged: (value, label) {
                        cloudProvider = value;
                        setState(() {});
                      },
                    ),
                  QSwitch(
                    items: [
                      {
                        "label": "Local Backup",
                        "value": "local",
                        "checked": localBackup,
                      }
                    ],
                    value: localBackup ? [{"label": "Local Backup", "value": "local", "checked": true}] : [],
                    onChanged: (values, ids) {
                      localBackup = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Backup Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Backup Statistics",
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
                          children: [
                            Text(
                              "$completedBackups",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Successful Backups",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${totalSize.toStringAsFixed(1)} GB",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Backup Size",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${backupHistory.isNotEmpty ? backupHistory.first["date"].toString().split(' ')[0] : 'Never'}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last Backup",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
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
                          label: "Create Backup Now",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Restore Data",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Import Data",
                          size: bs.sm,
                          onPressed: () {},
                        ),
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
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: backupHistory.take(5).map((backup) {
                      Color statusColor = _getStatusColor(backup["status"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: statusColor.withAlpha(40),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: backup["type"] == "Automatic" ? infoColor : warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${backup["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${backup["date"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${backup["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.cloud,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${backup["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${backup["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            if (backup["status"] == "Completed")
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${backup["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.folder,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${backup["files"]} files",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    icon: Icons.download,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.restore,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            else if (backup["status"] == "Failed")
                              Row(
                                children: [
                                  Text(
                                    "Backup failed - Check connection and try again",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    icon: Icons.refresh,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Storage Management
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Storage Management",
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
                          label: "Clean Old Backups",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Storage Settings",
                          size: bs.sm,
                          onPressed: () {},
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

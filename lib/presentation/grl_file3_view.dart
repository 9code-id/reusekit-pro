import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile3View extends StatefulWidget {
  @override
  State<GrlFile3View> createState() => _GrlFile3ViewState();
}

class _GrlFile3ViewState extends State<GrlFile3View> {
  String backupFrequency = "daily";
  String backupTime = "02:00";
  String retentionPeriod = "30";
  bool enableCloudBackup = true;
  bool compressBackups = true;
  bool incrementalBackup = true;
  bool encryptBackups = true;
  String selectedLocation = "cloud";

  List<Map<String, dynamic>> frequencyItems = [
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> retentionItems = [
    {"label": "7 Days", "value": "7"},
    {"label": "30 Days", "value": "30"},
    {"label": "90 Days", "value": "90"},
    {"label": "1 Year", "value": "365"},
    {"label": "Forever", "value": "forever"},
  ];

  List<Map<String, dynamic>> locationItems = [
    {"label": "Cloud Storage", "value": "cloud"},
    {"label": "External Drive", "value": "external"},
    {"label": "Network Drive", "value": "network"},
    {"label": "Local Folder", "value": "local"},
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "date": "2024-01-22 02:00:15",
      "type": "Full Backup",
      "size": "2.4 GB",
      "files": 1247,
      "duration": "12m 34s",
      "status": "completed",
      "location": "Google Drive"
    },
    {
      "date": "2024-01-21 02:00:12",
      "type": "Incremental",
      "size": "145 MB",
      "files": 89,
      "duration": "2m 18s",
      "status": "completed",
      "location": "Google Drive"
    },
    {
      "date": "2024-01-20 02:00:08",
      "type": "Incremental",
      "size": "78 MB",
      "files": 34,
      "duration": "1m 45s",
      "status": "completed",
      "location": "Google Drive"
    },
    {
      "date": "2024-01-19 02:00:22",
      "type": "Incremental",
      "size": "234 MB",
      "files": 156,
      "duration": "3m 56s",
      "status": "failed",
      "location": "Google Drive",
      "error": "Connection timeout"
    },
    {
      "date": "2024-01-18 02:00:05",
      "type": "Incremental",
      "size": "67 MB",
      "files": 23,
      "duration": "1m 12s",
      "status": "completed",
      "location": "Google Drive"
    },
  ];

  List<Map<String, dynamic>> backupStats = [
    {
      "label": "Total Backups",
      "value": "247",
      "color": primaryColor,
      "icon": Icons.backup,
    },
    {
      "label": "Success Rate",
      "value": "98.7%",
      "color": successColor,
      "icon": Icons.check_circle,
    },
    {
      "label": "Storage Used",
      "value": "45.2 GB",
      "color": warningColor,
      "icon": Icons.storage,
    },
    {
      "label": "Last Backup",
      "value": "2 hours ago",
      "color": infoColor,
      "icon": Icons.schedule,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Backup"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Backup Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    infoColor,
                    infoColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Backup Protection",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "ACTIVE",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your files are automatically backed up to secure cloud storage every day at 2:00 AM",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    minItemWidth: 120,
                    children: backupStats.map((stat) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                stat["icon"] as IconData,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${stat["label"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Backup Settings
            Text(
              "Backup Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Backup Frequency",
                          items: frequencyItems,
                          value: backupFrequency,
                          onChanged: (value, label) {
                            backupFrequency = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QTimePicker(
                          label: "Backup Time",
                          value: TimeOfDay.fromDateTime(
                            DateTime.parse("2024-01-01 $backupTime:00"),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              backupTime = value.kkmm;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Backup Location",
                          items: locationItems,
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Retention Period",
                          items: retentionItems,
                          value: retentionPeriod,
                          onChanged: (value, label) {
                            retentionPeriod = value;
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
                              "label": "Enable Cloud Backup",
                              "value": true,
                              "checked": enableCloudBackup,
                            }
                          ],
                          value: [
                            if (enableCloudBackup)
                              {
                                "label": "Enable Cloud Backup",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableCloudBackup = values.isNotEmpty;
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
                              "label": "Compress Backups",
                              "value": true,
                              "checked": compressBackups,
                            }
                          ],
                          value: [
                            if (compressBackups)
                              {
                                "label": "Compress Backups",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            compressBackups = values.isNotEmpty;
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
                              "label": "Incremental Backup",
                              "value": true,
                              "checked": incrementalBackup,
                            }
                          ],
                          value: [
                            if (incrementalBackup)
                              {
                                "label": "Incremental Backup",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            incrementalBackup = values.isNotEmpty;
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
                              "label": "Encrypt Backups",
                              "value": true,
                              "checked": encryptBackups,
                            }
                          ],
                          value: [
                            if (encryptBackups)
                              {
                                "label": "Encrypt Backups",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            encryptBackups = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                    label: "Backup Now",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Test Backup",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Backup History
            Text(
              "Backup History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...backupHistory.map((backup) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getBackupStatusColor(backup["status"]).withAlpha(50),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getBackupStatusColor(backup["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getBackupStatusIcon(backup["status"]),
                          color: _getBackupStatusColor(backup["status"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${backup["type"]} - ${backup["date"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${backup["size"]} • ${backup["files"]} files • ${backup["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getBackupStatusColor(backup["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${backup["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Duration: ${backup["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        if (backup["error"] != null) ...[
                          Text(
                            "Error: ${backup["error"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (backup["status"] == "completed") ...[
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Download",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Restore",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Delete",
                            color: dangerColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ] else if (backup["status"] == "failed") ...[
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Retry Backup",
                            color: warningColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "View Log",
                            color: infoColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            )),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildQuickActionCard(
                  "Full Backup",
                  "Create complete backup",
                  Icons.backup,
                  primaryColor,
                ),
                _buildQuickActionCard(
                  "Restore Files",
                  "Restore from backup",
                  Icons.restore,
                  successColor,
                ),
                _buildQuickActionCard(
                  "Cleanup Old",
                  "Remove old backups",
                  Icons.cleaning_services,
                  warningColor,
                ),
                _buildQuickActionCard(
                  "Verify Backup",
                  "Check backup integrity",
                  Icons.verified,
                  infoColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Execute",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackupStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      case "running":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getBackupStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "failed":
        return Icons.error;
      case "running":
        return Icons.backup;
      default:
        return Icons.help;
    }
  }
}

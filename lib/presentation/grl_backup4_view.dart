import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup4View extends StatefulWidget {
  @override
  State<GrlBackup4View> createState() => _GrlBackup4ViewState();
}

class _GrlBackup4ViewState extends State<GrlBackup4View> {
  bool isLoading = false;
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  String storageLocation = "cloud";
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": 1,
      "type": "Full Backup",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "size": "2.4 GB",
      "status": "completed",
      "location": "Google Drive",
      "duration": "12 minutes",
    },
    {
      "id": 2,
      "type": "Incremental Backup",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "size": "156 MB",
      "status": "completed",
      "location": "Google Drive",
      "duration": "3 minutes",
    },
    {
      "id": 3,
      "type": "Full Backup",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "size": "2.1 GB",
      "status": "failed",
      "location": "Google Drive",
      "duration": "8 minutes",
      "error": "Network connection interrupted",
    },
    {
      "id": 4,
      "type": "Manual Backup",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "size": "1.8 GB",
      "status": "completed",
      "location": "Local Storage",
      "duration": "15 minutes",
    },
  ];

  List<Map<String, dynamic>> storageOptions = [
    {
      "label": "Google Drive",
      "value": "google_drive",
      "icon": Icons.cloud,
      "available": "13.2 GB",
      "used": "2.8 GB",
    },
    {
      "label": "iCloud",
      "value": "icloud",
      "icon": Icons.cloud_upload,
      "available": "4.1 GB",
      "used": "1.2 GB",
    },
    {
      "label": "Local Storage",
      "value": "local",
      "icon": Icons.storage,
      "available": "128 GB",
      "used": "45 GB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Backup Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.backup,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Backup",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "2 hours ago",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "SYNCED",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2.4 GB",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Size",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                              "12 min",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                              "Google Drive",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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

            SizedBox(height: spMd),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Backup Now",
                    size: bs.md,
                    icon: Icons.backup,
                    onPressed: _performBackup,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Restore",
                    size: bs.md,
                    icon: Icons.restore,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Auto Backup Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Auto Backup Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enable Auto Backup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically backup your data",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoBackupEnabled,
                        onChanged: (value) {
                          autoBackupEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  if (autoBackupEnabled) ...[
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Backup Frequency",
                      items: [
                        {"label": "Daily", "value": "daily"},
                        {"label": "Weekly", "value": "weekly"},
                        {"label": "Monthly", "value": "monthly"},
                      ],
                      value: backupFrequency,
                      onChanged: (value, label) {
                        backupFrequency = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Storage Options
            Text(
              "Storage Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...storageOptions.map((storage) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: storageLocation == storage["value"]
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      storage["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${storage["label"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Available: ${storage["available"]} • Used: ${storage["used"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Radio<String>(
                    value: storage["value"],
                    groupValue: storageLocation,
                    onChanged: (value) {
                      storageLocation = value!;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )).toList(),

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
            SizedBox(height: spMd),
            ...backupHistory.map((backup) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(backup["status"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${backup["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(backup["date"] as DateTime).dMMMy} • ${(backup["date"] as DateTime).dMMMykkss}",
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
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(backup["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${backup["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(backup["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          Icons.storage,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${backup["size"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${backup["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.cloud,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${backup["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (backup["status"] == "failed" && backup["error"] != null) ...[
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${backup["error"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'in_progress':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _performBackup() async {
    isLoading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate backup process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    // Add new backup to history
    backupHistory.insert(0, {
      "id": backupHistory.length + 1,
      "type": "Manual Backup",
      "date": DateTime.now(),
      "size": "2.6 GB",
      "status": "completed",
      "location": storageLocation == "google_drive" ? "Google Drive" : 
                  storageLocation == "icloud" ? "iCloud" : "Local Storage",
      "duration": "3 minutes",
    });
    
    isLoading = false;
    setState(() {});
    
    ss("Backup completed successfully!");
  }
}

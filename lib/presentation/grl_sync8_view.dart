import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync8View extends StatefulWidget {
  @override
  State<GrlSync8View> createState() => _GrlSync8ViewState();
}

class _GrlSync8ViewState extends State<GrlSync8View> {
  bool isLoading = false;
  String selectedBackup = "";
  String restoreProgress = "";
  double progressValue = 0.0;
  
  List<Map<String, dynamic>> availableBackups = [
    {
      "id": "backup_001",
      "date": "2024-06-22 14:30:00",
      "size": "2.8 GB",
      "files": 15420,
      "version": "Latest",
      "status": "complete",
      "location": "Cloud Storage",
      "type": "Auto Backup"
    },
    {
      "id": "backup_002",
      "date": "2024-06-21 14:30:00",
      "size": "2.7 GB",
      "files": 15280,
      "version": "Yesterday",
      "status": "complete",
      "location": "Cloud Storage",
      "type": "Auto Backup"
    },
    {
      "id": "backup_003",
      "date": "2024-06-20 19:45:00",
      "size": "1.2 GB",
      "files": 8450,
      "version": "2 days ago",
      "status": "partial",
      "location": "Cloud Storage",
      "type": "Manual Backup"
    },
    {
      "id": "backup_004",
      "date": "2024-06-19 14:30:00",
      "size": "2.6 GB",
      "files": 14920,
      "version": "3 days ago",
      "status": "complete",
      "location": "Cloud Storage",
      "type": "Auto Backup"
    },
    {
      "id": "backup_005",
      "date": "2024-06-18 14:30:00",
      "size": "2.5 GB",
      "files": 14680,
      "version": "4 days ago",
      "status": "complete",
      "location": "Local Storage",
      "type": "Auto Backup"
    }
  ];

  List<Map<String, dynamic>> restoreCategories = [
    {
      "name": "All Data",
      "description": "Restore everything from backup",
      "icon": Icons.restore,
      "selected": true,
      "items": ["Documents", "Photos", "Contacts", "Settings", "App Data"]
    },
    {
      "name": "Documents Only",
      "description": "Restore documents and files",
      "icon": Icons.description,
      "selected": false,
      "items": ["Documents", "Downloads", "PDFs"]
    },
    {
      "name": "Media Files",
      "description": "Restore photos and videos",
      "icon": Icons.photo_library,
      "selected": false,
      "items": ["Photos", "Videos", "Audio Files"]
    },
    {
      "name": "Personal Data",
      "description": "Restore contacts and messages",
      "icon": Icons.person,
      "selected": false,
      "items": ["Contacts", "Messages", "Call History"]
    },
    {
      "name": "App Settings",
      "description": "Restore app configurations",
      "icon": Icons.settings,
      "selected": false,
      "items": ["Settings", "Preferences", "App Data"]
    }
  ];

  int selectedRestoreType = 0;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'complete':
        return successColor;
      case 'partial':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'complete':
        return 'Complete';
      case 'partial':
        return 'Partial';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  Future<void> _startRestore() async {
    if (selectedBackup.isEmpty) {
      se("Please select a backup to restore");
      return;
    }

    bool isConfirmed = await confirm("This will overwrite your current data. Continue with restore?");
    if (!isConfirmed) return;

    isLoading = true;
    progressValue = 0.0;
    restoreProgress = "Initializing restore...";
    setState(() {});

    List<String> steps = [
      "Connecting to backup source...",
      "Verifying backup integrity...",
      "Downloading backup files...",
      "Extracting data...",
      "Restoring documents...",
      "Restoring media files...",
      "Restoring settings...",
      "Finalizing restore...",
      "Restore completed!"
    ];

    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      restoreProgress = steps[i];
      progressValue = (i + 1) / steps.length;
      setState(() {});
    }

    isLoading = false;
    setState(() {});
    
    ss("Data restored successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restore Data"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Restore Progress (if active)
            if (isLoading)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: infoColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Restoring Data",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                restoreProgress,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(progressValue * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                  ],
                ),
              ),

            // Select Backup
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select Backup to Restore",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...availableBackups.map((backup) {
                    DateTime backupDate = DateTime.parse("${backup["date"]}");
                    bool isSelected = selectedBackup == backup["id"];
                    
                    return GestureDetector(
                      onTap: isLoading ? null : () {
                        selectedBackup = "${backup["id"]}";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(10)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${backup["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    backup["location"] == "Cloud Storage" 
                                        ? Icons.cloud
                                        : Icons.storage,
                                    color: _getStatusColor("${backup["status"]}"),
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${backup["version"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (backup["version"] == "Latest") ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: spXxs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "LATEST",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        backupDate.dMMMy,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: spXxs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${backup["status"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        _getStatusText("${backup["status"]}"),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Icon(
                                      isSelected 
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: isSelected ? primaryColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.storage,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${backup["size"]} • ${backup["files"]} files",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
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
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Restore Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "What to Restore",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...restoreCategories.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> category = entry.value;
                    bool isSelected = selectedRestoreType == index;
                    
                    return GestureDetector(
                      onTap: isLoading ? null : () {
                        selectedRestoreType = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(isSelected ? 30 : 10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${category["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    (category["items"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isSelected 
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Warning Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Important Notice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Restoring from backup will overwrite your current data. This action cannot be undone. Please ensure you have a recent backup before proceeding.",
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
            ),

            // Restore Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Restoring..." : "Start Restore",
                icon: Icons.restore,
                size: bs.md,
                onPressed: isLoading ? null : _startRestore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

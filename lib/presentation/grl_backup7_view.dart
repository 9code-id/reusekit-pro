import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup7View extends StatefulWidget {
  @override
  State<GrlBackup7View> createState() => _GrlBackup7ViewState();
}

class _GrlBackup7ViewState extends State<GrlBackup7View> {
  bool isRestoring = false;
  int restoreProgress = 0;
  String currentRestoreFile = "";
  String selectedBackupDate = "";
  
  List<Map<String, dynamic>> availableBackups = [
    {
      "id": 1,
      "date": DateTime.now().subtract(Duration(hours: 6)),
      "type": "Full Backup",
      "size": "2.4 GB",
      "location": "Google Drive",
      "status": "complete",
      "files": 2847,
      "categories": ["Photos", "Documents", "Contacts", "App Data"],
      "compatibility": "100%",
    },
    {
      "id": 2,
      "date": DateTime.now().subtract(Duration(days: 1)),
      "type": "Incremental Backup",
      "size": "156 MB",
      "location": "Google Drive",
      "status": "complete",
      "files": 234,
      "categories": ["Photos", "Documents"],
      "compatibility": "100%",
    },
    {
      "id": 3,
      "date": DateTime.now().subtract(Duration(days: 3)),
      "type": "Full Backup",
      "size": "2.1 GB",
      "location": "Google Drive",
      "status": "incomplete",
      "files": 2456,
      "categories": ["Photos", "Documents", "Contacts"],
      "compatibility": "85%",
      "warning": "Some files may be corrupted",
    },
    {
      "id": 4,
      "date": DateTime.now().subtract(Duration(days: 7)),
      "type": "Manual Backup",
      "size": "1.8 GB",
      "location": "Local Storage",
      "status": "complete",
      "files": 1923,
      "categories": ["Photos", "Documents", "App Data"],
      "compatibility": "95%",
    },
    {
      "id": 5,
      "date": DateTime.now().subtract(Duration(days: 14)),
      "type": "Full Backup",
      "size": "2.0 GB",
      "location": "iCloud",
      "status": "complete",
      "files": 2134,
      "categories": ["Photos", "Documents", "Contacts", "Messages"],
      "compatibility": "90%",
      "note": "Older version, some features may not be available",
    },
  ];

  List<Map<String, dynamic>> restoreOptions = [
    {
      "category": "Photos & Videos",
      "icon": Icons.photo_library,
      "enabled": true,
      "items": 1245,
      "size": "1.2 GB",
      "description": "All your photos and videos",
    },
    {
      "category": "Documents",
      "icon": Icons.description,
      "enabled": true,
      "items": 89,
      "size": "456 MB",
      "description": "PDFs, Word docs, and other files",
    },
    {
      "category": "Contacts",
      "icon": Icons.contacts,
      "enabled": true,
      "items": 247,
      "size": "12 MB",
      "description": "Phone contacts and address book",
    },
    {
      "category": "App Data",
      "icon": Icons.apps,
      "enabled": false,
      "items": 45,
      "size": "324 MB",
      "description": "Application settings and data",
    },
    {
      "category": "Messages",
      "icon": Icons.message,
      "enabled": false,
      "items": 1523,
      "size": "89 MB",
      "description": "Text messages and chat history",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restore Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: _showRestoreHelp,
          ),
        ],
      ),
      body: Column(
        children: [
          // Restore Progress (if restoring)
          if (isRestoring) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                border: Border(
                  bottom: BorderSide(color: primaryColor.withAlpha(100)),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.restore,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Restoring Data...",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              currentRestoreFile,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$restoreProgress%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  LinearProgressIndicator(
                    value: restoreProgress / 100,
                    backgroundColor: primaryColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cancel Restore",
                          size: bs.sm,
                          icon: Icons.cancel,
                          onPressed: _cancelRestore,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available Backups
                  Text(
                    "Available Backups",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...availableBackups.map((backup) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                      border: selectedBackupDate == backup["id"].toString()
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Backup Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getStatusColor(backup["status"]).withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(backup["status"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getBackupIcon(backup["type"]),
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
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
                        ),
                        
                        // Backup Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
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
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.folder,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${backup["files"]} files",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
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
                                ],
                              ),
                              SizedBox(height: spMd),
                              
                              // Compatibility
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: _getCompatibilityColor(backup["compatibility"]),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Compatibility: ${backup["compatibility"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getCompatibilityColor(backup["compatibility"]),
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Categories
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (backup["categories"] as List<String>).map((category) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                )).toList(),
                              ),
                              
                              // Warning or Note
                              if (backup["warning"] != null) ...[
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${backup["warning"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              if (backup["note"] != null) ...[
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${backup["note"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Preview",
                                      size: bs.sm,
                                      icon: Icons.preview,
                                      onPressed: () => _previewBackup(backup),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: backup["status"] == "complete" ? "Restore" : "Partial Restore",
                                      size: bs.sm,
                                      icon: Icons.restore,
                                      onPressed: () => _selectBackupForRestore(backup),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                  
                  // Restore Options (if backup selected)
                  if (selectedBackupDate.isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Text(
                      "Select Data to Restore",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...restoreOptions.map((option) => Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: option["enabled"] as bool
                            ? Border.all(color: primaryColor.withAlpha(100))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: option["enabled"] as bool,
                            onChanged: (value) {
                              option["enabled"] = value!;
                              setState(() {});
                            },
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: option["enabled"] as bool
                                  ? primaryColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              option["icon"] as IconData,
                              color: option["enabled"] as bool
                                  ? primaryColor
                                  : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${option["category"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: option["enabled"] as bool
                                        ? Colors.black
                                        : disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${option["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${option["items"]} items • ${option["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Restore",
                        size: bs.md,
                        icon: Icons.restore,
                        onPressed: _startRestore,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'complete':
        return successColor;
      case 'incomplete':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getBackupIcon(String type) {
    switch (type) {
      case 'Full Backup':
        return Icons.backup;
      case 'Incremental Backup':
        return Icons.update;
      case 'Manual Backup':
        return Icons.archive;
      default:
        return Icons.storage;
    }
  }

  Color _getCompatibilityColor(String compatibility) {
    int percent = int.tryParse(compatibility.replaceAll('%', '')) ?? 0;
    if (percent >= 95) return successColor;
    if (percent >= 80) return warningColor;
    return dangerColor;
  }

  void _previewBackup(Map<String, dynamic> backup) {
    // Show backup preview dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Backup Preview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Backup Date: ${(backup["date"] as DateTime).dMMMy}"),
            Text("Type: ${backup["type"]}"),
            Text("Size: ${backup["size"]}"),
            Text("Files: ${backup["files"]}"),
            SizedBox(height: spSm),
            Text("Categories:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...(backup["categories"] as List<String>).map((cat) => Text("• $cat")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _selectBackupForRestore(Map<String, dynamic> backup) {
    selectedBackupDate = backup["id"].toString();
    setState(() {});
    
    // Scroll to restore options
    si("Selected backup from ${(backup["date"] as DateTime).dMMMy}. Choose data to restore below.");
  }

  void _startRestore() async {
    final selectedOptions = restoreOptions.where((o) => o["enabled"] as bool).toList();
    
    if (selectedOptions.isEmpty) {
      sw("Please select at least one category to restore");
      return;
    }
    
    bool isConfirmed = await confirm("Are you sure you want to start the restore process? This will overwrite existing data.");
    if (!isConfirmed) return;
    
    isRestoring = true;
    restoreProgress = 0;
    setState(() {});
    
    List<String> files = [
      "Preparing restore...",
      "Restoring photos...",
      "Restoring documents...",
      "Restoring contacts...",
      "Restoring app data...",
      "Finalizing restore...",
    ];
    
    for (int i = 0; i < files.length; i++) {
      currentRestoreFile = files[i];
      setState(() {});
      
      await Future.delayed(Duration(seconds: 3));
      
      restoreProgress = ((i + 1) / files.length * 100).round();
      setState(() {});
    }
    
    isRestoring = false;
    selectedBackupDate = "";
    setState(() {});
    
    ss("Data restored successfully!");
  }

  void _cancelRestore() {
    isRestoring = false;
    restoreProgress = 0;
    currentRestoreFile = "";
    setState(() {});
    
    sw("Restore cancelled");
  }

  void _showRestoreHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Restore Help"),
        content: Text(
          "1. Select a backup from the list\n"
          "2. Preview the backup to see what's included\n"
          "3. Choose which data categories to restore\n"
          "4. Start the restore process\n\n"
          "Note: Restoring will overwrite existing data. Make sure to backup current data if needed."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }
}

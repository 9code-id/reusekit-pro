import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup2View extends StatefulWidget {
  @override
  State<GrlBackup2View> createState() => _GrlBackup2ViewState();
}

class _GrlBackup2ViewState extends State<GrlBackup2View> {
  String selectedBackup = "";
  bool restoreContacts = true;
  bool restoreMessages = true;
  bool restorePhotos = false;
  bool restoreSettings = true;
  bool restoreApps = false;
  String selectedDate = "";
  bool isLoading = false;
  
  List<Map<String, dynamic>> availableBackups = [
    {
      "id": "BKP-001",
      "date": "2024-06-22 08:30",
      "size": "2.4 GB",
      "location": "Google Drive",
      "type": "Complete Backup",
      "device": "iPhone 13 Pro",
      "components": {
        "contacts": true,
        "messages": true,
        "photos": true,
        "settings": true,
        "apps": true,
      },
      "version": "iOS 17.0",
    },
    {
      "id": "BKP-002",
      "date": "2024-06-21 08:30",
      "size": "2.3 GB",
      "location": "Google Drive",
      "type": "Complete Backup",
      "device": "iPhone 13 Pro",
      "components": {
        "contacts": true,
        "messages": true,
        "photos": true,
        "settings": true,
        "apps": true,
      },
      "version": "iOS 17.0",
    },
    {
      "id": "BKP-003",
      "date": "2024-06-20 14:15",
      "size": "1.8 GB",
      "location": "Local Storage",
      "type": "Partial Backup",
      "device": "iPhone 13 Pro",
      "components": {
        "contacts": true,
        "messages": true,
        "photos": false,
        "settings": true,
        "apps": false,
      },
      "version": "iOS 17.0",
    },
    {
      "id": "BKP-004",
      "date": "2024-06-15 10:45",
      "size": "2.1 GB",
      "location": "iCloud",
      "type": "Complete Backup",
      "device": "iPhone 12",
      "components": {
        "contacts": true,
        "messages": true,
        "photos": true,
        "settings": true,
        "apps": true,
      },
      "version": "iOS 16.5",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restore from Backup"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.restore,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Restore Your Data",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Choose a backup to restore your data from",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
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
              child: GestureDetector(
                onTap: () {
                  selectedBackup = backup["id"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedBackup == backup["id"] 
                          ? primaryColor 
                          : disabledOutlineBorderColor,
                      width: selectedBackup == backup["id"] ? 2 : 1,
                    ),
                    boxShadow: selectedBackup == backup["id"] ? [shadowMd] : [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: selectedBackup == backup["id"] 
                                  ? primaryColor 
                                  : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              _getLocationIcon(backup["location"]),
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
                                  "${backup["date"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: selectedBackup == backup["id"] 
                                        ? primaryColor 
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${backup["device"]} • ${backup["size"]}",
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
                              color: selectedBackup == backup["id"] 
                                  ? primaryColor.withAlpha(20) 
                                  : disabledColor.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${backup["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: selectedBackup == backup["id"] 
                                    ? primaryColor 
                                    : disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Backup Components
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Includes:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: _getBackupComponents(backup["components"]).map((component) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            component,
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                            ),
                          ),
                        )).toList(),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${backup["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${backup["version"]}",
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
              ),
            )).toList(),
            
            if (selectedBackup.isNotEmpty) ...[
              SizedBox(height: spLg),
              
              // Restore Options
              Text(
                "What to Restore",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
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
                      "Select data to restore:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Contacts",
                          "value": "contacts",
                          "checked": restoreContacts,
                        },
                        {
                          "label": "Messages",
                          "value": "messages",
                          "checked": restoreMessages,
                        },
                        {
                          "label": "Photos & Videos",
                          "value": "photos",
                          "checked": restorePhotos,
                        },
                        {
                          "label": "App Settings",
                          "value": "settings",
                          "checked": restoreSettings,
                        },
                        {
                          "label": "Apps & App Data",
                          "value": "apps",
                          "checked": restoreApps,
                        },
                      ],
                      value: [
                        if (restoreContacts) {"label": "Contacts", "value": "contacts", "checked": true},
                        if (restoreMessages) {"label": "Messages", "value": "messages", "checked": true},
                        if (restorePhotos) {"label": "Photos & Videos", "value": "photos", "checked": true},
                        if (restoreSettings) {"label": "App Settings", "value": "settings", "checked": true},
                        if (restoreApps) {"label": "Apps & App Data", "value": "apps", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        restoreContacts = values.any((v) => v["value"] == "contacts");
                        restoreMessages = values.any((v) => v["value"] == "messages");
                        restorePhotos = values.any((v) => v["value"] == "photos");
                        restoreSettings = values.any((v) => v["value"] == "settings");
                        restoreApps = values.any((v) => v["value"] == "apps");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Warning Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: warningColor.withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Important Notice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Current data will be replaced with backup data\n• This process cannot be undone\n• Make sure you have a recent backup before proceeding\n• Restore process may take several minutes",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Restore Progress Preview
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
                    Row(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Restore Process",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    _buildProcessStep("1", "Download Backup", "Downloading backup files", true),
                    _buildProcessStep("2", "Prepare Device", "Preparing device for restore", false),
                    _buildProcessStep("3", "Restore Data", "Restoring selected data", false),
                    _buildProcessStep("4", "Complete Setup", "Finalizing restore process", false),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Start Restore",
                      size: bs.md,
                      onPressed: !isLoading ? () async {
                        await _startRestore();
                      } : null,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Preview Only",
                      size: bs.md,
                      onPressed: () {
                        _previewRestore();
                      },
                    ),
                  ),
                ],
              ),
              
              if (isLoading) ...[
                SizedBox(height: spMd),
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Restoring data... Please don't close the app",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProcessStep(String number, String title, String description, bool isActive) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isActive ? primaryColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryColor : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            Icon(
              Icons.play_arrow,
              color: primaryColor,
              size: 20,
            ),
        ],
      ),
    );
  }

  IconData _getLocationIcon(String location) {
    switch (location.toLowerCase()) {
      case "google drive":
        return Icons.cloud;
      case "icloud":
        return Icons.cloud;
      case "dropbox":
        return Icons.cloud;
      case "local storage":
        return Icons.storage;
      default:
        return Icons.backup;
    }
  }

  List<String> _getBackupComponents(Map<String, dynamic> components) {
    List<String> included = [];
    if (components["contacts"]) included.add("Contacts");
    if (components["messages"]) included.add("Messages");
    if (components["photos"]) included.add("Photos");
    if (components["settings"]) included.add("Settings");
    if (components["apps"]) included.add("Apps");
    return included;
  }

  Future<void> _startRestore() async {
    bool isConfirmed = await confirm("Are you sure you want to start the restore process? Current data will be replaced.");
    
    if (isConfirmed) {
      isLoading = true;
      setState(() {});
      
      // Simulate restore process
      await Future.delayed(Duration(seconds: 5));
      
      isLoading = false;
      setState(() {});
      
      ss("Data restored successfully from backup!");
      
      // navigateTo(RestoreCompleteView());
    }
  }

  void _previewRestore() {
    Map<String, dynamic> selectedBackupData = availableBackups.firstWhere((backup) => backup["id"] == selectedBackup);
    
    // Show preview dialog or navigate to preview screen
    ss("Preview: Will restore ${_getSelectedComponentsCount()} data types from ${selectedBackupData["date"]}");
  }

  int _getSelectedComponentsCount() {
    int count = 0;
    if (restoreContacts) count++;
    if (restoreMessages) count++;
    if (restorePhotos) count++;
    if (restoreSettings) count++;
    if (restoreApps) count++;
    return count;
  }
}

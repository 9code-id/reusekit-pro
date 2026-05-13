import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive8View extends StatefulWidget {
  @override
  State<GrlArchive8View> createState() => _GrlArchive8ViewState();
}

class _GrlArchive8ViewState extends State<GrlArchive8View> {
  bool autoArchiveEnabled = true;
  int autoArchiveDays = 90;
  bool compressionEnabled = true;
  String compressionLevel = "Medium";
  bool encryptionEnabled = true;
  String retentionPeriod = "7 Years";
  bool notificationsEnabled = true;
  String backupSchedule = "Weekly";
  bool auditLoggingEnabled = true;
  String maxFileSize = "100 MB";

  List<Map<String, dynamic>> compressionOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
  ];

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 Year", "value": "1 Year"},
    {"label": "3 Years", "value": "3 Years"},
    {"label": "5 Years", "value": "5 Years"},
    {"label": "7 Years", "value": "7 Years"},
    {"label": "10 Years", "value": "10 Years"},
    {"label": "Permanent", "value": "Permanent"},
  ];

  List<Map<String, dynamic>> backupScheduleOptions = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> fileSizeOptions = [
    {"label": "10 MB", "value": "10 MB"},
    {"label": "50 MB", "value": "50 MB"},
    {"label": "100 MB", "value": "100 MB"},
    {"label": "500 MB", "value": "500 MB"},
    {"label": "1 GB", "value": "1 GB"},
  ];

  List<Map<String, dynamic>> storageStats = [
    {
      "title": "Total Storage",
      "value": "2.4 TB",
      "used": "1.8 TB",
      "percentage": 75,
      "icon": Icons.storage,
      "color": primaryColor,
    },
    {
      "title": "Archive Storage",
      "value": "1.2 TB",  
      "used": "890 GB",
      "percentage": 65,
      "icon": Icons.archive,
      "color": infoColor,
    },
    {
      "title": "Backup Storage", 
      "value": "800 GB",
      "used": "520 GB",
      "percentage": 65,
      "icon": Icons.backup,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Archive Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Storage Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Storage Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...storageStats.map((stat) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              stat["icon"],
                              color: stat["color"],
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${stat["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${stat["used"]} / ${stat["value"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            Container(
                              height: 8,
                              width: (MediaQuery.of(context).size.width - 96) * 
                                     (stat["percentage"] as int) / 100,
                              decoration: BoxDecoration(
                                color: stat["color"],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stat["percentage"]}% used",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Auto Archive Settings
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Auto Archive Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Auto Archive",
                        "value": true,
                        "checked": autoArchiveEnabled,
                      }
                    ],
                    value: [if (autoArchiveEnabled) {"label": "Enable Auto Archive", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoArchiveEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  if (autoArchiveEnabled) ...[
                    SizedBox(height: spSm),
                    QNumberField(
                      label: "Archive files after (days)",
                      value: autoArchiveDays.toString(),
                      hint: "Number of days before auto-archiving",
                      onChanged: (value) {
                        autoArchiveDays = int.tryParse(value) ?? 90;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Compression Settings
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.compress,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Compression Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Compression",
                        "value": true,
                        "checked": compressionEnabled,
                      }
                    ],
                    value: [if (compressionEnabled) {"label": "Enable Compression", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      compressionEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  if (compressionEnabled) ...[
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Compression Level",
                      items: compressionOptions,
                      value: compressionLevel,
                      onChanged: (value, label) {
                        compressionLevel = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Security Settings
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.security,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Security Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Encryption",
                        "value": true,
                        "checked": encryptionEnabled,
                      }
                    ],
                    value: [if (encryptionEnabled) {"label": "Enable Encryption", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      encryptionEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Audit Logging",
                        "value": true,
                        "checked": auditLoggingEnabled,
                      }
                    ],
                    value: [if (auditLoggingEnabled) {"label": "Enable Audit Logging", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      auditLoggingEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Retention Policy
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Retention Policy",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Retention Period",
                    items: retentionOptions,
                    value: retentionPeriod,
                    onChanged: (value, label) {
                      retentionPeriod = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Files will be permanently deleted after the retention period expires",
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
              ),
            ),

            // Backup Settings
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.backup,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Backup Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Backup Schedule",
                    items: backupScheduleOptions,
                    value: backupSchedule,
                    onChanged: (value, label) {
                      backupSchedule = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // File Size Limits
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.folder,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "File Size Limits",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Maximum File Size",
                    items: fileSizeOptions,
                    value: maxFileSize,
                    onChanged: (value, label) {
                      maxFileSize = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Notifications
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.notifications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Enable Notifications",
                        "value": true,
                        "checked": notificationsEnabled,
                      }
                    ],
                    value: [if (notificationsEnabled) {"label": "Enable Notifications", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      notificationsEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Save Settings",
                          icon: Icons.save,
                          size: bs.md,
                          onPressed: () {
                            _saveSettings();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reset to Default",
                          icon: Icons.refresh,
                          size: bs.md,
                          onPressed: () {
                            _resetToDefault();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Test Backup",
                          icon: Icons.backup,
                          size: bs.md,
                          onPressed: () {
                            _testBackup();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Config",
                          icon: Icons.file_download,
                          size: bs.md,
                          onPressed: () {
                            _exportConfig();
                          },
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

  void _saveSettings() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Settings saved successfully");
  }

  void _resetToDefault() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default values?");
    
    if (isConfirmed) {
      setState(() {
        autoArchiveEnabled = true;
        autoArchiveDays = 90;
        compressionEnabled = true;
        compressionLevel = "Medium";
        encryptionEnabled = true;
        retentionPeriod = "7 Years";
        notificationsEnabled = true;
        backupSchedule = "Weekly";
        auditLoggingEnabled = true;
        maxFileSize = "100 MB";
      });
      
      ss("Settings reset to default values");
    }
  }

  void _testBackup() async {
    showLoading();
    
    // Simulate backup test
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Backup test completed successfully");
  }

  void _exportConfig() {
    // Handle config export
    ss("Configuration exported successfully");
  }
}

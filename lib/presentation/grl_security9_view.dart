import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity9View extends StatefulWidget {
  @override
  State<GrlSecurity9View> createState() => _GrlSecurity9ViewState();
}

class _GrlSecurity9ViewState extends State<GrlSecurity9View> {
  bool encryptionEnabled = true;
  bool backupEncrypted = true;
  bool autoBackupEnabled = true;
  String selectedBackupFrequency = 'daily';
  
  List<Map<String, dynamic>> encryptionFeatures = [
    {
      "title": "End-to-End Encryption",
      "description": "Messages are encrypted on your device and can only be decrypted by the recipient",
      "icon": Icons.lock,
      "enabled": true,
      "status": "active",
    },
    {
      "title": "Local Data Encryption",
      "description": "All data stored on your device is encrypted using AES-256",
      "icon": Icons.storage,
      "enabled": true,
      "status": "active",
    },
    {
      "title": "Backup Encryption",
      "description": "Cloud backups are encrypted before being uploaded",
      "icon": Icons.cloud_upload,
      "enabled": true,
      "status": "active",
    },
    {
      "title": "Key Management",
      "description": "Encryption keys are managed securely on device",
      "icon": Icons.key,
      "enabled": true,
      "status": "active",
    },
  ];

  List<Map<String, dynamic>> backupStatus = [
    {
      "type": "Messages",
      "lastBackup": "2 hours ago",
      "size": "156 MB",
      "status": "completed",
      "encrypted": true,
    },
    {
      "type": "Media Files",
      "lastBackup": "5 hours ago", 
      "size": "2.3 GB",
      "status": "completed",
      "encrypted": true,
    },
    {
      "type": "Settings",
      "lastBackup": "1 day ago",
      "size": "2.1 MB",
      "status": "completed",
      "encrypted": true,
    },
    {
      "type": "Contacts",
      "lastBackup": "3 days ago",
      "size": "485 KB",
      "status": "pending",
      "encrypted": true,
    },
  ];

  List<Map<String, dynamic>> backupOptions = [
    {"label": "Never", "value": "never"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption & Backup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encryption Status
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Encryption Status",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                              "FULLY ENCRYPTED",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Your data is protected with military-grade encryption",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "AES-256",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Encryption Features
            Text(
              "Encryption Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...encryptionFeatures.map((feature) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(color: successColor.withAlpha(102), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        feature["icon"] as IconData,
                        color: successColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${feature["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "ACTIVE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${feature["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Backup Settings
            Container(
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
                        Icons.backup,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
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
                  SizedBox(height: spMd),
                  
                  // Auto Backup Toggle
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Automatic Backup",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Automatically backup data to secure cloud storage",
                              style: TextStyle(
                                fontSize: 14,
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
                          if (value) {
                            ss("Automatic backup enabled");
                          } else {
                            sw("Automatic backup disabled");
                          }
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                  
                  if (autoBackupEnabled) ...[
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Backup Frequency",
                      items: backupOptions,
                      value: selectedBackupFrequency,
                      onChanged: (value, label) {
                        selectedBackupFrequency = value;
                        setState(() {});
                        ss("Backup frequency updated to $label");
                      },
                    ),
                  ],
                  
                  SizedBox(height: spMd),
                  
                  // Encrypted Backup Toggle
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Encrypted Backups",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Encrypt backups before uploading to cloud",
                              style: TextStyle(
                                fontSize: 14, 
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: backupEncrypted,
                        onChanged: (value) async {
                          if (!value) {
                            bool isConfirmed = await confirm("Disabling backup encryption will make your backups less secure. Continue?");
                            if (!isConfirmed) return;
                          }
                          backupEncrypted = value;
                          setState(() {});
                          if (value) {
                            ss("Backup encryption enabled");
                          } else {
                            sw("Backup encryption disabled");
                          }
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Backup Status
            Text(
              "Backup Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...backupStatus.map((backup) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getBackupStatusColor(backup["status"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getBackupStatusColor(backup["status"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getBackupIcon(backup["type"]),
                        color: _getBackupStatusColor(backup["status"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${backup["type"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spXs),
                              if (backup["encrypted"] as bool)
                                Icon(
                                  Icons.lock,
                                  color: successColor,
                                  size: 16,
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Last backup: ${backup["lastBackup"]} • ${backup["size"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                        color: _getBackupStatusColor(backup["status"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${backup["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getBackupStatusColor(backup["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Backup Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Backup Now",
                    size: bs.md,
                    onPressed: () async {
                      showLoading();
                      await Future.delayed(Duration(seconds: 3));
                      hideLoading();
                      ss("Backup completed successfully");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: QButton(
                      label: "Restore",
                      size: bs.md,
                      onPressed: () async {
                        bool isConfirmed = await confirm("This will restore data from your latest backup. Current data may be overwritten. Continue?");
                        if (isConfirmed) {
                          showLoading();
                          await Future.delayed(Duration(seconds: 4));
                          hideLoading();
                          ss("Data restored successfully");
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Encryption Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(102)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "About Encryption",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• AES-256 encryption protects your data\n• Only you can decrypt your data with your device key\n• Backups are encrypted before leaving your device\n• Even we cannot access your encrypted data\n• Your encryption keys never leave your device",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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

  Color _getBackupStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getBackupIcon(String type) {
    switch (type.toLowerCase()) {
      case 'messages':
        return Icons.message;
      case 'media files':
        return Icons.photo_library;
      case 'settings':
        return Icons.settings;
      case 'contacts':
        return Icons.contacts;
      default:
        return Icons.backup;
    }
  }
}

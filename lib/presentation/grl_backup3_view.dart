import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup3View extends StatefulWidget {
  @override
  State<GrlBackup3View> createState() => _GrlBackup3ViewState();
}

class _GrlBackup3ViewState extends State<GrlBackup3View> {
  bool isAutoSync = true;
  bool isEncryptionEnabled = true;
  bool isWifiOnly = false;
  bool isLowBatteryMode = true;
  String selectedFrequency = 'daily';
  String selectedRetention = '30';
  int maxBackupSize = 5;
  bool isAdvancedMode = false;

  List<Map<String, dynamic>> backupTypes = [
    {
      "type": "contacts",
      "label": "Contacts",
      "icon": Icons.contacts,
      "enabled": true,
      "size": "2.5 MB",
      "count": 1247,
      "lastBackup": "2 hours ago",
    },
    {
      "type": "photos",
      "label": "Photos & Videos",
      "icon": Icons.photo_library,
      "enabled": true,
      "size": "1.2 GB",
      "count": 3456,
      "lastBackup": "4 hours ago",
    },
    {
      "type": "messages",
      "label": "Messages",
      "icon": Icons.message,
      "enabled": false,
      "size": "156 MB",
      "count": 2891,
      "lastBackup": "1 day ago",
    },
    {
      "type": "documents",
      "label": "Documents",
      "icon": Icons.folder,
      "enabled": true,
      "size": "89 MB",
      "count": 234,
      "lastBackup": "6 hours ago",
    },
    {
      "type": "settings",
      "label": "App Settings",
      "icon": Icons.settings,
      "enabled": true,
      "size": "12 MB",
      "count": 67,
      "lastBackup": "1 hour ago",
    },
    {
      "type": "calendar",
      "label": "Calendar Events",
      "icon": Icons.calendar_today,
      "enabled": false,
      "size": "3.4 MB",
      "count": 156,
      "lastBackup": "2 days ago",
    },
  ];

  List<Map<String, dynamic>> syncHistory = [
    {
      "date": "2024-01-22 14:30",
      "status": "success",
      "type": "Auto Sync",
      "size": "456 MB",
      "duration": "2m 34s",
    },
    {
      "date": "2024-01-22 02:15",
      "status": "success",
      "type": "Scheduled",
      "size": "123 MB",
      "duration": "1m 12s",
    },
    {
      "date": "2024-01-21 14:30",
      "status": "failed",
      "type": "Manual",
      "size": "0 MB",
      "duration": "0s",
      "error": "Network timeout",
    },
    {
      "date": "2024-01-21 02:15",
      "status": "success",
      "type": "Scheduled",
      "size": "789 MB",
      "duration": "3m 45s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _performSync();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sync Status Card
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
                      Icon(
                        Icons.cloud_done,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sync Active",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Last sync: 2 hours ago",
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
                          "1.8 GB",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                              "Next Sync",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "Tomorrow at 2:00 AM",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Sync Now",
                        size: bs.sm,
                        onPressed: () {
                          _performSync();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Quick Settings
            Text(
              "Quick Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Auto Sync Toggle
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isAutoSync ? successColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.sync,
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
                                "Auto Sync",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Automatically sync data when connected",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isAutoSync,
                          onChanged: (value) {
                            setState(() {
                              isAutoSync = value;
                            });
                          },
                          activeColor: successColor,
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1),

                  // Encryption Toggle
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isEncryptionEnabled ? warningColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.security,
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
                                "Encryption",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Encrypt data before uploading",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isEncryptionEnabled,
                          onChanged: (value) {
                            setState(() {
                              isEncryptionEnabled = value;
                            });
                          },
                          activeColor: warningColor,
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1),

                  // WiFi Only Toggle
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isWifiOnly ? infoColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.wifi,
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
                                "WiFi Only",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Only sync when connected to WiFi",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isWifiOnly,
                          onChanged: (value) {
                            setState(() {
                              isWifiOnly = value;
                            });
                          },
                          activeColor: infoColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Sync Frequency
            Text(
              "Sync Frequency",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            QDropdownField(
              label: "Backup Frequency",
              items: [
                {"label": "Every Hour", "value": "hourly"},
                {"label": "Daily", "value": "daily"},
                {"label": "Weekly", "value": "weekly"},
                {"label": "Monthly", "value": "monthly"},
                {"label": "Manual Only", "value": "manual"},
              ],
              value: selectedFrequency,
              onChanged: (value, label) {
                selectedFrequency = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Data Types
            Text(
              "Data Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: backupTypes.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> type = entry.value;
                  bool isLast = index == backupTypes.length - 1;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: type["enabled"] as bool ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                type["icon"] as IconData,
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
                                    "${type["label"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${type["count"]} items • ${type["size"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Last backup: ${type["lastBackup"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: type["enabled"] as bool ? successColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: type["enabled"] as bool,
                              onChanged: (value) {
                                setState(() {
                                  type["enabled"] = value;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      ),
                      if (!isLast) Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Advanced Settings
            Row(
              children: [
                Text(
                  "Advanced Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAdvancedMode = !isAdvancedMode;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isAdvancedMode ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isAdvancedMode ? "Hide" : "Show",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          isAdvancedMode ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (isAdvancedMode) ...[
              SizedBox(height: spMd),

              QDropdownField(
                label: "Backup Retention",
                items: [
                  {"label": "7 Days", "value": "7"},
                  {"label": "30 Days", "value": "30"},
                  {"label": "90 Days", "value": "90"},
                  {"label": "1 Year", "value": "365"},
                  {"label": "Forever", "value": "forever"},
                ],
                value: selectedRetention,
                onChanged: (value, label) {
                  selectedRetention = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              // Storage Limit
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
                    Text(
                      "Maximum Backup Size",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${maxBackupSize} GB",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Slider(
                      value: maxBackupSize.toDouble(),
                      min: 1,
                      max: 100,
                      divisions: 99,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          maxBackupSize = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Low Battery Mode
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.battery_saver,
                      color: isLowBatteryMode ? warningColor : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Low Battery Mode",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Pause sync when battery is below 20%",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isLowBatteryMode,
                      onChanged: (value) {
                        setState(() {
                          isLowBatteryMode = value;
                        });
                      },
                      activeColor: warningColor,
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spMd),

            // Sync History
            Text(
              "Recent Sync History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: syncHistory.take(4).toList().asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> sync = entry.value;
                  bool isLast = index == 3;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: sync["status"] == "success" ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                sync["status"] == "success" ? Icons.check : Icons.error,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${sync["type"]} Sync",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${sync["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (sync["status"] == "failed" && sync["error"] != null)
                                    Text(
                                      "${sync["error"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${sync["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${sync["duration"]}",
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
                      if (!isLast) Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View All History",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(SyncHistoryView());
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Reset Settings",
                    size: bs.md,
                    onPressed: () {
                      _resetSettings();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _performSync() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Sync completed successfully");
  }

  void _resetSettings() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all sync settings to default?");
    if (isConfirmed) {
      setState(() {
        isAutoSync = true;
        isEncryptionEnabled = true;
        isWifiOnly = false;
        isLowBatteryMode = true;
        selectedFrequency = 'daily';
        selectedRetention = '30';
        maxBackupSize = 5;
        isAdvancedMode = false;
        
        for (var type in backupTypes) {
          type["enabled"] = true;
        }
      });
      ss("Settings reset to default");
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sync Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Auto Sync: Automatically sync when conditions are met"),
            SizedBox(height: spSm),
            Text("• Encryption: Secure your data with end-to-end encryption"),
            SizedBox(height: spSm),
            Text("• WiFi Only: Save mobile data by syncing only on WiFi"),
            SizedBox(height: spSm),
            Text("• Low Battery Mode: Preserve battery when it's low"),
          ],
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

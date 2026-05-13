import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBackupRestoreView extends StatefulWidget {
  const BrsBackupRestoreView({super.key});

  @override
  State<BrsBackupRestoreView> createState() => _BrsBackupRestoreViewState();
}

class _BrsBackupRestoreViewState extends State<BrsBackupRestoreView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "daily";
  bool cloudBackupEnabled = true;
  String lastBackupDate = "2024-06-15 10:30 AM";
  bool loading = false;

  final List<Map<String, dynamic>> backupHistory = [
    {
      "date": "2024-06-15",
      "time": "10:30 AM",
      "type": "Automatic",
      "size": "2.5 MB",
      "status": "success",
      "items": 150,
    },
    {
      "date": "2024-06-14",
      "time": "10:30 AM",
      "type": "Automatic",
      "size": "2.3 MB",
      "status": "success",
      "items": 145,
    },
    {
      "date": "2024-06-13",
      "time": "03:15 PM",
      "type": "Manual",
      "size": "2.1 MB",
      "status": "success",
      "items": 140,
    },
    {
      "date": "2024-06-12",
      "time": "10:30 AM",
      "type": "Automatic",
      "size": "1.9 MB",
      "status": "failed",
      "items": 0,
    },
  ];

  final List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  final List<Map<String, dynamic>> dataTypes = [
    {
      "name": "Appointments",
      "description": "All booking and appointment data",
      "icon": Icons.calendar_today,
      "enabled": true,
      "count": 45,
    },
    {
      "name": "Customer Data",
      "description": "Customer profiles and preferences",
      "icon": Icons.people,
      "enabled": true,
      "count": 120,
    },
    {
      "name": "Service Records",
      "description": "Service history and details",
      "icon": Icons.content_cut,
      "enabled": true,
      "count": 85,
    },
    {
      "name": "Payment History",
      "description": "Transaction and payment records",
      "icon": Icons.payment,
      "enabled": false,
      "count": 200,
    },
    {
      "name": "Staff Information",
      "description": "Barber profiles and schedules",
      "icon": Icons.badge,
      "enabled": true,
      "count": 8,
    },
  ];

  void _performBackup() async {
    loading = true;
    setState(() {});

    // Simulate backup process
    await Future.delayed(Duration(seconds: 3));

    loading = false;
    lastBackupDate = DateTime.now().toString().substring(0, 16);
    setState(() {});
    
    ss("Backup completed successfully!");
  }

  void _restoreFromBackup(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("Restore data from ${backup["date"]}? This will replace current data.");
    
    if (isConfirmed) {
      loading = true;
      setState(() {});

      // Simulate restore process
      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});
      
      ss("Data restored successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
      ),
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: primaryColor),
                  SizedBox(height: spMd),
                  Text(
                    "Processing...",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Backup Status
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cloud_done,
                              color: successColor,
                              size: 30,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Backup Status: Active",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Last backup: $lastBackupDate",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Backup Now",
                            icon: Icons.backup,
                            size: bs.md,
                            onPressed: _performBackup,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Auto Backup Settings
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Automatic Backup",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QSwitch(
                                items: [
                                  {
                                    "label": "Enable automatic backup",
                                    "value": true,
                                    "checked": autoBackupEnabled,
                                  }
                                ],
                                value: [
                                  if (autoBackupEnabled)
                                    {
                                      "label": "Enable automatic backup",
                                      "value": true,
                                      "checked": true
                                    }
                                ],
                                onChanged: (values, ids) {
                                  autoBackupEnabled = values.isNotEmpty;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        if (autoBackupEnabled) ...[
                          QDropdownField(
                            label: "Backup Frequency",
                            items: backupFrequencyOptions,
                            value: backupFrequency,
                            onChanged: (value, label) {
                              backupFrequency = value;
                              setState(() {});
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QSwitch(
                                  items: [
                                    {
                                      "label": "Store in cloud",
                                      "value": true,
                                      "checked": cloudBackupEnabled,
                                    }
                                  ],
                                  value: [
                                    if (cloudBackupEnabled)
                                      {
                                        "label": "Store in cloud",
                                        "value": true,
                                        "checked": true
                                      }
                                  ],
                                  onChanged: (values, ids) {
                                    cloudBackupEnabled = values.isNotEmpty;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Data Selection
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Data to Backup",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...dataTypes.map((dataType) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: dataType["enabled"] 
                                  ? primaryColor.withAlpha(10) 
                                  : disabledColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  dataType["icon"] as IconData,
                                  color: dataType["enabled"] 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${dataType["name"]} (${dataType["count"]} items)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: dataType["enabled"] 
                                              ? primaryColor 
                                              : disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${dataType["description"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: dataType["enabled"],
                                  onChanged: (value) {
                                    dataType["enabled"] = value;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Backup History
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Backup History",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            QButton(
                              label: "Clear History",
                              size: bs.sm,
                              onPressed: () async {
                                bool isConfirmed = await confirm("Clear backup history? This won't delete actual backups.");
                                if (isConfirmed) {
                                  sw("Backup history cleared");
                                }
                              },
                            ),
                          ],
                        ),
                        ...backupHistory.map((backup) {
                          final isSuccess = backup["status"] == "success";
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: isSuccess 
                                  ? successColor.withAlpha(10) 
                                  : dangerColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSuccess 
                                    ? successColor.withAlpha(50) 
                                    : dangerColor.withAlpha(50),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSuccess ? Icons.check_circle : Icons.error,
                                  color: isSuccess ? successColor : dangerColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${backup["date"]} ${backup["time"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${backup["size"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${backup["type"]} Backup",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          if (isSuccess)
                                            Text(
                                              "${backup["items"]} items",
                                              style: TextStyle(
                                                color: successColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSuccess) ...[
                                  SizedBox(width: spSm),
                                  QButton(
                                    label: "Restore",
                                    size: bs.sm,
                                    onPressed: () => _restoreFromBackup(backup),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Storage Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Storage Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cloud Storage Used",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            Text(
                              "12.5 MB / 100 MB",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 0.125,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Local Storage Used",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            Text(
                              "8.2 MB",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Backups",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            Text(
                              "15 backups",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Emergency Restore
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Emergency Options",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Use these options only in case of data loss or corruption",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Factory Reset",
                                size: bs.sm,
                                onPressed: () async {
                                  bool isConfirmed = await confirm("Factory reset will delete ALL data. Are you sure?");
                                  if (isConfirmed) {
                                    se("Factory reset cancelled for safety");
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: QButton(
                                label: "Import Backup",
                                size: bs.sm,
                                onPressed: () {
                                  si("Opening file picker for backup import...");
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
}

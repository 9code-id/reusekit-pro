import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshSystemMaintenanceView extends StatefulWidget {
  const CshSystemMaintenanceView({super.key});

  @override
  State<CshSystemMaintenanceView> createState() => _CshSystemMaintenanceViewState();
}

class _CshSystemMaintenanceViewState extends State<CshSystemMaintenanceView> {
  bool maintenanceMode = false;
  bool autoMaintenance = true;
  bool cleanupLogs = true;
  bool optimizeDatabase = true;
  bool clearCache = true;
  bool updateIndexes = true;
  String maintenanceWindow = "02:00 AM - 04:00 AM";
  String maintenanceFrequency = "Weekly";
  String logRetention = "30 days";
  
  List<Map<String, dynamic>> windowOptions = [
    {"label": "12:00 AM - 02:00 AM", "value": "00:00 AM - 02:00 AM"},
    {"label": "02:00 AM - 04:00 AM", "value": "02:00 AM - 04:00 AM"},
    {"label": "04:00 AM - 06:00 AM", "value": "04:00 AM - 06:00 AM"},
    {"label": "10:00 PM - 12:00 AM", "value": "22:00 PM - 00:00 AM"},
  ];
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];
  
  List<Map<String, dynamic>> retentionOptions = [
    {"label": "7 days", "value": "7 days"},
    {"label": "30 days", "value": "30 days"},
    {"label": "90 days", "value": "90 days"},
    {"label": "1 year", "value": "1 year"},
  ];

  List<Map<String, dynamic>> systemStats = [
    {
      "metric": "CPU Usage",
      "value": "23%",
      "status": "Normal",
      "trend": "down",
      "icon": Icons.memory,
      "color": successColor,
    },
    {
      "metric": "Memory Usage",
      "value": "67%",
      "status": "Normal",
      "trend": "stable",
      "icon": Icons.developer_board,
      "color": successColor,
    },
    {
      "metric": "Disk Usage",
      "value": "85%",
      "status": "Warning",
      "trend": "up",
      "icon": Icons.storage,
      "color": warningColor,
    },
    {
      "metric": "Network Load",
      "value": "45%",
      "status": "Normal",
      "trend": "stable",
      "icon": Icons.network_check,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> maintenanceHistory = [
    {
      "date": "2024-01-15",
      "time": "02:00 AM",
      "type": "Automatic",
      "duration": "45 minutes",
      "status": "Completed",
      "tasks": "Database optimization, Cache cleanup, Log rotation",
    },
    {
      "date": "2024-01-08",
      "time": "02:00 AM",
      "type": "Automatic",
      "duration": "38 minutes",
      "status": "Completed",
      "tasks": "Database optimization, Cache cleanup, Log rotation",
    },
    {
      "date": "2024-01-05",
      "time": "10:30 AM",
      "type": "Manual",
      "duration": "25 minutes",
      "status": "Completed",
      "tasks": "Emergency database repair",
    },
    {
      "date": "2024-01-01",
      "time": "02:00 AM",
      "type": "Automatic",
      "duration": "52 minutes",
      "status": "Partial",
      "tasks": "Database optimization (failed), Cache cleanup, Log rotation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Maintenance"),
        actions: [
          IconButton(
            onPressed: () {
              _refreshSystemStatus();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // System Status Section
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
                    "System Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: systemStats.map((stat) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: (stat["color"] as Color).withAlpha(100)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  stat["icon"] as IconData,
                                  color: stat["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${stat["metric"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  stat["trend"] == "up" ? Icons.trending_up :
                                  stat["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                                  color: stat["trend"] == "up" ? dangerColor :
                                  stat["trend"] == "down" ? successColor : disabledBoldColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            Text(
                              "${stat["value"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: stat["color"] as Color,
                              ),
                            ),
                            Text(
                              "${stat["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: stat["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Maintenance Mode Section
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
                    "Maintenance Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: maintenanceMode ? warningColor.withAlpha(20) : successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: maintenanceMode ? warningColor.withAlpha(100) : successColor.withAlpha(100),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          maintenanceMode ? Icons.construction : Icons.check_circle,
                          color: maintenanceMode ? warningColor : successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            maintenanceMode ? "System is in maintenance mode" : "System is operational",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: maintenanceMode ? warningColor : successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QSwitch(
                    label: "Enable Maintenance Mode",
                    items: [
                      {
                        "label": "Put system in maintenance mode",
                        "value": true,
                        "checked": maintenanceMode,
                      }
                    ],
                    value: [if (maintenanceMode) {"label": "Put system in maintenance mode", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      maintenanceMode = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Automatic Maintenance Section
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
                    "Automatic Maintenance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Auto Maintenance",
                    items: [
                      {
                        "label": "Enable automatic maintenance",
                        "value": true,
                        "checked": autoMaintenance,
                      }
                    ],
                    value: [if (autoMaintenance) {"label": "Enable automatic maintenance", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoMaintenance = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Maintenance Window",
                    items: windowOptions,
                    value: maintenanceWindow,
                    onChanged: (value, label) {
                      maintenanceWindow = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Maintenance Frequency",
                    items: frequencyOptions,
                    value: maintenanceFrequency,
                    onChanged: (value, label) {
                      maintenanceFrequency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Maintenance Tasks Section
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
                    "Maintenance Tasks",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    label: "Cleanup Logs",
                    items: [
                      {
                        "label": "Clean up old log files",
                        "value": true,
                        "checked": cleanupLogs,
                      }
                    ],
                    value: [if (cleanupLogs) {"label": "Clean up old log files", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      cleanupLogs = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Log Retention Period",
                    items: retentionOptions,
                    value: logRetention,
                    onChanged: (value, label) {
                      logRetention = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Optimize Database",
                    items: [
                      {
                        "label": "Run database optimization",
                        "value": true,
                        "checked": optimizeDatabase,
                      }
                    ],
                    value: [if (optimizeDatabase) {"label": "Run database optimization", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      optimizeDatabase = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Clear Cache",
                    items: [
                      {
                        "label": "Clear system cache",
                        "value": true,
                        "checked": clearCache,
                      }
                    ],
                    value: [if (clearCache) {"label": "Clear system cache", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      clearCache = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Update Indexes",
                    items: [
                      {
                        "label": "Rebuild database indexes",
                        "value": true,
                        "checked": updateIndexes,
                      }
                    ],
                    value: [if (updateIndexes) {"label": "Rebuild database indexes", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      updateIndexes = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Maintenance History Section
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
                    children: [
                      Text(
                        "Maintenance History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _viewFullHistory();
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(maintenanceHistory.length, (index) {
                    final history = maintenanceHistory[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: history["status"] == "Completed" ? successColor.withAlpha(20) :
                               history["status"] == "Partial" ? warningColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: history["status"] == "Completed" ? successColor.withAlpha(100) :
                                 history["status"] == "Partial" ? warningColor.withAlpha(100) : dangerColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                history["status"] == "Completed" ? Icons.check_circle :
                                history["status"] == "Partial" ? Icons.warning : Icons.error,
                                color: history["status"] == "Completed" ? successColor :
                                       history["status"] == "Partial" ? warningColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${history["date"]} at ${history["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${history["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Duration: ${history["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${history["tasks"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Manual Actions Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Manual Maintenance Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Run Maintenance",
                          icon: Icons.build,
                          size: bs.md,
                          onPressed: () {
                            _runManualMaintenance();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "System Diagnostics",
                          icon: Icons.analytics,
                          size: bs.md,
                          onPressed: () {
                            _runDiagnostics();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Clear Cache Now",
                          icon: Icons.clear_all,
                          size: bs.md,
                          onPressed: () {
                            _clearCacheNow();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Restart Services",
                          icon: Icons.restart_alt,
                          size: bs.md,
                          onPressed: () {
                            _restartServices();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Maintenance Settings",
                      icon: Icons.save,
                      size: bs.md,
                      onPressed: () {
                        _saveMaintenanceSettings();
                      },
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

  void _refreshSystemStatus() {
    ss("System status refreshed");
  }

  void _runManualMaintenance() async {
    bool isConfirmed = await confirm("Run manual maintenance now? This may affect system performance.");
    if (isConfirmed) {
      ss("Manual maintenance started");
    }
  }

  void _runDiagnostics() {
    ss("System diagnostics initiated");
  }

  void _clearCacheNow() async {
    bool isConfirmed = await confirm("Clear all system cache now?");
    if (isConfirmed) {
      ss("System cache cleared");
    }
  }

  void _restartServices() async {
    bool isConfirmed = await confirm("Restart all system services? This will temporarily interrupt service.");
    if (isConfirmed) {
      ss("System services restarted");
    }
  }

  void _viewFullHistory() {
    ss("Full maintenance history opened");
  }

  void _saveMaintenanceSettings() {
    ss("Maintenance settings saved successfully");
  }
}

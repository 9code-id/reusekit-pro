import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings9View extends StatefulWidget {
  @override
  State<GrlSettings9View> createState() => _GrlSettings9ViewState();
}

class _GrlSettings9ViewState extends State<GrlSettings9View> {
  bool debugMode = false;
  bool showPerformanceOverlay = false;
  bool enableLogging = true;
  bool crashReporting = true;
  String logLevel = "Info";
  String environment = "Production";
  
  List<Map<String, dynamic>> logLevelOptions = [
    {"label": "Verbose", "value": "Verbose"},
    {"label": "Debug", "value": "Debug"},
    {"label": "Info", "value": "Info"},
    {"label": "Warning", "value": "Warning"},
    {"label": "Error", "value": "Error"},
  ];
  
  List<Map<String, dynamic>> environmentOptions = [
    {"label": "Production", "value": "Production"},
    {"label": "Staging", "value": "Staging"},
    {"label": "Development", "value": "Development"},
  ];

  List<Map<String, dynamic>> debugTools = [
    {
      "name": "Memory Inspector",
      "description": "Monitor app memory usage",
      "icon": Icons.memory,
      "enabled": false
    },
    {
      "name": "Network Logger",
      "description": "Log all network requests",
      "icon": Icons.network_check,
      "enabled": true
    },
    {
      "name": "Widget Inspector",
      "description": "Inspect widget tree",
      "icon": Icons.widgets,
      "enabled": false
    },
    {
      "name": "Performance Monitor",
      "description": "Track frame rates and performance",
      "icon": Icons.speed,
      "enabled": true
    },
  ];

  List<Map<String, dynamic>> recentLogs = [
    {
      "timestamp": "14:32:15",
      "level": "Info",
      "message": "User authenticated successfully",
      "source": "AuthService",
      "color": infoColor
    },
    {
      "timestamp": "14:31:42",
      "level": "Warning",
      "message": "Slow network connection detected",
      "source": "NetworkManager",
      "color": warningColor
    },
    {
      "timestamp": "14:30:18",
      "level": "Debug",
      "message": "Cache refresh initiated",
      "source": "CacheManager",
      "color": primaryColor
    },
    {
      "timestamp": "14:29:55",
      "level": "Error",
      "message": "Failed to load user preferences",
      "source": "PrefsService",
      "color": dangerColor
    },
    {
      "timestamp": "14:28:33",
      "level": "Info",
      "message": "App started successfully",
      "source": "Main",
      "color": successColor
    },
  ];

  List<Map<String, dynamic>> systemStats = [
    {
      "name": "Memory Usage",
      "value": "185.4 MB",
      "detail": "of 8 GB available",
      "icon": Icons.memory,
      "color": primaryColor
    },
    {
      "name": "CPU Usage",
      "value": "12.3%",
      "detail": "Average over last minute",
      "icon": Icons.developer_board,
      "color": successColor
    },
    {
      "name": "Battery Impact",
      "value": "Low",
      "detail": "3.2% in last hour",
      "icon": Icons.battery_full,
      "color": successColor
    },
    {
      "name": "Network Usage",
      "value": "2.4 MB",
      "detail": "Downloaded today",
      "icon": Icons.network_cell,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> developerActions = [
    {
      "name": "Clear Cache",
      "description": "Remove all cached data",
      "icon": Icons.clear_all,
      "dangerous": false
    },
    {
      "name": "Reset Database",
      "description": "Clear all local database data",
      "icon": Icons.storage,
      "dangerous": true
    },
    {
      "name": "Force Crash",
      "description": "Test crash reporting system",
      "icon": Icons.bug_report,
      "dangerous": true
    },
    {
      "name": "Export Logs",
      "description": "Save logs to file",
      "icon": Icons.file_download,
      "dangerous": false
    },
    {
      "name": "Reset Settings",
      "description": "Reset all app settings to default",
      "icon": Icons.settings_backup_restore,
      "dangerous": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer Settings"),
        actions: [
          QButton(
            icon: Icons.code,
            size: bs.sm,
            onPressed: () {
              si("Advanced developer tools coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Warning Banner
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                border: Border.all(color: warningColor.withAlpha(100)),
                borderRadius: BorderRadius.circular(radiusLg),
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
                          "Developer Mode",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "These settings are for development and debugging only. Use with caution.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Debug Settings
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
                        Icons.bug_report,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Debug Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildDebugToggle(
                    Icons.developer_mode,
                    "Debug Mode",
                    "Enable advanced debugging features",
                    debugMode,
                    (value) {
                      debugMode = value;
                      setState(() {});
                      if (value) {
                        sw("Debug mode enabled - Performance may be affected");
                      } else {
                        si("Debug mode disabled");
                      }
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildDebugToggle(
                    Icons.speed,
                    "Performance Overlay",
                    "Show frame rate and performance metrics",
                    showPerformanceOverlay,
                    (value) {
                      showPerformanceOverlay = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildDebugToggle(
                    Icons.article,
                    "Enable Logging",
                    "Record app events and errors",
                    enableLogging,
                    (value) {
                      enableLogging = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildDebugToggle(
                    Icons.report,
                    "Crash Reporting",
                    "Automatically report crashes",
                    crashReporting,
                    (value) {
                      crashReporting = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Configuration
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Configuration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Log Level",
                    items: logLevelOptions,
                    value: logLevel,
                    onChanged: (value, label) {
                      logLevel = value;
                      setState(() {});
                      si("Log level changed to ${label}");
                    },
                  ),
                  
                  QDropdownField(
                    label: "Environment",
                    items: environmentOptions,
                    value: environment,
                    onChanged: (value, label) {
                      environment = value;
                      setState(() {});
                      sw("Environment changed to ${label} - App restart required");
                    },
                  ),
                ],
              ),
            ),

            // Debug Tools
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
                        Icons.build,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Debug Tools",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...debugTools.map((tool) => _buildDebugTool(tool)),
                ],
              ),
            ),

            // System Statistics
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
                        Icons.analytics,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "System Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: systemStats.map((stat) => _buildSystemStat(stat)).toList(),
                  ),
                ],
              ),
            ),

            // Recent Logs
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
                        Icons.list_alt,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Recent Logs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("Full log viewer coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recentLogs.map((log) => _buildLogEntry(log)).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Developer Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.construction,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Developer Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...developerActions.map((action) => _buildDeveloperAction(action)),
                ],
              ),
            ),

            // Reset Warning
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                border: Border.all(color: dangerColor.withAlpha(100)),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Dangerous Actions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "The actions above marked as dangerous can cause data loss or app instability. Use only for testing purposes.",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
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

  Widget _buildDebugToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDebugTool(Map<String, dynamic> tool) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              tool["icon"],
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
                  "${tool["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${tool["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: tool["enabled"],
            onChanged: (value) {
              tool["enabled"] = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStat(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
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
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${stat["name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: stat["color"],
            ),
          ),
          Text(
            "${stat["detail"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(Map<String, dynamic> log) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "[${log["timestamp"]}]",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(width: spXs),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: log["color"].withAlpha(30),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              "${log["level"]}",
              style: TextStyle(
                fontSize: 9,
                color: log["color"],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              "${log["source"]}: ${log["message"]}",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperAction(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () {
        _performDeveloperAction(action);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              action["icon"],
              color: action["dangerous"] ? dangerColor : primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${action["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: action["dangerous"] ? dangerColor : primaryColor,
                        ),
                      ),
                      if (action["dangerous"]) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 14,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    "${action["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _performDeveloperAction(Map<String, dynamic> action) async {
    if (action["dangerous"]) {
      bool isConfirmed = await confirm("This action is dangerous and may cause data loss. Are you sure you want to proceed?");
      if (!isConfirmed) return;
    }

    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();

    switch (action["name"]) {
      case "Clear Cache":
        ss("Cache cleared successfully");
        break;
      case "Reset Database":
        se("Database reset completed");
        break;
      case "Force Crash":
        se("Crash test triggered");
        break;
      case "Export Logs":
        ss("Logs exported successfully");
        break;
      case "Reset Settings":
        ss("Settings reset to defaults");
        break;
    }
  }
}

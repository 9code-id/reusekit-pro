import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage6View extends StatefulWidget {
  @override
  State<GrlStorage6View> createState() => _GrlStorage6ViewState();
}

class _GrlStorage6ViewState extends State<GrlStorage6View> {
  int selectedTabIndex = 0;
  String backupLocation = "Cloud Storage";
  bool autoBackup = true;
  bool encryptBackup = false;
  String backupFrequency = "Daily";

  List<Map<String, dynamic>> backupTasks = [
    {
      "name": "System Backup",
      "type": "Full System",
      "status": "Completed",
      "size": "24.8 GB",
      "date": "2025-06-22 02:00 AM",
      "nextRun": "2025-06-23 02:00 AM",
      "icon": Icons.computer,
      "color": successColor,
      "progress": 100
    },
    {
      "name": "Documents Backup",
      "type": "Incremental",
      "status": "In Progress",
      "size": "2.1 GB",
      "date": "2025-06-22 10:30 AM",
      "nextRun": "2025-06-22 06:30 PM",
      "icon": Icons.description,
      "color": infoColor,
      "progress": 67
    },
    {
      "name": "Media Backup",
      "type": "Selective",
      "status": "Scheduled",
      "size": "15.4 GB",
      "date": "Not started",
      "nextRun": "2025-06-22 11:00 PM",
      "icon": Icons.perm_media,
      "color": warningColor,
      "progress": 0
    },
    {
      "name": "Settings Backup",
      "type": "Configuration",
      "status": "Failed",
      "size": "124 MB",
      "date": "2025-06-21 08:15 PM",
      "nextRun": "2025-06-22 08:15 PM",
      "icon": Icons.settings,
      "color": dangerColor,
      "progress": 0
    }
  ];

  List<Map<String, dynamic>> backupHistory = [
    {
      "name": "Full System Backup",
      "date": "June 22, 2025 - 02:00 AM",
      "size": "24.8 GB",
      "duration": "1h 23m",
      "status": "Success",
      "location": "Cloud Storage",
      "icon": Icons.check_circle
    },
    {
      "name": "Documents Backup",
      "date": "June 21, 2025 - 06:30 PM",
      "size": "2.1 GB",
      "duration": "12m",
      "status": "Success",
      "location": "External Drive",
      "icon": Icons.check_circle
    },
    {
      "name": "Media Files Backup",
      "date": "June 21, 2025 - 11:00 PM",
      "size": "15.4 GB",
      "duration": "45m",
      "status": "Success",
      "location": "Network Drive",
      "icon": Icons.check_circle
    },
    {
      "name": "Settings Backup",
      "date": "June 21, 2025 - 08:15 PM",
      "size": "124 MB",
      "duration": "Failed after 5m",
      "status": "Error",
      "location": "Local Drive",
      "icon": Icons.error
    }
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Hourly", "value": "Hourly"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Cloud Storage", "value": "Cloud Storage"},
    {"label": "External Drive", "value": "External Drive"},
    {"label": "Network Drive", "value": "Network Drive"},
    {"label": "Local Drive", "value": "Local Drive"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Backup Manager",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.backup)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildActiveBackupsTab(),
        _buildHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildActiveBackupsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackupOverview(),
          _buildQuickActions(),
          _buildActiveBackupsList(),
        ],
      ),
    );
  }

  Widget _buildBackupOverview() {
    int completedBackups = backupTasks.where((task) => task["status"] == "Completed").length;
    int totalBackups = backupTasks.length;
    double totalSize = backupTasks.fold(0.0, (sum, task) {
      String sizeStr = task["size"] as String;
      double size = double.tryParse(sizeStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      if (sizeStr.contains('GB')) size *= 1024;
      return sum + size;
    });

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.backup,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Backup Status",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$completedBackups/$totalBackups",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Backups Completed",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${totalSize.toStringAsFixed(1)} GB",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Total Size",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Backup Now",
                  icon: Icons.backup,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting immediate backup");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Restore",
                  icon: Icons.restore,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening restore options");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBackupsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Active Backup Tasks",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...backupTasks.map((task) => _buildBackupTaskCard(task)),
      ],
    );
  }

  Widget _buildBackupTaskCard(Map<String, dynamic> task) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: task["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (task["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  task["icon"] as IconData,
                  color: task["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["type"]} • ${task["size"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (task["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: task["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          if (task["status"] == "In Progress") ...[
            Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${task["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "ETA: 15 min",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: (task["progress"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: task["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Run",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${task["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Next Run",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${task["nextRun"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryStats(),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildHistoryStats() {
    int successfulBackups = backupHistory.where((backup) => backup["status"] == "Success").length;
    int totalBackups = backupHistory.length;
    double successRate = (successfulBackups / totalBackups) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$successfulBackups",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Successful",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${totalBackups - successfulBackups}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Failed",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${successRate.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Success Rate",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Backup History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...backupHistory.map((backup) => _buildHistoryItem(backup)),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> backup) {
    bool isSuccess = backup["status"] == "Success";
    Color statusColor = isSuccess ? successColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              backup["icon"] as IconData,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${backup["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${backup["date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${backup["size"]} • ${backup["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${backup["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackupSettings(),
          _buildScheduleSettings(),
          _buildSecuritySettings(),
        ],
      ),
    );
  }

  Widget _buildBackupSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Backup Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Backup Location",
            items: locationOptions,
            value: backupLocation,
            onChanged: (value, label) {
              backupLocation = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Backup Frequency",
            items: frequencyOptions,
            value: backupFrequency,
            onChanged: (value, label) {
              backupFrequency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Schedule Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "Enable Automatic Backup",
            items: [
              {
                "label": "Enable automatic backup",
                "value": true,
                "checked": autoBackup,
              }
            ],
            value: [if (autoBackup) {"label": "Enable automatic backup", "value": true, "checked": true}],
            onChanged: (values, ids) {
              autoBackup = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Security Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "Encrypt Backup Files",
            items: [
              {
                "label": "Enable backup encryption",
                "value": true,
                "checked": encryptBackup,
              }
            ],
            value: [if (encryptBackup) {"label": "Enable backup encryption", "value": true, "checked": true}],
            onChanged: (values, ids) {
              encryptBackup = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              icon: Icons.save,
              size: bs.md,
              onPressed: () {
                ss("Backup settings saved");
              },
            ),
          ),
        ],
      ),
    );
  }
}

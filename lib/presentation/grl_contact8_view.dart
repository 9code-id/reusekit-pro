import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact8View extends StatefulWidget {
  @override
  State<GrlContact8View> createState() => _GrlContact8ViewState();
}

class _GrlContact8ViewState extends State<GrlContact8View> {
  String searchQuery = "";
  String selectedFilter = "all";
  bool showSettings = false;
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "id": 1,
      "type": "backup",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "status": "completed",
      "contactCount": 2547,
      "size": "45.2 MB",
      "location": "Google Drive",
      "duration": "2m 34s",
    },
    {
      "id": 2,
      "type": "restore",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "status": "completed",
      "contactCount": 2234,
      "size": "42.1 MB",
      "location": "Local Storage",
      "duration": "1m 45s",
    },
    {
      "id": 3,
      "type": "backup",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "status": "failed",
      "contactCount": 2547,
      "size": "45.2 MB",
      "location": "iCloud",
      "duration": "Failed at 45%",
    },
    {
      "id": 4,
      "type": "sync",
      "date": DateTime.now().subtract(Duration(days: 10)),
      "status": "completed",
      "contactCount": 156,
      "size": "3.2 MB",
      "location": "Exchange Server",
      "duration": "45s",
    },
  ];

  List<Map<String, dynamic>> syncServices = [
    {
      "name": "Google Contacts",
      "icon": Icons.g_mobiledata,
      "connected": true,
      "lastSync": DateTime.now().subtract(Duration(hours: 2)),
      "contactCount": 1847,
      "autoSync": true,
    },
    {
      "name": "iCloud",
      "icon": Icons.cloud,
      "connected": true,
      "lastSync": DateTime.now().subtract(Duration(hours: 6)),
      "contactCount": 1234,
      "autoSync": false,
    },
    {
      "name": "Exchange",
      "icon": Icons.business,
      "connected": false,
      "lastSync": null,
      "contactCount": 0,
      "autoSync": false,
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "connected": true,
      "lastSync": DateTime.now().subtract(Duration(days: 1)),
      "contactCount": 567,
      "autoSync": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Sync"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showSettings = !showSettings;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showBackupDialog(),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.backup,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Backup Now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showRestoreDialog(),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.restore,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Restore",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _syncAllServices(),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.sync,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Sync All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Sync Services
            Text(
              "Connected Services",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...syncServices.map((service) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: service["connected"] ? successColor : disabledColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: service["connected"] ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      service["icon"],
                      color: service["connected"] ? successColor : disabledColor,
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
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: service["connected"] ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                service["connected"] ? "Connected" : "Disconnected",
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
                        if (service["connected"])
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${service["contactCount"]} contacts • Last sync: ${service["lastSync"] != null ? _formatLastSync(service["lastSync"]) : 'Never'}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Auto sync: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    service["autoSync"] ? "On" : "Off",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: service["autoSync"] ? successColor : warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      QButton(
                        label: service["connected"] ? "Sync" : "Connect",
                        size: bs.sm,
                        onPressed: () {
                          if (service["connected"]) {
                            _syncService(service["name"]);
                          } else {
                            _connectService(service["name"]);
                          }
                        },
                      ),
                      if (service["connected"])
                        GestureDetector(
                          onTap: () => _toggleAutoSync(service["name"]),
                          child: Container(
                            margin: EdgeInsets.only(top: spSm),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  service["autoSync"] ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Auto",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Filter and Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search history...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () => _showFilterDialog(),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // History Header
            Row(
              children: [
                Text(
                  "Backup History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _clearHistory(),
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // History List
            ...backupHistory.where((item) {
              if (searchQuery.isEmpty) return true;
              return item["type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                     item["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
            }).where((item) {
              if (selectedFilter == "all") return true;
              return item["type"] == selectedFilter;
            }).map((item) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(item["status"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getTypeColor(item["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            _getTypeIcon(item["type"]),
                            color: _getTypeColor(item["type"]),
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
                                    "${item["type"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(item["status"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${(item["date"] as DateTime).dMMMy} • ${(item["date"] as DateTime).hour}:${(item["date"] as DateTime).minute.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showHistoryDetails(item),
                          child: Icon(
                            Icons.more_vert,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: _buildHistoryInfo(
                            Icons.contacts,
                            "${item["contactCount"]} contacts",
                          ),
                        ),
                        Expanded(
                          child: _buildHistoryInfo(
                            Icons.storage,
                            "${item["size"]}",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildHistoryInfo(
                            Icons.location_on,
                            "${item["location"]}",
                          ),
                        ),
                        Expanded(
                          child: _buildHistoryInfo(
                            Icons.timer,
                            "${item["duration"]}",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: primaryColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'in_progress':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'backup':
        return primaryColor;
      case 'restore':
        return successColor;
      case 'sync':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'backup':
        return Icons.backup;
      case 'restore':
        return Icons.restore;
      case 'sync':
        return Icons.sync;
      default:
        return Icons.history;
    }
  }

  String _formatLastSync(DateTime date) {
    Duration diff = DateTime.now().difference(date);
    if (diff.inHours < 1) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inDays < 1) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }

  void _showBackupDialog() {
    // Navigate to backup configuration
  }

  void _showRestoreDialog() {
    // Navigate to restore selection
  }

  void _syncAllServices() {
    ss("Syncing all connected services...");
  }

  void _syncService(String serviceName) {
    ss("Syncing $serviceName...");
  }

  void _connectService(String serviceName) {
    // Navigate to service connection
  }

  void _toggleAutoSync(String serviceName) {
    int index = syncServices.indexWhere((s) => s["name"] == serviceName);
    if (index != -1) {
      syncServices[index]["autoSync"] = !syncServices[index]["autoSync"];
      setState(() {});
    }
  }

  void _showFilterDialog() {
    // Show filter options
  }

  void _clearHistory() {
    // Clear backup history
  }

  void _showHistoryDetails(Map<String, dynamic> item) {
    // Show detailed history information
  }
}

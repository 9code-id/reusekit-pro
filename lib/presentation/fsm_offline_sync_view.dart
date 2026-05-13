import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmOfflineSyncView extends StatefulWidget {
  const FsmOfflineSyncView({super.key});

  @override
  State<FsmOfflineSyncView> createState() => _FsmOfflineSyncViewState();
}

class _FsmOfflineSyncViewState extends State<FsmOfflineSyncView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedDataType = "all";
  bool isAutoSyncEnabled = true;
  bool isSyncing = false;
  DateTime lastSyncTime = DateTime.now().subtract(Duration(hours: 2));

  List<Map<String, dynamic>> syncItems = [
    {
      "id": "SYNC001",
      "type": "Work Orders",
      "icon": Icons.assignment,
      "status": "pending",
      "itemCount": 12,
      "lastSync": DateTime.now().subtract(Duration(hours: 3)),
      "priority": "high",
      "size": "2.4 MB",
      "description": "Work order assignments and updates",
      "color": Colors.orange,
    },
    {
      "id": "SYNC002", 
      "type": "Time Sheets",
      "icon": Icons.access_time,
      "status": "synced",
      "itemCount": 8,
      "lastSync": DateTime.now().subtract(Duration(minutes: 45)),
      "priority": "medium",
      "size": "1.2 MB",
      "description": "Employee time tracking data",
      "color": Colors.green,
    },
    {
      "id": "SYNC003",
      "type": "Inventory",
      "icon": Icons.inventory,
      "status": "error",
      "itemCount": 24,
      "lastSync": DateTime.now().subtract(Duration(hours: 6)),
      "priority": "high",
      "size": "3.8 MB",
      "description": "Stock levels and item updates",
      "color": Colors.red,
    },
    {
      "id": "SYNC004",
      "type": "Customer Data",
      "icon": Icons.people,
      "status": "synced",
      "itemCount": 156,
      "lastSync": DateTime.now().subtract(Duration(minutes: 30)),
      "priority": "low",
      "size": "4.2 MB",
      "description": "Customer information and contacts",
      "color": Colors.green,
    },
    {
      "id": "SYNC005",
      "type": "Forms",
      "icon": Icons.description,
      "status": "pending",
      "itemCount": 6,
      "lastSync": DateTime.now().subtract(Duration(hours: 4)),
      "priority": "medium",
      "size": "0.8 MB",
      "description": "Completed inspection forms",
      "color": Colors.orange,
    },
    {
      "id": "SYNC006",
      "type": "Photos",
      "icon": Icons.photo_camera,
      "status": "syncing",
      "itemCount": 32,
      "lastSync": DateTime.now().subtract(Duration(hours: 1)),
      "priority": "medium",
      "size": "15.6 MB",
      "description": "Job site photos and documentation",
      "color": Colors.blue,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Synced", "value": "synced"},
    {"label": "Syncing", "value": "syncing"},
    {"label": "Error", "value": "error"},
  ];

  List<Map<String, dynamic>> dataTypeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Work Orders", "value": "work_orders"},
    {"label": "Time Sheets", "value": "time_sheets"},
    {"label": "Inventory", "value": "inventory"},
    {"label": "Customer Data", "value": "customer_data"},
    {"label": "Forms", "value": "forms"},
    {"label": "Photos", "value": "photos"},
  ];

  List<Map<String, dynamic>> syncHistory = [
    {
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "type": "Full Sync",
      "status": "success",
      "itemCount": 248,
      "duration": "3m 24s",
    },
    {
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "type": "Incremental Sync",
      "status": "success",
      "itemCount": 12,
      "duration": "45s",
    },
    {
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "type": "Full Sync",
      "status": "partial",
      "itemCount": 189,
      "duration": "4m 12s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Sync"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to sync settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Sync Status Card
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
                  Row(
                    children: [
                      Icon(
                        isSyncing ? Icons.sync : Icons.cloud_done,
                        color: isSyncing ? Colors.blue : Colors.green,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSyncing ? "Syncing in Progress" : "All Data Synced",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last sync: ${lastSyncTime.dMMMykkss}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: isSyncing ? "Cancel" : "Sync Now",
                        size: bs.sm,
                        onPressed: _startSync,
                      ),
                    ],
                  ),
                  Divider(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          label: "Auto Sync",
                          items: [
                            {
                              "label": "Auto Sync",
                              "value": true,
                              "checked": isAutoSyncEnabled,
                            }
                          ],
                          value: [if (isAutoSyncEnabled) {"label": "Auto Sync", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isAutoSyncEnabled = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (isSyncing)
                        Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${_getPendingCount()}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${_getSyncedCount()}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Synced",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${_getErrorCount()}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Errors",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
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
                  QTextField(
                    label: "Search data types...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Data Type",
                          items: dataTypeItems,
                          value: selectedDataType,
                          onChanged: (value, label) {
                            selectedDataType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Sync All Pending",
                    size: bs.sm,
                    onPressed: _syncAllPending,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Retry Failed",
                    size: bs.sm,
                    onPressed: _retryFailed,
                  ),
                ),
              ],
            ),

            // Sync Items List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Data Sync Status",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _getFilteredSyncItems().length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _getFilteredSyncItems()[index];
                      return _buildSyncItemCard(item);
                    },
                  ),
                ],
              ),
            ),

            // Sync History
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Sync History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: syncHistory.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final history = syncHistory[index];
                      return _buildHistoryCard(history);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    String statusText = _getStatusText(item["status"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (item["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              item["icon"],
              color: item["color"],
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
                    Expanded(
                      child: Text(
                        "${item["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: statusColor.withAlpha(100)),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.folder, size: 12, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${item["itemCount"]} items",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.storage, size: 12, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${item["size"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Last: ${(item["lastSync"] as DateTime).dMMMykkss}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            children: [
              QButton(
                icon: item["status"] == "error" ? Icons.refresh : Icons.sync,
                size: bs.sm,
                onPressed: () => _syncItem(item),
              ),
              if (item["status"] == "error")
                Padding(
                  padding: EdgeInsets.only(top: spXs),
                  child: GestureDetector(
                    onTap: () => _viewErrorDetails(item),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color statusColor = history["status"] == "success" 
        ? Colors.green 
        : history["status"] == "partial" 
            ? Colors.orange 
            : Colors.red;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
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
                      "${history["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(history["timestamp"] as DateTime).dMMMykkss}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${history["itemCount"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Duration: ${history["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      history["status"].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
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

  List<Map<String, dynamic>> _getFilteredSyncItems() {
    return syncItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          item["type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      
      bool matchesType = selectedDataType == "all" || 
          item["type"].toString().toLowerCase().replaceAll(" ", "_") == selectedDataType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "synced":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "syncing":
        return Colors.blue;
      case "error":
        return Colors.red;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "synced":
        return "SYNCED";
      case "pending":
        return "PENDING";
      case "syncing":
        return "SYNCING";
      case "error":
        return "ERROR";
      default:
        return "UNKNOWN";
    }
  }

  int _getPendingCount() {
    return syncItems.where((item) => item["status"] == "pending").length;
  }

  int _getSyncedCount() {
    return syncItems.where((item) => item["status"] == "synced").length;
  }

  int _getErrorCount() {
    return syncItems.where((item) => item["status"] == "error").length;
  }

  void _startSync() {
    if (isSyncing) {
      // Cancel sync
      isSyncing = false;
      ss("Sync cancelled");
    } else {
      // Start sync
      isSyncing = true;
      // Simulate sync process
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          isSyncing = false;
          lastSyncTime = DateTime.now();
          ss("Sync completed successfully");
          setState(() {});
        }
      });
    }
    setState(() {});
  }

  void _syncAllPending() {
    ss("Syncing all pending items...");
    // Navigate to sync all pending
  }

  void _retryFailed() {
    ss("Retrying failed sync items...");
    // Navigate to retry failed syncs
  }

  void _syncItem(Map<String, dynamic> item) {
    ss("Syncing ${item["type"]}...");
    // Navigate to sync specific item
  }

  void _viewErrorDetails(Map<String, dynamic> item) {
    // Navigate to error details
  }
}

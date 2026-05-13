import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync3View extends StatefulWidget {
  @override
  State<GrlSync3View> createState() => _GrlSync3ViewState();
}

class _GrlSync3ViewState extends State<GrlSync3View> {
  String selectedFilter = "All";
  String selectedTimeRange = "Today";
  bool loading = false;
  bool realTimeSync = true;
  bool autoResolveConflicts = false;
  bool backgroundSync = true;

  List<Map<String, dynamic>> syncSessions = [
    {
      "id": "session_001",
      "device": "MacBook Pro",
      "type": "Automatic",
      "status": "Completed",
      "startTime": "2025-06-22 14:30:00",
      "endTime": "2025-06-22 14:32:45",
      "filesUploaded": 23,
      "filesDownloaded": 5,
      "filesSynced": 28,
      "dataTransferred": "47.8 MB",
      "conflicts": 0,
      "statusColor": Colors.green,
    },
    {
      "id": "session_002",
      "device": "iPhone 15",
      "type": "Manual",
      "status": "In Progress",
      "startTime": "2025-06-22 15:20:00",
      "endTime": null,
      "filesUploaded": 12,
      "filesDownloaded": 3,
      "filesSynced": 15,
      "dataTransferred": "23.4 MB",
      "conflicts": 1,
      "statusColor": Colors.blue,
    },
    {
      "id": "session_003",
      "device": "Desktop PC",
      "type": "Automatic",
      "status": "Failed",
      "startTime": "2025-06-22 13:45:00",
      "endTime": "2025-06-22 13:47:12",
      "filesUploaded": 0,
      "filesDownloaded": 0,
      "filesSynced": 0,
      "dataTransferred": "0 MB",
      "conflicts": 0,
      "statusColor": Colors.red,
    },
    {
      "id": "session_004",
      "device": "iPad Air",
      "type": "Automatic",
      "status": "Completed",
      "startTime": "2025-06-22 12:15:00",
      "endTime": "2025-06-22 12:16:23",
      "filesUploaded": 8,
      "filesDownloaded": 12,
      "filesSynced": 20,
      "dataTransferred": "31.2 MB",
      "conflicts": 2,
      "statusColor": Colors.green,
    },
  ];

  List<Map<String, dynamic>> syncStats = [
    {
      "title": "Active Sessions",
      "value": "2",
      "icon": Icons.sync,
      "color": primaryColor,
    },
    {
      "title": "Files Synced Today",
      "value": "127",
      "icon": Icons.description,
      "color": infoColor,
    },
    {
      "title": "Data Transferred",
      "value": "156.8 MB",
      "icon": Icons.cloud_upload,
      "color": successColor,
    },
    {
      "title": "Sync Success Rate",
      "value": "94.2%",
      "icon": Icons.check_circle,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "In Progress", "value": "In Progress"},
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
    {"label": "All time", "value": "All time"},
  ];

  List<Map<String, dynamic>> get filteredSessions {
    return syncSessions.where((session) {
      if (selectedFilter != "All" && session["status"] != selectedFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Monitor"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshSyncData(),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              PopupMenuItem(value: "force_sync", child: Text("Force Sync All")),
              PopupMenuItem(value: "pause_sync", child: Text("Pause Sync")),
              PopupMenuItem(value: "clear_history", child: Text("Clear History")),
              PopupMenuItem(value: "export_logs", child: Text("Export Logs")),
            ],
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSyncOverview(),
                SizedBox(height: spMd),
                _buildSyncSettings(),
                SizedBox(height: spMd),
                _buildFilterSection(),
                SizedBox(height: spMd),
                _buildSyncSessionsList(),
              ],
            ),
          ),
    );
  }

  Widget _buildSyncOverview() {
    return Container(
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
            "Sync Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: syncStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: stat["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        stat["icon"] as IconData,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${stat["title"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSettings() {
    return Container(
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
            "Sync Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildSyncToggle(
            "Real-time Sync",
            "Automatically sync files when changes are detected",
            realTimeSync,
            (value) => setState(() => realTimeSync = value),
          ),
          SizedBox(height: spSm),
          _buildSyncToggle(
            "Auto-resolve Conflicts",
            "Automatically resolve sync conflicts using newest version",
            autoResolveConflicts,
            (value) => setState(() => autoResolveConflicts = value),
          ),
          SizedBox(height: spSm),
          _buildSyncToggle(
            "Background Sync",
            "Continue syncing when app is in background",
            backgroundSync,
            (value) => setState(() => backgroundSync = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncToggle(String title, String description, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
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
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: successColor,
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Container(
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
            "Filter Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRangeOptions,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSessionsList() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sync Sessions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Start Sync",
                size: bs.sm,
                onPressed: () => _startManualSync(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...List.generate(filteredSessions.length, (index) {
            final session = filteredSessions[index];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
                color: (session["statusColor"] as Color).withAlpha(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: (session["statusColor"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${session["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: session["statusColor"] as Color,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${session["device"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        onSelected: (value) => _handleSessionAction(value, session),
                        itemBuilder: (context) => [
                          PopupMenuItem(value: "details", child: Text("View Details")),
                          PopupMenuItem(value: "retry", child: Text("Retry Sync")),
                          PopupMenuItem(value: "cancel", child: Text("Cancel Sync")),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type: ${session["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Files: ${session["filesSynced"]} synced",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Data: ${session["dataTransferred"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if ((session["conflicts"] as int) > 0)
                              Text(
                                "Conflicts: ${session["conflicts"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${DateTime.parse("${session["startTime"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse("${session["startTime"]}").toString().split(" ")[1].substring(0, 5)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (session["endTime"] != null)
                            Text(
                              "Duration: ${_calculateDuration(session)}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (session["status"] == "In Progress")
                    Column(
                      children: [
                        SizedBox(height: spSm),
                        LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: disabledColor,
                          color: primaryColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "65% complete",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _calculateDuration(Map<String, dynamic> session) {
    if (session["endTime"] == null) return "In progress";
    
    DateTime start = DateTime.parse("${session["startTime"]}");
    DateTime end = DateTime.parse("${session["endTime"]}");
    Duration duration = end.difference(start);
    
    if (duration.inHours > 0) {
      return "${duration.inHours}h ${duration.inMinutes % 60}m";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes}m ${duration.inSeconds % 60}s";
    } else {
      return "${duration.inSeconds}s";
    }
  }

  void _refreshSyncData() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Sync data refreshed successfully");
    });
  }

  void _startManualSync() {
    showLoading();
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Manual sync started successfully");
    });
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "force_sync":
        _forceSyncAll();
        break;
      case "pause_sync":
        _pauseSync();
        break;
      case "clear_history":
        _clearHistory();
        break;
      case "export_logs":
        ss("Exporting sync logs...");
        break;
    }
  }

  void _handleSessionAction(String action, Map<String, dynamic> session) {
    switch (action) {
      case "details":
        _showSessionDetails(session);
        break;
      case "retry":
        _retrySync(session);
        break;
      case "cancel":
        _cancelSync(session);
        break;
    }
  }

  void _forceSyncAll() async {
    bool isConfirmed = await confirm("Force sync all devices? This may take some time.");
    if (isConfirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 4), () {
        hideLoading();
        ss("Force sync completed for all devices");
      });
    }
  }

  void _pauseSync() async {
    bool isConfirmed = await confirm("Pause all sync operations?");
    if (isConfirmed) {
      ss("All sync operations paused");
    }
  }

  void _clearHistory() async {
    bool isConfirmed = await confirm("Clear all sync history? This action cannot be undone.");
    if (isConfirmed) {
      syncSessions.clear();
      setState(() {});
      ss("Sync history cleared successfully");
    }
  }

  void _showSessionDetails(Map<String, dynamic> session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sync Session Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Session ID", "${session["id"]}"),
                    _buildDetailRow("Device", "${session["device"]}"),
                    _buildDetailRow("Type", "${session["type"]}"),
                    _buildDetailRow("Status", "${session["status"]}"),
                    _buildDetailRow("Start Time", "${DateTime.parse("${session["startTime"]}").dMMMy}"),
                    if (session["endTime"] != null)
                      _buildDetailRow("End Time", "${DateTime.parse("${session["endTime"]}").dMMMy}"),
                    _buildDetailRow("Files Uploaded", "${session["filesUploaded"]}"),
                    _buildDetailRow("Files Downloaded", "${session["filesDownloaded"]}"),
                    _buildDetailRow("Total Files Synced", "${session["filesSynced"]}"),
                    _buildDetailRow("Data Transferred", "${session["dataTransferred"]}"),
                    _buildDetailRow("Conflicts", "${session["conflicts"]}"),
                    if (session["endTime"] != null)
                      _buildDetailRow("Duration", _calculateDuration(session)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _retrySync(Map<String, dynamic> session) {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Retry sync initiated for ${session["device"]}");
    });
  }

  void _cancelSync(Map<String, dynamic> session) async {
    bool isConfirmed = await confirm("Cancel sync session for ${session["device"]}?");
    if (isConfirmed) {
      session["status"] = "Cancelled";
      session["statusColor"] = disabledBoldColor;
      setState(() {});
      ss("Sync session cancelled");
    }
  }
}

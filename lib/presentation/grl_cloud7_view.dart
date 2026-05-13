import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud7View extends StatefulWidget {
  @override
  State<GrlCloud7View> createState() => _GrlCloud7ViewState();
}

class _GrlCloud7ViewState extends State<GrlCloud7View> {
  bool loading = false;
  String selectedTimeframe = "30d";
  
  List<Map<String, dynamic>> activities = [
    {
      "id": "1",
      "type": "upload",
      "file": "presentation.pdf",
      "folder": "Documents",
      "timestamp": "2024-06-22T10:30:00Z",
      "size": 2.5,
      "device": "iPhone 13",
      "status": "completed",
    },
    {
      "id": "2",
      "type": "download",
      "file": "vacation-photos.zip",
      "folder": "Photos",
      "timestamp": "2024-06-22T09:15:00Z",
      "size": 125.8,
      "device": "MacBook Pro",
      "status": "completed",
    },
    {
      "id": "3",
      "type": "sync",
      "file": "Music Library",
      "folder": "Music",
      "timestamp": "2024-06-22T08:45:00Z",
      "size": 45.2,
      "device": "iPad Air",
      "status": "failed",
    },
    {
      "id": "4",
      "type": "share",
      "file": "project-files.zip",
      "folder": "Work",
      "timestamp": "2024-06-21T16:20:00Z",
      "size": 15.7,
      "device": "iPhone 13",
      "status": "completed",
    },
    {
      "id": "5",
      "type": "delete",
      "file": "old-backup.zip",
      "folder": "Backups",
      "timestamp": "2024-06-21T14:30:00Z",
      "size": 89.3,
      "device": "MacBook Pro",
      "status": "completed",
    },
    {
      "id": "6",
      "type": "upload",
      "file": "report-Q2.docx",
      "folder": "Documents",
      "timestamp": "2024-06-21T11:45:00Z",
      "size": 1.2,
      "device": "Windows PC",
      "status": "completed",
    },
    {
      "id": "7",
      "type": "sync",
      "file": "Photo Library",
      "folder": "Photos",
      "timestamp": "2024-06-21T09:30:00Z",
      "size": 234.6,
      "device": "iPhone 13",
      "status": "in_progress",
    },
    {
      "id": "8",
      "type": "download",
      "file": "software-installer.dmg",
      "folder": "Downloads",
      "timestamp": "2024-06-20T20:15:00Z",
      "size": 67.4,
      "device": "MacBook Pro",
      "status": "completed",
    },
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 days", "value": "7d"},
    {"label": "Last 30 days", "value": "30d"},
    {"label": "Last 90 days", "value": "90d"},
    {"label": "All time", "value": "all"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Log"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearch,
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
                _buildActivityOverview(),
                SizedBox(height: spLg),
                _buildTimeframeSelector(),
                SizedBox(height: spMd),
                _buildActivityList(),
              ],
            ),
          ),
    );
  }

  Widget _buildActivityOverview() {
    Map<String, int> activityCounts = _getActivityCounts();
    
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
            "Activity Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Total Activities",
                  "${activities.length}",
                  Icons.timeline,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Uploads",
                  "${activityCounts["upload"] ?? 0}",
                  Icons.cloud_upload,
                  successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Downloads",
                  "${activityCounts["download"] ?? 0}",
                  Icons.cloud_download,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Failed",
                  "${activities.where((a) => a["status"] == "failed").length}",
                  Icons.error,
                  dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Row(
      children: [
        Text(
          "Show:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            height: 40,
            child: QHorizontalScroll(
              children: timeframeOptions.map((option) {
                bool isSelected = selectedTimeframe == option["value"];
                return GestureDetector(
                  onTap: () {
                    selectedTimeframe = option["value"] as String;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Text(
                      "${option["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    List<Map<String, dynamic>> filteredActivities = _getFilteredActivities();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activities (${filteredActivities.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (filteredActivities.isEmpty)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No activities found",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredActivities.map((activity) => _buildActivityItem(activity)).toList(),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color typeColor = _getTypeColor(activity["type"] as String);
    Color statusColor = _getStatusColor(activity["status"] as String);
    IconData typeIcon = _getTypeIcon(activity["type"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: typeColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  typeIcon,
                  size: 20,
                  color: typeColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${activity["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: typeColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${activity["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["file"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "in ${activity["folder"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${((activity["size"] as double)).toStringAsFixed(1)} MB",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    DateTime.parse("${activity["timestamp"]}").dMMMy,
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.devices,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${activity["device"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.schedule,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                DateTime.parse("${activity["timestamp"]}").toString().split(" ")[1].substring(0, 5),
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (activity["status"] == "failed")
                GestureDetector(
                  onTap: () => _retryActivity(activity),
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              if (activity["status"] == "in_progress")
                GestureDetector(
                  onTap: () => _cancelActivity(activity),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "upload":
        return successColor;
      case "download":
        return infoColor;
      case "sync":
        return primaryColor;
      case "share":
        return warningColor;
      case "delete":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      case "in_progress":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "upload":
        return Icons.cloud_upload;
      case "download":
        return Icons.cloud_download;
      case "sync":
        return Icons.sync;
      case "share":
        return Icons.share;
      case "delete":
        return Icons.delete;
      default:
        return Icons.description;
    }
  }

  Map<String, int> _getActivityCounts() {
    Map<String, int> counts = {};
    for (var activity in activities) {
      String type = activity["type"] as String;
      counts[type] = (counts[type] ?? 0) + 1;
    }
    return counts;
  }

  List<Map<String, dynamic>> _getFilteredActivities() {
    List<Map<String, dynamic>> filtered = activities;
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((activity) {
        return (activity["file"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (activity["folder"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (activity["device"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Filter by timeframe
    DateTime now = DateTime.now();
    DateTime cutoff;
    
    switch (selectedTimeframe) {
      case "7d":
        cutoff = now.subtract(Duration(days: 7));
        break;
      case "30d":
        cutoff = now.subtract(Duration(days: 30));
        break;
      case "90d":
        cutoff = now.subtract(Duration(days: 90));
        break;
      default:
        return filtered; // All time
    }
    
    filtered = filtered.where((activity) {
      DateTime activityDate = DateTime.parse("${activity["timestamp"]}");
      return activityDate.isAfter(cutoff);
    }).toList();
    
    // Sort by timestamp (newest first)
    filtered.sort((a, b) {
      DateTime dateA = DateTime.parse("${a["timestamp"]}");
      DateTime dateB = DateTime.parse("${b["timestamp"]}");
      return dateB.compareTo(dateA);
    });
    
    return filtered;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text("Activity Type:", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              children: ["upload", "download", "sync", "share", "delete"].map((type) {
                return FilterChip(
                  label: Text(type),
                  selected: false,
                  onSelected: (selected) {
                    // Implement filter logic
                  },
                );
              }).toList(),
            ),
            SizedBox(height: spMd),
            Text("Status:", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              children: ["completed", "failed", "in_progress"].map((status) {
                return FilterChip(
                  label: Text(status),
                  selected: false,
                  onSelected: (selected) {
                    // Implement filter logic
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearch() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Activities"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search",
                    value: searchQuery,
                    hint: "Search by file, folder, or device...",
                    onChanged: (value) {
                      searchQuery = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Clear",
            size: bs.sm,
            onPressed: () {
              searchQuery = "";
              setState(() {});
              Navigator.pop(context);
            },
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _retryActivity(Map<String, dynamic> activity) {
    activity["status"] = "in_progress";
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      activity["status"] = "completed";
      setState(() {});
      ss("Activity completed successfully");
    });
  }

  void _cancelActivity(Map<String, dynamic> activity) async {
    bool isConfirmed = await confirm("Cancel this activity?");
    if (isConfirmed) {
      activities.remove(activity);
      setState(() {});
      sw("Activity cancelled");
    }
  }
}

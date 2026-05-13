import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload6View extends StatefulWidget {
  @override
  State<GrlDownload6View> createState() => _GrlDownload6ViewState();
}

class _GrlDownload6ViewState extends State<GrlDownload6View> {
  bool loading = false;
  String selectedSortBy = "Date";
  String selectedFilter = "All Files";
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "Date"},
    {"label": "Name", "value": "Name"},
    {"label": "Size", "value": "Size"},
    {"label": "Type", "value": "Type"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Files", "value": "All Files"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Archives", "value": "Archives"},
  ];

  List<Map<String, dynamic>> downloadQueue = [
    {
      "id": 1,
      "title": "System Architecture Guide",
      "type": "PDF",
      "size": "12.4 MB",
      "priority": "High",
      "status": "Downloading",
      "progress": 75,
      "speed": "2.4 MB/s",
      "timeRemaining": "00:02:15",
      "startTime": "2024-12-20 14:30:00",
      "category": "Documents",
      "thumbnail": "https://picsum.photos/60/60?random=1&keyword=architecture"
    },
    {
      "id": 2,
      "title": "Product Demo Video",
      "type": "MP4",
      "size": "234.7 MB",
      "priority": "Medium",
      "status": "Queued",
      "progress": 0,
      "speed": "0 MB/s",
      "timeRemaining": "Waiting...",
      "startTime": "",
      "category": "Videos",
      "thumbnail": "https://picsum.photos/60/60?random=2&keyword=video"
    },
    {
      "id": 3,
      "title": "Brand Assets Collection",
      "type": "ZIP",
      "size": "89.3 MB",
      "priority": "Low",
      "status": "Paused",
      "progress": 35,
      "speed": "0 MB/s",
      "timeRemaining": "Paused",
      "startTime": "2024-12-20 13:45:00",
      "category": "Archives",
      "thumbnail": "https://picsum.photos/60/60?random=3&keyword=brand"
    },
    {
      "id": 4,
      "title": "Marketing Materials",
      "type": "ZIP",
      "size": "156.8 MB",
      "priority": "High",
      "status": "Completed",
      "progress": 100,
      "speed": "3.2 MB/s",
      "timeRemaining": "Completed",
      "startTime": "2024-12-20 12:15:00",
      "category": "Archives",
      "thumbnail": "https://picsum.photos/60/60?random=4&keyword=marketing"
    },
    {
      "id": 5,
      "title": "Financial Dashboard Template",
      "type": "FIGMA",
      "size": "28.9 MB",
      "priority": "Medium",
      "status": "Failed",
      "progress": 0,
      "speed": "0 MB/s",
      "timeRemaining": "Failed",
      "startTime": "2024-12-20 11:30:00",
      "category": "Documents",
      "thumbnail": "https://picsum.photos/60/60?random=5&keyword=dashboard"
    }
  ];

  Future<void> _pauseDownload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Paused";
    item["speed"] = "0 MB/s";
    item["timeRemaining"] = "Paused";
    setState(() {});
    si("Download paused");
  }

  Future<void> _resumeDownload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Downloading";
    item["speed"] = "1.8 MB/s";
    item["timeRemaining"] = "00:03:42";
    setState(() {});
    si("Download resumed");
  }

  Future<void> _retryDownload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Downloading";
    item["progress"] = 0;
    item["speed"] = "2.1 MB/s";
    item["timeRemaining"] = "00:04:30";
    setState(() {});
    ss("Download retrying");
  }

  Future<void> _cancelDownload(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this download?");
    if (isConfirmed) {
      downloadQueue.removeWhere((download) => download["id"] == item["id"]);
      setState(() {});
      ss("Download cancelled");
    }
  }

  Future<void> _clearCompleted() async {
    bool isConfirmed = await confirm("Clear all completed downloads from the queue?");
    if (isConfirmed) {
      downloadQueue.removeWhere((item) => item["status"] == "Completed");
      setState(() {});
      ss("Completed downloads cleared");
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Downloading":
        return infoColor;
      case "Completed":
        return successColor;
      case "Paused":
        return warningColor;
      case "Failed":
        return dangerColor;
      case "Queued":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredAndSortedQueue {
    List<Map<String, dynamic>> filtered = downloadQueue;
    
    if (selectedFilter != "All Files") {
      filtered = filtered.where((item) => item["category"] == selectedFilter).toList();
    }
    
    filtered.sort((a, b) {
      switch (selectedSortBy) {
        case "Name":
          return (a["title"] as String).compareTo(b["title"] as String);
        case "Size":
          return (a["size"] as String).compareTo(b["size"] as String);
        case "Type":
          return (a["type"] as String).compareTo(b["type"] as String);
        case "Date":
        default:
          return (b["startTime"] as String).compareTo(a["startTime"] as String);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Queue"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearCompleted,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Download settings");
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Queue Statistics
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.queue,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Download Queue Status",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${downloadQueue.where((item) => item["status"] == "Downloading").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 12,
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
                                "${downloadQueue.where((item) => item["status"] == "Queued").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Queued",
                                style: TextStyle(
                                  fontSize: 12,
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
                                "${downloadQueue.where((item) => item["status"] == "Completed").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 12,
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
                                "${downloadQueue.where((item) => item["status"] == "Failed").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Failed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Filter and Sort Controls
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Type",
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
                      label: "Sort by",
                      items: sortOptions,
                      value: selectedSortBy,
                      onChanged: (value, label) {
                        selectedSortBy = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Queue Header
              Row(
                children: [
                  Text(
                    "Download Queue",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${filteredAndSortedQueue.length} items",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Download Queue List
              Column(
                spacing: spSm,
                children: filteredAndSortedQueue.map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: _getStatusColor(item["status"] as String).withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${item["thumbnail"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(item["priority"] as String).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${item["priority"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor(item["priority"] as String),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${item["type"]} • ${item["size"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(item["status"] as String).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${item["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(item["status"] as String),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      if (item["status"] == "Downloading") ...[
                                        Text(
                                          "${item["speed"]} • ${item["timeRemaining"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ] else if (item["startTime"] != "") ...[
                                        Text(
                                          "${DateTime.parse(item["startTime"] as String).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        if (item["status"] == "Downloading" || item["status"] == "Paused") ...[
                          SizedBox(height: spSm),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${item["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(item["status"] as String),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${item["timeRemaining"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (item["progress"] as int) / 100,
                                backgroundColor: disabledColor.withAlpha(30),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStatusColor(item["status"] as String),
                                ),
                              ),
                            ],
                          ),
                        ],

                        SizedBox(height: spSm),
                        Row(
                          children: [
                            if (item["status"] == "Downloading") ...[
                              Expanded(
                                child: QButton(
                                  label: "Pause",
                                  size: bs.sm,
                                  icon: Icons.pause,
                                  onPressed: () => _pauseDownload(item),
                                ),
                              ),
                            ] else if (item["status"] == "Paused" || item["status"] == "Queued") ...[
                              Expanded(
                                child: QButton(
                                  label: "Resume",
                                  size: bs.sm,
                                  icon: Icons.play_arrow,
                                  onPressed: () => _resumeDownload(item),
                                ),
                              ),
                            ] else if (item["status"] == "Failed") ...[
                              Expanded(
                                child: QButton(
                                  label: "Retry",
                                  size: bs.sm,
                                  icon: Icons.refresh,
                                  onPressed: () => _retryDownload(item),
                                ),
                              ),
                            ] else if (item["status"] == "Completed") ...[
                              Expanded(
                                child: QButton(
                                  label: "Open",
                                  size: bs.sm,
                                  icon: Icons.open_in_new,
                                  onPressed: () {
                                    si("Opening ${item["title"]}");
                                  },
                                ),
                              ),
                            ],

                            if (item["status"] != "Completed") ...[
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Cancel",
                                  size: bs.sm,
                                  icon: Icons.cancel,
                                  onPressed: () => _cancelDownload(item),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Quick Actions
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
                      "Quick Actions",
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
                          child: QButton(
                            label: "Pause All",
                            size: bs.sm,
                            icon: Icons.pause_circle,
                            onPressed: () {
                              si("Pausing all downloads");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Resume All",
                            size: bs.sm,
                            icon: Icons.play_circle,
                            onPressed: () {
                              si("Resuming all downloads");
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

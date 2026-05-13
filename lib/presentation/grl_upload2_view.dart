import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload2View extends StatefulWidget {
  @override
  State<GrlUpload2View> createState() => _GrlUpload2ViewState();
}

class _GrlUpload2ViewState extends State<GrlUpload2View> {
  bool loading = false;
  int selectedTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> activeUploads = [
    {
      "id": 1,
      "filename": "Project_Documentation.pdf",
      "size": "15.2 MB",
      "progress": 75,
      "speed": "2.4 MB/s",
      "timeRemaining": "00:02:15",
      "status": "Uploading",
      "startTime": "2024-12-20 14:30:00",
      "category": "Documents",
      "thumbnail": "https://picsum.photos/60/60?random=1&keyword=document"
    },
    {
      "id": 2,
      "filename": "Design_Assets.zip",
      "size": "89.7 MB",
      "progress": 45,
      "speed": "1.8 MB/s",
      "timeRemaining": "00:05:30",
      "status": "Uploading",
      "startTime": "2024-12-20 14:15:00",
      "category": "Archives",
      "thumbnail": "https://picsum.photos/60/60?random=2&keyword=design"
    },
    {
      "id": 3,
      "filename": "Marketing_Video.mp4",
      "size": "234.5 MB",
      "progress": 15,
      "speed": "3.2 MB/s",
      "timeRemaining": "00:12:45",
      "status": "Uploading",
      "startTime": "2024-12-20 14:00:00",
      "category": "Videos",
      "thumbnail": "https://picsum.photos/60/60?random=3&keyword=video"
    },
    {
      "id": 4,
      "filename": "Data_Analysis.xlsx",
      "size": "5.8 MB",
      "progress": 0,
      "speed": "0 MB/s",
      "timeRemaining": "Waiting...",
      "status": "Queued",
      "startTime": "",
      "category": "Documents",
      "thumbnail": "https://picsum.photos/60/60?random=4&keyword=data"
    }
  ];

  List<Map<String, dynamic>> completedUploads = [
    {
      "id": 1,
      "filename": "Annual_Report_2024.pdf",
      "size": "12.4 MB",
      "uploadDate": "2024-12-20 13:45:00",
      "duration": "00:02:34",
      "averageSpeed": "4.8 MB/s",
      "status": "Completed",
      "category": "Documents",
      "downloads": 23,
      "views": 156,
      "thumbnail": "https://picsum.photos/60/60?random=5&keyword=report"
    },
    {
      "id": 2,
      "filename": "Product_Catalog.pdf",
      "size": "8.9 MB",
      "uploadDate": "2024-12-20 12:30:00",
      "duration": "00:01:45",
      "averageSpeed": "5.1 MB/s",
      "status": "Completed",
      "category": "Documents",
      "downloads": 67,
      "views": 234,
      "thumbnail": "https://picsum.photos/60/60?random=6&keyword=catalog"
    },
    {
      "id": 3,
      "filename": "Company_Presentation.pptx",
      "size": "25.7 MB",
      "uploadDate": "2024-12-20 11:15:00",
      "duration": "00:04:20",
      "averageSpeed": "5.9 MB/s",
      "status": "Completed",
      "category": "Documents",
      "downloads": 45,
      "views": 189,
      "thumbnail": "https://picsum.photos/60/60?random=7&keyword=presentation"
    },
    {
      "id": 4,
      "filename": "Brand_Guidelines.zip",
      "size": "67.3 MB",
      "uploadDate": "2024-12-20 10:00:00",
      "duration": "00:11:25",
      "averageSpeed": "5.9 MB/s",
      "status": "Completed",
      "category": "Archives",
      "downloads": 12,
      "views": 78,
      "thumbnail": "https://picsum.photos/60/60?random=8&keyword=brand"
    }
  ];

  Future<void> _pauseUpload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Paused";
    item["speed"] = "0 MB/s";
    item["timeRemaining"] = "Paused";
    setState(() {});
    si("Upload paused");
  }

  Future<void> _resumeUpload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Uploading";
    item["speed"] = "2.1 MB/s";
    item["timeRemaining"] = "00:03:42";
    setState(() {});
    si("Upload resumed");
  }

  Future<void> _cancelUpload(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this upload?");
    if (isConfirmed) {
      activeUploads.removeWhere((upload) => upload["id"] == item["id"]);
      setState(() {});
      ss("Upload cancelled");
    }
  }

  Future<void> _retryUpload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Uploading";
    item["progress"] = 0;
    item["speed"] = "2.1 MB/s";
    item["timeRemaining"] = "00:04:30";
    setState(() {});
    ss("Upload retrying");
  }

  Future<void> _deleteUpload(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this upload?");
    if (isConfirmed) {
      completedUploads.removeWhere((upload) => upload["id"] == item["id"]);
      setState(() {});
      ss("Upload deleted");
    }
  }

  Future<void> _shareUpload(Map<String, dynamic> item) async {
    si("Sharing ${item["filename"]}");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Uploading":
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

  Widget _buildActiveUploadsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search active uploads...",
                  value: searchQuery,
                  hint: "Search by filename",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  si("Searching uploads");
                },
              ),
            ],
          ),

          // Upload Progress Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor.withAlpha(20), infoColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      color: infoColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Upload Activity",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                            "${activeUploads.where((item) => item["status"] == "Uploading").length}",
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
                            "${activeUploads.where((item) => item["status"] == "Queued").length}",
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
                            "${((activeUploads.map((item) => double.parse((item["size"] as String).split(" ")[0])).reduce((a, b) => a + b))).toStringAsFixed(1)} MB",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Size",
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

          // Active Uploads List
          Text(
            "Active Uploads",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Column(
            spacing: spSm,
            children: activeUploads.map((item) {
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
                              Text(
                                "${item["filename"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["category"]} • ${item["size"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (item["startTime"] != "") ...[
                                SizedBox(height: spXs),
                                Text(
                                  "Started: ${DateTime.parse(item["startTime"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
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
                      ],
                    ),

                    if (item["status"] == "Uploading" || item["status"] == "Paused") ...[
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
                              if (item["status"] == "Uploading") ...[
                                Text(
                                  "${item["speed"]} • ${item["timeRemaining"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  "${item["timeRemaining"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                        if (item["status"] == "Uploading") ...[
                          Expanded(
                            child: QButton(
                              label: "Pause",
                              size: bs.sm,
                              icon: Icons.pause,
                              onPressed: () => _pauseUpload(item),
                            ),
                          ),
                        ] else if (item["status"] == "Paused" || item["status"] == "Queued") ...[
                          Expanded(
                            child: QButton(
                              label: "Resume",
                              size: bs.sm,
                              icon: Icons.play_arrow,
                              onPressed: () => _resumeUpload(item),
                            ),
                          ),
                        ] else if (item["status"] == "Failed") ...[
                          Expanded(
                            child: QButton(
                              label: "Retry",
                              size: bs.sm,
                              icon: Icons.refresh,
                              onPressed: () => _retryUpload(item),
                            ),
                          ),
                        ],

                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            size: bs.sm,
                            icon: Icons.cancel,
                            onPressed: () => _cancelUpload(item),
                          ),
                        ),
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
                          si("Pausing all uploads");
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
                          si("Resuming all uploads");
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
    );
  }

  Widget _buildCompletedUploadsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor.withAlpha(20), successColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_done,
                      color: successColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Upload Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                            "${completedUploads.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                            "${(completedUploads.map((item) => item["downloads"] as int).reduce((a, b) => a + b))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Downloads",
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
                            "${(completedUploads.map((item) => item["views"] as int).reduce((a, b) => a + b))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Views",
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

          // Completed Uploads List
          Text(
            "Completed Uploads",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Column(
            spacing: spSm,
            children: completedUploads.map((item) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
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
                              Text(
                                "${item["filename"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["category"]} • ${item["size"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Uploaded: ${DateTime.parse(item["uploadDate"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["duration"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Speed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["averageSpeed"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Downloads",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["downloads"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["views"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Share",
                            size: bs.sm,
                            icon: Icons.share,
                            onPressed: () => _shareUpload(item),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View",
                            size: bs.sm,
                            icon: Icons.visibility,
                            onPressed: () {
                              si("Viewing ${item["filename"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Delete",
                            size: bs.sm,
                            icon: Icons.delete,
                            onPressed: () => _deleteUpload(item),
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Upload Progress",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.cloud_upload)),
        Tab(text: "Completed", icon: Icon(Icons.cloud_done)),
      ],
      tabChildren: [
        _buildActiveUploadsTab(),
        _buildCompletedUploadsTab(),
      ],
    );
  }
}

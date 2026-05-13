import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmRecordingManagementView extends StatefulWidget {
  const EcmRecordingManagementView({super.key});

  @override
  State<EcmRecordingManagementView> createState() => _EcmRecordingManagementViewState();
}

class _EcmRecordingManagementViewState extends State<EcmRecordingManagementView> {
  String selectedStatus = "All";
  String selectedQuality = "All";
  String selectedType = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> recordings = [
    {
      "id": "REC001",
      "title": "Opening Keynote: Future of Technology",
      "speaker": "Dr. Sarah Johnson",
      "event": "Tech Conference 2024",
      "duration": "45:30",
      "size": "2.1 GB",
      "quality": "4K Ultra HD",
      "format": "MP4",
      "status": "Processing",
      "uploadDate": "2024-01-15",
      "downloadCount": 1250,
      "streamCount": 3400,
      "thumbnail": "https://picsum.photos/400/225?random=1&keyword=conference",
      "description": "Comprehensive discussion on emerging technologies and their impact on future industries",
      "tags": ["Technology", "Innovation", "Future"],
      "isPublic": true,
      "processingProgress": 75.0,
    },
    {
      "id": "REC002", 
      "title": "Panel Discussion: Sustainable Development",
      "speaker": "Multiple Speakers",
      "event": "Sustainability Summit 2024",
      "duration": "1:12:45",
      "size": "3.8 GB",
      "quality": "Full HD",
      "format": "MP4",
      "status": "Ready",
      "uploadDate": "2024-01-14",
      "downloadCount": 890,
      "streamCount": 2100,
      "thumbnail": "https://picsum.photos/400/225?random=2&keyword=environment",
      "description": "Expert panel discussing global sustainability challenges and innovative solutions",
      "tags": ["Environment", "Sustainability", "Panel"],
      "isPublic": true,
      "processingProgress": 100.0,
    },
    {
      "id": "REC003",
      "title": "Workshop: Data Analytics Fundamentals",
      "speaker": "Prof. Michael Chen",
      "event": "Data Science Bootcamp",
      "duration": "2:30:15",
      "size": "5.2 GB",
      "quality": "HD",
      "format": "MP4",
      "status": "Failed",
      "uploadDate": "2024-01-13",
      "downloadCount": 0,
      "streamCount": 0,
      "thumbnail": "https://picsum.photos/400/225?random=3&keyword=analytics",
      "description": "Comprehensive workshop covering basic to intermediate data analytics concepts",
      "tags": ["Data Science", "Workshop", "Analytics"],
      "isPublic": false,
      "processingProgress": 0.0,
    },
    {
      "id": "REC004",
      "title": "Product Launch: Innovation Showcase",
      "speaker": "Lisa Martinez, CTO",
      "event": "Innovation Week 2024",
      "duration": "38:20",
      "size": "1.9 GB",
      "quality": "Full HD",
      "format": "MP4",
      "status": "Ready",
      "uploadDate": "2024-01-12",
      "downloadCount": 2100,
      "streamCount": 5600,
      "thumbnail": "https://picsum.photos/400/225?random=4&keyword=innovation",
      "description": "Exciting showcase of cutting-edge products and technological innovations",
      "tags": ["Product Launch", "Innovation", "Technology"],
      "isPublic": true,
      "processingProgress": 100.0,
    },
    {
      "id": "REC005",
      "title": "Masterclass: Leadership in Digital Age",
      "speaker": "James Wilson",
      "event": "Leadership Summit 2024",
      "duration": "1:45:30",
      "size": "4.1 GB",
      "quality": "4K Ultra HD",
      "format": "MP4",
      "status": "Processing",
      "uploadDate": "2024-01-11",
      "downloadCount": 0,
      "streamCount": 0,
      "thumbnail": "https://picsum.photos/400/225?random=5&keyword=leadership",
      "description": "Advanced leadership strategies for navigating the digital transformation era",
      "tags": ["Leadership", "Digital", "Management"],
      "isPublic": false,
      "processingProgress": 45.0,
    },
  ];

  List<Map<String, dynamic>> get filteredRecordings {
    return recordings.where((recording) {
      bool matchesStatus = selectedStatus == "All" || recording["status"] == selectedStatus;
      bool matchesQuality = selectedQuality == "All" || recording["quality"] == selectedQuality;
      bool matchesType = selectedType == "All" || (recording["tags"] as List).contains(selectedType);
      bool matchesSearch = searchQuery.isEmpty || 
          recording["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          recording["speaker"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          recording["event"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesQuality && matchesType && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready":
        return successColor;
      case "Processing":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Ready":
        return Icons.check_circle;
      case "Processing":
        return Icons.refresh;
      case "Failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recording Management"),
        actions: [
          Icon(
            Icons.videocam,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.video_library,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Recordings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${recordings.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.download,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Downloads",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((recordings.map((r) => r["downloadCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Streams",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((recordings.map((r) => r["streamCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.storage,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Storage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "17.1 GB",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search recordings...",
                    value: searchQuery,
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
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spSm),

            QHorizontalScroll(
              children: [
                QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Ready", "value": "Ready"},
                    {"label": "Processing", "value": "Processing"},
                    {"label": "Failed", "value": "Failed"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
                SizedBox(width: spSm),
                QDropdownField(
                  label: "Quality",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "4K Ultra HD", "value": "4K Ultra HD"},
                    {"label": "Full HD", "value": "Full HD"},
                    {"label": "HD", "value": "HD"},
                  ],
                  value: selectedQuality,
                  onChanged: (value, label) {
                    selectedQuality = value;
                    setState(() {});
                  },
                ),
                SizedBox(width: spSm),
                QDropdownField(
                  label: "Type",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Technology", "value": "Technology"},
                    {"label": "Workshop", "value": "Workshop"},
                    {"label": "Panel", "value": "Panel"},
                    {"label": "Leadership", "value": "Leadership"},
                  ],
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Recording List
            Text(
              "Recordings (${filteredRecordings.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Column(
              spacing: spSm,
              children: filteredRecordings.map((recording) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recording Header
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${recording["thumbnail"]}"),
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
                                  "${recording["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${recording["speaker"]} • ${recording["event"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(recording["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getStatusIcon(recording["status"]),
                                  color: _getStatusColor(recording["status"]),
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${recording["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(recording["status"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Processing Progress (if applicable)
                      if (recording["status"] == "Processing") ...[
                        Row(
                          children: [
                            Text(
                              "Processing Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(recording["processingProgress"] as double).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: (recording["processingProgress"] as double).toInt(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 100 - (recording["processingProgress"] as double).toInt(),
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spSm),
                      ],

                      // Recording Details
                      Row(
                        spacing: spLg,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${recording["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.storage,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${recording["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.high_quality,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${recording["quality"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Engagement Stats
                      if (recording["status"] == "Ready") ...[
                        Row(
                          spacing: spLg,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${(recording["downloadCount"] as int)} downloads",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${(recording["streamCount"] as int)} streams",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                      ],

                      // Tags
                      QHorizontalScroll(
                        children: (recording["tags"] as List).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          if (recording["status"] == "Ready") ...[
                            QButton(
                              label: "Download",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Share",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                          ],
                          if (recording["status"] == "Failed") ...[
                            QButton(
                              label: "Retry Processing",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                          ],
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.upload,
          color: Colors.white,
        ),
      ),
    );
  }
}

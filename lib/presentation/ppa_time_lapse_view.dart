import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaTimeLapseView extends StatefulWidget {
  const PpaTimeLapseView({super.key});

  @override
  State<PpaTimeLapseView> createState() => _PpaTimeLapseViewState();
}

class _PpaTimeLapseViewState extends State<PpaTimeLapseView> {
  List<Map<String, dynamic>> timeLapseVideos = [
    {
      "id": 1,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=sunset",
      "title": "Sunset Time-lapse",
      "duration": "00:30",
      "realDuration": "2h 30m",
      "location": "Grand Canyon",
      "date": "2024-03-15",
      "size": "45.2 MB",
      "resolution": "4K",
      "fps": 30,
      "interval": "5s",
      "frames": 1800,
      "status": "Completed"
    },
    {
      "id": 2,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=clouds",
      "title": "Cloud Formation",
      "duration": "01:15",
      "realDuration": "6h 15m",
      "location": "Mountain Peak",
      "date": "2024-03-14",
      "size": "98.7 MB",
      "resolution": "4K",
      "fps": 24,
      "interval": "10s",
      "frames": 2250,
      "status": "Completed"
    },
    {
      "id": 3,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=city",
      "title": "City Traffic Flow",
      "duration": "00:45",
      "realDuration": "3h 45m",
      "location": "Downtown NYC",
      "date": "2024-03-13",
      "size": "67.3 MB",
      "resolution": "1080p",
      "fps": 30,
      "interval": "3s",
      "frames": 4500,
      "status": "Completed"
    },
    {
      "id": 4,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=flower",
      "title": "Flower Blooming",
      "duration": "00:20",
      "realDuration": "12h",
      "location": "Garden Studio",
      "date": "2024-03-12",
      "size": "28.9 MB",
      "resolution": "1080p",
      "fps": 25,
      "interval": "15s",
      "frames": 2880,
      "status": "Processing"
    },
    {
      "id": 5,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=stars",
      "title": "Star Trails",
      "duration": "02:30",
      "realDuration": "8h",
      "location": "Desert Observatory",
      "date": "2024-03-11",
      "size": "156.4 MB",
      "resolution": "4K",
      "fps": 24,
      "interval": "30s",
      "frames": 960,
      "status": "Completed"
    },
  ];

  List<Map<String, dynamic>> filteredVideos = [];
  String selectedResolution = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool isRecording = false;
  String recordingTitle = "New Time-lapse";
  String selectedInterval = "5s";
  String selectedResolutionSetting = "4K";

  @override
  void initState() {
    super.initState();
    filteredVideos = timeLapseVideos;
  }

  void _filterVideos() {
    filteredVideos = timeLapseVideos.where((video) {
      bool matchesResolution = selectedResolution == "All" || video["resolution"] == selectedResolution;
      bool matchesStatus = selectedStatus == "All" || video["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          "${video["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${video["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesResolution && matchesStatus && matchesSearch;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Processing":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time-lapse Videos"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Time-lapse captures photos at intervals and creates smooth video playback");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recording Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isRecording ? dangerColor.withAlpha(10) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: isRecording ? Border.all(color: dangerColor, width: 2) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isRecording ? Icons.fiber_manual_record : Icons.videocam,
                        color: isRecording ? dangerColor : primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          isRecording ? "Recording Time-lapse..." : "Create New Time-lapse",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isRecording ? dangerColor : primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isRecording) ...[
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Time-lapse Title",
                      value: recordingTitle,
                      onChanged: (value) {
                        recordingTitle = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Capture Interval",
                            items: [
                              {"label": "1 second", "value": "1s"},
                              {"label": "3 seconds", "value": "3s"},
                              {"label": "5 seconds", "value": "5s"},
                              {"label": "10 seconds", "value": "10s"},
                              {"label": "15 seconds", "value": "15s"},
                              {"label": "30 seconds", "value": "30s"},
                              {"label": "1 minute", "value": "1m"},
                            ],
                            value: selectedInterval,
                            onChanged: (value, label) {
                              selectedInterval = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Resolution",
                            items: [
                              {"label": "4K (3840x2160)", "value": "4K"},
                              {"label": "1080p (1920x1080)", "value": "1080p"},
                              {"label": "720p (1280x720)", "value": "720p"},
                            ],
                            value: selectedResolutionSetting,
                            onChanged: (value, label) {
                              selectedResolutionSetting = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Time-lapse Recording",
                        icon: Icons.play_circle_filled,
                        size: bs.md,
                        onPressed: () {
                          isRecording = true;
                          setState(() {});
                          ss("Time-lapse recording started");
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                recordingTitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Recording: 00:15:32",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Interval: $selectedInterval",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Frames captured: 187",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Stop Recording",
                            icon: Icons.stop,
                            size: bs.md,
                            onPressed: () {
                              isRecording = false;
                              setState(() {});
                              ss("Time-lapse recording stopped and processing started");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.pause,
                          size: bs.md,
                          onPressed: () {
                            ss("Time-lapse recording paused");
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search time-lapse videos...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            _filterVideos();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: _filterVideos,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Resolution",
                          items: [
                            {"label": "All Resolutions", "value": "All"},
                            {"label": "4K", "value": "4K"},
                            {"label": "1080p", "value": "1080p"},
                            {"label": "720p", "value": "720p"},
                          ],
                          value: selectedResolution,
                          onChanged: (value, label) {
                            selectedResolution = value;
                            _filterVideos();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: [
                            {"label": "All Status", "value": "All"},
                            {"label": "Completed", "value": "Completed"},
                            {"label": "Processing", "value": "Processing"},
                            {"label": "Failed", "value": "Failed"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterVideos();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time-lapse Statistics",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.video_library,
                                color: primaryColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filteredVideos.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Videos",
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.storage,
                                color: successColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((timeLapseVideos.fold(0.0, (sum, item) => sum + (double.tryParse("${item["size"]}".replaceAll(" MB", "")) ?? 0.0)))).toStringAsFixed(1)} MB",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Storage",
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
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Time-lapse Videos List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredVideos.map((video) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${video["thumbnail"]}",
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${video["duration"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${video["status"]}").withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${video["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${video["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${video["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${video["resolution"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${video["size"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Real duration: ${video["realDuration"]} • ${video["fps"]} fps",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Play",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Playing time-lapse: ${video["title"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Sharing time-lapse: ${video["title"]}");
                                  },
                                ),
                              ],
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
      ),
    );
  }
}

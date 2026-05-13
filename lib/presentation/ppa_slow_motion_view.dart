import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSlowMotionView extends StatefulWidget {
  const PpaSlowMotionView({super.key});

  @override
  State<PpaSlowMotionView> createState() => _PpaSlowMotionViewState();
}

class _PpaSlowMotionViewState extends State<PpaSlowMotionView> {
  List<Map<String, dynamic>> slowMotionVideos = [
    {
      "id": 1,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=water",
      "title": "Water Splash",
      "duration": "00:15",
      "originalDuration": "00:03",
      "location": "Photography Studio",
      "date": "2024-03-15",
      "size": "32.4 MB",
      "resolution": "1080p",
      "fps": 120,
      "slowMotionRate": "0.25x",
      "quality": "High",
      "status": "Completed"
    },
    {
      "id": 2,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=sports",
      "title": "Basketball Shot",
      "duration": "00:25",
      "originalDuration": "00:05",
      "location": "Basketball Court",
      "date": "2024-03-14",
      "size": "58.7 MB",
      "resolution": "4K",
      "fps": 240,
      "slowMotionRate": "0.2x",
      "quality": "Ultra",
      "status": "Completed"
    },
    {
      "id": 3,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=nature",
      "title": "Bird in Flight",
      "duration": "00:30",
      "originalDuration": "00:06",
      "location": "Wildlife Reserve",
      "date": "2024-03-13",
      "size": "45.2 MB",
      "resolution": "1080p",
      "fps": 240,
      "slowMotionRate": "0.2x",
      "quality": "High",
      "status": "Completed"
    },
    {
      "id": 4,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=fire",
      "title": "Candle Flame",
      "duration": "00:20",
      "originalDuration": "00:04",
      "location": "Indoor Studio",
      "date": "2024-03-12",
      "size": "28.9 MB",
      "resolution": "720p",
      "fps": 120,
      "slowMotionRate": "0.2x",
      "quality": "Medium",
      "status": "Processing"
    },
    {
      "id": 5,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=dance",
      "title": "Dance Performance",
      "duration": "01:45",
      "originalDuration": "00:21",
      "location": "Dance Studio",
      "date": "2024-03-11",
      "size": "89.1 MB",
      "resolution": "4K",
      "fps": 240,
      "slowMotionRate": "0.2x",
      "quality": "Ultra",
      "status": "Completed"
    },
  ];

  List<Map<String, dynamic>> filteredVideos = [];
  String selectedResolution = "All";
  String selectedQuality = "All";
  String searchQuery = "";
  bool isRecording = false;
  String recordingTitle = "New Slow Motion";
  String selectedFps = "120";
  String selectedSlowRate = "0.25x";

  @override
  void initState() {
    super.initState();
    filteredVideos = slowMotionVideos;
  }

  void _filterVideos() {
    filteredVideos = slowMotionVideos.where((video) {
      bool matchesResolution = selectedResolution == "All" || video["resolution"] == selectedResolution;
      bool matchesQuality = selectedQuality == "All" || video["quality"] == selectedQuality;
      bool matchesSearch = searchQuery.isEmpty ||
          "${video["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${video["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesResolution && matchesQuality && matchesSearch;
    }).toList();
    setState(() {});
  }

  Color _getQualityColor(String quality) {
    switch (quality) {
      case "Ultra":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
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
        title: Text("Slow Motion Videos"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Slow motion captures high frame rate video for smooth playback at reduced speed");
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
                        isRecording ? Icons.fiber_manual_record : Icons.slow_motion_video,
                        color: isRecording ? dangerColor : primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          isRecording ? "Recording Slow Motion..." : "Create Slow Motion Video",
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
                      label: "Video Title",
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
                            label: "Frame Rate (FPS)",
                            items: [
                              {"label": "120 FPS", "value": "120"},
                              {"label": "240 FPS", "value": "240"},
                              {"label": "480 FPS", "value": "480"},
                              {"label": "960 FPS", "value": "960"},
                            ],
                            value: selectedFps,
                            onChanged: (value, label) {
                              selectedFps = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Slow Motion Rate",
                            items: [
                              {"label": "0.5x (Half Speed)", "value": "0.5x"},
                              {"label": "0.25x (Quarter)", "value": "0.25x"},
                              {"label": "0.2x (Super Slow)", "value": "0.2x"},
                              {"label": "0.1x (Ultra Slow)", "value": "0.1x"},
                            ],
                            value: selectedSlowRate,
                            onChanged: (value, label) {
                              selectedSlowRate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Recording Tips",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "• Keep the camera steady for best results\n• Ensure good lighting for clear slow motion\n• Higher FPS = smoother slow motion but larger file size",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Slow Motion Recording",
                        icon: Icons.videocam,
                        size: bs.md,
                        onPressed: () {
                          isRecording = true;
                          setState(() {});
                          ss("Slow motion recording started at $selectedFps FPS");
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
                                "Recording: 00:00:45",
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
                                "$selectedFps FPS • $selectedSlowRate speed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Storage: 45.2 MB",
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
                              ss("Slow motion recording stopped and processing started");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.pause,
                          size: bs.md,
                          onPressed: () {
                            ss("Slow motion recording paused");
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
                          label: "Search slow motion videos...",
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
                          label: "Filter by Quality",
                          items: [
                            {"label": "All Quality", "value": "All"},
                            {"label": "Ultra", "value": "Ultra"},
                            {"label": "High", "value": "High"},
                            {"label": "Medium", "value": "Medium"},
                          ],
                          value: selectedQuality,
                          onChanged: (value, label) {
                            selectedQuality = value;
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
                    "Slow Motion Collection",
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
                                Icons.slow_motion_video,
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
                                "Slow Motion Videos",
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
                                "${((slowMotionVideos.fold(0.0, (sum, item) => sum + (double.tryParse("${item["size"]}".replaceAll(" MB", "")) ?? 0.0)))).toStringAsFixed(1)} MB",
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

            // Slow Motion Videos Grid
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
                              bottom: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${video["slowMotionRate"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getQualityColor("${video["quality"]}").withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${video["quality"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
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
                              "${video["fps"]} FPS • Original: ${video["originalDuration"]}",
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
                                      ss("Playing slow motion: ${video["title"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Sharing slow motion: ${video["title"]}");
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

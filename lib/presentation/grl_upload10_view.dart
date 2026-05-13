import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload10View extends StatefulWidget {
  @override
  State<GrlUpload10View> createState() => _GrlUpload10ViewState();
}

class _GrlUpload10ViewState extends State<GrlUpload10View> {
  String selectedQuality = "high";
  String selectedResolution = "1920x1080";
  String selectedFramerate = "30";
  String selectedCodec = "h264";
  String selectedFormat = "mp4";
  bool extractAudio = false;
  bool addSubtitles = false;
  String audioQuality = "192";
  List<String> selectedFiles = [];

  List<Map<String, dynamic>> qualityItems = [
    {"label": "Low (Fast)", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Ultra (Slow)", "value": "ultra"},
  ];

  List<Map<String, dynamic>> resolutionItems = [
    {"label": "480p (854x480)", "value": "854x480"},
    {"label": "720p (1280x720)", "value": "1280x720"},
    {"label": "1080p (1920x1080)", "value": "1920x1080"},
    {"label": "1440p (2560x1440)", "value": "2560x1440"},
    {"label": "4K (3840x2160)", "value": "3840x2160"},
  ];

  List<Map<String, dynamic>> framerateItems = [
    {"label": "24 fps", "value": "24"},
    {"label": "30 fps", "value": "30"},
    {"label": "60 fps", "value": "60"},
    {"label": "120 fps", "value": "120"},
  ];

  List<Map<String, dynamic>> codecItems = [
    {"label": "H.264 (MP4)", "value": "h264"},
    {"label": "H.265 (HEVC)", "value": "h265"},
    {"label": "VP9 (WebM)", "value": "vp9"},
    {"label": "AV1", "value": "av1"},
  ];

  List<Map<String, dynamic>> formatItems = [
    {"label": "MP4", "value": "mp4"},
    {"label": "WebM", "value": "webm"},
    {"label": "AVI", "value": "avi"},
    {"label": "MOV", "value": "mov"},
    {"label": "MKV", "value": "mkv"},
  ];

  List<Map<String, dynamic>> audioQualityItems = [
    {"label": "96 kbps", "value": "96"},
    {"label": "128 kbps", "value": "128"},
    {"label": "192 kbps", "value": "192"},
    {"label": "256 kbps", "value": "256"},
    {"label": "320 kbps", "value": "320"},
  ];

  List<Map<String, dynamic>> processQueue = [
    {
      "name": "conference_recording.mp4",
      "originalSize": "2.4 GB",
      "newSize": "850 MB",
      "progress": 0.75,
      "status": "processing",
      "eta": "5m 23s",
      "resolution": "1080p → 720p",
      "codec": "H.264"
    },
    {
      "name": "tutorial_video.avi",
      "originalSize": "1.2 GB",
      "newSize": "320 MB",
      "progress": 1.0,
      "status": "completed",
      "eta": "0m 0s",
      "resolution": "720p → 480p",
      "codec": "H.265"
    },
    {
      "name": "presentation.mov",
      "originalSize": "3.8 GB",
      "newSize": "1.1 GB",
      "progress": 0.35,
      "status": "processing",
      "eta": "12m 45s",
      "resolution": "4K → 1080p",
      "codec": "VP9"
    },
    {
      "name": "webinar.mkv",
      "originalSize": "5.2 GB",
      "newSize": "1.8 GB",
      "progress": 0.0,
      "status": "queued",
      "eta": "25m 30s",
      "resolution": "1440p → 1080p",
      "codec": "H.264"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Processor"),
        actions: [
          IconButton(
            icon: Icon(Icons.video_settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Processing Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    dangerColor,
                    dangerColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.video_library,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Video Processing Center",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "PROCESSING",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                              "4",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Videos in Queue",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "65%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Size Reduction",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "18m",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Est. Remaining",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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

            // File Selection
            Text(
              "Select Videos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            QMultiImagePicker(
              label: "Choose Video Files",
              value: selectedFiles,
              maxImages: 10,
              hint: "Select video files to process",
              helper: "Supports MP4, AVI, MOV, MKV, WebM formats",
              onChanged: (value) {
                selectedFiles = value;
                setState(() {});
              },
            ),

            // Processing Settings
            Text(
              "Processing Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Quality",
                          items: qualityItems,
                          value: selectedQuality,
                          onChanged: (value, label) {
                            selectedQuality = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Resolution",
                          items: resolutionItems,
                          value: selectedResolution,
                          onChanged: (value, label) {
                            selectedResolution = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Frame Rate",
                          items: framerateItems,
                          value: selectedFramerate,
                          onChanged: (value, label) {
                            selectedFramerate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Codec",
                          items: codecItems,
                          value: selectedCodec,
                          onChanged: (value, label) {
                            selectedCodec = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Output Format",
                    items: formatItems,
                    value: selectedFormat,
                    onChanged: (value, label) {
                      selectedFormat = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Extract Audio",
                              "value": true,
                              "checked": extractAudio,
                            }
                          ],
                          value: [
                            if (extractAudio)
                              {
                                "label": "Extract Audio",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            extractAudio = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (extractAudio) ...[
                    QDropdownField(
                      label: "Audio Quality",
                      items: audioQualityItems,
                      value: audioQuality,
                      onChanged: (value, label) {
                        audioQuality = value;
                        setState(() {});
                      },
                    ),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Add Subtitles",
                              "value": true,
                              "checked": addSubtitles,
                            }
                          ],
                          value: [
                            if (addSubtitles)
                              {
                                "label": "Add Subtitles",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            addSubtitles = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Processing Queue
            Text(
              "Processing Queue",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...processQueue.map((video) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getProcessStatusColor(video["status"]).withAlpha(50),
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
                          color: _getProcessStatusColor(video["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.video_file,
                          color: _getProcessStatusColor(video["status"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${video["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${video["originalSize"]} → ${video["newSize"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getProcessStatusColor(video["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${video["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${video["resolution"]} • ${video["codec"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "ETA: ${video["eta"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (video["status"] == "processing") ...[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Processing...",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${((video["progress"] as double) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: video["progress"] as double,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                  ] else if (video["status"] == "completed") ...[
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Processing completed successfully",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Download",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            )),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Pause All",
                    color: warningColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Start Processing",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Quick Presets
            Text(
              "Quick Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildPresetCard(
                  "Web Optimized",
                  "720p, H.264, 30fps",
                  Icons.web,
                  primaryColor,
                ),
                _buildPresetCard(
                  "Mobile Friendly",
                  "480p, H.265, 24fps",
                  Icons.phone_android,
                  successColor,
                ),
                _buildPresetCard(
                  "High Quality",
                  "1080p, H.264, 60fps",
                  Icons.hd,
                  warningColor,
                ),
                _buildPresetCard(
                  "Space Saver",
                  "480p, H.265, 24fps",
                  Icons.storage,
                  infoColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Apply",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Color _getProcessStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return primaryColor;
      case "queued":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

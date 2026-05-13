import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaRecordingView extends StatefulWidget {
  const EmaRecordingView({super.key});

  @override
  State<EmaRecordingView> createState() => _EmaRecordingViewState();
}

class _EmaRecordingViewState extends State<EmaRecordingView> {
  bool isRecording = false;
  bool isPaused = false;
  String recordingDuration = "00:00:00";
  double recordingProgress = 0.0;
  String recordingTitle = "";
  String recordingDescription = "";
  String selectedQuality = "1080p";
  bool autoSave = true;
  
  List<Map<String, dynamic>> qualityOptions = [
    {"label": "4K (2160p)", "value": "4K"},
    {"label": "Full HD (1080p)", "value": "1080p"},
    {"label": "HD (720p)", "value": "720p"},
    {"label": "SD (480p)", "value": "480p"},
  ];

  List<Map<String, dynamic>> recordings = [
    {
      "id": "rec_001",
      "title": "AI Healthcare Diagnosis Tutorial",
      "description": "Complete guide to implementing AI-powered diagnostic tools in healthcare",
      "duration": "2:15:30",
      "fileSize": "1.2 GB",
      "quality": "1080p",
      "recordedDate": "2024-12-18",
      "status": "completed",
      "views": 3547,
      "likes": 892,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=medical",
    },
    {
      "id": "rec_002",
      "title": "Machine Learning in Drug Discovery",
      "description": "How AI accelerates pharmaceutical research and development processes",
      "duration": "1:45:20",
      "fileSize": "850 MB",
      "quality": "1080p",
      "recordedDate": "2024-12-16",
      "status": "completed",
      "views": 2134,
      "likes": 567,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=research",
    },
    {
      "id": "rec_003",
      "title": "Telemedicine Best Practices",
      "description": "Essential guidelines for effective remote healthcare delivery",
      "duration": "1:20:45",
      "fileSize": "640 MB",
      "quality": "720p",
      "recordedDate": "2024-12-14",
      "status": "processing",
      "views": 0,
      "likes": 0,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=telehealth",
    },
    {
      "id": "rec_004",
      "title": "Digital Health Security",
      "description": "Protecting patient data in digital healthcare systems",
      "duration": "0:45:12",
      "fileSize": "325 MB",
      "quality": "1080p",
      "recordedDate": "2024-12-12",
      "status": "failed",
      "views": 0,
      "likes": 0,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=security",
    },
  ];

  List<Map<String, dynamic>> recordingSettings = [
    {
      "title": "Auto-save recordings",
      "description": "Automatically save recordings to cloud storage",
      "isEnabled": true,
    },
    {
      "title": "Background noise reduction",
      "description": "Apply AI-powered noise cancellation during recording",
      "isEnabled": true,
    },
    {
      "title": "Auto-transcription",
      "description": "Generate automatic transcripts for recordings",
      "isEnabled": false,
    },
    {
      "title": "Real-time backup",
      "description": "Create backup copies during recording",
      "isEnabled": true,
    },
  ];

  int selectedTab = 0;

  void _startRecording() {
    if (recordingTitle.isNotEmpty) {
      isRecording = true;
      isPaused = false;
      ss("Recording started: $recordingTitle");
      setState(() {});
    } else {
      se("Please enter a recording title");
    }
  }

  void _stopRecording() {
    isRecording = false;
    isPaused = false;
    ss("Recording stopped and saved");
    recordingTitle = "";
    recordingDescription = "";
    recordingDuration = "00:00:00";
    recordingProgress = 0.0;
    setState(() {});
  }

  void _pauseResumeRecording() {
    isPaused = !isPaused;
    ss(isPaused ? "Recording paused" : "Recording resumed");
    setState(() {});
  }

  void _deleteRecording(String recordingId) {
    recordings.removeWhere((recording) => recording["id"] == recordingId);
    ss("Recording deleted successfully");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Recording Studio",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Record", icon: Icon(Icons.fiber_manual_record)),
        Tab(text: "My Recordings", icon: Icon(Icons.video_library)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRecordTab(),
        _buildRecordingsTab(),
        _buildSettingsTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildRecordTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recording Status
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isRecording 
                  ? [dangerColor, dangerColor.withAlpha(180)]
                  : [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                if (isRecording) ...[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPaused ? Icons.pause : Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    isPaused ? "PAUSED" : "RECORDING",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    recordingDuration,
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: recordingProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Icon(
                    Icons.videocam,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Ready to Record",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Set up your recording and press start when ready",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Recording Setup
          if (!isRecording) ...[
            Text(
              "Recording Setup",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Recording Title",
                    value: recordingTitle,
                    hint: "Enter a title for your recording",
                    validator: Validator.required,
                    onChanged: (value) {
                      recordingTitle = value;
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Description",
                    value: recordingDescription,
                    hint: "Describe what your recording will cover",
                    onChanged: (value) {
                      recordingDescription = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Recording Quality",
                    items: qualityOptions,
                    value: selectedQuality,
                    onChanged: (value, label) {
                      selectedQuality = value;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Auto-save Options",
                    items: [
                      {
                        "label": "Auto-save to cloud",
                        "value": true,
                        "checked": autoSave,
                      }
                    ],
                    value: [if (autoSave) {"label": "Auto-save to cloud", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoSave = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),
          ],

          // Recording Controls
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Recording Controls",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    if (!isRecording) ...[
                      Expanded(
                        child: QButton(
                          label: "Start Recording",
                          color: dangerColor,
                          size: bs.md,
                          onPressed: _startRecording,
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: QButton(
                          label: isPaused ? "Resume" : "Pause",
                          color: warningColor,
                          size: bs.md,
                          onPressed: _pauseResumeRecording,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Stop & Save",
                          color: successColor,
                          size: bs.md,
                          onPressed: _stopRecording,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Recording Tips
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: infoColor, size: 20),
                    SizedBox(width: spMd),
                    Text(
                      "Recording Tips",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "• Test your audio and video setup before recording\n"
                  "• Ensure good lighting and stable camera position\n"
                  "• Use a quiet environment to minimize background noise\n"
                  "• Prepare your content outline in advance\n"
                  "• Keep recordings under 3 hours for optimal file handling\n"
                  "• Use auto-save to prevent data loss",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Recordings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: recordings.map((recording) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${recording["thumbnail"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${recording["duration"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: recording["status"] == "completed" ? successColor :
                                    recording["status"] == "processing" ? warningColor :
                                    dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${recording["status"].toString().toUpperCase()}",
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Recording Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${recording["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${recording["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "${recording["quality"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${recording["fileSize"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (recording["status"] == "completed") ...[
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.visibility, color: disabledBoldColor, size: 12),
                              SizedBox(width: spXs),
                              Text(
                                "${recording["views"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.favorite, color: dangerColor, size: 12),
                              SizedBox(width: spXs),
                              Text(
                                "${recording["likes"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: spMd),
                        
                        // Action Buttons
                        if (recording["status"] == "completed") ...[
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Play",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Playing: ${recording["title"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.delete,
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () => _deleteRecording(recording["id"]),
                              ),
                            ],
                          ),
                        ] else if (recording["status"] == "processing") ...[
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Processing...",
                              color: warningColor,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Retry",
                                  color: warningColor,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Retrying recording: ${recording["title"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.delete,
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () => _deleteRecording(recording["id"]),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recording Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...recordingSettings.map((setting) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${setting["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${setting["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: setting["isEnabled"],
                  onChanged: (value) {
                    setting["isEnabled"] = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          )).toList(),

          SizedBox(height: spLg),

          // Storage Management
          Text(
            "Storage Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.cloud_upload, color: primaryColor, size: 24),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cloud Storage Usage",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "4.2 GB of 50 GB used",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "8.4%",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.084,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Manage Storage",
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening storage management");
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Export Settings
          Text(
            "Export Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QDropdownField(
                  label: "Default Export Quality",
                  items: qualityOptions,
                  value: selectedQuality,
                  onChanged: (value, label) {
                    selectedQuality = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export All Recordings",
                        size: bs.sm,
                        onPressed: () {
                          ss("Exporting all recordings");
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "Clear Cache",
                        color: warningColor,
                        size: bs.sm,
                        onPressed: () {
                          ss("Cache cleared");
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recording Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Analytics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.video_library, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${recordings.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Recordings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "5,681",
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
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "1,459",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Likes",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "6:06:07",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Duration",
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

          SizedBox(height: spLg),

          // Top Performing Recordings
          Text(
            "Top Performing Recordings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...recordings.where((rec) => rec["status"] == "completed")
              .map((recording) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${recording["thumbnail"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${recording["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${recording["duration"]} • ${recording["recordedDate"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${recording["views"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: dangerColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${recording["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),

          SizedBox(height: spLg),

          // Performance Insights
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.insights, color: infoColor, size: 20),
                    SizedBox(width: spMd),
                    Text(
                      "Performance Insights",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "• Your healthcare AI recordings have 45% higher engagement than average\n"
                  "• Peak viewing time for your content is between 2:00 PM - 4:00 PM\n"
                  "• Tutorial-style recordings perform 30% better than lectures\n"
                  "• Recordings under 2 hours have 60% higher completion rates\n"
                  "• Your average recording quality score is 4.7/5.0",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

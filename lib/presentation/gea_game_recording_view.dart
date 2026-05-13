import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameRecordingView extends StatefulWidget {
  const GeaGameRecordingView({super.key});

  @override
  State<GeaGameRecordingView> createState() => _GeaGameRecordingViewState();
}

class _GeaGameRecordingViewState extends State<GeaGameRecordingView> {
  int currentTab = 0;
  bool isRecording = false;
  String recordingTime = "00:00:00";
  String recordingQuality = "1080p";
  bool includeAudio = true;
  bool includeMicrophone = true;
  bool showSystemNotifications = false;
  String selectedFormat = "MP4";
  String storageLocation = "/Games/Recordings";
  double recordingFrameRate = 60.0;

  List<Map<String, dynamic>> recordings = [
    {
      "id": "rec_001",
      "title": "Victory Royale - Solos",
      "game": "Fortnite",
      "duration": "05:23",
      "size": "842.5 MB",
      "quality": "1080p",
      "fps": 60,
      "date": "2024-01-15T10:30:00",
      "thumbnail": "https://picsum.photos/320/180?random=101&keyword=gaming",
      "views": 0,
      "shared": false,
      "bookmarked": false,
      "highlights": ["Victory", "5 Kills", "Final Circle"],
    },
    {
      "id": "rec_002", 
      "title": "Clutch 1v4 - Ranked",
      "game": "Valorant",
      "duration": "02:47",
      "size": "425.8 MB",
      "quality": "1080p",
      "fps": 144,
      "date": "2024-01-14T20:15:00",
      "thumbnail": "https://picsum.photos/320/180?random=102&keyword=valorant",
      "views": 12,
      "shared": true,
      "bookmarked": true,
      "highlights": ["Clutch", "4K", "Ace"],
    },
    {
      "id": "rec_003",
      "title": "Epic Boss Fight",
      "game": "Elden Ring",
      "duration": "12:56",
      "size": "1.2 GB",
      "quality": "1440p",
      "fps": 60,
      "date": "2024-01-13T18:45:00",
      "thumbnail": "https://picsum.photos/320/180?random=103&keyword=boss",
      "views": 3,
      "shared": false,
      "bookmarked": true,
      "highlights": ["Boss Fight", "No Death"],
    },
    {
      "id": "rec_004",
      "title": "Speedrun Attempt",
      "game": "Celeste",
      "duration": "45:12",
      "size": "2.1 GB",
      "quality": "1080p",
      "fps": 120,
      "date": "2024-01-12T14:20:00",
      "thumbnail": "https://picsum.photos/320/180?random=104&keyword=speedrun",
      "views": 8,
      "shared": true,
      "bookmarked": false,
      "highlights": ["PB", "Sub 46"],
    },
    {
      "id": "rec_005",
      "title": "Funny Moments Compilation",
      "game": "Among Us",
      "duration": "08:34",
      "size": "654.2 MB",
      "quality": "1080p",
      "fps": 60,
      "date": "2024-01-11T16:00:00",
      "thumbnail": "https://picsum.photos/320/180?random=105&keyword=funny",
      "views": 25,
      "shared": true,
      "bookmarked": false,
      "highlights": ["Funny", "Impostor Win"],
    },
  ];

  List<Map<String, dynamic>> recordingPresets = [
    {
      "name": "High Quality",
      "quality": "1440p",
      "fps": 60,
      "bitrate": "50 Mbps",
      "format": "MP4",
    },
    {
      "name": "Streaming",
      "quality": "1080p", 
      "fps": 60,
      "bitrate": "25 Mbps",
      "format": "MP4",
    },
    {
      "name": "Storage Saver",
      "quality": "720p",
      "fps": 30,
      "bitrate": "10 Mbps",
      "format": "MP4",
    },
    {
      "name": "Competitive",
      "quality": "1080p",
      "fps": 144,
      "bitrate": "35 Mbps",
      "format": "MP4",
    },
  ];

  List<String> qualityOptions = ["720p", "1080p", "1440p", "4K"];
  List<String> formatOptions = ["MP4", "AVI", "MOV", "MKV"];
  List<double> fpsOptions = [30, 60, 120, 144];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Game Recording",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Record", icon: Icon(Icons.videocam)),
        Tab(text: "Library", icon: Icon(Icons.video_library)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildRecordTab(),
        _buildLibraryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildRecordTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recording Status Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isRecording ? dangerColor.withAlpha(20) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isRecording ? dangerColor : disabledOutlineBorderColor,
                width: 2,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  isRecording ? Icons.fiber_manual_record : Icons.videocam_off,
                  size: 48,
                  color: isRecording ? dangerColor : disabledBoldColor,
                ),
                Text(
                  isRecording ? "RECORDING" : "READY TO RECORD",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: isRecording ? dangerColor : primaryColor,
                  ),
                ),
                if (isRecording)
                  Text(
                    recordingTime,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isRecording ? "Stop Recording" : "Start Recording",
                    color: isRecording ? dangerColor : successColor,
                    size: bs.md,
                    onPressed: () {
                      isRecording = !isRecording;
                      if (isRecording) {
                        recordingTime = "00:00:01";
                        ss("Recording started");
                      } else {
                        ss("Recording saved to library");
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Quick Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Icon(
                              Icons.high_quality,
                              color: primaryColor,
                              size: 24,
                            ),
                            Text(
                              "Quality",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              recordingQuality,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Icon(
                              Icons.speed,
                              color: primaryColor,
                              size: 24,
                            ),
                            Text(
                              "FPS",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${recordingFrameRate.toInt()}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Icon(
                              includeAudio ? Icons.volume_up : Icons.volume_off,
                              color: primaryColor,
                              size: 24,
                            ),
                            Text(
                              "Audio",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              includeAudio ? "ON" : "OFF",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

          // Recording Presets
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recording Presets",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: recordingPresets.map((preset) {
                    return GestureDetector(
                      onTap: () {
                        recordingQuality = "${preset["quality"]}";
                        recordingFrameRate = (preset["fps"] as int).toDouble();
                        selectedFormat = "${preset["format"]}";
                        ss("Applied ${preset["name"]} preset");
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.tune,
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
                                    "${preset["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${preset["quality"]} • ${preset["fps"]}fps • ${preset["bitrate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Library Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        Icons.video_library,
                        color: primaryColor,
                        size: 32,
                      ),
                      Text(
                        "${recordings.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Recordings",
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        Icons.storage,
                        color: infoColor,
                        size: 32,
                      ),
                      Text(
                        "5.2 GB",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Used Space",
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

          // Recordings List
          Column(
            spacing: spSm,
            children: recordings.map((recording) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Thumbnail
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${recording["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(4),
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
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
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
                            "${recording["game"]} • ${recording["quality"]} ${recording["fps"]}fps",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              if (recording["shared"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "Shared",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              if (recording["shared"] as bool) SizedBox(width: spXs),
                              Text(
                                "${recording["size"]}",
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
                    Column(
                      spacing: spXs,
                      children: [
                        GestureDetector(
                          onTap: () {
                            recording["bookmarked"] = !(recording["bookmarked"] as bool);
                            setState(() {});
                          },
                          child: Icon(
                            (recording["bookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                            color: (recording["bookmarked"] as bool) ? warningColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () => _showRecordingOptions(recording),
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

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recording Quality Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recording Quality",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Resolution",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              recordingQuality,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Frame Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${recordingFrameRate.toInt()} fps",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
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

          // Audio Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Audio Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Include Game Audio",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: includeAudio,
                      onChanged: (value) {
                        includeAudio = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Include Microphone",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: includeMicrophone,
                      onChanged: (value) {
                        includeMicrophone = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Storage & Format Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Storage & Format",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Output Format",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        selectedFormat,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Storage Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              storageLocation,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.folder_open,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notifications
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Show System Notifications",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: showSystemNotifications,
                      onChanged: (value) {
                        showSystemNotifications = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
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

  void _showRecordingOptions(Map<String, dynamic> recording) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${recording["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildOptionButton("Play Recording", Icons.play_arrow, () {
              back();
              ss("Playing ${recording["title"]}");
            }),
            _buildOptionButton("Share Recording", Icons.share, () {
              back();
              ss("Sharing ${recording["title"]}");
            }),
            _buildOptionButton("Edit Recording", Icons.edit, () {
              back();
              ss("Opening editor for ${recording["title"]}");
            }),
            _buildOptionButton("Export Recording", Icons.file_download, () {
              back();
              ss("Exporting ${recording["title"]}");
            }),
            _buildOptionButton("Delete Recording", Icons.delete, () async {
              back();
              bool isConfirmed = await confirm("Are you sure you want to delete this recording?");
              if (isConfirmed) {
                recordings.removeWhere((r) => r["id"] == recording["id"]);
                ss("Recording deleted");
                setState(() {});
              }
            }, color: dangerColor),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, IconData icon, VoidCallback onPressed, {Color? color}) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: label,
        icon: icon,
        color: color ?? primaryColor,
        size: bs.md,
        onPressed: onPressed,
      ),
    );
  }
}

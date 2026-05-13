import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaClassRecordingView extends StatefulWidget {
  const ElaClassRecordingView({super.key});

  @override
  State<ElaClassRecordingView> createState() => _ElaClassRecordingViewState();
}

class _ElaClassRecordingViewState extends State<ElaClassRecordingView> {
  int currentTab = 0;
  String selectedSubject = "All Subjects";
  String selectedQuality = "HD";
  bool autoRecord = true;
  bool recordChat = true;
  bool recordScreenShare = true;

  List<Map<String, dynamic>> subjectFilters = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Mathematics", "value": "Mathematics"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "English", "value": "English"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "HD (720p)", "value": "HD"},
    {"label": "Full HD (1080p)", "value": "FHD"},
    {"label": "Standard (480p)", "value": "SD"},
  ];

  List<Map<String, dynamic>> recordings = [
    {
      "id": 1,
      "title": "Advanced Calculus - Integration Techniques",
      "subject": "Mathematics",
      "instructor": "Dr. Sarah Chen",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "duration": 90,
      "size": "850 MB",
      "quality": "HD",
      "views": 45,
      "likes": 38,
      "thumbnailUrl": "https://picsum.photos/300/200?random=1&keyword=math",
      "recordingUrl": "https://example.com/recording1.mp4",
      "status": "Available",
      "hasTranscript": true,
      "hasCaptions": true,
    },
    {
      "id": 2,
      "title": "Quantum Physics - Wave Particle Duality",
      "subject": "Physics",
      "instructor": "Prof. Michael Johnson",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "duration": 120,
      "size": "1.2 GB",
      "quality": "Full HD",
      "views": 32,
      "likes": 28,
      "thumbnailUrl": "https://picsum.photos/300/200?random=2&keyword=physics",
      "recordingUrl": "https://example.com/recording2.mp4",
      "status": "Processing",
      "hasTranscript": false,
      "hasCaptions": false,
    },
    {
      "id": 3,
      "title": "Organic Chemistry - Reaction Mechanisms",
      "subject": "Chemistry",
      "instructor": "Dr. Emily Rodriguez",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "duration": 75,
      "size": "680 MB",
      "quality": "HD",
      "views": 28,
      "likes": 24,
      "thumbnailUrl": "https://picsum.photos/300/200?random=3&keyword=chemistry",
      "recordingUrl": "https://example.com/recording3.mp4",
      "status": "Available",
      "hasTranscript": true,
      "hasCaptions": true,
    },
    {
      "id": 4,
      "title": "Cell Biology - Mitosis and Meiosis",
      "subject": "Biology",
      "instructor": "Dr. David Kim",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "duration": 60,
      "size": "520 MB",
      "quality": "HD",
      "views": 52,
      "likes": 41,
      "thumbnailUrl": "https://picsum.photos/300/200?random=4&keyword=biology",
      "recordingUrl": "https://example.com/recording4.mp4",
      "status": "Available",
      "hasTranscript": true,
      "hasCaptions": false,
    },
    {
      "id": 5,
      "title": "Linear Algebra - Matrix Operations",
      "subject": "Mathematics",
      "instructor": "Dr. John Davis",
      "date": DateTime.now().subtract(Duration(days: 4)),
      "duration": 85,
      "size": "780 MB",
      "quality": "HD",
      "views": 36,
      "likes": 31,
      "thumbnailUrl": "https://picsum.photos/300/200?random=5&keyword=algebra",
      "recordingUrl": "https://example.com/recording5.mp4",
      "status": "Available",
      "hasTranscript": true,
      "hasCaptions": true,
    },
  ];

  List<Map<String, dynamic>> liveRecordings = [
    {
      "id": 1,
      "title": "Advanced Statistics - Current Session",
      "instructor": "Prof. Lisa Anderson",
      "startTime": DateTime.now().subtract(Duration(minutes: 45)),
      "currentDuration": 45,
      "status": "Recording",
      "quality": "HD",
      "participants": 38,
    },
    {
      "id": 2,
      "title": "Thermodynamics - Lab Session",
      "instructor": "Dr. Robert Martinez",
      "startTime": DateTime.now().subtract(Duration(minutes: 20)),
      "currentDuration": 20,
      "status": "Recording",
      "quality": "Full HD",
      "participants": 25,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Processing":
        return warningColor;
      case "Recording":
        return dangerColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return "${minutes}min";
    } else {
      int hours = (minutes / 60).floor();
      int remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return "${hours}h";
      }
      return "${hours}h ${remainingMinutes}min";
    }
  }

  Widget _buildRecordingCard(Map<String, dynamic> recording) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${recording["thumbnailUrl"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(127),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${recording["status"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${recording["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(127),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _formatDuration(recording["duration"] as int),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(127),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${recording["quality"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if ("${recording["status"]}" == "Available")
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(127),
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
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${recording["subject"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (recording["hasTranscript"] as bool)
                      Icon(
                        Icons.closed_caption,
                        size: 16,
                        color: successColor,
                      ),
                    if (recording["hasCaptions"] as bool) ...[
                      SizedBox(width: spXs),
                      Icon(
                        Icons.subtitles,
                        size: 16,
                        color: successColor,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${recording["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${recording["instructor"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${(recording["date"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.storage,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${recording["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.visibility,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${recording["views"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      Icons.thumb_up,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${recording["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "${recording["status"]}" == "Available" ? "Play" : "Processing...",
                        onPressed: () {
                          if ("${recording["status"]}" == "Available") {
                            ss("Playing recording: ${recording["title"]}");
                          } else {
                            si("Recording is still processing");
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Downloading recording");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        ss("Recording link shared");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showRecordingOptions(recording);
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
  }

  Widget _buildLiveRecordingCard(Map<String, dynamic> recording) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${recording["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "RECORDING",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${recording["instructor"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "Started: ${(recording["startTime"] as DateTime).kkmm}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "Duration: ${_formatDuration(recording["currentDuration"] as int)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.people,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${recording["participants"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Stop Recording",
                  onPressed: () {
                    _stopRecording(recording);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.pause,
                size: bs.sm,
                onPressed: () {
                  sw("Recording paused");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {
                  _showRecordingSettings();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recording Settings",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Default Quality",
            items: qualityOptions,
            value: selectedQuality,
            onChanged: (value, label) {
              selectedQuality = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                autoRecord ? Icons.check_box : Icons.check_box_outline_blank,
                color: autoRecord ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    autoRecord = !autoRecord;
                    setState(() {});
                  },
                  child: Text(
                    "Auto-record all classes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                recordChat ? Icons.check_box : Icons.check_box_outline_blank,
                color: recordChat ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    recordChat = !recordChat;
                    setState(() {});
                  },
                  child: Text(
                    "Include chat messages",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                recordScreenShare ? Icons.check_box : Icons.check_box_outline_blank,
                color: recordScreenShare ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    recordScreenShare = !recordScreenShare;
                    setState(() {});
                  },
                  child: Text(
                    "Record screen sharing",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              onPressed: () {
                ss("Recording settings saved");
              },
            ),
          ),
        ],
      ),
    );
  }

  void _stopRecording(Map<String, dynamic> recording) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Stop Recording"),
        content: Text("Are you sure you want to stop recording \"${recording["title"]}\"?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              setState(() {
                liveRecordings.removeWhere((r) => r["id"] == recording["id"]);
              });
              ss("Recording stopped and saved");
            },
            child: Text(
              "Stop Recording",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecordingOptions(Map<String, dynamic> recording) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Recording Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Details"),
              onTap: () {
                back();
                ss("Editing recording details");
              },
            ),
            ListTile(
              leading: Icon(Icons.closed_caption),
              title: Text("Generate Transcript"),
              onTap: () {
                back();
                ss("Generating transcript");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Recording"),
              onTap: () {
                back();
                _deleteRecording(recording);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _deleteRecording(Map<String, dynamic> recording) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Recording"),
        content: Text("Are you sure you want to permanently delete \"${recording["title"]}\"?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              sw("Recording deleted");
            },
            child: Text(
              "Delete",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecordingSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Live Recording Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Quality: $selectedQuality"),
            SizedBox(height: spSm),
            Text("Auto-record: ${autoRecord ? 'Enabled' : 'Disabled'}"),
            SizedBox(height: spSm),
            Text("Include chat: ${recordChat ? 'Yes' : 'No'}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Class Recordings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Recordings", icon: Icon(Icons.video_library)),
        Tab(text: "Live", icon: Icon(Icons.fiber_manual_record)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        // All Recordings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QDropdownField(
                label: "Filter by Subject",
                items: subjectFilters,
                value: selectedSubject,
                onChanged: (value, label) {
                  selectedSubject = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              ...recordings.map((recording) => _buildRecordingCard(recording)),
            ],
          ),
        ),
        // Live Recordings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (liveRecordings.isEmpty)
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "No live recordings in progress",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...liveRecordings.map((recording) => _buildLiveRecordingCard(recording)),
            ],
          ),
        ),
        // Settings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildRecordingSettings(),
        ),
      ],
    );
  }
}

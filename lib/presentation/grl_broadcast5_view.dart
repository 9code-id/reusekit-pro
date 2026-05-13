import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast5View extends StatefulWidget {
  @override
  State<GrlBroadcast5View> createState() => _GrlBroadcast5ViewState();
}

class _GrlBroadcast5ViewState extends State<GrlBroadcast5View> {
  bool isRecording = false;
  String selectedQuality = "HD";
  String broadcastTitle = "";
  String description = "";
  bool isPrivate = false;
  int estimatedViewers = 0;

  List<Map<String, dynamic>> recentBroadcasts = [
    {
      "id": 1,
      "title": "Morning Tech Talk",
      "date": "2024-01-15",
      "duration": "1h 25m",
      "views": 12500,
      "status": "Published",
      "thumbnail": "https://picsum.photos/150/100?random=1&keyword=tech",
    },
    {
      "id": 2,
      "title": "Live Q&A Session",
      "date": "2024-01-14",
      "duration": "45m",
      "views": 8900,
      "status": "Published",
      "thumbnail": "https://picsum.photos/150/100?random=2&keyword=meeting",
    },
    {
      "id": 3,
      "title": "Product Launch Event",
      "date": "2024-01-13",
      "duration": "2h 10m",
      "views": 25600,
      "status": "Published",
      "thumbnail": "https://picsum.photos/150/100?random=3&keyword=product",
    }
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "SD (480p)", "value": "SD"},
    {"label": "HD (720p)", "value": "HD"},
    {"label": "Full HD (1080p)", "value": "FHD"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildBroadcastSetup(),
            SizedBox(height: spLg),
            _buildStreamControls(),
            SizedBox(height: spLg),
            _buildStreamStats(),
            SizedBox(height: spLg),
            _buildRecentBroadcasts(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [dangerColor, warningColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.broadcast_on_personal,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Broadcast Studio",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Start your live broadcast and connect with audience",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: isRecording ? dangerColor : successColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                isRecording ? "ON AIR" : "READY",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBroadcastSetup() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_applications,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Broadcast Setup",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Broadcast Title",
            value: broadcastTitle,
            hint: "Enter your broadcast title",
            onChanged: (value) {
              broadcastTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe what your broadcast is about",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Stream Quality",
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
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Private Stream",
                      "value": "private",
                      "checked": isPrivate,
                    }
                  ],
                  value: [
                    if (isPrivate)
                      {
                        "label": "Private Stream",
                        "value": "private",
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    isPrivate = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreamControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.control_camera,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Stream Controls",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isRecording && broadcastTitle.isNotEmpty) {
                      isRecording = true;
                      estimatedViewers = 0;
                      ss("Broadcast started successfully!");
                    } else if (isRecording) {
                      isRecording = false;
                      ss("Broadcast stopped");
                    } else {
                      se("Please enter broadcast title first");
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: isRecording ? dangerColor : successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          isRecording ? Icons.stop : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          isRecording ? "Stop Broadcast" : "Start Broadcast",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Column(
                children: [
                  _buildControlButton(
                    icon: Icons.mic,
                    label: "Audio",
                    color: infoColor,
                    onTap: () {
                      si("Audio settings opened");
                    },
                  ),
                  SizedBox(height: spSm),
                  _buildControlButton(
                    icon: Icons.videocam,
                    label: "Video",
                    color: warningColor,
                    onTap: () {
                      si("Video settings opened");
                    },
                  ),
                  SizedBox(height: spSm),
                  _buildControlButton(
                    icon: Icons.screen_share,
                    label: "Screen",
                    color: secondaryColor,
                    onTap: () {
                      si("Screen sharing enabled");
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Live Statistics",
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
                child: _buildStatCard(
                  title: "Current Viewers",
                  value: isRecording ? "${estimatedViewers + (DateTime.now().millisecond % 100)}" : "0",
                  icon: Icons.visibility,
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  title: "Stream Duration",
                  value: isRecording ? "15:30" : "00:00",
                  icon: Icons.timer,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: "Quality",
                  value: selectedQuality,
                  icon: Icons.high_quality,
                  color: warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  title: "Status",
                  value: isRecording ? "Live" : "Offline",
                  icon: isRecording ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isRecording ? dangerColor : disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBroadcasts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.history,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Recent Broadcasts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: recentBroadcasts.map((broadcast) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${broadcast["thumbnail"]}",
                      width: 60,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${broadcast["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${broadcast["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${broadcast["duration"]}",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(broadcast["views"] as int) > 1000 ? '${((broadcast["views"] as int) / 1000).toStringAsFixed(1)}K' : broadcast["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${broadcast["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
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
    );
  }
}

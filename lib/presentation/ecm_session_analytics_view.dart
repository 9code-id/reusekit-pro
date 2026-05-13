import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSessionAnalyticsView extends StatefulWidget {
  const EcmSessionAnalyticsView({super.key});

  @override
  State<EcmSessionAnalyticsView> createState() => _EcmSessionAnalyticsViewState();
}

class _EcmSessionAnalyticsViewState extends State<EcmSessionAnalyticsView> {
  int currentTab = 0;
  String selectedSession = "All Sessions";
  String selectedTimeframe = "Today";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> sessionOptions = [
    {"label": "All Sessions", "value": "All Sessions"},
    {"label": "AI in Healthcare", "value": "AI in Healthcare"},
    {"label": "Future of Work", "value": "Future of Work"},
    {"label": "Sustainable Technology", "value": "Sustainable Technology"},
    {"label": "Digital Transformation", "value": "Digital Transformation"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> sessionStats = [
    {
      "session": "AI in Healthcare",
      "speaker": "Dr. Sarah Chen",
      "duration": "45 min",
      "attendees": 342,
      "maxCapacity": 400,
      "avgRating": 4.8,
      "engagement": 92,
      "qnaQuestions": 23,
      "pollResponses": 156,
      "chatMessages": 89,
      "downloads": 178,
      "status": "Completed",
      "startTime": "09:00 AM",
      "endTime": "09:45 AM",
    },
    {
      "session": "Future of Work",
      "speaker": "Mark Rodriguez",
      "duration": "60 min",
      "attendees": 289,
      "maxCapacity": 350,
      "avgRating": 4.6,
      "engagement": 88,
      "qnaQuestions": 19,
      "pollResponses": 134,
      "chatMessages": 67,
      "downloads": 145,
      "status": "Completed",
      "startTime": "10:30 AM",
      "endTime": "11:30 AM",
    },
    {
      "session": "Sustainable Technology",
      "speaker": "Emma Thompson",
      "duration": "50 min",
      "attendees": 267,
      "maxCapacity": 300,
      "avgRating": 4.7,
      "engagement": 85,
      "qnaQuestions": 16,
      "pollResponses": 98,
      "chatMessages": 54,
      "downloads": 123,
      "status": "In Progress",
      "startTime": "02:00 PM",
      "endTime": "02:50 PM",
    },
    {
      "session": "Digital Transformation",
      "speaker": "James Wilson",
      "duration": "40 min",
      "attendees": 198,
      "maxCapacity": 250,
      "avgRating": 4.5,
      "engagement": 82,
      "qnaQuestions": 12,
      "pollResponses": 87,
      "chatMessages": 43,
      "downloads": 89,
      "status": "Upcoming",
      "startTime": "03:30 PM",
      "endTime": "04:10 PM",
    },
  ];

  List<Map<String, dynamic>> realTimeMetrics = [
    {
      "metric": "Active Attendees",
      "value": "1,247",
      "change": "+23",
      "trend": "up",
      "icon": Icons.people,
      "color": Colors.blue,
    },
    {
      "metric": "Current Sessions",
      "value": "3",
      "change": "0",
      "trend": "stable",
      "icon": Icons.play_circle,
      "color": Colors.green,
    },
    {
      "metric": "Average Engagement",
      "value": "87%",
      "change": "+5%",
      "trend": "up",
      "icon": Icons.trending_up,
      "color": Colors.orange,
    },
    {
      "metric": "Technical Issues",
      "value": "2",
      "change": "-1",
      "trend": "down",
      "icon": Icons.warning,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> attendanceData = [
    {"time": "09:00", "count": 45},
    {"time": "09:15", "count": 156},
    {"time": "09:30", "count": 289},
    {"time": "09:45", "count": 342},
    {"time": "10:00", "count": 298},
    {"time": "10:15", "count": 234},
    {"time": "10:30", "count": 187},
  ];

  List<Map<String, dynamic>> interactionData = [
    {
      "type": "Chat Messages",
      "count": 453,
      "percentage": 35,
      "color": Colors.blue,
    },
    {
      "type": "Poll Responses",
      "count": 375,
      "percentage": 29,
      "color": Colors.green,
    },
    {
      "type": "Q&A Questions",
      "count": 267,
      "percentage": 21,
      "color": Colors.orange,
    },
    {
      "type": "Reactions",
      "count": 189,
      "percentage": 15,
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loading = true;
              setState(() {});
              Future.delayed(Duration(seconds: 2), () {
                loading = false;
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Session analytics exported successfully");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFilters(),
                Expanded(
                  child: _buildTabContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Session",
                  items: sessionOptions,
                  value: selectedSession,
                  onChanged: (value, label) {
                    selectedSession = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search Sessions",
            value: searchQuery,
            hint: "Search by session name or speaker",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentTab = 0;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: currentTab == 0 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: currentTab == 0 ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      "Overview",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTab == 0 ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentTab = 1;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: currentTab == 1 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: currentTab == 1 ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      "Real-time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTab == 1 ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentTab = 2;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: currentTab == 2 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: currentTab == 2 ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      "Interactions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTab == 2 ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildRealTimeTab();
      case 2:
        return _buildInteractionsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Session Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...sessionStats.map((session) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${session["session"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Speaker: ${session["speaker"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(session["status"]).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${session["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(session["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSessionStat("Duration", "${session["duration"]}"),
                      ),
                      Expanded(
                        child: _buildSessionStat("Time", "${session["startTime"]} - ${session["endTime"]}"),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSessionStat("Attendees", "${session["attendees"]}/${session["maxCapacity"]}"),
                      ),
                      Expanded(
                        child: _buildSessionStat("Rating", "${session["avgRating"]} ⭐"),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Engagement: ${session["engagement"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (session["engagement"] as int) / 100,
                    backgroundColor: disabledOutlineBorderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInteractionStat(Icons.question_answer, "Q&A", "${session["qnaQuestions"]}"),
                      ),
                      Expanded(
                        child: _buildInteractionStat(Icons.poll, "Polls", "${session["pollResponses"]}"),
                      ),
                      Expanded(
                        child: _buildInteractionStat(Icons.chat, "Chat", "${session["chatMessages"]}"),
                      ),
                      Expanded(
                        child: _buildInteractionStat(Icons.download, "Downloads", "${session["downloads"]}"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRealTimeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Real-time Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: realTimeMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTrendColor(metric["trend"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getTrendColor(metric["trend"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
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
                  "Live Attendance Tracking",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 48,
                          color: infoColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Attendance Chart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Real-time attendance visualization",
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
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Session Interactions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                ...interactionData.map((interaction) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: interaction["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${interaction["type"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${interaction["count"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: (interaction["percentage"] as int) / 100,
                                      backgroundColor: disabledOutlineBorderColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        interaction["color"] as Color,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${interaction["percentage"]}%",
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
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Analytics",
                  icon: Icons.file_download,
                  size: bs.md,
                  onPressed: () {
                    ss("Session analytics exported successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Report",
                  icon: Icons.share,
                  size: bs.md,
                  onPressed: () {
                    ss("Session report shared with team");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: infoColor,
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Upcoming":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}

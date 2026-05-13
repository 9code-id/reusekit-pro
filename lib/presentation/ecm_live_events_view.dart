import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmLiveEventsView extends StatefulWidget {
  const EcmLiveEventsView({super.key});

  @override
  State<EcmLiveEventsView> createState() => _EcmLiveEventsViewState();
}

class _EcmLiveEventsViewState extends State<EcmLiveEventsView> {
  String selectedEvent = "1";
  bool isMonitoring = true;
  
  List<Map<String, dynamic>> liveEvents = [
    {
      "id": "1",
      "name": "Annual Tech Conference 2024",
      "date": "Dec 19, 2024",
      "startTime": "09:00 AM",
      "endTime": "06:00 PM",
      "currentTime": "02:30 PM",
      "location": "Convention Center",
      "type": "Conference",
      "status": "live",
      "attendees": 428,
      "maxAttendees": 500,
      "currentSession": "AI and Machine Learning Panel",
      "nextSession": "Networking Break",
      "progress": 65,
      "image": "https://picsum.photos/400/200?random=1&keyword=conference",
      "realTimeData": {
        "currentAttendance": 428,
        "checkInsToday": 456,
        "peakAttendance": 485,
        "avgSatisfaction": 4.7,
        "livePolls": 3,
        "questions": 47,
        "socialMentions": 234
      },
      "schedule": [
        {"time": "09:00 AM", "session": "Opening Keynote", "status": "completed"},
        {"time": "10:30 AM", "session": "Tech Trends 2024", "status": "completed"},
        {"time": "12:00 PM", "session": "Lunch Break", "status": "completed"},
        {"time": "01:30 PM", "session": "AI and ML Panel", "status": "active"},
        {"time": "03:00 PM", "session": "Networking Break", "status": "upcoming"},
        {"time": "04:00 PM", "session": "Future of Work", "status": "upcoming"},
        {"time": "05:30 PM", "session": "Closing Ceremony", "status": "upcoming"},
      ],
      "teamMembers": [
        {"name": "Sarah Wilson", "role": "Event Manager", "status": "active"},
        {"name": "Mike Johnson", "role": "Technical Lead", "status": "active"},
        {"name": "Emily Davis", "role": "Registration", "status": "active"},
        {"name": "James Miller", "role": "Security", "status": "active"},
      ]
    },
    {
      "id": "2",
      "name": "Product Launch Webinar",
      "date": "Dec 19, 2024",
      "startTime": "02:00 PM",
      "endTime": "04:00 PM",
      "currentTime": "02:45 PM",
      "location": "Online Platform",
      "type": "Webinar",
      "status": "live",
      "attendees": 1247,
      "maxAttendees": 2000,
      "currentSession": "Product Demo",
      "nextSession": "Q&A Session",
      "progress": 35,
      "image": "https://picsum.photos/400/200?random=2&keyword=webinar",
      "realTimeData": {
        "currentAttendance": 1247,
        "checkInsToday": 1380,
        "peakAttendance": 1420,
        "avgSatisfaction": 4.5,
        "livePolls": 2,
        "questions": 156,
        "socialMentions": 89
      },
      "schedule": [
        {"time": "02:00 PM", "session": "Welcome & Intro", "status": "completed"},
        {"time": "02:20 PM", "session": "Product Demo", "status": "active"},
        {"time": "03:15 PM", "session": "Q&A Session", "status": "upcoming"},
        {"time": "03:45 PM", "session": "Closing Remarks", "status": "upcoming"},
      ],
      "teamMembers": [
        {"name": "Alex Chen", "role": "Host", "status": "active"},
        {"name": "Lisa Park", "role": "Tech Support", "status": "active"},
        {"name": "David Kim", "role": "Moderator", "status": "active"},
      ]
    },
  ];

  Map<String, dynamic> get currentEvent {
    return liveEvents.firstWhere((event) => event["id"] == selectedEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Events"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isMonitoring ? successColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  isMonitoring ? "LIVE" : "OFFLINE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isMonitoring ? successColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event selector
            if (liveEvents.length > 1) ...[
              QCategoryPicker(
                label: "Select Live Event",
                items: liveEvents.map((event) => {
                  "label": "${event["name"]}",
                  "value": event["id"],
                }).toList(),
                value: selectedEvent,
                onChanged: (index, label, value, item) {
                  selectedEvent = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),
            ],
            
            // Event header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Stack(
                  children: [
                    Image.network(
                      "${currentEvent["image"]}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(120),
                            Colors.transparent,
                            Colors.black.withAlpha(160),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor,
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
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentEvent["name"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.white, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${currentEvent["startTime"]} - ${currentEvent["endTime"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${currentEvent["attendees"]} / ${currentEvent["maxAttendees"]} attendees",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spLg),
            
            // Real-time stats
            Text(
              "Real-time Analytics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Current Attendance",
                  "${currentEvent["realTimeData"]["currentAttendance"]}",
                  Icons.people,
                  primaryColor,
                  "+12 in last 5 min",
                ),
                _buildStatCard(
                  "Peak Attendance",
                  "${currentEvent["realTimeData"]["peakAttendance"]}",
                  Icons.trending_up,
                  successColor,
                  "Today's highest",
                ),
                _buildStatCard(
                  "Satisfaction",
                  "${currentEvent["realTimeData"]["avgSatisfaction"]}⭐",
                  Icons.sentiment_satisfied,
                  warningColor,
                  "Live feedback",
                ),
                _buildStatCard(
                  "Social Mentions",
                  "${currentEvent["realTimeData"]["socialMentions"]}",
                  Icons.share,
                  infoColor,
                  "+5 recent",
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Current session
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: successColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_circle_filled, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Session",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${currentEvent["currentSession"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${currentEvent["progress"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  LinearProgressIndicator(
                    value: (currentEvent["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Next: ${currentEvent["nextSession"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Schedule
            Text(
              "Event Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (currentEvent["schedule"] as List).length,
              itemBuilder: (context, index) {
                final session = (currentEvent["schedule"] as List)[index];
                Color statusColor = disabledColor;
                IconData statusIcon = Icons.radio_button_unchecked;
                
                if (session["status"] == "completed") {
                  statusColor = successColor;
                  statusIcon = Icons.check_circle;
                } else if (session["status"] == "active") {
                  statusColor = primaryColor;
                  statusIcon = Icons.play_circle_filled;
                } else {
                  statusColor = disabledBoldColor;
                  statusIcon = Icons.schedule;
                }
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: session["status"] == "active" ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          statusIcon,
                          color: statusColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${session["session"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${session["time"]}",
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
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${session["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: spLg),
            
            // Team status
            Text(
              "Team Status",
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
              children: (currentEvent["teamMembers"] as List).map((member) {
                return Container(
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
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: member["status"] == "active" ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${member["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${member["role"]}",
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
                );
              }).toList(),
            ),
            SizedBox(height: spXl),
            
            // Control buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Alert",
                    size: bs.md,
                    onPressed: () {
                      si("Alert sent to team");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Event Control",
                    size: bs.md,
                    onPressed: () {
                      si("Opening event controls");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color, String subtitle) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

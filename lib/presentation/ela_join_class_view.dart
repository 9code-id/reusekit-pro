import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaJoinClassView extends StatefulWidget {
  const ElaJoinClassView({super.key});

  @override
  State<ElaJoinClassView> createState() => _ElaJoinClassViewState();
}

class _ElaJoinClassViewState extends State<ElaJoinClassView> {
  String classCode = "";
  String selectedClass = "";
  bool micEnabled = true;
  bool cameraEnabled = false;

  List<Map<String, dynamic>> quickJoinClasses = [
    {
      "id": 1,
      "title": "Advanced Calculus - Integration Techniques",
      "instructor": "Dr. Sarah Chen",
      "startTime": "09:00",
      "endTime": "10:30",
      "status": "Live Now",
      "participants": 45,
      "subject": "Mathematics",
      "classCode": "MATH101",
      "thumbnailUrl": "https://picsum.photos/300/200?random=1&keyword=math",
      "instructorAvatar": "https://picsum.photos/100/100?random=1",
      "isLive": true,
    },
    {
      "id": 2,
      "title": "Quantum Physics - Wave Particle Duality",
      "instructor": "Prof. Michael Johnson",
      "startTime": "11:00",
      "endTime": "12:30",
      "status": "Starting Soon",
      "participants": 32,
      "subject": "Physics",
      "classCode": "PHYS201",
      "thumbnailUrl": "https://picsum.photos/300/200?random=2&keyword=physics",
      "instructorAvatar": "https://picsum.photos/100/100?random=2",
      "isLive": false,
    },
    {
      "id": 3,
      "title": "Organic Chemistry - Reaction Mechanisms",
      "instructor": "Dr. Emily Rodriguez",
      "startTime": "14:00",
      "endTime": "15:30",
      "status": "Scheduled",
      "participants": 28,
      "subject": "Chemistry",
      "classCode": "CHEM301",
      "thumbnailUrl": "https://picsum.photos/300/200?random=3&keyword=chemistry",
      "instructorAvatar": "https://picsum.photos/100/100?random=3",
      "isLive": false,
    },
  ];

  List<Map<String, dynamic>> recentClasses = [
    {
      "title": "Linear Algebra",
      "instructor": "Dr. John Davis",
      "classCode": "MATH201",
      "lastJoined": "2 hours ago",
      "subject": "Mathematics",
    },
    {
      "title": "Thermodynamics",
      "instructor": "Prof. Lisa Thompson",
      "classCode": "PHYS301",
      "lastJoined": "Yesterday",
      "subject": "Physics",
    },
    {
      "title": "Cell Biology",
      "instructor": "Dr. David Kim",
      "classCode": "BIO101",
      "lastJoined": "3 days ago",
      "subject": "Biology",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live Now":
        return dangerColor;
      case "Starting Soon":
        return warningColor;
      case "Scheduled":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildQuickJoinCard(Map<String, dynamic> classData) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${classData["thumbnailUrl"]}"),
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
                    color: _getStatusColor("${classData["status"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ("${classData["status"]}" == "Live Now")
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(right: 4),
                        ),
                      Text(
                        "${classData["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                    "${classData["classCode"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${classData["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${classData["instructorAvatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${classData["instructor"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
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
                      "${classData["startTime"]} - ${classData["endTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${classData["participants"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: (classData["isLive"] as bool) ? "Join Now" : "Join When Live",
                    onPressed: () {
                      if (classData["isLive"] as bool) {
                        _showPreJoinDialog(classData);
                      } else {
                        ss("You'll be notified when the class starts");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentClassCard(Map<String, dynamic> classData) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.history,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${classData["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${classData["instructor"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Code: ${classData["classCode"]} • ${classData["lastJoined"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Join Again",
            size: bs.sm,
            onPressed: () {
              _joinClassWithCode("${classData["classCode"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJoinByCodeForm() {
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
            children: [
              Icon(
                Icons.login,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Join with Class Code",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Class Code",
            value: classCode,
            hint: "Enter class code (e.g., MATH101)",
            onChanged: (value) {
              classCode = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Join Class",
              onPressed: () {
                if (classCode.isNotEmpty) {
                  _joinClassWithCode(classCode);
                } else {
                  se("Please enter a valid class code");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _joinClassWithCode(String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Join Class"),
        content: Text("Joining class with code: $code"),
        actions: [
          TextButton(
            onPressed: () {
              back();
              ss("Successfully joined the class!");
            },
            child: Text("Join"),
          ),
        ],
      ),
    );
  }

  void _showPreJoinDialog(Map<String, dynamic> classData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Join Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${classData["title"]}"),
            SizedBox(height: spMd),
            Text(
              "Check your audio and video settings before joining:",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  micEnabled ? Icons.mic : Icons.mic_off,
                  color: micEnabled ? successColor : dangerColor,
                ),
                SizedBox(width: spXs),
                Text("Microphone"),
                Spacer(),
                Switch(
                  value: micEnabled,
                  onChanged: (value) {
                    setState(() {
                      micEnabled = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  cameraEnabled ? Icons.videocam : Icons.videocam_off,
                  color: cameraEnabled ? successColor : dangerColor,
                ),
                SizedBox(width: spXs),
                Text("Camera"),
                Spacer(),
                Switch(
                  value: cameraEnabled,
                  onChanged: (value) {
                    setState(() {
                      cameraEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Joining live class...");
            },
            child: Text("Join Now"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Class"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJoinByCodeForm(),
            SizedBox(height: spMd),
            Text(
              "Quick Join",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
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
                      "Join your enrolled classes instantly",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
            ...quickJoinClasses.map((classData) => _buildQuickJoinCard(classData)),
            SizedBox(height: spMd),
            Text(
              "Recent Classes",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...recentClasses.map((classData) => _buildRecentClassCard(classData)),
          ],
        ),
      ),
    );
  }
}

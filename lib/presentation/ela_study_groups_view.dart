import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaStudyGroupsView extends StatefulWidget {
  const ElaStudyGroupsView({super.key});

  @override
  State<ElaStudyGroupsView> createState() => _ElaStudyGroupsViewState();
}

class _ElaStudyGroupsViewState extends State<ElaStudyGroupsView> {
  String searchQuery = "";
  String selectedSubject = "all";
  String selectedLevel = "all";

  List<Map<String, dynamic>> subjectItems = [
    {"label": "All Subjects", "value": "all"},
    {"label": "Mathematics", "value": "math"},
    {"label": "Physics", "value": "physics"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Biology", "value": "biology"},
    {"label": "Computer Science", "value": "cs"},
  ];

  List<Map<String, dynamic>> levelItems = [
    {"label": "All Levels", "value": "all"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
  ];

  List<Map<String, dynamic>> studyGroups = [
    {
      "id": 1,
      "name": "Advanced Calculus Study Group",
      "subject": "Mathematics",
      "level": "Advanced",
      "description": "Weekly study sessions for calculus concepts and problem-solving",
      "members": 15,
      "maxMembers": 20,
      "meetingTime": "Mon 7:00 PM",
      "image": "https://picsum.photos/150/100?random=1&keyword=math",
      "moderator": "Dr. Sarah Johnson",
      "isJoined": true,
      "tags": ["Calculus", "Derivatives", "Integrals"],
    },
    {
      "id": 2,
      "name": "Physics Problem Solvers",
      "subject": "Physics",
      "level": "Intermediate",
      "description": "Collaborative problem-solving sessions for physics concepts",
      "members": 23,
      "maxMembers": 25,
      "meetingTime": "Wed 6:30 PM",
      "image": "https://picsum.photos/150/100?random=2&keyword=physics",
      "moderator": "Prof. Michael Chen",
      "isJoined": false,
      "tags": ["Mechanics", "Thermodynamics", "Waves"],
    },
    {
      "id": 3,
      "name": "Organic Chemistry Lab",
      "subject": "Chemistry",
      "level": "Advanced",
      "description": "Virtual lab discussions and concept clarification",
      "members": 12,
      "maxMembers": 15,
      "meetingTime": "Fri 5:00 PM",
      "image": "https://picsum.photos/150/100?random=3&keyword=chemistry",
      "moderator": "Dr. Emily Davis",
      "isJoined": true,
      "tags": ["Organic", "Reactions", "Synthesis"],
    },
    {
      "id": 4,
      "name": "Algorithms & Data Structures",
      "subject": "Computer Science",
      "level": "Intermediate",
      "description": "Weekly coding practice and algorithm discussions",
      "members": 28,
      "maxMembers": 30,
      "meetingTime": "Tue 8:00 PM",
      "image": "https://picsum.photos/150/100?random=4&keyword=programming",
      "moderator": "Alex Rodriguez",
      "isJoined": false,
      "tags": ["Algorithms", "Data Structures", "Coding"],
    },
    {
      "id": 5,
      "name": "Biology Concepts Review",
      "subject": "Biology",
      "level": "Beginner",
      "description": "Basic biology concepts and exam preparation",
      "members": 18,
      "maxMembers": 25,
      "meetingTime": "Thu 7:30 PM",
      "image": "https://picsum.photos/150/100?random=5&keyword=biology",
      "moderator": "Dr. Lisa Thompson",
      "isJoined": true,
      "tags": ["Cell Biology", "Genetics", "Evolution"],
    },
    {
      "id": 6,
      "name": "Linear Algebra Study Circle",
      "subject": "Mathematics",
      "level": "Intermediate",
      "description": "Matrix operations, vector spaces, and linear transformations",
      "members": 14,
      "maxMembers": 20,
      "meetingTime": "Sat 2:00 PM",
      "image": "https://picsum.photos/150/100?random=6&keyword=algebra",
      "moderator": "Prof. James Wilson",
      "isJoined": false,
      "tags": ["Matrices", "Vectors", "Eigenvalues"],
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return studyGroups.where((group) {
      bool matchesSearch = group["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          group["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSubject = selectedSubject == "all" || group["subject"].toString().toLowerCase().contains(selectedSubject);
      bool matchesLevel = selectedLevel == "all" || group["level"].toString().toLowerCase() == selectedLevel;
      return matchesSearch && matchesSubject && matchesLevel;
    }).toList();
  }

  void _joinGroup(Map<String, dynamic> group) async {
    bool isConfirmed = await confirm("Join ${group["name"]} study group?");
    if (isConfirmed) {
      setState(() {
        group["isJoined"] = true;
        group["members"] = (group["members"] as int) + 1;
      });
      ss("Successfully joined ${group["name"]}!");
    }
  }

  void _leaveGroup(Map<String, dynamic> group) async {
    bool isConfirmed = await confirm("Leave ${group["name"]} study group?");
    if (isConfirmed) {
      setState(() {
        group["isJoined"] = false;
        group["members"] = (group["members"] as int) - 1;
      });
      si("Left ${group["name"]} study group");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CreateStudyGroupView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search study groups",
              value: searchQuery,
              hint: "Enter group name or topic",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Subject",
                    items: subjectItems,
                    value: selectedSubject,
                    onChanged: (value, label) {
                      selectedSubject = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Level",
                    items: levelItems,
                    value: selectedLevel,
                    onChanged: (value, label) {
                      selectedLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Study Groups List
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Available Study Groups",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredGroups.length} groups",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  // Groups Grid
                  ...filteredGroups.map((group) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${group["image"]}",
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
                                      "${group["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${group["subject"]} • ${group["level"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: group["isJoined"] as bool ? successColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  group["isJoined"] as bool ? "Joined" : "Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "${group["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),

                          // Tags
                          Wrap(
                            spacing: spXs,
                            children: (group["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Group Info
                          Row(
                            children: [
                              Icon(Icons.group, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${group["members"]}/${group["maxMembers"]} members",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${group["meetingTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Moderator: ${group["moderator"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // navigateTo('StudyGroupDetailView')
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: group["isJoined"] as bool ? "Leave" : "Join",
                                  size: bs.sm,
                                  onPressed: () {
                                    if (group["isJoined"] as bool) {
                                      _leaveGroup(group);
                                    } else {
                                      _joinGroup(group);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

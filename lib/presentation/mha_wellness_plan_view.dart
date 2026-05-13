import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaWellnessPlanView extends StatefulWidget {
  const MhaWellnessPlanView({super.key});

  @override
  State<MhaWellnessPlanView> createState() => _MhaWellnessPlanViewState();
}

class _MhaWellnessPlanViewState extends State<MhaWellnessPlanView> {
  int selectedPlanIndex = 0;

  List<Map<String, dynamic>> wellnessPlans = [
    {
      "name": "Weight Management",
      "description": "Personalized plan to reach your target weight",
      "duration": "12 weeks",
      "difficulty": "Moderate",
      "progress": 65,
      "icon": Icons.monitor_weight,
      "color": 0xFF4CAF50,
      "goals": ["Lose 10 kg", "Build healthy habits", "Improve metabolism"],
      "activities": [
        {"name": "Daily walk", "completed": true, "target": "30 min"},
        {"name": "Healthy meal prep", "completed": false, "target": "3 meals"},
        {"name": "Water intake", "completed": true, "target": "8 glasses"},
        {"name": "Sleep tracking", "completed": true, "target": "8 hours"}
      ]
    },
    {
      "name": "Heart Health",
      "description": "Strengthen your cardiovascular system",
      "duration": "8 weeks",
      "difficulty": "Beginner",
      "progress": 40,
      "icon": Icons.favorite,
      "color": 0xFFF44336,
      "goals": ["Lower blood pressure", "Improve circulation", "Reduce cholesterol"],
      "activities": [
        {"name": "Cardio exercise", "completed": true, "target": "20 min"},
        {"name": "Meditation", "completed": false, "target": "10 min"},
        {"name": "Heart-healthy meals", "completed": true, "target": "2 meals"},
        {"name": "BP monitoring", "completed": false, "target": "2x daily"}
      ]
    },
    {
      "name": "Stress Management",
      "description": "Learn to manage and reduce daily stress",
      "duration": "6 weeks",
      "difficulty": "Easy",
      "progress": 80,
      "icon": Icons.psychology,
      "color": 0xFF9C27B0,
      "goals": ["Reduce anxiety", "Improve sleep", "Better work-life balance"],
      "activities": [
        {"name": "Breathing exercises", "completed": true, "target": "5 min"},
        {"name": "Journaling", "completed": true, "target": "15 min"},
        {"name": "Relaxation time", "completed": false, "target": "30 min"},
        {"name": "Digital detox", "completed": true, "target": "1 hour"}
      ]
    }
  ];

  List<Map<String, dynamic>> todaySchedule = [
    {
      "time": "07:00 AM",
      "activity": "Morning walk",
      "duration": "30 min",
      "completed": true,
      "type": "Exercise"
    },
    {
      "time": "08:30 AM", 
      "activity": "Healthy breakfast",
      "duration": "15 min",
      "completed": true,
      "type": "Nutrition"
    },
    {
      "time": "12:00 PM",
      "activity": "Meditation session",
      "duration": "10 min",
      "completed": false,
      "type": "Mental Health"
    },
    {
      "time": "06:00 PM",
      "activity": "Cardio workout",
      "duration": "45 min",
      "completed": false,
      "type": "Exercise"
    },
    {
      "time": "09:00 PM",
      "activity": "Sleep preparation",
      "duration": "30 min",
      "completed": false,
      "type": "Sleep"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final currentPlan = wellnessPlans[selectedPlanIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Wellness Plan"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Selection Cards
            Text(
              "Active Wellness Plans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: wellnessPlans.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> plan = entry.value;
                bool isSelected = index == selectedPlanIndex;
                
                return GestureDetector(
                  onTap: () {
                    selectedPlanIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSelected ? [
                          Color(plan["color"] as int),
                          Color(plan["color"] as int).withAlpha(180),
                        ] : [
                          Colors.grey[100]!,
                          Colors.grey[50]!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? Color(plan["color"] as int) : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              plan["icon"] as IconData,
                              color: isSelected ? Colors.white : Color(plan["color"] as int),
                              size: 28,
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white.withAlpha(40) : Color(plan["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${plan["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Color(plan["color"] as int),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${plan["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${plan["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white70 : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: isSelected ? Colors.white70 : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${plan["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white70 : disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: isSelected ? Colors.white70 : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${plan["difficulty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white70 : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Current Plan Details
            Container(
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
                      Text(
                        "${currentPlan["name"]} Goals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 60,
                        height: 60,
                        child: Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: (currentPlan["progress"] as int) / 100.0,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(currentPlan["color"] as int),
                                ),
                                strokeWidth: 6,
                              ),
                            ),
                            Center(
                              child: Text(
                                "${currentPlan["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(currentPlan["color"] as int),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...((currentPlan["goals"] as List).map((goal) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(currentPlan["color"] as int),
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "$goal",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Today's Activities
            Text(
              "Today's Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...todaySchedule.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: activity["completed"] ? successColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: activity["completed"] ? successColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        activity["completed"] ? Icons.check : Icons.schedule,
                        color: activity["completed"] ? Colors.white : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["activity"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: activity["completed"] ? successColor : Colors.black87,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${activity["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${activity["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${activity["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (!activity["completed"])
                      QButton(
                        label: "Start",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Weekly Progress
            Container(
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
                    "Weekly Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProgressStat("Completed", "85%", successColor),
                      _buildProgressStat("In Progress", "12%", warningColor),
                      _buildProgressStat("Missed", "3%", dangerColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}

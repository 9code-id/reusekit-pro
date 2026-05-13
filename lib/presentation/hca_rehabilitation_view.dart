import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaRehabilitationView extends StatefulWidget {
  const HcaRehabilitationView({super.key});

  @override
  State<HcaRehabilitationView> createState() => _HcaRehabilitationViewState();
}

class _HcaRehabilitationViewState extends State<HcaRehabilitationView> {
  String selectedProgram = "All Programs";
  String selectedPhase = "Current";
  
  final List<Map<String, dynamic>> rehabilitationPrograms = [
    {
      "id": "RH001",
      "name": "Post-Surgical Knee Recovery",
      "type": "Orthopedic",
      "startDate": "2024-01-01",
      "duration": "12 weeks",
      "progress": 75,
      "phase": "Phase 3",
      "totalPhases": 4,
      "therapist": "Dr. Sarah Mitchell",
      "status": "Active",
      "goals": [
        "Restore full range of motion",
        "Regain strength and stability",
        "Return to daily activities"
      ],
      "milestones": [
        {"name": "Phase 1: Pain Management", "completed": true, "date": "2024-01-15"},
        {"name": "Phase 2: Mobility Restoration", "completed": true, "date": "2024-02-01"},
        {"name": "Phase 3: Strength Building", "completed": false, "date": "2024-02-15"},
        {"name": "Phase 4: Functional Training", "completed": false, "date": "2024-03-01"}
      ]
    },
    {
      "id": "RH002",
      "name": "Stroke Recovery Program",
      "type": "Neurological",
      "startDate": "2023-12-15",
      "duration": "16 weeks",
      "progress": 60,
      "phase": "Phase 2",
      "totalPhases": 3,
      "therapist": "Dr. Michael Chen",
      "status": "Active",
      "goals": [
        "Improve motor function",
        "Enhance speech clarity",
        "Increase independence"
      ],
      "milestones": [
        {"name": "Phase 1: Acute Recovery", "completed": true, "date": "2024-01-01"},
        {"name": "Phase 2: Intensive Therapy", "completed": false, "date": "2024-02-15"},
        {"name": "Phase 3: Community Reintegration", "completed": false, "date": "2024-03-15"}
      ]
    },
    {
      "id": "RH003",
      "name": "Cardiac Rehabilitation",
      "type": "Cardiovascular",
      "startDate": "2024-01-10",
      "duration": "8 weeks",
      "progress": 45,
      "phase": "Phase 1",
      "totalPhases": 3,
      "therapist": "Dr. Lisa Johnson",
      "status": "Active",
      "goals": [
        "Improve cardiovascular health",
        "Build exercise tolerance",
        "Reduce risk factors"
      ],
      "milestones": [
        {"name": "Phase 1: Assessment & Baseline", "completed": false, "date": "2024-01-24"},
        {"name": "Phase 2: Progressive Exercise", "completed": false, "date": "2024-02-14"},
        {"name": "Phase 3: Maintenance Program", "completed": false, "date": "2024-03-07"}
      ]
    }
  ];

  final List<Map<String, dynamic>> dailyActivities = [
    {
      "time": "08:00",
      "activity": "Morning Stretching",
      "duration": "15 minutes",
      "type": "Exercise",
      "completed": true,
      "difficulty": "Easy",
      "therapist": "Dr. Sarah Mitchell"
    },
    {
      "time": "10:30",
      "activity": "Physical Therapy Session",
      "duration": "45 minutes",
      "type": "Therapy",
      "completed": false,
      "difficulty": "Moderate",
      "therapist": "Dr. Sarah Mitchell"
    },
    {
      "time": "14:00",
      "activity": "Occupational Therapy",
      "duration": "30 minutes",
      "type": "Therapy",
      "completed": false,
      "difficulty": "Easy",
      "therapist": "Dr. Michael Chen"
    },
    {
      "time": "16:30",
      "activity": "Balance Training",
      "duration": "20 minutes",
      "type": "Exercise",
      "completed": false,
      "difficulty": "Moderate",
      "therapist": "Dr. Sarah Mitchell"
    },
    {
      "time": "19:00",
      "activity": "Evening Relaxation",
      "duration": "10 minutes",
      "type": "Wellness",
      "completed": false,
      "difficulty": "Easy",
      "therapist": "Self-guided"
    }
  ];

  final List<Map<String, dynamic>> assessmentMetrics = [
    {
      "metric": "Range of Motion",
      "current": 85,
      "baseline": 45,
      "target": 95,
      "unit": "degrees",
      "trend": "improving",
      "lastUpdated": "2024-01-19"
    },
    {
      "metric": "Strength Score",
      "current": 7,
      "baseline": 3,
      "target": 9,
      "unit": "/10",
      "trend": "improving",
      "lastUpdated": "2024-01-18"
    },
    {
      "metric": "Pain Level",
      "current": 3,
      "baseline": 8,
      "target": 1,
      "unit": "/10",
      "trend": "improving",
      "lastUpdated": "2024-01-20"
    },
    {
      "metric": "Functional Mobility",
      "current": 75,
      "baseline": 30,
      "target": 90,
      "unit": "%",
      "trend": "improving",
      "lastUpdated": "2024-01-19"
    }
  ];

  final List<Map<String, dynamic>> therapyTeam = [
    {
      "name": "Dr. Sarah Mitchell",
      "role": "Physical Therapist",
      "specialty": "Orthopedic Rehabilitation",
      "experience": "12 years",
      "contact": "(555) 123-4567",
      "availability": "Mon-Fri 8AM-6PM"
    },
    {
      "name": "Dr. Michael Chen",
      "role": "Occupational Therapist",
      "specialty": "Neurological Recovery",
      "experience": "8 years",
      "contact": "(555) 234-5678",
      "availability": "Mon-Sat 9AM-5PM"
    },
    {
      "name": "Dr. Lisa Johnson",
      "role": "Speech Therapist",
      "specialty": "Communication Disorders",
      "experience": "15 years",
      "contact": "(555) 345-6789",
      "availability": "Tue-Fri 10AM-4PM"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rehabilitation Programs"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () => _showAssessmentDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgramOverviewCard(),
            _buildTodayScheduleCard(),
            _buildProgressMetricsCard(),
            _buildCurrentProgramCard(),
            _buildTherapyTeamCard(),
            _buildEducationalResourcesCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddActivityDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildProgramOverviewCard() {
    final activePrograms = rehabilitationPrograms.where((p) => p["status"] == "Active").length;
    final totalProgress = rehabilitationPrograms
        .where((p) => p["status"] == "Active")
        .map((p) => p["progress"] as int)
        .fold(0, (sum, progress) => sum + progress) / activePrograms;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.healing, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Rehabilitation Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard("Active Programs", "$activePrograms", successColor, Icons.trending_up),
              _buildOverviewCard("Overall Progress", "${totalProgress.toInt()}%", primaryColor, Icons.show_chart),
              _buildOverviewCard("This Week", "5 sessions", infoColor, Icons.event),
              _buildOverviewCard("Completed Goals", "8/12", warningColor, Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayScheduleCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${DateTime.now().toString().substring(0, 10)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...dailyActivities.map((activity) {
            final completed = activity["completed"] as bool;
            final type = activity["type"];
            Color typeColor = primaryColor;
            
            if (type == "Exercise") typeColor = successColor;
            if (type == "Wellness") typeColor = infoColor;
            if (type == "Therapy") typeColor = warningColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: completed 
                  ? successColor.withAlpha(10)
                  : typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: completed 
                    ? successColor.withAlpha(30)
                    : typeColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: completed ? successColor : typeColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      completed 
                        ? Icons.check 
                        : type == "Exercise"
                          ? Icons.fitness_center
                          : type == "Therapy"
                            ? Icons.healing
                            : Icons.self_improvement,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${activity["activity"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: completed ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${activity["time"]} • ${activity["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${activity["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: typeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "With ${activity["therapist"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!completed)
                    QButton(
                      icon: Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () => _markActivityCompleted(activity),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProgressMetricsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Update",
                size: bs.sm,
                onPressed: () => _showAssessmentDialog(),
              ),
            ],
          ),
          ...assessmentMetrics.map((metric) {
            final current = metric["current"];
            final target = metric["target"];
            final baseline = metric["baseline"];
            final progress = ((current - baseline) / (target - baseline) * 100).clamp(0, 100).toInt();
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "$current${metric["unit"]} / $target${metric["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Baseline: $baseline${metric["unit"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Last updated: ${metric["lastUpdated"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCurrentProgramCard() {
    final currentProgram = rehabilitationPrograms.first;
    final milestones = currentProgram["milestones"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Program",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${currentProgram["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.healing, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${currentProgram["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${currentProgram["type"]} Rehabilitation",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Progress: ${currentProgram["progress"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${currentProgram["phase"]} of ${currentProgram["totalPhases"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (currentProgram["progress"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Program Milestones",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          ...milestones.map((milestone) {
            final completed = milestone["completed"] as bool;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: completed 
                  ? successColor.withAlpha(10)
                  : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: completed 
                    ? successColor.withAlpha(30)
                    : warningColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: completed ? successColor : warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${milestone["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: completed ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        Text(
                          "Target: ${milestone["date"]}",
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTherapyTeamCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Therapy Team",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Contact All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...therapyTeam.map((member) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${member["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${member["role"]} • ${member["experience"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${member["specialty"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () => _showMessageDialog(member["name"]),
                      ),
                      SizedBox(height: spXs),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEducationalResourcesCard() {
    final resources = [
      {
        "title": "Understanding Your Recovery Timeline",
        "type": "Article",
        "duration": "8 min read",
        "category": "Education"
      },
      {
        "title": "Exercises for Better Recovery",
        "type": "Video",
        "duration": "15 minutes",
        "category": "Exercise"
      },
      {
        "title": "Managing Pain During Rehabilitation",
        "type": "Guide",
        "duration": "6 min read",
        "category": "Pain Management"
      },
      {
        "title": "Nutrition for Healing",
        "type": "Article",
        "duration": "10 min read",
        "category": "Nutrition"
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Educational Resources",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          ...resources.map((resource) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    resource["type"] == "Video" 
                      ? Icons.play_circle 
                      : resource["type"] == "Article"
                        ? Icons.article
                        : Icons.book,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${resource["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${resource["type"]} • ${resource["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${resource["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
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
          }),
        ],
      ),
    );
  }

  void _markActivityCompleted(Map<String, dynamic> activity) {
    setState(() {
      activity["completed"] = true;
    });
    ss("Activity '${activity["activity"]}' marked as completed");
  }

  void _showAssessmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Assessment Update"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text("Rate your current pain level (1-10):"),
            QTextField(
              label: "Pain Level",
              value: "3",
              onChanged: (value) {},
            ),
            QTextField(
              label: "Range of Motion (degrees)",
              value: "85",
              onChanged: (value) {},
            ),
            QMemoField(
              label: "Notes",
              value: "",
              hint: "Any additional observations...",
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Assessment updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showAddActivityDialog() {
    String activityName = "";
    String activityType = "Exercise";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Activity"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Activity Name",
              value: activityName,
              hint: "Enter activity name",
              onChanged: (value) {
                activityName = value;
              },
            ),
            QDropdownField(
              label: "Activity Type",
              items: [
                {"label": "Exercise", "value": "Exercise"},
                {"label": "Therapy", "value": "Therapy"},
                {"label": "Wellness", "value": "Wellness"},
              ],
              value: activityType,
              onChanged: (value, label) {
                activityType = value;
              },
            ),
            QTimePicker(
              label: "Time",
              value: TimeOfDay.now(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Activity added to schedule");
            },
          ),
        ],
      ),
    );
  }

  void _showMessageDialog(String memberName) {
    String message = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message $memberName"),
        content: QMemoField(
          label: "Message",
          value: message,
          hint: "Type your message here...",
          onChanged: (value) {
            message = value;
          },
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Send",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Message sent to $memberName");
            },
          ),
        ],
      ),
    );
  }
}

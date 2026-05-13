import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPhysicalTherapyView extends StatefulWidget {
  const HcaPhysicalTherapyView({super.key});

  @override
  State<HcaPhysicalTherapyView> createState() => _HcaPhysicalTherapyViewState();
}

class _HcaPhysicalTherapyViewState extends State<HcaPhysicalTherapyView> {
  String selectedCondition = "All Conditions";
  String selectedTherapist = "";
  
  final List<Map<String, dynamic>> therapySessions = [
    {
      "id": "PT001",
      "therapist": "Dr. Sarah Mitchell",
      "date": "2024-01-20",
      "time": "10:00 AM",
      "condition": "Lower Back Pain",
      "exercises": 8,
      "duration": "45 minutes",
      "status": "Scheduled",
      "location": "City Physical Therapy Center",
      "type": "In-Person",
      "notes": "Focus on core strengthening and flexibility",
      "progress": 65,
      "painLevel": 4
    },
    {
      "id": "PT002",
      "therapist": "Dr. Michael Chen",
      "date": "2024-01-18",
      "time": "2:30 PM",
      "condition": "Shoulder Injury",
      "exercises": 6,
      "duration": "40 minutes",
      "status": "Completed",
      "location": "Home",
      "type": "Telehealth",
      "notes": "Range of motion exercises, ice therapy",
      "progress": 78,
      "painLevel": 2
    },
    {
      "id": "PT003",
      "therapist": "Dr. Lisa Johnson",
      "date": "2024-01-16",
      "time": "11:15 AM",
      "condition": "Knee Rehabilitation",
      "exercises": 10,
      "duration": "50 minutes",
      "status": "Completed",
      "location": "Wellness Rehabilitation Clinic",
      "type": "In-Person",
      "notes": "Post-surgery rehabilitation, strength building",
      "progress": 85,
      "painLevel": 1
    }
  ];

  final List<Map<String, dynamic>> exercisePrograms = [
    {
      "name": "Lower Back Strengthening",
      "therapist": "Dr. Sarah Mitchell",
      "exercises": 12,
      "duration": "30 minutes",
      "frequency": "3x per week",
      "level": "Intermediate",
      "progress": 68,
      "lastCompleted": "2024-01-19",
      "description": "Comprehensive program for lower back pain relief and prevention"
    },
    {
      "name": "Shoulder Mobility",
      "therapist": "Dr. Michael Chen",
      "exercises": 8,
      "duration": "20 minutes",
      "frequency": "Daily",
      "level": "Beginner",
      "progress": 82,
      "lastCompleted": "2024-01-20",
      "description": "Gentle exercises to improve shoulder range of motion"
    },
    {
      "name": "Knee Strengthening",
      "therapist": "Dr. Lisa Johnson",
      "exercises": 15,
      "duration": "40 minutes",
      "frequency": "4x per week",
      "level": "Advanced",
      "progress": 91,
      "lastCompleted": "2024-01-19",
      "description": "Post-operative knee rehabilitation program"
    }
  ];

  final List<Map<String, dynamic>> therapists = [
    {
      "name": "Dr. Sarah Mitchell",
      "specialty": "Orthopedic Physical Therapy",
      "experience": "12 years",
      "rating": 4.9,
      "patients": 156,
      "location": "City Physical Therapy Center",
      "availability": "Mon-Fri 8AM-6PM",
      "phone": "(555) 123-4567",
      "email": "sarah.mitchell@ptcenter.com"
    },
    {
      "name": "Dr. Michael Chen",
      "specialty": "Sports Medicine PT",
      "experience": "8 years",
      "rating": 4.8,
      "patients": 203,
      "location": "Sports Rehabilitation Clinic",
      "availability": "Mon-Sat 7AM-8PM",
      "phone": "(555) 234-5678",
      "email": "michael.chen@sportspt.com"
    },
    {
      "name": "Dr. Lisa Johnson",
      "specialty": "Post-Surgical Rehabilitation",
      "experience": "15 years",
      "rating": 4.9,
      "patients": 178,
      "location": "Wellness Rehabilitation Clinic",
      "availability": "Tue-Sat 9AM-5PM",
      "phone": "(555) 345-6789",
      "email": "lisa.johnson@wellness.com"
    }
  ];

  final List<Map<String, dynamic>> progressMetrics = [
    {
      "metric": "Pain Level",
      "current": 3,
      "previous": 6,
      "target": 1,
      "unit": "/10",
      "trend": "improving",
      "icon": Icons.healing
    },
    {
      "metric": "Mobility Score",
      "current": 78,
      "previous": 65,
      "target": 90,
      "unit": "%",
      "trend": "improving",
      "icon": Icons.accessibility
    },
    {
      "metric": "Strength Rating",
      "current": 7,
      "previous": 5,
      "target": 9,
      "unit": "/10",
      "trend": "improving",
      "icon": Icons.fitness_center
    },
    {
      "metric": "Exercise Compliance",
      "current": 85,
      "previous": 72,
      "target": 95,
      "unit": "%",
      "trend": "improving",
      "icon": Icons.check_circle
    }
  ];

  final List<Map<String, dynamic>> weeklyProgress = [
    {"week": "Week 1", "pain": 8, "mobility": 45, "strength": 3},
    {"week": "Week 2", "pain": 7, "mobility": 52, "strength": 4},
    {"week": "Week 3", "pain": 6, "mobility": 61, "strength": 5},
    {"week": "Week 4", "pain": 4, "mobility": 68, "strength": 6},
    {"week": "Week 5", "pain": 3, "mobility": 78, "strength": 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physical Therapy"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showBookSessionDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgressOverviewCard(),
            _buildQuickActionsCard(),
            _buildUpcomingSessionsCard(),
            _buildExerciseProgramsCard(),
            _buildProgressChartCard(),
            _buildTherapistTeamCard(),
            _buildEducationalResourcesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressOverviewCard() {
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
          Text(
            "Recovery Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: progressMetrics.map((metric) {
              final current = metric["current"];
              final target = metric["target"];
              final progress = (current / target * 100).clamp(0, 100).toInt();
              final trend = metric["trend"];
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: trend == "improving" 
                    ? successColor.withAlpha(10)
                    : warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: trend == "improving" 
                      ? successColor.withAlpha(30)
                      : warningColor.withAlpha(30),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          metric["icon"] as IconData,
                          color: trend == "improving" ? successColor : warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${metric["metric"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "$current${metric["unit"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: trend == "improving" ? successColor : warningColor,
                          ),
                        ),
                        Text(
                          " / $target${metric["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: trend == "improving" ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
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

  Widget _buildQuickActionsCard() {
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard(
                "Book Session",
                "Schedule appointment",
                Icons.event_available,
                primaryColor,
                () => _showBookSessionDialog(),
              ),
              _buildActionCard(
                "Start Exercise",
                "Begin daily routine",
                Icons.play_arrow,
                successColor,
                () => _showExerciseDialog(),
              ),
              _buildActionCard(
                "Log Pain Level",
                "Track current pain",
                Icons.healing,
                warningColor,
                () => _showPainLevelDialog(),
              ),
              _buildActionCard(
                "Message Therapist",
                "Contact your PT",
                Icons.message,
                infoColor,
                () => _showMessageDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(icon, color: color, size: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSessionsCard() {
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
                "Therapy Sessions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...therapySessions.map((session) {
            final status = session["status"];
            final isCompleted = status == "Completed";
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: isCompleted 
                  ? successColor.withAlpha(10)
                  : infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isCompleted 
                    ? successColor.withAlpha(30)
                    : infoColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isCompleted ? successColor : infoColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.schedule,
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
                          "${session["therapist"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${session["condition"]} - ${session["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${session["date"]} at ${session["time"]}",
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
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$status",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "${session["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
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

  Widget _buildExerciseProgramsCard() {
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
                "Exercise Programs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _showAddProgramDialog(),
              ),
            ],
          ),
          ...exercisePrograms.map((program) {
            final progress = program["progress"] as int;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.fitness_center,
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
                              "${program["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "By ${program["therapist"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: spXs,
                        children: [
                          Text(
                            "$progress%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${program["level"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 6,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${program["duration"]} • ${program["frequency"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last: ${program["lastCompleted"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
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

  Widget _buildProgressChartCard() {
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
          Text(
            "Weekly Progress Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem("Pain Level", dangerColor),
                    _buildLegendItem("Mobility", successColor),
                    _buildLegendItem("Strength", primaryColor),
                  ],
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyProgress.map((data) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: ((data["pain"] as int) * 8).toDouble(),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: Container(
                                    height: ((data["mobility"] as int) * 1.2).toDouble(),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: Container(
                                    height: ((data["strength"] as int) * 12).toDouble(),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${data["week"]}".replaceAll("Week ", "W"),
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
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

  Widget _buildTherapistTeamCard() {
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
                label: "Find PT",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...therapists.take(2).map((therapist) {
            final rating = therapist["rating"] as double;
            
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
                          "${therapist["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${therapist["specialty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 12, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "$rating (${therapist["patients"]} patients)",
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
                    children: [
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () => _showMessageDialog(),
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
        "title": "Understanding Your Recovery",
        "type": "Article",
        "duration": "5 min read",
        "category": "Education"
      },
      {
        "title": "Home Exercise Safety Tips",
        "type": "Video",
        "duration": "12 minutes",
        "category": "Safety"
      },
      {
        "title": "Pain Management Techniques",
        "type": "Guide",
        "duration": "8 min read",
        "category": "Pain Relief"
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

  void _showBookSessionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Book Therapy Session"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Select Therapist",
              items: therapists.map((t) => {
                "label": "${t["name"]} - ${t["specialty"]}",
                "value": t["name"]
              }).toList(),
              value: selectedTherapist,
              onChanged: (value, label) {
                selectedTherapist = value;
              },
            ),
            QDatePicker(
              label: "Session Date",
              value: DateTime.now().add(Duration(days: 1)),
              onChanged: (value) {},
            ),
            QTimePicker(
              label: "Session Time",
              value: TimeOfDay(hour: 10, minute: 0),
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
            label: "Book",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Therapy session booked successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showExerciseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Start Exercise Session"),
        content: Text("Ready to begin your daily exercise routine?"),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Start",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Exercise session started");
            },
          ),
        ],
      ),
    );
  }

  void _showPainLevelDialog() {
    int painLevel = 3;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Pain Level"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text("Rate your current pain level (1-10):"),
            Row(
              children: List.generate(10, (index) {
                final level = index + 1;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      painLevel = level;
                    },
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.only(right: index < 9 ? spXs : 0),
                      decoration: BoxDecoration(
                        color: level == painLevel 
                          ? dangerColor
                          : disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Center(
                        child: Text(
                          "$level",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: level == painLevel 
                              ? Colors.white
                              : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
            label: "Log",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Pain level logged successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showMessageDialog() {
    String message = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message Therapist"),
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
              ss("Message sent to therapist");
            },
          ),
        ],
      ),
    );
  }

  void _showAddProgramDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Exercise Program"),
        content: Text("Contact your therapist to add a new exercise program to your routine."),
        actions: [
          QButton(
            label: "OK",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

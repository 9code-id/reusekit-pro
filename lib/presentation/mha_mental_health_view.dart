import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMentalHealthView extends StatefulWidget {
  const MhaMentalHealthView({super.key});

  @override
  State<MhaMentalHealthView> createState() => _MhaMentalHealthViewState();
}

class _MhaMentalHealthViewState extends State<MhaMentalHealthView> {
  int currentTab = 0;

  // Mental health assessments data
  List<Map<String, dynamic>> assessments = [
    {
      "id": 1,
      "title": "Depression (PHQ-9)",
      "score": 12,
      "maxScore": 27,
      "level": "Moderate",
      "date": "2024-03-15",
      "color": Colors.orange,
      "description": "Patient Health Questionnaire for Depression"
    },
    {
      "id": 2,
      "title": "Anxiety (GAD-7)",
      "score": 8,
      "maxScore": 21,
      "level": "Mild",
      "date": "2024-03-14",
      "color": Colors.yellow,
      "description": "Generalized Anxiety Disorder Assessment"
    },
    {
      "id": 3,
      "title": "Stress Scale",
      "score": 15,
      "maxScore": 40,
      "level": "Moderate",
      "date": "2024-03-13",
      "color": Colors.orange,
      "description": "Perceived Stress Scale Assessment"
    },
    {
      "id": 4,
      "title": "Sleep Quality",
      "score": 6,
      "maxScore": 21,
      "level": "Good",
      "date": "2024-03-12",
      "color": Colors.green,
      "description": "Pittsburgh Sleep Quality Index"
    },
  ];

  // Mental health resources
  List<Map<String, dynamic>> resources = [
    {
      "id": 1,
      "title": "Mindfulness Meditation",
      "type": "Exercise",
      "duration": "10 min",
      "difficulty": "Beginner",
      "icon": Icons.self_improvement,
      "description": "Practice mindfulness to reduce stress and anxiety"
    },
    {
      "id": 2,
      "title": "Breathing Techniques",
      "type": "Exercise",
      "duration": "5 min",
      "difficulty": "Beginner",
      "icon": Icons.air,
      "description": "Deep breathing exercises for relaxation"
    },
    {
      "id": 3,
      "title": "Cognitive Behavioral Therapy",
      "type": "Therapy",
      "duration": "45 min",
      "difficulty": "Intermediate",
      "icon": Icons.psychology,
      "description": "CBT techniques for managing negative thoughts"
    },
    {
      "id": 4,
      "title": "Progressive Muscle Relaxation",
      "type": "Exercise",
      "duration": "15 min",
      "difficulty": "Beginner",
      "icon": Icons.spa,
      "description": "Systematic muscle relaxation technique"
    },
    {
      "id": 5,
      "title": "Journaling",
      "type": "Activity",
      "duration": "20 min",
      "difficulty": "Beginner",
      "icon": Icons.book,
      "description": "Express thoughts and emotions through writing"
    },
    {
      "id": 6,
      "title": "Support Groups",
      "type": "Community",
      "duration": "60 min",
      "difficulty": "Intermediate",
      "icon": Icons.group,
      "description": "Connect with others facing similar challenges"
    },
  ];

  // Mental health tips
  List<Map<String, dynamic>> tips = [
    {
      "id": 1,
      "title": "Stay Connected",
      "description": "Maintain relationships with family and friends",
      "category": "Social",
      "icon": Icons.people,
    },
    {
      "id": 2,
      "title": "Get Moving",
      "description": "Regular exercise boosts mood and reduces anxiety",
      "category": "Physical",
      "icon": Icons.directions_run,
    },
    {
      "id": 3,
      "title": "Practice Gratitude",
      "description": "Focus on positive aspects of your life daily",
      "category": "Mental",
      "icon": Icons.favorite,
    },
    {
      "id": 4,
      "title": "Limit Screen Time",
      "description": "Reduce exposure to negative news and social media",
      "category": "Lifestyle",
      "icon": Icons.smartphone,
    },
    {
      "id": 5,
      "title": "Seek Professional Help",
      "description": "Don't hesitate to talk to a mental health professional",
      "category": "Support",
      "icon": Icons.medical_services,
    },
    {
      "id": 6,
      "title": "Maintain Sleep Hygiene",
      "description": "Regular sleep schedule improves mental wellbeing",
      "category": "Physical",
      "icon": Icons.bedtime,
    },
  ];

  // Current mood tracking
  List<Map<String, dynamic>> moodHistory = [
    {"date": "2024-03-15", "mood": "Good", "score": 7, "color": Colors.green},
    {"date": "2024-03-14", "mood": "Fair", "score": 5, "color": Colors.orange},
    {"date": "2024-03-13", "mood": "Excellent", "score": 9, "color": Colors.blue},
    {"date": "2024-03-12", "mood": "Poor", "score": 3, "color": Colors.red},
    {"date": "2024-03-11", "mood": "Good", "score": 6, "color": Colors.green},
    {"date": "2024-03-10", "mood": "Fair", "score": 5, "color": Colors.orange},
    {"date": "2024-03-09", "mood": "Good", "score": 7, "color": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mental Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Assessments", icon: Icon(Icons.assignment)),
        Tab(text: "Resources", icon: Icon(Icons.library_books)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAssessmentsTab(),
        _buildResourcesTab(),
        _buildTipsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Daily Check-in Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.psychology, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Daily Mental Health Check-in",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "How are you feeling today? Take a moment to check in with yourself.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Quick Check-in",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to mood tracker
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.chat,
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to chat support
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Mental Health Score
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
                  "Mental Health Score",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
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
                            "72/100",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Good - Keep up the positive habits!",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withAlpha(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.sentiment_satisfied,
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Mood Trend
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Mood Trend",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to mood tracker
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: moodHistory.length,
                    itemBuilder: (context, index) {
                      final mood = moodHistory[index];
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: spXs,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: (mood["color"] as Color).withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${mood["score"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: mood["color"] as Color,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${mood["mood"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${mood["date"]}".split('-')[2],
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildQuickActionCard(
                "Start Meditation",
                Icons.self_improvement,
                Colors.blue,
                () {
                  // Navigate to meditation
                },
              ),
              _buildQuickActionCard(
                "Breathing Exercise",
                Icons.air,
                Colors.green,
                () {
                  // Navigate to breathing exercise
                },
              ),
              _buildQuickActionCard(
                "Journal Entry",
                Icons.book,
                Colors.orange,
                () {
                  // Navigate to journal
                },
              ),
              _buildQuickActionCard(
                "Crisis Support",
                Icons.emergency,
                Colors.red,
                () {
                  // Navigate to crisis support
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Assessment Summary
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
                  "Assessment Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Regular mental health assessments help track your wellbeing and identify areas for improvement.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Take New Assessment",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to assessment selection
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recent Assessments
          Text(
            "Recent Assessments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...assessments.map((assessment) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spSm),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${assessment["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${assessment["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: (assessment["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${assessment["level"]}",
                        style: TextStyle(
                          color: assessment["color"] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Score: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${assessment["score"]}/${assessment["maxScore"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: assessment["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (assessment["score"] as int) / (assessment["maxScore"] as int),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: assessment["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: spXs,
                      children: [
                        Text(
                          "${assessment["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        QButton(
                          label: "Retake",
                          size: bs.sm,
                          onPressed: () {
                            // Retake assessment
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Resource Categories
          Text(
            "Mental Health Resources",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Access tools, exercises, and support to improve your mental wellbeing.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: resources.map((resource) => Container(
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
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          resource["icon"] as IconData,
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
                              "${resource["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${resource["type"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${resource["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${resource["duration"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${resource["difficulty"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start",
                      size: bs.sm,
                      onPressed: () {
                        // Start resource activity
                      },
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Tips Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor.withAlpha(20), successColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Mental Health Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Simple, evidence-based strategies to support your mental wellbeing.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Tips List
          ...tips.map((tip) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    tip["icon"] as IconData,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${tip["category"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${tip["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

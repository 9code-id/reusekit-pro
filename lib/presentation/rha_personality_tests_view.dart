import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaPersonalityTestsView extends StatefulWidget {
  const RhaPersonalityTestsView({super.key});

  @override
  State<RhaPersonalityTestsView> createState() => _RhaPersonalityTestsViewState();
}

class _RhaPersonalityTestsViewState extends State<RhaPersonalityTestsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDuration = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> personalityTests = [
    {
      "id": "PT001",
      "title": "Big Five Personality Assessment",
      "description": "Comprehensive personality evaluation based on the five-factor model of personality traits",
      "category": "Core Personality",
      "type": "Psychometric",
      "duration": 25,
      "questions": 60,
      "participants": 524,
      "completionRate": 89.3,
      "averageScore": "Detailed Report",
      "status": "Active",
      "traits": ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Neuroticism"],
      "createdDate": "2024-01-10",
      "lastUsed": "2024-06-18",
      "creator": "Dr. Sarah Mitchell",
      "applicationAreas": ["Leadership Roles", "Team Building", "Career Development", "Communication"],
      "testSections": [
        {"name": "Openness to Experience", "questions": 12, "timeLimit": 5},
        {"name": "Conscientiousness", "questions": 12, "timeLimit": 5},
        {"name": "Extraversion", "questions": 12, "timeLimit": 5},
        {"name": "Agreeableness", "questions": 12, "timeLimit": 5},
        {"name": "Neuroticism", "questions": 12, "timeLimit": 5}
      ],
      "insights": ["Work Style", "Communication Preferences", "Leadership Potential", "Team Dynamics"]
    },
    {
      "id": "PT002",
      "title": "DISC Behavioral Assessment", 
      "description": "Evaluate behavioral styles and communication preferences in workplace environments",
      "category": "Behavioral",
      "type": "Behavioral",
      "duration": 15,
      "questions": 24,
      "participants": 398,
      "completionRate": 92.1,
      "averageScore": "Behavioral Profile",
      "status": "Active",
      "traits": ["Dominance", "Influence", "Steadiness", "Conscientiousness"],
      "createdDate": "2024-01-15",
      "lastUsed": "2024-06-17",
      "creator": "Michael Thompson",
      "applicationAreas": ["Sales Positions", "Customer Service", "Management", "Team Collaboration"],
      "testSections": [
        {"name": "Dominance (D)", "questions": 6, "timeLimit": 4},
        {"name": "Influence (I)", "questions": 6, "timeLimit": 4},
        {"name": "Steadiness (S)", "questions": 6, "timeLimit": 4},
        {"name": "Conscientiousness (C)", "questions": 6, "timeLimit": 3}
      ],
      "insights": ["Communication Style", "Motivation Factors", "Workplace Behavior", "Conflict Resolution"]
    },
    {
      "id": "PT003",
      "title": "Emotional Intelligence (EQ) Test",
      "description": "Assess emotional awareness, empathy, and social skills for workplace success",
      "category": "Emotional",
      "type": "Cognitive",
      "duration": 30,
      "questions": 40,
      "participants": 287,
      "completionRate": 85.7,
      "averageScore": "EQ Score + Analysis",
      "status": "Active",
      "traits": ["Self-Awareness", "Self-Regulation", "Motivation", "Empathy", "Social Skills"],
      "createdDate": "2024-02-01",
      "lastUsed": "2024-06-16",
      "creator": "Dr. Emily Chen",
      "applicationAreas": ["Leadership", "Customer Relations", "Healthcare", "Education"],
      "testSections": [
        {"name": "Self-Awareness", "questions": 8, "timeLimit": 6},
        {"name": "Self-Regulation", "questions": 8, "timeLimit": 6},
        {"name": "Motivation", "questions": 8, "timeLimit": 6},
        {"name": "Empathy", "questions": 8, "timeLimit": 6},
        {"name": "Social Skills", "questions": 8, "timeLimit": 6}
      ],
      "insights": ["Leadership Capability", "Team Interaction", "Stress Management", "Adaptability"]
    },
    {
      "id": "PT004",
      "title": "Myers-Briggs Type Indicator (MBTI)",
      "description": "Identify personality type preferences and cognitive functions for career alignment",
      "category": "Type Indicator",
      "type": "Psychometric",
      "duration": 20,
      "questions": 93,
      "participants": 456,
      "completionRate": 88.9,
      "averageScore": "Personality Type",
      "status": "Active",
      "traits": ["Extraversion/Introversion", "Sensing/Intuition", "Thinking/Feeling", "Judging/Perceiving"],
      "createdDate": "2024-01-20",
      "lastUsed": "2024-06-15",
      "creator": "Dr. Robert Wilson",
      "applicationAreas": ["Career Counseling", "Team Building", "Leadership Development", "Workplace Harmony"],
      "testSections": [
        {"name": "E/I Preference", "questions": 23, "timeLimit": 5},
        {"name": "S/N Preference", "questions": 23, "timeLimit": 5},
        {"name": "T/F Preference", "questions": 23, "timeLimit": 5},
        {"name": "J/P Preference", "questions": 24, "timeLimit": 5}
      ],
      "insights": ["Work Environment Fit", "Decision Making Style", "Information Processing", "Planning Approach"]
    },
    {
      "id": "PT005",
      "title": "Workplace Motivation Assessment",
      "description": "Understand what drives and motivates individuals in professional settings",
      "category": "Motivation",
      "type": "Behavioral",
      "duration": 12,
      "questions": 36,
      "participants": 342,
      "completionRate": 94.2,
      "averageScore": "Motivation Profile",
      "status": "Active",
      "traits": ["Achievement", "Power", "Affiliation", "Autonomy", "Recognition", "Security"],
      "createdDate": "2024-02-05",
      "lastUsed": "2024-06-14",
      "creator": "Lisa Anderson",
      "applicationAreas": ["Performance Management", "Career Development", "Team Motivation", "Retention"],
      "testSections": [
        {"name": "Achievement Motivation", "questions": 6, "timeLimit": 2},
        {"name": "Power Motivation", "questions": 6, "timeLimit": 2},
        {"name": "Affiliation Motivation", "questions": 6, "timeLimit": 2},
        {"name": "Autonomy Motivation", "questions": 6, "timeLimit": 2},
        {"name": "Recognition Motivation", "questions": 6, "timeLimit": 2},
        {"name": "Security Motivation", "questions": 6, "timeLimit": 2}
      ],
      "insights": ["Career Goals", "Reward Preferences", "Work Environment", "Leadership Style"]
    },
    {
      "id": "PT006",
      "title": "Cognitive Style Assessment",
      "description": "Evaluate thinking patterns, problem-solving approaches, and decision-making styles",
      "category": "Cognitive",
      "type": "Cognitive",
      "duration": 18,
      "questions": 45,
      "participants": 213,
      "completionRate": 86.4,
      "averageScore": "Cognitive Profile",
      "status": "Draft",
      "traits": ["Analytical", "Intuitive", "Systematic", "Creative", "Logical", "Emotional"],
      "createdDate": "2024-02-10",
      "lastUsed": "2024-06-10",
      "creator": "Dr. Alex Rodriguez",
      "applicationAreas": ["Problem Solving Roles", "Innovation", "Strategic Planning", "Research"],
      "testSections": [
        {"name": "Analytical Thinking", "questions": 9, "timeLimit": 3.5},
        {"name": "Creative Thinking", "questions": 9, "timeLimit": 3.5},
        {"name": "Systematic Processing", "questions": 9, "timeLimit": 3.5},
        {"name": "Intuitive Processing", "questions": 9, "timeLimit": 3.5},
        {"name": "Decision Making", "questions": 9, "timeLimit": 3.5}
      ],
      "insights": ["Problem Solving Approach", "Innovation Potential", "Learning Style", "Decision Speed"]
    }
  ];

  List<Map<String, dynamic>> get filteredTests {
    return personalityTests.where((test) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${test["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${test["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (test["traits"] as List).any((trait) => "$trait".toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || test["category"] == selectedCategory;
      bool matchesDuration = selectedDuration == "All" || _matchesDurationFilter(test["duration"] as int);
      bool matchesStatus = selectedStatus == "All" || test["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesDuration && matchesStatus;
    }).toList();
  }

  bool _matchesDurationFilter(int duration) {
    switch (selectedDuration) {
      case "Short":
        return duration <= 15;
      case "Medium":
        return duration > 15 && duration <= 25;
      case "Long":
        return duration > 25;
      default:
        return true;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Core Personality':
        return primaryColor;
      case 'Behavioral':
        return successColor;
      case 'Emotional':
        return warningColor;
      case 'Type Indicator':
        return infoColor;
      case 'Motivation':
        return secondaryColor;
      case 'Cognitive':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return successColor;
      case 'Draft':
        return warningColor;
      case 'Inactive':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personality Tests"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.add, size: 24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.psychology,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total Tests",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${personalityTests.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "+1 this month",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.people,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total Participants",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(personalityTests.fold(0, (sum, test) => sum + (test["participants"] as int)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "2,220 participants",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Completion Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${((personalityTests.fold(0.0, (sum, test) => sum + (test["completionRate"] as double)) / personalityTests.length)).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "89.4% average",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.access_time,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Average Duration",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${((personalityTests.fold(0, (sum, test) => sum + (test["duration"] as int)) / personalityTests.length)).toStringAsFixed(0)} min",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "20 minutes avg",
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

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search tests...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Core Personality", "value": "Core Personality"},
                            {"label": "Behavioral", "value": "Behavioral"},
                            {"label": "Emotional", "value": "Emotional"},
                            {"label": "Type Indicator", "value": "Type Indicator"},
                            {"label": "Motivation", "value": "Motivation"},
                            {"label": "Cognitive", "value": "Cognitive"},
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Duration",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Short (≤15 min)", "value": "Short"},
                            {"label": "Medium (16-25 min)", "value": "Medium"},
                            {"label": "Long (>25 min)", "value": "Long"},
                          ],
                          value: selectedDuration,
                          onChanged: (value, label) {
                            selectedDuration = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Active", "value": "Active"},
                            {"label": "Draft", "value": "Draft"},
                            {"label": "Inactive", "value": "Inactive"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              ),
            ),

            // Tests List
            ...filteredTests.map((test) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${test["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${test["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${test["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor("${test["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${test["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${test["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),

                    // Test Details Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor("${test["category"]}"),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getCategoryColor("${test["category"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${test["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Test Metrics
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["duration"]} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${test["questions"]} questions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["participants"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "participants",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(test["completionRate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "completion",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.assessment,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["averageScore"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Personality Traits
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Measured Traits",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (test["traits"] as List).map<Widget>((trait) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor("${test["category"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "$trait",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _getCategoryColor("${test["category"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Application Areas
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                size: 14,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Best for Roles",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (test["applicationAreas"] as List).map<Widget>((area) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: successColor.withAlpha(30),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "$area",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Key Insights
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                size: 14,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Key Insights Provided",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          ...(test["insights"] as List).map<Widget>((insight) {
                            return Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "$insight",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Start Test",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {},
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
    );
  }
}

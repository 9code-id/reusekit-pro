import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaSkillAssessmentView extends StatefulWidget {
  const ElaSkillAssessmentView({super.key});

  @override
  State<ElaSkillAssessmentView> createState() => _ElaSkillAssessmentViewState();
}

class _ElaSkillAssessmentViewState extends State<ElaSkillAssessmentView> {
  String selectedCategory = "All";
  String selectedLevel = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> skillAssessments = [
    {
      "id": "1",
      "title": "Flutter Mobile Development",
      "description": "Comprehensive assessment covering widgets, state management, and navigation",
      "category": "Mobile Development",
      "level": "Intermediate",
      "duration": "45 minutes",
      "questions": 30,
      "attempts": 1247,
      "averageScore": 78.5,
      "passingScore": 70,
      "skills": ["Flutter", "Dart", "State Management", "Navigation"],
      "icon": Icons.phone_android,
      "color": Color(0xFF02569B),
      "rating": 4.6,
      "reviews": 89,
      "isCompleted": false,
      "lastAttempt": null,
      "bestScore": null,
      "difficulty": "Intermediate"
    },
    {
      "id": "2",
      "title": "JavaScript Fundamentals",
      "description": "Test your knowledge of JavaScript basics, ES6 features, and DOM manipulation",
      "category": "Web Development",
      "level": "Beginner",
      "duration": "30 minutes",
      "questions": 25,
      "attempts": 2156,
      "averageScore": 82.3,
      "passingScore": 65,
      "skills": ["JavaScript", "ES6", "DOM", "Functions"],
      "icon": Icons.javascript,
      "color": Color(0xFFF7DF1E),
      "rating": 4.8,
      "reviews": 156,
      "isCompleted": true,
      "lastAttempt": "2024-01-10",
      "bestScore": 87,
      "difficulty": "Beginner"
    },
    {
      "id": "3",
      "title": "Machine Learning Basics",
      "description": "Evaluate your understanding of ML algorithms, data preprocessing, and model evaluation",
      "category": "AI/ML",
      "level": "Advanced",
      "duration": "60 minutes",
      "questions": 40,
      "attempts": 567,
      "averageScore": 71.2,
      "passingScore": 75,
      "skills": ["Python", "Scikit-learn", "Pandas", "Statistics"],
      "icon": Icons.psychology,
      "color": Color(0xFF3776AB),
      "rating": 4.5,
      "reviews": 43,
      "isCompleted": false,
      "lastAttempt": null,
      "bestScore": null,
      "difficulty": "Advanced"
    },
    {
      "id": "4",
      "title": "React Frontend Development",
      "description": "Assessment on React components, hooks, state management, and modern patterns",
      "category": "Web Development",
      "level": "Intermediate",
      "duration": "50 minutes",
      "questions": 35,
      "attempts": 1834,
      "averageScore": 76.8,
      "passingScore": 70,
      "skills": ["React", "JSX", "Hooks", "Redux"],
      "icon": Icons.web,
      "color": Color(0xFF61DAFB),
      "rating": 4.7,
      "reviews": 124,
      "isCompleted": true,
      "lastAttempt": "2024-01-05",
      "bestScore": 92,
      "difficulty": "Intermediate"
    },
    {
      "id": "5",
      "title": "Database Design & SQL",
      "description": "Test your skills in database design, SQL queries, and database optimization",
      "category": "Backend Development",
      "level": "Intermediate",
      "duration": "40 minutes",
      "questions": 28,
      "attempts": 923,
      "averageScore": 74.1,
      "passingScore": 68,
      "skills": ["SQL", "Database Design", "Normalization", "Indexing"],
      "icon": Icons.storage,
      "color": Color(0xFF336791),
      "rating": 4.4,
      "reviews": 67,
      "isCompleted": false,
      "lastAttempt": null,
      "bestScore": null,
      "difficulty": "Intermediate"
    },
    {
      "id": "6",
      "title": "UI/UX Design Principles",
      "description": "Evaluate your knowledge of design principles, user experience, and prototyping",
      "category": "Design",
      "level": "Beginner",
      "duration": "35 minutes",
      "questions": 25,
      "attempts": 1456,
      "averageScore": 81.7,
      "passingScore": 65,
      "skills": ["Design Principles", "Typography", "Color Theory", "Wireframing"],
      "icon": Icons.design_services,
      "color": Color(0xFFFF6B6B),
      "rating": 4.6,
      "reviews": 98,
      "isCompleted": true,
      "lastAttempt": "2023-12-28",
      "bestScore": 89,
      "difficulty": "Beginner"
    },
    {
      "id": "7",
      "title": "DevOps & Cloud Computing",
      "description": "Assessment covering Docker, Kubernetes, CI/CD, and cloud platform services",
      "category": "DevOps",
      "level": "Advanced",
      "duration": "55 minutes",
      "questions": 38,
      "attempts": 445,
      "averageScore": 68.9,
      "passingScore": 72,
      "skills": ["Docker", "Kubernetes", "AWS", "CI/CD"],
      "icon": Icons.cloud_queue,
      "color": Color(0xFF4CAF50),
      "rating": 4.3,
      "reviews": 34,
      "isCompleted": false,
      "lastAttempt": null,
      "bestScore": null,
      "difficulty": "Advanced"
    },
    {
      "id": "8",
      "title": "Cybersecurity Fundamentals",
      "description": "Test your knowledge of security principles, encryption, and threat prevention",
      "category": "Security",
      "level": "Intermediate",
      "duration": "45 minutes",
      "questions": 32,
      "attempts": 678,
      "averageScore": 72.6,
      "passingScore": 70,
      "skills": ["Encryption", "Network Security", "Penetration Testing", "OWASP"],
      "icon": Icons.security,
      "color": Color(0xFF9C27B0),
      "rating": 4.5,
      "reviews": 52,
      "isCompleted": false,
      "lastAttempt": null,
      "bestScore": null,
      "difficulty": "Intermediate"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Mobile Development", "value": "Mobile Development"},
    {"label": "Web Development", "value": "Web Development"},
    {"label": "AI/ML", "value": "AI/ML"},
    {"label": "Backend Development", "value": "Backend Development"},
    {"label": "Design", "value": "Design"},
    {"label": "DevOps", "value": "DevOps"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> levels = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> get filteredAssessments {
    return skillAssessments.where((assessment) {
      bool matchesSearch = searchQuery.isEmpty ||
          (assessment["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (assessment["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || assessment["category"] == selectedCategory;
      bool matchesLevel = selectedLevel == "All" || assessment["level"] == selectedLevel;

      return matchesSearch && matchesCategory && matchesLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skill Assessment"),
        actions: [
          GestureDetector(
            onTap: () => _showMyResultsDialog(),
            child: Container(
              padding: EdgeInsets.all(spXs),
              child: Icon(Icons.assessment),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildStatsCards(),
            _buildSearchAndFilters(),
            _buildAssessmentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    final completedCount = skillAssessments.where((a) => a["isCompleted"] == true).length;
    final totalAssessments = skillAssessments.length;
    final averageScore = skillAssessments
        .where((a) => a["bestScore"] != null)
        .map((a) => a["bestScore"] as int)
        .fold(0, (sum, score) => sum + score) / 
        (skillAssessments.where((a) => a["bestScore"] != null).length);

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard(
          "Completed Assessments",
          "$completedCount/$totalAssessments",
          Icons.check_circle,
          successColor,
        ),
        _buildStatCard(
          "Average Score",
          "${averageScore.isNaN ? 0 : averageScore.round()}%",
          Icons.trending_up,
          primaryColor,
        ),
        _buildStatCard(
          "Skill Level",
          completedCount > 3 ? "Intermediate" : "Beginner",
          Icons.school,
          warningColor,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search assessments...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Level",
                items: levels,
                value: selectedLevel,
                onChanged: (value, label) {
                  selectedLevel = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssessmentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Available Assessments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${filteredAssessments.length}",
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
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredAssessments.length,
          itemBuilder: (context, index) {
            final assessment = filteredAssessments[index];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: _buildAssessmentCard(assessment),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAssessmentCard(Map<String, dynamic> assessment) {
    final bool isCompleted = assessment["isCompleted"] as bool;
    final int? bestScore = assessment["bestScore"] as int?;
    final int passingScore = assessment["passingScore"] as int;
    final bool hasPassed = bestScore != null && bestScore >= passingScore;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: isCompleted 
            ? Border.all(color: hasPassed ? successColor : dangerColor, width: 1)
            : null,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (assessment["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    assessment["icon"] as IconData,
                    color: assessment["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${assessment["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isCompleted)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: hasPassed ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                hasPassed ? "PASSED" : "FAILED",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${assessment["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusSm),
                bottomRight: Radius.circular(radiusSm),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    _buildInfoChip(Icons.schedule, "${assessment["duration"]}", null),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.quiz, "${assessment["questions"]} Questions", null),
                    SizedBox(width: spSm),
                    _buildInfoChip(
                      Icons.school,
                      "${assessment["level"]}",
                      assessment["level"] == "Beginner"
                          ? successColor
                          : assessment["level"] == "Intermediate"
                              ? warningColor
                              : dangerColor,
                    ),
                  ],
                ),
                if (isCompleted && bestScore != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: hasPassed 
                          ? successColor.withAlpha(20) 
                          : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: hasPassed ? successColor : dangerColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          hasPassed ? Icons.check_circle : Icons.error,
                          size: 16,
                          color: hasPassed ? successColor : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Best Score: $bestScore% (Required: $passingScore%)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: hasPassed ? successColor : dangerColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Last attempt: ${DateTime.parse(assessment["lastAttempt"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skills Covered:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: (assessment["skills"] as List).map((skill) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$skill",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${assessment["attempts"]} attempts",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: 4),
                    Text(
                      "${assessment["rating"]} (${assessment["reviews"]} reviews)",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Text(
                      "Avg: ${(assessment["averageScore"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      flex: 3,
                      child: QButton(
                        label: isCompleted ? "Retake Assessment" : "Start Assessment",
                        size: bs.sm,
                        onPressed: () => _startAssessment(assessment),
                      ),
                    ),
                    QButton(
                      icon: Icons.info_outline,
                      size: bs.sm,
                      onPressed: () => _showAssessmentDetails(assessment),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color? color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color ?? disabledBoldColor),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color ?? disabledBoldColor,
            fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _startAssessment(Map<String, dynamic> assessment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.quiz, color: primaryColor),
            SizedBox(width: spSm),
            Text("Start Assessment"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you ready to start the ${assessment["title"]} assessment?"),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Duration: ${assessment["duration"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.quiz, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Questions: ${assessment["questions"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.school, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Passing Score: ${assessment["passingScore"]}%"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Assessment started! Good luck!");
            },
            child: Text("Start Now"),
          ),
        ],
      ),
    );
  }

  void _showAssessmentDetails(Map<String, dynamic> assessment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (assessment["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      assessment["icon"] as IconData,
                      color: assessment["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${assessment["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${assessment["category"]} • ${assessment["level"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${assessment["description"]}",
                          style: TextStyle(fontSize: 14, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: [
                        _buildDetailCard("Duration", "${assessment["duration"]}", Icons.schedule),
                        _buildDetailCard("Questions", "${assessment["questions"]}", Icons.quiz),
                        _buildDetailCard("Passing Score", "${assessment["passingScore"]}%", Icons.gps_fixed),
                        _buildDetailCard("Difficulty", "${assessment["level"]}", Icons.school),
                        _buildDetailCard("Attempts", "${assessment["attempts"]}", Icons.people),
                        _buildDetailCard("Rating", "${assessment["rating"]}/5.0", Icons.star),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skills You'll Be Tested On",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: (assessment["skills"] as List).map((skill) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: primaryColor.withAlpha(50)),
                              ),
                              child: Text(
                                "$skill",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    QButton(
                      label: "Start Assessment",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        _startAssessment(assessment);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showMyResultsDialog() {
    final completedAssessments = skillAssessments.where((a) => a["isCompleted"] == true).toList();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Icon(Icons.assessment, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "My Assessment Results",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: completedAssessments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.quiz, size: 64, color: disabledBoldColor),
                          SizedBox(height: spMd),
                          Text(
                            "No completed assessments yet",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Start taking assessments to see your results here",
                            style: TextStyle(color: disabledBoldColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(spMd),
                      itemCount: completedAssessments.length,
                      itemBuilder: (context, index) {
                        final assessment = completedAssessments[index];
                        final int bestScore = assessment["bestScore"] as int;
                        final int passingScore = assessment["passingScore"] as int;
                        final bool hasPassed = bestScore >= passingScore;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: hasPassed ? successColor : dangerColor,
                              width: 1,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${assessment["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: hasPassed ? successColor : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      hasPassed ? "PASSED" : "FAILED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Score: $bestScore%",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: hasPassed ? successColor : dangerColor,
                                          ),
                                        ),
                                        Text(
                                          "Required: $passingScore%",
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
                                    children: [
                                      Text(
                                        "Completed:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${DateTime.parse(assessment["lastAttempt"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}

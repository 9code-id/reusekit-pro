import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCustomAssessmentsView extends StatefulWidget {
  const RhaCustomAssessmentsView({super.key});

  @override
  State<RhaCustomAssessmentsView> createState() => _RhaCustomAssessmentsViewState();
}

class _RhaCustomAssessmentsViewState extends State<RhaCustomAssessmentsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  bool loading = false;

  List<Map<String, dynamic>> customAssessments = [
    {
      "id": "CA001",
      "title": "Advanced JavaScript Programming",
      "description": "Comprehensive assessment covering ES6+, async programming, and modern frameworks",
      "category": "Technical",
      "difficulty": "Advanced",
      "duration": 90,
      "questions": 45,
      "status": "active",
      "createdBy": "John Smith",
      "createdAt": "2024-12-10 09:30:00",
      "lastModified": "2024-12-15 14:20:00",
      "completions": 127,
      "avgScore": 78.5,
      "tags": ["javascript", "programming", "frontend"],
      "sections": [
        {"title": "Core Concepts", "questions": 15, "timeLimit": 30},
        {"title": "Async Programming", "questions": 15, "timeLimit": 30},
        {"title": "Practical Application", "questions": 15, "timeLimit": 30}
      ]
    },
    {
      "id": "CA002",
      "title": "Leadership Assessment v2.0",
      "description": "Updated leadership evaluation with situational judgment and team management scenarios",
      "category": "Behavioral",
      "difficulty": "Intermediate",
      "duration": 75,
      "questions": 30,
      "status": "active",
      "createdBy": "Sarah Johnson",
      "createdAt": "2024-12-08 11:15:00",
      "lastModified": "2024-12-12 16:45:00",
      "completions": 89,
      "avgScore": 82.3,
      "tags": ["leadership", "management", "teamwork"],
      "sections": [
        {"title": "Leadership Styles", "questions": 10, "timeLimit": 25},
        {"title": "Decision Making", "questions": 10, "timeLimit": 25},
        {"title": "Situational Judgment", "questions": 10, "timeLimit": 25}
      ]
    },
    {
      "id": "CA003",
      "title": "Data Science Fundamentals",
      "description": "Comprehensive evaluation of statistics, machine learning, and data analysis skills",
      "category": "Technical",
      "difficulty": "Intermediate",
      "duration": 120,
      "questions": 50,
      "status": "draft",
      "createdBy": "Michael Chen",
      "createdAt": "2024-12-14 08:00:00",
      "lastModified": "2024-12-16 10:30:00",
      "completions": 0,
      "avgScore": 0,
      "tags": ["data science", "statistics", "machine learning"],
      "sections": [
        {"title": "Statistical Analysis", "questions": 20, "timeLimit": 50},
        {"title": "Machine Learning", "questions": 20, "timeLimit": 50},
        {"title": "Data Visualization", "questions": 10, "timeLimit": 20}
      ]
    },
    {
      "id": "CA004",
      "title": "Customer Service Excellence",
      "description": "Assessment focusing on communication skills, problem-solving, and customer satisfaction",
      "category": "Soft Skills",
      "difficulty": "Beginner",
      "duration": 60,
      "questions": 25,
      "status": "inactive",
      "createdBy": "Emily Rodriguez",
      "createdAt": "2024-11-28 14:20:00",
      "lastModified": "2024-12-01 09:15:00",
      "completions": 234,
      "avgScore": 85.7,
      "tags": ["customer service", "communication", "problem solving"],
      "sections": [
        {"title": "Communication Skills", "questions": 10, "timeLimit": 25},
        {"title": "Problem Resolution", "questions": 10, "timeLimit": 25},
        {"title": "Customer Psychology", "questions": 5, "timeLimit": 10}
      ]
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technical", "value": "Technical"},
    {"label": "Behavioral", "value": "Behavioral"},
    {"label": "Soft Skills", "value": "Soft Skills"},
    {"label": "Leadership", "value": "Leadership"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Inactive", "value": "inactive"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Custom Assessments",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Assessments", icon: Icon(Icons.assignment)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Builder", icon: Icon(Icons.build)),
      ],
      tabChildren: [
        _buildMyAssessmentsTab(),
        _buildTemplatesTab(),
        _buildBuilderTab(),
      ],
    );
  }

  Widget _buildMyAssessmentsTab() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildQuickStats(),
          _buildAssessmentsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                  label: "Search assessments...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                label: "Create New",
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
                  items: categoryOptions,
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard("Total Assessments", "47", Icons.assignment, primaryColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Active", "34", Icons.check_circle, successColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Drafts", "8", Icons.edit, warningColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Inactive", "5", Icons.pause_circle, disabledBoldColor),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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

  Widget _buildAssessmentsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(Icons.list, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Custom Assessments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Import",
                  icon: Icons.upload,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          ...customAssessments.map((assessment) => _buildAssessmentItem(assessment)),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(Map<String, dynamic> assessment) {
    Color statusColor = _getStatusColor(assessment["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: statusColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${assessment["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${assessment["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${assessment["status"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${assessment["category"]} • ${assessment["difficulty"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.timer, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${assessment["duration"]} min",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.quiz, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${assessment["questions"]} questions",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          QHorizontalScroll(
            children: (assessment["tags"] as List).map((tag) => Container(
              margin: EdgeInsets.only(right: spXs),
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "#$tag",
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                ),
              ),
            )).toList(),
          ),
          if (assessment["status"] == "active") ...[
            Row(
              children: [
                Text(
                  "Completions: ${assessment["completions"]} • Avg Score: ${(assessment["avgScore"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Text(
                  "Created by ${assessment["createdBy"]} • ${assessment["createdAt"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: assessment["status"] == "draft" ? "Continue" : "Activate",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "draft":
        return warningColor;
      case "inactive":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildTemplatesTab() {
    List<Map<String, dynamic>> templates = [
      {
        "id": "T001",
        "title": "Technical Skills Assessment",
        "description": "Ready-to-use template for evaluating programming and technical competencies",
        "category": "Technical",
        "duration": 60,
        "questions": 30,
        "difficulty": "Intermediate",
        "usageCount": 127,
        "rating": 4.7,
        "tags": ["programming", "technical", "coding"]
      },
      {
        "id": "T002",
        "title": "Leadership Evaluation",
        "description": "Comprehensive leadership assessment with behavioral scenarios",
        "category": "Leadership",
        "duration": 75,
        "questions": 25,
        "difficulty": "Advanced",
        "usageCount": 89,
        "rating": 4.5,
        "tags": ["leadership", "management", "behavioral"]
      },
      {
        "id": "T003",
        "title": "Soft Skills Evaluation",
        "description": "Assessment template for communication, teamwork, and interpersonal skills",
        "category": "Soft Skills",
        "duration": 45,
        "questions": 20,
        "difficulty": "Beginner",
        "usageCount": 156,
        "rating": 4.8,
        "tags": ["communication", "teamwork", "interpersonal"]
      },
      {
        "id": "T004",
        "title": "Sales Performance Assessment",
        "description": "Evaluate sales techniques, customer relationship management, and negotiation skills",
        "category": "Sales",
        "duration": 90,
        "questions": 35,
        "difficulty": "Intermediate",
        "usageCount": 73,
        "rating": 4.3,
        "tags": ["sales", "negotiation", "customer relations"]
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplatesHeader(),
          _buildTemplateCategories(),
          _buildTemplatesList(templates),
        ],
      ),
    );
  }

  Widget _buildTemplatesHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.library_books, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assessment Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Pre-built assessment templates to get you started quickly",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Browse All",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCategories() {
    List<Map<String, dynamic>> categories = [
      {"name": "Technical", "count": 12, "icon": Icons.code},
      {"name": "Leadership", "count": 8, "icon": Icons.groups},
      {"name": "Soft Skills", "count": 15, "icon": Icons.psychology},
      {"name": "Sales", "count": 6, "icon": Icons.trending_up},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: categories.map((category) => Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                category["icon"] as IconData,
                color: primaryColor,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${category["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${category["count"]} templates",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildTemplatesList(List<Map<String, dynamic>> templates) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Popular Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...templates.map((template) => _buildTemplateItem(template)),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: primaryColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: 2),
                  Text(
                    "${template["rating"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${template["category"]} • ${template["difficulty"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.timer, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${template["duration"]} min",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${template["usageCount"]} uses",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          QHorizontalScroll(
            children: (template["tags"] as List).map((tag) => Container(
              margin: EdgeInsets.only(right: spXs),
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "#$tag",
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                ),
              ),
            )).toList(),
          ),
          Row(
            children: [
              QButton(
                label: "Preview",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuilderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBuilderOptions(),
          _buildQuickStartGuide(),
          _buildRecentDrafts(),
        ],
      ),
    );
  }

  Widget _buildBuilderOptions() {
    List<Map<String, dynamic>> options = [
      {
        "title": "Start from Scratch",
        "description": "Build a completely custom assessment from the ground up",
        "icon": Icons.create,
        "color": primaryColor,
      },
      {
        "title": "Use Template",
        "description": "Customize one of our pre-built assessment templates",
        "icon": Icons.library_books,
        "color": infoColor,
      },
      {
        "title": "Import Questions",
        "description": "Import questions from external sources or existing assessments",
        "icon": Icons.upload,
        "color": successColor,
      },
      {
        "title": "AI Assistant",
        "description": "Let AI help you generate questions and structure your assessment",
        "icon": Icons.auto_awesome,
        "color": warningColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Assessment Builder",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: options.map((option) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (option["color"] as Color).withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: (option["color"] as Color).withAlpha(30)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (option["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      option["icon"] as IconData,
                      color: option["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${option["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${option["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start Building",
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildQuickStartGuide() {
    List<Map<String, dynamic>> steps = [
      {"step": "1", "title": "Define Assessment", "description": "Set title, category, and basic parameters"},
      {"step": "2", "title": "Add Questions", "description": "Create or import questions with various types"},
      {"step": "3", "title": "Configure Settings", "description": "Set time limits, scoring, and difficulty levels"},
      {"step": "4", "title": "Test & Preview", "description": "Review and test your assessment before publishing"},
      {"step": "5", "title": "Publish & Share", "description": "Make your assessment available to participants"},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Quick Start Guide",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...steps.map((step) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "${step["step"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${step["description"]}",
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
          )),
        ],
      ),
    );
  }

  Widget _buildRecentDrafts() {
    List<Map<String, dynamic>> drafts = [
      {
        "title": "Python Programming Assessment",
        "lastModified": "2 hours ago",
        "progress": 65,
        "questions": 8,
      },
      {
        "title": "Marketing Strategy Evaluation",
        "lastModified": "1 day ago",
        "progress": 30,
        "questions": 3,
      },
      {
        "title": "Project Management Skills",
        "lastModified": "3 days ago",
        "progress": 85,
        "questions": 15,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Recent Drafts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if (drafts.isEmpty) ...[
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Text(
                  "No draft assessments found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ] else ...[
            ...drafts.map((draft) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${draft["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${draft["lastModified"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${draft["questions"]} questions • ${draft["progress"]}% complete",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Continue",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (draft["progress"] as int) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}

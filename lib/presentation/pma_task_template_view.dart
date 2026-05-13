import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskTemplateView extends StatefulWidget {
  const PmaTaskTemplateView({super.key});

  @override
  State<PmaTaskTemplateView> createState() => _PmaTaskTemplateViewState();
}

class _PmaTaskTemplateViewState extends State<PmaTaskTemplateView> {
  String searchQuery = "";
  String selectedDifficulty = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All", "value": "All"},
    {"label": "Easy", "value": "Easy"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Hard", "value": "Hard"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Development", "value": "Development"},
    {"label": "Design", "value": "Design"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> taskTemplates = [
    {
      "id": 1,
      "name": "API Development",
      "description": "Create RESTful API endpoints with authentication",
      "category": "Development",
      "difficulty": "Medium",
      "estimatedHours": 8,
      "successRate": 92,
      "usageCount": 456,
      "skills": ["Backend", "API Design", "Authentication"],
      "icon": Icons.code,
      "color": "primary",
      "createdBy": "John Smith",
      "lastUsed": "2024-01-20",
    },
    {
      "id": 2,
      "name": "UI/UX Wireframing",
      "description": "Design user interface wireframes and prototypes",
      "category": "Design",
      "difficulty": "Easy",
      "estimatedHours": 4,
      "successRate": 88,
      "usageCount": 789,
      "skills": ["Design", "Prototyping", "User Research"],
      "icon": Icons.design_services,
      "color": "success",
      "createdBy": "Sarah Wilson",
      "lastUsed": "2024-01-22",
    },
    {
      "id": 3,
      "name": "Unit Testing Suite",
      "description": "Write comprehensive unit tests for components",
      "category": "Testing",
      "difficulty": "Hard",
      "estimatedHours": 12,
      "successRate": 85,
      "usageCount": 234,
      "skills": ["Testing", "Quality Assurance", "Automation"],
      "icon": Icons.bug_report,
      "color": "warning",
      "createdBy": "Mike Johnson",
      "lastUsed": "2024-01-18",
    },
    {
      "id": 4,
      "name": "Technical Documentation",
      "description": "Create detailed technical documentation",
      "category": "Documentation",
      "difficulty": "Medium",
      "estimatedHours": 6,
      "successRate": 94,
      "usageCount": 567,
      "skills": ["Writing", "Technical Communication", "Documentation"],
      "icon": Icons.description,
      "color": "info",
      "createdBy": "Emily Chen",
      "lastUsed": "2024-01-21",
    },
    {
      "id": 5,
      "name": "Database Optimization",
      "description": "Optimize database queries and performance",
      "category": "Development",
      "difficulty": "Expert",
      "estimatedHours": 16,
      "successRate": 78,
      "usageCount": 123,
      "skills": ["Database", "Performance", "SQL"],
      "icon": Icons.storage,
      "color": "danger",
      "createdBy": "Alex Rodriguez",
      "lastUsed": "2024-01-15",
    },
    {
      "id": 6,
      "name": "Social Media Campaign",
      "description": "Plan and execute social media marketing strategy",
      "category": "Marketing",
      "difficulty": "Easy",
      "estimatedHours": 5,
      "successRate": 91,
      "usageCount": 678,
      "skills": ["Marketing", "Social Media", "Content Creation"],
      "icon": Icons.campaign,
      "color": "secondary",
      "createdBy": "Lisa Park",
      "lastUsed": "2024-01-19",
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return taskTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          template["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          template["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDifficulty = selectedDifficulty == "All" || template["difficulty"] == selectedDifficulty;
      bool matchesCategory = selectedCategory == "All" || template["category"] == selectedCategory;
      
      return matchesSearch && matchesDifficulty && matchesCategory;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return infoColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTemplateColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "secondary":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Task Templates",
                    value: searchQuery,
                    hint: "Search by name or description...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Difficulty",
                          items: difficultyLevels,
                          value: selectedDifficulty,
                          onChanged: (value, label) {
                            selectedDifficulty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredTemplates.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Templates Found",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((taskTemplates.map((t) => t["successRate"] as int).reduce((a, b) => a + b)) / taskTemplates.length).round()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg Success Rate",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((taskTemplates.map((t) => t["usageCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Usage",
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
            ),

            // Task Template Grid
            if (filteredTemplates.isNotEmpty)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTemplates.map((template) {
                  Color templateColor = _getTemplateColor(template["color"]);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: templateColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: templateColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  template["icon"],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: templateColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(template["difficulty"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: _getDifficultyColor(template["difficulty"]),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${template["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getDifficultyColor(template["difficulty"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Template Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Description
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Category
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${template["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),

                              // Stats Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["estimatedHours"]}h",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.trending_up,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["successRate"]}%",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              // Usage and Creator
                              Row(
                                children: [
                                  Icon(
                                    Icons.download,
                                    size: 14,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["usageCount"]} uses",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "By ${template["createdBy"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),

                              // Skills
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: (template["skills"] as List).map((skill) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$skill",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Last Used
                              Text(
                                "Last used: ${template["lastUsed"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),

                              // Action Buttons
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Use Template",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No task templates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

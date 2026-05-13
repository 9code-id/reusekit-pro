import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectTemplateView extends StatefulWidget {
  const PmaProjectTemplateView({super.key});

  @override
  State<PmaProjectTemplateView> createState() => _PmaProjectTemplateViewState();
}

class _PmaProjectTemplateViewState extends State<PmaProjectTemplateView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedComplexity = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Web Development", "value": "Web Development"},
    {"label": "Mobile App", "value": "Mobile App"},
    {"label": "AI & Machine Learning", "value": "AI & Machine Learning"},
    {"label": "E-commerce", "value": "E-commerce"},
    {"label": "Healthcare", "value": "Healthcare"},
  ];

  List<Map<String, dynamic>> complexityLevels = [
    {"label": "All", "value": "All"},
    {"label": "Simple", "value": "Simple"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Complex", "value": "Complex"},
    {"label": "Enterprise", "value": "Enterprise"},
  ];

  List<Map<String, dynamic>> projectTemplates = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "description": "Complete online store with payment integration",
      "category": "E-commerce",
      "complexity": "Complex",
      "duration": "8-12 weeks",
      "teamSize": 5,
      "successRate": 89,
      "usageCount": 324,
      "technologies": ["React", "Node.js", "MongoDB"],
      "image": "https://picsum.photos/300/200?random=1&keyword=ecommerce",
      "createdBy": "Sarah Johnson",
      "lastUpdated": "2024-01-15",
    },
    {
      "id": 2,
      "name": "Healthcare Management System",
      "description": "Patient management with appointment scheduling",
      "category": "Healthcare",
      "complexity": "Enterprise",
      "duration": "12-16 weeks",
      "teamSize": 8,
      "successRate": 92,
      "usageCount": 156,
      "technologies": ["Flutter", "Firebase", "MySQL"],
      "image": "https://picsum.photos/300/200?random=2&keyword=healthcare",
      "createdBy": "Dr. Michael Chen",
      "lastUpdated": "2024-01-10",
    },
    {
      "id": 3,
      "name": "Social Media Dashboard",
      "description": "Analytics dashboard for social media management",
      "category": "Web Development",
      "complexity": "Moderate",
      "duration": "4-6 weeks",
      "teamSize": 3,
      "successRate": 95,
      "usageCount": 789,
      "technologies": ["Vue.js", "Python", "PostgreSQL"],
      "image": "https://picsum.photos/300/200?random=3&keyword=dashboard",
      "createdBy": "Alex Rodriguez",
      "lastUpdated": "2024-01-20",
    },
    {
      "id": 4,
      "name": "Mobile Fitness Tracker",
      "description": "Track workouts and nutrition with AI insights",
      "category": "Mobile App",
      "complexity": "Complex",
      "duration": "10-14 weeks",
      "teamSize": 6,
      "successRate": 87,
      "usageCount": 445,
      "technologies": ["React Native", "TensorFlow", "AWS"],
      "image": "https://picsum.photos/300/200?random=4&keyword=fitness",
      "createdBy": "Emma Wilson",
      "lastUpdated": "2024-01-18",
    },
    {
      "id": 5,
      "name": "AI Chatbot Platform",
      "description": "Intelligent customer service automation",
      "category": "AI & Machine Learning",
      "complexity": "Enterprise",
      "duration": "14-20 weeks",
      "teamSize": 10,
      "successRate": 84,
      "usageCount": 267,
      "technologies": ["Python", "TensorFlow", "Docker"],
      "image": "https://picsum.photos/300/200?random=5&keyword=chatbot",
      "createdBy": "David Kim",
      "lastUpdated": "2024-01-12",
    },
    {
      "id": 6,
      "name": "Task Management App",
      "description": "Simple team collaboration and task tracking",
      "category": "Web Development",
      "complexity": "Simple",
      "duration": "2-4 weeks",
      "teamSize": 2,
      "successRate": 98,
      "usageCount": 1203,
      "technologies": ["React", "Express", "SQLite"],
      "image": "https://picsum.photos/300/200?random=6&keyword=tasks",
      "createdBy": "Lisa Park",
      "lastUpdated": "2024-01-22",
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return projectTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          template["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          template["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || template["category"] == selectedCategory;
      bool matchesComplexity = selectedComplexity == "All" || template["complexity"] == selectedComplexity;
      
      return matchesSearch && matchesCategory && matchesComplexity;
    }).toList();
  }

  Color _getComplexityColor(String complexity) {
    switch (complexity) {
      case "Simple":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Complex":
        return infoColor;
      case "Enterprise":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
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
                    label: "Search Templates",
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
                          label: "Complexity",
                          items: complexityLevels,
                          value: selectedComplexity,
                          onChanged: (value, label) {
                            selectedComplexity = value;
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
                          "${((projectTemplates.map((t) => t["successRate"] as int).reduce((a, b) => a + b)) / projectTemplates.length).round()}%",
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
                          "${((projectTemplates.map((t) => t["usageCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
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

            // Template Grid
            if (filteredTemplates.isNotEmpty)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTemplates.map((template) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                          child: Image.network(
                            "${template["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Template Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Complexity
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${template["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getComplexityColor(template["complexity"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: _getComplexityColor(template["complexity"]),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "${template["complexity"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getComplexityColor(template["complexity"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

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
                                    "${template["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.people,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["teamSize"]} people",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Success Rate and Usage
                              Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${template["successRate"]}% success",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
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
                                ],
                              ),

                              // Technologies
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: (template["technologies"] as List).map((tech) {
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
                                      "$tech",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Creator and Date
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "By ${template["createdBy"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${template["lastUpdated"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
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
                                    icon: Icons.favorite_border,
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
                      "No templates found",
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

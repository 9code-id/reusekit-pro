import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskTemplatesView extends StatefulWidget {
  const TpmTaskTemplatesView({super.key});

  @override
  State<TpmTaskTemplatesView> createState() => _TpmTaskTemplatesViewState();
}

class _TpmTaskTemplatesViewState extends State<TpmTaskTemplatesView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedDepartment = "";
  int currentTab = 0;

  List<Map<String, dynamic>> templates = [
    {
      "id": 1,
      "name": "Database Design Template",
      "description": "Complete database design workflow with schema creation, optimization, and documentation",
      "category": "Development",
      "department": "Engineering",
      "estimatedHours": 40,
      "difficulty": "Advanced",
      "tags": ["Database", "Schema", "SQL", "Architecture"],
      "createdBy": "Michael Chen",
      "createdDate": "2024-12-01",
      "usageCount": 25,
      "rating": 4.8,
      "isPublic": true,
      "isFavorite": false,
      "subtasks": [
        {
          "title": "Requirements Analysis",
          "description": "Analyze database requirements and constraints",
          "estimatedHours": 8,
          "priority": "High"
        },
        {
          "title": "Schema Design",
          "description": "Design database schema with tables and relationships",
          "estimatedHours": 16,
          "priority": "High"
        },
        {
          "title": "Performance Optimization",
          "description": "Create indexes and optimize queries",
          "estimatedHours": 8,
          "priority": "Medium"
        },
        {
          "title": "Documentation",
          "description": "Document schema and usage guidelines",
          "estimatedHours": 8,
          "priority": "Medium"
        }
      ]
    },
    {
      "id": 2,
      "name": "UI/UX Design Process",
      "description": "End-to-end UI/UX design workflow from research to final mockups",
      "category": "Design",
      "department": "Design",
      "estimatedHours": 60,
      "difficulty": "Intermediate",
      "tags": ["UI Design", "UX Research", "Wireframes", "Prototyping"],
      "createdBy": "Emma Wilson",
      "createdDate": "2024-11-28",
      "usageCount": 18,
      "rating": 4.6,
      "isPublic": true,
      "isFavorite": true,
      "subtasks": [
        {
          "title": "User Research",
          "description": "Conduct user interviews and surveys",
          "estimatedHours": 16,
          "priority": "High"
        },
        {
          "title": "Wireframing",
          "description": "Create low-fidelity wireframes",
          "estimatedHours": 12,
          "priority": "High"
        },
        {
          "title": "UI Design",
          "description": "Design high-fidelity mockups",
          "estimatedHours": 20,
          "priority": "High"
        },
        {
          "title": "Prototyping",
          "description": "Create interactive prototypes",
          "estimatedHours": 12,
          "priority": "Medium"
        }
      ]
    },
    {
      "id": 3,
      "name": "API Development Workflow",
      "description": "Standard API development process with testing and documentation",
      "category": "Development",
      "department": "Engineering",
      "estimatedHours": 32,
      "difficulty": "Intermediate",
      "tags": ["API", "REST", "Testing", "Documentation"],
      "createdBy": "John Smith",
      "createdDate": "2024-12-05",
      "usageCount": 12,
      "rating": 4.5,
      "isPublic": true,
      "isFavorite": false,
      "subtasks": [
        {
          "title": "API Design",
          "description": "Design API endpoints and data models",
          "estimatedHours": 8,
          "priority": "High"
        },
        {
          "title": "Implementation",
          "description": "Implement API endpoints with business logic",
          "estimatedHours": 16,
          "priority": "High"
        },
        {
          "title": "Testing",
          "description": "Write unit and integration tests",
          "estimatedHours": 6,
          "priority": "High"
        },
        {
          "title": "Documentation",
          "description": "Create API documentation and examples",
          "estimatedHours": 2,
          "priority": "Medium"
        }
      ]
    },
    {
      "id": 4,
      "name": "QA Testing Process",
      "description": "Comprehensive testing workflow for web applications",
      "category": "Testing",
      "department": "Quality Assurance",
      "estimatedHours": 24,
      "difficulty": "Beginner",
      "tags": ["Testing", "QA", "Bug Tracking", "Automation"],
      "createdBy": "David Rodriguez",
      "createdDate": "2024-11-25",
      "usageCount": 30,
      "rating": 4.9,
      "isPublic": true,
      "isFavorite": true,
      "subtasks": [
        {
          "title": "Test Planning",
          "description": "Create test plan and test cases",
          "estimatedHours": 6,
          "priority": "High"
        },
        {
          "title": "Manual Testing",
          "description": "Execute manual test cases",
          "estimatedHours": 12,
          "priority": "High"
        },
        {
          "title": "Bug Reporting",
          "description": "Document and track bugs",
          "estimatedHours": 4,
          "priority": "High"
        },
        {
          "title": "Regression Testing",
          "description": "Perform regression testing after fixes",
          "estimatedHours": 2,
          "priority": "Medium"
        }
      ]
    },
    {
      "id": 5,
      "name": "Project Documentation",
      "description": "Complete documentation workflow for software projects",
      "category": "Documentation",
      "department": "Product Management",
      "estimatedHours": 16,
      "difficulty": "Beginner",
      "tags": ["Documentation", "Technical Writing", "User Guide"],
      "createdBy": "Lisa Park",
      "createdDate": "2024-12-10",
      "usageCount": 8,
      "rating": 4.2,
      "isPublic": true,
      "isFavorite": false,
      "subtasks": [
        {
          "title": "Technical Specification",
          "description": "Write technical specifications",
          "estimatedHours": 6,
          "priority": "High"
        },
        {
          "title": "User Guide",
          "description": "Create user guide and tutorials",
          "estimatedHours": 6,
          "priority": "Medium"
        },
        {
          "title": "API Documentation",
          "description": "Document API endpoints and usage",
          "estimatedHours": 4,
          "priority": "Medium"
        }
      ]
    },
    {
      "id": 6,
      "name": "Marketing Campaign Launch",
      "description": "Complete marketing campaign from planning to execution",
      "category": "Marketing",
      "department": "Marketing",
      "estimatedHours": 80,
      "difficulty": "Advanced",
      "tags": ["Marketing", "Campaign", "Social Media", "Analytics"],
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-11-20",
      "usageCount": 6,
      "rating": 4.3,
      "isPublic": false,
      "isFavorite": false,
      "subtasks": [
        {
          "title": "Campaign Strategy",
          "description": "Develop campaign strategy and goals",
          "estimatedHours": 16,
          "priority": "High"
        },
        {
          "title": "Content Creation",
          "description": "Create marketing content and assets",
          "estimatedHours": 32,
          "priority": "High"
        },
        {
          "title": "Campaign Execution",
          "description": "Launch and monitor campaign",
          "estimatedHours": 24,
          "priority": "High"
        },
        {
          "title": "Analytics & Reporting",
          "description": "Analyze results and create reports",
          "estimatedHours": 8,
          "priority": "Medium"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "Development", "value": "Development"},
    {"label": "Design", "value": "Design"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Marketing", "value": "Marketing"}
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Quality Assurance", "value": "Quality Assurance"},
    {"label": "Product Management", "value": "Product Management"},
    {"label": "Marketing", "value": "Marketing"}
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return templates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          (template["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory.isEmpty || template["category"] == selectedCategory;
      bool matchesDepartment = selectedDepartment.isEmpty || template["department"] == selectedDepartment;
      
      return matchesSearch && matchesCategory && matchesDepartment;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Development":
        return primaryColor;
      case "Design":
        return secondaryColor;
      case "Testing":
        return warningColor;
      case "Documentation":
        return infoColor;
      case "Marketing":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Task Templates",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.view_list)),
        Tab(text: "My Templates", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildMyTemplatesTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search templates...",
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
                size: bs.sm,
                onPressed: () => _createTemplate(),
              ),
            ],
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
                  label: "Department",
                  items: departments,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.view_list, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Total Templates",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${templates.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [successColor, successColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Favorites",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${templates.where((t) => t["isFavorite"] as bool).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (filteredTemplates.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No templates found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search filters",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTemplates.length,
              itemBuilder: (context, index) {
                final template = filteredTemplates[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        color: _getCategoryColor("${template["category"]}"),
                        width: 4,
                      ),
                    ),
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
                              children: [
                                Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${template["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => _toggleFavorite(template),
                                child: Icon(
                                  (template["isFavorite"] as bool) ? Icons.star : Icons.star_border,
                                  color: (template["isFavorite"] as bool) ? warningColor : disabledColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(height: spXs),
                              if (!(template["isPublic"] as bool))
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Private",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getCategoryColor("${template["category"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${template["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getCategoryColor("${template["category"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor("${template["difficulty"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${template["difficulty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getDifficultyColor("${template["difficulty"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledColor),
                              SizedBox(width: 4),
                              Text(
                                "${template["estimatedHours"]}h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: warningColor),
                              SizedBox(width: 4),
                              Text(
                                "${template["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: [
                              Icon(Icons.download, size: 14, color: disabledColor),
                              SizedBox(width: 4),
                              Text(
                                "${template["usageCount"]} uses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "by ${template["createdBy"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),

                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (template["tags"] as List).take(4).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Use Template",
                              size: bs.sm,
                              onPressed: () => _useTemplate(template),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () => _previewTemplate(template),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () => _showTemplateOptions(template),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMyTemplatesTab() {
    List<Map<String, dynamic>> myTemplates = templates.where((t) => t["isFavorite"] as bool).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your favorite templates for quick access",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (myTemplates.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.star_border,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No favorite templates",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Star templates to add them to your favorites",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Browse Templates",
                    onPressed: () {
                      currentTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          else
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 280,
              children: myTemplates.map((template) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_getCategoryColor("${template["category"]}"), _getCategoryColor("${template["category"]}").withAlpha(200)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${template["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Icon(Icons.star, color: Colors.white, size: 20),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${template["category"]} • ${template["difficulty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${template["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Icon(Icons.schedule, size: 14, color: disabledColor),
                                SizedBox(width: 4),
                                Text(
                                  "${template["estimatedHours"]}h",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                                Spacer(),
                                Icon(Icons.star, size: 14, color: warningColor),
                                SizedBox(width: 4),
                                Text(
                                  "${template["rating"]}",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                              ],
                            ),

                            Text(
                              "${(template["subtasks"] as List).length} subtasks included",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Use Template",
                                size: bs.sm,
                                onPressed: () => _useTemplate(template),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Template",
                        icon: Icons.add,
                        onPressed: () => _createTemplate(),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.import_export,
                      size: bs.sm,
                      onPressed: () => _importTemplate(),
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

  void _toggleFavorite(Map<String, dynamic> template) {
    template["isFavorite"] = !(template["isFavorite"] as bool);
    setState(() {});
    
    if (template["isFavorite"] as bool) {
      ss("Added to favorites");
    } else {
      ss("Removed from favorites");
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    // Implementation for using template
    ss("Creating task from template: ${template["name"]}");
  }

  void _previewTemplate(Map<String, dynamic> template) {
    // Implementation for previewing template
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    // Implementation for showing template options
  }

  void _createTemplate() {
    // Implementation for creating new template
  }

  void _importTemplate() {
    // Implementation for importing template
  }
}

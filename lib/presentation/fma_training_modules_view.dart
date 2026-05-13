import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaTrainingModulesView extends StatefulWidget {
  const FmaTrainingModulesView({super.key});

  @override
  State<FmaTrainingModulesView> createState() => _FmaTrainingModulesViewState();
}

class _FmaTrainingModulesViewState extends State<FmaTrainingModulesView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedDifficulty = "all";
  bool showCompletedOnly = false;

  List<Map<String, dynamic>> categories = [
    {
      "label": "All Categories",
      "value": "all",
    },
    {
      "label": "POS System",
      "value": "pos",
    },
    {
      "label": "Customer Service",
      "value": "service",
    },
    {
      "label": "Inventory Management",
      "value": "inventory",
    },
    {
      "label": "Financial Management",
      "value": "finance",
    },
    {
      "label": "Food Safety",
      "value": "safety",
    },
  ];

  List<Map<String, dynamic>> difficulties = [
    {
      "label": "All Levels",
      "value": "all",
    },
    {
      "label": "Beginner",
      "value": "beginner",
    },
    {
      "label": "Intermediate",
      "value": "intermediate",
    },
    {
      "label": "Advanced",
      "value": "advanced",
    },
  ];

  List<Map<String, dynamic>> trainingModules = [
    {
      "id": "1",
      "title": "POS System Fundamentals",
      "description": "Learn the basics of operating the point-of-sale system",
      "category": "pos",
      "difficulty": "beginner",
      "duration": "45 min",
      "progress": 100,
      "isCompleted": true,
      "rating": 4.8,
      "totalLessons": 8,
      "completedLessons": 8,
      "image": "https://picsum.photos/300/200?random=1&keyword=pos",
      "instructor": "Sarah Johnson",
      "enrolledUsers": 245,
    },
    {
      "id": "2",
      "title": "Customer Service Excellence",
      "description": "Master the art of exceptional customer service in F&B",
      "category": "service",
      "difficulty": "intermediate",
      "duration": "60 min",
      "progress": 75,
      "isCompleted": false,
      "rating": 4.9,
      "totalLessons": 10,
      "completedLessons": 7,
      "image": "https://picsum.photos/300/200?random=2&keyword=service",
      "instructor": "Michael Chen",
      "enrolledUsers": 189,
    },
    {
      "id": "3",
      "title": "Inventory Control & Management",
      "description": "Efficient inventory tracking and stock management",
      "category": "inventory",
      "difficulty": "advanced",
      "duration": "90 min",
      "progress": 30,
      "isCompleted": false,
      "rating": 4.7,
      "totalLessons": 12,
      "completedLessons": 4,
      "image": "https://picsum.photos/300/200?random=3&keyword=inventory",
      "instructor": "Emily Rodriguez",
      "enrolledUsers": 156,
    },
    {
      "id": "4",
      "title": "Financial Reporting & Analysis",
      "description": "Understanding sales reports and financial metrics",
      "category": "finance",
      "difficulty": "intermediate",
      "duration": "75 min",
      "progress": 0,
      "isCompleted": false,
      "rating": 4.6,
      "totalLessons": 9,
      "completedLessons": 0,
      "image": "https://picsum.photos/300/200?random=4&keyword=finance",
      "instructor": "David Kim",
      "enrolledUsers": 203,
    },
    {
      "id": "5",
      "title": "Food Safety & Hygiene Standards",
      "description": "Essential food safety protocols and hygiene practices",
      "category": "safety",
      "difficulty": "beginner",
      "duration": "50 min",
      "progress": 100,
      "isCompleted": true,
      "rating": 4.9,
      "totalLessons": 7,
      "completedLessons": 7,
      "image": "https://picsum.photos/300/200?random=5&keyword=safety",
      "instructor": "Lisa Wang",
      "enrolledUsers": 312,
    },
    {
      "id": "6",
      "title": "Advanced POS Features",
      "description": "Master advanced POS functionalities and integrations",
      "category": "pos",
      "difficulty": "advanced",
      "duration": "80 min",
      "progress": 20,
      "isCompleted": false,
      "rating": 4.8,
      "totalLessons": 11,
      "completedLessons": 2,
      "image": "https://picsum.photos/300/200?random=6&keyword=advanced",
      "instructor": "Robert Thompson",
      "enrolledUsers": 127,
    },
  ];

  List<Map<String, dynamic>> get filteredModules {
    return trainingModules.where((module) {
      bool matchesSearch = "${module["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${module["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || module["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "all" || module["difficulty"] == selectedDifficulty;
      bool matchesCompletion = !showCompletedOnly || (module["isCompleted"] as bool);
      
      return matchesSearch && matchesCategory && matchesDifficulty && matchesCompletion;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Training Modules"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            SizedBox(height: spLg),
            _buildStatsOverview(),
            SizedBox(height: spLg),
            _buildCategoryFilter(),
            SizedBox(height: spLg),
            _buildModulesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
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
            "Find Your Training",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search modules...",
            value: searchQuery,
            hint: "Enter module name or keyword",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    int totalModules = trainingModules.length;
    int completedModules = trainingModules.where((m) => m["isCompleted"] as bool).length;
    int inProgressModules = trainingModules.where((m) => !m["isCompleted"] as bool && (m["progress"] as int) > 0).length;
    
    return Container(
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
            "Your Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Modules",
                  "$totalModules",
                  Icons.school,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Completed",
                  "$completedModules",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "In Progress",
                  "$inProgressModules",
                  Icons.schedule,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
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

  Widget _buildCategoryFilter() {
    return QCategoryPicker(
      label: "Filter by Category",
      items: categories,
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildModulesList() {
    List<Map<String, dynamic>> modules = filteredModules;
    
    if (modules.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No modules found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search or filter criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Available Modules (${modules.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortDialog(),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...modules.map((module) => _buildModuleCard(module)).toList(),
      ],
    );
  }

  Widget _buildModuleCard(Map<String, dynamic> module) {
    bool isCompleted = module["isCompleted"] as bool;
    int progress = module["progress"] as int;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Image and Status
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  child: Image.network(
                    "${module["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    isCompleted ? "Completed" : "${progress}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor("${module["difficulty"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${module["difficulty"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Module Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${module["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${module["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Module Info Row
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${module["instructor"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${module["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Progress Bar (if not completed)
                if (!isCompleted) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress: ${module["completedLessons"]}/${module["totalLessons"]} lessons",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${progress}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: progress / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                ],
                
                // Rating and Enrollment Info
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(module["rating"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${module["enrolledUsers"]} enrolled",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: isCompleted ? "Review" : progress > 0 ? "Continue" : "Start",
                      size: bs.sm,
                      onPressed: () => _startModule(module),
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return successColor;
      case 'intermediate':
        return warningColor;
      case 'advanced':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Modules"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Difficulty Level",
              items: difficulties,
              value: selectedDifficulty,
              onChanged: (value, label) {
                selectedDifficulty = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            QSwitch(
              items: [
                {
                  "label": "Show completed only",
                  "value": true,
                  "checked": showCompletedOnly,
                }
              ],
              value: [if (showCompletedOnly) {"label": "Show completed only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showCompletedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sort By"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Title A-Z"),
              onTap: () {
                trainingModules.sort((a, b) => "${a["title"]}".compareTo("${b["title"]}"));
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              title: Text("Progress"),
              onTap: () {
                trainingModules.sort((a, b) => (b["progress"] as int).compareTo(a["progress"] as int));
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              title: Text("Rating"),
              onTap: () {
                trainingModules.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startModule(Map<String, dynamic> module) {
    // Navigate to module detail or learning view
    ss("Starting module: ${module["title"]}");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial4View extends StatefulWidget {
  @override
  State<GrlTutorial4View> createState() => _GrlTutorial4ViewState();
}

class _GrlTutorial4ViewState extends State<GrlTutorial4View> {
  int selectedTutorial = 0;

  List<Map<String, dynamic>> tutorials = [
    {
      "category": "Getting Started",
      "title": "Basic Navigation",
      "description": "Learn how to navigate through the app and access key features",
      "duration": "5 min",
      "difficulty": "Beginner",
      "icon": Icons.navigation,
      "color": primaryColor,
      "completed": true,
      "steps": [
        "Understanding the main menu",
        "Using the navigation drawer",
        "Quick access shortcuts",
        "Search functionality",
      ],
    },
    {
      "category": "Getting Started",
      "title": "Account Setup",
      "description": "Set up your profile and customize your preferences",
      "duration": "8 min",
      "difficulty": "Beginner",
      "icon": Icons.person_add,
      "color": successColor,
      "completed": true,
      "steps": [
        "Creating your profile",
        "Adding profile picture",
        "Setting preferences",
        "Privacy settings",
      ],
    },
    {
      "category": "Core Features",
      "title": "Dashboard Overview",
      "description": "Explore the dashboard and understand key metrics",
      "duration": "10 min",
      "difficulty": "Intermediate",
      "icon": Icons.dashboard,
      "color": infoColor,
      "completed": false,
      "steps": [
        "Dashboard layout",
        "Widget customization",
        "Data visualization",
        "Real-time updates",
      ],
    },
    {
      "category": "Core Features",
      "title": "Data Management",
      "description": "Learn how to create, edit, and organize your data",
      "duration": "15 min",
      "difficulty": "Intermediate",
      "icon": Icons.storage,
      "color": warningColor,
      "completed": false,
      "steps": [
        "Creating new entries",
        "Importing data",
        "Data organization",
        "Backup and sync",
      ],
    },
    {
      "category": "Advanced",
      "title": "Automation & Workflows",
      "description": "Set up automated processes and custom workflows",
      "duration": "20 min",
      "difficulty": "Advanced",
      "icon": Icons.auto_awesome,
      "color": primaryColor,
      "completed": false,
      "steps": [
        "Creating workflows",
        "Setting up triggers",
        "Conditional logic",
        "Testing automation",
      ],
    },
    {
      "category": "Advanced",
      "title": "Analytics & Reporting",
      "description": "Generate insights and create custom reports",
      "duration": "18 min",
      "difficulty": "Advanced",
      "icon": Icons.analytics,
      "color": dangerColor,
      "completed": false,
      "steps": [
        "Creating reports",
        "Custom metrics",
        "Data filters",
        "Scheduled reports",
      ],
    },
    {
      "category": "Integration",
      "title": "Third-party Integrations",
      "description": "Connect with external tools and services",
      "duration": "12 min",
      "difficulty": "Intermediate",
      "icon": Icons.extension,
      "color": successColor,
      "completed": false,
      "steps": [
        "Available integrations",
        "API setup",
        "Data synchronization",
        "Troubleshooting",
      ],
    },
    {
      "category": "Integration",
      "title": "Mobile App Features",
      "description": "Discover mobile-specific features and capabilities",
      "duration": "7 min",
      "difficulty": "Beginner",
      "icon": Icons.phone_android,
      "color": infoColor,
      "completed": false,
      "steps": [
        "Mobile navigation",
        "Offline capabilities",
        "Push notifications",
        "Mobile shortcuts",
      ],
    },
  ];

  String selectedCategory = "All";
  List<String> categories = ["All", "Getting Started", "Core Features", "Advanced", "Integration"];

  List<Map<String, dynamic>> get filteredTutorials {
    if (selectedCategory == "All") {
      return tutorials;
    }
    return tutorials.where((tutorial) => tutorial["category"] == selectedCategory).toList();
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
        return primaryColor;
    }
  }

  void _startTutorial(int index) {
    final tutorial = filteredTutorials[index];
    si("Starting tutorial: ${tutorial["title"]}");
    // Navigate to tutorial content or start interactive tutorial
  }

  int get completedCount => tutorials.where((t) => t["completed"] == true).length;
  double get progressPercentage => completedCount / tutorials.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Tutorials"),
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withAlpha(30),
                  primaryColor.withAlpha(10),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXl),
                      ),
                      child: Icon(
                        Icons.school,
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Learning Progress",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "$completedCount of ${tutorials.length} tutorials completed",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${(progressPercentage * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                LinearProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Tutorial List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredTutorials.length,
              itemBuilder: (context, index) {
                final tutorial = filteredTutorials[index];
                final isCompleted = tutorial["completed"] as bool;
                final difficultyColor = _getDifficultyColor(tutorial["difficulty"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isCompleted ? successColor.withAlpha(50) : disabledColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Tutorial Header
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (tutorial["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                tutorial["icon"] as IconData,
                                color: tutorial["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${tutorial["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (isCompleted)
                                        Icon(
                                          Icons.check_circle,
                                          color: successColor,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${tutorial["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: difficultyColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXl),
                                        ),
                                        child: Text(
                                          "${tutorial["difficulty"]}",
                                          style: TextStyle(
                                            color: difficultyColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.schedule,
                                        color: disabledBoldColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tutorial["duration"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tutorial Steps
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (tutorial["color"] as Color).withAlpha(5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusLg),
                            bottomRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "What you'll learn:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: tutorial["color"] as Color,
                                fontSize: 14,
                              ),
                            ),
                            Wrap(
                              spacing: spSm,
                              runSpacing: spXs,
                              children: (tutorial["steps"] as List<String>)
                                  .take(2) // Show only first 2 steps
                                  .map((step) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          border: Border.all(
                                            color: (tutorial["color"] as Color).withAlpha(30),
                                          ),
                                        ),
                                        child: Text(
                                          step,
                                          style: TextStyle(
                                            color: tutorial["color"] as Color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            if ((tutorial["steps"] as List).length > 2)
                              Text(
                                "+${(tutorial["steps"] as List).length - 2} more topics",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: isCompleted ? "Review Tutorial" : "Start Tutorial",
                                size: bs.sm,
                                icon: isCompleted ? Icons.replay : Icons.play_arrow,
                                onPressed: () => _startTutorial(index),
                              ),
                            ),
                          ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          si("Opening tutorial suggestions based on your progress");
        },
        icon: Icon(Icons.lightbulb_outline),
        label: Text("Get Recommendations"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTutorialsView extends StatefulWidget {
  const TpmTutorialsView({super.key});

  @override
  State<TpmTutorialsView> createState() => _TpmTutorialsViewState();
}

class _TpmTutorialsViewState extends State<TpmTutorialsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<String> categories = [
    "All",
    "Getting Started",
    "Project Management",
    "Team Collaboration",
    "Advanced Features",
    "Integrations",
  ];

  List<Map<String, dynamic>> tutorials = [
    {
      "id": "1",
      "title": "Getting Started with Task Management",
      "description": "Learn the fundamentals of creating and managing tasks effectively",
      "category": "Getting Started",
      "duration": "8 min",
      "difficulty": "Beginner",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=tutorial",
      "views": 2847,
      "rating": 4.8,
      "is_completed": true,
      "published_date": "2024-01-15",
    },
    {
      "id": "2",
      "title": "Creating Project Templates",
      "description": "Save time by creating reusable project templates for your team",
      "category": "Project Management",
      "duration": "12 min",
      "difficulty": "Intermediate",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=project",
      "views": 1923,
      "rating": 4.7,
      "is_completed": false,
      "published_date": "2024-01-20",
    },
    {
      "id": "3",
      "title": "Team Collaboration Best Practices",
      "description": "Enhance your team's productivity with proven collaboration strategies",
      "category": "Team Collaboration",
      "duration": "15 min",
      "difficulty": "Intermediate",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=collaboration",
      "views": 1654,
      "rating": 4.9,
      "is_completed": false,
      "published_date": "2024-01-25",
    },
    {
      "id": "4",
      "title": "Advanced Reporting Techniques",
      "description": "Create comprehensive reports and analytics for stakeholder presentations",
      "category": "Advanced Features",
      "duration": "20 min",
      "difficulty": "Advanced",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=analytics",
      "views": 987,
      "rating": 4.6,
      "is_completed": false,
      "published_date": "2024-02-01",
    },
    {
      "id": "5",
      "title": "Slack Integration Setup",
      "description": "Connect your workspace with Slack for seamless communication",
      "category": "Integrations",
      "duration": "10 min",
      "difficulty": "Beginner",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=slack",
      "views": 1432,
      "rating": 4.5,
      "is_completed": true,
      "published_date": "2024-02-05",
    },
    {
      "id": "6",
      "title": "Automating Workflow Processes",
      "description": "Set up automated workflows to streamline your project management",
      "category": "Advanced Features",
      "duration": "18 min",
      "difficulty": "Advanced",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=automation",
      "views": 756,
      "rating": 4.7,
      "is_completed": false,
      "published_date": "2024-02-10",
    },
  ];

  List<Map<String, dynamic>> get filteredTutorials {
    return tutorials.where((tutorial) {
      bool matchesCategory = selectedCategory == "All" || tutorial["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (tutorial["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
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
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorials"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
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
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Video Tutorials",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Master every feature with our comprehensive video guides",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
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
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${tutorials.length} tutorials",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${tutorials.where((t) => t["is_completed"] == true).length} completed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            QTextField(
              label: "Search tutorials...",
              value: searchQuery,
              hint: "What would you like to learn?",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Tutorials List
            Row(
              children: [
                Text(
                  "Tutorials",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTutorials.length} results",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            
            Column(
              spacing: spMd,
              children: filteredTutorials.map((tutorial) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${tutorial["thumbnail"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(tutorial["difficulty"] as String),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${tutorial["difficulty"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${tutorial["duration"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          if (tutorial["is_completed"] == true)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      // Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tutorial["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${tutorial["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(tutorial["views"] as int)} views",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tutorial["rating"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${tutorial["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: tutorial["is_completed"] == true ? "Watch Again" : "Start Tutorial",
                                size: bs.sm,
                                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}

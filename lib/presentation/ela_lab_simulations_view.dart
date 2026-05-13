import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLabSimulationsView extends StatefulWidget {
  const ElaLabSimulationsView({super.key});

  @override
  State<ElaLabSimulationsView> createState() => _ElaLabSimulationsViewState();
}

class _ElaLabSimulationsViewState extends State<ElaLabSimulationsView> {
  String selectedCategory = "Physics";
  String selectedDifficulty = "Beginner";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "Earth Science", "value": "Earth Science"},
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> simulations = [
    {
      "title": "Pendulum Motion",
      "category": "Physics",
      "difficulty": "Beginner",
      "duration": 15,
      "completed": true,
      "rating": 4.8,
      "participants": 1250,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=pendulum",
      "description": "Explore the physics of pendulum motion and oscillations",
      "objectives": ["Understand period and frequency", "Analyze energy transfer", "Study damping effects"],
    },
    {
      "title": "Chemical Reactions",
      "category": "Chemistry",
      "difficulty": "Intermediate",
      "duration": 25,
      "completed": false,
      "rating": 4.6,
      "participants": 890,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=chemistry",
      "description": "Simulate various chemical reactions and molecular interactions",
      "objectives": ["Study reaction rates", "Balance equations", "Observe product formation"],
    },
    {
      "title": "DNA Replication",
      "category": "Biology",
      "difficulty": "Advanced",
      "duration": 30,
      "completed": false,
      "rating": 4.9,
      "participants": 675,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=dna",
      "description": "Step-by-step simulation of DNA replication process",
      "objectives": ["Understand helicase function", "Learn about DNA polymerase", "Study error correction"],
    },
    {
      "title": "Weather Systems",
      "category": "Earth Science",
      "difficulty": "Intermediate",
      "duration": 20,
      "completed": true,
      "rating": 4.5,
      "participants": 1100,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=weather",
      "description": "Simulate weather patterns and atmospheric phenomena",
      "objectives": ["Study pressure systems", "Understand cloud formation", "Track storm development"],
    },
    {
      "title": "Circuit Analysis",
      "category": "Physics",
      "difficulty": "Advanced",
      "duration": 35,
      "completed": false,
      "rating": 4.7,
      "participants": 780,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=circuit",
      "description": "Analyze electrical circuits and component behavior",
      "objectives": ["Apply Ohm's law", "Study parallel/series circuits", "Measure voltage and current"],
    },
    {
      "title": "Photosynthesis",
      "category": "Biology",
      "difficulty": "Beginner",
      "duration": 18,
      "completed": true,
      "rating": 4.4,
      "participants": 1500,
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=photosynthesis",
      "description": "Explore the process of photosynthesis in plants",
      "objectives": ["Understand light reactions", "Study Calvin cycle", "Analyze glucose production"],
    },
  ];

  List<Map<String, dynamic>> get filteredSimulations {
    return simulations.where((simulation) {
      bool categoryMatch = selectedCategory == "All" || simulation["category"] == selectedCategory;
      bool difficultyMatch = selectedDifficulty == "All" || simulation["difficulty"] == selectedDifficulty;
      return categoryMatch && difficultyMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Simulations"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to saved simulations
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.science,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Virtual Laboratory",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Conduct experiments safely in virtual environment",
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

            // Filter Section
            Container(
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
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
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

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredSimulations.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${simulations.where((s) => s["completed"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((simulations.map((s) => s["rating"] as double).reduce((a, b) => a + b)) / simulations.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Rating",
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

            // Simulations Grid
            Text(
              "Available Simulations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredSimulations.map((simulation) {
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
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusMd),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${simulation["thumbnail"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: simulation["completed"] == true
                                    ? successColor
                                    : warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                simulation["completed"] == true
                                    ? "Completed"
                                    : "${simulation["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${simulation["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${simulation["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${simulation["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${simulation["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${simulation["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${simulation["participants"]} users",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: simulation["completed"] == true
                                    ? "Review Results"
                                    : "Start Simulation",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to simulation
                                },
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

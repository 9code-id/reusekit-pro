import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWorkoutHistoryView extends StatefulWidget {
  const FwaWorkoutHistoryView({super.key});

  @override
  State<FwaWorkoutHistoryView> createState() => _FwaWorkoutHistoryViewState();
}

class _FwaWorkoutHistoryViewState extends State<FwaWorkoutHistoryView> {
  List<Map<String, dynamic>> workoutHistory = [
    {
      "id": 1,
      "date": "2024-03-15",
      "title": "Upper Body Strength",
      "duration": 45,
      "calories": 320,
      "exercises": 6,
      "completedSets": 18,
      "totalSets": 18,
      "type": "Strength",
      "difficulty": "Intermediate",
      "rating": 4,
      "notes": "Great workout! Felt strong today.",
      "exerciseList": [
        {"name": "Push-ups", "sets": 3, "reps": [15, 12, 10]},
        {"name": "Pull-ups", "sets": 3, "reps": [8, 6, 5]},
        {"name": "Dips", "sets": 3, "reps": [12, 10, 8]},
        {"name": "Pike Push-ups", "sets": 3, "reps": [10, 8, 6]},
        {"name": "Plank", "sets": 3, "reps": ["60s", "45s", "30s"]},
        {"name": "Mountain Climbers", "sets": 3, "reps": ["30s", "30s", "25s"]}
      ]
    },
    {
      "id": 2,
      "date": "2024-03-13",
      "title": "HIIT Cardio Blast",
      "duration": 25,
      "calories": 280,
      "exercises": 4,
      "completedSets": 12,
      "totalSets": 12,
      "type": "HIIT",
      "difficulty": "Advanced",
      "rating": 5,
      "notes": "Intense session! Heart rate was up the whole time.",
      "exerciseList": [
        {"name": "Burpees", "sets": 3, "reps": [10, 8, 6]},
        {"name": "Jump Squats", "sets": 3, "reps": [15, 12, 10]},
        {"name": "High Knees", "sets": 3, "reps": ["30s", "30s", "20s"]},
        {"name": "Mountain Climbers", "sets": 3, "reps": ["30s", "25s", "20s"]}
      ]
    },
    {
      "id": 3,
      "date": "2024-03-11",
      "title": "Lower Body Power",
      "duration": 50,
      "calories": 380,
      "exercises": 5,
      "completedSets": 15,
      "totalSets": 15,
      "type": "Strength",
      "difficulty": "Advanced",
      "rating": 4,
      "notes": "Legs are shaking! Good workout.",
      "exerciseList": [
        {"name": "Squats", "sets": 3, "reps": [20, 18, 15]},
        {"name": "Lunges", "sets": 3, "reps": [12, 10, 8]},
        {"name": "Calf Raises", "sets": 3, "reps": [25, 20, 15]},
        {"name": "Wall Sit", "sets": 3, "reps": ["60s", "45s", "30s"]},
        {"name": "Single Leg Deadlifts", "sets": 3, "reps": [10, 8, 6]}
      ]
    },
    {
      "id": 4,
      "date": "2024-03-09",
      "title": "Full Body Circuit",
      "duration": 35,
      "calories": 250,
      "exercises": 8,
      "completedSets": 16,
      "totalSets": 20,
      "type": "Circuit",
      "difficulty": "Intermediate",
      "rating": 3,
      "notes": "Couldn't finish all sets. Need more practice.",
      "exerciseList": [
        {"name": "Push-ups", "sets": 2, "reps": [10, 8]},
        {"name": "Squats", "sets": 3, "reps": [15, 12, 10]},
        {"name": "Plank", "sets": 2, "reps": ["45s", "30s"]},
        {"name": "Jumping Jacks", "sets": 3, "reps": ["30s", "30s", "20s"]},
        {"name": "Lunges", "sets": 2, "reps": [8, 6]},
        {"name": "Tricep Dips", "sets": 2, "reps": [8, 6]},
        {"name": "High Knees", "sets": 2, "reps": ["20s", "15s"]},
        {"name": "Bicycle Crunches", "sets": 0, "reps": []}
      ]
    },
    {
      "id": 5,
      "date": "2024-03-07",
      "title": "Yoga Flow",
      "duration": 30,
      "calories": 120,
      "exercises": 10,
      "completedSets": 10,
      "totalSets": 10,
      "type": "Yoga",
      "difficulty": "Beginner",
      "rating": 5,
      "notes": "Very relaxing and peaceful session.",
      "exerciseList": [
        {"name": "Sun Salutation", "sets": 1, "reps": ["3 rounds"]},
        {"name": "Warrior I", "sets": 1, "reps": ["30s each side"]},
        {"name": "Warrior II", "sets": 1, "reps": ["30s each side"]},
        {"name": "Triangle Pose", "sets": 1, "reps": ["30s each side"]},
        {"name": "Tree Pose", "sets": 1, "reps": ["30s each side"]},
        {"name": "Downward Dog", "sets": 1, "reps": ["60s"]},
        {"name": "Child's Pose", "sets": 1, "reps": ["60s"]},
        {"name": "Cat-Cow", "sets": 1, "reps": ["10 rounds"]},
        {"name": "Seated Twist", "sets": 1, "reps": ["30s each side"]},
        {"name": "Savasana", "sets": 1, "reps": ["5 minutes"]}
      ]
    }
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Strength", "Cardio", "HIIT", "Yoga", "Circuit"];
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = workoutHistory;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((workout) {
        return workout["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               workout["notes"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedFilter != "All") {
      filtered = filtered.where((workout) => workout["type"] == selectedFilter).toList();
    }

    return filtered;
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "Strength":
        return primaryColor;
      case "Cardio":
        return dangerColor;
      case "HIIT":
        return warningColor;
      case "Yoga":
        return successColor;
      case "Circuit":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout History"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo('Workout Analytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search workouts...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),

            // Filter Options
            Container(
              width: double.infinity,
              child: QCategoryPicker(
                items: filterOptions.map((option) => {
                  "label": option,
                  "value": option,
                }).toList(),
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),

            // Quick Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "This Month's Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${workoutHistory.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Workouts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${workoutHistory.fold(0, (sum, workout) => sum + (workout["duration"] as int))}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Minutes Trained",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${workoutHistory.fold(0, (sum, workout) => sum + (workout["calories"] as int))}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "Calories Burned",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${(workoutHistory.fold(0.0, (sum, workout) => sum + (workout["rating"] as int)) / workoutHistory.length).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 24,
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
                    ],
                  ),
                ],
              ),
            ),

            // Workout History List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Workout History (${filteredHistory.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('Export History')
                        },
                        child: Text(
                          "Export",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredHistory.map((workout) {
                      double completionRate = (workout["completedSets"] as int) / (workout["totalSets"] as int);
                      Color typeColor = getTypeColor(workout["type"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: typeColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${workout["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        formatDate(workout["date"]),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: typeColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${workout["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 200,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.timer, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${workout["duration"]} min",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.local_fire_department, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${workout["calories"]} cal",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.fitness_center, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${workout["exercises"]} exercises",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle, size: 16, color: successColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${workout["completedSets"]}/${workout["totalSets"]} sets",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Rating
                            Row(
                              children: [
                                Text(
                                  "Rating: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (workout["rating"] as int) ? Icons.star : Icons.star_border,
                                      size: 16,
                                      color: warningColor,
                                    );
                                  }),
                                ),
                                Spacer(),
                                Text(
                                  "${(completionRate * 100).toInt()}% completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: completionRate == 1.0 ? successColor : warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            // Progress Bar
                            LinearProgressIndicator(
                              value: completionRate,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                completionRate == 1.0 ? successColor : warningColor
                              ),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),

                            // Notes
                            if (workout["notes"].toString().isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.note, color: infoColor, size: 16),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${workout["notes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Actions
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo('Workout Detail', workout)
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: QButton(
                                    label: "Repeat Workout",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo('Start Workout', workout)
                                    },
                                  ),
                                ),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Workout shared successfully");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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

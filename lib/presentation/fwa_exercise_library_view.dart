import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaExerciseLibraryView extends StatefulWidget {
  const FwaExerciseLibraryView({super.key});

  @override
  State<FwaExerciseLibraryView> createState() => _FwaExerciseLibraryViewState();
}

class _FwaExerciseLibraryViewState extends State<FwaExerciseLibraryView> {
  List<Map<String, dynamic>> exercises = [
    {
      "id": 1,
      "name": "Push-ups",
      "category": "Chest",
      "difficulty": "Beginner",
      "equipment": "Bodyweight",
      "duration": "30 seconds",
      "calories": 12,
      "description": "Classic upper body exercise targeting chest, shoulders, and triceps",
      "image": "https://picsum.photos/300/200?random=1&keyword=pushup",
      "targetMuscles": ["Chest", "Shoulders", "Triceps"],
      "instructions": [
        "Start in plank position",
        "Lower body to the ground",
        "Push back up to starting position",
        "Keep core engaged throughout"
      ],
      "isFavorite": true,
      "rating": 4.5,
      "sets": 3,
      "reps": "10-15"
    },
    {
      "id": 2,
      "name": "Squats",
      "category": "Legs",
      "difficulty": "Beginner",
      "equipment": "Bodyweight",
      "duration": "45 seconds",
      "calories": 15,
      "description": "Fundamental lower body exercise for building leg and glute strength",
      "image": "https://picsum.photos/300/200?random=2&keyword=squat",
      "targetMuscles": ["Quadriceps", "Glutes", "Hamstrings"],
      "instructions": [
        "Stand with feet shoulder-width apart",
        "Lower down as if sitting in a chair",
        "Keep chest up and knees behind toes",
        "Return to standing position"
      ],
      "isFavorite": false,
      "rating": 4.8,
      "sets": 3,
      "reps": "12-20"
    },
    {
      "id": 3,
      "name": "Plank",
      "category": "Core",
      "difficulty": "Beginner",
      "equipment": "Bodyweight",
      "duration": "60 seconds",
      "calories": 8,
      "description": "Core stability exercise that strengthens the entire midsection",
      "image": "https://picsum.photos/300/200?random=3&keyword=plank",
      "targetMuscles": ["Core", "Shoulders", "Back"],
      "instructions": [
        "Start in push-up position",
        "Hold position on forearms",
        "Keep body in straight line",
        "Engage core muscles"
      ],
      "isFavorite": true,
      "rating": 4.3,
      "sets": 3,
      "reps": "30-60 sec"
    },
    {
      "id": 4,
      "name": "Burpees",
      "category": "Full Body",
      "difficulty": "Advanced",
      "equipment": "Bodyweight",
      "duration": "30 seconds",
      "calories": 20,
      "description": "High-intensity full body exercise combining squat, plank, and jump",
      "image": "https://picsum.photos/300/200?random=4&keyword=burpee",
      "targetMuscles": ["Full Body", "Cardio"],
      "instructions": [
        "Start standing, drop to squat",
        "Jump back to plank position",
        "Do a push-up",
        "Jump feet back to squat, then jump up"
      ],
      "isFavorite": false,
      "rating": 4.2,
      "sets": 3,
      "reps": "5-10"
    },
    {
      "id": 5,
      "name": "Lunges",
      "category": "Legs",
      "difficulty": "Intermediate",
      "equipment": "Bodyweight",
      "duration": "40 seconds",
      "calories": 12,
      "description": "Unilateral leg exercise improving balance and leg strength",
      "image": "https://picsum.photos/300/200?random=5&keyword=lunge",
      "targetMuscles": ["Quadriceps", "Glutes", "Calves"],
      "instructions": [
        "Step forward with one leg",
        "Lower hips until both knees are 90°",
        "Keep front knee over ankle",
        "Return to starting position"
      ],
      "isFavorite": true,
      "rating": 4.4,
      "sets": 3,
      "reps": "10-12 each leg"
    },
    {
      "id": 6,
      "name": "Mountain Climbers",
      "category": "Cardio",
      "difficulty": "Intermediate",
      "equipment": "Bodyweight",
      "duration": "30 seconds",
      "calories": 18,
      "description": "Dynamic cardio exercise that also targets core muscles",
      "image": "https://picsum.photos/300/200?random=6&keyword=mountain",
      "targetMuscles": ["Core", "Cardio", "Shoulders"],
      "instructions": [
        "Start in plank position",
        "Bring one knee to chest",
        "Quickly switch legs",
        "Keep core engaged and move fast"
      ],
      "isFavorite": false,
      "rating": 4.0,
      "sets": 3,
      "reps": "20-30 sec"
    }
  ];

  List<String> categories = ["All", "Chest", "Legs", "Core", "Full Body", "Cardio", "Back", "Arms"];
  List<String> difficulties = ["All", "Beginner", "Intermediate", "Advanced"];
  List<String> equipments = ["All", "Bodyweight", "Dumbbells", "Resistance Bands", "Barbell"];

  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String selectedEquipment = "All";
  String searchQuery = "";
  bool showFavoritesOnly = false;

  List<Map<String, dynamic>> get filteredExercises {
    List<Map<String, dynamic>> filtered = exercises;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((exercise) {
        return exercise["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               exercise["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedCategory != "All") {
      filtered = filtered.where((exercise) => exercise["category"] == selectedCategory).toList();
    }

    if (selectedDifficulty != "All") {
      filtered = filtered.where((exercise) => exercise["difficulty"] == selectedDifficulty).toList();
    }

    if (selectedEquipment != "All") {
      filtered = filtered.where((exercise) => exercise["equipment"] == selectedEquipment).toList();
    }

    if (showFavoritesOnly) {
      filtered = filtered.where((exercise) => exercise["isFavorite"] == true).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Library"),
        actions: [
          IconButton(
            icon: Icon(
              showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: showFavoritesOnly ? dangerColor : null,
            ),
            onPressed: () {
              showFavoritesOnly = !showFavoritesOnly;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search exercises...",
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

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Difficulty",
                          items: difficulties.map((difficulty) => {
                            "label": difficulty,
                            "value": difficulty,
                          }).toList(),
                          value: selectedDifficulty,
                          onChanged: (value, label) {
                            selectedDifficulty = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Equipment",
                          items: equipments.map((equipment) => {
                            "label": equipment,
                            "value": equipment,
                          }).toList(),
                          value: selectedEquipment,
                          onChanged: (value, label) {
                            selectedEquipment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              child: Text(
                "${filteredExercises.length} exercises found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Exercise List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredExercises.map((exercise) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              child: Image.network(
                                "${exercise["image"]}",
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                exercise["isFavorite"] = !exercise["isFavorite"];
                                setState(() {});
                                if (exercise["isFavorite"]) {
                                  ss("Added to favorites");
                                } else {
                                  si("Removed from favorites");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  exercise["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                  color: exercise["isFavorite"] ? dangerColor : disabledBoldColor,
                                  size: 20,
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
                                color: exercise["difficulty"] == "Beginner" ? successColor :
                                      exercise["difficulty"] == "Intermediate" ? warningColor :
                                      dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${exercise["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${exercise["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${exercise["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${exercise["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${exercise["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.local_fire_department, size: 14, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${exercise["calories"]} cal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.fitness_center, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${exercise["equipment"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 14, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${exercise["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (exercise["targetMuscles"] != null)
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (exercise["targetMuscles"] as List).take(3).map((muscle) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$muscle",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList().cast<Widget>(),
                              ),
                            SizedBox(height: spXs),
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo('Exercise Detail', exercise)
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: QButton(
                                    label: "Add to Plan",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Exercise added to your workout plan");
                                    },
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}

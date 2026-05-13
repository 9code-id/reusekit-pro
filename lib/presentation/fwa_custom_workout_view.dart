import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaCustomWorkoutView extends StatefulWidget {
  const FwaCustomWorkoutView({Key? key}) : super(key: key);

  @override
  State<FwaCustomWorkoutView> createState() => _FwaCustomWorkoutViewState();
}

class _FwaCustomWorkoutViewState extends State<FwaCustomWorkoutView> {
  String workoutName = "";
  String workoutDescription = "";
  String selectedCategory = "Strength";
  String selectedDifficulty = "Beginner";
  String estimatedDuration = "30";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Strength", "value": "Strength"},
    {"label": "Cardio", "value": "Cardio"},
    {"label": "HIIT", "value": "HIIT"},
    {"label": "Yoga", "value": "Yoga"},
    {"label": "Pilates", "value": "Pilates"},
    {"label": "Stretching", "value": "Stretching"},
    {"label": "Mixed", "value": "Mixed"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> selectedExercises = [];

  List<Map<String, dynamic>> availableExercises = [
    {
      "id": 1,
      "name": "Push-ups",
      "category": "Strength",
      "targetMuscle": "Chest, Arms",
      "equipment": "No Equipment",
      "difficulty": "Beginner",
      "caloriesPerMinute": 8,
      "instructions": "Start in plank position, lower body to floor, push back up",
      "image": "https://picsum.photos/150/100?random=1&keyword=pushup"
    },
    {
      "id": 2,
      "name": "Squats",
      "category": "Strength",
      "targetMuscle": "Legs, Glutes",
      "equipment": "No Equipment",
      "difficulty": "Beginner",
      "caloriesPerMinute": 10,
      "instructions": "Stand with feet shoulder-width apart, lower hips back and down",
      "image": "https://picsum.photos/150/100?random=2&keyword=squat"
    },
    {
      "id": 3,
      "name": "Burpees",
      "category": "HIIT",
      "targetMuscle": "Full Body",
      "equipment": "No Equipment",
      "difficulty": "Advanced",
      "caloriesPerMinute": 15,
      "instructions": "Squat, jump back to plank, push-up, jump feet forward, jump up",
      "image": "https://picsum.photos/150/100?random=3&keyword=burpee"
    },
    {
      "id": 4,
      "name": "Plank",
      "category": "Strength",
      "targetMuscle": "Core",
      "equipment": "No Equipment",
      "difficulty": "Intermediate",
      "caloriesPerMinute": 6,
      "instructions": "Hold push-up position with forearms on ground",
      "image": "https://picsum.photos/150/100?random=4&keyword=plank"
    },
    {
      "id": 5,
      "name": "Jumping Jacks",
      "category": "Cardio",
      "targetMuscle": "Full Body",
      "equipment": "No Equipment",
      "difficulty": "Beginner",
      "caloriesPerMinute": 12,
      "instructions": "Jump feet apart while raising arms overhead, return to start",
      "image": "https://picsum.photos/150/100?random=5&keyword=jumping"
    },
    {
      "id": 6,
      "name": "Mountain Climbers",
      "category": "HIIT",
      "targetMuscle": "Core, Legs",
      "equipment": "No Equipment",
      "difficulty": "Intermediate",
      "caloriesPerMinute": 14,
      "instructions": "In plank position, alternate bringing knees to chest rapidly",
      "image": "https://picsum.photos/150/100?random=6&keyword=mountain"
    },
    {
      "id": 7,
      "name": "Lunges",
      "category": "Strength",
      "targetMuscle": "Legs, Glutes",
      "equipment": "No Equipment",
      "difficulty": "Beginner",
      "caloriesPerMinute": 9,
      "instructions": "Step forward, lower hips until both knees bent at 90 degrees",
      "image": "https://picsum.photos/150/100?random=7&keyword=lunge"
    },
    {
      "id": 8,
      "name": "High Knees",
      "category": "Cardio",
      "targetMuscle": "Legs, Core",
      "equipment": "No Equipment",
      "difficulty": "Beginner",
      "caloriesPerMinute": 11,
      "instructions": "Run in place lifting knees as high as possible",
      "image": "https://picsum.photos/150/100?random=8&keyword=knees"
    },
  ];

  String searchQuery = "";
  String filterCategory = "All";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredExercises = _getFilteredExercises();
    int totalCalories = _calculateTotalCalories();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Custom Workout"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveWorkout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout Basic Info
            Text(
              "Workout Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QTextField(
              label: "Workout Name",
              value: workoutName,
              hint: "Enter workout name",
              onChanged: (value) {
                workoutName = value;
                setState(() {});
              },
            ),

            QTextField(
              label: "Description",
              value: workoutDescription,
              hint: "Describe your workout",
              onChanged: (value) {
                workoutDescription = value;
                setState(() {});
              },
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
                    label: "Difficulty",
                    items: difficultyOptions,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QNumberField(
              label: "Estimated Duration (minutes)",
              value: estimatedDuration,
              onChanged: (value) {
                estimatedDuration = value;
                setState(() {});
              },
            ),

            // Selected Exercises Summary
            if (selectedExercises.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selected Exercises (${selectedExercises.length})",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "~$totalCalories cal",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: selectedExercises.map((exercise) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${exercise["name"]} - ${exercise["sets"]}x${exercise["reps"]}${exercise["duration"] != null ? " (${exercise["duration"]}s)" : ""}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectedExercises.remove(exercise);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.remove_circle,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Exercise Search and Filter
            Text(
              "Add Exercises",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search exercises",
                    value: searchQuery,
                    hint: "Find exercises...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by category",
                    items: [
                      {"label": "All", "value": "All"},
                      ...categoryOptions,
                    ],
                    value: filterCategory,
                    onChanged: (value, label) {
                      filterCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Available Exercises List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredExercises.map((exercise) {
                bool isSelected = selectedExercises.any((selected) => selected["id"] == exercise["id"]);
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(color: successColor, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${exercise["image"]}",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor("${exercise["difficulty"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${exercise["difficulty"]}",
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
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${exercise["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${exercise["targetMuscle"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${exercise["equipment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${exercise["caloriesPerMinute"]} cal/min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${exercise["instructions"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: isSelected ? "Configure" : "Add Exercise",
                                size: bs.sm,
                                onPressed: () {
                                  if (isSelected) {
                                    _configureExercise(exercise);
                                  } else {
                                    _addExercise(exercise);
                                  }
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

            if (filteredExercises.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No exercises found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Create Workout Button
            if (selectedExercises.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Workout",
                  size: bs.md,
                  onPressed: () {
                    _saveWorkout();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredExercises() {
    return availableExercises.where((exercise) {
      bool matchesSearch = searchQuery.isEmpty || 
          (exercise["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (exercise["targetMuscle"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = filterCategory == "All" || exercise["category"] == filterCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  int _calculateTotalCalories() {
    int total = 0;
    for (var exercise in selectedExercises) {
      int duration = exercise["duration"] ?? (exercise["sets"] * exercise["reps"] * 3); // Estimate 3 seconds per rep
      int caloriesPerMinute = exercise["caloriesPerMinute"] ?? 8;
      total += ((duration / 60) * caloriesPerMinute).round();
    }
    return total;
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

  void _addExercise(Map<String, dynamic> exercise) {
    showDialog(
      context: context,
      builder: (context) {
        String sets = "3";
        String reps = "12";
        String duration = "";
        
        return AlertDialog(
          title: Text("Add ${exercise["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              if (exercise["category"] != "Cardio") ...[
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Sets",
                        value: sets,
                        onChanged: (value) => sets = value,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Reps",
                        value: reps,
                        onChanged: (value) => reps = value,
                      ),
                    ),
                  ],
                ),
              ],
              QNumberField(
                label: exercise["category"] == "Cardio" ? "Duration (seconds)" : "Rest between sets (seconds)",
                value: duration,
                hint: exercise["category"] == "Cardio" ? "60" : "30",
                onChanged: (value) => duration = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Map<String, dynamic> exerciseConfig = Map.from(exercise);
                exerciseConfig["sets"] = int.tryParse(sets) ?? 3;
                exerciseConfig["reps"] = int.tryParse(reps) ?? 12;
                if (duration.isNotEmpty) {
                  exerciseConfig["duration"] = int.tryParse(duration) ?? 60;
                }
                
                selectedExercises.add(exerciseConfig);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _configureExercise(Map<String, dynamic> exercise) {
    int exerciseIndex = selectedExercises.indexWhere((e) => e["id"] == exercise["id"]);
    if (exerciseIndex == -1) return;
    
    Map<String, dynamic> current = selectedExercises[exerciseIndex];
    
    showDialog(
      context: context,
      builder: (context) {
        String sets = "${current["sets"] ?? 3}";
        String reps = "${current["reps"] ?? 12}";
        String duration = "${current["duration"] ?? ""}";
        
        return AlertDialog(
          title: Text("Configure ${exercise["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              if (exercise["category"] != "Cardio") ...[
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Sets",
                        value: sets,
                        onChanged: (value) => sets = value,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Reps",
                        value: reps,
                        onChanged: (value) => reps = value,
                      ),
                    ),
                  ],
                ),
              ],
              QNumberField(
                label: exercise["category"] == "Cardio" ? "Duration (seconds)" : "Rest between sets (seconds)",
                value: duration,
                onChanged: (value) => duration = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedExercises.removeAt(exerciseIndex);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Remove", style: TextStyle(color: dangerColor)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                selectedExercises[exerciseIndex]["sets"] = int.tryParse(sets) ?? 3;
                selectedExercises[exerciseIndex]["reps"] = int.tryParse(reps) ?? 12;
                if (duration.isNotEmpty) {
                  selectedExercises[exerciseIndex]["duration"] = int.tryParse(duration);
                }
                
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _saveWorkout() {
    if (workoutName.isEmpty) {
      se("Please enter a workout name");
      return;
    }
    
    if (selectedExercises.isEmpty) {
      se("Please add at least one exercise");
      return;
    }
    
    // Save workout logic here
    ss("Custom workout '$workoutName' created successfully!");
    
    // Navigate back or to workout details
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise1View extends StatefulWidget {
  @override
  State<GrlExercise1View> createState() => _GrlExercise1ViewState();
}

class _GrlExercise1ViewState extends State<GrlExercise1View> {
  String selectedDifficulty = "all";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> exercises = [
    {
      "id": "1",
      "name": "Push-ups",
      "category": "Strength",
      "difficulty": "beginner",
      "duration": 15,
      "calories": 45,
      "description": "Classic upper body exercise targeting chest, shoulders, and triceps",
      "equipment": "None",
      "image": "https://picsum.photos/300/200?random=1&keyword=exercise",
      "steps": ["Start in plank position", "Lower body to ground", "Push back up", "Repeat"],
      "completed": false,
      "rating": 4.5,
      "videoUrl": "https://example.com/video1"
    },
    {
      "id": "2",
      "name": "Jumping Jacks",
      "category": "Cardio",
      "difficulty": "beginner",
      "duration": 10,
      "calories": 35,
      "description": "Full-body cardio exercise to get your heart rate up",
      "equipment": "None",
      "image": "https://picsum.photos/300/200?random=2&keyword=cardio",
      "steps": ["Stand with feet together", "Jump feet apart while raising arms", "Jump back to start", "Repeat"],
      "completed": true,
      "rating": 4.2,
      "videoUrl": "https://example.com/video2"
    },
    {
      "id": "3",
      "name": "Plank Hold",
      "category": "Core",
      "difficulty": "intermediate",
      "duration": 20,
      "calories": 25,
      "description": "Isometric core exercise for building stability and strength",
      "equipment": "None",
      "image": "https://picsum.photos/300/200?random=3&keyword=plank",
      "steps": ["Start in push-up position", "Hold straight line from head to heels", "Engage core muscles", "Maintain position"],
      "completed": false,
      "rating": 4.7,
      "videoUrl": "https://example.com/video3"
    },
    {
      "id": "4",
      "name": "Dumbbell Squats",
      "category": "Strength",
      "difficulty": "intermediate",
      "duration": 25,
      "calories": 65,
      "description": "Lower body strength exercise targeting quads and glutes",
      "equipment": "Dumbbells",
      "image": "https://picsum.photos/300/200?random=4&keyword=weights",
      "steps": ["Hold dumbbells at shoulders", "Lower into squat position", "Drive through heels to stand", "Repeat"],
      "completed": false,
      "rating": 4.8,
      "videoUrl": "https://example.com/video4"
    },
    {
      "id": "5",
      "name": "Burpees",
      "category": "HIIT",
      "difficulty": "advanced",
      "duration": 20,
      "calories": 80,
      "description": "High-intensity full-body exercise combining strength and cardio",
      "equipment": "None",
      "image": "https://picsum.photos/300/200?random=5&keyword=fitness",
      "steps": ["Start standing", "Drop to plank", "Do push-up", "Jump feet to hands", "Jump up with arms overhead"],
      "completed": false,
      "rating": 4.3,
      "videoUrl": "https://example.com/video5"
    },
    {
      "id": "6",
      "name": "Mountain Climbers",
      "category": "Cardio",
      "difficulty": "intermediate",
      "duration": 15,
      "calories": 55,
      "description": "Dynamic cardio exercise that works the entire body",
      "equipment": "None",
      "image": "https://picsum.photos/300/200?random=6&keyword=mountain",
      "steps": ["Start in plank position", "Bring one knee to chest", "Switch legs quickly", "Keep core engaged"],
      "completed": true,
      "rating": 4.4,
      "videoUrl": "https://example.com/video6"
    }
  ];

  List<String> categories = ["all", "Strength", "Cardio", "Core", "HIIT"];
  List<String> difficulties = ["all", "beginner", "intermediate", "advanced"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            _buildQuickStats(),
            
            SizedBox(height: spMd),

            // Filter Section
            _buildFilterSection(),
            
            SizedBox(height: spMd),

            // Exercise Grid
            _buildExerciseGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showCreateWorkoutDialog(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildQuickStats() {
    int totalExercises = exercises.length;
    int completedToday = exercises.where((e) => e["completed"] == true).length;
    int totalCalories = exercises.where((e) => e["completed"] == true)
        .map((e) => e["calories"] as int)
        .fold(0, (sum, calories) => sum + calories);
    int totalMinutes = exercises.where((e) => e["completed"] == true)
        .map((e) => e["duration"] as int)
        .fold(0, (sum, duration) => sum + duration);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: Colors.white, size: 24),
              SizedBox(width: spSm),
              Text(
                "Today's Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Completed", "$completedToday/$totalExercises", Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Calories", "$totalCalories", Icons.local_fire_department),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Minutes", "$totalMinutes", Icons.timer),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter Exercises",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        // Category Filter
        Row(
          children: [
            Text(
              "Category:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    
                    return Container(
                      margin: EdgeInsets.only(right: spXs),
                      child: GestureDetector(
                        onTap: () {
                          selectedCategory = category;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            category == "all" ? "All" : category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Difficulty Filter
        Row(
          children: [
            Text(
              "Difficulty:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: difficulties.length,
                  itemBuilder: (context, index) {
                    final difficulty = difficulties[index];
                    final isSelected = selectedDifficulty == difficulty;
                    
                    return Container(
                      margin: EdgeInsets.only(right: spXs),
                      child: GestureDetector(
                        onTap: () {
                          selectedDifficulty = difficulty;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            difficulty == "all" ? "All" : difficulty.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExerciseGrid() {
    List<Map<String, dynamic>> filteredExercises = exercises.where((exercise) {
      bool categoryMatch = selectedCategory == "all" || exercise["category"] == selectedCategory;
      bool difficultyMatch = selectedDifficulty == "all" || exercise["difficulty"] == selectedDifficulty;
      return categoryMatch && difficultyMatch;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Exercise Library",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredExercises.length} exercises",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 200,
          children: filteredExercises.map((exercise) {
            return _buildExerciseCard(exercise);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    bool isCompleted = exercise["completed"] as bool;
    Color difficultyColor = _getDifficultyColor(exercise["difficulty"]);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Image
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${exercise["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: difficultyColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${exercise["difficulty"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (isCompleted)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          
          // Exercise Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${exercise["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${exercise["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                
                // Exercise Details
                Row(
                  children: [
                    _buildDetailChip(Icons.timer, "${exercise["duration"]}min", infoColor),
                    SizedBox(width: spXs),
                    _buildDetailChip(Icons.local_fire_department, "${exercise["calories"]}", dangerColor),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    _buildDetailChip(Icons.category, "${exercise["category"]}", primaryColor),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 12),
                        SizedBox(width: 2),
                        Text(
                          "${((exercise["rating"] as double)).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isCompleted ? "View Details" : "Start Exercise",
                    size: bs.sm,
                    onPressed: () => _showExerciseDetails(exercise),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showSearchDialog() {
    // Search dialog implementation
  }

  void _showCreateWorkoutDialog() {
    // Create workout dialog implementation
  }

  void _showExerciseDetails(Map<String, dynamic> exercise) {
    // Exercise details dialog implementation
  }
}

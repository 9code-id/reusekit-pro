import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWorkoutPlansView extends StatefulWidget {
  const FwaWorkoutPlansView({Key? key}) : super(key: key);

  @override
  State<FwaWorkoutPlansView> createState() => _FwaWorkoutPlansViewState();
}

class _FwaWorkoutPlansViewState extends State<FwaWorkoutPlansView> {
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Strength", "value": "Strength"},
    {"label": "Cardio", "value": "Cardio"},
    {"label": "HIIT", "value": "HIIT"},
    {"label": "Yoga", "value": "Yoga"},
    {"label": "Pilates", "value": "Pilates"},
    {"label": "Stretching", "value": "Stretching"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> workoutPlans = [
    {
      "id": 1,
      "title": "Full Body Strength",
      "description": "Complete workout targeting all major muscle groups",
      "category": "Strength",
      "difficulty": "Intermediate",
      "duration": 45,
      "exercises": 8,
      "calories": 320,
      "image": "https://picsum.photos/300/200?random=1&keyword=gym",
      "rating": 4.8,
      "reviews": 1245,
      "isPopular": true,
      "equipment": ["Dumbbells", "Barbell", "Bench"],
      "trainer": "Mike Johnson"
    },
    {
      "id": 2,
      "title": "Morning Cardio Blast",
      "description": "High-energy cardio workout to start your day",
      "category": "Cardio",
      "difficulty": "Beginner",
      "duration": 30,
      "exercises": 6,
      "calories": 280,
      "image": "https://picsum.photos/300/200?random=2&keyword=running",
      "rating": 4.6,
      "reviews": 892,
      "isPopular": false,
      "equipment": ["No Equipment"],
      "trainer": "Sarah Lee"
    },
    {
      "id": 3,
      "title": "HIIT Fat Burner",
      "description": "Intense interval training for maximum fat burn",
      "category": "HIIT",
      "difficulty": "Advanced",
      "duration": 25,
      "exercises": 12,
      "calories": 350,
      "image": "https://picsum.photos/300/200?random=3&keyword=fitness",
      "rating": 4.9,
      "reviews": 2156,
      "isPopular": true,
      "equipment": ["Kettlebell", "Jump Rope"],
      "trainer": "Alex Rodriguez"
    },
    {
      "id": 4,
      "title": "Yoga Flow Basics",
      "description": "Gentle yoga sequences for flexibility and mindfulness",
      "category": "Yoga",
      "difficulty": "Beginner",
      "duration": 40,
      "exercises": 15,
      "calories": 150,
      "image": "https://picsum.photos/300/200?random=4&keyword=yoga",
      "rating": 4.7,
      "reviews": 756,
      "isPopular": false,
      "equipment": ["Yoga Mat"],
      "trainer": "Emma Wilson"
    },
    {
      "id": 5,
      "title": "Upper Body Pump",
      "description": "Focused upper body strength and muscle building",
      "category": "Strength",
      "difficulty": "Intermediate",
      "duration": 35,
      "exercises": 10,
      "calories": 290,
      "image": "https://picsum.photos/300/200?random=5&keyword=workout",
      "rating": 4.5,
      "reviews": 643,
      "isPopular": false,
      "equipment": ["Dumbbells", "Pull-up Bar"],
      "trainer": "Chris Martin"
    },
    {
      "id": 6,
      "title": "Core Destroyer",
      "description": "Intense core workout for abs and stability",
      "category": "Strength",
      "difficulty": "Advanced",
      "duration": 20,
      "exercises": 8,
      "calories": 180,
      "image": "https://picsum.photos/300/200?random=6&keyword=abs",
      "rating": 4.8,
      "reviews": 1089,
      "isPopular": true,
      "equipment": ["Medicine Ball", "Ab Roller"],
      "trainer": "Lisa Chen"
    },
  ];

  List<Map<String, dynamic>> featuredPlans = [
    {
      "title": "30-Day Challenge",
      "description": "Transform your body in 30 days",
      "image": "https://picsum.photos/400/250?random=7&keyword=challenge",
      "color": Colors.purple,
      "duration": "30 days",
      "workouts": 25
    },
    {
      "title": "Beginner's Guide",
      "description": "Perfect start for fitness journey",
      "image": "https://picsum.photos/400/250?random=8&keyword=beginner",
      "color": Colors.green,
      "duration": "8 weeks",
      "workouts": 16
    },
    {
      "title": "Weight Loss Program",
      "description": "Burn fat and lose weight effectively",
      "image": "https://picsum.photos/400/250?random=9&keyword=weightloss",
      "color": Colors.orange,
      "duration": "12 weeks",
      "workouts": 36
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPlans = _getFilteredPlans();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to favorites
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
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
            // Search Bar
            QTextField(
              label: "Search workout plans",
              value: searchQuery,
              hint: "Find your perfect workout...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Filters
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

            // Featured Programs
            Text(
              "Featured Programs",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: featuredPlans.map((program) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${program["image"]}",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(180),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        right: spSm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${program["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${program["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.white.withAlpha(200),
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${program["duration"]} • ${program["workouts"]} workouts",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: program["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Featured",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Popular Workouts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Workouts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show all popular workouts
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Workout Plans Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredPlans.map((plan) {
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
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${plan["image"]}",
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (plan["isPopular"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "Popular",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                // Add to favorites
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: dangerColor,
                                  size: 18,
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
                              "${plan["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${plan["description"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${plan["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${plan["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _buildInfoChip(Icons.schedule, "${plan["duration"]} min"),
                                SizedBox(width: spXs),
                                _buildInfoChip(Icons.fitness_center, "${plan["exercises"]} exercises"),
                              ],
                            ),
                            Row(
                              children: [
                                _buildInfoChip(Icons.local_fire_department, "${plan["calories"]} cal"),
                                SizedBox(width: spXs),
                                _buildDifficultyChip("${plan["difficulty"]}"),
                              ],
                            ),
                            Text(
                              "Trainer: ${plan["trainer"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Start Workout",
                                size: bs.sm,
                                onPressed: () {
                                  // Start workout
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

            if (filteredPlans.isEmpty)
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
                      "No workout plans found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or search terms",
                      textAlign: TextAlign.center,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create custom workout
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: disabledBoldColor,
          ),
          SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color chipColor;
    switch (difficulty) {
      case "Beginner":
        chipColor = successColor;
        break;
      case "Intermediate":
        chipColor = warningColor;
        break;
      case "Advanced":
        chipColor = dangerColor;
        break;
      default:
        chipColor = primaryColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          fontSize: 10,
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPlans() {
    return workoutPlans.where((plan) {
      bool matchesCategory = selectedCategory == "All" || plan["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || plan["difficulty"] == selectedDifficulty;
      bool matchesSearch = searchQuery.isEmpty || 
          (plan["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (plan["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (plan["trainer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesDifficulty && matchesSearch;
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Workouts"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Difficulty",
              items: difficultyOptions,
              value: selectedDifficulty,
              onChanged: (value, label) {
                selectedDifficulty = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedCategory = "All";
              selectedDifficulty = "All";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }
}

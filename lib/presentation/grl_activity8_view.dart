import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity8View extends StatefulWidget {
  @override
  State<GrlActivity8View> createState() => _GrlActivity8ViewState();
}

class _GrlActivity8ViewState extends State<GrlActivity8View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  final List<String> categories = ["All", "Cardio", "Strength", "Flexibility", "Sports", "HIIT"];
  
  final List<Map<String, dynamic>> workoutPlans = [
    {
      "id": 1,
      "title": "Morning Power Workout",
      "description": "High-intensity workout to kickstart your day",
      "duration": 30,
      "difficulty": "Medium",
      "category": "HIIT",
      "exercises": 8,
      "calories": 280,
      "equipment": ["Dumbbells", "Mat"],
      "rating": 4.8,
      "reviews": 324,
      "image": "https://placehold.co/300x200?text=Morning+Power",
      "isBookmarked": true,
      "trainer": "Sarah Johnson",
      "tags": ["Fat Burn", "Energy Boost", "Full Body"],
      "preview": [
        "Jumping Jacks - 2 min",
        "Push-ups - 3 sets",
        "Squats - 3 sets",
        "Plank - 1 min"
      ]
    },
    {
      "id": 2,
      "title": "Strength Building Circuit",
      "description": "Build muscle with targeted strength exercises",
      "duration": 45,
      "difficulty": "Hard",
      "category": "Strength",
      "exercises": 12,
      "calories": 380,
      "equipment": ["Barbells", "Dumbbells", "Bench"],
      "rating": 4.9,
      "reviews": 287,
      "image": "https://placehold.co/300x200?text=Strength+Circuit",
      "isBookmarked": false,
      "trainer": "Mike Thompson",
      "tags": ["Muscle Gain", "Upper Body", "Lower Body"],
      "preview": [
        "Deadlifts - 4 sets",
        "Bench Press - 4 sets",
        "Squats - 4 sets",
        "Overhead Press - 3 sets"
      ]
    },
    {
      "id": 3,
      "title": "Cardio Blast",
      "description": "High-energy cardio session for endurance",
      "duration": 25,
      "difficulty": "Medium",
      "category": "Cardio",
      "exercises": 6,
      "calories": 320,
      "equipment": ["None"],
      "rating": 4.7,
      "reviews": 412,
      "image": "https://placehold.co/300x200?text=Cardio+Blast",
      "isBookmarked": true,
      "trainer": "Emma Davis",
      "tags": ["Heart Health", "Endurance", "Fat Burn"],
      "preview": [
        "High Knees - 3 min",
        "Burpees - 3 sets",
        "Mountain Climbers - 3 sets",
        "Jump Rope - 5 min"
      ]
    },
    {
      "id": 4,
      "title": "Yoga Flow for Flexibility",
      "description": "Gentle stretching and flexibility routine",
      "duration": 35,
      "difficulty": "Easy",
      "category": "Flexibility",
      "exercises": 10,
      "calories": 120,
      "equipment": ["Yoga Mat", "Block"],
      "rating": 4.6,
      "reviews": 189,
      "image": "https://placehold.co/300x200?text=Yoga+Flow",
      "isBookmarked": false,
      "trainer": "Lisa Chen",
      "tags": ["Relaxation", "Flexibility", "Mindfulness"],
      "preview": [
        "Sun Salutation - 5 rounds",
        "Warrior Poses - 2 min each",
        "Forward Fold - 2 min",
        "Savasana - 5 min"
      ]
    },
    {
      "id": 5,
      "title": "Basketball Training",
      "description": "Sport-specific drills for basketball players",
      "duration": 50,
      "difficulty": "Hard",
      "category": "Sports",
      "exercises": 15,
      "calories": 450,
      "equipment": ["Basketball", "Cones"],
      "rating": 4.8,
      "reviews": 156,
      "image": "https://placehold.co/300x200?text=Basketball+Training",
      "isBookmarked": true,
      "trainer": "Coach Wilson",
      "tags": ["Sport Training", "Agility", "Coordination"],
      "preview": [
        "Dribbling Drills - 10 min",
        "Shooting Practice - 15 min",
        "Defensive Slides - 5 min",
        "Scrimmage - 20 min"
      ]
    },
    {
      "id": 6,
      "title": "Core Strengthener",
      "description": "Focused core workout for stability",
      "duration": 20,
      "difficulty": "Medium",
      "category": "Strength",
      "exercises": 7,
      "calories": 180,
      "equipment": ["Mat", "Medicine Ball"],
      "rating": 4.5,
      "reviews": 278,
      "image": "https://placehold.co/300x200?text=Core+Strengthener",
      "isBookmarked": false,
      "trainer": "Alex Rodriguez",
      "tags": ["Core", "Stability", "Abs"],
      "preview": [
        "Plank Variations - 4 sets",
        "Russian Twists - 3 sets",
        "Dead Bug - 3 sets",
        "Mountain Climbers - 2 sets"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredWorkouts {
    List<Map<String, dynamic>> filtered = workoutPlans;
    
    if (selectedTab != 0) {
      String category = categories[selectedTab];
      filtered = filtered.where((workout) => 
        "${workout["category"]}" == category).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((workout) =>
        "${workout["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${workout["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${workout["trainer"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy": return successColor;
      case "Medium": return warningColor;
      case "Hard": return dangerColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
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
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search workouts, trainers...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Category Tabs
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: categories[selectedTab],
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${workoutPlans.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Workouts",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${workoutPlans.where((w) => w["isBookmarked"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Saved",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${workoutPlans.fold(0, (sum, w) => sum + (w["duration"] as int))}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Min",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(workoutPlans.fold(0, (sum, w) => sum + (w["calories"] as int)) / 1000).toStringAsFixed(1)}k",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Calories",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Workout Cards
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Workouts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredWorkouts.length} workouts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: filteredWorkouts.map((workout) {
                      bool isBookmarked = workout["isBookmarked"] as bool;
                      Color difficultyColor = _getDifficultyColor("${workout["difficulty"]}");
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            // Workout Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(radiusLg),
                                  ),
                                  child: Image.network(
                                    "${workout["image"]}",
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                      color: isBookmarked ? warningColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: difficultyColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${workout["difficulty"]}",
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
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  // Title and Rating
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${workout["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: warningColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${workout["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            " (${workout["reviews"]})",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Description
                                  Text(
                                    "${workout["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),

                                  // Trainer
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${workout["trainer"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Workout Stats
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            Text(
                                              "${workout["duration"]} min",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              size: 16,
                                              color: successColor,
                                            ),
                                            Text(
                                              "${workout["exercises"]} exercises",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 16,
                                              color: dangerColor,
                                            ),
                                            Text(
                                              "${workout["calories"]} cal",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Tags
                                  QHorizontalScroll(
                                    children: (workout["tags"] as List).map((tag) {
                                      return Container(
                                        margin: EdgeInsets.only(right: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$tag",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),

                                  // Equipment Required
                                  if ((workout["equipment"] as List).isNotEmpty)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "Equipment needed:",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          (workout["equipment"] as List).join(", "),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                  // Exercise Preview
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "Exercise Preview:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Column(
                                        spacing: 2,
                                        children: (workout["preview"] as List).take(3).map((exercise) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                "$exercise",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                      if ((workout["preview"] as List).length > 3)
                                        Text(
                                          "...and ${(workout["preview"] as List).length - 3} more",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontStyle: FontStyle.italic,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                    ],
                                  ),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Start Workout",
                                          size: bs.sm,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.play_circle,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        onPressed: () {},
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

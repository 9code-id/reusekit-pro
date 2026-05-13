import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness10View extends StatefulWidget {
  @override
  State<GrlFitness10View> createState() => _GrlFitness10ViewState();
}

class _GrlFitness10ViewState extends State<GrlFitness10View> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<String> categories = ["All", "Beginner", "Intermediate", "Advanced", "Equipment Free"];

  List<Map<String, dynamic>> workoutPlans = [
    {
      "id": 1,
      "title": "Full Body Burn",
      "category": "Intermediate",
      "duration": "45 min",
      "exercises": 12,
      "difficulty": "Intermediate",
      "calories": 380,
      "equipment": "Dumbbells",
      "rating": 4.8,
      "reviews": 1250,
      "image": "https://picsum.photos/400/250?random=1&keyword=fitness",
      "description": "Complete full-body workout targeting all major muscle groups",
      "trainer": "Sarah Johnson",
      "tags": ["Strength", "Cardio", "Fat Burn"]
    },
    {
      "id": 2,
      "title": "Morning Yoga Flow",
      "category": "Beginner",
      "duration": "30 min",
      "exercises": 8,
      "difficulty": "Beginner",
      "calories": 120,
      "equipment": "None",
      "rating": 4.9,
      "reviews": 2100,
      "image": "https://picsum.photos/400/250?random=2&keyword=yoga",
      "description": "Gentle morning yoga sequence to energize your day",
      "trainer": "Amanda Chen",
      "tags": ["Flexibility", "Mindfulness", "Beginner"]
    },
    {
      "id": 3,
      "title": "HIIT Cardio Blast",
      "category": "Advanced",
      "duration": "25 min",
      "exercises": 10,
      "difficulty": "Advanced",
      "calories": 450,
      "equipment": "None",
      "rating": 4.7,
      "reviews": 890,
      "image": "https://picsum.photos/400/250?random=3&keyword=cardio",
      "description": "High-intensity interval training for maximum calorie burn",
      "trainer": "Mike Torres",
      "tags": ["HIIT", "Cardio", "No Equipment"]
    },
    {
      "id": 4,
      "title": "Strength Builder",
      "category": "Intermediate",
      "duration": "50 min",
      "exercises": 15,
      "difficulty": "Intermediate",
      "calories": 320,
      "equipment": "Dumbbells, Barbell",
      "rating": 4.6,
      "reviews": 670,
      "image": "https://picsum.photos/400/250?random=4&keyword=strength",
      "description": "Build lean muscle with progressive strength training",
      "trainer": "John Davis",
      "tags": ["Strength", "Muscle", "Progressive"]
    },
    {
      "id": 5,
      "title": "Pilates Core",
      "category": "Beginner",
      "duration": "35 min",
      "exercises": 9,
      "difficulty": "Beginner",
      "calories": 180,
      "equipment": "Mat",
      "rating": 4.8,
      "reviews": 1540,
      "image": "https://picsum.photos/400/250?random=5&keyword=pilates",
      "description": "Strengthen your core with controlled pilates movements",
      "trainer": "Lisa Wang",
      "tags": ["Core", "Pilates", "Flexibility"]
    },
    {
      "id": 6,
      "title": "Bodyweight Beast",
      "category": "Equipment Free",
      "duration": "40 min",
      "exercises": 14,
      "difficulty": "Intermediate",
      "calories": 350,
      "equipment": "None",
      "rating": 4.9,
      "reviews": 1890,
      "image": "https://picsum.photos/400/250?random=6&keyword=bodyweight",
      "description": "Intense bodyweight workout requiring no equipment",
      "trainer": "Chris Martinez",
      "tags": ["Bodyweight", "Strength", "No Equipment"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredWorkouts = workoutPlans.where((workout) {
      final matchesCategory = selectedCategory == "All" || workout["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          (workout["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (workout["trainer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search workouts or trainers...",
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredWorkouts.length,
              itemBuilder: (context, index) {
                final workout = filteredWorkouts[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${workout["image"]}",
                              width: double.infinity,
                              height: 180,
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
                                Icons.favorite_border,
                                size: 20,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(workout["difficulty"] as String).withAlpha(220),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${workout["difficulty"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${workout["duration"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    Icon(Icons.star, color: warningColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${workout["rating"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "by ${workout["trainer"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${workout["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Icon(Icons.fitness_center, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${workout["exercises"]} exercises",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.local_fire_department, size: 16, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${workout["calories"]} cal",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.sports_gymnastics, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${workout["equipment"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: List.generate(
                                (workout["tags"] as List).length,
                                (tagIndex) {
                                  final tag = (workout["tags"] as List)[tagIndex];
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "$tag",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Text(
                                  "${((workout["reviews"] as int) / 1000).toStringAsFixed(1)}k reviews",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Start Workout",
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
              },
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
}

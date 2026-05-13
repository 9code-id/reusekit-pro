import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaExerciseDetailView extends StatefulWidget {
  const FwaExerciseDetailView({super.key});

  @override
  State<FwaExerciseDetailView> createState() => _FwaExerciseDetailViewState();
}

class _FwaExerciseDetailViewState extends State<FwaExerciseDetailView> {
  Map<String, dynamic> exercise = {
    "name": "Push-ups",
    "category": "Chest",
    "difficulty": "Beginner",
    "equipment": "Bodyweight",
    "duration": "30 seconds",
    "calories": 12,
    "description": "Push-ups are a fundamental upper body exercise that targets the chest, shoulders, and triceps. This bodyweight exercise is perfect for building strength and endurance while improving overall upper body stability.",
    "image": "https://picsum.photos/400/300?random=1&keyword=pushup",
    "targetMuscles": ["Chest", "Shoulders", "Triceps", "Core"],
    "instructions": [
      "Start in a plank position with your hands slightly wider than shoulder-width apart",
      "Keep your body in a straight line from head to heels",
      "Lower your body until your chest nearly touches the floor",
      "Push through your palms to return to the starting position",
      "Keep your core engaged throughout the movement",
      "Maintain steady breathing - exhale on the way up, inhale on the way down"
    ],
    "isFavorite": true,
    "rating": 4.5,
    "totalRatings": 1247,
    "sets": 3,
    "reps": "10-15",
    "restTime": "60 seconds",
    "variations": [
      {
        "name": "Knee Push-ups",
        "difficulty": "Beginner",
        "description": "Modified version performed on knees for beginners"
      },
      {
        "name": "Diamond Push-ups",
        "difficulty": "Advanced",
        "description": "Hands in diamond shape to target triceps more"
      },
      {
        "name": "Incline Push-ups",
        "difficulty": "Beginner",
        "description": "Hands elevated on bench or platform"
      },
      {
        "name": "Decline Push-ups",
        "difficulty": "Advanced",
        "description": "Feet elevated to increase difficulty"
      }
    ],
    "tips": [
      "Keep your body in a straight line throughout the movement",
      "Don't let your hips sag or pike up",
      "Focus on controlled movement rather than speed",
      "If you can't do full push-ups, start with knee push-ups",
      "Gradually increase reps as you get stronger"
    ],
    "commonMistakes": [
      "Allowing hips to sag or pike up",
      "Not going down far enough",
      "Flaring elbows too wide",
      "Holding breath during the movement",
      "Rushing through the reps"
    ]
  };

  List<Map<String, dynamic>> relatedExercises = [
    {
      "name": "Chest Dips",
      "category": "Chest",
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/200/150?random=2&keyword=dips",
      "calories": 15
    },
    {
      "name": "Incline Push-ups",
      "category": "Chest",
      "difficulty": "Beginner",
      "image": "https://picsum.photos/200/150?random=3&keyword=incline",
      "calories": 10
    },
    {
      "name": "Pike Push-ups",
      "category": "Shoulders",
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/200/150?random=4&keyword=pike",
      "calories": 14
    }
  ];

  int currentTab = 0;
  bool hasPerformed = false;
  int performedSets = 0;
  int performedReps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${exercise["name"]}"),
        actions: [
          IconButton(
            icon: Icon(
              exercise["isFavorite"] ? Icons.favorite : Icons.favorite_border,
              color: exercise["isFavorite"] ? dangerColor : null,
            ),
            onPressed: () {
              exercise["isFavorite"] = !exercise["isFavorite"];
              setState(() {});
              if (exercise["isFavorite"]) {
                ss("Added to favorites");
              } else {
                si("Removed from favorites");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Exercise shared successfully");
            },
          ),
        ],
      ),
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: currentTab,
        tabs: [
          Tab(text: "Overview", icon: Icon(Icons.info)),
          Tab(text: "Instructions", icon: Icon(Icons.list_alt)),
          Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
        ],
        tabChildren: [
          // Overview Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Exercise Image & Basic Info
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Image.network(
                            "${exercise["image"]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${exercise["name"]}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${exercise["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 16, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${exercise["rating"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " (${exercise["totalRatings"]} reviews)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${exercise["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Exercise Stats
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.timer, color: primaryColor, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "${exercise["duration"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.local_fire_department, color: dangerColor, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "${exercise["calories"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Calories",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.fitness_center, color: successColor, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "${exercise["equipment"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Equipment",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.repeat, color: warningColor, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "${exercise["sets"]} × ${exercise["reps"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Sets × Reps",
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

                // Target Muscles
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
                        "Target Muscles",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spSm,
                        children: (exercise["targetMuscles"] as List).map((muscle) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "$muscle",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList().cast<Widget>(),
                      ),
                    ],
                  ),
                ),

                // Related Exercises
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
                        "Related Exercises",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: relatedExercises.map((related) {
                          return Container(
                            width: 150,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: disabledColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                    child: Image.network(
                                      "${related["image"]}",
                                      width: double.infinity,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(spSm),
                                  child: Column(
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "${related["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${related["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
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
              ],
            ),
          ),

          // Instructions Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
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
                        "Step-by-Step Instructions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Column(
                        spacing: spSm,
                        children: (exercise["instructions"] as List).asMap().entries.map((entry) {
                          int index = entry.key;
                          String instruction = entry.value;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  instruction,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Variations
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
                        "Exercise Variations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Column(
                        spacing: spSm,
                        children: (exercise["variations"] as List).map((variation) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: disabledColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: variation["difficulty"] == "Beginner" ? successColor :
                                          variation["difficulty"] == "Intermediate" ? warningColor :
                                          dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${variation["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${variation["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${variation["description"]}",
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
                          );
                        }).toList().cast<Widget>(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tips Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Pro Tips
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
                          Icon(Icons.lightbulb, color: warningColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Pro Tips",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spSm,
                        children: (exercise["tips"] as List).map((tip) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                margin: EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "$tip",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Common Mistakes
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
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Common Mistakes to Avoid",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spSm,
                        children: (exercise["commonMistakes"] as List).map((mistake) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                margin: EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "$mistake",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    height: 1.4,
                                  ),
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
            ),
          ),
        ],
        onInit: (tabController) {
          // Optional: Access to TabController
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Start Exercise",
                size: bs.md,
                onPressed: () {
                  // navigateTo('Exercise Timer')
                },
              ),
            ),
            QButton(
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                ss("Added to your workout plan");
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWorkoutPlanView extends StatefulWidget {
  const FwaWorkoutPlanView({super.key});

  @override
  State<FwaWorkoutPlanView> createState() => _FwaWorkoutPlanViewState();
}

class _FwaWorkoutPlanViewState extends State<FwaWorkoutPlanView> {
  List<Map<String, dynamic>> workoutPlans = [
    {
      "title": "Weight Loss Beginner",
      "description": "Perfect for beginners looking to lose weight and build basic fitness",
      "duration": "4 weeks",
      "difficulty": "Beginner",
      "workoutsPerWeek": 3,
      "avgDuration": "30 min",
      "equipment": "None",
      "calories": "200-300",
      "image": "https://picsum.photos/400/250?random=1&keyword=fitness",
      "isActive": true,
      "progress": 0.6,
      "completedWorkouts": 7,
      "totalWorkouts": 12,
      "tags": ["Weight Loss", "Cardio", "Beginner"]
    },
    {
      "title": "Strength Building",
      "description": "Build muscle mass and strength with progressive overload training",
      "duration": "6 weeks",
      "difficulty": "Intermediate",
      "workoutsPerWeek": 4,
      "avgDuration": "45 min",
      "equipment": "Dumbbells",
      "calories": "300-400",
      "image": "https://picsum.photos/400/250?random=2&keyword=strength",
      "isActive": false,
      "progress": 0.0,
      "completedWorkouts": 0,
      "totalWorkouts": 24,
      "tags": ["Strength", "Muscle Building", "Intermediate"]
    },
    {
      "title": "HIIT Transformation",
      "description": "High-intensity workouts for maximum calorie burn and fat loss",
      "duration": "3 weeks",
      "difficulty": "Advanced",
      "workoutsPerWeek": 5,
      "avgDuration": "25 min",
      "equipment": "None",
      "calories": "400-500",
      "image": "https://picsum.photos/400/250?random=3&keyword=hiit",
      "isActive": false,
      "progress": 0.0,
      "completedWorkouts": 0,
      "totalWorkouts": 15,
      "tags": ["HIIT", "Fat Loss", "Advanced"]
    },
    {
      "title": "Flexibility & Mobility",
      "description": "Improve flexibility, reduce stiffness, and enhance mobility",
      "duration": "5 weeks",
      "difficulty": "Beginner",
      "workoutsPerWeek": 3,
      "avgDuration": "20 min",
      "equipment": "None",
      "calories": "100-150",
      "image": "https://picsum.photos/400/250?random=4&keyword=yoga",
      "isActive": false,
      "progress": 0.0,
      "completedWorkouts": 0,
      "totalWorkouts": 15,
      "tags": ["Flexibility", "Yoga", "Recovery"]
    },
    {
      "title": "Full Body Circuit",
      "description": "Complete full-body workouts combining cardio and strength",
      "duration": "8 weeks",
      "difficulty": "Intermediate",
      "workoutsPerWeek": 4,
      "avgDuration": "40 min",
      "equipment": "Resistance Bands",
      "calories": "350-450",
      "image": "https://picsum.photos/400/250?random=5&keyword=circuit",
      "isActive": false,
      "progress": 0.0,
      "completedWorkouts": 0,
      "totalWorkouts": 32,
      "tags": ["Full Body", "Circuit", "Cardio"]
    }
  ];

  List<String> filterTags = ["All", "Beginner", "Intermediate", "Advanced", "Weight Loss", "Strength", "Cardio"];
  String selectedFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredPlans {
    List<Map<String, dynamic>> filtered = workoutPlans;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((plan) {
        return plan["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               plan["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedFilter != "All") {
      filtered = filtered.where((plan) {
        List<String> tags = (plan["tags"] as List).cast<String>();
        return tags.contains(selectedFilter) || plan["difficulty"] == selectedFilter;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('Create Custom Plan')
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
                    label: "Search workout plans...",
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

            // Filter Tags
            Container(
              width: double.infinity,
              child: QCategoryPicker(
                items: filterTags.map((tag) => {
                  "label": tag,
                  "value": tag,
                }).toList(),
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),

            // Active Plan Section
            if (workoutPlans.any((plan) => plan["isActive"]))
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
                      "Current Plan",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: workoutPlans.where((plan) => plan["isActive"]).map((plan) {
                          return Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${plan["title"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "ACTIVE",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${plan["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${plan["duration"]} • ${plan["workoutsPerWeek"]}x/week",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${plan["completedWorkouts"]}/${plan["totalWorkouts"]} workouts",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Progress",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${((plan["progress"] as double) * 100).toInt()}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  LinearProgressIndicator(
                                    value: plan["progress"],
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: spSm,
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Continue",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo('Workout Session')
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo('Plan Details')
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

            // Available Plans
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
                    "Available Plans (${filteredPlans.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spMd,
                    children: filteredPlans.map((plan) {
                      return Container(
                        decoration: BoxDecoration(
                          color: plan["isActive"] ? primaryColor.withAlpha(5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: plan["isActive"] ? primaryColor.withAlpha(30) : disabledColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                child: Image.network(
                                  "${plan["image"]}",
                                  width: double.infinity,
                                  height: 150,
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
                                          "${plan["title"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: plan["difficulty"] == "Beginner" ? successColor :
                                                plan["difficulty"] == "Intermediate" ? warningColor :
                                                dangerColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${plan["difficulty"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${plan["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  ResponsiveGridView(
                                    padding: EdgeInsets.zero,
                                    minItemWidth: 200,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${plan["duration"]}",
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
                                            "${plan["workoutsPerWeek"]}x/week",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size: 16, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${plan["avgDuration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.local_fire_department, size: 16, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${plan["calories"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (plan["tags"] as List).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$tag",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList().cast<Widget>(),
                                  ),
                                  Row(
                                    spacing: spSm,
                                    children: [
                                      if (!plan["isActive"])
                                        Expanded(
                                          child: QButton(
                                            label: "Start Plan",
                                            size: bs.sm,
                                            onPressed: () async {
                                              bool isConfirmed = await confirm("Are you sure you want to start this workout plan?");
                                              if (isConfirmed) {
                                                // Start the plan
                                                for (var p in workoutPlans) {
                                                  p["isActive"] = false;
                                                }
                                                plan["isActive"] = true;
                                                setState(() {});
                                                ss("Workout plan started successfully!");
                                              }
                                            },
                                          ),
                                        )
                                      else
                                        Expanded(
                                          child: QButton(
                                            label: "Active",
                                            size: bs.sm,
                                            onPressed: () {},
                                          ),
                                        ),
                                      Expanded(
                                        child: QButton(
                                          label: "Preview",
                                          size: bs.sm,
                                          onPressed: () {
                                            // navigateTo('Plan Preview')
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
          ],
        ),
      ),
    );
  }
}

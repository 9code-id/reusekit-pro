import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMealScheduleView extends StatefulWidget {
  const FwaMealScheduleView({super.key});

  @override
  State<FwaMealScheduleView> createState() => _FwaMealScheduleViewState();
}

class _FwaMealScheduleViewState extends State<FwaMealScheduleView> {
  DateTime selectedDate = DateTime.now();
  String selectedMealType = "All";
  bool showCalorieGoals = true;

  List<Map<String, dynamic>> mealTypes = [
    {"label": "All", "value": "All"},
    {"label": "Breakfast", "value": "Breakfast"},
    {"label": "Lunch", "value": "Lunch"},
    {"label": "Dinner", "value": "Dinner"},
    {"label": "Snacks", "value": "Snacks"},
  ];

  List<Map<String, dynamic>> mealSchedule = [
    {
      "id": 1,
      "time": "07:00",
      "type": "Breakfast",
      "name": "Overnight Oats with Berries",
      "calories": 320,
      "protein": 12,
      "carbs": 58,
      "fat": 8,
      "completed": true,
      "image": "https://picsum.photos/60/60?random=1&keyword=oats",
      "ingredients": ["Oats", "Milk", "Berries", "Honey"],
      "prepTime": 10,
      "difficulty": "Easy",
      "reminder": true,
    },
    {
      "id": 2,
      "time": "10:00",
      "type": "Snacks",
      "name": "Greek Yogurt with Nuts",
      "calories": 180,
      "protein": 15,
      "carbs": 12,
      "fat": 9,
      "completed": false,
      "image": "https://picsum.photos/60/60?random=2&keyword=yogurt",
      "ingredients": ["Greek yogurt", "Almonds", "Walnuts"],
      "prepTime": 5,
      "difficulty": "Easy",
      "reminder": true,
    },
    {
      "id": 3,
      "time": "13:00",
      "type": "Lunch",
      "name": "Grilled Chicken Salad",
      "calories": 450,
      "protein": 35,
      "carbs": 25,
      "fat": 22,
      "completed": false,
      "image": "https://picsum.photos/60/60?random=3&keyword=salad",
      "ingredients": ["Chicken breast", "Mixed greens", "Tomatoes", "Cucumber", "Olive oil"],
      "prepTime": 20,
      "difficulty": "Medium",
      "reminder": true,
    },
    {
      "id": 4,
      "time": "16:00",
      "type": "Snacks",
      "name": "Protein Smoothie",
      "calories": 250,
      "protein": 20,
      "carbs": 30,
      "fat": 5,
      "completed": false,
      "image": "https://picsum.photos/60/60?random=4&keyword=smoothie",
      "ingredients": ["Protein powder", "Banana", "Spinach", "Almond milk"],
      "prepTime": 5,
      "difficulty": "Easy",
      "reminder": true,
    },
    {
      "id": 5,
      "time": "19:00",
      "type": "Dinner",
      "name": "Baked Salmon with Quinoa",
      "calories": 520,
      "protein": 40,
      "carbs": 45,
      "fat": 18,
      "completed": false,
      "image": "https://picsum.photos/60/60?random=5&keyword=salmon",
      "ingredients": ["Salmon fillet", "Quinoa", "Broccoli", "Lemon"],
      "prepTime": 30,
      "difficulty": "Medium",
      "reminder": true,
    },
    {
      "id": 6,
      "time": "21:00",
      "type": "Snacks",
      "name": "Herbal Tea with Honey",
      "calories": 25,
      "protein": 0,
      "carbs": 7,
      "fat": 0,
      "completed": false,
      "image": "https://picsum.photos/60/60?random=6&keyword=tea",
      "ingredients": ["Chamomile tea", "Honey"],
      "prepTime": 5,
      "difficulty": "Easy",
      "reminder": false,
    },
  ];

  List<Map<String, dynamic>> get filteredMeals {
    return mealSchedule.where((meal) {
      return selectedMealType == "All" || meal["type"] == selectedMealType;
    }).toList();
  }

  Map<String, int> get dailyTotals {
    int totalCalories = mealSchedule.fold(0, (sum, meal) => sum + (meal["calories"] as int));
    int totalProtein = mealSchedule.fold(0, (sum, meal) => sum + (meal["protein"] as int));
    int totalCarbs = mealSchedule.fold(0, (sum, meal) => sum + (meal["carbs"] as int));
    int totalFat = mealSchedule.fold(0, (sum, meal) => sum + (meal["fat"] as int));
    
    return {
      "calories": totalCalories,
      "protein": totalProtein,
      "carbs": totalCarbs,
      "fat": totalFat,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Schedule"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Date Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(Icons.today, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${selectedDate.dMMMy}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.keyboard_arrow_left,
                    size: bs.sm,
                    onPressed: () {
                      selectedDate = selectedDate.subtract(Duration(days: 1));
                      setState(() {});
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.keyboard_arrow_right,
                    size: bs.sm,
                    onPressed: () {
                      selectedDate = selectedDate.add(Duration(days: 1));
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Daily Goals Summary
            if (showCalorieGoals) ...[
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
                    Row(
                      children: [
                        Icon(Icons.track_changes, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Daily Goals",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showCalorieGoals = !showCalorieGoals;
                            setState(() {});
                          },
                          child: Icon(Icons.expand_less, color: disabledBoldColor, size: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGoalCard("Calories", "${dailyTotals["calories"]}", "2000", "kcal", primaryColor),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildGoalCard("Protein", "${dailyTotals["protein"]}", "150", "g", successColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGoalCard("Carbs", "${dailyTotals["carbs"]}", "200", "g", infoColor),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildGoalCard("Fat", "${dailyTotals["fat"]}", "70", "g", warningColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Meal Type Filter
            QCategoryPicker(
              label: "Meal Type",
              items: mealTypes,
              value: selectedMealType,
              onChanged: (index, label, value, item) {
                selectedMealType = value;
                setState(() {});
              },
            ),

            // Meal Schedule List
            ...filteredMeals.map((meal) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: meal["completed"]
                      ? Border.all(color: successColor, width: 2)
                      : null,
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Header with time and meal type
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getMealTypeColor(meal["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getMealTypeIcon(meal["type"]),
                            color: _getMealTypeColor(meal["type"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${meal["time"]} - ${meal["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${meal["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (meal["reminder"])
                          Icon(Icons.notifications, color: warningColor, size: 16),
                        SizedBox(width: spSm),
                        if (meal["completed"])
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(Icons.check, size: 16, color: Colors.white),
                          ),
                      ],
                    ),

                    // Meal details
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${meal["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _buildNutrientInfo("Calories", "${meal["calories"]}", "kcal")),
                                  Expanded(child: _buildNutrientInfo("Protein", "${meal["protein"]}", "g")),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: _buildNutrientInfo("Carbs", "${meal["carbs"]}", "g")),
                                  Expanded(child: _buildNutrientInfo("Fat", "${meal["fat"]}", "g")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Meal info
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${meal["prepTime"]} min",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.signal_cellular_4_bar, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${meal["difficulty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(meal["ingredients"] as List).length} ingredients",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: meal["completed"] ? "Completed" : "Mark Complete",
                            size: bs.sm,
                            onPressed: () {
                              meal["completed"] = !meal["completed"];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(String label, String current, String goal, String unit, Color color) {
    double progress = (double.tryParse(current) ?? 0) / (double.tryParse(goal) ?? 1);
    progress = progress > 1 ? 1 : progress;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                current,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                " / $goal $unit",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withAlpha(20),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "$value$unit",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getMealTypeColor(String type) {
    switch (type) {
      case "Breakfast":
        return warningColor;
      case "Lunch":
        return successColor;
      case "Dinner":
        return primaryColor;
      case "Snacks":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMealTypeIcon(String type) {
    switch (type) {
      case "Breakfast":
        return Icons.wb_sunny;
      case "Lunch":
        return Icons.wb_cloudy;
      case "Dinner":
        return Icons.nights_stay;
      case "Snacks":
        return Icons.local_cafe;
      default:
        return Icons.restaurant;
    }
  }
}

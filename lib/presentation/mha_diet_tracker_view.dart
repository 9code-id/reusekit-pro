import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDietTrackerView extends StatefulWidget {
  const MhaDietTrackerView({super.key});

  @override
  State<MhaDietTrackerView> createState() => _MhaDietTrackerViewState();
}

class _MhaDietTrackerViewState extends State<MhaDietTrackerView> {
  int currentTab = 0;
  Map<String, dynamic> dailyNutrition = {
    "calories": 1450,
    "targetCalories": 2000,
    "protein": 85,
    "targetProtein": 120,
    "carbs": 180,
    "targetCarbs": 250,
    "fat": 65,
    "targetFat": 78,
    "fiber": 18,
    "targetFiber": 25,
    "sugar": 45,
    "targetSugar": 50,
    "sodium": 1800,
    "targetSodium": 2300,
  };

  List<Map<String, dynamic>> todayMeals = [
    {
      "id": 1,
      "mealType": "Breakfast",
      "time": "08:00",
      "foods": [
        {
          "name": "Oatmeal with Berries",
          "quantity": "1 bowl",
          "calories": 320,
          "protein": 12,
          "carbs": 58,
          "fat": 6,
        },
        {
          "name": "Greek Yogurt",
          "quantity": "150g",
          "calories": 130,
          "protein": 15,
          "carbs": 8,
          "fat": 4,
        },
      ],
      "totalCalories": 450,
      "icon": Icons.free_breakfast,
      "color": warningColor,
    },
    {
      "id": 2,
      "mealType": "Lunch",
      "time": "12:30",
      "foods": [
        {
          "name": "Grilled Chicken Salad",
          "quantity": "1 large",
          "calories": 380,
          "protein": 35,
          "carbs": 15,
          "fat": 22,
        },
        {
          "name": "Whole Wheat Bread",
          "quantity": "2 slices",
          "calories": 160,
          "protein": 6,
          "carbs": 28,
          "fat": 3,
        },
      ],
      "totalCalories": 540,
      "icon": Icons.restaurant,
      "color": successColor,
    },
    {
      "id": 3,
      "mealType": "Snack",
      "time": "15:30",
      "foods": [
        {
          "name": "Apple",
          "quantity": "1 medium",
          "calories": 95,
          "protein": 0,
          "carbs": 25,
          "fat": 0,
        },
        {
          "name": "Almonds",
          "quantity": "20 pieces",
          "calories": 140,
          "protein": 5,
          "carbs": 5,
          "fat": 12,
        },
      ],
      "totalCalories": 235,
      "icon": Icons.fastfood,
      "color": infoColor,
    },
    {
      "id": 4,
      "mealType": "Dinner",
      "time": "19:00",
      "foods": [
        {
          "name": "Salmon Fillet",
          "quantity": "150g",
          "calories": 225,
          "protein": 22,
          "carbs": 0,
          "fat": 14,
        },
      ],
      "totalCalories": 225,
      "icon": Icons.dinner_dining,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {
      "day": "Mon",
      "calories": 1950,
      "targetCalories": 2000,
      "waterGlasses": 8,
    },
    {
      "day": "Tue",
      "calories": 1780,
      "targetCalories": 2000,
      "waterGlasses": 6,
    },
    {
      "day": "Wed",
      "calories": 2100,
      "targetCalories": 2000,
      "waterGlasses": 9,
    },
    {
      "day": "Thu",
      "calories": 1890,
      "targetCalories": 2000,
      "waterGlasses": 7,
    },
    {
      "day": "Fri",
      "calories": 2200,
      "targetCalories": 2000,
      "waterGlasses": 8,
    },
    {
      "day": "Sat",
      "calories": 1650,
      "targetCalories": 2000,
      "waterGlasses": 5,
    },
    {
      "day": "Sun",
      "calories": 1450,
      "targetCalories": 2000,
      "waterGlasses": 4,
    },
  ];

  List<Map<String, dynamic>> foodSuggestions = [
    {
      "name": "Grilled Chicken Breast",
      "calories": 165,
      "protein": 31,
      "carbs": 0,
      "fat": 3.6,
      "category": "Protein",
      "icon": Icons.restaurant,
      "color": successColor,
    },
    {
      "name": "Brown Rice",
      "calories": 111,
      "protein": 2.6,
      "carbs": 22,
      "fat": 0.9,
      "category": "Carbs",
      "icon": Icons.rice_bowl,
      "color": warningColor,
    },
    {
      "name": "Avocado",
      "calories": 160,
      "protein": 2,
      "carbs": 8.5,
      "fat": 14.7,
      "category": "Healthy Fat",
      "icon": Icons.eco,
      "color": primaryColor,
    },
    {
      "name": "Spinach",
      "calories": 23,
      "protein": 2.9,
      "carbs": 3.6,
      "fat": 0.4,
      "category": "Vegetable",
      "icon": Icons.eco,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Diet Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Nutrition", icon: Icon(Icons.pie_chart)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildNutritionTab(),
        _buildProgressTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCalorieOverview(),
          _buildTodayMeals(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildCalorieOverview() {
    int consumedCalories = dailyNutrition["calories"] as int;
    int targetCalories = dailyNutrition["targetCalories"] as int;
    int remainingCalories = targetCalories - consumedCalories;
    double progress = (consumedCalories / targetCalories).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Daily Calories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildCalorieCard("Consumed", "$consumedCalories", dangerColor),
              SizedBox(width: spSm),
              _buildCalorieCard("Remaining", "$remainingCalories", remainingCalories > 0 ? successColor : warningColor),
              SizedBox(width: spSm),
              _buildCalorieCard("Target", "$targetCalories", primaryColor),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: progress <= 1.0 ? successColor : warningColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progress <= 1.0 ? successColor : warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayMeals() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Meals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...todayMeals.map((meal) => _buildMealCard(meal)).toList(),
        ],
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    Color mealColor = meal["color"] as Color;
    List<Map<String, dynamic>> foods = meal["foods"] as List<Map<String, dynamic>>;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: mealColor.withAlpha(100),
          width: 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: mealColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  meal["icon"] as IconData,
                  color: mealColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${meal["mealType"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${meal["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${meal["totalCalories"]} calories",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: mealColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ...foods.map((food) {
            return Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          "${food["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${food["quantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Text(
                        "${food["calories"]} cal",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "P:${food["protein"]}g C:${food["carbs"]}g F:${food["fat"]}g",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Food",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('AddFoodView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditMealView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Scan Barcode",
                  icon: Icons.qr_code_scanner,
                  onPressed: () {
                    //navigateTo('BarcodeScannerView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Photo Food",
                  icon: Icons.camera_alt,
                  onPressed: () {
                    //navigateTo('PhotoFoodView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildNutritionBreakdown(),
          _buildFoodSuggestions(),
        ],
      ),
    );
  }

  Widget _buildNutritionBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Nutrition Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildNutrientBar("Protein", dailyNutrition["protein"] as int, dailyNutrition["targetProtein"] as int, "g", successColor),
          _buildNutrientBar("Carbs", dailyNutrition["carbs"] as int, dailyNutrition["targetCarbs"] as int, "g", warningColor),
          _buildNutrientBar("Fat", dailyNutrition["fat"] as int, dailyNutrition["targetFat"] as int, "g", infoColor),
          _buildNutrientBar("Fiber", dailyNutrition["fiber"] as int, dailyNutrition["targetFiber"] as int, "g", primaryColor),
          _buildNutrientBar("Sugar", dailyNutrition["sugar"] as int, dailyNutrition["targetSugar"] as int, "g", dangerColor),
          _buildNutrientBar("Sodium", dailyNutrition["sodium"] as int, dailyNutrition["targetSodium"] as int, "mg", warningColor),
        ],
      ),
    );
  }

  Widget _buildNutrientBar(String name, int current, int target, String unit, Color color) {
    double progress = (current / target).clamp(0.0, 1.0);
    bool exceeded = current > target;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "$current/$target $unit",
                style: TextStyle(
                  fontSize: 12,
                  color: exceeded ? dangerColor : disabledBoldColor,
                  fontWeight: exceeded ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: exceeded ? dangerColor : color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSuggestions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Food Suggestions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 160,
            children: foodSuggestions.map((food) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (food["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: food["color"] as Color,
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      food["icon"] as IconData,
                      color: food["color"] as Color,
                      size: 32,
                    ),
                    Text(
                      "${food["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${food["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${food["calories"]} cal",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "P:${food["protein"]}g C:${food["carbs"]}g F:${food["fat"]}g",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('AddFoodView')
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWeeklyCalorieProgress(),
          _buildNutritionTrends(),
        ],
      ),
    );
  }

  Widget _buildWeeklyCalorieProgress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Calorie Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: Column(
              spacing: spXs,
              children: weeklyProgress.map((day) {
                int calories = day["calories"] as int;
                int target = day["targetCalories"] as int;
                double progress = (calories / target).clamp(0.0, 1.5);
                Color barColor = progress <= 1.0 ? successColor : progress <= 1.2 ? warningColor : dangerColor;
                
                return Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (progress / 1.5).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "$calories",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTrends() {
    List<Map<String, dynamic>> trends = [
      {
        "nutrient": "Protein",
        "average": 78,
        "target": 120,
        "trend": "stable",
        "color": successColor,
      },
      {
        "nutrient": "Fiber",
        "average": 16,
        "target": 25,
        "trend": "increasing",
        "color": primaryColor,
      },
      {
        "nutrient": "Sugar",
        "average": 52,
        "target": 50,
        "trend": "decreasing",
        "color": dangerColor,
      },
      {
        "nutrient": "Sodium",
        "average": 2100,
        "target": 2300,
        "trend": "stable",
        "color": warningColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Nutrition Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...trends.map((trend) {
            IconData trendIcon;
            Color trendColor;
            
            switch (trend["trend"] as String) {
              case "increasing":
                trendIcon = Icons.trending_up;
                trendColor = successColor;
                break;
              case "decreasing":
                trendIcon = Icons.trending_down;
                trendColor = dangerColor;
                break;
              default:
                trendIcon = Icons.trending_flat;
                trendColor = infoColor;
            }
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (trend["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: trend["color"] as Color,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${trend["nutrient"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg: ${trend["average"]} | Target: ${trend["target"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    trendIcon,
                    color: trendColor,
                    size: 24,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

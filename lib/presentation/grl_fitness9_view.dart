import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness9View extends StatefulWidget {
  @override
  State<GrlFitness9View> createState() => _GrlFitness9ViewState();
}

class _GrlFitness9ViewState extends State<GrlFitness9View> {
  int selectedTab = 0;
  String selectedMealType = "All";

  List<String> mealTypes = ["All", "Breakfast", "Lunch", "Dinner", "Snack"];

  Map<String, dynamic> dailyNutrition = {
    "totalCalories": 1850,
    "targetCalories": 2000,
    "protein": 125,
    "targetProtein": 150,
    "carbs": 220,
    "targetCarbs": 250,
    "fat": 65,
    "targetFat": 70,
    "water": 2.1,
    "targetWater": 2.5,
  };

  List<Map<String, dynamic>> todayMeals = [
    {
      "type": "Breakfast",
      "name": "Oatmeal with Berries",
      "calories": 320,
      "protein": 12,
      "carbs": 58,
      "fat": 6,
      "time": "8:00 AM",
      "image": "https://picsum.photos/100/100?random=1&keyword=oatmeal",
    },
    {
      "type": "Snack",
      "name": "Greek Yogurt",
      "calories": 150,
      "protein": 15,
      "carbs": 12,
      "fat": 5,
      "time": "10:30 AM",
      "image": "https://picsum.photos/100/100?random=2&keyword=yogurt",
    },
    {
      "type": "Lunch",
      "name": "Grilled Chicken Salad",
      "calories": 450,
      "protein": 35,
      "carbs": 20,
      "fat": 25,
      "time": "1:00 PM",
      "image": "https://picsum.photos/100/100?random=3&keyword=salad",
    },
    {
      "type": "Snack",
      "name": "Mixed Nuts",
      "calories": 180,
      "protein": 6,
      "carbs": 8,
      "fat": 15,
      "time": "3:30 PM",
      "image": "https://picsum.photos/100/100?random=4&keyword=nuts",
    },
    {
      "type": "Dinner",
      "name": "Salmon with Quinoa",
      "calories": 520,
      "protein": 38,
      "carbs": 45,
      "fat": 22,
      "time": "7:00 PM",
      "image": "https://picsum.photos/100/100?random=5&keyword=salmon",
    },
    {
      "type": "Snack",
      "name": "Apple with Almond Butter",
      "calories": 230,
      "protein": 8,
      "carbs": 25,
      "fat": 12,
      "time": "9:00 PM",
      "image": "https://picsum.photos/100/100?random=6&keyword=apple",
    },
  ];

  List<Map<String, dynamic>> nutritionTips = [
    {
      "title": "Stay Hydrated",
      "description": "Drink at least 8 glasses of water daily for optimal metabolism",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "title": "Protein Power",
      "description": "Include protein in every meal to support muscle growth and satiety",
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "title": "Balanced Meals",
      "description": "Combine complex carbs, lean protein, and healthy fats",
      "icon": Icons.balance,
      "color": warningColor,
    },
    {
      "title": "Portion Control",
      "description": "Use smaller plates and listen to your hunger cues",
      "icon": Icons.restaurant,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMeals = selectedMealType == "All" 
        ? todayMeals 
        : todayMeals.where((meal) => meal["type"] == selectedMealType).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Nutrition",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${dailyNutrition["totalCalories"]}/${dailyNutrition["targetCalories"]} cal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (dailyNutrition["totalCalories"] as int) / (dailyNutrition["targetCalories"] as int),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildNutrientCard(
                        "Protein", 
                        dailyNutrition["protein"] as int, 
                        dailyNutrition["targetProtein"] as int, 
                        "g",
                        successColor
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildNutrientCard(
                        "Carbs", 
                        dailyNutrition["carbs"] as int, 
                        dailyNutrition["targetCarbs"] as int, 
                        "g",
                        warningColor
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildNutrientCard(
                        "Fat", 
                        dailyNutrition["fat"] as int, 
                        dailyNutrition["targetFat"] as int, 
                        "g",
                        dangerColor
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Water Intake",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${dailyNutrition["water"]}L / ${dailyNutrition["targetWater"]}L",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mealTypes.length,
              itemBuilder: (context, index) {
                final mealType = mealTypes[index];
                final isSelected = selectedMealType == mealType;
                
                return GestureDetector(
                  onTap: () {
                    selectedMealType = mealType;
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
                        mealType,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(spMd),
              children: [
                if (filteredMeals.isNotEmpty) ...[
                  ...List.generate(filteredMeals.length, (index) {
                    final meal = filteredMeals[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
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
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getMealTypeColor(meal["type"] as String).withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${meal["type"]}",
                                        style: TextStyle(
                                          color: _getMealTypeColor(meal["type"] as String),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${meal["time"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${meal["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${meal["calories"]} cal",
                                      style: TextStyle(
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "P: ${meal["protein"]}g",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "C: ${meal["carbs"]}g",
                                      style: TextStyle(
                                        color: warningColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "F: ${meal["fat"]}g",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }),
                ] else ...[
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No meals logged",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Add your first meal to start tracking",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spLg),
                Text(
                  "Nutrition Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...List.generate(nutritionTips.length, (index) {
                  final tip = nutritionTips[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(color: (tip["color"] as Color).withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (tip["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            tip["icon"] as IconData,
                            color: tip["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tip["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: tip["color"] as Color,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${tip["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildNutrientCard(String name, int current, int target, String unit, Color color) {
    final progress = current / target;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$current$unit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress > 1 ? 1 : progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return warningColor;
      case 'lunch':
        return primaryColor;
      case 'dinner':
        return dangerColor;
      case 'snack':
        return successColor;
      default:
        return primaryColor;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaFoodDiaryView extends StatefulWidget {
  const FwaFoodDiaryView({super.key});

  @override
  State<FwaFoodDiaryView> createState() => _FwaFoodDiaryViewState();
}

class _FwaFoodDiaryViewState extends State<FwaFoodDiaryView> {
  DateTime selectedDate = DateTime.now();
  String selectedMeal = "Breakfast";
  
  final List<String> mealTypes = ["Breakfast", "Lunch", "Dinner", "Snacks"];
  
  final Map<String, List<Map<String, dynamic>>> foodEntries = {
    "Breakfast": [
      {
        "name": "Oatmeal with Berries",
        "calories": 280,
        "protein": 8.5,
        "carbs": 54.0,
        "fat": 5.2,
        "image": "https://picsum.photos/60/60?random=1&keyword=oatmeal",
        "quantity": "1 bowl",
        "time": "08:30 AM",
      },
      {
        "name": "Greek Yogurt",
        "calories": 150,
        "protein": 15.0,
        "carbs": 12.0,
        "fat": 4.0,
        "image": "https://picsum.photos/60/60?random=2&keyword=yogurt",
        "quantity": "1 cup",
        "time": "09:00 AM",
      },
    ],
    "Lunch": [
      {
        "name": "Grilled Chicken Salad",
        "calories": 420,
        "protein": 35.0,
        "carbs": 15.0,
        "fat": 25.0,
        "image": "https://picsum.photos/60/60?random=3&keyword=salad",
        "quantity": "1 serving",
        "time": "12:30 PM",
      },
      {
        "name": "Quinoa Bowl",
        "calories": 350,
        "protein": 14.0,
        "carbs": 58.0,
        "fat": 8.5,
        "image": "https://picsum.photos/60/60?random=4&keyword=quinoa",
        "quantity": "1 cup",
        "time": "01:00 PM",
      },
    ],
    "Dinner": [
      {
        "name": "Baked Salmon",
        "calories": 380,
        "protein": 40.0,
        "carbs": 0.0,
        "fat": 22.0,
        "image": "https://picsum.photos/60/60?random=5&keyword=salmon",
        "quantity": "6 oz",
        "time": "07:00 PM",
      },
    ],
    "Snacks": [
      {
        "name": "Apple with Almonds",
        "calories": 190,
        "protein": 6.0,
        "carbs": 25.0,
        "fat": 9.0,
        "image": "https://picsum.photos/60/60?random=6&keyword=apple",
        "quantity": "1 medium + 15 nuts",
        "time": "03:30 PM",
      },
    ],
  };

  int get totalCalories {
    return foodEntries.values
        .expand((entries) => entries)
        .fold(0, (sum, entry) => sum + (entry["calories"] as int));
  }

  double get totalProtein {
    return foodEntries.values
        .expand((entries) => entries)
        .fold(0.0, (sum, entry) => sum + (entry["protein"] as double));
  }

  double get totalCarbs {
    return foodEntries.values
        .expand((entries) => entries)
        .fold(0.0, (sum, entry) => sum + (entry["carbs"] as double));
  }

  double get totalFat {
    return foodEntries.values
        .expand((entries) => entries)
        .fold(0.0, (sum, entry) => sum + (entry["fat"] as double));
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              selectedDate = selectedDate.subtract(Duration(days: 1));
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.chevron_left,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${selectedDate.dMMMy}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Food Diary",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedDate.isBefore(DateTime.now())) {
                selectedDate = selectedDate.add(Duration(days: 1));
                setState(() {});
              }
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: selectedDate.isBefore(DateTime.now())
                    ? disabledColor.withAlpha(20)
                    : disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.chevron_right,
                color: selectedDate.isBefore(DateTime.now())
                    ? primaryColor
                    : disabledColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Daily Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Calories Progress
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Calories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$totalCalories / 2000 kcal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: totalCalories / 2000,
                  backgroundColor: disabledColor.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          // Macros Row
          Row(
            children: [
              _buildMacroCard("Protein", "${totalProtein.toStringAsFixed(1)}g", "150g", successColor),
              SizedBox(width: spSm),
              _buildMacroCard("Carbs", "${totalCarbs.toStringAsFixed(1)}g", "250g", warningColor),
              SizedBox(width: spSm),
              _buildMacroCard("Fat", "${totalFat.toStringAsFixed(1)}g", "67g", dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCard(String title, String current, String target, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              current,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              "/ $target",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTabs() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: mealTypes.map((meal) {
          bool isSelected = selectedMeal == meal;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedMeal = meal;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                margin: EdgeInsets.only(right: meal != mealTypes.last ? spXs : 0),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: isSelected ? [shadowSm] : [],
                  border: !isSelected
                      ? Border.all(color: disabledColor.withAlpha(30))
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      meal,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(foodEntries[meal] ?? []).fold(0, (sum, entry) => sum + (entry["calories"] as int))} cal",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFoodEntries() {
    final entries = foodEntries[selectedMeal] ?? [];
    
    if (entries.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.restaurant,
              size: 48,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No food entries for $selectedMeal",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Tap the + button to add your first meal",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

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
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  selectedMeal,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${entries.fold(0, (sum, entry) => sum + (entry["calories"] as int))} calories",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: entries.map((entry) => _buildFoodEntry(entry)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodEntry(Map<String, dynamic> entry) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: disabledColor.withAlpha(20),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Food Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${entry["image"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          
          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${entry["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${entry["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${entry["quantity"]} • ${entry["calories"]} cal",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildNutrientTag("P: ${(entry["protein"] as double).toStringAsFixed(1)}g", successColor),
                    SizedBox(width: spXs),
                    _buildNutrientTag("C: ${(entry["carbs"] as double).toStringAsFixed(1)}g", warningColor),
                    SizedBox(width: spXs),
                    _buildNutrientTag("F: ${(entry["fat"] as double).toStringAsFixed(1)}g", dangerColor),
                  ],
                ),
              ],
            ),
          ),
          
          // Actions
          GestureDetector(
            onTap: () {
              // Edit food entry
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Diary"),
        actions: [
          GestureDetector(
            onTap: () {
              // Open insights/analytics
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.analytics,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildDateSelector(),
            _buildNutritionSummary(),
            _buildMealTabs(),
            _buildFoodEntries(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new food entry
          // ss('Next page'));
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

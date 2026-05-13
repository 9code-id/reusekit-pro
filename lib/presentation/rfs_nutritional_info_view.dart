import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsNutritionalInfoView extends StatefulWidget {
  const RfsNutritionalInfoView({super.key});

  @override
  State<RfsNutritionalInfoView> createState() => _RfsNutritionalInfoViewState();
}

class _RfsNutritionalInfoViewState extends State<RfsNutritionalInfoView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDiet = "All";
  String selectedNutrient = "All";

  final List<Map<String, dynamic>> dietItems = [
    {"label": "All", "value": "All"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Vegan", "value": "Vegan"},
    {"label": "Keto", "value": "Keto"},
    {"label": "Low Carb", "value": "Low Carb"},
    {"label": "High Protein", "value": "High Protein"},
    {"label": "Gluten Free", "value": "Gluten Free"},
  ];

  final List<Map<String, dynamic>> nutrientItems = [
    {"label": "All", "value": "All"},
    {"label": "High Protein", "value": "High Protein"},
    {"label": "High Fiber", "value": "High Fiber"},
    {"label": "Low Sodium", "value": "Low Sodium"},
    {"label": "High Calcium", "value": "High Calcium"},
    {"label": "Rich in Iron", "value": "Rich in Iron"},
  ];

  final List<Map<String, dynamic>> dishes = [
    {
      "id": 1,
      "name": "Grilled Salmon with Quinoa",
      "category": "Main Course",
      "servingSize": "1 plate (300g)",
      "calories": 485,
      "protein": 38.5,
      "carbs": 42.0,
      "fat": 18.5,
      "fiber": 5.2,
      "sugar": 3.1,
      "sodium": 320,
      "calcium": 85,
      "iron": 2.8,
      "vitaminA": 12,
      "vitaminC": 8,
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon",
      "dietaryInfo": ["High Protein", "Gluten Free", "Omega-3 Rich"],
      "allergens": ["Fish"],
      "healthScore": 92,
      "description": "Perfectly grilled salmon fillet served with nutrient-rich quinoa and seasonal vegetables"
    },
    {
      "id": 2,
      "name": "Mediterranean Chickpea Salad",
      "category": "Appetizer",
      "servingSize": "1 bowl (250g)",
      "calories": 285,
      "protein": 12.8,
      "carbs": 38.2,
      "fat": 9.5,
      "fiber": 11.2,
      "sugar": 8.4,
      "sodium": 280,
      "calcium": 95,
      "iron": 3.6,
      "vitaminA": 18,
      "vitaminC": 24,
      "image": "https://picsum.photos/300/200?random=2&keyword=salad",
      "dietaryInfo": ["Vegan", "High Fiber", "High Protein"],
      "allergens": [],
      "healthScore": 88,
      "description": "Fresh chickpea salad with vegetables, herbs, and olive oil dressing"
    },
    {
      "id": 3,
      "name": "Avocado Toast with Poached Egg",
      "category": "Breakfast",
      "servingSize": "2 slices (180g)",
      "calories": 365,
      "protein": 18.2,
      "carbs": 32.0,
      "fat": 21.5,
      "fiber": 12.8,
      "sugar": 2.8,
      "sodium": 420,
      "calcium": 120,
      "iron": 3.2,
      "vitaminA": 15,
      "vitaminC": 12,
      "image": "https://picsum.photos/300/200?random=3&keyword=avocado",
      "dietaryInfo": ["Vegetarian", "High Fiber", "High Protein"],
      "allergens": ["Eggs", "Gluten"],
      "healthScore": 85,
      "description": "Creamy avocado spread on whole grain toast topped with perfectly poached egg"
    },
    {
      "id": 4,
      "name": "Keto Beef Stir Fry",
      "category": "Main Course",
      "servingSize": "1 plate (280g)",
      "calories": 420,
      "protein": 32.5,
      "carbs": 8.2,
      "fat": 28.8,
      "fiber": 3.5,
      "sugar": 4.2,
      "sodium": 580,
      "calcium": 65,
      "iron": 4.2,
      "vitaminA": 22,
      "vitaminC": 28,
      "image": "https://picsum.photos/300/200?random=4&keyword=beef",
      "dietaryInfo": ["Keto", "Low Carb", "High Protein"],
      "allergens": [],
      "healthScore": 78,
      "description": "Tender beef strips stir-fried with low-carb vegetables in savory sauce"
    },
    {
      "id": 5,
      "name": "Quinoa Buddha Bowl",
      "category": "Main Course",
      "servingSize": "1 bowl (350g)",
      "calories": 385,
      "protein": 16.8,
      "carbs": 58.2,
      "fat": 12.5,
      "fiber": 14.2,
      "sugar": 12.8,
      "sodium": 240,
      "calcium": 145,
      "iron": 4.8,
      "vitaminA": 35,
      "vitaminC": 42,
      "image": "https://picsum.photos/300/200?random=5&keyword=bowl",
      "dietaryInfo": ["Vegan", "High Fiber", "Gluten Free"],
      "allergens": [],
      "healthScore": 94,
      "description": "Nutrient-packed bowl with quinoa, roasted vegetables, and tahini dressing"
    },
    {
      "id": 6,
      "name": "Greek Yogurt Parfait",
      "category": "Dessert",
      "servingSize": "1 cup (200g)",
      "calories": 245,
      "protein": 18.5,
      "carbs": 28.2,
      "fat": 8.2,
      "fiber": 4.8,
      "sugar": 22.5,
      "sodium": 85,
      "calcium": 280,
      "iron": 0.8,
      "vitaminA": 8,
      "vitaminC": 15,
      "image": "https://picsum.photos/300/200?random=6&keyword=yogurt",
      "dietaryInfo": ["Vegetarian", "High Protein", "High Calcium"],
      "allergens": ["Dairy"],
      "healthScore": 82,
      "description": "Creamy Greek yogurt layered with fresh berries and granola"
    }
  ];

  List<Map<String, dynamic>> get filteredDishes {
    return dishes.where((dish) {
      bool matchesSearch = dish["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDiet = selectedDiet == "All" || (dish["dietaryInfo"] as List).contains(selectedDiet);
      bool matchesNutrient = selectedNutrient == "All" || (dish["dietaryInfo"] as List).contains(selectedNutrient);
      
      return matchesSearch && matchesDiet && matchesNutrient;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Nutritional Information",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Menu Items", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Guidelines", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildMenuItemsTab(),
        _buildAnalyticsTab(),
        _buildGuidelinesTab(),
      ],
    );
  }

  Widget _buildMenuItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildNutritionOverview(),
          _buildDishList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search dishes...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Diet Type",
                items: dietItems,
                value: selectedDiet,
                onChanged: (value, label) {
                  selectedDiet = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Nutrient Focus",
                items: nutrientItems,
                value: selectedNutrient,
                onChanged: (value, label) {
                  selectedNutrient = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNutritionOverview() {
    double avgCalories = dishes.map((d) => d["calories"] as int).reduce((a, b) => a + b) / dishes.length;
    double avgProtein = dishes.map((d) => d["protein"] as double).reduce((a, b) => a + b) / dishes.length;
    double avgHealthScore = dishes.map((d) => d["healthScore"] as int).reduce((a, b) => a + b) / dishes.length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "${avgCalories.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Calories",
                  style: TextStyle(
                    fontSize: 12,
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "${avgProtein.toStringAsFixed(1)}g",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Avg Protein",
                  style: TextStyle(
                    fontSize: 12,
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
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "${avgHealthScore.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Health Score",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDishList() {
    return Column(
      spacing: spSm,
      children: filteredDishes.map((dish) {
        return _buildDishCard(dish);
      }).toList(),
    );
  }

  Widget _buildDishCard(Map<String, dynamic> dish) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${dish["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
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
                    Expanded(
                      child: Text(
                        "${dish["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getHealthScoreColor(dish["healthScore"] as int),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${dish["healthScore"]}%",
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
                  "${dish["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Serving: ${dish["servingSize"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    _buildMacroInfo("Cal", "${dish["calories"]}", dangerColor),
                    SizedBox(width: spSm),
                    _buildMacroInfo("Protein", "${dish["protein"]}g", successColor),
                    SizedBox(width: spSm),
                    _buildMacroInfo("Carbs", "${dish["carbs"]}g", warningColor),
                    SizedBox(width: spSm),
                    _buildMacroInfo("Fat", "${dish["fat"]}g", infoColor),
                  ],
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (dish["dietaryInfo"] as List<dynamic>).take(3).map((info) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$info",
                        style: TextStyle(
                          fontSize: 9,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              _showNutritionDetails(dish);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMacroInfo(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getHealthScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    if (score >= 70) return infoColor;
    return dangerColor;
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildNutrientDistribution(),
          _buildDietaryStats(),
          _buildHealthScoreStats(),
        ],
      ),
    );
  }

  Widget _buildNutrientDistribution() {
    return Container(
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
          Text(
            "Average Nutrient Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildNutrientBar("Protein", dishes.map((d) => d["protein"] as double).reduce((a, b) => a + b) / dishes.length, successColor, "g"),
          _buildNutrientBar("Carbs", dishes.map((d) => d["carbs"] as double).reduce((a, b) => a + b) / dishes.length, warningColor, "g"),
          _buildNutrientBar("Fat", dishes.map((d) => d["fat"] as double).reduce((a, b) => a + b) / dishes.length, infoColor, "g"),
          _buildNutrientBar("Fiber", dishes.map((d) => d["fiber"] as double).reduce((a, b) => a + b) / dishes.length, primaryColor, "g"),
          _buildNutrientBar("Sodium", dishes.map((d) => d["sodium"] as int).reduce((a, b) => a + b) / dishes.length, dangerColor, "mg"),
        ],
      ),
    );
  }

  Widget _buildNutrientBar(String label, double value, Color color, String unit) {
    double maxValue = label == "Sodium" ? 600 : 60;
    
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (value / maxValue).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          "${value.toStringAsFixed(1)}$unit",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDietaryStats() {
    final dietaryStats = <String, int>{};
    for (var dish in dishes) {
      for (var diet in dish["dietaryInfo"] as List) {
        dietaryStats[diet] = (dietaryStats[diet] ?? 0) + 1;
      }
    }

    return Container(
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
          Text(
            "Dietary Options Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: dietaryStats.entries.map((entry) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${entry.value}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildHealthScoreStats() {
    final healthRanges = <String, int>{
      "Excellent (90-100)": dishes.where((d) => (d["healthScore"] as int) >= 90).length,
      "Good (80-89)": dishes.where((d) => (d["healthScore"] as int) >= 80 && (d["healthScore"] as int) < 90).length,
      "Fair (70-79)": dishes.where((d) => (d["healthScore"] as int) >= 70 && (d["healthScore"] as int) < 80).length,
      "Poor (< 70)": dishes.where((d) => (d["healthScore"] as int) < 70).length,
    };

    return Container(
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
          Text(
            "Health Score Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...healthRanges.entries.map((entry) {
            Color color = successColor;
            if (entry.key.contains("Good")) color = warningColor;
            if (entry.key.contains("Fair")) color = infoColor;
            if (entry.key.contains("Poor")) color = dangerColor;

            return Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: entry.value / dishes.length,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "${entry.value}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGuidelinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildNutritionGuidelines(),
          _buildDietaryGuidelines(),
          _buildAllergenInfo(),
        ],
      ),
    );
  }

  Widget _buildNutritionGuidelines() {
    final guidelines = [
      {"title": "Daily Calorie Intake", "content": "Adults: 2000-2500 calories/day\nChildren: 1500-2000 calories/day\nSeniors: 1800-2200 calories/day"},
      {"title": "Protein Requirements", "content": "Adults: 0.8g per kg body weight\nAthletes: 1.2-2.0g per kg body weight\nPregnant women: Additional 25g/day"},
      {"title": "Carbohydrate Guidelines", "content": "45-65% of total daily calories\nFocus on complex carbohydrates\nLimit simple sugars to <10% daily calories"},
      {"title": "Fat Recommendations", "content": "20-35% of total daily calories\nSaturated fats: <10% of daily calories\nTrans fats: Minimize consumption"},
    ];

    return Container(
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
          Text(
            "Nutrition Guidelines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...guidelines.map((guideline) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${guideline["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${guideline["content"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spXs),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDietaryGuidelines() {
    final dietTypes = [
      {"name": "Vegetarian", "description": "No meat, poultry, or fish. May include dairy and eggs.", "color": successColor},
      {"name": "Vegan", "description": "No animal products including meat, dairy, eggs, or honey.", "color": primaryColor},
      {"name": "Keto", "description": "Very low carb (5-10%), moderate protein, high fat (70-80%).", "color": warningColor},
      {"name": "Gluten Free", "description": "No wheat, barley, rye, or other gluten-containing grains.", "color": infoColor},
      {"name": "Low Sodium", "description": "Less than 2,300mg sodium per day, ideally under 1,500mg.", "color": dangerColor},
    ];

    return Container(
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
          Text(
            "Dietary Restrictions Guide",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...dietTypes.map((diet) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (diet["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: diet["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${diet["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: diet["color"] as Color,
                          ),
                        ),
                        Text(
                          "${diet["description"]}",
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAllergenInfo() {
    final allergens = [
      {"name": "Nuts", "icon": Icons.warning, "description": "Tree nuts, peanuts"},
      {"name": "Dairy", "icon": Icons.warning, "description": "Milk, cheese, yogurt"},
      {"name": "Gluten", "icon": Icons.warning, "description": "Wheat, barley, rye"},
      {"name": "Eggs", "icon": Icons.warning, "description": "All egg products"},
      {"name": "Fish", "icon": Icons.warning, "description": "All fish and seafood"},
      {"name": "Soy", "icon": Icons.warning, "description": "Soybeans and soy products"},
    ];

    return Container(
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
          Text(
            "Common Allergens",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: allergens.map((allergen) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      allergen["icon"] as IconData,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${allergen["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${allergen["description"]}",
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
    );
  }

  void _showNutritionDetails(Map<String, dynamic> dish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${dish["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${dish["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Serving Size: ${dish["servingSize"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              _buildDetailRow("Calories", "${dish["calories"]}", "kcal"),
              _buildDetailRow("Protein", "${dish["protein"]}", "g"),
              _buildDetailRow("Carbohydrates", "${dish["carbs"]}", "g"),
              _buildDetailRow("Fat", "${dish["fat"]}", "g"),
              _buildDetailRow("Fiber", "${dish["fiber"]}", "g"),
              _buildDetailRow("Sugar", "${dish["sugar"]}", "g"),
              _buildDetailRow("Sodium", "${dish["sodium"]}", "mg"),
              _buildDetailRow("Calcium", "${dish["calcium"]}", "mg"),
              _buildDetailRow("Iron", "${dish["iron"]}", "mg"),
              SizedBox(height: spSm),
              Text(
                "Dietary Information:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: spXs,
                children: (dish["dietaryInfo"] as List).map((info) {
                  return Container(
                    margin: EdgeInsets.only(top: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$info",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String unit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "$value $unit",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaIngredientsView extends StatefulWidget {
  const FdaIngredientsView({super.key});

  @override
  State<FdaIngredientsView> createState() => _FdaIngredientsViewState();
}

class _FdaIngredientsViewState extends State<FdaIngredientsView> {
  List<Map<String, dynamic>> ingredients = [
    {
      "name": "Fresh Tomatoes",
      "quantity": "2 pieces",
      "category": "Vegetables",
      "allergen": false,
      "nutritional_value": "Rich in Vitamin C and Lycopene",
      "icon": Icons.local_florist,
    },
    {
      "name": "Mozzarella Cheese",
      "quantity": "100g",
      "category": "Dairy",
      "allergen": true,
      "allergen_type": "Dairy",
      "nutritional_value": "High in Protein and Calcium",
      "icon": Icons.cake,
    },
    {
      "name": "Fresh Basil",
      "quantity": "5-6 leaves",
      "category": "Herbs",
      "allergen": false,
      "nutritional_value": "Rich in Antioxidants",
      "icon": Icons.eco,
    },
    {
      "name": "Olive Oil",
      "quantity": "2 tbsp",
      "category": "Oil",
      "allergen": false,
      "nutritional_value": "Healthy Monounsaturated Fats",
      "icon": Icons.opacity,
    },
    {
      "name": "Wheat Flour",
      "quantity": "200g",
      "category": "Grains",
      "allergen": true,
      "allergen_type": "Gluten",
      "nutritional_value": "Source of Carbohydrates",
      "icon": Icons.grain,
    },
    {
      "name": "Sea Salt",
      "quantity": "1 tsp",
      "category": "Seasoning",
      "allergen": false,
      "nutritional_value": "Essential Minerals",
      "icon": Icons.circle,
    },
    {
      "name": "Black Pepper",
      "quantity": "1/2 tsp",
      "category": "Spices",
      "allergen": false,
      "nutritional_value": "Antioxidants and Piperine",
      "icon": Icons.circle_outlined,
    },
    {
      "name": "Garlic",
      "quantity": "2 cloves",
      "category": "Vegetables",
      "allergen": false,
      "nutritional_value": "Antimicrobial Properties",
      "icon": Icons.local_florist,
    },
  ];

  String selectedCategory = "All";
  bool showAllergens = true;

  List<String> categories = [
    "All",
    "Vegetables",
    "Dairy", 
    "Herbs",
    "Oil",
    "Grains",
    "Seasoning",
    "Spices"
  ];

  List<Map<String, dynamic>> get filteredIngredients {
    var filtered = ingredients;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((ingredient) => 
        ingredient["category"] == selectedCategory).toList();
    }
    
    if (!showAllergens) {
      filtered = filtered.where((ingredient) => 
        !(ingredient["allergen"] as bool)).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredients"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showNutritionalInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Item Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.local_pizza,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Margherita Pizza",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Classic Italian pizza with fresh ingredients",
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

            SizedBox(height: spLg),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Ingredients (${filteredIngredients.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: showAllergens ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: showAllergens ? dangerColor : successColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        showAllergens ? Icons.warning : Icons.check_circle,
                        color: showAllergens ? dangerColor : successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        showAllergens ? "Show Allergens" : "Hide Allergens",
                        style: TextStyle(
                          fontSize: 12,
                          color: showAllergens ? dangerColor : successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Category Filter
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            // Allergen Toggle
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show allergen ingredients",
                        "value": true,
                        "checked": showAllergens,
                      }
                    ],
                    value: [
                      if (showAllergens)
                        {
                          "label": "Show allergen ingredients",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showAllergens = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Ingredients List
            ...filteredIngredients.map((ingredient) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: (ingredient["allergen"] as bool) 
                        ? dangerColor.withAlpha(100)
                        : disabledOutlineBorderColor,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (ingredient["allergen"] as bool)
                            ? dangerColor.withAlpha(20)
                            : primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        ingredient["icon"] as IconData,
                        color: (ingredient["allergen"] as bool)
                            ? dangerColor
                            : primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${ingredient["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (ingredient["allergen"] as bool) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "ALLERGEN",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${ingredient["category"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${ingredient["quantity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (ingredient["allergen"] as bool && 
                              ingredient.containsKey("allergen_type")) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Contains: ${ingredient["allergen_type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          SizedBox(height: spXs),
                          Text(
                            "${ingredient["nutritional_value"]}",
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

            SizedBox(height: spLg),

            // Nutritional Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Nutritional Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "This dish contains a balanced mix of carbohydrates, proteins, and healthy fats. The fresh vegetables provide essential vitamins and minerals.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "View Detailed Nutrition Facts",
                    size: bs.sm,
                    onPressed: () {
                      _showDetailedNutrition();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNutritionalInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nutritional Benefits"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Rich in vitamins A, C, and K"),
            Text("• High in antioxidants"),
            Text("• Good source of protein and calcium"),
            Text("• Contains healthy monounsaturated fats"),
            Text("• Provides essential minerals"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showDetailedNutrition() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nutrition Facts"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNutritionRow("Calories", "320 kcal"),
            _buildNutritionRow("Protein", "14g"),
            _buildNutritionRow("Carbohydrates", "35g"),
            _buildNutritionRow("Fat", "12g"),
            _buildNutritionRow("Fiber", "3g"),
            _buildNutritionRow("Sodium", "680mg"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

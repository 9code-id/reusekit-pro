import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaRecipeDetailView extends StatefulWidget {
  const FwaRecipeDetailView({super.key});

  @override
  State<FwaRecipeDetailView> createState() => _FwaRecipeDetailViewState();
}

class _FwaRecipeDetailViewState extends State<FwaRecipeDetailView> {
  bool isFavorite = false;
  bool isServingSizeExpanded = false;
  int selectedServings = 2;
  
  final Map<String, dynamic> recipe = {
    "id": "1",
    "name": "Grilled Chicken & Quinoa Bowl",
    "image": "https://picsum.photos/400/300?random=1&keyword=healthy-food",
    "calories": 485,
    "protein": 35,
    "carbs": 45,
    "fat": 12,
    "fiber": 8,
    "sugar": 6,
    "sodium": 320,
    "cookTime": 25,
    "prepTime": 15,
    "difficulty": "Medium",
    "servings": 2,
    "rating": 4.8,
    "reviews": 156,
    "description": "A nutritious and delicious bowl featuring perfectly grilled chicken breast over fluffy quinoa, topped with fresh vegetables and a light vinaigrette.",
    "chef": {
      "name": "Chef Sarah Martinez",
      "image": "https://picsum.photos/60/60?random=2&keyword=chef",
      "verified": true
    }
  };

  final List<Map<String, dynamic>> ingredients = [
    {"item": "Chicken breast", "amount": "300g", "calories": 165},
    {"item": "Quinoa", "amount": "1 cup", "calories": 222},
    {"item": "Mixed greens", "amount": "2 cups", "calories": 20},
    {"item": "Cherry tomatoes", "amount": "150g", "calories": 27},
    {"item": "Cucumber", "amount": "1 medium", "calories": 16},
    {"item": "Avocado", "amount": "1/2 piece", "calories": 120},
    {"item": "Olive oil", "amount": "2 tbsp", "calories": 240},
    {"item": "Lemon juice", "amount": "2 tbsp", "calories": 8},
    {"item": "Garlic", "amount": "2 cloves", "calories": 8},
    {"item": "Salt & pepper", "amount": "to taste", "calories": 0}
  ];

  final List<Map<String, dynamic>> instructions = [
    {"step": 1, "instruction": "Rinse quinoa under cold water and cook according to package directions. Set aside to cool."},
    {"step": 2, "instruction": "Season chicken breast with salt, pepper, and garlic powder. Let marinate for 10 minutes."},
    {"step": 3, "instruction": "Heat grill pan over medium-high heat. Cook chicken for 6-7 minutes per side until internal temperature reaches 165°F."},
    {"step": 4, "instruction": "While chicken cooks, prepare vegetables by washing and chopping tomatoes, cucumber, and greens."},
    {"step": 5, "instruction": "Make dressing by whisking together olive oil, lemon juice, minced garlic, salt and pepper."},
    {"step": 6, "instruction": "Let chicken rest for 5 minutes, then slice into strips."},
    {"step": 7, "instruction": "Assemble bowls by dividing quinoa between two bowls, topping with greens, vegetables, and sliced chicken."},
    {"step": 8, "instruction": "Drizzle with dressing and garnish with sliced avocado. Serve immediately."}
  ];

  final List<Map<String, dynamic>> nutritionTips = [
    {"tip": "High in complete protein", "icon": Icons.fitness_center},
    {"tip": "Rich in fiber for digestion", "icon": Icons.eco},
    {"tip": "Contains heart-healthy fats", "icon": Icons.favorite},
    {"tip": "Low in saturated fat", "icon": Icons.check_circle}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              ss(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Recipe shared!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${recipe["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Recipe Title & Info
            Text(
              "${recipe["name"]}",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Chef Info
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${recipe["chef"]["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${recipe["chef"]["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          if (recipe["chef"]["verified"] as bool)
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: successColor,
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: warningColor),
                          SizedBox(width: spXs),
                          Text(
                            "${(recipe["rating"] as double).toStringAsFixed(1)} (${recipe["reviews"]} reviews)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Quick Info Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: primaryColor, size: 20),
                        SizedBox(height: spXs),
                        Text(
                          "${(recipe["prepTime"] as int) + (recipe["cookTime"] as int)} min",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Time",
                          style: TextStyle(
                            fontSize: 10,
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.local_fire_department, color: warningColor, size: 20),
                        SizedBox(height: spXs),
                        Text(
                          "${recipe["calories"]} cal",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Per Serving",
                          style: TextStyle(
                            fontSize: 10,
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.restaurant, color: successColor, size: 20),
                        SizedBox(height: spXs),
                        Text(
                          "${recipe["difficulty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Difficulty",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Serving Size Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Servings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedServings > 1) {
                                selectedServings--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: selectedServings > 1 ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            width: 40,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "$selectedServings",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              if (selectedServings < 10) {
                                selectedServings++;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: selectedServings < 10 ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Nutrition Facts
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nutrition Facts (per serving)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((recipe["calories"] as int) * selectedServings / (recipe["servings"] as int)).round()}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((recipe["protein"] as int) * selectedServings / (recipe["servings"] as int)).round()}g",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Protein",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((recipe["carbs"] as int) * selectedServings / (recipe["servings"] as int)).round()}g",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Carbs",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((recipe["fat"] as int) * selectedServings / (recipe["servings"] as int)).round()}g",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Fat",
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
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Nutrition Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Benefits",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...nutritionTips.map((tip) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            tip["icon"] as IconData,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${tip["tip"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Description
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${recipe["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Ingredients
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...ingredients.map((ingredient) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${ingredient["item"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${ingredient["amount"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${ingredient["calories"]} cal",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Instructions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...instructions.map((instruction) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${instruction["step"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${instruction["instruction"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Cooking",
                    size: bs.md,
                    onPressed: () {
                      ss("Cooking timer started!");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add to Meal Plan",
                    size: bs.md,
                    onPressed: () {
                      ss("Added to meal plan!");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

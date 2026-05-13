import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaRecipeLibraryView extends StatefulWidget {
  const FwaRecipeLibraryView({super.key});

  @override
  State<FwaRecipeLibraryView> createState() => _FwaRecipeLibraryViewState();
}

class _FwaRecipeLibraryViewState extends State<FwaRecipeLibraryView> {
  String selectedCategory = "all";
  String selectedDietType = "all";
  String selectedMealType = "all";
  String searchQuery = "";
  bool showFavorites = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Breakfast", "value": "breakfast"},
    {"label": "Lunch", "value": "lunch"},
    {"label": "Dinner", "value": "dinner"},
    {"label": "Snacks", "value": "snacks"},
    {"label": "Desserts", "value": "desserts"},
  ];

  List<Map<String, dynamic>> dietTypeOptions = [
    {"label": "All Diets", "value": "all"},
    {"label": "Vegetarian", "value": "vegetarian"},
    {"label": "Vegan", "value": "vegan"},
    {"label": "Keto", "value": "keto"},
    {"label": "Low Carb", "value": "low_carb"},
    {"label": "High Protein", "value": "high_protein"},
    {"label": "Gluten Free", "value": "gluten_free"},
  ];

  List<Map<String, dynamic>> mealTypeOptions = [
    {"label": "All Meals", "value": "all"},
    {"label": "Quick (15 min)", "value": "quick"},
    {"label": "Medium (30 min)", "value": "medium"},
    {"label": "Slow (45+ min)", "value": "slow"},
  ];

  List<Map<String, dynamic>> featuredRecipes = [
    {
      "id": 1,
      "title": "Grilled Chicken Quinoa Bowl",
      "description": "Protein-packed bowl with grilled chicken, quinoa, and fresh vegetables",
      "image": "https://picsum.photos/400/300?random=1&keyword=chicken",
      "cookTime": "25 min",
      "servings": 2,
      "calories": 420,
      "protein": 35,
      "carbs": 45,
      "fat": 12,
      "difficulty": "Medium",
      "rating": 4.8,
      "reviews": 156,
      "isFavorite": true,
      "category": "lunch",
      "dietType": "high_protein",
      "ingredients": 8,
      "tags": ["High Protein", "Gluten Free", "Healthy"],
    },
    {
      "id": 2,
      "title": "Avocado Toast with Poached Egg",
      "description": "Classic breakfast with whole grain bread, avocado, and perfectly poached egg",
      "image": "https://picsum.photos/400/300?random=2&keyword=avocado",
      "cookTime": "10 min",
      "servings": 1,
      "calories": 320,
      "protein": 18,
      "carbs": 28,
      "fat": 16,
      "difficulty": "Easy",
      "rating": 4.6,
      "reviews": 89,
      "isFavorite": false,
      "category": "breakfast",
      "dietType": "vegetarian",
      "ingredients": 5,
      "tags": ["Vegetarian", "Quick", "Healthy"],
    },
    {
      "id": 3,
      "title": "Salmon with Roasted Vegetables",
      "description": "Omega-3 rich salmon with colorful roasted seasonal vegetables",
      "image": "https://picsum.photos/400/300?random=3&keyword=salmon",
      "cookTime": "35 min",
      "servings": 3,
      "calories": 380,
      "protein": 32,
      "carbs": 22,
      "fat": 18,
      "difficulty": "Medium",
      "rating": 4.9,
      "reviews": 234,
      "isFavorite": true,
      "category": "dinner",
      "dietType": "keto",
      "ingredients": 10,
      "tags": ["Keto", "High Protein", "Omega-3"],
    },
    {
      "id": 4,
      "title": "Greek Yogurt Berry Parfait",
      "description": "Layered parfait with Greek yogurt, fresh berries, and granola",
      "image": "https://picsum.photos/400/300?random=4&keyword=yogurt",
      "cookTime": "5 min",
      "servings": 1,
      "calories": 280,
      "protein": 20,
      "carbs": 35,
      "fat": 8,
      "difficulty": "Easy",
      "rating": 4.5,
      "reviews": 67,
      "isFavorite": false,
      "category": "snacks",
      "dietType": "vegetarian",
      "ingredients": 4,
      "tags": ["Vegetarian", "Quick", "Probiotic"],
    },
    {
      "id": 5,
      "title": "Lentil Buddha Bowl",
      "description": "Nutritious vegan bowl with lentils, roasted vegetables, and tahini dressing",
      "image": "https://picsum.photos/400/300?random=5&keyword=lentils",
      "cookTime": "40 min",
      "servings": 2,
      "calories": 450,
      "protein": 22,
      "carbs": 58,
      "fat": 14,
      "difficulty": "Medium",
      "rating": 4.7,
      "reviews": 178,
      "isFavorite": true,
      "category": "lunch",
      "dietType": "vegan",
      "ingredients": 12,
      "tags": ["Vegan", "High Fiber", "Plant-Based"],
    },
    {
      "id": 6,
      "title": "Chocolate Protein Smoothie",
      "description": "Post-workout smoothie with chocolate protein, banana, and almond milk",
      "image": "https://picsum.photos/400/300?random=6&keyword=smoothie",
      "cookTime": "3 min",
      "servings": 1,
      "calories": 250,
      "protein": 25,
      "carbs": 20,
      "fat": 6,
      "difficulty": "Easy",
      "rating": 4.4,
      "reviews": 92,
      "isFavorite": false,
      "category": "snacks",
      "dietType": "high_protein",
      "ingredients": 5,
      "tags": ["High Protein", "Post-Workout", "Quick"],
    },
  ];

  List<Map<String, dynamic>> popularTags = [
    {"label": "Quick & Easy", "count": 156, "color": Colors.green},
    {"label": "High Protein", "count": 134, "color": Colors.blue},
    {"label": "Vegetarian", "count": 98, "color": Colors.orange},
    {"label": "Keto", "count": 87, "color": Colors.purple},
    {"label": "Low Calorie", "count": 76, "color": Colors.red},
    {"label": "Meal Prep", "count": 65, "color": Colors.teal},
  ];

  List<Map<String, dynamic>> get filteredRecipes {
    return featuredRecipes.where((recipe) {
      bool matchesCategory = selectedCategory == "all" || recipe["category"] == selectedCategory;
      bool matchesDiet = selectedDietType == "all" || recipe["dietType"] == selectedDietType;
      bool matchesSearch = searchQuery.isEmpty || 
          (recipe["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (recipe["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFavorites = !showFavorites || recipe["isFavorite"] == true;
      
      return matchesCategory && matchesDiet && matchesSearch && matchesFavorites;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Library"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Show search dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search recipes...",
              value: searchQuery,
              hint: "Search by name, ingredients, or tags",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Diet Type",
                              items: dietTypeOptions,
                              value: selectedDietType,
                              onChanged: (value, label) {
                                selectedDietType = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Cook Time",
                              items: mealTypeOptions,
                              value: selectedMealType,
                              onChanged: (value, label) {
                                selectedMealType = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popular Tags
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Popular Tags",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: popularTags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (tag["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: tag["color"] as Color,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${tag["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tag["color"] as Color,
                              ),
                            ),
                            SizedBox(width: spXxs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXxs, vertical: 1),
                              decoration: BoxDecoration(
                                color: tag["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${tag["count"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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

            // Recipe Results Header
            Row(
              children: [
                Text(
                  "Recipes (${filteredRecipes.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {
                    // Show advanced filters
                  },
                ),
              ],
            ),

            // Recipe Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredRecipes.map((recipe) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Image
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${recipe["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                recipe["isFavorite"] == true 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                color: recipe["isFavorite"] == true 
                                    ? dangerColor 
                                    : disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${recipe["cookTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Recipe Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${recipe["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${recipe["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Nutrition Info
                            Row(
                              children: [
                                _buildNutritionBadge("${recipe["calories"]} cal", Icons.local_fire_department, Colors.orange),
                                SizedBox(width: spXs),
                                _buildNutritionBadge("${recipe["protein"]}g", Icons.fitness_center, Colors.blue),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    SizedBox(width: 2),
                                    Text(
                                      "${recipe["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Recipe Tags
                            Wrap(
                              spacing: spXxs,
                              runSpacing: spXxs,
                              children: (recipe["tags"] as List).take(2).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Recipe",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to recipe detail
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.add_shopping_cart,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Add ingredients to shopping list
                                  },
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

            // Load More Button
            if (filteredRecipes.length >= 6)
              Center(
                child: QButton(
                  label: "Load More Recipes",
                  icon: Icons.refresh,
                  size: bs.md,
                  onPressed: () {
                    // Load more recipes
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add custom recipe
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildNutritionBadge(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

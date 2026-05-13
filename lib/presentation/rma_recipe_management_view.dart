import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRecipeManagementView extends StatefulWidget {
  const RmaRecipeManagementView({super.key});

  @override
  State<RmaRecipeManagementView> createState() => _RmaRecipeManagementViewState();
}

class _RmaRecipeManagementViewState extends State<RmaRecipeManagementView> {
  String selectedCategory = "all";
  String selectedDifficulty = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> recipes = [
    {
      "id": "RCP-001",
      "name": "Grilled Salmon with Herbs",
      "category": "main_course",
      "difficulty": "medium",
      "prepTime": 20,
      "cookTime": 15,
      "servings": 4,
      "cost": 28.50,
      "sellingPrice": 45.00,
      "profitMargin": 36.7,
      "popularity": 85,
      "lastModified": "2024-03-10",
      "chef": "John Chef",
      "status": "active",
      "ingredients": [
        {"name": "Salmon Fillet", "quantity": 800, "unit": "g", "cost": 18.00},
        {"name": "Fresh Herbs", "quantity": 50, "unit": "g", "cost": 3.50},
        {"name": "Olive Oil", "quantity": 30, "unit": "ml", "cost": 2.00},
        {"name": "Lemon", "quantity": 2, "unit": "pieces", "cost": 1.50},
        {"name": "Garlic", "quantity": 3, "unit": "cloves", "cost": 0.50},
        {"name": "Seasonings", "quantity": 1, "unit": "mix", "cost": 3.00},
      ],
      "instructions": [
        "Preheat grill to medium-high heat",
        "Season salmon with herbs and spices",
        "Grill for 6-8 minutes per side",
        "Serve with lemon wedges",
      ],
      "allergens": ["fish"],
      "dietaryTags": ["gluten-free", "keto-friendly"],
    },
    {
      "id": "RCP-002",
      "name": "Classic Caesar Salad",
      "category": "appetizer",
      "difficulty": "easy",
      "prepTime": 15,
      "cookTime": 0,
      "servings": 6,
      "cost": 12.75,
      "sellingPrice": 18.00,
      "profitMargin": 29.2,
      "popularity": 92,
      "lastModified": "2024-03-12",
      "chef": "Sarah Kitchen",
      "status": "active",
      "ingredients": [
        {"name": "Romaine Lettuce", "quantity": 2, "unit": "heads", "cost": 4.00},
        {"name": "Parmesan Cheese", "quantity": 100, "unit": "g", "cost": 3.50},
        {"name": "Caesar Dressing", "quantity": 150, "unit": "ml", "cost": 2.25},
        {"name": "Croutons", "quantity": 80, "unit": "g", "cost": 2.00},
        {"name": "Anchovies", "quantity": 6, "unit": "pieces", "cost": 1.00},
      ],
      "instructions": [
        "Wash and chop romaine lettuce",
        "Prepare homemade croutons",
        "Mix dressing ingredients",
        "Toss salad with dressing",
        "Top with parmesan and anchovies",
      ],
      "allergens": ["dairy", "fish"],
      "dietaryTags": ["vegetarian"],
    },
    {
      "id": "RCP-003",
      "name": "Chocolate Lava Cake",
      "category": "dessert",
      "difficulty": "hard",
      "prepTime": 30,
      "cookTime": 12,
      "servings": 8,
      "cost": 15.20,
      "sellingPrice": 32.00,
      "profitMargin": 52.5,
      "popularity": 78,
      "lastModified": "2024-03-08",
      "chef": "Mike Pastry",
      "status": "active",
      "ingredients": [
        {"name": "Dark Chocolate", "quantity": 200, "unit": "g", "cost": 6.00},
        {"name": "Butter", "quantity": 150, "unit": "g", "cost": 3.00},
        {"name": "Eggs", "quantity": 4, "unit": "pieces", "cost": 2.00},
        {"name": "Sugar", "quantity": 100, "unit": "g", "cost": 1.20},
        {"name": "Flour", "quantity": 60, "unit": "g", "cost": 0.50},
        {"name": "Vanilla Extract", "quantity": 5, "unit": "ml", "cost": 2.50},
      ],
      "instructions": [
        "Melt chocolate and butter",
        "Whisk eggs and sugar",
        "Combine wet and dry ingredients",
        "Fill ramekins and bake",
        "Serve warm with ice cream",
      ],
      "allergens": ["eggs", "dairy", "gluten"],
      "dietaryTags": ["vegetarian"],
    },
    {
      "id": "RCP-004",
      "name": "Vegetarian Pasta Primavera",
      "category": "main_course",
      "difficulty": "easy",
      "prepTime": 25,
      "cookTime": 20,
      "servings": 5,
      "cost": 18.90,
      "sellingPrice": 28.00,
      "profitMargin": 32.5,
      "popularity": 68,
      "lastModified": "2024-03-14",
      "chef": "Lisa Vegetarian",
      "status": "active",
      "ingredients": [
        {"name": "Pasta", "quantity": 500, "unit": "g", "cost": 3.50},
        {"name": "Mixed Vegetables", "quantity": 400, "unit": "g", "cost": 8.00},
        {"name": "Olive Oil", "quantity": 50, "unit": "ml", "cost": 3.00},
        {"name": "Garlic", "quantity": 4, "unit": "cloves", "cost": 0.40},
        {"name": "Parmesan", "quantity": 80, "unit": "g", "cost": 3.00},
        {"name": "Fresh Basil", "quantity": 20, "unit": "g", "cost": 1.00},
      ],
      "instructions": [
        "Cook pasta according to package instructions",
        "Sauté vegetables in olive oil",
        "Add garlic and seasonings",
        "Combine pasta with vegetables",
        "Garnish with parmesan and basil",
      ],
      "allergens": ["gluten", "dairy"],
      "dietaryTags": ["vegetarian"],
    },
    {
      "id": "RCP-005",
      "name": "Craft Beer Burger",
      "category": "main_course",
      "difficulty": "medium",
      "prepTime": 15,
      "cookTime": 12,
      "servings": 4,
      "cost": 22.40,
      "sellingPrice": 35.00,
      "profitMargin": 36.0,
      "popularity": 89,
      "lastModified": "2024-03-13",
      "chef": "David Grill",
      "status": "active",
      "ingredients": [
        {"name": "Ground Beef", "quantity": 600, "unit": "g", "cost": 12.00},
        {"name": "Burger Buns", "quantity": 4, "unit": "pieces", "cost": 2.40},
        {"name": "Cheese", "quantity": 120, "unit": "g", "cost": 3.00},
        {"name": "Lettuce", "quantity": 100, "unit": "g", "cost": 1.50},
        {"name": "Tomatoes", "quantity": 2, "unit": "pieces", "cost": 2.00},
        {"name": "Special Sauce", "quantity": 80, "unit": "ml", "cost": 1.50},
      ],
      "instructions": [
        "Form beef patties and season",
        "Grill patties to desired doneness",
        "Toast burger buns lightly",
        "Assemble with toppings",
        "Serve with craft beer recommendation",
      ],
      "allergens": ["gluten", "dairy"],
      "dietaryTags": [],
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Appetizers", "value": "appetizer"},
    {"label": "Main Course", "value": "main_course"},
    {"label": "Desserts", "value": "dessert"},
    {"label": "Beverages", "value": "beverage"},
    {"label": "Sides", "value": "side"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All Difficulties", "value": "all"},
    {"label": "Easy", "value": "easy"},
    {"label": "Medium", "value": "medium"},
    {"label": "Hard", "value": "hard"},
  ];

  List<Map<String, dynamic>> get filteredRecipes {
    return recipes.where((recipe) {
      final matchesCategory = selectedCategory == "all" || recipe["category"] == selectedCategory;
      final matchesDifficulty = selectedDifficulty == "all" || recipe["difficulty"] == selectedDifficulty;
      final matchesSearch = searchQuery.isEmpty ||
          recipe["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          recipe["chef"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesDifficulty && matchesSearch;
    }).toList();
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                "Recipe Management",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Recipe",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreateRecipe')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search recipes...",
                  value: searchQuery,
                  hint: "Recipe name, chef",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Difficulty",
                  items: difficultyOptions,
                  value: selectedDifficulty,
                  onChanged: (value, label) {
                    selectedDifficulty = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeStats() {
    final totalRecipes = filteredRecipes.length;
    final avgCost = filteredRecipes.fold(0.0, (sum, recipe) => sum + (recipe["cost"] as double)) / 
                   (totalRecipes > 0 ? totalRecipes : 1);
    final avgMargin = filteredRecipes.fold(0.0, (sum, recipe) => sum + (recipe["profitMargin"] as double)) / 
                     (totalRecipes > 0 ? totalRecipes : 1);
    final popularRecipes = filteredRecipes.where((r) => (r["popularity"] as int) > 80).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipe Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Recipes",
                "$totalRecipes",
                Icons.restaurant_menu,
                primaryColor,
              ),
              _buildStatCard(
                "Avg Cost",
                "\$${avgCost.toStringAsFixed(2)}",
                Icons.attach_money,
                warningColor,
              ),
              _buildStatCard(
                "Avg Margin",
                "${avgMargin.toStringAsFixed(1)}%",
                Icons.trending_up,
                successColor,
              ),
              _buildStatCard(
                "Popular Items",
                "$popularRecipes",
                Icons.star,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipes (${filteredRecipes.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (filteredRecipes.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No recipes found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredRecipes.map((recipe) => _buildRecipeCard(recipe)).toList(),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    final difficultyColor = _getDifficultyColor(recipe["difficulty"]);
    final categoryColor = _getCategoryColor(recipe["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: categoryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${recipe["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: difficultyColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${recipe["difficulty"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: difficultyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "by ${recipe["chef"]} • ${recipe["category"]}".replaceAll('_', ' ').toUpperCase(),
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${recipe["popularity"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${recipe["profitMargin"]}% margin",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildRecipeDetail(
                  Icons.schedule,
                  "Prep Time",
                  "${recipe["prepTime"]} min",
                ),
              ),
              Expanded(
                child: _buildRecipeDetail(
                  Icons.timer,
                  "Cook Time",
                  "${recipe["cookTime"]} min",
                ),
              ),
              Expanded(
                child: _buildRecipeDetail(
                  Icons.people,
                  "Servings",
                  "${recipe["servings"]}",
                ),
              ),
              Expanded(
                child: _buildRecipeDetail(
                  Icons.attach_money,
                  "Cost",
                  "\$${(recipe["cost"] as double).toStringAsFixed(2)}",
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selling Price: \$${(recipe["sellingPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      if ((recipe["allergens"] as List).isNotEmpty)
                        Text(
                          "Allergens: ${(recipe["allergens"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 11,
                            color: dangerColor,
                          ),
                        ),
                      if ((recipe["dietaryTags"] as List).isNotEmpty)
                        Text(
                          "Tags: ${(recipe["dietaryTags"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Recipe",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RecipeDetails')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditRecipe')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Copy",
                size: bs.sm,
                onPressed: () {
                  //duplicateRecipe()
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeDetail(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "appetizer":
        return Colors.green;
      case "main_course":
        return primaryColor;
      case "dessert":
        return Colors.pink;
      case "beverage":
        return Colors.blue;
      case "side":
        return Colors.orange;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.import_export),
            onPressed: () {
              //navigateTo('ImportExportRecipes')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RecipeAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildRecipeStats(),
            _buildRecipesList(),
          ],
        ),
      ),
    );
  }
}

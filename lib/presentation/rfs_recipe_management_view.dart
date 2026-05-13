import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsRecipeManagementView extends StatefulWidget {
  const RfsRecipeManagementView({super.key});

  @override
  State<RfsRecipeManagementView> createState() => _RfsRecipeManagementViewState();
}

class _RfsRecipeManagementViewState extends State<RfsRecipeManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  bool showFilters = false;
  String selectedDifficulty = "All";
  String selectedCookTime = "All";

  final List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Beverage", "value": "Beverage"},
    {"label": "Side Dish", "value": "Side Dish"},
  ];

  final List<Map<String, dynamic>> difficultyItems = [
    {"label": "All", "value": "All"},
    {"label": "Easy", "value": "Easy"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Hard", "value": "Hard"},
  ];

  final List<Map<String, dynamic>> cookTimeItems = [
    {"label": "All", "value": "All"},
    {"label": "Under 15 min", "value": "Under 15 min"},
    {"label": "15-30 min", "value": "15-30 min"},
    {"label": "30-60 min", "value": "30-60 min"},
    {"label": "Over 1 hour", "value": "Over 1 hour"},
  ];

  final List<Map<String, dynamic>> recipes = [
    {
      "id": 1,
      "name": "Grilled Salmon with Herbs",
      "category": "Main Course",
      "difficulty": "Medium",
      "cookTime": "25 min",
      "servings": 4,
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon",
      "rating": 4.8,
      "reviews": 156,
      "ingredients": 12,
      "calories": 380,
      "description": "Fresh Atlantic salmon grilled to perfection with aromatic herbs and lemon",
      "tags": ["Healthy", "Protein", "Gluten-Free"],
      "lastModified": "2024-12-18",
      "status": "Active"
    },
    {
      "id": 2,
      "name": "Chocolate Lava Cake",
      "category": "Dessert",
      "difficulty": "Hard",
      "cookTime": "35 min",
      "servings": 6,
      "image": "https://picsum.photos/300/200?random=2&keyword=chocolate",
      "rating": 4.9,
      "reviews": 203,
      "ingredients": 8,
      "calories": 420,
      "description": "Decadent chocolate cake with molten center served with vanilla ice cream",
      "tags": ["Dessert", "Chocolate", "Popular"],
      "lastModified": "2024-12-17",
      "status": "Active"
    },
    {
      "id": 3,
      "name": "Caesar Salad Supreme",
      "category": "Appetizer",
      "difficulty": "Easy",
      "cookTime": "10 min",
      "servings": 2,
      "image": "https://picsum.photos/300/200?random=3&keyword=salad",
      "rating": 4.6,
      "reviews": 89,
      "ingredients": 7,
      "calories": 180,
      "description": "Classic Caesar salad with homemade croutons and parmesan cheese",
      "tags": ["Vegetarian", "Quick", "Light"],
      "lastModified": "2024-12-16",
      "status": "Active"
    },
    {
      "id": 4,
      "name": "Beef Wellington",
      "category": "Main Course",
      "difficulty": "Hard",
      "cookTime": "90 min",
      "servings": 8,
      "image": "https://picsum.photos/300/200?random=4&keyword=beef",
      "rating": 4.7,
      "reviews": 134,
      "ingredients": 15,
      "calories": 650,
      "description": "Premium beef tenderloin wrapped in pastry with mushroom duxelles",
      "tags": ["Premium", "Special", "Protein"],
      "lastModified": "2024-12-15",
      "status": "Draft"
    },
    {
      "id": 5,
      "name": "Mango Smoothie Bowl",
      "category": "Beverage",
      "difficulty": "Easy",
      "cookTime": "5 min",
      "servings": 1,
      "image": "https://picsum.photos/300/200?random=5&keyword=mango",
      "rating": 4.5,
      "reviews": 67,
      "ingredients": 6,
      "calories": 220,
      "description": "Refreshing mango smoothie bowl topped with fresh fruits and granola",
      "tags": ["Healthy", "Vegan", "Refreshing"],
      "lastModified": "2024-12-14",
      "status": "Active"
    },
    {
      "id": 6,
      "name": "Truffle Mac & Cheese",
      "category": "Side Dish",
      "difficulty": "Medium",
      "cookTime": "40 min",
      "servings": 6,
      "image": "https://picsum.photos/300/200?random=6&keyword=cheese",
      "rating": 4.8,
      "reviews": 178,
      "ingredients": 9,
      "calories": 450,
      "description": "Creamy mac and cheese elevated with truffle oil and premium cheeses",
      "tags": ["Comfort", "Cheese", "Premium"],
      "lastModified": "2024-12-13",
      "status": "Active"
    }
  ];

  List<Map<String, dynamic>> get filteredRecipes {
    return recipes.where((recipe) {
      bool matchesSearch = recipe["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || recipe["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || recipe["difficulty"] == selectedDifficulty;
      
      return matchesSearch && matchesCategory && matchesDifficulty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Recipe Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Recipes", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRecipeListTab(),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildRecipeListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          if (showFilters) _buildFilterOptions(),
          _buildRecipeStats(),
          _buildRecipeGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search recipes...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                // navigateTo('AddRecipeView')
              },
            ),
          ],
        ),
        QCategoryPicker(
          items: categoryItems,
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: QDropdownField(
                  label: "Difficulty",
                  items: difficultyItems,
                  value: selectedDifficulty,
                  onChanged: (value, label) {
                    selectedDifficulty = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Cook Time",
                  items: cookTimeItems,
                  value: selectedCookTime,
                  onChanged: (value, label) {
                    selectedCookTime = value;
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
    int totalRecipes = recipes.length;
    int activeRecipes = recipes.where((r) => r["status"] == "Active").length;
    double avgRating = recipes.map((r) => r["rating"] as double).reduce((a, b) => a + b) / recipes.length;

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
                  "$totalRecipes",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Recipes",
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
                  "$activeRecipes",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Active",
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
                  "${avgRating.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Avg Rating",
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

  Widget _buildRecipeGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredRecipes.map((recipe) {
        return _buildRecipeCard(recipe);
      }).toList(),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${recipe["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: recipe["status"] == "Active" ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${recipe["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${recipe["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${recipe["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${recipe["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: 2),
                    Text(
                      "${recipe["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${recipe["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.timer, size: 14, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${recipe["cookTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${recipe["servings"]} servings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.local_fire_department, size: 14, color: dangerColor),
                    SizedBox(width: 2),
                    Text(
                      "${recipe["calories"]} cal",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Recipe",
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo('RecipeDetailView')
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCategoryStats(),
          _buildCategoryList(),
        ],
      ),
    );
  }

  Widget _buildCategoryStats() {
    final categoryStats = categoryItems.skip(1).map((category) {
      final count = recipes.where((r) => r["category"] == category["value"]).length;
      return {
        "name": category["label"],
        "count": count,
        "color": _getCategoryColor(category["value"] as String),
      };
    }).toList();

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: categoryStats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: stat["color"].withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  _getCategoryIcon(stat["name"] as String),
                  color: stat["color"],
                  size: 24,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${stat["count"]}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: stat["color"],
                ),
              ),
              Text(
                "${stat["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryList() {
    return Column(
      spacing: spSm,
      children: categoryItems.skip(1).map((category) {
        final categoryRecipes = recipes.where((r) => r["category"] == category["value"]).toList();
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
              Row(
                children: [
                  Icon(
                    _getCategoryIcon(category["label"] as String),
                    color: _getCategoryColor(category["value"] as String),
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${category["label"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${categoryRecipes.length} recipes",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              if (categoryRecipes.isNotEmpty)
                QHorizontalScroll(
                  children: categoryRecipes.take(3).map((recipe) {
                    return Container(
                      width: 120,
                      margin: EdgeInsets.only(right: spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${recipe["image"]}",
                              height: 80,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${recipe["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPopularRecipes(),
          _buildRatingAnalytics(),
          _buildIngredientAnalytics(),
        ],
      ),
    );
  }

  Widget _buildPopularRecipes() {
    final popularRecipes = List.from(recipes)..sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));

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
            "Most Popular Recipes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...popularRecipes.take(5).map((recipe) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${recipe["image"]}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${recipe["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 12, color: warningColor),
                          SizedBox(width: 2),
                          Text(
                            "${recipe["rating"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${recipe["reviews"]} reviews",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRatingAnalytics() {
    final ratingDistribution = <String, int>{
      "5 Stars": recipes.where((r) => (r["rating"] as double) >= 4.5).length,
      "4 Stars": recipes.where((r) => (r["rating"] as double) >= 4.0 && (r["rating"] as double) < 4.5).length,
      "3 Stars": recipes.where((r) => (r["rating"] as double) >= 3.0 && (r["rating"] as double) < 4.0).length,
      "2 Stars": recipes.where((r) => (r["rating"] as double) >= 2.0 && (r["rating"] as double) < 3.0).length,
      "1 Star": recipes.where((r) => (r["rating"] as double) < 2.0).length,
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
            "Rating Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...ratingDistribution.entries.map((entry) {
            return Row(
              children: [
                SizedBox(
                  width: 80,
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
                      widthFactor: entry.value / recipes.length,
                      child: Container(
                        decoration: BoxDecoration(
                          color: warningColor,
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

  Widget _buildIngredientAnalytics() {
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
            "Recipe Complexity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${(recipes.map((r) => r["ingredients"] as int).reduce((a, b) => a + b) / recipes.length).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Ingredients",
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
                      "${(recipes.map((r) => r["calories"] as int).reduce((a, b) => a + b) / recipes.length).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
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
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Appetizer": return infoColor;
      case "Main Course": return primaryColor;
      case "Dessert": return warningColor;
      case "Beverage": return successColor;
      case "Side Dish": return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Appetizer": return Icons.restaurant;
      case "Main Course": return Icons.dinner_dining;
      case "Dessert": return Icons.cake;
      case "Beverage": return Icons.local_drink;
      case "Side Dish": return Icons.rice_bowl;
      default: return Icons.fastfood;
    }
  }
}

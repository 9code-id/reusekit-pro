import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite2View extends StatefulWidget {
  @override
  State<GrlFavorite2View> createState() => _GrlFavorite2ViewState();
}

class _GrlFavorite2ViewState extends State<GrlFavorite2View> {
  String searchQuery = "";
  String sortBy = "name";
  bool showOnlyQuick = false;

  List<Map<String, dynamic>> favoriteRecipes = [
    {
      "id": "1",
      "name": "Creamy Mushroom Risotto",
      "cuisine": "Italian",
      "difficulty": "Medium",
      "cookTime": "35 min",
      "servings": 4,
      "calories": 380,
      "rating": 4.8,
      "reviews": 1543,
      "image": "https://picsum.photos/300/300?random=1&keyword=risotto",
      "isQuick": false,
      "isVegetarian": true,
      "chef": "Chef Marco",
      "description": "Rich and creamy risotto with wild mushrooms and parmesan cheese"
    },
    {
      "id": "2",
      "name": "Grilled Salmon Teriyaki",
      "cuisine": "Japanese",
      "difficulty": "Easy",
      "cookTime": "20 min",
      "servings": 2,
      "calories": 290,
      "rating": 4.7,
      "reviews": 892,
      "image": "https://picsum.photos/300/300?random=2&keyword=salmon",
      "isQuick": true,
      "isVegetarian": false,
      "chef": "Chef Yuki",
      "description": "Perfectly grilled salmon with homemade teriyaki glaze"
    },
    {
      "id": "3",
      "name": "Mediterranean Quinoa Bowl",
      "cuisine": "Mediterranean",
      "difficulty": "Easy",
      "cookTime": "15 min",
      "servings": 2,
      "calories": 350,
      "rating": 4.6,
      "reviews": 1267,
      "image": "https://picsum.photos/300/300?random=3&keyword=quinoa",
      "isQuick": true,
      "isVegetarian": true,
      "chef": "Chef Sofia",
      "description": "Fresh quinoa bowl with Mediterranean vegetables and feta"
    },
    {
      "id": "4",
      "name": "Beef Bourguignon",
      "cuisine": "French",
      "difficulty": "Hard",
      "cookTime": "180 min",
      "servings": 6,
      "calories": 450,
      "rating": 4.9,
      "reviews": 743,
      "image": "https://picsum.photos/300/300?random=4&keyword=beef",
      "isQuick": false,
      "isVegetarian": false,
      "chef": "Chef Pierre",
      "description": "Classic French beef stew braised in red wine with vegetables"
    },
    {
      "id": "5",
      "name": "Thai Green Curry",
      "cuisine": "Thai",
      "difficulty": "Medium",
      "cookTime": "25 min",
      "servings": 4,
      "calories": 320,
      "rating": 4.7,
      "reviews": 1098,
      "image": "https://picsum.photos/300/300?random=5&keyword=curry",
      "isQuick": false,
      "isVegetarian": true,
      "chef": "Chef Siri",
      "description": "Aromatic green curry with vegetables and coconut milk"
    }
  ];

  List<Map<String, dynamic>> get filteredRecipes {
    List<Map<String, dynamic>> filtered = List.from(favoriteRecipes);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((recipe) => 
        (recipe["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (recipe["cuisine"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (recipe["chef"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply quick filter
    if (showOnlyQuick) {
      filtered = filtered.where((recipe) => recipe["isQuick"] as bool).toList();
    }

    // Apply sorting
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "time":
        filtered.sort((a, b) => _parseTime(a["cookTime"] as String).compareTo(_parseTime(b["cookTime"] as String)));
        break;
      case "calories":
        filtered.sort((a, b) => (a["calories"] as int).compareTo(b["calories"] as int));
        break;
      default:
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
    }

    return filtered;
  }

  int _parseTime(String timeStr) {
    return int.parse(timeStr.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Recipes"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            QTextField(
              label: "Search recipes...",
              value: searchQuery,
              hint: "Recipe name, cuisine, or chef",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Name", "value": "name"},
                      {"label": "Rating", "value": "rating"},
                      {"label": "Cook Time", "value": "time"},
                      {"label": "Calories", "value": "calories"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Quick Recipes Only",
                        "value": true,
                        "checked": showOnlyQuick,
                      }
                    ],
                    value: [if (showOnlyQuick) {"label": "Quick Recipes Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showOnlyQuick = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Stats Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteRecipes.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Saved Recipes",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteRecipes.where((r) => r["isQuick"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Quick Recipes",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(favoriteRecipes.fold(0.0, (sum, recipe) => sum + (recipe["rating"] as double)) / favoriteRecipes.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Rating",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Recipes List
            filteredRecipes.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: spXl),
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No recipes found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Browse Recipes",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRecipes.length,
                    separatorBuilder: (context, index) => SizedBox(height: spMd),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Recipe Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(radiusLg),
                                  ),
                                  child: Image.network(
                                    "${recipe["image"]}",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: GestureDetector(
                                    onTap: () async {
                                      bool isConfirmed = await confirm("Remove this recipe from favorites?");
                                      if (isConfirmed) {
                                        favoriteRecipes.removeWhere((r) => r["id"] == recipe["id"]);
                                        setState(() {});
                                        ss("Recipe removed from favorites");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [shadowSm],
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: dangerColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                if (recipe["isQuick"] as bool)
                                  Positioned(
                                    top: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "QUICK",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (recipe["isVegetarian"] as bool)
                                  Positioned(
                                    bottom: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.eco,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            // Recipe Details
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${recipe["cuisine"]}",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${recipe["chef"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${recipe["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spMd),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text("${recipe["cookTime"]}", style: TextStyle(fontSize: 12)),
                                      SizedBox(width: spMd),
                                      Icon(Icons.people, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text("${recipe["servings"]} servings", style: TextStyle(fontSize: 12)),
                                      SizedBox(width: spMd),
                                      Icon(Icons.local_fire_department, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text("${recipe["calories"]} cal", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: warningColor, size: 16),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${recipe["rating"]}",
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${recipe["reviews"]} reviews)",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getDifficultyColor(recipe["difficulty"] as String).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${recipe["difficulty"]}",
                                          style: TextStyle(
                                            color: _getDifficultyColor(recipe["difficulty"] as String),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spMd),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Recipe",
                                          size: bs.sm,
                                          onPressed: () {
                                            ss("Opening recipe details");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.shopping_cart,
                                        size: bs.sm,
                                        onPressed: () {
                                          ss("Added ingredients to shopping list");
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
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

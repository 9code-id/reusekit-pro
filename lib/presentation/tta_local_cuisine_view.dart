import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaLocalCuisineView extends StatefulWidget {
  const TtaLocalCuisineView({super.key});

  @override
  State<TtaLocalCuisineView> createState() => _TtaLocalCuisineViewState();
}

class _TtaLocalCuisineViewState extends State<TtaLocalCuisineView> {
  String selectedRegion = "All Regions";
  String selectedDifficulty = "All Levels";
  String searchQuery = "";

  List<Map<String, dynamic>> regions = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "Northern Italy", "value": "Northern Italy"},
    {"label": "Central Italy", "value": "Central Italy"},
    {"label": "Southern Italy", "value": "Southern Italy"},
    {"label": "Sicily", "value": "Sicily"},
    {"label": "Sardinia", "value": "Sardinia"},
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All Levels", "value": "All Levels"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> cuisineCategories = [
    {
      "name": "Traditional Dishes",
      "icon": Icons.restaurant,
      "color": primaryColor,
      "dishes": 24,
    },
    {
      "name": "Street Food",
      "icon": Icons.local_dining,
      "color": warningColor,
      "dishes": 18,
    },
    {
      "name": "Desserts",
      "icon": Icons.cake,
      "color": secondaryColor,
      "dishes": 15,
    },
    {
      "name": "Beverages",
      "icon": Icons.local_drink,
      "color": infoColor,
      "dishes": 12,
    },
  ];

  List<Map<String, dynamic>> featuredDishes = [
    {
      "id": 1,
      "name": "Risotto alla Milanese",
      "region": "Northern Italy",
      "difficulty": "Intermediate",
      "cookingTime": "45 min",
      "servings": 4,
      "rating": 4.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=risotto",
      "description": "Creamy saffron risotto from Milan, rich and aromatic",
      "ingredients": ["Arborio rice", "Saffron", "Parmesan", "White wine", "Beef stock"],
      "category": "Traditional Dishes",
      "cultural_info": "Originally created in the 19th century, this dish represents the wealth and sophistication of Milan.",
      "tips": "Use genuine saffron threads for authentic flavor and color",
      "price_range": "\$\$",
      "popularity": 95
    },
    {
      "id": 2,
      "name": "Arancini Siciliani",
      "region": "Sicily",
      "difficulty": "Advanced",
      "cookingTime": "2 hours",
      "servings": 6,
      "rating": 4.7,
      "image": "https://picsum.photos/300/200?random=2&keyword=arancini",
      "description": "Golden fried rice balls stuffed with ragù, mozzarella, and peas",
      "ingredients": ["Risotto rice", "Ragù sauce", "Mozzarella", "Peas", "Breadcrumbs"],
      "category": "Street Food",
      "cultural_info": "Named after oranges due to their shape and color, originated in 10th century Sicily.",
      "tips": "Let the risotto cool completely before shaping for best results",
      "price_range": "\$",
      "popularity": 88
    },
    {
      "id": 3,
      "name": "Cacio e Pepe",
      "region": "Central Italy",
      "difficulty": "Beginner",
      "cookingTime": "15 min",
      "servings": 2,
      "rating": 4.9,
      "image": "https://picsum.photos/300/200?random=3&keyword=pasta",
      "description": "Simple Roman pasta with pecorino cheese and black pepper",
      "ingredients": ["Spaghetti", "Pecorino Romano", "Black pepper", "Pasta water"],
      "category": "Traditional Dishes",
      "cultural_info": "Ancient Roman shepherds' dish, showcasing the beauty of simplicity in Italian cooking.",
      "tips": "Use starchy pasta water to create a silky emulsion",
      "price_range": "\$",
      "popularity": 92
    },
    {
      "id": 4,
      "name": "Gelato Artigianale",
      "region": "All Regions",
      "difficulty": "Intermediate",
      "cookingTime": "4 hours",
      "servings": 8,
      "rating": 4.6,
      "image": "https://picsum.photos/300/200?random=4&keyword=gelato",
      "description": "Authentic Italian gelato with intense flavors and smooth texture",
      "ingredients": ["Whole milk", "Heavy cream", "Sugar", "Egg yolks", "Natural flavors"],
      "category": "Desserts",
      "cultural_info": "Gelato originated in Renaissance Italy and differs from ice cream in its denser texture.",
      "tips": "Serve at a slightly warmer temperature than ice cream for optimal texture",
      "price_range": "\$\$",
      "popularity": 90
    },
    {
      "id": 5,
      "name": "Cannoli Siciliani",
      "region": "Sicily",
      "difficulty": "Advanced",
      "cookingTime": "3 hours",
      "servings": 12,
      "rating": 4.8,
      "image": "https://picsum.photos/300/200?random=5&keyword=cannoli",
      "description": "Crispy pastry tubes filled with sweet ricotta cream",
      "ingredients": ["Flour", "Wine", "Ricotta", "Powdered sugar", "Candied fruits"],
      "category": "Desserts",
      "cultural_info": "Originating from Palermo, cannoli were traditionally made during Carnival season.",
      "tips": "Fill shells just before serving to maintain crispiness",
      "price_range": "\$\$",
      "popularity": 85
    },
    {
      "id": 6,
      "name": "Focaccia Ligure",
      "region": "Northern Italy",
      "difficulty": "Intermediate",
      "cookingTime": "3 hours",
      "servings": 8,
      "rating": 4.5,
      "image": "https://picsum.photos/300/200?random=6&keyword=focaccia",
      "description": "Soft, olive oil-rich bread from Liguria topped with herbs",
      "ingredients": ["Bread flour", "Olive oil", "Rosemary", "Sea salt", "Olives"],
      "category": "Traditional Dishes",
      "cultural_info": "Ancient bread from Liguria, traditionally baked in wood-fired ovens.",
      "tips": "Dimple the surface with fingertips to create characteristic wells for oil",
      "price_range": "\$",
      "popularity": 78
    },
  ];

  List<Map<String, dynamic>> get filteredDishes {
    return featuredDishes.where((dish) {
      bool matchesRegion = selectedRegion == "All Regions" || dish["region"] == selectedRegion;
      bool matchesDifficulty = selectedDifficulty == "All Levels" || dish["difficulty"] == selectedDifficulty;
      bool matchesSearch = "${dish["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${dish["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${dish["region"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesRegion && matchesDifficulty && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Cuisine"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              //navigateTo('SavedRecipesView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/200?random=100&keyword=italian"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(128),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(spMd),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discover Authentic Italian Cuisine",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Explore traditional recipes and cultural stories",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.white,
              child: Column(
                children: [
                  QTextField(
                    label: "Search dishes or regions",
                    value: searchQuery,
                    hint: "Risotto, Sicily, Pasta...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Region",
                          items: regions,
                          value: selectedRegion,
                          onChanged: (value, label) {
                            selectedRegion = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Difficulty",
                          items: difficultyLevels,
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
            ),

            // Categories Section
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: cuisineCategories.map((category) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                size: 32,
                                color: category["color"] as Color,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${category["dishes"]} dishes",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            // Featured Dishes
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Featured Dishes (${filteredDishes.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            SizedBox(height: spSm),

            // Dishes List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredDishes.length,
              itemBuilder: (context, index) {
                final dish = filteredDishes[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dish Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${dish["image"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            
                            // Difficulty Badge
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor("${dish["difficulty"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${dish["difficulty"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Rating Badge
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(153),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${dish["rating"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Dish Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${dish["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${dish["price_range"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${dish["region"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${dish["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Stats Row
                            Row(
                              children: [
                                _buildStatChip(Icons.schedule, "${dish["cookingTime"]}"),
                                SizedBox(width: spXs),
                                _buildStatChip(Icons.people, "${dish["servings"]} servings"),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${dish["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Ingredients Preview
                            Text(
                              "Key Ingredients:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (dish["ingredients"] as List).take(3).map((ingredient) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${ingredient}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            if ((dish["ingredients"] as List).length > 3)
                              Padding(
                                padding: EdgeInsets.only(top: spXs),
                                child: Text(
                                  "+${(dish["ingredients"] as List).length - 3} more ingredients",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Recipe",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('RecipeDetailView')
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Recipe saved to favorites");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Recipe shared");
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

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: disabledBoldColor,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFoodRecommendationsView extends StatefulWidget {
  const TtaFoodRecommendationsView({super.key});

  @override
  State<TtaFoodRecommendationsView> createState() => _TtaFoodRecommendationsViewState();
}

class _TtaFoodRecommendationsViewState extends State<TtaFoodRecommendationsView> {
  String selectedCategory = "For You";
  bool showFilters = false;
  String priceRange = "All";
  String cuisine = "All";
  String dietaryRestriction = "None";
  String sortBy = "Recommended";

  List<Map<String, dynamic>> categories = [
    {"name": "For You", "count": 28},
    {"name": "Trending", "count": 15},
    {"name": "Nearby", "count": 12},
    {"name": "Budget-Friendly", "count": 18},
    {"name": "Fine Dining", "count": 8},
    {"name": "Quick Bites", "count": 22},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All", "value": "All"},
    {"label": "Budget (\$)", "value": "budget"},
    {"label": "Moderate (\$\$)", "value": "moderate"},
    {"label": "Expensive (\$\$\$)", "value": "expensive"},
    {"label": "Luxury (\$\$\$\$)", "value": "luxury"},
  ];

  List<Map<String, dynamic>> cuisineTypes = [
    {"label": "All", "value": "All"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Mexican", "value": "Mexican"},
    {"label": "Indian", "value": "Indian"},
    {"label": "French", "value": "French"},
    {"label": "Thai", "value": "Thai"},
  ];

  List<Map<String, dynamic>> dietaryOptions = [
    {"label": "None", "value": "None"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Vegan", "value": "Vegan"},
    {"label": "Gluten-Free", "value": "Gluten-Free"},
    {"label": "Halal", "value": "Halal"},
    {"label": "Kosher", "value": "Kosher"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recommended", "value": "Recommended"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Price", "value": "Price"},
    {"label": "Newest", "value": "Newest"},
  ];

  Map<String, dynamic> userProfile = {
    "name": "John Smith",
    "preferences": ["Italian", "Asian", "Vegetarian"],
    "favoriteRestaurants": ["Mama's Kitchen", "Sakura Sushi", "Dragon Palace"],
    "lastOrders": ["Carbonara", "California Roll", "Pad Thai"],
    "location": "Downtown",
  };

  List<Map<String, dynamic>> recommendations = [
    {
      "id": 1,
      "restaurant": "Bella Vista",
      "dish": "Truffle Risotto",
      "cuisine": "Italian",
      "category": "For You",
      "rating": 4.8,
      "reviews": 245,
      "price": 28.99,
      "priceRange": "expensive",
      "distance": "0.3 km",
      "deliveryTime": "25-35 min",
      "image": "https://picsum.photos/300/200?random=1&keyword=risotto",
      "restaurant_image": "https://picsum.photos/100/100?random=11&keyword=restaurant",
      "tags": ["Vegetarian", "Premium"],
      "match_score": 95,
      "description": "Luxurious risotto with black truffle shavings",
      "why_recommended": "Based on your love for Italian cuisine and vegetarian options",
      "dietary": ["Vegetarian"],
      "spice_level": "Mild",
      "calories": 580,
    },
    {
      "id": 2,
      "restaurant": "Street Taco Co",
      "dish": "Fish Tacos",
      "cuisine": "Mexican",
      "category": "Trending",
      "rating": 4.6,
      "reviews": 189,
      "price": 12.99,
      "priceRange": "budget",
      "distance": "0.8 km",
      "deliveryTime": "20-30 min",
      "image": "https://picsum.photos/300/200?random=2&keyword=tacos",
      "restaurant_image": "https://picsum.photos/100/100?random=12&keyword=mexican",
      "tags": ["Trending", "Fresh"],
      "match_score": 88,
      "description": "Fresh grilled fish with mango salsa and cilantro lime crema",
      "why_recommended": "Highly rated by users with similar tastes",
      "dietary": ["Gluten-Free Option"],
      "spice_level": "Medium",
      "calories": 420,
    },
    {
      "id": 3,
      "restaurant": "Noodle House",
      "dish": "Ramen Bowl",
      "cuisine": "Japanese",
      "category": "Nearby",
      "rating": 4.7,
      "reviews": 324,
      "price": 16.99,
      "priceRange": "moderate",
      "distance": "0.2 km",
      "deliveryTime": "15-25 min",
      "image": "https://picsum.photos/300/200?random=3&keyword=ramen",
      "restaurant_image": "https://picsum.photos/100/100?random=13&keyword=japanese",
      "tags": ["Nearby", "Comfort Food"],
      "match_score": 82,
      "description": "Rich tonkotsu broth with chashu pork and soft-boiled egg",
      "why_recommended": "Close to your location and highly rated",
      "dietary": [],
      "spice_level": "Mild",
      "calories": 650,
    },
    {
      "id": 4,
      "restaurant": "Green Leaf Cafe",
      "dish": "Buddha Bowl",
      "cuisine": "Healthy",
      "category": "For You",
      "rating": 4.5,
      "reviews": 156,
      "price": 14.99,
      "priceRange": "moderate",
      "distance": "0.5 km",
      "deliveryTime": "20-30 min",
      "image": "https://picsum.photos/300/200?random=4&keyword=bowl",
      "restaurant_image": "https://picsum.photos/100/100?random=14&keyword=healthy",
      "tags": ["Vegan", "Healthy", "Superfood"],
      "match_score": 91,
      "description": "Quinoa, roasted vegetables, avocado with tahini dressing",
      "why_recommended": "Perfect match for your vegetarian preferences",
      "dietary": ["Vegan", "Gluten-Free"],
      "spice_level": "Mild",
      "calories": 485,
    },
    {
      "id": 5,
      "restaurant": "Le Petit Bistro",
      "dish": "Duck Confit",
      "cuisine": "French",
      "category": "Fine Dining",
      "rating": 4.9,
      "reviews": 89,
      "price": 42.99,
      "priceRange": "luxury",
      "distance": "1.2 km",
      "deliveryTime": "45-60 min",
      "image": "https://picsum.photos/300/200?random=5&keyword=duck",
      "restaurant_image": "https://picsum.photos/100/100?random=15&keyword=french",
      "tags": ["Fine Dining", "Chef's Special"],
      "match_score": 75,
      "description": "Slow-cooked duck leg with garlic potatoes and cherry sauce",
      "why_recommended": "Exploring new flavors beyond your usual preferences",
      "dietary": [],
      "spice_level": "Mild",
      "calories": 820,
    },
    {
      "id": 6,
      "restaurant": "Burger Junction",
      "dish": "Classic Cheeseburger",
      "cuisine": "American",
      "category": "Quick Bites",
      "rating": 4.3,
      "reviews": 567,
      "price": 9.99,
      "priceRange": "budget",
      "distance": "0.4 km",
      "deliveryTime": "15-20 min",
      "image": "https://picsum.photos/300/200?random=6&keyword=burger",
      "restaurant_image": "https://picsum.photos/100/100?random=16&keyword=burger",
      "tags": ["Quick", "Comfort Food"],
      "match_score": 70,
      "description": "Juicy beef patty with cheese, lettuce, tomato, and special sauce",
      "why_recommended": "Fast delivery for when you're in a hurry",
      "dietary": [],
      "spice_level": "Mild",
      "calories": 680,
    },
  ];

  List<Map<String, dynamic>> get filteredRecommendations {
    return recommendations.where((item) {
      bool matchesCategory = selectedCategory == "For You" || item["category"] == selectedCategory;
      bool matchesPrice = priceRange == "All" || item["priceRange"] == priceRange;
      bool matchesCuisine = cuisine == "All" || item["cuisine"] == cuisine;
      bool matchesDietary = dietaryRestriction == "None" || 
                           (item["dietary"] as List).contains(dietaryRestriction);
      
      return matchesCategory && matchesPrice && matchesCuisine && matchesDietary;
    }).toList();
  }

  String _getPriceDisplay(String priceRange) {
    switch (priceRange) {
      case "budget": return "\$";
      case "moderate": return "\$\$";
      case "expensive": return "\$\$\$";
      case "luxury": return "\$\$\$\$";
      default: return "\$\$";
    }
  }

  Color _getMatchScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    if (score >= 70) return infoColor;
    return disabledBoldColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Personal Recommendations Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(25), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor,
                  child: Text(
                    "${userProfile["name"]}".split(" ").map((e) => e[0]).join(""),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi ${userProfile["name"]}!",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Based on your preferences: ${(userProfile["preferences"] as List).join(", ")}",
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
          ),

          // Category Tabs
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["name"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["name"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white.withAlpha(77) 
                                : primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${category["count"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Filters Section
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey[50],
              child: Column(
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Price Range",
                          items: priceRanges,
                          value: priceRange,
                          onChanged: (value, label) {
                            priceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Cuisine",
                          items: cuisineTypes,
                          value: cuisine,
                          onChanged: (value, label) {
                            cuisine = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Dietary",
                          items: dietaryOptions,
                          value: dietaryRestriction,
                          onChanged: (value, label) {
                            dietaryRestriction = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredRecommendations.length} recommendations found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Personalized for you",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Recommendations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredRecommendations.length,
              itemBuilder: (context, index) {
                final item = filteredRecommendations[index];
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
                      // Food Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${item["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            
                            // Match Score Badge
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getMatchScoreColor(item["match_score"] as int),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["match_score"]}% match",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Category Badge
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(153),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Item Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Restaurant and Dish
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  child: Image.network(
                                    "${item["restaurant_image"]}",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item["dish"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["restaurant"]} • ${item["cuisine"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$${(item["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Description
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Why Recommended
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${item["why_recommended"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Stats and Tags
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${item["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["distance"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  _getPriceDisplay("${item["priceRange"]}"),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: [
                                ...(item["tags"] as List).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${tag}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                
                                if ((item["dietary"] as List).isNotEmpty)
                                  ...(item["dietary"] as List).map((diet) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${diet}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Order Now",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('RestaurantDetailView')
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.favorite_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Added to favorites");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Recommendation shared");
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
          ),
        ],
      ),
    );
  }
}

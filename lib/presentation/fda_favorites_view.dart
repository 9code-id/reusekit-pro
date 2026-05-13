import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaFavoritesView extends StatefulWidget {
  const FdaFavoritesView({super.key});

  @override
  State<FdaFavoritesView> createState() => _FdaFavoritesViewState();
}

class _FdaFavoritesViewState extends State<FdaFavoritesView> {
  String selectedTab = "restaurants";
  String searchQuery = "";

  final List<Map<String, dynamic>> favoriteRestaurants = [
    {
      "id": 1,
      "name": "Mario's Pizzeria",
      "cuisine": "Italian",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "rating": 4.8,
      "reviewCount": 245,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "distance": 1.2,
      "isOpen": true,
      "priceRange": "\$\$\$",
      "lastOrdered": "2024-01-15",
      "favoriteItems": ["Margherita Pizza", "Garlic Bread"],
      "totalOrders": 8,
    },
    {
      "id": 2,
      "name": "Dragon Palace",
      "cuisine": "Chinese",
      "image": "https://picsum.photos/300/200?random=2&keyword=restaurant",
      "rating": 4.6,
      "reviewCount": 189,
      "deliveryTime": "30-40 min",
      "deliveryFee": 3.49,
      "distance": 2.1,
      "isOpen": true,
      "priceRange": "\$\$",
      "lastOrdered": "2024-01-12",
      "favoriteItems": ["Sweet & Sour Pork", "Fried Rice"],
      "totalOrders": 5,
    },
    {
      "id": 3,
      "name": "Burger Junction",
      "cuisine": "American",
      "image": "https://picsum.photos/300/200?random=3&keyword=burger",
      "rating": 4.4,
      "reviewCount": 312,
      "deliveryTime": "20-30 min",
      "deliveryFee": 1.99,
      "distance": 0.8,
      "isOpen": false,
      "priceRange": "\$\$",
      "lastOrdered": "2024-01-10",
      "favoriteItems": ["Classic Burger", "Crispy Fries"],
      "totalOrders": 12,
    },
  ];

  final List<Map<String, dynamic>> favoriteFoods = [
    {
      "id": 1,
      "name": "Margherita Pizza",
      "restaurantName": "Mario's Pizzeria",
      "image": "https://picsum.photos/300/200?random=10&keyword=pizza",
      "price": 16.99,
      "category": "Pizza",
      "rating": 4.9,
      "reviewCount": 89,
      "description": "Classic Italian pizza with fresh tomatoes and mozzarella",
      "isVegetarian": true,
      "addedDate": "2024-01-15",
      "orderCount": 6,
    },
    {
      "id": 2,
      "name": "Chicken Biryani",
      "restaurantName": "Spice Garden",
      "image": "https://picsum.photos/300/200?random=11&keyword=biryani",
      "price": 14.50,
      "category": "Indian",
      "rating": 4.7,
      "reviewCount": 156,
      "description": "Aromatic basmati rice with tender chicken and spices",
      "isVegetarian": false,
      "addedDate": "2024-01-12",
      "orderCount": 4,
    },
    {
      "id": 3,
      "name": "Caesar Salad",
      "restaurantName": "Green Leaf Cafe",
      "image": "https://picsum.photos/300/200?random=12&keyword=salad",
      "price": 9.99,
      "category": "Salad",
      "rating": 4.3,
      "reviewCount": 67,
      "description": "Fresh romaine lettuce with parmesan and croutons",
      "isVegetarian": true,
      "addedDate": "2024-01-08",
      "orderCount": 3,
    },
    {
      "id": 4,
      "name": "Pad Thai",
      "restaurantName": "Bangkok Express",
      "image": "https://picsum.photos/300/200?random=13&keyword=padthai",
      "price": 12.75,
      "category": "Thai",
      "rating": 4.8,
      "reviewCount": 234,
      "description": "Traditional Thai stir-fried noodles with shrimp",
      "isVegetarian": false,
      "addedDate": "2024-01-05",
      "orderCount": 7,
    },
  ];

  List<Map<String, dynamic>> get filteredFavoriteRestaurants {
    if (searchQuery.isEmpty) return favoriteRestaurants;
    return favoriteRestaurants.where((restaurant) {
      return (restaurant["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (restaurant["cuisine"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get filteredFavoriteFoods {
    if (searchQuery.isEmpty) return favoriteFoods;
    return favoriteFoods.where((food) {
      return (food["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (food["restaurantName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (food["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "restaurants";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "restaurants" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Restaurants",
                        style: TextStyle(
                          color: selectedTab == "restaurants" ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "foods";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "foods" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Food Items",
                        style: TextStyle(
                          color: selectedTab == "foods" ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedTab == "restaurants" 
              ? _buildRestaurantsTab() 
              : _buildFoodsTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantsTab() {
    final restaurants = filteredFavoriteRestaurants;

    if (restaurants.isEmpty) {
      return _buildEmptyState(
        "No favorite restaurants",
        "Start adding restaurants to your favorites!",
        Icons.restaurant,
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${restaurants.length} Favorite Restaurant${restaurants.length != 1 ? 's' : ''}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: restaurants.map((restaurant) {
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
                    // Restaurant Image
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                            child: Image.network(
                              "${restaurant["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: GestureDetector(
                            onTap: () {
                              _removeFromFavorites("restaurant", restaurant["id"]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
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
                        if (!(restaurant["isOpen"] as bool))
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "CLOSED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Restaurant Details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${restaurant["name"]}",
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
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${restaurant["rating"]}",
                                      style: TextStyle(
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spSm),

                          Row(
                            children: [
                              Text(
                                "${restaurant["cuisine"]} • ${restaurant["priceRange"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${restaurant["deliveryTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spSm),

                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Favorites:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(restaurant["favoriteItems"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: spSm),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ordered ${restaurant["totalOrders"]} times",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last order: ${restaurant["lastOrdered"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Order Again",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Redirecting to restaurant menu...");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  si("Sharing restaurant...");
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
        ],
      ),
    );
  }

  Widget _buildFoodsTab() {
    final foods = filteredFavoriteFoods;

    if (foods.isEmpty) {
      return _buildEmptyState(
        "No favorite foods",
        "Start adding food items to your favorites!",
        Icons.fastfood,
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${foods.length} Favorite Food${foods.length != 1 ? 's' : ''}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: foods.map((food) {
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
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                            child: Image.network(
                              "${food["image"]}",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: GestureDetector(
                            onTap: () {
                              _removeFromFavorites("food", food["id"]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [shadowSm],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        if (food["isVegetarian"] as bool)
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "VEG",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
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
                        children: [
                          Text(
                            "${food["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spXs),

                          Text(
                            "${food["restaurantName"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spXs),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${(food["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 10,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${food["rating"]}",
                                      style: TextStyle(
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spXs),

                          Text(
                            "${food["description"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spSm),

                          Text(
                            "Ordered ${food["orderCount"]} times",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),

                          SizedBox(height: spSm),

                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Order Again",
                              size: bs.sm,
                              onPressed: () {
                                ss("Added to cart!");
                              },
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

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Explore Now",
              size: bs.md,
              onPressed: () {
                //navigateTo('explore_page')
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Favorites"),
          content: QTextField(
            label: "Search",
            value: searchQuery,
            hint: "Restaurant or food name...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                searchQuery = "";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }

  void _removeFromFavorites(String type, int id) async {
    bool isConfirmed = await confirm("Remove from favorites?");
    if (isConfirmed) {
      if (type == "restaurant") {
        favoriteRestaurants.removeWhere((item) => item["id"] == id);
      } else {
        favoriteFoods.removeWhere((item) => item["id"] == id);
      }
      setState(() {});
      ss("Removed from favorites");
    }
  }
}

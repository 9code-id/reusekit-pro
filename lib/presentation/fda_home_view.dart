import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaHomeView extends StatefulWidget {
  const FdaHomeView({super.key});

  @override
  State<FdaHomeView> createState() => _FdaHomeViewState();
}

class _FdaHomeViewState extends State<FdaHomeView> {
  String searchQuery = "";
  String selectedCategory = "All";
  int currentIndex = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.restaurant},
    {"label": "Pizza", "value": "Pizza", "icon": Icons.local_pizza},
    {"label": "Burger", "value": "Burger", "icon": Icons.lunch_dining},
    {"label": "Sushi", "value": "Sushi", "icon": Icons.set_meal},
    {"label": "Dessert", "value": "Dessert", "icon": Icons.cake},
    {"label": "Drinks", "value": "Drinks", "icon": Icons.local_drink},
  ];

  List<Map<String, dynamic>> featuredRestaurants = [
    {
      "id": 1,
      "name": "Tony's Italian",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "rating": 4.8,
      "deliveryTime": "25-30 min",
      "deliveryFee": 2.99,
      "category": "Italian",
      "isPromoted": true,
    },
    {
      "id": 2,
      "name": "Burger Palace",
      "image": "https://picsum.photos/300/200?random=2&keyword=burger",
      "rating": 4.6,
      "deliveryTime": "20-25 min",
      "deliveryFee": 1.99,
      "category": "Fast Food",
      "isPromoted": false,
    },
    {
      "id": 3,
      "name": "Sushi Express",
      "image": "https://picsum.photos/300/200?random=3&keyword=sushi",
      "rating": 4.9,
      "deliveryTime": "30-35 min",
      "deliveryFee": 3.99,
      "category": "Japanese",
      "isPromoted": true,
    },
  ];

  List<Map<String, dynamic>> nearbyRestaurants = [
    {
      "id": 4,
      "name": "Pizza Corner",
      "image": "https://picsum.photos/250/150?random=4&keyword=pizza",
      "rating": 4.5,
      "deliveryTime": "15-20 min",
      "deliveryFee": 1.49,
      "category": "Pizza",
      "distance": "0.8 km",
    },
    {
      "id": 5,
      "name": "Healthy Bowls",
      "image": "https://picsum.photos/250/150?random=5&keyword=salad",
      "rating": 4.7,
      "deliveryTime": "25-30 min",
      "deliveryFee": 2.49,
      "category": "Healthy",
      "distance": "1.2 km",
    },
    {
      "id": 6,
      "name": "Coffee & More",
      "image": "https://picsum.photos/250/150?random=6&keyword=coffee",
      "rating": 4.4,
      "deliveryTime": "10-15 min",
      "deliveryFee": 0.99,
      "category": "Cafe",
      "distance": "0.5 km",
    },
  ];

  List<Map<String, dynamic>> promotions = [
    {
      "title": "Free Delivery",
      "subtitle": "On orders above \$25",
      "image": "https://picsum.photos/350/120?random=7&keyword=delivery",
      "color": successColor,
    },
    {
      "title": "50% Off",
      "subtitle": "First order discount",
      "image": "https://picsum.photos/350/120?random=8&keyword=discount",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "FoodDelivery",
      actions: [
        GestureDetector(
          onTap: () {
            //navigateTo notification view
          },
          child: Stack(
            children: [
              Icon(Icons.notifications),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Orders",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildSearchTab(),
        _buildCartTab(),
        _buildOrdersTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "What would you like to eat?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.restaurant_menu,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Search restaurants, cuisines...",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.tune,
                  color: disabledBoldColor,
                ),
              ],
            ),
          ),

          // Promotions
          Text(
            "Special Offers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QHorizontalScroll(
            children: promotions.map((promo) {
              return Container(
                width: 280,
                margin: EdgeInsets.only(right: spSm),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${promo["image"]}",
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(100),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${promo["title"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${promo["subtitle"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
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

          // Categories
          Text(
            "Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QHorizontalScroll(
            children: categories.map((category) {
              bool isSelected = selectedCategory == category["value"];
              return GestureDetector(
                onTap: () {
                  selectedCategory = category["value"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category["icon"],
                        size: 20,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${category["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Featured Restaurants
          Text(
            "Featured Restaurants",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QHorizontalScroll(
            children: featuredRestaurants.map((restaurant) {
              return GestureDetector(
                onTap: () {
                  //navigateTo FdaRestaurantDetailView
                },
                child: Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
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
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${restaurant["image"]}",
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (restaurant["isPromoted"]) ...[
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "PROMOTED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: dangerColor,
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
                              "${restaurant["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${restaurant["category"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["deliveryTime"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Delivery: \$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Nearby Restaurants
          Row(
            children: [
              Expanded(
                child: Text(
                  "Nearby Restaurants",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //navigateTo FdaRestaurantListView
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: nearbyRestaurants.map((restaurant) {
              return GestureDetector(
                onTap: () {
                  //navigateTo FdaRestaurantDetailView
                },
                child: Container(
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
                          "${restaurant["image"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${restaurant["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${restaurant["category"]} • ${restaurant["distance"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return Center(
      child: Text("Search Tab"),
    );
  }

  Widget _buildCartTab() {
    return Center(
      child: Text("Cart Tab"),
    );
  }

  Widget _buildOrdersTab() {
    return Center(
      child: Text("Orders Tab"),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text("Profile Tab"),
    );
  }
}


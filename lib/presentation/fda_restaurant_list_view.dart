import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRestaurantListView extends StatefulWidget {
  const FdaRestaurantListView({super.key});

  @override
  State<FdaRestaurantListView> createState() => _FdaRestaurantListViewState();
}

class _FdaRestaurantListViewState extends State<FdaRestaurantListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Popular";
  
  List<String> categories = ["All", "Pizza", "Burger", "Chinese", "Indian", "Dessert", "Coffee"];
  List<String> sortOptions = ["Popular", "Rating", "Delivery Time", "Distance", "Price: Low to High", "Price: High to Low"];
  
  List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "Mama's Kitchen",
      "cuisine": "Italian",
      "rating": 4.8,
      "reviewCount": 245,
      "deliveryTime": "25-30 min",
      "deliveryFee": 2.99,
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "distance": "1.2 km",
      "offers": ["Free Delivery", "20% Off"],
      "categories": ["Pizza", "Italian"],
      "isOpen": true,
      "tags": ["Fast Delivery", "Highly Rated"],
    },
    {
      "id": 2,
      "name": "Spice Garden",
      "cuisine": "Indian",
      "rating": 4.6,
      "reviewCount": 189,
      "deliveryTime": "30-35 min",
      "deliveryFee": 1.99,
      "image": "https://picsum.photos/300/200?random=2&keyword=indian",
      "distance": "2.1 km",
      "offers": ["Buy 1 Get 1"],
      "categories": ["Indian", "Curry"],
      "isOpen": true,
      "tags": ["Spicy", "Authentic"],
    },
    {
      "id": 3,
      "name": "Dragon Palace",
      "cuisine": "Chinese",
      "rating": 4.7,
      "reviewCount": 156,
      "deliveryTime": "20-25 min",
      "deliveryFee": 2.49,
      "image": "https://picsum.photos/300/200?random=3&keyword=chinese",
      "distance": "0.8 km",
      "offers": ["Free Delivery on \$30+"],
      "categories": ["Chinese", "Noodles"],
      "isOpen": true,
      "tags": ["Quick Delivery"],
    },
    {
      "id": 4,
      "name": "Burger House",
      "cuisine": "American",
      "rating": 4.3,
      "reviewCount": 78,
      "deliveryTime": "15-20 min",
      "deliveryFee": 1.49,
      "image": "https://picsum.photos/300/200?random=4&keyword=burger",
      "distance": "1.5 km",
      "offers": [],
      "categories": ["Burger", "Fast Food"],
      "isOpen": false,
      "tags": ["Fast Food"],
    },
    {
      "id": 5,
      "name": "Sweet Dreams",
      "cuisine": "Desserts",
      "rating": 4.9,
      "reviewCount": 321,
      "deliveryTime": "25-30 min",
      "deliveryFee": 2.99,
      "image": "https://picsum.photos/300/200?random=5&keyword=dessert",
      "distance": "1.8 km",
      "offers": ["Special Weekend Deal"],
      "categories": ["Dessert", "Ice Cream"],
      "isOpen": true,
      "tags": ["Best Rated", "Sweet Treats"],
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    List<Map<String, dynamic>> filtered = restaurants;
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((restaurant) {
        List<String> restaurantCategories = restaurant["categories"] as List<String>;
        return restaurantCategories.contains(selectedCategory);
      }).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((restaurant) {
        return restaurant["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               restaurant["cuisine"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort restaurants
    switch (sortBy) {
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Delivery Time":
        filtered.sort((a, b) {
          int aTime = int.parse(a["deliveryTime"].toString().split("-")[0]);
          int bTime = int.parse(b["deliveryTime"].toString().split("-")[0]);
          return aTime.compareTo(bTime);
        });
        break;
      case "Distance":
        filtered.sort((a, b) {
          double aDistance = double.parse(a["distance"].toString().split(" ")[0]);
          double bDistance = double.parse(b["distance"].toString().split(" ")[0]);
          return aDistance.compareTo(bDistance);
        });
        break;
      case "Price: Low to High":
        filtered.sort((a, b) => (a["deliveryFee"] as double).compareTo(b["deliveryFee"] as double));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => (b["deliveryFee"] as double).compareTo(a["deliveryFee"] as double));
        break;
      default: // Popular
        filtered.sort((a, b) => (b["reviewCount"] as int).compareTo(a["reviewCount"] as int));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurants"),
        actions: [
          GestureDetector(
            onTap: () {
              _showSortBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                searchQuery.isEmpty ? "Search restaurants..." : searchQuery,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: searchQuery.isEmpty ? disabledBoldColor : primaryColor,
                                ),
                              ),
                            ),
                            if (searchQuery.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  searchQuery = "";
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // --
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Category Filter
                QHorizontalScroll(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: disabledColor.withAlpha(30),
            child: Row(
              children: [
                Text(
                  "${filteredRestaurants.length} restaurants found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sort by: $sortBy",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Restaurant List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${restaurant["image"]}",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Status Overlay
                          if (!(restaurant["isOpen"] as bool))
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusMd),
                                    topRight: Radius.circular(radiusMd),
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Currently Closed",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                          // Offers Badge
                          if ((restaurant["offers"] as List).isNotEmpty)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${(restaurant["offers"] as List)[0]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          
                          // Favorite Button
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Restaurant Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name and Tags
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${restaurant["name"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if ((restaurant["tags"] as List).isNotEmpty)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(restaurant["tags"] as List)[0]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${restaurant["cuisine"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Rating and Reviews
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${restaurant["reviewCount"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Delivery Info
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${restaurant["deliveryTime"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spMd),
                                Row(
                                  children: [
                                    Icon(Icons.delivery_dining, color: disabledBoldColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spMd),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${restaurant["distance"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLg),
          topRight: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sort by",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              ...sortOptions.map((option) {
                bool isSelected = sortBy == option;
                return GestureDetector(
                  onTap: () {
                    sortBy = option;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(Icons.check, color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}


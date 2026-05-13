import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCategoryView extends StatefulWidget {
  const FdaCategoryView({super.key});

  @override
  State<FdaCategoryView> createState() => _FdaCategoryViewState();
}

class _FdaCategoryViewState extends State<FdaCategoryView> {
  String selectedCategory = "Fast Food";
  String selectedSubCategory = "All";
  bool isLoading = false;

  List<Map<String, dynamic>> categories = [
    {
      "name": "Fast Food",
      "icon": Icons.fastfood,
      "color": Colors.red,
      "restaurantCount": 124,
      "subCategories": ["All", "Burgers", "Fried Chicken", "Sandwiches", "Wraps"]
    },
    {
      "name": "Pizza",
      "icon": Icons.local_pizza,
      "color": Colors.orange,
      "restaurantCount": 89,
      "subCategories": ["All", "Italian", "Chicago Style", "New York Style", "Gourmet"]
    },
    {
      "name": "Asian",
      "icon": Icons.ramen_dining,
      "color": Colors.amber,
      "restaurantCount": 156,
      "subCategories": ["All", "Chinese", "Japanese", "Thai", "Korean", "Vietnamese"]
    },
    {
      "name": "Italian",
      "icon": Icons.restaurant_menu,
      "color": Colors.green,
      "restaurantCount": 78,
      "subCategories": ["All", "Pasta", "Pizza", "Risotto", "Gelato"]
    },
    {
      "name": "Mexican",
      "icon": Icons.local_dining,
      "color": Colors.pink,
      "restaurantCount": 92,
      "subCategories": ["All", "Tacos", "Burritos", "Quesadillas", "Nachos"]
    },
    {
      "name": "Dessert",
      "icon": Icons.cake,
      "color": Colors.purple,
      "restaurantCount": 67,
      "subCategories": ["All", "Ice Cream", "Cakes", "Pastries", "Cookies"]
    },
    {
      "name": "Coffee",
      "icon": Icons.local_cafe,
      "color": Colors.brown,
      "restaurantCount": 143,
      "subCategories": ["All", "Espresso", "Cold Brew", "Frappuccino", "Tea"]
    },
    {
      "name": "Healthy",
      "icon": Icons.eco,
      "color": Colors.lightGreen,
      "restaurantCount": 54,
      "subCategories": ["All", "Salads", "Smoothies", "Grain Bowls", "Wraps"]
    },
  ];

  List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "McDonald's",
      "image": "https://picsum.photos/300/200?random=1&keyword=mcdonalds",
      "rating": 4.2,
      "reviews": 2450,
      "deliveryTime": "15-25 min",
      "deliveryFee": 1.99,
      "distance": "0.8 km",
      "isOpen": true,
      "category": "Fast Food",
      "subCategory": "Burgers",
      "featured": true,
      "tags": ["Popular", "Fast Delivery"]
    },
    {
      "id": 2,
      "name": "KFC",
      "image": "https://picsum.photos/300/200?random=2&keyword=kfc",
      "rating": 4.1,
      "reviews": 1890,
      "deliveryTime": "20-30 min",
      "deliveryFee": 2.49,
      "distance": "1.2 km",
      "isOpen": true,
      "category": "Fast Food",
      "subCategory": "Fried Chicken",
      "featured": false,
      "tags": ["Original Recipe"]
    },
    {
      "id": 3,
      "name": "Burger King",
      "image": "https://picsum.photos/300/200?random=3&keyword=burger",
      "rating": 4.0,
      "reviews": 1560,
      "deliveryTime": "18-28 min",
      "deliveryFee": 1.99,
      "distance": "1.5 km",
      "isOpen": true,
      "category": "Fast Food",
      "subCategory": "Burgers",
      "featured": false,
      "tags": ["Flame Grilled"]
    },
    {
      "id": 4,
      "name": "Subway",
      "image": "https://picsum.photos/300/200?random=4&keyword=subway",
      "rating": 4.3,
      "reviews": 980,
      "deliveryTime": "12-22 min",
      "deliveryFee": 1.49,
      "distance": "0.9 km",
      "isOpen": true,
      "category": "Fast Food",
      "subCategory": "Sandwiches",
      "featured": true,
      "tags": ["Healthy Options", "Customizable"]
    },
    {
      "id": 5,
      "name": "Taco Bell",
      "image": "https://picsum.photos/300/200?random=5&keyword=tacobell",
      "rating": 3.9,
      "reviews": 1240,
      "deliveryTime": "15-25 min",
      "deliveryFee": 2.99,
      "distance": "2.1 km",
      "isOpen": false,
      "category": "Fast Food",
      "subCategory": "Wraps",
      "featured": false,
      "tags": ["Late Night"]
    },
    {
      "id": 6,
      "name": "Five Guys",
      "image": "https://picsum.photos/300/200?random=6&keyword=fiveguys",
      "rating": 4.6,
      "reviews": 780,
      "deliveryTime": "25-35 min",
      "deliveryFee": 3.49,
      "distance": "3.2 km",
      "isOpen": true,
      "category": "Fast Food",
      "subCategory": "Burgers",
      "featured": true,
      "tags": ["Premium", "Fresh"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentCategory = categories.firstWhere((cat) => cat["name"] == selectedCategory);
    List<String> subCategories = List<String>.from(currentCategory["subCategories"]);
    
    List<Map<String, dynamic>> filteredRestaurants = restaurants.where((restaurant) {
      bool categoryMatch = restaurant["category"] == selectedCategory;
      bool subCategoryMatch = selectedSubCategory == "All" || restaurant["subCategory"] == selectedSubCategory;
      return categoryMatch && subCategoryMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Column(
        children: [
          // Category Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (currentCategory["color"] as Color).withAlpha(30),
                  (currentCategory["color"] as Color).withAlpha(10),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: currentCategory["color"],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        currentCategory["icon"],
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCategory,
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${currentCategory["restaurantCount"]} restaurants available",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Category Selection
                QHorizontalScroll(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category["name"];
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = category["name"];
                        selectedSubCategory = "All";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"],
                              size: 16,
                              color: isSelected ? Colors.white : category["color"],
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
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
          ),

          // Sub Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter by type:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: subCategories.map((subCategory) {
                    bool isSelected = selectedSubCategory == subCategory;
                    return GestureDetector(
                      onTap: () {
                        selectedSubCategory = subCategory;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? currentCategory["color"] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? currentCategory["color"] : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          subCategory,
                          style: TextStyle(
                            fontSize: 12,
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

          // Results Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredRestaurants.length} restaurants found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ss("Opening sort options");
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Restaurant List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                children: filteredRestaurants.map((restaurant) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
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
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (restaurant["featured"])
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "FEATURED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            if (!restaurant["isOpen"])
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(100),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "CLOSED",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: primaryColor,
                                  size: 18,
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${restaurant["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${restaurant["rating"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${restaurant["subCategory"]} • ${restaurant["distance"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
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
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.delivery_dining,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "\$${restaurant["deliveryFee"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "(${restaurant["reviews"]} reviews)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              if ((restaurant["tags"] as List).isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  children: (restaurant["tags"] as List).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSearchResultsView extends StatefulWidget {
  const FdaSearchResultsView({super.key});

  @override
  State<FdaSearchResultsView> createState() => _FdaSearchResultsViewState();
}

class _FdaSearchResultsViewState extends State<FdaSearchResultsView> {
  String searchQuery = "Pizza";
  String selectedFilter = "All";
  String sortBy = "Relevance";
  bool isLoading = false;

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "name": "Tony's Pizza Palace",
      "type": "restaurant",
      "image": "https://picsum.photos/300/200?random=1&keyword=pizza",
      "rating": 4.8,
      "reviews": 1250,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "category": "Italian",
      "distance": "1.2 km",
      "isOpen": true,
      "featured": true,
    },
    {
      "id": 2,
      "name": "Margherita Pizza",
      "type": "food",
      "image": "https://picsum.photos/300/200?random=2&keyword=margherita",
      "rating": 4.6,
      "reviews": 890,
      "price": 14.99,
      "restaurant": "Bella Italia",
      "deliveryTime": "20-30 min",
      "category": "Italian",
      "description": "Classic margherita with fresh basil and mozzarella",
    },
    {
      "id": 3,
      "name": "Pizza Corner",
      "type": "restaurant",
      "image": "https://picsum.photos/300/200?random=3&keyword=pizzeria",
      "rating": 4.5,
      "reviews": 670,
      "deliveryTime": "30-40 min",
      "deliveryFee": 1.99,
      "category": "Fast Food",
      "distance": "2.1 km",
      "isOpen": true,
      "featured": false,
    },
    {
      "id": 4,
      "name": "Pepperoni Supreme",
      "type": "food",
      "image": "https://picsum.photos/300/200?random=4&keyword=pepperoni",
      "rating": 4.7,
      "reviews": 340,
      "price": 16.99,
      "restaurant": "Mario's Kitchen",
      "deliveryTime": "25-35 min",
      "category": "Italian",
      "description": "Loaded with pepperoni and extra cheese",
    },
    {
      "id": 5,
      "name": "Gourmet Pizza Co.",
      "type": "restaurant",
      "image": "https://picsum.photos/300/200?random=5&keyword=gourmet",
      "rating": 4.9,
      "reviews": 2100,
      "deliveryTime": "35-45 min",
      "deliveryFee": 3.99,
      "category": "Italian",
      "distance": "3.5 km",
      "isOpen": false,
      "featured": true,
    },
    {
      "id": 6,
      "name": "Hawaiian Pizza",
      "type": "food",
      "image": "https://picsum.photos/300/200?random=6&keyword=hawaiian",
      "rating": 4.3,
      "reviews": 520,
      "price": 15.99,
      "restaurant": "Island Bites",
      "deliveryTime": "20-30 min",
      "category": "Italian",
      "description": "Ham and pineapple on crispy crust",
    },
  ];

  List<String> filterOptions = ["All", "Restaurants", "Food Items", "Open Now", "Free Delivery"];
  List<String> sortOptions = ["Relevance", "Rating", "Delivery Time", "Distance", "Price: Low to High", "Price: High to Low"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> restaurants = searchResults.where((item) => item["type"] == "restaurant").toList();
    List<Map<String, dynamic>> foods = searchResults.where((item) => item["type"] == "food").toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Results for '$searchQuery'"),
        actions: [
          GestureDetector(
            onTap: () {
              ss("Opening search filters");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Icon(Icons.tune),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QHorizontalScroll(
                        children: filterOptions.map((filter) {
                          bool isSelected = selectedFilter == filter;
                          return GestureDetector(
                            onTap: () {
                              selectedFilter = filter;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              margin: EdgeInsets.only(right: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                filter,
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
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${searchResults.length} results found",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          ),
                          builder: (context) => Container(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sort By",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                ...sortOptions.map((option) {
                                  bool isSelected = sortBy == option;
                                  return GestureDetector(
                                    onTap: () {
                                      sortBy = option;
                                      setState(() {});
                                      back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: spSm),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            option,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isSelected ? primaryColor : primaryColor,
                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                            ),
                                          ),
                                          if (isSelected)
                                            Icon(
                                              Icons.check,
                                              color: primaryColor,
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Sort: $sortBy",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: primaryColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurants Section
                  if (restaurants.isNotEmpty) ...[
                    Text(
                      "Restaurants",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...restaurants.map((restaurant) {
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
                                    height: 150,
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
                                    "${restaurant["category"]} • ${restaurant["distance"]}",
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
                                      SizedBox(width: spSm),
                                      Text(
                                        "(${restaurant["reviews"]} reviews)",
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
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                  ],

                  // Food Items Section
                  if (foods.isNotEmpty) ...[
                    Text(
                      "Food Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...foods.map((food) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
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
                                "${food["image"]}",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
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
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${food["restaurant"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
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
                                              size: 10,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "${food["rating"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${food["reviews"]})",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${(food["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                QButton(
                                  label: "Add",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("${food["name"]} added to cart");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

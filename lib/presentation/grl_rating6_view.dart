import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating6View extends StatefulWidget {
  @override
  State<GrlRating6View> createState() => _GrlRating6ViewState();
}

class _GrlRating6ViewState extends State<GrlRating6View> {
  String selectedProduct = "all";
  String selectedTimeframe = "month";
  String sortBy = "rating";

  List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "Wireless Bluetooth Headphones",
      "image": "https://picsum.photos/150/150?random=1&keyword=headphones",
      "averageRating": 4.5,
      "totalReviews": 1247,
      "price": 299.99,
      "category": "Electronics",
      "ratingDistribution": {"5": 678, "4": 342, "3": 156, "2": 45, "1": 26},
      "recentReviews": [
        {
          "userName": "Sarah M.",
          "rating": 5.0,
          "comment": "Amazing sound quality!",
          "date": DateTime.now().subtract(Duration(days: 2)),
          "verified": true,
        },
        {
          "userName": "Mike R.",
          "rating": 4.0,
          "comment": "Great value for money",
          "date": DateTime.now().subtract(Duration(days: 5)),
          "verified": true,
        },
      ],
    },
    {
      "id": "2",
      "name": "Smart Fitness Watch",
      "image": "https://picsum.photos/150/150?random=2&keyword=watch",
      "averageRating": 4.2,
      "totalReviews": 892,
      "price": 199.99,
      "category": "Wearables",
      "ratingDistribution": {"5": 445, "4": 267, "3": 123, "2": 34, "1": 23},
      "recentReviews": [
        {
          "userName": "Lisa K.",
          "rating": 5.0,
          "comment": "Perfect for my fitness goals",
          "date": DateTime.now().subtract(Duration(days: 1)),
          "verified": true,
        },
      ],
    },
    {
      "id": "3",
      "name": "Wireless Phone Charger",
      "image": "https://picsum.photos/150/150?random=3&keyword=charger",
      "averageRating": 3.8,
      "totalReviews": 567,
      "price": 49.99,
      "category": "Accessories",
      "ratingDistribution": {"5": 178, "4": 167, "3": 134, "2": 56, "1": 32},
      "recentReviews": [
        {
          "userName": "John D.",
          "rating": 3.0,
          "comment": "Works okay but slow charging",
          "date": DateTime.now().subtract(Duration(days: 3)),
          "verified": false,
        },
      ],
    },
    {
      "id": "4",
      "name": "Bluetooth Speaker",
      "image": "https://picsum.photos/150/150?random=4&keyword=speaker",
      "averageRating": 4.7,
      "totalReviews": 2156,
      "price": 149.99,
      "category": "Audio",
      "ratingDistribution": {"5": 1234, "4": 567, "3": 234, "2": 78, "1": 43},
      "recentReviews": [
        {
          "userName": "Emma T.",
          "rating": 5.0,
          "comment": "Incredible bass and clarity!",
          "date": DateTime.now().subtract(Duration(hours: 12)),
          "verified": true,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _getFilteredProducts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Ratings"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${products.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Products",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${_getTotalReviews()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Reviews",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${_getAverageRating().toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Avg Rating",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filter Chips
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              children: [
                _buildFilterChip("All Products", "all", selectedProduct),
                _buildFilterChip("Electronics", "Electronics", selectedProduct),
                _buildFilterChip("Wearables", "Wearables", selectedProduct),
                _buildFilterChip("Audio", "Audio", selectedProduct),
                _buildFilterChip("Accessories", "Accessories", selectedProduct),
              ],
            ),
          ),

          // Sort Options
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QHorizontalScroll(
                    children: [
                      _buildSortChip("Rating", "rating"),
                      _buildSortChip("Reviews", "reviews"),
                      _buildSortChip("Price", "price"),
                      _buildSortChip("Name", "name"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Products List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${product["image"]}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${product["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "\$${(product["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Rating Overview
                      Row(
                        children: [
                          // Average Rating
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${(product["averageRating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          (product["averageRating"] as double) > starIndex ? Icons.star : Icons.star_border,
                                          size: 16,
                                          color: warningColor,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${product["totalReviews"]} reviews",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Rating Distribution
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: List.generate(5, (index) {
                                int stars = 5 - index;
                                Map<String, dynamic> distribution = product["ratingDistribution"] as Map<String, dynamic>;
                                int count = distribution["$stars"] as int;
                                double percentage = count / (product["totalReviews"] as int);
                                
                                return Container(
                                  margin: EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$stars",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: percentage,
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _getStarColor(stars),
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "$count",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Recent Reviews
                      Text(
                        "Recent Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: spSm),

                      ...(product["recentReviews"] as List).take(2).map((review) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${review["userName"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (review["verified"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: successColor,
                                  ),
                                ],
                                Spacer(),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      (review["rating"] as double) > starIndex ? Icons.star : Icons.star_border,
                                      size: 12,
                                      color: warningColor,
                                    );
                                  }),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(review["date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${review["comment"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View All Reviews",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(ProductReviewsView(productId: product["id"]));
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Rate Product",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(RateProductView(productId: product["id"]));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddProductView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue) {
    bool isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () {
        selectedProduct = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    bool isSelected = sortBy == value;
    return GestureDetector(
      onTap: () {
        sortBy = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isSelected ? primaryColor : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = List.from(products);

    // Apply category filter
    if (selectedProduct != "all") {
      filtered = filtered.where((p) => p["category"] == selectedProduct).toList();
    }

    // Apply sorting
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["averageRating"] as double).compareTo(a["averageRating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["totalReviews"] as int).compareTo(a["totalReviews"] as int));
        break;
      case "price":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "name":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
    }

    return filtered;
  }

  int _getTotalReviews() {
    return products.fold(0, (sum, product) => sum + (product["totalReviews"] as int));
  }

  double _getAverageRating() {
    if (products.isEmpty) return 0.0;
    double totalRating = products.fold(0.0, (sum, product) => sum + (product["averageRating"] as double));
    return totalRating / products.length;
  }

  Color _getStarColor(int stars) {
    switch (stars) {
      case 5:
        return successColor;
      case 4:
        return primaryColor;
      case 3:
        return warningColor;
      case 2:
        return Colors.orange;
      case 1:
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter & Sort",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: [
                "all", "Electronics", "Wearables", "Audio", "Accessories"
              ].map((category) => _buildFilterChip(
                category == "all" ? "All Products" : category,
                category,
                selectedProduct,
              )).toList(),
            ),
            SizedBox(height: spMd),
            Text(
              "Sort By",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: [
                {"label": "Rating", "value": "rating"},
                {"label": "Reviews", "value": "reviews"},
                {"label": "Price", "value": "price"},
                {"label": "Name", "value": "name"},
              ].map((sort) => GestureDetector(
                onTap: () {
                  sortBy = sort["value"]!;
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: sortBy == sort["value"] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: sortBy == sort["value"] ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    sort["label"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: sortBy == sort["value"] ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

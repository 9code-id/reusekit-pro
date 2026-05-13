import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome1View extends StatefulWidget {
  @override
  State<GrlHome1View> createState() => _GrlHome1ViewState();
}

class _GrlHome1ViewState extends State<GrlHome1View> {
  String searchQuery = "";
  int selectedCategory = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Popular", "value": "popular"},
    {"label": "Recent", "value": "recent"},
    {"label": "Trending", "value": "trending"},
  ];

  final List<Map<String, dynamic>> featuredItems = [
    {
      "id": 1,
      "title": "Modern Living Room Design",
      "subtitle": "Contemporary furniture collection",
      "image": "https://picsum.photos/300/200?random=1&keyword=living-room",
      "price": 1299.99,
      "rating": 4.8,
      "reviews": 245,
      "category": "Furniture",
      "isNew": true,
    },
    {
      "id": 2,
      "title": "Smart Home Bundle",
      "subtitle": "Complete automation system",
      "image": "https://picsum.photos/300/200?random=2&keyword=smart-home",
      "price": 899.50,
      "rating": 4.9,
      "reviews": 156,
      "category": "Technology",
      "isNew": false,
    },
    {
      "id": 3,
      "title": "Premium Kitchen Set",
      "subtitle": "Professional grade appliances",
      "image": "https://picsum.photos/300/200?random=3&keyword=kitchen",
      "price": 2499.00,
      "rating": 4.7,
      "reviews": 89,
      "category": "Appliances",
      "isNew": true,
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Browse Products",
      "icon": Icons.shopping_bag,
      "color": primaryColor,
      "count": "2.5K+",
    },
    {
      "title": "My Orders",
      "icon": Icons.receipt_long,
      "color": successColor,
      "count": "12",
    },
    {
      "title": "Wishlist",
      "icon": Icons.favorite,
      "color": dangerColor,
      "count": "48",
    },
    {
      "title": "Support",
      "icon": Icons.help_center,
      "color": infoColor,
      "count": "24/7",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Discover amazing products and deals today",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Explore Now",
                    color: Colors.white,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search products...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: quickActions.map((action) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (action["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          action["icon"] as IconData,
                          color: action["color"] as Color,
                          size: 24,
                        ),
                      ),
                      Text(
                        "${action["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${action["count"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),

            // Featured Products
            Row(
              children: [
                Text(
                  "Featured Products",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            QHorizontalScroll(
              children: featuredItems.map((item) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${item["image"]}",
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (item["isNew"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "NEW",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(230),
                                borderRadius: BorderRadius.circular(radiusXs),
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
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${item["subtitle"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    Text(
                                      "${(item["rating"] as num).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "(${item["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  "\$${((item["price"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Add to Cart",
                                size: bs.sm,
                                onPressed: () {},
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

            // Stats Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Your Shopping Stats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          children: [
                            Text(
                              "156",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Orders",
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
                          spacing: spXs,
                          children: [
                            Text(
                              "\$2,845",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
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
                          spacing: spXs,
                          children: [
                            Text(
                              "48",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Wishlist Items",
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
            ),
          ],
        ),
      ),
    );
  }
}

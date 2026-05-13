import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsTrendingProductsView extends StatefulWidget {
  const EcsTrendingProductsView({super.key});

  @override
  State<EcsTrendingProductsView> createState() => _EcsTrendingProductsViewState();
}

class _EcsTrendingProductsViewState extends State<EcsTrendingProductsView> {
  String selectedCategory = "All";
  String selectedTimeframe = "This Week";
  String sortBy = "Popularity";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Beauty", "value": "Beauty"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popularity", "value": "Popularity"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Newest", "value": "Newest"},
  ];

  List<Map<String, dynamic>> trendingProducts = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "rating": 4.8,
      "reviews": 2847,
      "trendRank": 1,
      "trendDirection": "up",
      "trendPercentage": 15.6,
      "soldCount": 1240,
      "category": "Electronics",
      "badge": "Hot Trend",
      "badgeColor": Colors.red,
    },
    {
      "id": 2,
      "name": "Smart Fitness Watch",
      "price": 199.99,
      "originalPrice": 299.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=smartwatch",
      "rating": 4.7,
      "reviews": 1923,
      "trendRank": 2,
      "trendDirection": "up",
      "trendPercentage": 12.3,
      "soldCount": 856,
      "category": "Electronics",
      "badge": "Rising Fast",
      "badgeColor": Colors.orange,
    },
    {
      "id": 3,
      "name": "Premium Skincare Set",
      "price": 79.99,
      "originalPrice": 120.00,
      "image": "https://picsum.photos/300/300?random=3&keyword=skincare",
      "rating": 4.9,
      "reviews": 3241,
      "trendRank": 3,
      "trendDirection": "up",
      "trendPercentage": 9.8,
      "soldCount": 2134,
      "category": "Beauty",
      "badge": "Top Rated",
      "badgeColor": Colors.green,
    },
    {
      "id": 4,
      "name": "Casual Summer Dress",
      "price": 45.99,
      "originalPrice": 75.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=dress",
      "rating": 4.6,
      "reviews": 1654,
      "trendRank": 4,
      "trendDirection": "up",
      "trendPercentage": 8.2,
      "soldCount": 967,
      "category": "Fashion",
      "badge": "Trending",
      "badgeColor": primaryColor,
    },
    {
      "id": 5,
      "name": "Gaming Mechanical Keyboard",
      "price": 129.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=keyboard",
      "rating": 4.8,
      "reviews": 892,
      "trendRank": 5,
      "trendDirection": "up",
      "trendPercentage": 7.1,
      "soldCount": 543,
      "category": "Electronics",
      "badge": "Gaming",
      "badgeColor": Colors.purple,
    },
    {
      "id": 6,
      "name": "Yoga Mat Premium",
      "price": 34.99,
      "originalPrice": 59.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=yoga",
      "rating": 4.7,
      "reviews": 1287,
      "trendRank": 6,
      "trendDirection": "stable",
      "trendPercentage": 5.4,
      "soldCount": 1876,
      "category": "Sports",
      "badge": "Bestseller",
      "badgeColor": Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Products"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trend Stats Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What's Trending Now",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Top products based on sales & searches",
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
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard("24.5K", "Products Sold", Icons.shopping_bag),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("156%", "Growth Rate", Icons.show_chart),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard("4.8", "Avg Rating", Icons.star),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Section
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter & Sort",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Timeframe",
                        items: timeframes,
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Trending Products Grid
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Trending Products",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${trendingProducts.length} products",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: trendingProducts.map((product) {
                    return _buildTrendingProductCard(product);
                  }).toList(),
                ),
              ],
            ),

            // Trending Categories
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QHorizontalScroll(
                  children: categories.where((cat) => cat["value"] != "All").map((category) {
                    return _buildTrendingCategoryCard(category);
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Badge and Rank
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Trend Rank
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    spacing: spXs,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 14,
                      ),
                      Text(
                        "#${product["trendRank"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Badge
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: product["badgeColor"],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${product["badge"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Price and Original Price
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${(product["originalPrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                // Rating and Reviews
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Trend Info
                Row(
                  children: [
                    Icon(
                      product["trendDirection"] == "up" ? Icons.trending_up : Icons.trending_flat,
                      color: product["trendDirection"] == "up" ? successColor : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(product["trendPercentage"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: product["trendDirection"] == "up" ? successColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${product["soldCount"]} sold",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Add to Cart Button
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
  }

  Widget _buildTrendingCategoryCard(Map<String, dynamic> category) {
    final List<IconData> categoryIcons = [
      Icons.phone_android,
      Icons.checkroom,
      Icons.home,
      Icons.sports_soccer,
      Icons.face_retouching_natural,
    ];
    
    final index = categories.indexOf(category) - 1;
    final icon = categoryIcons[index % categoryIcons.length];

    return Container(
      width: 120,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),
          Text(
            "${category["label"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Trending",
            style: TextStyle(
              fontSize: 10,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

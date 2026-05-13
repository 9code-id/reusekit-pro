import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaMarketplaceView extends StatefulWidget {
  const SmaMarketplaceView({super.key});

  @override
  State<SmaMarketplaceView> createState() => _SmaMarketplaceViewState();
}

class _SmaMarketplaceViewState extends State<SmaMarketplaceView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "recent";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.apps},
    {"label": "Electronics", "value": "Electronics", "icon": Icons.devices},
    {"label": "Clothing", "value": "Clothing", "icon": Icons.checkroom},
    {"label": "Books", "value": "Books", "icon": Icons.book},
    {"label": "Sports", "value": "Sports", "icon": Icons.sports_basketball},
    {"label": "Home", "value": "Home", "icon": Icons.home},
    {"label": "Cars", "value": "Cars", "icon": Icons.directions_car},
    {"label": "Services", "value": "Services", "icon": Icons.build},
  ];

  List<Map<String, dynamic>> marketplaceItems = [
    {
      "id": 1,
      "title": "iPhone 13 Pro Max - Like New",
      "description": "Excellent condition, barely used. Comes with original box and charger.",
      "price": 899.0,
      "originalPrice": 1099.0,
      "category": "Electronics",
      "location": "New York, NY",
      "seller": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/50/50?random=1",
        "rating": 4.8,
        "verified": true,
      },
      "images": [
        "https://picsum.photos/300/300?random=1&keyword=phone",
        "https://picsum.photos/300/300?random=2&keyword=phone",
        "https://picsum.photos/300/300?random=3&keyword=phone",
      ],
      "postedDate": "2024-06-15",
      "condition": "Like New",
      "views": 142,
      "saved": 23,
      "isFeatured": true,
    },
    {
      "id": 2,
      "title": "Vintage Leather Jacket",
      "description": "Authentic vintage leather jacket from the 80s. Perfect for collectors.",
      "price": 150.0,
      "originalPrice": 0.0,
      "category": "Clothing",
      "location": "Los Angeles, CA",
      "seller": {
        "name": "Mike Thompson",
        "avatar": "https://picsum.photos/50/50?random=4",
        "rating": 4.5,
        "verified": false,
      },
      "images": [
        "https://picsum.photos/300/300?random=5&keyword=jacket",
        "https://picsum.photos/300/300?random=6&keyword=leather",
      ],
      "postedDate": "2024-06-14",
      "condition": "Good",
      "views": 89,
      "saved": 15,
      "isFeatured": false,
    },
    {
      "id": 3,
      "title": "Complete Python Programming Course",
      "description": "Learn Python from beginner to advanced. Includes 40+ hours of video content.",
      "price": 45.0,
      "originalPrice": 199.0,
      "category": "Books",
      "location": "Chicago, IL",
      "seller": {
        "name": "Alex Rivera",
        "avatar": "https://picsum.photos/50/50?random=7",
        "rating": 4.9,
        "verified": true,
      },
      "images": [
        "https://picsum.photos/300/300?random=8&keyword=books",
        "https://picsum.photos/300/300?random=9&keyword=study",
      ],
      "postedDate": "2024-06-13",
      "condition": "New",
      "views": 67,
      "saved": 31,
      "isFeatured": true,
    },
    {
      "id": 4,
      "title": "Mountain Bike - Trek X-Caliber",
      "description": "Great condition mountain bike, perfect for trails and city riding.",
      "price": 450.0,
      "originalPrice": 650.0,
      "category": "Sports",
      "location": "Denver, CO",
      "seller": {
        "name": "Jamie Wilson",
        "avatar": "https://picsum.photos/50/50?random=10",
        "rating": 4.6,
        "verified": true,
      },
      "images": [
        "https://picsum.photos/300/300?random=11&keyword=bike",
        "https://picsum.photos/300/300?random=12&keyword=mountain",
      ],
      "postedDate": "2024-06-12",
      "condition": "Good",
      "views": 156,
      "saved": 42,
      "isFeatured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return marketplaceItems.where((item) {
      final matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('SellItemView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "What are you looking for?",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Categories
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Sort and Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: [
                      {"label": "Most Recent", "value": "recent"},
                      {"label": "Price: Low to High", "value": "price_asc"},
                      {"label": "Price: High to Low", "value": "price_desc"},
                      {"label": "Most Popular", "value": "popular"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('MarketplaceFiltersView')
                  },
                ),
              ],
            ),

            // Featured Items Section
            if (marketplaceItems.any((item) => item["isFeatured"] == true)) ...[
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "Featured Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              QHorizontalScroll(
                children: marketplaceItems
                    .where((item) => item["isFeatured"] == true)
                    .map((item) => _buildFeaturedItemCard(item))
                    .toList(),
              ),
            ],

            // All Items
            Row(
              children: [
                Text(
                  "All Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredItems.length} items",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Items Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) => _buildItemCard(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedItemCard(Map<String, dynamic> item) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Featured Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${(item["images"] as List)[0]}",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "Featured",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if ((item["originalPrice"] as double) > 0)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${(((item["originalPrice"] as double) - (item["price"] as double)) / (item["originalPrice"] as double) * 100).toInt()}% OFF",
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

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    if ((item["originalPrice"] as double) > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(item["originalPrice"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${item["location"]}",
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
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final seller = item["seller"] as Map<String, dynamic>;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${(item["images"] as List)[0]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if ((item["originalPrice"] as double) > 0)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${(((item["originalPrice"] as double) - (item["price"] as double)) / (item["originalPrice"] as double) * 100).toInt()}% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${(item["images"] as List).length}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    if ((item["originalPrice"] as double) > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(item["originalPrice"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                // Seller Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage("${seller["avatar"]}"),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${seller["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (seller["verified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  size: 12,
                                  color: successColor,
                                ),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 10, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "${seller["rating"]}",
                                style: TextStyle(
                                  fontSize: 10,
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

                Row(
                  children: [
                    Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // Stats
                Row(
                  children: [
                    Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${item["views"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.favorite_border, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${item["saved"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getConditionColor(item["condition"]).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["condition"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: _getConditionColor(item["condition"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Contact Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('MarketplaceItemView', arguments: item)
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "New":
        return successColor;
      case "Like New":
        return infoColor;
      case "Good":
        return warningColor;
      case "Fair":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

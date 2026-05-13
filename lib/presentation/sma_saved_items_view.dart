import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSavedItemsView extends StatefulWidget {
  const SmaSavedItemsView({super.key});

  @override
  State<SmaSavedItemsView> createState() => _SmaSavedItemsViewState();
}

class _SmaSavedItemsViewState extends State<SmaSavedItemsView> {
  String selectedCategory = "All";
  String sortBy = "recent";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Home", "value": "Home"},
    {"label": "Books", "value": "Books"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> savedItems = [
    {
      "id": 1,
      "title": "iPhone 13 Pro Max - Like New",
      "description": "Excellent condition, barely used. Comes with original box and charger.",
      "price": 899.0,
      "originalPrice": 1099.0,
      "category": "Electronics",
      "condition": "Like New",
      "location": "New York, NY",
      "savedDate": "2024-06-15",
      "seller": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/50/50?random=1",
        "rating": 4.8,
        "verified": true,
      },
      "image": "https://picsum.photos/300/300?random=1&keyword=phone",
      "isAvailable": true,
      "priceDropped": true,
      "originalSavedPrice": 950.0,
    },
    {
      "id": 2,
      "title": "Vintage Leather Jacket",
      "description": "Authentic vintage leather jacket from the 80s. Perfect for collectors.",
      "price": 150.0,
      "originalPrice": 0.0,
      "category": "Clothing",
      "condition": "Good",
      "location": "Los Angeles, CA",
      "savedDate": "2024-06-14",
      "seller": {
        "name": "Mike Thompson",
        "avatar": "https://picsum.photos/50/50?random=2",
        "rating": 4.5,
        "verified": false,
      },
      "image": "https://picsum.photos/300/300?random=2&keyword=jacket",
      "isAvailable": true,
      "priceDropped": false,
      "originalSavedPrice": 150.0,
    },
    {
      "id": 3,
      "title": "Complete Python Programming Course",
      "description": "Learn Python from beginner to advanced. Includes 40+ hours of video content.",
      "price": 45.0,
      "originalPrice": 199.0,
      "category": "Books",
      "condition": "New",
      "location": "Chicago, IL",
      "savedDate": "2024-06-13",
      "seller": {
        "name": "Alex Rivera",
        "avatar": "https://picsum.photos/50/50?random=3",
        "rating": 4.9,
        "verified": true,
      },
      "image": "https://picsum.photos/300/300?random=3&keyword=books",
      "isAvailable": true,
      "priceDropped": false,
      "originalSavedPrice": 45.0,
    },
    {
      "id": 4,
      "title": "Designer Handbag - Sold",
      "description": "Luxury designer handbag in perfect condition.",
      "price": 450.0,
      "originalPrice": 850.0,
      "category": "Clothing",
      "condition": "Like New",
      "location": "Miami, FL",
      "savedDate": "2024-06-10",
      "seller": {
        "name": "Emma Davis",
        "avatar": "https://picsum.photos/50/50?random=4",
        "rating": 4.7,
        "verified": true,
      },
      "image": "https://picsum.photos/300/300?random=4&keyword=handbag",
      "isAvailable": false,
      "priceDropped": false,
      "originalSavedPrice": 450.0,
    },
    {
      "id": 5,
      "title": "Gaming Laptop - RTX 3070",
      "description": "High-performance gaming laptop with RTX 3070 graphics card.",
      "price": 1200.0,
      "originalPrice": 1800.0,
      "category": "Electronics",
      "condition": "Excellent",
      "location": "Seattle, WA",
      "savedDate": "2024-06-12",
      "seller": {
        "name": "David Kim",
        "avatar": "https://picsum.photos/50/50?random=5",
        "rating": 4.6,
        "verified": true,
      },
      "image": "https://picsum.photos/300/300?random=5&keyword=laptop",
      "isAvailable": true,
      "priceDropped": true,
      "originalSavedPrice": 1350.0,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return savedItems.where((item) {
      final matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get availableItems {
    return filteredItems.where((item) => item["isAvailable"] == true).toList();
  }

  List<Map<String, dynamic>> get unavailableItems {
    return filteredItems.where((item) => item["isAvailable"] == false).toList();
  }

  List<Map<String, dynamic>> get priceDroppedItems {
    return filteredItems.where((item) => item["priceDropped"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Items"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //navigateTo('SearchView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${savedItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Saved",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${availableItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${priceDroppedItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Price Drops",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search saved items...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
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
                    label: "Sort by",
                    items: [
                      {"label": "Recently Saved", "value": "recent"},
                      {"label": "Price: Low to High", "value": "price_asc"},
                      {"label": "Price: High to Low", "value": "price_desc"},
                      {"label": "Price Drops", "value": "price_drops"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Price Drop Alerts
            if (priceDroppedItems.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_down, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Price Drop Alert!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${priceDroppedItems.length} of your saved items have dropped in price. Don't miss out!",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Available Items
            if (availableItems.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "Available Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${availableItems.length} items",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: availableItems.map((item) => _buildItemCard(item)).toList(),
              ),
            ],

            // Unavailable Items
            if (unavailableItems.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "No Longer Available",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${unavailableItems.length} items",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: unavailableItems.map((item) => _buildItemCard(item)).toList(),
              ),
            ],

            // Empty State
            if (filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No saved items yet",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Start saving items you're interested in to keep track of them here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Browse Marketplace",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('MarketplaceView')
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final seller = item["seller"] as Map<String, dynamic>;
    final isAvailable = item["isAvailable"] as bool;
    final priceDropped = item["priceDropped"] as bool;
    
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
                child: Stack(
                  children: [
                    Image.network(
                      "${item["image"]}",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (!isAvailable)
                      Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.black.withAlpha(120),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "SOLD",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Price Drop Badge
              if (priceDropped && isAvailable)
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
                        Icon(Icons.trending_down, color: Colors.white, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "Price Drop",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Unsave Button
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _unsaveItem(item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: dangerColor,
                      size: 16,
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
                    color: isAvailable ? primaryColor : disabledBoldColor,
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

                // Price Row
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${(item["price"] as double).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? successColor : disabledBoldColor,
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
                        if (priceDropped && isAvailable)
                          Text(
                            "Was \$${(item["originalSavedPrice"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 10,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
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

                // Seller Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage("${seller["avatar"]}"),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${seller["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (seller["verified"] == true)
                      Icon(
                        Icons.verified,
                        size: 12,
                        color: successColor,
                      ),
                  ],
                ),

                // Location and Date
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["location"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  "Saved ${item["savedDate"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),

                // Action Button
                Container(
                  width: double.infinity,
                  child: isAvailable
                      ? QButton(
                          label: "View Item",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('MarketplaceItemView', arguments: item)
                          },
                        )
                      : QButton(
                          label: "Find Similar",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('MarketplaceView', arguments: {'category': item["category"]})
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
      case "Excellent":
        return primaryColor;
      case "Good":
        return warningColor;
      case "Fair":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _unsaveItem(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove this item from your saved list?");
    if (isConfirmed) {
      setState(() {
        savedItems.removeWhere((savedItem) => savedItem["id"] == item["id"]);
      });
      ss("Item removed from saved list");
    }
  }
}

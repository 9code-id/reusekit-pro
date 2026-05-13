import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop10View extends StatefulWidget {
  @override
  State<GrlShop10View> createState() => _GrlShop10ViewState();
}

class _GrlShop10ViewState extends State<GrlShop10View> {
  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "name": "Premium Wireless Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "brand": "TechSound Pro",
      "rating": 4.8,
      "reviews": 2547,
      "discount": 25,
      "inStock": true,
      "category": "Electronics",
      "addedDate": "2024-06-15",
      "description": "High-quality wireless headphones with noise cancellation",
    },
    {
      "id": 2,
      "name": "Smart Fitness Watch",
      "price": 449.99,
      "originalPrice": 599.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=smartwatch",
      "brand": "FitTech Elite",
      "rating": 4.6,
      "reviews": 1890,
      "discount": 25,
      "inStock": true,
      "category": "Wearables",
      "addedDate": "2024-06-12",
      "description": "Advanced fitness tracking with health monitoring",
    },
    {
      "id": 3,
      "name": "Professional Gaming Mouse",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=mouse",
      "brand": "GameMaster Pro",
      "rating": 4.9,
      "reviews": 3250,
      "discount": 31,
      "inStock": false,
      "category": "Gaming",
      "addedDate": "2024-06-10",
      "description": "High-precision gaming mouse with RGB lighting",
    },
    {
      "id": 4,
      "name": "Bluetooth Portable Speaker",
      "price": 199.99,
      "originalPrice": 299.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=speaker",
      "brand": "SoundWave",
      "rating": 4.7,
      "reviews": 1456,
      "discount": 33,
      "inStock": true,
      "category": "Audio",
      "addedDate": "2024-06-08",
      "description": "Waterproof portable speaker with 360-degree sound",
    },
    {
      "id": 5,
      "name": "Mechanical Keyboard RGB",
      "price": 159.99,
      "originalPrice": 219.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=keyboard",
      "brand": "TypeMaster",
      "rating": 4.8,
      "reviews": 2103,
      "discount": 27,
      "inStock": true,
      "category": "Gaming",
      "addedDate": "2024-06-05",
      "description": "Premium mechanical keyboard with customizable RGB",
    },
    {
      "id": 6,
      "name": "4K Ultra HD Monitor",
      "price": 899.99,
      "originalPrice": 1199.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=monitor",
      "brand": "DisplayPro",
      "rating": 4.5,
      "reviews": 892,
      "discount": 25,
      "inStock": true,
      "category": "Displays",
      "addedDate": "2024-06-03",
      "description": "32-inch 4K monitor with HDR support",
    },
  ];

  String selectedSortOption = "newest";
  String selectedCategory = "all";
  bool showOutOfStock = true;

  List<String> sortOptions = [
    "newest",
    "oldest",
    "price_low",
    "price_high",
    "name_az",
    "rating_high",
  ];

  List<String> categories = [
    "all",
    "Electronics",
    "Wearables",
    "Gaming",
    "Audio",
    "Displays",
  ];

  List<Map<String, dynamic>> get filteredAndSortedItems {
    List<Map<String, dynamic>> filtered = wishlistItems.where((item) {
      bool categoryMatch = selectedCategory == "all" || item["category"] == selectedCategory;
      bool stockMatch = showOutOfStock || (item["inStock"] as bool);
      return categoryMatch && stockMatch;
    }).toList();

    filtered.sort((a, b) {
      switch (selectedSortOption) {
        case "newest":
          return DateTime.parse(b["addedDate"]).compareTo(DateTime.parse(a["addedDate"]));
        case "oldest":
          return DateTime.parse(a["addedDate"]).compareTo(DateTime.parse(b["addedDate"]));
        case "price_low":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "price_high":
          return (b["price"] as double).compareTo(a["price"] as double);
        case "name_az":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "rating_high":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareWishlist();
            },
          ),
        ],
      ),
      body: wishlistItems.isEmpty ? _buildEmptyWishlist() : _buildWishlistContent(),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 100,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "Your wishlist is empty",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Save items you love to your wishlist",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Start Shopping",
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistContent() {
    return Column(
      children: [
        // Filters and Sort
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Statistics
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${wishlistItems.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Items",
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
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${wishlistItems.where((item) => item["inStock"] as bool).length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "In Stock",
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
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "\$${_calculateTotalSavings().toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Total Savings",
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
              
              SizedBox(height: spMd),
              
              // Filter and Sort Controls
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories.map((category) => {
                        "label": category == "all" ? "All Categories" : category,
                        "value": category,
                      }).toList(),
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QDropdownField(
                      label: "Sort by",
                      items: [
                        {"label": "Newest First", "value": "newest"},
                        {"label": "Oldest First", "value": "oldest"},
                        {"label": "Price: Low to High", "value": "price_low"},
                        {"label": "Price: High to Low", "value": "price_high"},
                        {"label": "Name: A to Z", "value": "name_az"},
                        {"label": "Highest Rated", "value": "rating_high"},
                      ],
                      value: selectedSortOption,
                      onChanged: (value, label) {
                        selectedSortOption = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Show Out of Stock Toggle
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Show out of stock items",
                          "value": true,
                          "checked": showOutOfStock,
                        }
                      ],
                      value: [
                        if (showOutOfStock)
                          {
                            "label": "Show out of stock items",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        showOutOfStock = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Results Header
        Container(
          padding: EdgeInsets.all(spMd),
          child: Row(
            children: [
              Text(
                "${filteredAndSortedItems.length} Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (wishlistItems.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _clearWishlist();
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Wishlist Items
        Expanded(
          child: ResponsiveGridView(
            padding: EdgeInsets.all(spMd),
            minItemWidth: 200,
            children: filteredAndSortedItems.map((item) => _buildWishlistCard(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                  child: Image.network(
                    "${item["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Discount Badge
              if ((item["discount"] as int) > 0)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-${item["discount"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              
              // Remove from Wishlist
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _removeFromWishlist(item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
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
              
              // Stock Status Overlay
              if (!(item["inStock"] as bool))
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "OUT OF STOCK",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Product Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${item["category"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${item["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Price
                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((item["originalPrice"] as double) > (item["price"] as double)) ...[
                      SizedBox(width: spSm),
                      Text(
                        "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                
                if ((item["originalPrice"] as double) > (item["price"] as double))
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: Text(
                      "You save \$${((item["originalPrice"] as double) - (item["price"] as double)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Added Date
                Text(
                  "Added on ${item["addedDate"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: item["inStock"] as bool ? "Add to Cart" : "Notify When Available",
                        size: bs.sm,
                        onPressed: () {
                          if (item["inStock"] as bool) {
                            _addToCart(item);
                          } else {
                            _notifyWhenAvailable(item);
                          }
                        },
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Share",
                            size: bs.sm,
                            onPressed: () {
                              _shareItem(item);
                            },
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
  }

  double _calculateTotalSavings() {
    return wishlistItems.fold(0.0, (sum, item) => 
        sum + ((item["originalPrice"] as double) - (item["price"] as double)));
  }

  void _removeFromWishlist(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove this item from your wishlist?");
    if (isConfirmed) {
      wishlistItems.removeWhere((wishlistItem) => wishlistItem["id"] == item["id"]);
      setState(() {});
      ss("Item removed from wishlist");
    }
  }

  void _clearWishlist() async {
    bool isConfirmed = await confirm("Clear all items from your wishlist?");
    if (isConfirmed) {
      wishlistItems.clear();
      setState(() {});
      ss("Wishlist cleared successfully");
    }
  }

  void _addToCart(Map<String, dynamic> item) {
    ss("${item["name"]} added to cart!");
  }

  void _notifyWhenAvailable(Map<String, dynamic> item) {
    ss("You'll be notified when ${item["name"]} is back in stock");
  }

  void _shareItem(Map<String, dynamic> item) {
    ss("Sharing ${item["name"]}");
  }

  void _shareWishlist() {
    if (wishlistItems.isEmpty) {
      se("Your wishlist is empty");
      return;
    }
    ss("Sharing your wishlist with ${wishlistItems.length} items");
  }
}

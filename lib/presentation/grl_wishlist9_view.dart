import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist9View extends StatefulWidget {
  @override
  State<GrlWishlist9View> createState() => _GrlWishlist9ViewState();
}

class _GrlWishlist9ViewState extends State<GrlWishlist9View> {
  bool loading = false;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedSort = "newest";
  int currentTab = 0;
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Items", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Home", "value": "home"},
    {"label": "Books", "value": "books"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Price Low to High", "value": "price_asc"},
    {"label": "Price High to Low", "value": "price_desc"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Best Rated", "value": "rating"},
  ];

  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "brand": "Apple",
      "price": 1199.99,
      "originalPrice": 1299.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=smartphone",
      "category": "electronics",
      "rating": 4.8,
      "reviews": 2547,
      "discount": 8,
      "availability": "In Stock",
      "dateAdded": "2024-01-15",
      "tags": ["flagship", "premium", "camera"],
      "wishlistType": "premium",
      "priority": "high",
      "notes": "Waiting for better discount",
      "priceHistory": [1299.99, 1249.99, 1199.99],
      "store": "Apple Store",
      "isGift": false,
      "giftFor": "",
      "estimatedDelivery": "2-3 days",
      "inStock": true,
      "stockCount": 45,
      "features": ["A17 Pro chip", "Titanium design", "Action Button"],
      "specifications": {
        "screen": "6.7-inch Super Retina XDR",
        "storage": "256GB",
        "camera": "48MP Pro camera system",
        "battery": "29 hours video playback"
      }
    },
    {
      "id": 2,
      "name": "Nike Air Jordan 1 Retro High",
      "brand": "Nike",
      "price": 170.00,
      "originalPrice": 170.00,
      "image": "https://picsum.photos/300/300?random=2&keyword=sneakers",
      "category": "fashion",
      "rating": 4.7,
      "reviews": 892,
      "discount": 0,
      "availability": "Limited Stock",
      "dateAdded": "2024-01-10",
      "tags": ["sneakers", "retro", "basketball"],
      "wishlistType": "standard",
      "priority": "medium",
      "notes": "Size 10.5 preferred",
      "priceHistory": [170.00, 170.00, 170.00],
      "store": "Nike Official",
      "isGift": true,
      "giftFor": "Best Friend",
      "estimatedDelivery": "5-7 days",
      "inStock": true,
      "stockCount": 12,
      "features": ["Classic design", "Premium leather", "Air cushioning"],
      "specifications": {
        "material": "Leather and synthetic",
        "sole": "Rubber outsole",
        "height": "High-top",
        "closure": "Lace-up"
      }
    },
    {
      "id": 3,
      "name": "MacBook Pro 16-inch M3 Pro",
      "brand": "Apple",
      "price": 2499.99,
      "originalPrice": 2699.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=laptop",
      "category": "electronics",
      "rating": 4.9,
      "reviews": 1234,
      "discount": 7,
      "availability": "In Stock",
      "dateAdded": "2024-01-08",
      "tags": ["laptop", "professional", "creative"],
      "wishlistType": "premium",
      "priority": "high",
      "notes": "For video editing work",
      "priceHistory": [2699.99, 2599.99, 2499.99],
      "store": "Apple Store",
      "isGift": false,
      "giftFor": "",
      "estimatedDelivery": "1-2 days",
      "inStock": true,
      "stockCount": 8,
      "features": ["M3 Pro chip", "18-hour battery", "Liquid Retina XDR display"],
      "specifications": {
        "processor": "Apple M3 Pro 12-core CPU",
        "memory": "18GB unified memory",
        "storage": "512GB SSD",
        "display": "16.2-inch Liquid Retina XDR"
      }
    },
    {
      "id": 4,
      "name": "Dyson V15 Detect Absolute",
      "brand": "Dyson",
      "price": 649.99,
      "originalPrice": 749.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=vacuum",
      "category": "home",
      "rating": 4.6,
      "reviews": 567,
      "discount": 13,
      "availability": "In Stock",
      "dateAdded": "2024-01-05",
      "tags": ["vacuum", "cordless", "smart"],
      "wishlistType": "standard",
      "priority": "medium",
      "notes": "Great for pet hair",
      "priceHistory": [749.99, 699.99, 649.99],
      "store": "Best Buy",
      "isGift": false,
      "giftFor": "",
      "estimatedDelivery": "3-5 days",
      "inStock": true,
      "stockCount": 23,
      "features": ["Laser detect technology", "60 minutes runtime", "HEPA filtration"],
      "specifications": {
        "suction": "230 AW",
        "runtime": "Up to 60 minutes",
        "weight": "3.1 kg",
        "capacity": "0.77 liters"
      }
    },
    {
      "id": 5,
      "name": "Sony WH-1000XM5 Headphones",
      "brand": "Sony",
      "price": 349.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=headphones",
      "category": "electronics",
      "rating": 4.8,
      "reviews": 1890,
      "discount": 13,
      "availability": "In Stock",
      "dateAdded": "2024-01-03",
      "tags": ["headphones", "noise-canceling", "wireless"],
      "wishlistType": "standard",
      "priority": "low",
      "notes": "Perfect for travel",
      "priceHistory": [399.99, 379.99, 349.99],
      "store": "Amazon",
      "isGift": false,
      "giftFor": "",
      "estimatedDelivery": "2-3 days",
      "inStock": true,
      "stockCount": 67,
      "features": ["Industry-leading noise canceling", "30-hour battery", "Quick attention mode"],
      "specifications": {
        "driver": "30mm dynamic",
        "frequency": "4Hz-40kHz",
        "battery": "30 hours with ANC",
        "weight": "250g"
      }
    },
    {
      "id": 6,
      "name": "Kindle Oasis (10th Gen)",
      "brand": "Amazon",
      "price": 249.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=ebook",
      "category": "books",
      "rating": 4.5,
      "reviews": 743,
      "discount": 0,
      "availability": "In Stock",
      "dateAdded": "2023-12-28",
      "tags": ["e-reader", "waterproof", "premium"],
      "wishlistType": "standard",
      "priority": "low",
      "notes": "For reading by the pool",
      "priceHistory": [249.99, 249.99, 249.99],
      "store": "Amazon",
      "isGift": true,
      "giftFor": "Mom",
      "estimatedDelivery": "1-2 days",
      "inStock": true,
      "stockCount": 156,
      "features": ["7-inch display", "Adjustable warm light", "IPX8 waterproof"],
      "specifications": {
        "display": "7-inch 300 ppi",
        "storage": "8GB or 32GB",
        "battery": "Weeks of use",
        "connectivity": "Wi-Fi or Wi-Fi + Cellular"
      }
    }
  ];

  List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": 7,
      "name": "AirPods Pro (2nd Gen)",
      "brand": "Apple",
      "price": 249.99,
      "image": "https://picsum.photos/150/150?random=7&keyword=airpods",
      "viewedAt": "2 hours ago"
    },
    {
      "id": 8,
      "name": "Samsung Galaxy Watch 6",
      "brand": "Samsung",
      "price": 329.99,
      "image": "https://picsum.photos/150/150?random=8&keyword=smartwatch",
      "viewedAt": "1 day ago"
    },
    {
      "id": 9,
      "name": "iPad Air (5th Gen)",
      "brand": "Apple",
      "price": 599.99,
      "image": "https://picsum.photos/150/150?random=9&keyword=tablet",
      "viewedAt": "3 days ago"
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "id": 10,
      "name": "Apple Watch Series 9",
      "brand": "Apple",
      "price": 399.99,
      "discount": 10,
      "image": "https://picsum.photos/150/150?random=10&keyword=applewatch",
      "reason": "Based on your iPhone interest"
    },
    {
      "id": 11,
      "name": "Nike Dri-FIT Running Shirt",
      "brand": "Nike",
      "price": 35.99,
      "discount": 20,
      "image": "https://picsum.photos/150/150?random=11&keyword=activewear",
      "reason": "Matches your Jordan 1 style"
    },
    {
      "id": 12,
      "name": "LG OLED C3 55-inch TV",
      "brand": "LG",
      "price": 1299.99,
      "discount": 15,
      "image": "https://picsum.photos/150/150?random=12&keyword=tv",
      "reason": "Perfect for your home setup"
    }
  ];

  List<Map<String, dynamic>> priceAlerts = [
    {
      "id": 1,
      "productName": "iPhone 15 Pro Max",
      "currentPrice": 1199.99,
      "targetPrice": 1099.99,
      "difference": 100.00,
      "status": "active",
      "createdAt": "2024-01-15"
    },
    {
      "id": 2,
      "productName": "MacBook Pro 16-inch",
      "currentPrice": 2499.99,
      "targetPrice": 2299.99,
      "difference": 200.00,
      "status": "active",
      "createdAt": "2024-01-08"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Smart Wishlist",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Wishlist", icon: Icon(Icons.favorite)),
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Alerts", icon: Icon(Icons.notifications)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildWishlistTab(),
        _buildDiscoverTab(),
        _buildAlertsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildWishlistTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilter(),
          _buildWishlistStats(),
          _buildWishlistGrid(),
        ],
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRecentlyViewed(),
          _buildRecommendations(),
          _buildTrendingSection(),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPriceAlerts(),
          _buildStockAlerts(),
          _buildNotificationSettings(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSpendingAnalytics(),
          _buildCategoryBreakdown(),
          _buildSavingsReport(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search your wishlist...",
            value: searchQuery,
            hint: "Product name, brand, or category",
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
                  items: categoryItems,
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
                  items: sortItems,
                  value: selectedSort,
                  onChanged: (value, label) {
                    selectedSort = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistStats() {
    double totalValue = wishlistItems.fold(0.0, (sum, item) => sum + (item["price"] as double));
    double totalSavings = wishlistItems.fold(0.0, (sum, item) => sum + ((item["originalPrice"] as double) - (item["price"] as double)));
    int totalItems = wishlistItems.length;
    int inStockItems = wishlistItems.where((item) => item["inStock"] == true).length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Wishlist Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalValue.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Value",
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalSavings.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalItems",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$inStockItems",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: wishlistItems.map((item) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${item["image"]}",
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if ((item["discount"] as int) > 0)
                    Positioned(
                      top: spXs,
                      right: spXs,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
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
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        item["priority"] == "high" ? Icons.priority_high :
                        item["priority"] == "medium" ? Icons.remove : Icons.keyboard_arrow_down,
                        size: 16,
                        color: item["priority"] == "high" ? dangerColor :
                              item["priority"] == "medium" ? warningColor : successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${item["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${item["brand"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.star, size: 14, color: warningColor),
                  SizedBox(width: 2),
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
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Text(
                    "\$${(item["price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if ((item["originalPrice"] as double) > (item["price"] as double))
                    Padding(
                      padding: EdgeInsets.only(left: spXs),
                      child: Text(
                        "\$${(item["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: item["inStock"] ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["availability"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: item["inStock"] ? successColor : dangerColor,
                  ),
                ),
              ),
              if (item["notes"].toString().isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: spXs),
                  child: Text(
                    "${item["notes"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to product details
                      },
                    ),
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.shopping_cart,
                    size: bs.sm,
                    onPressed: () {
                      ss("Added to cart successfully!");
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      _showItemOptions(item);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentlyViewed() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recently Viewed",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: recentlyViewed.map((item) {
              return Container(
                width: 140,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${item["image"]}",
                        height: 80,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${item["viewedAt"]}",
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
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.recommend, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recommended for You",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: recommendations.map((item) {
              return Container(
                width: 160,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${item["image"]}",
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if ((item["discount"] as int) > 0)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "-${item["discount"]}%",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${item["reason"]}",
                      style: TextStyle(
                        fontSize: 9,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    QButton(
                      label: "Add to Wishlist",
                      size: bs.sm,
                      onPressed: () {
                        ss("Added to wishlist!");
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Trending Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...List.generate(3, (index) {
            final trends = [
              "iPhone 15 Series - Most searched this week",
              "Winter Fashion - 40% average discount",
              "Gaming Laptops - Black Friday deals continue"
            ];
            return Container(
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      trends[index],
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: disabledBoldColor,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPriceAlerts() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.price_check, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Price Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Alert",
                size: bs.sm,
                onPressed: () {
                  _showAddPriceAlert();
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...priceAlerts.map((alert) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${alert["productName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: alert["status"] == "active" ? successColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Current: \$${(alert["currentPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Target: \$${(alert["targetPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (alert["targetPrice"] as double) / (alert["currentPrice"] as double),
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      (alert["currentPrice"] as double) <= (alert["targetPrice"] as double) 
                        ? successColor : warningColor
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Need \$${(alert["difference"] as double).currency} more discount",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStockAlerts() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.inventory, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Stock Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Get notified when out-of-stock items become available again.",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "All wishlist items are currently in stock!",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...[
            {"title": "Price Drop Alerts", "subtitle": "When items go on sale", "enabled": true},
            {"title": "Stock Alerts", "subtitle": "When out-of-stock items return", "enabled": true},
            {"title": "New Recommendations", "subtitle": "Weekly personalized suggestions", "enabled": false},
            {"title": "Trending Items", "subtitle": "Popular products in your categories", "enabled": true},
          ].map((setting) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${setting["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${setting["subtitle"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: setting["enabled"] as bool,
                    onChanged: (value) {
                      setState(() {
                        setting["enabled"] = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpendingAnalytics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Spending Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$5,649.94",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Wishlist Value",
                        style: TextStyle(
                          fontSize: 11,
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$849.95",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Potential Savings",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Average Item Price: \$941.66",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Most Expensive Category: Electronics (67%)",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    final categories = [
      {"name": "Electronics", "count": 3, "value": 4049.97, "color": primaryColor},
      {"name": "Fashion", "count": 1, "value": 170.00, "color": warningColor},
      {"name": "Home", "count": 1, "value": 649.99, "color": successColor},
      {"name": "Books", "count": 1, "value": 249.99, "color": infoColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Category Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...categories.map((category) {
            double percentage = (category["value"] as double) / 5119.95 * 100;
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: category["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${category["count"]} items",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "\$${(category["value"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(category["color"] as Color),
                  ),
                  SizedBox(height: spXs),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${percentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSavingsReport() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.savings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Savings Report",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "You're saving smart!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "By waiting for discounts on your wishlist items, you could save up to \$529.95 compared to buying at original prices.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Best Deal:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "MacBook Pro (-\$200)",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
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

  void _showItemOptions(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Item Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Details"),
              onTap: () {
                Navigator.pop(context);
                _showEditItem(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.priority_high),
              title: Text("Change Priority"),
              onTap: () {
                Navigator.pop(context);
                _showChangePriority(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Set Price Alert"),
              onTap: () {
                Navigator.pop(context);
                _showSetPriceAlert(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Item"),
              onTap: () {
                Navigator.pop(context);
                ss("Item shared successfully!");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove from Wishlist", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Remove this item from your wishlist?");
                if (isConfirmed) {
                  setState(() {
                    wishlistItems.removeWhere((i) => i["id"] == item["id"]);
                  });
                  ss("Item removed from wishlist");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditItem(Map<String, dynamic> item) {
    String notes = item["notes"];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Notes",
              value: notes,
              hint: "Add personal notes about this item",
              onChanged: (value) {
                notes = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                item["notes"] = notes;
              });
              Navigator.pop(context);
              ss("Item updated successfully!");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showChangePriority(Map<String, dynamic> item) {
    String selectedPriority = item["priority"];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Priority"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("High Priority"),
              value: "high",
              groupValue: selectedPriority,
              onChanged: (value) {
                selectedPriority = value!;
                setState(() {});
              },
            ),
            RadioListTile(
              title: Text("Medium Priority"),
              value: "medium",
              groupValue: selectedPriority,
              onChanged: (value) {
                selectedPriority = value!;
                setState(() {});
              },
            ),
            RadioListTile(
              title: Text("Low Priority"),
              value: "low",
              groupValue: selectedPriority,
              onChanged: (value) {
                selectedPriority = value!;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                item["priority"] = selectedPriority;
              });
              Navigator.pop(context);
              ss("Priority updated successfully!");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showSetPriceAlert(Map<String, dynamic> item) {
    String targetPrice = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Current price: \$${(item["price"] as double).currency}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Target Price (\$)",
              value: targetPrice,
              hint: "Enter your desired price",
              onChanged: (value) {
                targetPrice = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (targetPrice.isNotEmpty) {
                Navigator.pop(context);
                ss("Price alert set successfully!");
              }
            },
            child: Text("Set Alert"),
          ),
        ],
      ),
    );
  }

  void _showAddPriceAlert() {
    String productName = "";
    String targetPrice = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Product Name",
              value: productName,
              hint: "Enter product name or URL",
              onChanged: (value) {
                productName = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Target Price (\$)",
              value: targetPrice,
              hint: "Enter your desired price",
              onChanged: (value) {
                targetPrice = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (productName.isNotEmpty && targetPrice.isNotEmpty) {
                Navigator.pop(context);
                ss("Price alert created successfully!");
              }
            },
            child: Text("Create Alert"),
          ),
        ],
      ),
    );
  }
}

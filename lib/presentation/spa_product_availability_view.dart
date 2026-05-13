import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductAvailabilityView extends StatefulWidget {
  const SpaProductAvailabilityView({super.key});

  @override
  State<SpaProductAvailabilityView> createState() => _SpaProductAvailabilityViewState();
}

class _SpaProductAvailabilityViewState extends State<SpaProductAvailabilityView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedRegion = "USA";
  String sortBy = "availability";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Books", "value": "Books"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "United States", "value": "USA"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Availability", "value": "availability"},
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Popularity", "value": "popularity"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "name": "iPhone 15 Pro Max",
      "category": "Electronics",
      "image": "https://picsum.photos/120/120?random=1&keyword=phone",
      "price": 1199.00,
      "popularity": 95,
      "availability": {
        "overall": "In Stock",
        "status": "available",
        "stock_level": 85,
        "estimated_delivery": "1-2 days",
        "locations": [
          {"store": "Apple Store", "status": "In Stock", "quantity": "50+", "pickup": true},
          {"store": "Best Buy", "status": "In Stock", "quantity": "25+", "pickup": true},
          {"store": "Amazon", "status": "In Stock", "quantity": "100+", "pickup": false},
          {"store": "Target", "status": "Limited", "quantity": "5-10", "pickup": true},
          {"store": "Walmart", "status": "Out of Stock", "quantity": "0", "pickup": false},
        ],
      },
      "alerts": {
        "restock_notifications": 1247,
        "price_alerts": 892,
      },
    },
    {
      "name": "Samsung Galaxy S24 Ultra",
      "category": "Electronics",
      "image": "https://picsum.photos/120/120?random=2&keyword=phone",
      "price": 1199.99,
      "popularity": 88,
      "availability": {
        "overall": "Limited Stock",
        "status": "limited",
        "stock_level": 35,
        "estimated_delivery": "3-5 days",
        "locations": [
          {"store": "Samsung Store", "status": "In Stock", "quantity": "20+", "pickup": true},
          {"store": "Best Buy", "status": "Limited", "quantity": "5-10", "pickup": true},
          {"store": "Amazon", "status": "In Stock", "quantity": "30+", "pickup": false},
          {"store": "T-Mobile", "status": "In Stock", "quantity": "15+", "pickup": true},
          {"store": "Verizon", "status": "Out of Stock", "quantity": "0", "pickup": false},
        ],
      },
      "alerts": {
        "restock_notifications": 756,
        "price_alerts": 623,
      },
    },
    {
      "name": "PlayStation 5",
      "category": "Electronics",
      "image": "https://picsum.photos/120/120?random=3&keyword=gaming",
      "price": 499.99,
      "popularity": 92,
      "availability": {
        "overall": "Out of Stock",
        "status": "out_of_stock",
        "stock_level": 0,
        "estimated_delivery": "2-3 weeks",
        "locations": [
          {"store": "Sony Direct", "status": "Out of Stock", "quantity": "0", "pickup": false},
          {"store": "Best Buy", "status": "Out of Stock", "quantity": "0", "pickup": false},
          {"store": "Amazon", "status": "Out of Stock", "quantity": "0", "pickup": false},
          {"store": "Target", "status": "Out of Stock", "quantity": "0", "pickup": false},
          {"store": "GameStop", "status": "Out of Stock", "quantity": "0", "pickup": false},
        ],
      },
      "alerts": {
        "restock_notifications": 3482,
        "price_alerts": 2156,
      },
    },
    {
      "name": "MacBook Pro M3",
      "category": "Electronics",
      "image": "https://picsum.photos/120/120?random=4&keyword=laptop",
      "price": 1999.00,
      "popularity": 78,
      "availability": {
        "overall": "In Stock",
        "status": "available",
        "stock_level": 72,
        "estimated_delivery": "1-3 days",
        "locations": [
          {"store": "Apple Store", "status": "In Stock", "quantity": "30+", "pickup": true},
          {"store": "Best Buy", "status": "In Stock", "quantity": "15+", "pickup": true},
          {"store": "Amazon", "status": "In Stock", "quantity": "50+", "pickup": false},
          {"store": "B&H Photo", "status": "In Stock", "quantity": "20+", "pickup": true},
          {"store": "Adorama", "status": "Limited", "quantity": "3-5", "pickup": true},
        ],
      },
      "alerts": {
        "restock_notifications": 423,
        "price_alerts": 789,
      },
    },
    {
      "name": "Nintendo Switch OLED",
      "category": "Electronics",
      "image": "https://picsum.photos/120/120?random=5&keyword=gaming",
      "price": 349.99,
      "popularity": 85,
      "availability": {
        "overall": "In Stock",
        "status": "available",
        "stock_level": 90,
        "estimated_delivery": "1-2 days",
        "locations": [
          {"store": "Nintendo Store", "status": "In Stock", "quantity": "50+", "pickup": false},
          {"store": "Best Buy", "status": "In Stock", "quantity": "40+", "pickup": true},
          {"store": "Amazon", "status": "In Stock", "quantity": "100+", "pickup": false},
          {"store": "Target", "status": "In Stock", "quantity": "25+", "pickup": true},
          {"store": "GameStop", "status": "In Stock", "quantity": "30+", "pickup": true},
        ],
      },
      "alerts": {
        "restock_notifications": 234,
        "price_alerts": 567,
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesSearch = searchQuery.isEmpty || 
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort products
    switch (sortBy) {
      case "price_low":
        filteredProducts.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filteredProducts.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "popularity":
        filteredProducts.sort((a, b) => (b["popularity"] as int).compareTo(a["popularity"] as int));
        break;
      default:
        filteredProducts.sort((a, b) {
          final aAvailability = (a["availability"]["stock_level"] as int);
          final bAvailability = (b["availability"]["stock_level"] as int);
          return bAvailability.compareTo(aAvailability);
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Availability"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
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

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Region",
                  items: regions,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
                    setState(() {});
                  },
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

            // Availability Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Availability Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildAvailabilityCard(
                        "In Stock",
                        "${filteredProducts.where((p) => (p["availability"]["status"] as String) == "available").length}",
                        successColor,
                        Icons.check_circle,
                      ),
                      _buildAvailabilityCard(
                        "Limited Stock",
                        "${filteredProducts.where((p) => (p["availability"]["status"] as String) == "limited").length}",
                        warningColor,
                        Icons.warning,
                      ),
                      _buildAvailabilityCard(
                        "Out of Stock",
                        "${filteredProducts.where((p) => (p["availability"]["status"] as String) == "out_of_stock").length}",
                        dangerColor,
                        Icons.error,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products List
            Text(
              "${filteredProducts.length} Products Found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductAvailabilityCard(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductAvailabilityCard(Map<String, dynamic> product) {
    final availability = product["availability"] as Map<String, dynamic>;
    final locations = (availability["locations"] as List<Map<String, dynamic>>);
    final alerts = product["alerts"] as Map<String, dynamic>;
    final status = availability["status"] as String;
    
    Color statusColor;
    switch (status) {
      case "available":
        statusColor = successColor;
        break;
      case "limited":
        statusColor = warningColor;
        break;
      default:
        statusColor = dangerColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
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
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "\$${(product["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${availability["overall"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.local_shipping, size: 12, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Delivery: ${availability["estimated_delivery"]}",
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
              Column(
                children: [
                  Text(
                    "${availability["stock_level"]}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    "Stock Level",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Stock Level Bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: (availability["stock_level"] as int) / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),

          SizedBox(height: spSm),

          // Store Availability
          Text(
            "Store Availability",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: locations.asMap().entries.map((entry) {
                final index = entry.key;
                final location = entry.value;
                final locationStatus = location["status"] as String;
                
                Color locationColor;
                switch (locationStatus) {
                  case "In Stock":
                    locationColor = successColor;
                    break;
                  case "Limited":
                    locationColor = warningColor;
                    break;
                  default:
                    locationColor = dangerColor;
                }

                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      top: index > 0 ? BorderSide(color: disabledOutlineBorderColor) : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${location["store"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: locationColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            locationStatus,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: locationColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${location["quantity"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        child: location["pickup"] as bool
                            ? Icon(Icons.storefront, size: 12, color: primaryColor)
                            : Icon(Icons.close, size: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: spSm),

          // Alerts Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification Alerts",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.notifications, size: 12, color: infoColor),
                          SizedBox(width: spXs),
                          Text(
                            "${alerts["restock_notifications"]} restock alerts",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.price_change, size: 12, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "${alerts["price_alerts"]} price alerts",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "out_of_stock" ? "Notify When Available" : "View Stores",
                  size: bs.sm,
                  onPressed: () {
                    if (status == "out_of_stock") {
                      ss("You'll be notified when ${product["name"]} is back in stock");
                    } else {
                      ss("Opening store locations...");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Set Price Alert",
                  size: bs.sm,
                  onPressed: () {
                    ss("Price alert set for ${product["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

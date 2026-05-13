import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics6View extends StatefulWidget {
  @override
  State<GrlAnalytics6View> createState() => _GrlAnalytics6ViewState();
}

class _GrlAnalytics6ViewState extends State<GrlAnalytics6View> {
  int currentTab = 0;
  String selectedCategory = "all";

  List<Map<String, dynamic>> categories = [
    {"label": "All Products", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Books", "value": "books"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> productMetrics = [
    {
      "title": "Total Products",
      "value": 1248,
      "change": 8.2,
      "icon": Icons.inventory,
      "color": Colors.blue
    },
    {
      "title": "Active Products",
      "value": 1156,
      "change": 5.4,
      "icon": Icons.check_circle,
      "color": Colors.green
    },
    {
      "title": "Out of Stock",
      "value": 92,
      "change": -12.5,
      "icon": Icons.error_outline,
      "color": Colors.red
    },
    {
      "title": "Low Stock",
      "value": 34,
      "change": -18.9,
      "icon": Icons.warning,
      "color": Colors.orange
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Wireless Headphones",
      "sku": "WH-1000XM4",
      "category": "Electronics",
      "price": 299.99,
      "stock": 145,
      "sold": 2340,
      "revenue": 701460.00,
      "rating": 4.8,
      "image": "https://picsum.photos/60/60?random=1&keyword=headphones"
    },
    {
      "name": "Smart Fitness Watch",
      "sku": "SW-FIT-PRO",
      "category": "Electronics",
      "price": 249.99,
      "stock": 89,
      "sold": 1890,
      "revenue": 472481.10,
      "rating": 4.6,
      "image": "https://picsum.photos/60/60?random=2&keyword=smartwatch"
    },
    {
      "name": "Organic Cotton T-Shirt",
      "sku": "OCT-BLK-L",
      "category": "Clothing",
      "price": 29.99,
      "stock": 234,
      "sold": 5670,
      "revenue": 170023.30,
      "rating": 4.4,
      "image": "https://picsum.photos/60/60?random=3&keyword=tshirt"
    },
    {
      "name": "JavaScript Programming Guide",
      "sku": "JSG-2024",
      "category": "Books",
      "price": 49.99,
      "stock": 78,
      "sold": 1250,
      "revenue": 62487.50,
      "rating": 4.9,
      "image": "https://picsum.photos/60/60?random=4&keyword=book"
    },
    {
      "name": "Indoor Plant Starter Kit",
      "sku": "IPSK-001",
      "category": "Home & Garden",
      "price": 39.99,
      "stock": 156,
      "sold": 980,
      "revenue": 39190.20,
      "rating": 4.5,
      "image": "https://picsum.photos/60/60?random=5&keyword=plant"
    },
  ];

  List<Map<String, dynamic>> categoryPerformance = [
    {
      "category": "Electronics",
      "products": 342,
      "revenue": 1250400.00,
      "avgPrice": 185.50,
      "growth": 15.3,
      "color": Colors.blue
    },
    {
      "category": "Clothing",
      "products": 456,
      "revenue": 890200.00,
      "avgPrice": 45.80,
      "growth": 8.7,
      "color": Colors.purple
    },
    {
      "category": "Books",
      "products": 189,
      "revenue": 234500.00,
      "avgPrice": 28.90,
      "growth": 22.1,
      "color": Colors.green
    },
    {
      "category": "Home & Garden",
      "products": 261,
      "revenue": 456700.00,
      "avgPrice": 67.30,
      "growth": 12.8,
      "color": Colors.orange
    },
  ];

  List<Map<String, dynamic>> stockAlerts = [
    {
      "product": "Gaming Keyboard",
      "sku": "GK-RGB-001",
      "current_stock": 5,
      "min_stock": 20,
      "status": "critical",
      "last_order": "2 days ago"
    },
    {
      "product": "Bluetooth Speaker",
      "sku": "BS-PORT-002",
      "current_stock": 12,
      "min_stock": 25,
      "status": "low",
      "last_order": "1 week ago"
    },
    {
      "product": "Running Shoes",
      "sku": "RS-NIKE-42",
      "current_stock": 8,
      "min_stock": 30,
      "status": "critical",
      "last_order": "3 days ago"
    },
    {
      "product": "Coffee Maker",
      "sku": "CM-AUTO-001",
      "current_stock": 18,
      "min_stock": 25,
      "status": "low",
      "last_order": "5 days ago"
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "Product Added",
      "product": "Smart Watch Series 8",
      "user": "Admin",
      "time": "2 minutes ago",
      "icon": Icons.add_circle,
      "color": Colors.green
    },
    {
      "action": "Stock Updated",
      "product": "Wireless Headphones",
      "user": "Inventory Manager",
      "time": "15 minutes ago",
      "icon": Icons.update,
      "color": Colors.blue
    },
    {
      "action": "Price Changed",
      "product": "Gaming Mouse",
      "user": "Product Manager",
      "time": "1 hour ago",
      "icon": Icons.monetization_on,
      "color": Colors.orange
    },
    {
      "action": "Product Disabled",
      "product": "Old Model Phone",
      "user": "Admin",
      "time": "2 hours ago",
      "icon": Icons.remove_circle,
      "color": Colors.red
    },
  ];

  Color _getStockStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "low":
        return warningColor;
      case "good":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Product Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPerformanceTab(),
        _buildInventoryTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: productMetrics.map((metric) {
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (metric["change"] as double) >= 0
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: (metric["change"] as double) >= 0
                                  ? successColor
                                  : dangerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(metric["value"] as int)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Performing Products",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...topProducts.take(3).map((product) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${product["image"]}",
                            width: 50,
                            height: 50,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${product["sold"]} sold",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(product["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${(product["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...categoryPerformance.map((category) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: category["color"] as Color,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${category["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "+${(category["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Products",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(category["products"] as int)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(category["revenue"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: category["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Avg Price",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(category["avgPrice"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
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
                    Text(
                      "Stock Alerts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${stockAlerts.where((alert) => alert["status"] == "critical").length} critical",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...stockAlerts.map((alert) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getStockStatusColor(alert["status"] as String).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStockStatusColor(alert["status"] as String),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${alert["product"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getStockStatusColor(alert["status"] as String).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${alert["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: _getStockStatusColor(alert["status"] as String),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SKU",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${alert["sku"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Stock",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(alert["current_stock"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _getStockStatusColor(alert["status"] as String),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Min Stock",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(alert["min_stock"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...recentActivity.map((activity) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (activity["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            activity["icon"] as IconData,
                            color: activity["color"] as Color,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${activity["product"]} by ${activity["user"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

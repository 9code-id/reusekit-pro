import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard2View extends StatefulWidget {
  @override
  State<GrlDashboard2View> createState() => _GrlDashboard2ViewState();
}

class _GrlDashboard2ViewState extends State<GrlDashboard2View> {
  bool loading = false;
  String selectedCategory = "All";
  List<Map<String, dynamic>> inventoryData = [
    {"name": "Laptop Dell XPS", "category": "Electronics", "stock": 25, "price": 1299.99, "status": "In Stock", "image": "https://picsum.photos/60/60?random=1&keyword=laptop"},
    {"name": "Office Chair", "category": "Furniture", "stock": 8, "price": 299.50, "status": "Low Stock", "image": "https://picsum.photos/60/60?random=2&keyword=chair"},
    {"name": "Wireless Mouse", "category": "Electronics", "stock": 150, "price": 29.99, "status": "In Stock", "image": "https://picsum.photos/60/60?random=3&keyword=mouse"},
    {"name": "Standing Desk", "category": "Furniture", "stock": 0, "price": 599.00, "status": "Out of Stock", "image": "https://picsum.photos/60/60?random=4&keyword=desk"},
    {"name": "Smartphone", "category": "Electronics", "stock": 45, "price": 799.99, "status": "In Stock", "image": "https://picsum.photos/60/60?random=5&keyword=phone"},
    {"name": "Coffee Machine", "category": "Appliances", "stock": 12, "price": 450.00, "status": "In Stock", "image": "https://picsum.photos/60/60?random=6&keyword=coffee"},
  ];

  List<Map<String, dynamic>> recentOrders = [
    {"id": "ORD-2024-001", "customer": "John Smith", "items": 3, "total": 1859.97, "status": "Processing", "date": "2024-01-15"},
    {"id": "ORD-2024-002", "customer": "Sarah Johnson", "items": 1, "total": 299.50, "status": "Shipped", "date": "2024-01-14"},
    {"id": "ORD-2024-003", "customer": "Mike Wilson", "items": 2, "total": 329.98, "status": "Delivered", "date": "2024-01-13"},
    {"id": "ORD-2024-004", "customer": "Emily Brown", "items": 1, "total": 799.99, "status": "Processing", "date": "2024-01-12"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Furniture", "value": "Furniture"},
    {"label": "Appliances", "value": "Appliances"},
  ];

  List<Map<String, dynamic>> get filteredInventory {
    if (selectedCategory == "All") return inventoryData;
    return inventoryData.where((item) => item["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                si("Opening add product form");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Products", "${inventoryData.length}", Icons.inventory_2, primaryColor),
                _buildStatCard("Low Stock", "${inventoryData.where((item) => item["status"] == "Low Stock").length}", Icons.warning, warningColor),
                _buildStatCard("Out of Stock", "${inventoryData.where((item) => item["status"] == "Out of Stock").length}", Icons.error, dangerColor),
                _buildStatCard("Total Value", "\$${((inventoryData.map((item) => (item["stock"] as int) * (item["price"] as double)).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K", Icons.attach_money, successColor),
              ],
            ),

            // Category Filter
            Row(
              children: [
                Text(
                  "Category:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Inventory List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Inventory",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening full inventory view");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredInventory.map((product) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor(product["status"]),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${product["image"]}"),
                                  fit: BoxFit.cover,
                                ),
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
                                    "${product["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Stock: ${product["stock"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor(product["status"]),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(product["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${product["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(product["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(product["price"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Editing ${product["name"]}");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Recent Orders
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Orders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening orders management");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentOrders.map((order) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.shopping_bag,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${order["id"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${order["customer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${order["items"]} items • ${order["date"]}",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                  "\$${(order["total"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getOrderStatusColor(order["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${order["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getOrderStatusColor(order["status"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Product",
                    icon: Icons.add_box,
                    size: bs.md,
                    onPressed: () {
                      si("Opening add product form");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Restock Alert",
                    icon: Icons.notifications,
                    size: bs.md,
                    onPressed: () {
                      sw("Setting up restock notifications");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case "Processing":
        return warningColor;
      case "Shipped":
        return infoColor;
      case "Delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}

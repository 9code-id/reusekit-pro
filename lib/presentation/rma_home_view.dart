import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaHomeView extends StatefulWidget {
  const RmaHomeView({super.key});

  @override
  State<RmaHomeView> createState() => _RmaHomeViewState();
}

class _RmaHomeViewState extends State<RmaHomeView> {
  List<Map<String, dynamic>> todaysMetrics = [
    {
      "title": "Total Orders",
      "value": 156,
      "change": 12,
      "isPositive": true,
      "icon": Icons.shopping_cart,
      "color": primaryColor
    },
    {
      "title": "Pending Orders",
      "value": 23,
      "change": -5,
      "isPositive": false,
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "Completed Today",
      "value": 89,
      "change": 18,
      "isPositive": true,
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Total Revenue",
      "value": 12450.75,
      "change": 8.5,
      "isPositive": true,
      "icon": Icons.attach_money,
      "color": infoColor
    }
  ];

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "ORD-2024-0156",
      "customerName": "John Doe",
      "items": [
        {"name": "Wireless Headphones", "qty": 1, "price": 99.99},
        {"name": "USB Cable", "qty": 2, "price": 12.99}
      ],
      "total": 125.97,
      "status": "pending",
      "priority": "high",
      "orderDate": "2024-06-19 14:30",
      "estimatedDelivery": "2024-06-21"
    },
    {
      "id": "ORD-2024-0155",
      "customerName": "Sarah Johnson",
      "items": [
        {"name": "Smartphone Case", "qty": 1, "price": 24.99},
        {"name": "Screen Protector", "qty": 1, "price": 9.99}
      ],
      "total": 34.98,
      "status": "processing",
      "priority": "medium",
      "orderDate": "2024-06-19 13:15",
      "estimatedDelivery": "2024-06-22"
    },
    {
      "id": "ORD-2024-0154",
      "customerName": "Michael Chen",
      "items": [
        {"name": "Bluetooth Speaker", "qty": 1, "price": 79.99}
      ],
      "total": 79.99,
      "status": "completed",
      "priority": "low",
      "orderDate": "2024-06-19 11:45",
      "estimatedDelivery": "2024-06-20"
    },
    {
      "id": "ORD-2024-0153",
      "customerName": "Emma Davis",
      "items": [
        {"name": "Laptop Charger", "qty": 1, "price": 45.99},
        {"name": "Mouse Pad", "qty": 1, "price": 15.99}
      ],
      "total": 61.98,
      "status": "cancelled",
      "priority": "medium",
      "orderDate": "2024-06-19 09:20",
      "estimatedDelivery": "2024-06-21"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Create Order",
      "subtitle": "Add new customer order",
      "icon": Icons.add_shopping_cart,
      "color": primaryColor,
      "route": "create_order"
    },
    {
      "title": "Scan Product",
      "subtitle": "Quick product lookup",
      "icon": Icons.qr_code_scanner,
      "color": infoColor,
      "route": "scan_product"
    },
    {
      "title": "Inventory Check",
      "subtitle": "View stock levels",
      "icon": Icons.inventory,
      "color": warningColor,
      "route": "inventory"
    },
    {
      "title": "Customer Search",
      "subtitle": "Find customer records",
      "icon": Icons.person_search,
      "color": successColor,
      "route": "customer_search"
    }
  ];

  List<Map<String, dynamic>> lowStockAlerts = [
    {
      "product": "iPhone 15 Pro Max",
      "currentStock": 3,
      "minimumStock": 10,
      "category": "Smartphones"
    },
    {
      "product": "Samsung Galaxy Buds",
      "currentStock": 5,
      "minimumStock": 15,
      "category": "Audio"
    },
    {
      "product": "MacBook Air M2",
      "currentStock": 1,
      "minimumStock": 5,
      "category": "Laptops"
    }
  ];

  String searchQuery = "";

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "processing":
        return infoColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "processing":
        return "Processing";
      case "completed":
        return "Completed";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retail Management"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {
              // Navigate to notifications
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.account_circle,
            size: bs.sm,
            onPressed: () {
              // Navigate to profile
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search orders, customers, products...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Today's Metrics
            Text(
              "Today's Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: todaysMetrics.map((metric) {
                bool isRevenue = metric["title"] == "Total Revenue";
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
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
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: metric["isPositive"] 
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  metric["isPositive"] ? Icons.arrow_upward : Icons.arrow_downward,
                                  size: 10,
                                  color: metric["isPositive"] ? successColor : dangerColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${metric["change"]}${isRevenue ? "%" : ""}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: metric["isPositive"] ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        isRevenue 
                            ? "\$${((metric["value"] as num).toDouble()).currency}"
                            : "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: metric["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickActions.map((action) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to action route
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            action["icon"] as IconData,
                            color: action["color"] as Color,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${action["subtitle"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Recent Orders
            Row(
              children: [
                Text(
                  "Recent Orders",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to all orders
                  },
                ),
              ],
            ),

            ...recentOrders.take(3).map((order) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(order["status"]),
                    ),
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusText(order["status"]).toUpperCase(),
                            style: TextStyle(
                              color: _getStatusColor(order["status"]),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${order["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${order["customerName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${order["orderDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((order["total"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Items:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          ...((order["items"] as List).map((item) {
                            return Text(
                              "• ${item["name"]} (${item["qty"]}x) - \$${((item["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            );
                          })).toList(),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to order details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show order options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Low Stock Alerts
            if (lowStockAlerts.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "Low Stock Alerts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${lowStockAlerts.length} alerts",
                      style: TextStyle(
                        color: dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: lowStockAlerts.map((alert) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: dangerColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alert["product"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${alert["category"]} • Stock: ${alert["currentStock"]} (Min: ${alert["minimumStock"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Reorder",
                            size: bs.sm,
                            onPressed: () {
                              // Reorder product
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick create order
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaRestaurantDashboardView extends StatefulWidget {
  const FmaRestaurantDashboardView({super.key});

  @override
  State<FmaRestaurantDashboardView> createState() => _FmaRestaurantDashboardViewState();
}

class _FmaRestaurantDashboardViewState extends State<FmaRestaurantDashboardView> {
  String selectedPeriod = "today";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];
  
  Map<String, dynamic> dashboardData = {
    "today": {
      "revenue": 3245.75,
      "orders": 156,
      "customers": 98,
      "avg_order": 20.80,
      "peak_hour": "12:30 PM",
      "top_item": "Grilled Salmon",
      "growth": 12.5,
    },
    "week": {
      "revenue": 18765.50,
      "orders": 890,
      "customers": 456,
      "avg_order": 21.08,
      "peak_hour": "1:00 PM",
      "top_item": "Beef Burger",
      "growth": 8.7,
    },
    "month": {
      "revenue": 89234.25,
      "orders": 4234,
      "customers": 2156,
      "avg_order": 21.07,
      "peak_hour": "12:45 PM",
      "top_item": "Caesar Salad",
      "growth": 15.2,
    },
    "year": {
      "revenue": 987654.75,
      "orders": 45678,
      "customers": 23456,
      "avg_order": 21.63,
      "peak_hour": "1:15 PM",
      "top_item": "Grilled Chicken",
      "growth": 22.4,
    },
  };
  
  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "#ORD001",
      "customer": "John Smith",
      "items": 3,
      "total": 45.50,
      "status": "Preparing",
      "time": "12:45 PM",
      "table": "Table 5",
    },
    {
      "id": "#ORD002",
      "customer": "Sarah Johnson",
      "items": 2,
      "total": 32.75,
      "status": "Ready",
      "time": "12:40 PM",
      "table": "Table 12",
    },
    {
      "id": "#ORD003",
      "customer": "Mike Wilson",
      "items": 4,
      "total": 67.20,
      "status": "Delivered",
      "time": "12:35 PM",
      "table": "Table 8",
    },
    {
      "id": "#ORD004",
      "customer": "Emma Davis",
      "items": 1,
      "total": 18.95,
      "status": "Preparing",
      "time": "12:30 PM",
      "table": "Table 3",
    },
  ];
  
  List<Map<String, dynamic>> popularItems = [
    {
      "name": "Grilled Salmon",
      "orders": 45,
      "revenue": 1125.00,
      "image": "https://picsum.photos/80/80?random=1&keyword=salmon"
    },
    {
      "name": "Beef Burger",
      "orders": 38,
      "revenue": 684.00,
      "image": "https://picsum.photos/80/80?random=2&keyword=burger"
    },
    {
      "name": "Caesar Salad",
      "orders": 32,
      "revenue": 448.00,
      "image": "https://picsum.photos/80/80?random=3&keyword=salad"
    },
    {
      "name": "Pasta Carbonara",
      "orders": 29,
      "revenue": 522.00,
      "image": "https://picsum.photos/80/80?random=4&keyword=pasta"
    },
  ];
  
  List<Map<String, dynamic>> staffPerformance = [
    {
      "name": "Alice Johnson",
      "role": "Chef",
      "orders": 78,
      "rating": 4.9,
      "status": "Online"
    },
    {
      "name": "Bob Smith",
      "role": "Waiter",
      "orders": 65,
      "rating": 4.7,
      "status": "Online"
    },
    {
      "name": "Carol Williams",
      "role": "Cashier",
      "orders": 92,
      "rating": 4.8,
      "status": "Break"
    },
    {
      "name": "David Brown",
      "role": "Kitchen Assistant",
      "orders": 43,
      "rating": 4.6,
      "status": "Online"
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    final currentData = dashboardData[selectedPeriod];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Period Filter
            QDropdownField(
              label: "Time Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                setState(() {
                  selectedPeriod = value;
                });
              },
            ),
            
            // Stats Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Revenue",
                  "\$${(currentData["revenue"] as double).currency}",
                  Icons.attach_money,
                  successColor,
                  "${(currentData["growth"] as double) > 0 ? '+' : ''}${(currentData["growth"] as double).toStringAsFixed(1)}%",
                ),
                _buildStatCard(
                  "Orders",
                  "${currentData["orders"]}",
                  Icons.receipt,
                  primaryColor,
                  "${(currentData["growth"] as double) > 0 ? '+' : ''}${(currentData["growth"] as double).toStringAsFixed(1)}%",
                ),
                _buildStatCard(
                  "Customers",
                  "${currentData["customers"]}",
                  Icons.people,
                  infoColor,
                  "${(currentData["growth"] as double) > 0 ? '+' : ''}${(currentData["growth"] as double).toStringAsFixed(1)}%",
                ),
                _buildStatCard(
                  "Avg Order",
                  "\$${(currentData["avg_order"] as double).toStringAsFixed(2)}",
                  Icons.shopping_cart,
                  warningColor,
                  "${(currentData["growth"] as double) > 0 ? '+' : ''}${(currentData["growth"] as double).toStringAsFixed(1)}%",
                ),
              ],
            ),
            
            // Quick Insights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Quick Insights",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Peak Hour",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentData["peak_hour"]}",
                              style: TextStyle(
                                fontSize: 16,
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
                              "Top Item",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentData["top_item"]}",
                              style: TextStyle(
                                fontSize: 16,
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
            ),
            
            // Recent Orders
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Orders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigate to all orders
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentOrders.take(3).map((order) => _buildOrderItem(order)),
                ],
              ),
            ),
            
            // Popular Items
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Popular Items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigate to menu analytics
                        },
                        child: Text(
                          "Analytics",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...popularItems.take(3).map((item) => _buildPopularItem(item)),
                ],
              ),
            ),
            
            // Staff Performance
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Staff Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigate to staff management
                        },
                        child: Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...staffPerformance.take(3).map((staff) => _buildStaffItem(staff)),
                ],
              ),
            ),
            
            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
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
                    minItemWidth: 140,
                    children: [
                      _buildActionCard("Add Menu Item", Icons.add, primaryColor),
                      _buildActionCard("View Menu", Icons.restaurant_menu, infoColor),
                      _buildActionCard("Manage Staff", Icons.people, successColor),
                      _buildActionCard("Reports", Icons.analytics, warningColor),
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
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color, String growth) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (growth.startsWith('+') ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  growth,
                  style: TextStyle(
                    fontSize: 10,
                    color: growth.startsWith('+') ? successColor : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
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
  
  Widget _buildOrderItem(Map<String, dynamic> order) {
    Color statusColor;
    switch (order["status"]) {
      case "Preparing":
        statusColor = warningColor;
        break;
      case "Ready":
        statusColor = infoColor;
        break;
      case "Delivered":
        statusColor = successColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                        "${order["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${order["customer"]} • ${order["table"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${order["items"]} items • \$${(order["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${order["time"]}",
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
    );
  }
  
  Widget _buildPopularItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${item["orders"]} orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(item["revenue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
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
  
  Widget _buildStaffItem(Map<String, dynamic> staff) {
    Color statusColor;
    switch (staff["status"]) {
      case "Online":
        statusColor = successColor;
        break;
      case "Break":
        statusColor = warningColor;
        break;
      case "Offline":
        statusColor = disabledBoldColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${staff["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${staff["role"]} • ${staff["orders"]} orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${(staff["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
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
  
  Widget _buildActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle action
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: color.withAlpha(50),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

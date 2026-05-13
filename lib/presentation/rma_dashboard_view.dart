import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDashboardView extends StatefulWidget {
  const RmaDashboardView({super.key});

  @override
  State<RmaDashboardView> createState() => _RmaDashboardViewState();
}

class _RmaDashboardViewState extends State<RmaDashboardView> {
  List<Map<String, dynamic>> dailyStats = [
    {
      "title": "Today's Revenue",
      "value": 15420.50,
      "icon": Icons.attach_money,
      "color": successColor,
      "percentage": 12.5,
      "trend": "up"
    },
    {
      "title": "Orders",
      "value": 127,
      "icon": Icons.receipt_long,
      "color": primaryColor,
      "percentage": -3.2,
      "trend": "down"
    },
    {
      "title": "Average Order",
      "value": 121.42,
      "icon": Icons.shopping_cart,
      "color": infoColor,
      "percentage": 8.7,
      "trend": "up"
    },
    {
      "title": "Table Turnover",
      "value": 4.2,
      "icon": Icons.table_restaurant,
      "color": warningColor,
      "percentage": 5.1,
      "trend": "up"
    },
  ];

  List<Map<String, dynamic>> recentOrders = [
    {
      "orderId": "ORD-2024-001",
      "table": "Table 5",
      "amount": 185.50,
      "status": "Completed",
      "time": "2 mins ago",
      "items": 6
    },
    {
      "orderId": "ORD-2024-002",
      "table": "Table 12",
      "amount": 240.75,
      "status": "In Progress",
      "time": "5 mins ago",
      "items": 8
    },
    {
      "orderId": "ORD-2024-003",
      "table": "Table 3",
      "amount": 95.25,
      "status": "Preparing",
      "time": "8 mins ago",
      "items": 3
    },
    {
      "orderId": "ORD-2024-004",
      "table": "Takeout",
      "amount": 67.50,
      "status": "Ready",
      "time": "12 mins ago",
      "items": 4
    },
  ];

  List<Map<String, dynamic>> topMenuItems = [
    {
      "name": "Grilled Salmon",
      "category": "Main Course",
      "sales": 45,
      "revenue": 1350.0,
      "price": 30.0
    },
    {
      "name": "Caesar Salad",
      "category": "Appetizer",
      "sales": 38,
      "revenue": 684.0,
      "price": 18.0
    },
    {
      "name": "Beef Tenderloin",
      "category": "Main Course",
      "sales": 32,
      "revenue": 1440.0,
      "price": 45.0
    },
    {
      "name": "Chocolate Lava Cake",
      "category": "Dessert",
      "sales": 28,
      "revenue": 336.0,
      "price": 12.0
    },
  ];

  List<Map<String, dynamic>> kitchenAlerts = [
    {
      "type": "Low Stock",
      "item": "Fresh Salmon",
      "severity": "high",
      "message": "Only 3 portions remaining"
    },
    {
      "type": "Order Delayed",
      "item": "Table 8 - Pasta",
      "severity": "medium",
      "message": "15 minutes behind schedule"
    },
    {
      "type": "Equipment",
      "item": "Oven #2",
      "severity": "low",
      "message": "Maintenance due tomorrow"
    },
  ];

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (stat["trend"] == "up" ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      stat["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                      color: stat["trend"] == "up" ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(stat["percentage"] as num) >= 0 ? '+' : ''}${(stat["percentage"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: stat["trend"] == "up" ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            stat["title"] == "Today's Revenue" || stat["title"] == "Average Order"
                ? "\$${((stat["value"] as num).toDouble()).currency}"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  //navigateTo('RmaOrdersView')
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
          SizedBox(height: spMd),
          ...recentOrders.map((order) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
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
                    children: [
                      Row(
                        children: [
                          Text(
                            "${order["orderId"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${order["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${order["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor("${order["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "${order["table"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ${order["items"]} items",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ${order["time"]}",
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
                Text(
                  "\$${((order["amount"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTopMenuSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Top Menu Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //navigateTo('RmaMenuAnalyticsView')
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
          SizedBox(height: spMd),
          ...topMenuItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${item["category"]} • \$${((item["price"] as num).toDouble()).currency}",
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
                      "${item["sales"]} sold",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "\$${((item["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildKitchenAlertsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Kitchen Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${kitchenAlerts.length}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...kitchenAlerts.map((alert) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getAlertColor("${alert["severity"]}").withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: _getAlertColor("${alert["severity"]}").withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getAlertIcon("${alert["type"]}"),
                  color: _getAlertColor("${alert["severity"]}"),
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${alert["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getAlertColor("${alert["severity"]}"),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${alert["item"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${alert["message"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        "title": "New Order",
        "icon": Icons.add_shopping_cart,
        "color": primaryColor,
        "route": "RmaNewOrderView"
      },
      {
        "title": "Menu",
        "icon": Icons.restaurant_menu,
        "color": successColor,
        "route": "RmaMenuManagementView"
      },
      {
        "title": "Reports",
        "icon": Icons.analytics,
        "color": infoColor,
        "route": "RmaReportsView"
      },
      {
        "title": "Settings",
        "icon": Icons.settings,
        "color": warningColor,
        "route": "RmaSettingsView"
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: actions.map((action) => GestureDetector(
              onTap: () {
                //navigateTo('${action["route"]}')
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (action["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (action["color"] as Color).withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${action["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: action["color"] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return warningColor;
      case 'preparing':
        return infoColor;
      case 'ready':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type.toLowerCase()) {
      case 'low stock':
        return Icons.inventory_2;
      case 'order delayed':
        return Icons.schedule;
      case 'equipment':
        return Icons.build;
      default:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('RmaNotificationsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            ResponsiveGridView(
              minItemWidth: 200,
              children: dailyStats.map((stat) => _buildStatCard(stat)).toList(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    spacing: spMd,
                    children: [
                      _buildRecentOrdersSection(),
                      _buildTopMenuSection(),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    spacing: spMd,
                    children: [
                      _buildKitchenAlertsSection(),
                      _buildQuickActions(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

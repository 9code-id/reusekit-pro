import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome2View extends StatefulWidget {
  @override
  State<GrlHome2View> createState() => _GrlHome2ViewState();
}

class _GrlHome2ViewState extends State<GrlHome2View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> topServices = [
    {
      "id": 1,
      "name": "Express Delivery",
      "description": "Fast delivery within 24 hours",
      "icon": Icons.local_shipping,
      "color": primaryColor,
      "orders": 1245,
      "rating": 4.9,
      "price": 15.99,
    },
    {
      "id": 2,
      "name": "Home Cleaning",
      "description": "Professional cleaning service",
      "icon": Icons.cleaning_services,
      "color": successColor,
      "orders": 987,
      "rating": 4.8,
      "price": 89.99,
    },
    {
      "id": 3,
      "name": "Tech Support",
      "description": "24/7 technical assistance",
      "icon": Icons.support_agent,
      "color": infoColor,
      "orders": 756,
      "rating": 4.7,
      "price": 49.99,
    },
    {
      "id": 4,
      "name": "Pet Care",
      "description": "Professional pet care services",
      "icon": Icons.pets,
      "color": warningColor,
      "orders": 543,
      "rating": 4.9,
      "price": 35.99,
    },
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Order Delivered",
      "subtitle": "Your electronics order has been delivered successfully",
      "time": "2 hours ago",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "New Promotion",
      "subtitle": "Get 25% off on all home appliances this weekend",
      "time": "5 hours ago",
      "icon": Icons.local_offer,
      "color": warningColor,
    },
    {
      "title": "Payment Processed",
      "subtitle": "Payment of \$299.99 has been processed successfully",
      "time": "1 day ago",
      "icon": Icons.payment,
      "color": infoColor,
    },
    {
      "title": "Review Reminder",
      "subtitle": "Please review your recent purchase from TechStore",
      "time": "2 days ago",
      "icon": Icons.rate_review,
      "color": primaryColor,
    },
  ];

  final List<Map<String, dynamic>> dashboardStats = [
    {
      "title": "Active Orders",
      "value": "12",
      "subtitle": "In progress",
      "icon": Icons.shopping_bag,
      "color": primaryColor,
      "trend": "+8%",
      "trendUp": true,
    },
    {
      "title": "Completed",
      "value": "156",
      "subtitle": "This month",
      "icon": Icons.done_all,
      "color": successColor,
      "trend": "+12%",
      "trendUp": true,
    },
    {
      "title": "Total Spent",
      "value": "\$2,845",
      "subtitle": "Last 30 days",
      "icon": Icons.account_balance_wallet,
      "color": infoColor,
      "trend": "-5%",
      "trendUp": false,
    },
    {
      "title": "Saved Amount",
      "value": "\$425",
      "subtitle": "With discounts",
      "icon": Icons.savings,
      "color": warningColor,
      "trend": "+18%",
      "trendUp": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        Text(
                          "John Anderson",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "You have 3 pending orders today",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            QTextField(
              label: "Search services or orders...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Dashboard Stats
            Text(
              "Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: dashboardStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              size: 20,
                              color: stat["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (stat["trendUp"] as bool) ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["trend"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (stat["trendUp"] as bool) ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Top Services
            Row(
              children: [
                Text(
                  "Top Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: topServices.map((service) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (service["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          service["icon"] as IconData,
                          size: 24,
                          color: service["color"] as Color,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${service["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    Text(
                                      "${(service["rating"] as num).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${service["orders"]} orders",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((service["price"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QButton(
                            label: "Book Now",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activities
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: recentActivities.map((activity) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: activity["color"] as Color,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (activity["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          activity["icon"] as IconData,
                          size: 20,
                          color: activity["color"] as Color,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${activity["subtitle"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View All Orders",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Support",
                    color: infoColor,
                    size: bs.md,
                    onPressed: () {},
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

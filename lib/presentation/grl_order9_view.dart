import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder9View extends StatefulWidget {
  @override
  State<GrlOrder9View> createState() => _GrlOrder9ViewState();
}

class _GrlOrder9ViewState extends State<GrlOrder9View> {
  int currentTab = 0;

  List<Map<String, dynamic>> salesData = [
    {
      "period": "Today",
      "orders": 45,
      "revenue": 12567.89,
      "avgOrderValue": 279.29,
      "growth": 8.5,
      "topProducts": [
        {"name": "Wireless Headphones", "sold": 15, "revenue": 2399.85},
        {"name": "Smartphone Cases", "sold": 12, "revenue": 479.88},
        {"name": "Charging Cables", "sold": 18, "revenue": 359.82},
      ]
    },
    {
      "period": "This Week",
      "orders": 287,
      "revenue": 78543.21,
      "avgOrderValue": 273.77,
      "growth": 12.3,
      "topProducts": [
        {"name": "Wireless Headphones", "sold": 89, "revenue": 14211.11},
        {"name": "Smart Watches", "sold": 34, "revenue": 10199.66},
        {"name": "Bluetooth Speakers", "sold": 67, "revenue": 8045.33},
      ]
    },
    {
      "period": "This Month",
      "orders": 1234,
      "revenue": 341567.89,
      "avgOrderValue": 276.78,
      "growth": 15.7,
      "topProducts": [
        {"name": "Wireless Headphones", "sold": 356, "revenue": 56899.44},
        {"name": "Smart Watches", "sold": 234, "revenue": 70245.66},
        {"name": "Smartphone Cases", "sold": 567, "revenue": 22679.33},
      ]
    },
  ];

  List<Map<String, dynamic>> analyticsData = [
    {
      "title": "Total Orders",
      "value": "2,847",
      "change": "+12.5%",
      "isPositive": true,
      "icon": Icons.shopping_cart,
      "color": primaryColor,
    },
    {
      "title": "Total Revenue",
      "value": "\$567,891",
      "change": "+8.9%",
      "isPositive": true,
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Avg Order Value",
      "value": "\$199.50",
      "change": "-2.1%",
      "isPositive": false,
      "icon": Icons.trending_up,
      "color": warningColor,
    },
    {
      "title": "Conversion Rate",
      "value": "3.2%",
      "change": "+0.5%",
      "isPositive": true,
      "icon": Icons.percent,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "ORD-001",
      "customer": "John Smith",
      "amount": 299.99,
      "status": "completed",
      "time": "2 min ago"
    },
    {
      "id": "ORD-002",
      "customer": "Sarah Johnson",
      "amount": 159.50,
      "status": "processing",
      "time": "5 min ago"
    },
    {
      "id": "ORD-003",
      "customer": "Mike Davis",
      "amount": 89.99,
      "status": "shipped",
      "time": "12 min ago"
    },
    {
      "id": "ORD-004",
      "customer": "Emily Wilson",
      "amount": 449.99,
      "status": "completed",
      "time": "18 min ago"
    },
    {
      "id": "ORD-005",
      "customer": "Robert Brown",
      "amount": 199.99,
      "status": "pending",
      "time": "25 min ago"
    },
  ];

  List<Map<String, dynamic>> statusBreakdown = [
    {"status": "Completed", "count": 1456, "percentage": 51.2, "color": successColor},
    {"status": "Processing", "count": 687, "percentage": 24.1, "color": infoColor},
    {"status": "Shipped", "count": 423, "percentage": 14.9, "color": primaryColor},
    {"status": "Pending", "count": 281, "percentage": 9.8, "color": warningColor},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return infoColor;
      case "shipped":
        return primaryColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "processing":
        return "Processing";
      case "shipped":
        return "Shipped";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spSm,
      children: [
        // Analytics Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 150,
          children: analyticsData.map((data) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (data["color"] as Color).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          data["icon"],
                          size: 20,
                          color: data["color"],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (data["isPositive"] ? successColor : dangerColor).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${data["change"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: data["isPositive"] ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${data["value"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${data["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        // Order Status Breakdown
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Order Status Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ...statusBreakdown.map((item) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: item["color"],
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${item["count"]} (${(item["percentage"] as double).toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * (item["percentage"] as double) / 100 * 0.6,
                            decoration: BoxDecoration(
                              color: item["color"],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item != statusBreakdown.last) SizedBox(height: spSm),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        // Recent Orders
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Recent Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // View all orders
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
              
              ...recentOrders.map((order) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
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
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(order["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(order["status"]),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                _getStatusText(order["status"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatusColor(order["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${order["time"]}",
                        style: TextStyle(
                          fontSize: 10,
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
    );
  }

  Widget _buildSalesTab() {
    return Column(
      spacing: spSm,
      children: [
        // Sales Period Cards
        ...salesData.map((data) {
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${data["period"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "+${(data["growth"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Sales Metrics
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data["orders"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                            "\$${(data["revenue"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                            "\$${(data["avgOrderValue"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Avg Order",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Divider(color: disabledColor),
                
                // Top Products
                Text(
                  "Top Products",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                
                ...(data["topProducts"] as List).map((product) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${product["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${product["sold"]} sold",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "\$${(product["revenue"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales", icon: Icon(Icons.bar_chart)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSalesTab(),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}

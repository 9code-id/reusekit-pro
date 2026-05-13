import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaInventoryOverviewView extends StatefulWidget {
  const ImaInventoryOverviewView({super.key});

  @override
  State<ImaInventoryOverviewView> createState() => _ImaInventoryOverviewViewState();
}

class _ImaInventoryOverviewViewState extends State<ImaInventoryOverviewView> {
  List<Map<String, dynamic>> statsData = [
    {
      "title": "Total Products",
      "value": 1247,
      "change": 12.5,
      "icon": Icons.inventory,
      "color": "primary"
    },
    {
      "title": "Low Stock Items",
      "value": 23,
      "change": -15.3,
      "icon": Icons.warning,
      "color": "warning"
    },
    {
      "title": "Out of Stock",
      "value": 8,
      "change": -42.1,
      "icon": Icons.error,
      "color": "danger"
    },
    {
      "title": "Total Value",
      "value": 156789,
      "change": 8.7,
      "icon": Icons.attach_money,
      "color": "success"
    }
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "Stock Added",
      "product": "iPhone 14 Pro Max",
      "quantity": 25,
      "timestamp": "2 minutes ago",
      "type": "add"
    },
    {
      "action": "Stock Updated",
      "product": "Samsung Galaxy S23",
      "quantity": 15,
      "timestamp": "15 minutes ago",
      "type": "update"
    },
    {
      "action": "Low Stock Alert",
      "product": "MacBook Air M2",
      "quantity": 3,
      "timestamp": "1 hour ago",
      "type": "alert"
    },
    {
      "action": "Stock Removed",
      "product": "iPad Pro 11\"",
      "quantity": 8,
      "timestamp": "2 hours ago",
      "type": "remove"
    },
    {
      "action": "New Product Added",
      "product": "AirPods Pro 3",
      "quantity": 50,
      "timestamp": "3 hours ago",
      "type": "new"
    }
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "iPhone 14 Pro Max",
      "sku": "IP14PM-256",
      "stock": 45,
      "reserved": 12,
      "price": 1199.99,
      "image": "https://picsum.photos/100/100?random=1&keyword=phone"
    },
    {
      "name": "Samsung Galaxy S23 Ultra",
      "sku": "SGS23U-512",
      "stock": 32,
      "reserved": 8,
      "price": 1099.99,
      "image": "https://picsum.photos/100/100?random=2&keyword=phone"
    },
    {
      "name": "MacBook Air M2",
      "sku": "MBA-M2-512",
      "stock": 18,
      "reserved": 5,
      "price": 1499.99,
      "image": "https://picsum.photos/100/100?random=3&keyword=laptop"
    },
    {
      "name": "iPad Pro 11\"",
      "sku": "IPP11-256",
      "stock": 28,
      "reserved": 7,
      "price": 899.99,
      "image": "https://picsum.photos/100/100?random=4&keyword=tablet"
    }
  ];

  String selectedPeriod = "today";
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show menu
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
            Row(
              children: [
                Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    underline: SizedBox(),
                    items: periodOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: "${option["value"]}",
                        child: Text("${option["label"]}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedPeriod = value!;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Stats Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: statsData.map((stat) {
                Color cardColor = primaryColor;
                if (stat["color"] == "warning") cardColor = warningColor;
                if (stat["color"] == "danger") cardColor = dangerColor;
                if (stat["color"] == "success") cardColor = successColor;

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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: cardColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"],
                              color: cardColor,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(stat["change"] as double) >= 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (stat["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        stat["title"] == "Total Value"
                            ? "\$${((stat["value"] as int).toDouble()).currency}"
                            : "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Container(
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Product",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to add product
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Update Stock",
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to update stock
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            // Generate report
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Export data
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Top Products
            Container(
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
                        "Top Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigate to product list
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...topProducts.map((product) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
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
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${product["sku"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Stock: ${product["stock"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Reserved: ${product["reserved"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
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
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // Edit product
                                },
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

            // Recent Activity
            Container(
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
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // View all activity
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentActivity.map((activity) {
                    IconData activityIcon = Icons.inventory;
                    Color activityColor = primaryColor;
                    
                    switch (activity["type"]) {
                      case "add":
                        activityIcon = Icons.add_circle;
                        activityColor = successColor;
                        break;
                      case "update":
                        activityIcon = Icons.update;
                        activityColor = infoColor;
                        break;
                      case "alert":
                        activityIcon = Icons.warning;
                        activityColor = warningColor;
                        break;
                      case "remove":
                        activityIcon = Icons.remove_circle;
                        activityColor = dangerColor;
                        break;
                      case "new":
                        activityIcon = Icons.fiber_new;
                        activityColor = primaryColor;
                        break;
                    }

                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: activityColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: activityColor.withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: activityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              activityIcon,
                              size: 16,
                              color: activityColor,
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
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${activity["product"]} (Qty: ${activity["quantity"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${activity["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
      ),
    );
  }
}

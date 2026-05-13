import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats6View extends StatefulWidget {
  @override
  State<GrlStats6View> createState() => _GrlStats6ViewState();
}

class _GrlStats6ViewState extends State<GrlStats6View> {
  String selectedWarehouse = "all";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> warehouseItems = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "East Coast", "value": "east"},
    {"label": "West Coast", "value": "west"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> get inventoryMetrics => [
    {
      "title": "Total Items",
      "value": "12,547",
      "trend": "+2.3%",
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Low Stock Alerts",
      "value": "23",
      "trend": "-15%",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Out of Stock",
      "value": "8",
      "trend": "+2",
      "icon": Icons.remove_circle,
      "color": dangerColor,
    },
    {
      "title": "Total Value",
      "value": "\$2.4M",
      "trend": "+5.7%",
      "icon": Icons.monetization_on,
      "color": successColor,
    },
    {
      "title": "Turnover Rate",
      "value": "85%",
      "trend": "+3.2%",
      "icon": Icons.refresh,
      "color": infoColor,
    },
    {
      "title": "Avg Stock Days",
      "value": "42",
      "trend": "-8%",
      "icon": Icons.schedule,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> get stockAlerts => [
    {
      "product": "iPhone 15 Pro Max",
      "sku": "IPH15PM-256",
      "currentStock": 8,
      "minStock": 25,
      "status": "Low Stock",
      "warehouse": "Main Warehouse",
      "lastRestocked": "2024-01-15",
      "category": "Electronics",
    },
    {
      "product": "Samsung Galaxy S24",
      "sku": "SGS24-128",
      "currentStock": 0,
      "minStock": 20,
      "status": "Out of Stock",
      "warehouse": "East Coast",
      "lastRestocked": "2024-01-10",
      "category": "Electronics",
    },
    {
      "product": "MacBook Air M3",
      "sku": "MBA-M3-512",
      "currentStock": 3,
      "minStock": 15,
      "status": "Critical",
      "warehouse": "West Coast",
      "lastRestocked": "2024-01-12",
      "category": "Electronics",
    },
    {
      "product": "AirPods Pro 2",
      "sku": "APP2-WHT",
      "currentStock": 12,
      "minStock": 30,
      "status": "Low Stock",
      "warehouse": "Main Warehouse",
      "lastRestocked": "2024-01-18",
      "category": "Electronics",
    },
  ];

  List<Map<String, dynamic>> get topMovingProducts => [
    {
      "product": "Wireless Earbuds",
      "sold": 1245,
      "revenue": 98750,
      "stock": 156,
      "velocity": 92,
      "image": "https://picsum.photos/100/100?random=1&keyword=earbuds",
    },
    {
      "product": "Smart Watch Series 9",
      "sold": 892,
      "revenue": 267600,
      "stock": 78,
      "velocity": 88,
      "image": "https://picsum.photos/100/100?random=2&keyword=watch",
    },
    {
      "product": "Gaming Headset",
      "sold": 678,
      "revenue": 67800,
      "stock": 234,
      "velocity": 75,
      "image": "https://picsum.photos/100/100?random=3&keyword=headset",
    },
    {
      "product": "Bluetooth Speaker",
      "sold": 542,
      "revenue": 43360,
      "stock": 189,
      "velocity": 68,
      "image": "https://picsum.photos/100/100?random=4&keyword=speaker",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Out of Stock":
        return dangerColor;
      case "Critical":
        return warningColor;
      case "Low Stock":
        return infoColor;
      default:
        return successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              ss("Inventory data synchronized");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Warehouse",
                    items: warehouseItems,
                    value: selectedWarehouse,
                    onChanged: (value, label) {
                      selectedWarehouse = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
            ),

            // Inventory Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: inventoryMetrics.map((metric) {
                bool isPositive = !(metric["trend"] as String).startsWith('-');
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(51),
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
                              color: isPositive ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: isPositive ? successColor : dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${metric["trend"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Stock Alerts
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
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
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stockAlerts.length} alerts",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: stockAlerts.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final alert = stockAlerts[index];
                      Color statusColor = _getStatusColor(alert["status"] as String);
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 60,
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${alert["product"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "SKU: ${alert["sku"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${alert["warehouse"]} • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${alert["category"]}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${alert["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${alert["currentStock"]}/${alert["minStock"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Last: ${alert["lastRestocked"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Top Moving Products
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Fast Moving Products",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.trending_up,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: topMovingProducts.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final product = topMovingProducts[index];
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
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
                                    "${product["product"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${product["sold"]} sold",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${product["stock"]} in stock",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: product["stock"] as int > 100 ? successColor : warningColor,
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
                                  "\$${((product["revenue"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 60,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (product["velocity"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: (product["velocity"] as int) >= 80 
                                          ? successColor 
                                          : (product["velocity"] as int) >= 60 
                                            ? warningColor 
                                            : dangerColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${product["velocity"]}% velocity",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Restock Alerts",
                    icon: Icons.add_shopping_cart,
                    size: bs.md,
                    onPressed: () {
                      ss("Restock orders created");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Inventory report exported");
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
}

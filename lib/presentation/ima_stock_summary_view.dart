import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaStockSummaryView extends StatefulWidget {
  const ImaStockSummaryView({super.key});

  @override
  State<ImaStockSummaryView> createState() => _ImaStockSummaryViewState();
}

class _ImaStockSummaryViewState extends State<ImaStockSummaryView> {
  List<Map<String, dynamic>> stockSummary = [
    {
      "category": "Electronics",
      "totalProducts": 156,
      "inStock": 134,
      "lowStock": 18,
      "outOfStock": 4,
      "totalValue": 234567.89,
      "icon": Icons.devices,
      "color": primaryColor,
    },
    {
      "category": "Clothing",
      "totalProducts": 298,
      "inStock": 267,
      "lowStock": 23,
      "outOfStock": 8,
      "totalValue": 89234.56,
      "icon": Icons.checkroom,
      "color": successColor,
    },
    {
      "category": "Home & Garden",
      "totalProducts": 187,
      "inStock": 162,
      "lowStock": 19,
      "outOfStock": 6,
      "totalValue": 145678.23,
      "icon": Icons.home,
      "color": infoColor,
    },
    {
      "category": "Sports",
      "totalProducts": 123,
      "inStock": 98,
      "lowStock": 15,
      "outOfStock": 10,
      "totalValue": 67890.12,
      "icon": Icons.sports_soccer,
      "color": warningColor,
    },
    {
      "category": "Books",
      "totalProducts": 234,
      "inStock": 189,
      "lowStock": 32,
      "outOfStock": 13,
      "totalValue": 34567.89,
      "icon": Icons.book,
      "color": secondaryColor,
    },
    {
      "category": "Beauty",
      "totalProducts": 167,
      "inStock": 142,
      "lowStock": 18,
      "outOfStock": 7,
      "totalValue": 78945.67,
      "icon": Icons.face,
      "color": dangerColor,
    }
  ];

  List<Map<String, dynamic>> stockMovement = [
    {
      "date": "2024-01-15",
      "incoming": 245,
      "outgoing": 189,
      "net": 56,
    },
    {
      "date": "2024-01-14",
      "incoming": 167,
      "outgoing": 234,
      "net": -67,
    },
    {
      "date": "2024-01-13",
      "incoming": 298,
      "outgoing": 156,
      "net": 142,
    },
    {
      "date": "2024-01-12",
      "incoming": 134,
      "outgoing": 267,
      "net": -133,
    },
    {
      "date": "2024-01-11",
      "incoming": 456,
      "outgoing": 189,
      "net": 267,
    }
  ];

  String selectedFilter = "all";
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Low Stock", "value": "low"},
    {"label": "Out of Stock", "value": "out"},
    {"label": "In Stock", "value": "in"}
  ];

  List<Map<String, dynamic>> alertItems = [
    {
      "product": "iPhone 14 Pro Max 256GB",
      "sku": "IP14PM-256",
      "currentStock": 3,
      "minStock": 10,
      "category": "Electronics",
      "alertType": "low",
      "daysLeft": 2,
    },
    {
      "product": "Samsung Galaxy Buds Pro",
      "sku": "SGBP-2023",
      "currentStock": 0,
      "minStock": 15,
      "category": "Electronics",
      "alertType": "out",
      "daysLeft": 0,
    },
    {
      "product": "Nike Air Max 270",
      "sku": "NAM-270-BLK",
      "currentStock": 2,
      "minStock": 8,
      "category": "Sports",
      "alertType": "low",
      "daysLeft": 1,
    },
    {
      "product": "MacBook Air M2 13\"",
      "sku": "MBA-M2-13",
      "currentStock": 1,
      "minStock": 5,
      "category": "Electronics",
      "alertType": "critical",
      "daysLeft": 0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportSummary();
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
            // Summary Cards
            Text(
              "Category Overview",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Filter Dropdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: DropdownButton<String>(
                value: selectedFilter,
                isExpanded: true,
                underline: SizedBox(),
                items: filterOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: "${option["value"]}",
                    child: Text("${option["label"]}"),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedFilter = value!;
                  setState(() {});
                },
              ),
            ),

            // Category Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: stockSummary.map((category) {
                double stockPercentage = ((category["inStock"] as int) / (category["totalProducts"] as int)) * 100;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (category["color"] as Color).withAlpha(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"],
                              color: category["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${stockPercentage.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: stockPercentage > 80 
                                  ? successColor 
                                  : stockPercentage > 50 
                                      ? warningColor 
                                      : dangerColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${category["category"]}",
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
                                  "Total Products",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["totalProducts"]}",
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
                                  "In Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["inStock"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
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
                                  "Low Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["lowStock"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
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
                                  "Out of Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["outOfStock"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Value: ",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(category["totalValue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: category["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Stock Movement Chart
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
                    "Stock Movement (Last 5 Days)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...stockMovement.map((movement) {
                    bool isPositive = (movement["net"] as int) >= 0;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: isPositive 
                            ? successColor.withAlpha(10) 
                            : dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isPositive 
                              ? successColor.withAlpha(30) 
                              : dangerColor.withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${movement["date"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "In: ${movement["incoming"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Out: ${movement["outgoing"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: isPositive 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Net: ${isPositive ? '+' : ''}${movement["net"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isPositive ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Stock Alerts
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
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alertItems.length} Alerts",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...alertItems.map((alert) {
                    Color alertColor = dangerColor;
                    IconData alertIcon = Icons.error;
                    String alertText = "Out of Stock";

                    if (alert["alertType"] == "low") {
                      alertColor = warningColor;
                      alertIcon = Icons.warning;
                      alertText = "Low Stock";
                    } else if (alert["alertType"] == "critical") {
                      alertColor = dangerColor;
                      alertIcon = Icons.priority_high;
                      alertText = "Critical";
                    }

                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: alertColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: alertColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: alertColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              alertIcon,
                              size: 16,
                              color: alertColor,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${alert["sku"]} • Current: ${alert["currentStock"]} • Min: ${alert["minStock"]}",
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: alertColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  alertText,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: alertColor,
                                  ),
                                ),
                              ),
                              if ((alert["daysLeft"] as int) > 0)
                                Text(
                                  "${alert["daysLeft"]} days left",
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
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Restock Items",
                    icon: Icons.add_shopping_cart,
                    size: bs.md,
                    onPressed: () {
                      // Navigate to restock
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Generate report
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: filterOptions.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: "${option["value"]}",
                groupValue: selectedFilter,
                onChanged: (value) {
                  selectedFilter = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _exportSummary() {
    ss("Stock summary exported successfully!");
  }
}

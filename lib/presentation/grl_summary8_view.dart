import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary8View extends StatefulWidget {
  @override
  State<GrlSummary8View> createState() => _GrlSummary8ViewState();
}

class _GrlSummary8ViewState extends State<GrlSummary8View> {
  List<Map<String, dynamic>> inventoryData = [
    {
      "category": "Electronics",
      "total_items": 1250,
      "in_stock": 1120,
      "low_stock": 85,
      "out_of_stock": 45,
      "value": 485000.0,
      "turnover_rate": 8.5,
      "color": primaryColor,
    },
    {
      "category": "Clothing",
      "total_items": 3200,
      "in_stock": 2890,
      "low_stock": 210,
      "out_of_stock": 100,
      "value": 320000.0,
      "turnover_rate": 12.3,
      "color": successColor,
    },
    {
      "category": "Home & Garden",
      "total_items": 850,
      "in_stock": 720,
      "low_stock": 95,
      "out_of_stock": 35,
      "value": 125000.0,
      "turnover_rate": 6.2,
      "color": infoColor,
    },
    {
      "category": "Sports",
      "total_items": 680,
      "in_stock": 615,
      "low_stock": 45,
      "out_of_stock": 20,
      "value": 89000.0,
      "turnover_rate": 9.8,
      "color": warningColor,
    },
    {
      "category": "Books",
      "total_items": 2100,
      "in_stock": 1850,
      "low_stock": 180,
      "out_of_stock": 70,
      "value": 52000.0,
      "turnover_rate": 15.6,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> topMovingItems = [
    {
      "name": "Wireless Bluetooth Headphones",
      "sku": "WBH-001",
      "sold_last_30_days": 245,
      "current_stock": 85,
      "reorder_point": 50,
      "category": "Electronics",
      "unit_price": 89.99,
    },
    {
      "name": "Premium Cotton T-Shirt",
      "sku": "PCT-002",
      "sold_last_30_days": 189,
      "current_stock": 120,
      "reorder_point": 75,
      "category": "Clothing",
      "unit_price": 24.99,
    },
    {
      "name": "Smart Fitness Tracker",
      "sku": "SFT-003",
      "sold_last_30_days": 167,
      "current_stock": 45,
      "reorder_point": 30,
      "category": "Sports",
      "unit_price": 149.99,
    },
    {
      "name": "Organic Garden Soil",
      "sku": "OGS-004",
      "sold_last_30_days": 156,
      "current_stock": 200,
      "reorder_point": 100,
      "category": "Home & Garden",
      "unit_price": 12.99,
    },
    {
      "name": "Business Strategy Guide",
      "sku": "BSG-005",
      "sold_last_30_days": 134,
      "current_stock": 65,
      "reorder_point": 40,
      "category": "Books",
      "unit_price": 29.99,
    },
  ];

  List<Map<String, dynamic>> lowStockAlerts = [
    {
      "name": "Gaming Mechanical Keyboard",
      "sku": "GMK-101",
      "current_stock": 8,
      "reorder_point": 15,
      "category": "Electronics",
      "last_ordered": "2024-11-20",
      "supplier": "Tech Supplies Co.",
      "urgency": "high",
    },
    {
      "name": "Denim Jacket - Size M",
      "sku": "DJ-M-202",
      "current_stock": 12,
      "reorder_point": 20,
      "category": "Clothing",
      "last_ordered": "2024-12-01",
      "supplier": "Fashion Hub Ltd.",
      "urgency": "medium",
    },
    {
      "name": "Yoga Mat Premium",
      "sku": "YMP-303",
      "current_stock": 5,
      "reorder_point": 25,
      "category": "Sports",
      "last_ordered": "2024-11-15",
      "supplier": "FitGear Inc.",
      "urgency": "high",
    },
    {
      "name": "LED Table Lamp",
      "sku": "LTL-404",
      "current_stock": 18,
      "reorder_point": 30,
      "category": "Home & Garden",
      "last_ordered": "2024-11-28",
      "supplier": "Home Essentials",
      "urgency": "medium",
    },
  ];

  String selectedView = "overview";

  @override
  Widget build(BuildContext context) {
    final totalItems = inventoryData.fold(0, (sum, item) => sum + (item["total_items"] as int));
    final totalValue = inventoryData.fold(0.0, (sum, item) => sum + (item["value"] as double));
    final totalLowStock = inventoryData.fold(0, (sum, item) => sum + (item["low_stock"] as int));
    final totalOutOfStock = inventoryData.fold(0, (sum, item) => sum + (item["out_of_stock"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management Summary"),
        actions: [
          Icon(Icons.inventory, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.warning, color: warningColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.inventory_2, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Inventory Health Status",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                              "Total Items",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${totalItems.toString()}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Total Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalValue.currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Alerts",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${totalLowStock + totalOutOfStock}",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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

            QCategoryPicker(
              items: [
                {"label": "Overview", "value": "overview"},
                {"label": "Stock Levels", "value": "stock_levels"},
                {"label": "Performance", "value": "performance"},
                {"label": "Alerts", "value": "alerts"},
              ],
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "In Stock Items",
                  "${inventoryData.fold(0, (sum, item) => sum + (item["in_stock"] as int))}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildMetricCard(
                  "Low Stock Alerts",
                  "$totalLowStock",
                  Icons.warning,
                  warningColor,
                ),
                _buildMetricCard(
                  "Out of Stock",
                  "$totalOutOfStock",
                  Icons.error,
                  dangerColor,
                ),
                _buildMetricCard(
                  "Avg Turnover Rate",
                  "${(inventoryData.fold(0.0, (sum, item) => sum + (item["turnover_rate"] as double)) / inventoryData.length).toStringAsFixed(1)}x",
                  Icons.trending_up,
                  infoColor,
                ),
              ],
            ),

            if (selectedView == "overview" || selectedView == "stock_levels") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category Breakdown",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: inventoryData.map((category) {
                        final stockPercentage = ((category["in_stock"] as int) / (category["total_items"] as int)) * 100;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: category["color"] as Color,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${category["category"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$${(category["value"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                          "Total: ${category["total_items"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Container(
                                          height: 6,
                                          margin: EdgeInsets.only(top: spXs),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: stockPercentage / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: category["color"] as Color,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${stockPercentage.toStringAsFixed(0)}% in stock",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if ((category["low_stock"] as int) > 0)
                                        Text(
                                          "${category["low_stock"]} low stock",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: warningColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Turnover Rate: ${(category["turnover_rate"] as double).toStringAsFixed(1)}x/year",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if ((category["out_of_stock"] as int) > 0)
                                    Text(
                                      "${category["out_of_stock"]} out of stock",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
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
            ],

            if (selectedView == "overview" || selectedView == "performance") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Moving Items (30 days)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Icon(Icons.trending_up, color: successColor, size: 20),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: topMovingItems.map((item) {
                        final needsReorder = (item["current_stock"] as int) <= (item["reorder_point"] as int);
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.inventory,
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
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "SKU: ${item["sku"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          " • ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${item["category"]}",
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
                                  Text(
                                    "${item["sold_last_30_days"]} sold",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Stock: ${item["current_stock"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: needsReorder ? dangerColor : disabledBoldColor,
                                          fontWeight: needsReorder ? FontWeight.w600 : FontWeight.normal,
                                        ),
                                      ),
                                      if (needsReorder) ...[
                                        SizedBox(width: spXs),
                                        Icon(Icons.warning, color: dangerColor, size: 12),
                                      ],
                                    ],
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
            ],

            if (selectedView == "alerts") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Low Stock Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${lowStockAlerts.length} items need attention",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: lowStockAlerts.map((alert) {
                        Color urgencyColor = warningColor;
                        if (alert["urgency"] == "high") urgencyColor = dangerColor;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: urgencyColor,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${alert["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: urgencyColor.withAlpha(26),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${alert["urgency"]} priority",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: urgencyColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "SKU: ${alert["sku"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    " • ",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Current Stock: ${alert["current_stock"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: urgencyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Reorder Point: ${alert["reorder_point"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${alert["supplier"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Last ordered: ${DateTime.parse(alert["last_ordered"]).dMMMy}",
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
                    ),
                  ],
                ),
              ),
            ],

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate PO",
                    icon: Icons.add_shopping_cart,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
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
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
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
}

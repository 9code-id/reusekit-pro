import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmLowStockAlertsView extends StatefulWidget {
  const IwmLowStockAlertsView({super.key});

  @override
  State<IwmLowStockAlertsView> createState() => _IwmLowStockAlertsViewState();
}

class _IwmLowStockAlertsViewState extends State<IwmLowStockAlertsView> {
  String selectedCategory = "all";
  String selectedSeverity = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Home & Garden", "value": "home"},
  ];
  
  List<Map<String, dynamic>> severityLevels = [
    {"label": "All Levels", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "Low", "value": "low"},
    {"label": "Warning", "value": "warning"},
  ];
  
  List<Map<String, dynamic>> alertStats = [
    {
      "title": "Critical Alerts",
      "value": 12,
      "subtitle": "Out of Stock",
      "icon": Icons.error,
      "color": dangerColor
    },
    {
      "title": "Low Stock",
      "value": 28,
      "subtitle": "Below Threshold",
      "icon": Icons.warning,
      "color": warningColor
    },
    {
      "title": "Reorder Soon",
      "value": 35,
      "subtitle": "Approaching Limit",
      "icon": Icons.schedule,
      "color": infoColor
    },
    {
      "title": "Total Products",
      "value": 1247,
      "subtitle": "In Inventory",
      "icon": Icons.inventory,
      "color": primaryColor
    },
  ];
  
  List<Map<String, dynamic>> lowStockItems = [
    {
      "name": "iPhone 15 Pro Max",
      "sku": "IPH15PM-256",
      "category": "Electronics",
      "currentStock": 0,
      "minThreshold": 10,
      "maxThreshold": 50,
      "price": 1199.99,
      "supplier": "Apple Inc.",
      "lastRestocked": "2024-01-10",
      "severity": "critical",
      "image": "https://picsum.photos/60/60?random=1&keyword=phone",
      "daysOutOfStock": 5,
      "avgDailySales": 2.5
    },
    {
      "name": "Samsung Galaxy Buds Pro",
      "sku": "SGB-PRO-BLK",
      "category": "Electronics",
      "currentStock": 3,
      "minThreshold": 15,
      "maxThreshold": 100,
      "price": 199.99,
      "supplier": "Samsung Electronics",
      "lastRestocked": "2024-01-08",
      "severity": "critical",
      "image": "https://picsum.photos/60/60?random=2&keyword=earbuds",
      "daysOutOfStock": 0,
      "avgDailySales": 1.8
    },
    {
      "name": "Nike Air Max 270",
      "sku": "NAM270-WHT-10",
      "category": "Clothing",
      "currentStock": 8,
      "minThreshold": 20,
      "maxThreshold": 80,
      "price": 149.99,
      "supplier": "Nike Inc.",
      "lastRestocked": "2024-01-12",
      "severity": "low",
      "image": "https://picsum.photos/60/60?random=3&keyword=shoes",
      "daysOutOfStock": 0,
      "avgDailySales": 1.2
    },
    {
      "name": "Organic Coffee Beans",
      "sku": "OCB-1KG-ARB",
      "category": "Food & Beverages",
      "currentStock": 15,
      "minThreshold": 30,
      "maxThreshold": 200,
      "price": 24.99,
      "supplier": "Green Mountain Coffee",
      "lastRestocked": "2024-01-14",
      "severity": "warning",
      "image": "https://picsum.photos/60/60?random=4&keyword=coffee",
      "daysOutOfStock": 0,
      "avgDailySales": 5.2
    },
    {
      "name": "Wireless Bluetooth Speaker",
      "sku": "WBS-BT50-BLK",
      "category": "Electronics",
      "currentStock": 5,
      "minThreshold": 25,
      "maxThreshold": 75,
      "price": 89.99,
      "supplier": "JBL",
      "lastRestocked": "2024-01-09",
      "severity": "low",
      "image": "https://picsum.photos/60/60?random=5&keyword=speaker",
      "daysOutOfStock": 0,
      "avgDailySales": 0.8
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Low Stock Alerts"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildAlertStats(),
            _buildLowStockList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Products",
            value: searchQuery,
            hint: "Search by name, SKU, or supplier...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityLevels,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Stock Alert Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: alertStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Low Stock Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Export",
              icon: Icons.download,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...lowStockItems.map((item) => _buildLowStockItem(item)),
      ],
    );
  }

  Widget _buildLowStockItem(Map<String, dynamic> item) {
    Color severityColor = _getSeverityColor(item["severity"]);
    bool isOutOfStock = (item["currentStock"] as int) == 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 60,
                  height: 60,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${item["sku"]} • ${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: severityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["severity"].toString().toUpperCase()}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: severityColor,
                            ),
                          ),
                        ),
                        if (isOutOfStock) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OUT OF STOCK",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Text(
                    "\$${((item["price"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Reorder",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
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
                            "Current Stock: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["currentStock"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isOutOfStock ? dangerColor : primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Min Threshold: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["minThreshold"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Supplier: ${item["supplier"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Last Restocked: ${item["lastRestocked"]}",
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
          ),
          if (isOutOfStock)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Out of stock for ${item["daysOutOfStock"]} days • Est. daily sales: ${item["avgDailySales"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'low':
        return warningColor;
      case 'warning':
        return infoColor;
      default:
        return primaryColor;
    }
  }
}

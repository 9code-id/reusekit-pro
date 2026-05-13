import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport2View extends StatefulWidget {
  @override
  State<GrlReport2View> createState() => _GrlReport2ViewState();
}

class _GrlReport2ViewState extends State<GrlReport2View> {
  int selectedTab = 0;
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "name": "MacBook Pro 16\"",
      "sku": "MBP-16-001",
      "category": "Laptops",
      "stock": 25,
      "minStock": 10,
      "price": 2499.99,
      "status": "in_stock",
      "lastUpdated": "2024-12-22",
      "image": "https://picsum.photos/60/60?random=1&keyword=laptop",
    },
    {
      "name": "iPhone 15 Pro",
      "sku": "IP15P-001",
      "category": "Smartphones",
      "stock": 8,
      "minStock": 15,
      "price": 999.99,
      "status": "low_stock",
      "lastUpdated": "2024-12-21",
      "image": "https://picsum.photos/60/60?random=2&keyword=phone",
    },
    {
      "name": "AirPods Pro",
      "sku": "APP-001",
      "category": "Audio",
      "stock": 0,
      "minStock": 5,
      "price": 249.99,
      "status": "out_of_stock",
      "lastUpdated": "2024-12-20",
      "image": "https://picsum.photos/60/60?random=3&keyword=earbuds",
    },
    {
      "name": "iPad Air",
      "sku": "IPA-001",
      "category": "Tablets",
      "stock": 42,
      "minStock": 20,
      "price": 599.99,
      "status": "in_stock",
      "lastUpdated": "2024-12-22",
      "image": "https://picsum.photos/60/60?random=4&keyword=tablet",
    },
    {
      "name": "Magic Mouse",
      "sku": "MM-001",
      "category": "Accessories",
      "stock": 5,
      "minStock": 10,
      "price": 79.99,
      "status": "low_stock",
      "lastUpdated": "2024-12-21",
      "image": "https://picsum.photos/60/60?random=5&keyword=mouse",
    },
  ];

  List<Map<String, dynamic>> stockMovements = [
    {
      "item": "MacBook Pro 16\"",
      "type": "in",
      "quantity": 10,
      "reason": "Purchase Order #PO-001",
      "date": "2024-12-22 14:30",
      "user": "John Smith",
    },
    {
      "item": "iPhone 15 Pro",
      "type": "out",
      "quantity": 2,
      "reason": "Sale Order #SO-156",
      "date": "2024-12-22 11:15",
      "user": "Sarah Johnson",
    },
    {
      "item": "AirPods Pro",
      "type": "out",
      "quantity": 1,
      "reason": "Sale Order #SO-155",
      "date": "2024-12-22 10:45",
      "user": "Mike Brown",
    },
    {
      "item": "iPad Air",
      "type": "in",
      "quantity": 15,
      "reason": "Purchase Order #PO-002",
      "date": "2024-12-21 16:20",
      "user": "Emma Davis",
    },
  ];

  List<Map<String, dynamic>> categoryStats = [
    {
      "name": "Laptops",
      "items": 12,
      "totalValue": 89750.0,
      "lowStock": 2,
      "outOfStock": 0,
      "color": primaryColor,
    },
    {
      "name": "Smartphones",
      "items": 8,
      "totalValue": 45600.0,
      "lowStock": 3,
      "outOfStock": 1,
      "color": infoColor,
    },
    {
      "name": "Audio",
      "items": 15,
      "totalValue": 12450.0,
      "lowStock": 4,
      "outOfStock": 2,
      "color": warningColor,
    },
    {
      "name": "Tablets",
      "items": 6,
      "totalValue": 23400.0,
      "lowStock": 1,
      "outOfStock": 0,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inventory Report",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Stock Levels", icon: Icon(Icons.inventory)),
        Tab(text: "Movements", icon: Icon(Icons.swap_horiz)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildStockLevelsTab(),
        _buildMovementsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSummaryCards(),
          _buildCategoryStats(),
          _buildLowStockAlert(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    List<Map<String, dynamic>> summaryData = [
      {
        "title": "Total Items",
        "value": inventoryItems.length.toString(),
        "subtitle": "Products in inventory",
        "icon": Icons.inventory_2,
        "color": primaryColor,
      },
      {
        "title": "Total Value",
        "value": "\$${(inventoryItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["stock"] as int)))).currency}",
        "subtitle": "Current stock value",
        "icon": Icons.attach_money,
        "color": successColor,
      },
      {
        "title": "Low Stock Items",
        "value": inventoryItems.where((item) => (item["stock"] as int) <= (item["minStock"] as int) && (item["stock"] as int) > 0).length.toString(),
        "subtitle": "Need restocking",
        "icon": Icons.warning,
        "color": warningColor,
      },
      {
        "title": "Out of Stock",
        "value": inventoryItems.where((item) => (item["stock"] as int) == 0).length.toString(),
        "subtitle": "Urgent restocking",
        "icon": Icons.error,
        "color": dangerColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: summaryData.map((data) {
        return Container(
          padding: EdgeInsets.all(spSm),
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
                      color: (data["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: data["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${data["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${data["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: categoryStats.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: category["color"] as Color,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(category["items"] as int)} items • \$${((category["totalValue"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        if ((category["lowStock"] as int) > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(category["lowStock"] as int)} Low",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if ((category["outOfStock"] as int) > 0)
                          Container(
                            margin: EdgeInsets.only(top: spXs),
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(category["outOfStock"] as int)} Out",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
    );
  }

  Widget _buildLowStockAlert() {
    List<Map<String, dynamic>> lowStockItems = inventoryItems
        .where((item) => (item["stock"] as int) <= (item["minStock"] as int))
        .toList();

    if (lowStockItems.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: successColor.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: successColor.withAlpha(76)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: successColor),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "All items are well stocked!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.warning, color: dangerColor),
              SizedBox(width: spSm),
              Text(
                "Low Stock Alert",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: lowStockItems.map((item) {
              Color statusColor = (item["stock"] as int) == 0 ? dangerColor : warningColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${item["image"]}"),
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
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "SKU: ${item["sku"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${(item["stock"] as int)} in stock",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        Text(
                          "Min: ${(item["minStock"] as int)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
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
    );
  }

  Widget _buildStockLevelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Stock Levels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              children: inventoryItems.map((item) {
                Color statusColor = (item["stock"] as int) == 0 
                    ? dangerColor 
                    : (item["stock"] as int) <= (item["minStock"] as int) 
                        ? warningColor 
                        : successColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${item["image"]}"),
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
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "SKU: ${item["sku"]} • ${item["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(item["stock"] as int)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            "Min: ${(item["minStock"] as int)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
    );
  }

  Widget _buildMovementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Stock Movements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              children: stockMovements.map((movement) {
                Color typeColor = movement["type"] == "in" ? successColor : dangerColor;
                IconData typeIcon = movement["type"] == "in" ? Icons.add : Icons.remove;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: typeColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: typeColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: typeColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          typeIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${movement["item"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${movement["reason"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${movement["date"]} • ${movement["user"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${movement["type"] == "in" ? "+" : "-"}${(movement["quantity"] as int)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: typeColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPricingManagementView extends StatefulWidget {
  const FmaPricingManagementView({super.key});

  @override
  State<FmaPricingManagementView> createState() => _FmaPricingManagementViewState();
}

class _FmaPricingManagementViewState extends State<FmaPricingManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Name";
  bool isAscending = true;
  
  List<Map<String, dynamic>> menuItems = [
    {
      "id": "1",
      "name": "Beef Burger Deluxe",
      "category": "Main Course",
      "currentPrice": 15.99,
      "originalPrice": 15.99,
      "costPrice": 8.50,
      "profitMargin": 46.84,
      "lastUpdated": "2024-12-15",
      "isOnSale": false,
      "salePrice": 0.0,
      "image": "https://picsum.photos/80/80?random=1&keyword=burger",
    },
    {
      "id": "2",
      "name": "Grilled Chicken Salad",
      "category": "Main Course", 
      "currentPrice": 12.99,
      "originalPrice": 12.99,
      "costPrice": 6.75,
      "profitMargin": 48.04,
      "lastUpdated": "2024-12-14",
      "isOnSale": true,
      "salePrice": 10.99,
      "image": "https://picsum.photos/80/80?random=2&keyword=salad",
    },
    {
      "id": "3",
      "name": "Margherita Pizza",
      "category": "Main Course",
      "currentPrice": 18.99,
      "originalPrice": 18.99,
      "costPrice": 9.25,
      "profitMargin": 51.29,
      "lastUpdated": "2024-12-13",
      "isOnSale": false,
      "salePrice": 0.0,
      "image": "https://picsum.photos/80/80?random=3&keyword=pizza",
    },
    {
      "id": "4",
      "name": "Chocolate Cake Slice",
      "category": "Dessert",
      "currentPrice": 6.99,
      "originalPrice": 6.99,
      "costPrice": 2.80,
      "profitMargin": 59.94,
      "lastUpdated": "2024-12-12",
      "isOnSale": true,
      "salePrice": 5.99,
      "image": "https://picsum.photos/80/80?random=4&keyword=cake",
    },
    {
      "id": "5",
      "name": "Fresh Orange Juice",
      "category": "Beverage",
      "currentPrice": 4.99,
      "originalPrice": 4.99,
      "costPrice": 1.25,
      "profitMargin": 74.95,
      "lastUpdated": "2024-12-11",
      "isOnSale": false,
      "salePrice": 0.0,
      "image": "https://picsum.photos/80/80?random=5&keyword=juice",
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Beverage", "value": "Beverage"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Name", "value": "Name"},
    {"label": "Price", "value": "Price"},
    {"label": "Profit Margin", "value": "Profit Margin"},
    {"label": "Last Updated", "value": "Last Updated"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedItems {
    var filtered = menuItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      dynamic aValue, bValue;
      
      switch (sortBy) {
        case "Name":
          aValue = a["name"];
          bValue = b["name"];
          break;
        case "Price":
          aValue = a["currentPrice"];
          bValue = b["currentPrice"];
          break;
        case "Profit Margin":
          aValue = a["profitMargin"];
          bValue = b["profitMargin"];
          break;
        case "Last Updated":
          aValue = DateTime.parse(a["lastUpdated"]);
          bValue = DateTime.parse(b["lastUpdated"]);
          break;
        default:
          aValue = a["name"];
          bValue = b["name"];
      }

      int comparison = 0;
      if (aValue is String && bValue is String) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is num && bValue is num) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is DateTime && bValue is DateTime) {
        comparison = aValue.compareTo(bValue);
      }

      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  Color getProfitMarginColor(double margin) {
    if (margin >= 60) return successColor;
    if (margin >= 40) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              // navigateTo(FmaPricingAnalyticsView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
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
                    label: "Search Menu Items",
                    value: searchQuery,
                    hint: "Search by item name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
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
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortItems,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isAscending = !isAscending;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Pricing Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Pricing Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${(menuItems.fold(0.0, (sum, item) => sum + (item["currentPrice"] as double)) / menuItems.length).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Avg Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${(menuItems.fold(0.0, (sum, item) => sum + (item["profitMargin"] as double)) / menuItems.length).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Avg Margin",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${menuItems.where((item) => item["isOnSale"] == true).length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "On Sale",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.restaurant_menu, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Menu Items (${filteredAndSortedItems.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredAndSortedItems.map((item) {
                    double profitMargin = item["profitMargin"] as double;
                    Color marginColor = getProfitMarginColor(profitMargin);
                    bool isOnSale = item["isOnSale"] as bool;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isOnSale 
                            ? warningColor.withAlpha(50)
                            : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (isOnSale)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "ON SALE",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    if (isOnSale) ...[
                                      Text(
                                        "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${(item["salePrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        "\$${(item["currentPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: marginColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${profitMargin.toStringAsFixed(1)}% margin",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: marginColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Cost: \$${(item["costPrice"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Updated: ${DateTime.parse(item["lastUpdated"]).dMMMy}",
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
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // navigateTo(FmaItemPricingEditView(itemId: item["id"]));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              GestureDetector(
                                onTap: () {
                                  if (isOnSale) {
                                    // Remove from sale
                                    item["isOnSale"] = false;
                                    item["salePrice"] = 0.0;
                                    ss("Item removed from sale");
                                  } else {
                                    // Add to sale
                                    item["isOnSale"] = true;
                                    item["salePrice"] = (item["currentPrice"] as double) * 0.8; // 20% off
                                    ss("Item added to sale");
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: isOnSale 
                                      ? dangerColor.withAlpha(20)
                                      : warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    isOnSale ? Icons.money_off : Icons.local_offer,
                                    color: isOnSale ? dangerColor : warningColor,
                                    size: 16,
                                  ),
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

            // Bulk Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Bulk Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Apply Discount",
                          color: warningColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(FmaBulkDiscountView());
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Price Update",
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(FmaBulkPriceUpdateView());
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Export Prices",
                          color: successColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Price list exported successfully");
                          },
                        ),
                      ),
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
}

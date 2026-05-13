import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsMenuPricingView extends StatefulWidget {
  const RfsMenuPricingView({super.key});

  @override
  State<RfsMenuPricingView> createState() => _RfsMenuPricingViewState();
}

class _RfsMenuPricingViewState extends State<RfsMenuPricingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String priceRange = "All";
  bool showProfitMargins = false;

  final List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Appetizers", "value": "Appetizers"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Sides", "value": "Sides"},
  ];

  final List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All", "value": "All"},
    {"label": "Under \$10", "value": "Under 10"},
    {"label": "\$10 - \$20", "value": "10-20"},
    {"label": "\$20 - \$30", "value": "20-30"},
    {"label": "Over \$30", "value": "Over 30"},
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      "id": 1,
      "name": "Grilled Atlantic Salmon",
      "category": "Main Course",
      "currentPrice": 28.99,
      "costPrice": 12.50,
      "suggestedPrice": 29.99,
      "profitMargin": 56.9,
      "lastUpdated": "2024-12-15",
      "popularity": 92,
      "orderFrequency": 45,
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon",
      "description": "Fresh Atlantic salmon grilled to perfection with herbs",
      "portionSize": "8 oz",
      "preparationTime": "18 min",
      "difficulty": "Medium",
      "priceHistory": [26.99, 27.99, 28.99],
      "competitorPrices": [29.99, 31.50, 27.95],
      "seasonalAdjustment": 0.0
    },
    {
      "id": 2,
      "name": "Caesar Salad",
      "category": "Appetizers",
      "currentPrice": 12.99,
      "costPrice": 4.25,
      "suggestedPrice": 13.99,
      "profitMargin": 67.3,
      "lastUpdated": "2024-12-10",
      "popularity": 78,
      "orderFrequency": 68,
      "image": "https://picsum.photos/300/200?random=2&keyword=salad",
      "description": "Classic Caesar salad with homemade croutons and parmesan",
      "portionSize": "Regular",
      "preparationTime": "8 min",
      "difficulty": "Easy",
      "priceHistory": [11.99, 12.49, 12.99],
      "competitorPrices": [13.99, 12.50, 14.95],
      "seasonalAdjustment": 0.0
    },
    {
      "id": 3,
      "name": "Chocolate Lava Cake",
      "category": "Desserts",
      "currentPrice": 9.99,
      "costPrice": 2.80,
      "suggestedPrice": 10.99,
      "profitMargin": 72.0,
      "lastUpdated": "2024-12-12",
      "popularity": 88,
      "orderFrequency": 32,
      "image": "https://picsum.photos/300/200?random=3&keyword=chocolate",
      "description": "Warm chocolate cake with molten center and vanilla ice cream",
      "portionSize": "Single",
      "preparationTime": "12 min",
      "difficulty": "Medium",
      "priceHistory": [8.99, 9.49, 9.99],
      "competitorPrices": [11.99, 10.50, 12.95],
      "seasonalAdjustment": 0.0
    },
    {
      "id": 4,
      "name": "Craft Beer Selection",
      "category": "Beverages",
      "currentPrice": 6.99,
      "costPrice": 2.10,
      "suggestedPrice": 7.49,
      "profitMargin": 70.0,
      "lastUpdated": "2024-12-08",
      "popularity": 65,
      "orderFrequency": 85,
      "image": "https://picsum.photos/300/200?random=4&keyword=beer",
      "description": "Selection of local craft beers on tap",
      "portionSize": "16 oz",
      "preparationTime": "2 min",
      "difficulty": "Easy",
      "priceHistory": [5.99, 6.49, 6.99],
      "competitorPrices": [7.99, 6.95, 8.50],
      "seasonalAdjustment": 0.0
    },
    {
      "id": 5,
      "name": "Truffle Mac & Cheese",
      "category": "Sides",
      "currentPrice": 14.99,
      "costPrice": 5.75,
      "suggestedPrice": 15.99,
      "profitMargin": 61.6,
      "lastUpdated": "2024-12-14",
      "popularity": 82,
      "orderFrequency": 28,
      "image": "https://picsum.photos/300/200?random=5&keyword=cheese",
      "description": "Creamy mac and cheese with truffle oil and premium cheeses",
      "portionSize": "Side",
      "preparationTime": "15 min",
      "difficulty": "Medium",
      "priceHistory": [13.99, 14.49, 14.99],
      "competitorPrices": [16.99, 15.50, 17.95],
      "seasonalAdjustment": 0.0
    },
    {
      "id": 6,
      "name": "Beef Wellington",
      "category": "Main Course",
      "currentPrice": 45.99,
      "costPrice": 18.25,
      "suggestedPrice": 48.99,
      "profitMargin": 60.3,
      "lastUpdated": "2024-12-16",
      "popularity": 95,
      "orderFrequency": 12,
      "image": "https://picsum.photos/300/200?random=6&keyword=beef",
      "description": "Premium beef tenderloin wrapped in pastry with mushroom duxelles",
      "portionSize": "10 oz",
      "preparationTime": "45 min",
      "difficulty": "Hard",
      "priceHistory": [42.99, 44.99, 45.99],
      "competitorPrices": [49.99, 47.50, 52.95],
      "seasonalAdjustment": 0.0
    }
  ];

  List<Map<String, dynamic>> get filteredMenuItems {
    return menuItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesPriceRange = _matchesPriceRange(item["currentPrice"] as double);
      
      return matchesSearch && matchesCategory && matchesPriceRange;
    }).toList();
  }

  bool _matchesPriceRange(double price) {
    switch (priceRange) {
      case "Under 10": return price < 10;
      case "10-20": return price >= 10 && price <= 20;
      case "20-30": return price >= 20 && price <= 30;
      case "Over 30": return price > 30;
      default: return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Menu Pricing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Price List", icon: Icon(Icons.attach_money)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Optimization", icon: Icon(Icons.tune)),
      ],
      tabChildren: [
        _buildPriceListTab(),
        _buildAnalyticsTab(),
        _buildOptimizationTab(),
      ],
    );
  }

  Widget _buildPriceListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildPricingOverview(),
          _buildMenuItemsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search menu items...",
          value: searchQuery,
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
                items: categoryItems,
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
                label: "Price Range",
                items: priceRangeItems,
                value: priceRange,
                onChanged: (value, label) {
                  priceRange = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QSwitch(
          items: [
            {
              "label": "Show Profit Margins",
              "value": true,
              "checked": showProfitMargins,
            }
          ],
          value: [if (showProfitMargins) {"label": "Show Profit Margins", "value": true, "checked": true}],
          onChanged: (values, ids) {
            showProfitMargins = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPricingOverview() {
    double avgPrice = menuItems.map((i) => i["currentPrice"] as double).reduce((a, b) => a + b) / menuItems.length;
    double avgMargin = menuItems.map((i) => i["profitMargin"] as double).reduce((a, b) => a + b) / menuItems.length;
    double highestPrice = menuItems.map((i) => i["currentPrice"] as double).reduce((a, b) => a > b ? a : b);
    double lowestPrice = menuItems.map((i) => i["currentPrice"] as double).reduce((a, b) => a < b ? a : b);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "\$${avgPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Price",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "${avgMargin.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Avg Margin",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "\$${highestPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Highest",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "\$${lowestPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Lowest",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItemsList() {
    return Column(
      spacing: spSm,
      children: filteredMenuItems.map((item) {
        return _buildMenuItemCard(item);
      }).toList(),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    bool needsPriceAdjustment = (item["currentPrice"] as double) < (item["suggestedPrice"] as double);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: needsPriceAdjustment ? Border.all(color: warningColor.withAlpha(100), width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${item["preparationTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.star, size: 14, color: warningColor),
                        SizedBox(width: 4),
                        Text(
                          "${item["popularity"]}% popularity",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${item["orderFrequency"]} orders/week",
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
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showPriceEditDialog(item);
                },
              ),
            ],
          ),
          
          // Price Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${(item["currentPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Current Price",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showProfitMargins)
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${(item["costPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Cost Price",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${(item["suggestedPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: needsPriceAdjustment ? warningColor : successColor,
                            ),
                          ),
                          Text(
                            "Suggested",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showProfitMargins)
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(item["profitMargin"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: _getProfitMarginColor(item["profitMargin"] as double),
                              ),
                            ),
                            Text(
                              "Margin",
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
                
                // Competitor Pricing
                if ((item["competitorPrices"] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Competitor Prices:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        children: (item["competitorPrices"] as List).map((price) {
                          bool isLower = (price as double) < (item["currentPrice"] as double);
                          bool isHigher = (price as double) > (item["currentPrice"] as double);
                          
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isLower ? dangerColor.withAlpha(20) : 
                                     isHigher ? successColor.withAlpha(20) : 
                                     disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: isLower ? dangerColor : 
                                       isHigher ? successColor : 
                                       disabledBoldColor,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              "\$${(price as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 10,
                                color: isLower ? dangerColor : 
                                       isHigher ? successColor : 
                                       disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          // Price Adjustment Suggestion
          if (needsPriceAdjustment)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, size: 14, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Consider increasing price by \$${((item["suggestedPrice"] as double) - (item["currentPrice"] as double)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildProfitabilityAnalysis(),
          _buildCategoryPricing(),
          _buildPriceDistribution(),
        ],
      ),
    );
  }

  Widget _buildProfitabilityAnalysis() {
    var sortedByProfit = List.from(menuItems)..sort((a, b) => (b["profitMargin"] as double).compareTo(a["profitMargin"] as double));
    
    return Container(
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
            "Profitability Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...sortedByProfit.take(5).map((item) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusXs),
                  child: Image.network(
                    "${item["image"]}",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
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
                        ),
                      ),
                      Text(
                        "\$${(item["currentPrice"] as double).toStringAsFixed(2)} • ${item["orderFrequency"]} orders/week",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getProfitMarginColor(item["profitMargin"] as double).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${(item["profitMargin"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getProfitMarginColor(item["profitMargin"] as double),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryPricing() {
    final categoryStats = <String, Map<String, double>>{};
    
    for (var category in categoryItems.skip(1)) {
      final categoryItems_data = menuItems.where((item) => item["category"] == category["value"]).toList();
      if (categoryItems_data.isNotEmpty) {
        categoryStats[category["label"] as String] = {
          "avgPrice": categoryItems_data.map((i) => i["currentPrice"] as double).reduce((a, b) => a + b) / categoryItems_data.length,
          "avgMargin": categoryItems_data.map((i) => i["profitMargin"] as double).reduce((a, b) => a + b) / categoryItems_data.length,
          "count": categoryItems_data.length.toDouble(),
        };
      }
    }

    return Container(
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
            "Category Pricing Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categoryStats.entries.map((entry) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Price: \$${entry.value["avgPrice"]!.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Avg Margin: ${entry.value["avgMargin"]!.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Items: ${entry.value["count"]!.toInt()}",
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
        ],
      ),
    );
  }

  Widget _buildPriceDistribution() {
    final priceRanges = <String, int>{
      "Under \$10": menuItems.where((i) => (i["currentPrice"] as double) < 10).length,
      "\$10-\$20": menuItems.where((i) => (i["currentPrice"] as double) >= 10 && (i["currentPrice"] as double) <= 20).length,
      "\$20-\$30": menuItems.where((i) => (i["currentPrice"] as double) >= 20 && (i["currentPrice"] as double) <= 30).length,
      "Over \$30": menuItems.where((i) => (i["currentPrice"] as double) > 30).length,
    };

    return Container(
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
            "Price Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...priceRanges.entries.map((entry) {
            return Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: entry.value / menuItems.length,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "${entry.value}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOptimizationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPricingRecommendations(),
          _buildCompetitorAnalysis(),
          _buildSeasonalAdjustments(),
        ],
      ),
    );
  }

  Widget _buildPricingRecommendations() {
    var needsAdjustment = menuItems.where((item) => 
      (item["currentPrice"] as double) < (item["suggestedPrice"] as double)
    ).toList();

    return Container(
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
            "Pricing Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (needsAdjustment.isEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor),
                  SizedBox(width: spSm),
                  Text(
                    "All prices are optimally set!",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            ...needsAdjustment.map((item) {
              double increase = (item["suggestedPrice"] as double) - (item["currentPrice"] as double);
              double increasePercent = (increase / (item["currentPrice"] as double)) * 100;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${item["image"]}",
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
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Current: \$${(item["currentPrice"] as double).toStringAsFixed(2)} → Suggested: \$${(item["suggestedPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Increase: \$${increase.toStringAsFixed(2)} (+${increasePercent.toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Apply",
                      size: bs.sm,
                      onPressed: () {
                        _applyPriceChange(item);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildCompetitorAnalysis() {
    return Container(
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
            "Competitor Price Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...menuItems.map((item) {
            List<double> competitorPrices = (item["competitorPrices"] as List).cast<double>();
            double avgCompetitorPrice = competitorPrices.reduce((a, b) => a + b) / competitorPrices.length;
            double currentPrice = item["currentPrice"] as double;
            bool isBelow = currentPrice < avgCompetitorPrice;
            bool isAbove = currentPrice > avgCompetitorPrice;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isBelow ? dangerColor.withAlpha(20) :
                       isAbove ? successColor.withAlpha(20) :
                       disabledColor.withAlpha(20),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Our price: \$${currentPrice.toStringAsFixed(2)} | Avg competitor: \$${avgCompetitorPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: isBelow ? dangerColor :
                             isAbove ? successColor :
                             disabledBoldColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      isBelow ? "Below Market" :
                      isAbove ? "Above Market" :
                      "At Market",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSeasonalAdjustments() {
    return Container(
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
            "Seasonal Price Adjustments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Winter Season Recommendations",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "• Hot beverages: +15% price adjustment",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "• Comfort foods: +10% price adjustment",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "• Cold beverages: -5% price adjustment",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "• Seasonal specials: Premium pricing",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Apply Winter Pricing",
                  size: bs.sm,
                  onPressed: () {
                    _applySeasonalPricing();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset to Base Prices",
                  size: bs.sm,
                  onPressed: () {
                    _resetSeasonalPricing();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getProfitMarginColor(double margin) {
    if (margin >= 70) return successColor;
    if (margin >= 60) return warningColor;
    if (margin >= 50) return infoColor;
    return dangerColor;
  }

  void _showPriceEditDialog(Map<String, dynamic> item) {
    String newPrice = item["currentPrice"].toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Price - ${item["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "New Price (\$)",
              value: newPrice,
              onChanged: (value) {
                newPrice = value;
              },
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Price: \$${(item["currentPrice"] as double).toStringAsFixed(2)}"),
                  Text("Cost Price: \$${(item["costPrice"] as double).toStringAsFixed(2)}"),
                  Text("Suggested Price: \$${(item["suggestedPrice"] as double).toStringAsFixed(2)}"),
                  Text("Current Margin: ${(item["profitMargin"] as double).toStringAsFixed(1)}%"),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Update price logic
              Navigator.pop(context);
              ss("Price updated successfully");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _applyPriceChange(Map<String, dynamic> item) {
    // Apply suggested price change
    ss("Price updated to \$${(item["suggestedPrice"] as double).toStringAsFixed(2)}");
  }

  void _applySeasonalPricing() {
    // Apply seasonal pricing adjustments
    ss("Winter seasonal pricing applied");
  }

  void _resetSeasonalPricing() {
    // Reset to base prices
    ss("Prices reset to base levels");
  }
}

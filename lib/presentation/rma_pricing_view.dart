import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPricingView extends StatefulWidget {
  const RmaPricingView({super.key});

  @override
  State<RmaPricingView> createState() => _RmaPricingViewState();
}

class _RmaPricingViewState extends State<RmaPricingView> {
  String selectedCategory = "all";
  String priceRange = "all";
  bool showCostAnalysis = true;
  
  List<Map<String, dynamic>> menuItems = [
    {
      "id": "burger_classic",
      "name": "Classic Burger",
      "category": "burgers",
      "basePrice": 12.99,
      "cost": 4.50,
      "margin": 65.3,
      "popularity": 8.7,
      "sales": 145,
      "image": "https://picsum.photos/100/100?random=1&keyword=burger"
    },
    {
      "id": "pizza_margherita",
      "name": "Margherita Pizza",
      "category": "pizzas",
      "basePrice": 16.50,
      "cost": 5.25,
      "margin": 68.2,
      "popularity": 9.2,
      "sales": 198,
      "image": "https://picsum.photos/100/100?random=2&keyword=pizza"
    },
    {
      "id": "pasta_carbonara",
      "name": "Pasta Carbonara",
      "category": "pasta",
      "basePrice": 14.75,
      "cost": 4.80,
      "margin": 67.5,
      "popularity": 7.8,
      "sales": 112,
      "image": "https://picsum.photos/100/100?random=3&keyword=pasta"
    },
    {
      "id": "salad_caesar",
      "name": "Caesar Salad",
      "category": "salads",
      "basePrice": 11.25,
      "cost": 3.75,
      "margin": 66.7,
      "popularity": 6.5,
      "sales": 87,
      "image": "https://picsum.photos/100/100?random=4&keyword=salad"
    },
    {
      "id": "steak_ribeye",
      "name": "Ribeye Steak",
      "category": "steaks",
      "basePrice": 28.99,
      "cost": 12.50,
      "margin": 56.9,
      "popularity": 8.1,
      "sales": 76,
      "image": "https://picsum.photos/100/100?random=5&keyword=steak"
    },
    {
      "id": "chicken_wings",
      "name": "Buffalo Wings",
      "category": "appetizers",
      "basePrice": 9.99,
      "cost": 3.25,
      "margin": 67.5,
      "popularity": 8.9,
      "sales": 203,
      "image": "https://picsum.photos/100/100?random=6&keyword=wings"
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Burgers", "value": "burgers"},
    {"label": "Pizzas", "value": "pizzas"},
    {"label": "Pasta", "value": "pasta"},
    {"label": "Salads", "value": "salads"},
    {"label": "Steaks", "value": "steaks"},
    {"label": "Appetizers", "value": "appetizers"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$10", "value": "under_10"},
    {"label": "\$10 - \$20", "value": "10_20"},
    {"label": "\$20 - \$30", "value": "20_30"},
    {"label": "Over \$30", "value": "over_30"},
  ];

  Widget _buildPricingOverview() {
    final totalItems = menuItems.length;
    final avgPrice = (menuItems.map((item) => item["basePrice"] as double).reduce((a, b) => a + b)) / totalItems;
    final avgMargin = (menuItems.map((item) => item["margin"] as double).reduce((a, b) => a + b)) / totalItems;
    final highestMargin = menuItems.map((item) => item["margin"] as double).reduce((a, b) => a > b ? a : b);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pricing Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Items",
                "$totalItems",
                Icons.restaurant_menu,
                primaryColor,
              ),
              _buildOverviewCard(
                "Average Price",
                "\$${avgPrice.toStringAsFixed(2)}",
                Icons.attach_money,
                successColor,
              ),
              _buildOverviewCard(
                "Average Margin",
                "${avgMargin.toStringAsFixed(1)}%",
                Icons.trending_up,
                infoColor,
              ),
              _buildOverviewCard(
                "Highest Margin",
                "${highestMargin.toStringAsFixed(1)}%",
                Icons.star,
                warningColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
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
                  label: "Price Range",
                  items: priceRanges,
                  value: priceRange,
                  onChanged: (value, label) {
                    priceRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Cost Analysis",
                      "value": true,
                      "checked": showCostAnalysis,
                    }
                  ],
                  value: [
                    if (showCostAnalysis)
                      {
                        "label": "Show Cost Analysis",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showCostAnalysis = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Bulk Price Update",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaBulkPriceUpdateView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingItem(Map<String, dynamic> item) {
    final profit = (item["basePrice"] as double) - (item["cost"] as double);
    final marginColor = (item["margin"] as double) >= 60 ? successColor : 
                       (item["margin"] as double) >= 40 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Price: \$${((item["basePrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    if (showCostAnalysis) ...[
                      SizedBox(width: spSm),
                      Text(
                        "Cost: \$${((item["cost"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                if (showCostAnalysis)
                  Row(
                    children: [
                      Text(
                        "Profit: \$${profit.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: marginColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${(item["margin"] as double).toStringAsFixed(1)}% margin",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: marginColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(item["popularity"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.shopping_cart, color: infoColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${item["sales"]} orders",
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
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaEditPricingView')
                },
              ),
              SizedBox(height: spSm),
              QButton(
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaPriceAnalysisView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      if (selectedCategory != "all" && item["category"] != selectedCategory) {
        return false;
      }
      
      final price = item["basePrice"] as double;
      switch (priceRange) {
        case "under_10":
          return price < 10;
        case "10_20":
          return price >= 10 && price <= 20;
        case "20_30":
          return price >= 20 && price <= 30;
        case "over_30":
          return price > 30;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              //navigateTo('RmaPriceCalculatorView')
            },
          ),
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              //navigateTo('RmaPricingAnalyticsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPricingOverview(),
            _buildFilters(),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Menu Items (${filteredItems.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Item",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaAddMenuItemView')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredItems.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No items found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredItems.map((item) => _buildPricingItem(item)).toList(),
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

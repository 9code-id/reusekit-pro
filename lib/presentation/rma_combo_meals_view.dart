import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaComboMealsView extends StatefulWidget {
  const RmaComboMealsView({super.key});

  @override
  State<RmaComboMealsView> createState() => _RmaComboMealsViewState();
}

class _RmaComboMealsViewState extends State<RmaComboMealsView> {
  String selectedCategory = "all";
  String sortBy = "popularity";
  bool showProfitAnalysis = true;
  
  List<Map<String, dynamic>> comboMeals = [
    {
      "id": "combo_1",
      "name": "Classic Burger Combo",
      "description": "Burger + fries + drink",
      "category": "burgers",
      "status": "active",
      "popularity": 9.2,
      "totalSales": 1245,
      "items": [
        {"name": "Classic Burger", "category": "main", "price": 12.99},
        {"name": "French Fries", "category": "side", "price": 4.50},
        {"name": "Soft Drink", "category": "drink", "price": 2.50}
      ],
      "originalPrice": 19.99,
      "comboPrice": 16.99,
      "savings": 3.00,
      "discountPercent": 15.0,
      "profit": 8.50,
      "margin": 50.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=burger"
    },
    {
      "id": "combo_2",
      "name": "Pizza Family Pack",
      "description": "2 large pizzas + garlic bread + 2L soda",
      "category": "pizza",
      "status": "active",
      "popularity": 8.7,
      "totalSales": 892,
      "items": [
        {"name": "Large Margherita Pizza", "category": "main", "price": 18.99},
        {"name": "Large Pepperoni Pizza", "category": "main", "price": 20.99},
        {"name": "Garlic Bread", "category": "side", "price": 5.99},
        {"name": "2L Soda", "category": "drink", "price": 3.99}
      ],
      "originalPrice": 49.96,
      "comboPrice": 39.99,
      "savings": 9.97,
      "discountPercent": 20.0,
      "profit": 18.50,
      "margin": 46.3,
      "image": "https://picsum.photos/300/200?random=2&keyword=pizza"
    },
    {
      "id": "combo_3",
      "name": "Chicken Wings Feast",
      "description": "2 dozen wings + dips + beer",
      "category": "appetizers",
      "status": "active",
      "popularity": 7.9,
      "totalSales": 654,
      "items": [
        {"name": "12pc Buffalo Wings", "category": "main", "price": 14.99},
        {"name": "12pc BBQ Wings", "category": "main", "price": 14.99},
        {"name": "3 Dipping Sauces", "category": "side", "price": 2.99},
        {"name": "Draft Beer", "category": "drink", "price": 5.99}
      ],
      "originalPrice": 38.96,
      "comboPrice": 32.99,
      "savings": 5.97,
      "discountPercent": 15.3,
      "profit": 15.20,
      "margin": 46.1,
      "image": "https://picsum.photos/300/200?random=3&keyword=wings"
    },
    {
      "id": "combo_4",
      "name": "Breakfast Special",
      "description": "Eggs + bacon + toast + coffee",
      "category": "breakfast",
      "status": "active",
      "popularity": 8.5,
      "totalSales": 1156,
      "items": [
        {"name": "2 Eggs Any Style", "category": "main", "price": 4.99},
        {"name": "3 Strips Bacon", "category": "side", "price": 3.99},
        {"name": "Toast & Butter", "category": "side", "price": 2.99},
        {"name": "Coffee", "category": "drink", "price": 2.99}
      ],
      "originalPrice": 14.96,
      "comboPrice": 11.99,
      "savings": 2.97,
      "discountPercent": 19.8,
      "profit": 6.80,
      "margin": 56.7,
      "image": "https://picsum.photos/300/200?random=4&keyword=breakfast"
    },
    {
      "id": "combo_5",
      "name": "Seafood Platter",
      "description": "Fish + shrimp + sides + wine",
      "category": "seafood",
      "status": "limited",
      "popularity": 6.8,
      "totalSales": 234,
      "items": [
        {"name": "Grilled Fish Fillet", "category": "main", "price": 22.99},
        {"name": "Grilled Shrimp (6pc)", "category": "main", "price": 18.99},
        {"name": "Rice Pilaf", "category": "side", "price": 4.99},
        {"name": "Steamed Vegetables", "category": "side", "price": 5.99},
        {"name": "Glass of Wine", "category": "drink", "price": 8.99}
      ],
      "originalPrice": 61.95,
      "comboPrice": 49.99,
      "savings": 11.96,
      "discountPercent": 19.3,
      "profit": 22.50,
      "margin": 45.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=seafood"
    },
    {
      "id": "combo_6",
      "name": "Kids Happy Meal",
      "description": "Mini burger + fries + juice + toy",
      "category": "kids",
      "status": "active",
      "popularity": 9.5,
      "totalSales": 2134,
      "items": [
        {"name": "Mini Burger", "category": "main", "price": 6.99},
        {"name": "Small Fries", "category": "side", "price": 2.99},
        {"name": "Apple Juice", "category": "drink", "price": 2.99},
        {"name": "Toy", "category": "extra", "price": 1.99}
      ],
      "originalPrice": 14.96,
      "comboPrice": 9.99,
      "savings": 4.97,
      "discountPercent": 33.2,
      "profit": 4.50,
      "margin": 45.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=kids"
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Burgers", "value": "burgers"},
    {"label": "Pizza", "value": "pizza"},
    {"label": "Appetizers", "value": "appetizers"},
    {"label": "Breakfast", "value": "breakfast"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Kids Menu", "value": "kids"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popularity", "value": "popularity"},
    {"label": "Total Sales", "value": "sales"},
    {"label": "Savings Amount", "value": "savings"},
    {"label": "Profit Margin", "value": "margin"},
    {"label": "Alphabetical", "value": "name"},
  ];

  Widget _buildComboOverview() {
    final activeCount = comboMeals.where((combo) => combo["status"] == "active").length;
    final totalSales = comboMeals.fold(0, (sum, combo) => sum + (combo["totalSales"] as int));
    final avgSavings = (comboMeals.map((combo) => combo["savings"] as double).reduce((a, b) => a + b)) / comboMeals.length;
    final bestPerformer = comboMeals.reduce((a, b) => (a["totalSales"] as int) > (b["totalSales"] as int) ? a : b);
    
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
            "Combo Meals Overview",
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
                "Active Combos",
                "$activeCount",
                Icons.restaurant_menu,
                primaryColor,
              ),
              _buildOverviewCard(
                "Total Sales",
                "$totalSales",
                Icons.trending_up,
                successColor,
              ),
              _buildOverviewCard(
                "Avg Savings",
                "\$${avgSavings.toStringAsFixed(2)}",
                Icons.savings,
                warningColor,
              ),
              _buildOverviewCard(
                "Top Seller",
                "${bestPerformer["name"]}",
                Icons.star,
                infoColor,
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
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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
                      "label": "Show Profit Analysis",
                      "value": true,
                      "checked": showProfitAnalysis,
                    }
                  ],
                  value: [
                    if (showProfitAnalysis)
                      {
                        "label": "Show Profit Analysis",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showProfitAnalysis = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Create Combo",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaCreateComboView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComboCard(Map<String, dynamic> combo) {
    final items = combo["items"] as List;
    final statusColor = combo["status"] == "active" ? successColor :
                       combo["status"] == "limited" ? warningColor : disabledBoldColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${combo["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(80),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "Save \$${(combo["savings"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${combo["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${(combo["popularity"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${combo["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${combo["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${combo["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Includes:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...items.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Regular Price",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((combo["originalPrice"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Combo Price",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${((combo["comboPrice"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${(combo["discountPercent"] as double).toStringAsFixed(1)}% OFF",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (showProfitAnalysis) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Profit",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((combo["profit"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Margin",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(combo["margin"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total Sales",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${combo["totalSales"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add to Order",
                        icon: Icons.add_shopping_cart,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaAddComboToOrderView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaEditComboView')
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.analytics,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaComboAnalyticsView')
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredAndSortedCombos {
    var filtered = comboMeals.where((combo) {
      if (selectedCategory != "all" && combo["category"] != selectedCategory) {
        return false;
      }
      return true;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "popularity":
          return (b["popularity"] as double).compareTo(a["popularity"] as double);
        case "sales":
          return (b["totalSales"] as int).compareTo(a["totalSales"] as int);
        case "savings":
          return (b["savings"] as double).compareTo(a["savings"] as double);
        case "margin":
          return (b["margin"] as double).compareTo(a["margin"] as double);
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Combo Meals"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RmaComboAnalyticsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('RmaComboSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildComboOverview(),
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
                  Text(
                    "Available Combos (${filteredAndSortedCombos.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  if (filteredAndSortedCombos.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No combo meals found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Create combo meals to increase average order value",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredAndSortedCombos.map((combo) => _buildComboCard(combo)).toList(),
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

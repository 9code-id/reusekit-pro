import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsComboMealsView extends StatefulWidget {
  const RfsComboMealsView({super.key});

  @override
  State<RfsComboMealsView> createState() => _RfsComboMealsViewState();
}

class _RfsComboMealsViewState extends State<RfsComboMealsView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> comboMeals = [
    {
      "id": 1,
      "name": "Classic Burger Combo",
      "description": "Beef burger, fries, and soft drink - perfect value meal",
      "price": 14.99,
      "originalPrice": 18.97,
      "savings": 3.98,
      "category": "Lunch",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=1&keyword=burger-combo",
      "preparationTime": 12,
      "popularity": 95,
      "ordersToday": 45,
      "items": [
        {"name": "Beef Burger", "price": 9.99, "calories": 520},
        {"name": "French Fries", "price": 4.99, "calories": 320},
        {"name": "Soft Drink", "price": 3.99, "calories": 140}
      ],
      "totalCalories": 980,
      "allergens": ["Gluten", "Dairy", "Soy"],
      "customizable": true,
      "substitutions": ["Veggie Burger", "Sweet Potato Fries", "Diet Drink"],
      "rating": 4.6,
      "reviews": 127
    },
    {
      "id": 2,
      "name": "Mediterranean Bowl Set",
      "description": "Grilled chicken bowl with hummus, pita, and Greek salad",
      "price": 16.99,
      "originalPrice": 21.97,
      "savings": 4.98,
      "category": "Healthy",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=2&keyword=mediterranean-bowl",
      "preparationTime": 15,
      "popularity": 88,
      "ordersToday": 32,
      "items": [
        {"name": "Grilled Chicken Bowl", "price": 12.99, "calories": 420},
        {"name": "Hummus & Pita", "price": 5.99, "calories": 280},
        {"name": "Greek Salad", "price": 6.99, "calories": 180}
      ],
      "totalCalories": 880,
      "allergens": ["Gluten", "Dairy", "Sesame"],
      "customizable": true,
      "substitutions": ["Falafel", "Extra Vegetables", "Tzatziki"],
      "rating": 4.8,
      "reviews": 89
    },
    {
      "id": 3,
      "name": "Breakfast Special",
      "description": "Pancakes, scrambled eggs, bacon, and fresh juice",
      "price": 12.99,
      "originalPrice": 16.96,
      "savings": 3.97,
      "category": "Breakfast",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=3&keyword=breakfast-special",
      "preparationTime": 18,
      "popularity": 92,
      "ordersToday": 28,
      "items": [
        {"name": "Pancakes (3)", "price": 6.99, "calories": 350},
        {"name": "Scrambled Eggs", "price": 4.99, "calories": 180},
        {"name": "Bacon (3 strips)", "price": 3.99, "calories": 120},
        {"name": "Fresh Orange Juice", "price": 2.99, "calories": 110}
      ],
      "totalCalories": 760,
      "allergens": ["Gluten", "Dairy", "Eggs"],
      "customizable": true,
      "substitutions": ["Turkey Bacon", "Egg Whites", "Whole Wheat Pancakes"],
      "rating": 4.7,
      "reviews": 156
    },
    {
      "id": 4,
      "name": "Pizza Family Pack",
      "description": "Large pizza, garlic bread, and 2L soda for sharing",
      "price": 24.99,
      "originalPrice": 31.97,
      "savings": 6.98,
      "category": "Family",
      "isActive": false,
      "image": "https://picsum.photos/200/200?random=4&keyword=pizza-family",
      "preparationTime": 25,
      "popularity": 85,
      "ordersToday": 12,
      "items": [
        {"name": "Large Margherita Pizza", "price": 18.99, "calories": 2400},
        {"name": "Garlic Bread", "price": 6.99, "calories": 420},
        {"name": "2L Coca Cola", "price": 5.99, "calories": 800}
      ],
      "totalCalories": 3620,
      "allergens": ["Gluten", "Dairy"],
      "customizable": true,
      "substitutions": ["Different Pizza Toppings", "Cheesy Garlic Bread", "Diet Soda"],
      "rating": 4.5,
      "reviews": 203
    },
    {
      "id": 5,
      "name": "Sushi Bento Box",
      "description": "Assorted sushi, miso soup, edamame, and green tea",
      "price": 19.99,
      "originalPrice": 26.96,
      "savings": 6.97,
      "category": "Asian",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=5&keyword=sushi-bento",
      "preparationTime": 20,
      "popularity": 87,
      "ordersToday": 18,
      "items": [
        {"name": "Assorted Sushi (8 pieces)", "price": 15.99, "calories": 320},
        {"name": "Miso Soup", "price": 3.99, "calories": 80},
        {"name": "Edamame", "price": 4.99, "calories": 120},
        {"name": "Green Tea", "price": 1.99, "calories": 0}
      ],
      "totalCalories": 520,
      "allergens": ["Fish", "Soy", "Sesame"],
      "customizable": true,
      "substitutions": ["Vegetarian Rolls", "Clear Soup", "Jasmine Tea"],
      "rating": 4.9,
      "reviews": 78
    },
    {
      "id": 6,
      "name": "Taco Tuesday Trio",
      "description": "Three different tacos with guacamole and chips",
      "price": 13.99,
      "originalPrice": 17.97,
      "savings": 3.98,
      "category": "Mexican",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=6&keyword=taco-trio",
      "preparationTime": 14,
      "popularity": 90,
      "ordersToday": 38,
      "items": [
        {"name": "Beef Taco", "price": 4.99, "calories": 280},
        {"name": "Chicken Taco", "price": 4.99, "calories": 260},
        {"name": "Fish Taco", "price": 5.99, "calories": 240},
        {"name": "Guacamole & Chips", "price": 3.99, "calories": 320}
      ],
      "totalCalories": 1100,
      "allergens": ["Gluten", "Fish", "Dairy"],
      "customizable": true,
      "substitutions": ["Vegetarian Tacos", "Corn Tortillas", "Salsa Verde"],
      "rating": 4.4,
      "reviews": 94
    }
  ];

  List<String> categoryOptions = ["All", "Breakfast", "Lunch", "Healthy", "Family", "Asian", "Mexican"];

  List<Map<String, dynamic>> get filteredCombos {
    return comboMeals.where((combo) {
      bool matchesSearch = combo["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          combo["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || combo["category"] == selectedCategory;
      bool matchesStatus = !showActiveOnly || combo["isActive"];
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  void _showComboDetails(Map<String, dynamic> combo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${combo["name"]}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${combo["image"]}",
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${combo["description"]}",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${(combo["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: successColor),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(combo["originalPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Save \$${(combo["savings"] as double).toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Category", "${combo["category"]}"),
                _buildDetailRow("Prep Time", "${combo["preparationTime"]} mins"),
                _buildDetailRow("Popularity", "${combo["popularity"]}%"),
                _buildDetailRow("Orders Today", "${combo["ordersToday"]}"),
                _buildDetailRow("Total Calories", "${combo["totalCalories"]}"),
                _buildDetailRow("Rating", "${combo["rating"]} (${combo["reviews"]} reviews)"),
                SizedBox(height: spSm),
                Text("Combo Items:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spXs),
                ...(combo["items"] as List).map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item["name"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("${item["calories"]} cal", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("\$${(item["price"] as double).toStringAsFixed(2)}", 
                             style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: spSm),
                Text("Allergens:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (combo["allergens"] as List).map((allergen) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${allergen}",
                        style: TextStyle(fontSize: 12, color: warningColor),
                      ),
                    );
                  }).toList(),
                ),
                if (combo["customizable"]) ...[
                  SizedBox(height: spSm),
                  Text("Available Substitutions:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: spXs),
                  ...(combo["substitutions"] as List).map((sub) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text("• ${sub}", style: TextStyle(fontSize: 12, color: infoColor)),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: disabledBoldColor)),
        ],
      ),
    );
  }

  Widget _buildComboCard(Map<String, dynamic> combo) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusSm),
                  topRight: Radius.circular(radiusSm),
                ),
                child: Image.network(
                  "${combo["image"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: combo["isActive"] ? successColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    combo["isActive"] ? "ACTIVE" : "INACTIVE",
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Save \$${(combo["savings"] as double).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${combo["name"]}",
                  style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: spXs),
                Text(
                  "${combo["description"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${(combo["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: successColor),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(combo["originalPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: 2),
                    Text(
                      "${combo["rating"]}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${combo["category"]}",
                        style: TextStyle(fontSize: 10, color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${combo["totalCalories"]} cal",
                        style: TextStyle(fontSize: 10, color: infoColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (combo["customizable"]) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "CUSTOMIZABLE",
                          style: TextStyle(fontSize: 10, color: warningColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                    Spacer(),
                    Text(
                      "${combo["popularity"]}%",
                      style: TextStyle(fontSize: 12, color: successColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _showComboDetails(combo),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: combo["isActive"] ? Icons.pause : Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          combo["isActive"] = !combo["isActive"];
                        });
                        ss(combo["isActive"] ? "Combo activated" : "Combo deactivated");
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

  Widget _buildCombosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Combo Meals", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          // Stats Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${comboMeals.where((c) => c["isActive"]).length}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      Text("Active Combos", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${comboMeals.fold(0, (sum, combo) => sum + (combo["ordersToday"] as int))}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor),
                      ),
                      Text("Orders Today", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${(comboMeals.fold(0.0, (sum, combo) => sum + ((combo["ordersToday"] as int) * (combo["price"] as double)))).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: warningColor),
                      ),
                      Text("Revenue", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions.map((category) => {"label": category, "value": category}).toList(),
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search combos...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            items: [
              {
                "label": "Show active only",
                "value": true,
                "checked": showActiveOnly,
              }
            ],
            value: [if (showActiveOnly) {"label": "Show active only", "value": true, "checked": true}],
            onChanged: (values, ids) {
              showActiveOnly = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Combos List
          Text("Available Combos (${filteredCombos.length})", 
               style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          ...filteredCombos.map((combo) => _buildComboCard(combo)).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Combo Meals Analytics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          // Performance Chart
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Combo Performance", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  child: Center(
                    child: Text("Performance Chart Placeholder", 
                                style: TextStyle(color: disabledBoldColor)),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Top Performing Combos
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Top Performing Combos", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...comboMeals.take(3).map((combo) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${combo["image"]}",
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
                              Text("${combo["name"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("${combo["ordersToday"]} orders • \$${(combo["price"] as double).toStringAsFixed(2)}", 
                                   style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("${combo["popularity"]}%", style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Category Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Category Breakdown", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...categoryOptions.skip(1).map((category) {
                  List<Map<String, dynamic>> categoryItems = comboMeals.where((c) => c["category"] == category).toList();
                  int totalOrders = categoryItems.fold(0, (sum, item) => sum + (item["ordersToday"] as int));
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(category, style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("${categoryItems.length} combos", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                        Text("$totalOrders orders", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Combo Customization", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          // Customizable Combos
          Text("Customizable Combos", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          ...comboMeals.where((combo) => combo["customizable"]).map((combo) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${combo["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${combo["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("\$${(combo["price"] as double).toStringAsFixed(2)}", 
                                 style: TextStyle(color: successColor, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "CUSTOMIZABLE",
                          style: TextStyle(fontSize: 10, color: warningColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text("Available Substitutions:", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: spXs),
                  ...(combo["substitutions"] as List).map((substitution) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.swap_horiz, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text("${substitution}", style: TextStyle(fontSize: 12, color: primaryColor)),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Combo Meals",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Combos", icon: Icon(Icons.restaurant)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Customization", icon: Icon(Icons.tune)),
      ],
      tabChildren: [
        _buildCombosTab(),
        _buildAnalyticsTab(),
        _buildCustomizationTab(),
      ],
    );
  }
}

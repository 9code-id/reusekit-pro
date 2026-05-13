import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsIngredientInventoryView extends StatefulWidget {
  const RfsIngredientInventoryView({super.key});

  @override
  State<RfsIngredientInventoryView> createState() => _RfsIngredientInventoryViewState();
}

class _RfsIngredientInventoryViewState extends State<RfsIngredientInventoryView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedUsageType = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Proteins", "value": "Proteins"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Spices", "value": "Spices"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Oils", "value": "Oils"},
    {"label": "Seasonings", "value": "Seasonings"},
  ];

  List<Map<String, dynamic>> usageTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "High Usage", "value": "High Usage"},
    {"label": "Medium Usage", "value": "Medium Usage"},
    {"label": "Low Usage", "value": "Low Usage"},
    {"label": "Seasonal", "value": "Seasonal"},
  ];

  List<Map<String, dynamic>> ingredients = [
    {
      "id": "ING001",
      "name": "Fresh Basil",
      "category": "Seasonings",
      "currentStock": 2.5,
      "unit": "lbs",
      "costPerUnit": 12.00,
      "totalValue": 30.00,
      "usageType": "High Usage",
      "avgDailyUsage": 0.3,
      "daysRemaining": 8,
      "recipeCount": 15,
      "popularRecipes": ["Margherita Pizza", "Caprese Salad", "Pesto Pasta"],
      "supplier": "Fresh Herbs Co",
      "lastOrdered": "2025-06-17T00:00:00",
      "location": "Herb Storage",
      "preservationMethod": "Refrigerated",
      "qualityGrade": "Premium",
      "image": "https://picsum.photos/300/200?random=1&keyword=basil"
    },
    {
      "id": "ING002",
      "name": "Extra Virgin Olive Oil",
      "category": "Oils",
      "currentStock": 8,
      "unit": "bottles",
      "costPerUnit": 15.99,
      "totalValue": 127.92,
      "usageType": "High Usage",
      "avgDailyUsage": 1.2,
      "daysRemaining": 7,
      "recipeCount": 28,
      "popularRecipes": ["Caesar Salad", "Grilled Vegetables", "Marinades"],
      "supplier": "Mediterranean Imports",
      "lastOrdered": "2025-06-15T00:00:00",
      "location": "Pantry A",
      "preservationMethod": "Room Temperature",
      "qualityGrade": "Premium",
      "image": "https://picsum.photos/300/200?random=2&keyword=olive"
    },
    {
      "id": "ING003",
      "name": "Aged Parmesan",
      "category": "Dairy",
      "currentStock": 4.2,
      "unit": "lbs",
      "costPerUnit": 22.50,
      "totalValue": 94.50,
      "usageType": "Medium Usage",
      "avgDailyUsage": 0.4,
      "daysRemaining": 11,
      "recipeCount": 12,
      "popularRecipes": ["Pasta Carbonara", "Caesar Salad", "Risotto"],
      "supplier": "Artisan Cheese Co",
      "lastOrdered": "2025-06-12T00:00:00",
      "location": "Cheese Cooler",
      "preservationMethod": "Refrigerated",
      "qualityGrade": "Artisan",
      "image": "https://picsum.photos/300/200?random=3&keyword=parmesan"
    },
    {
      "id": "ING004",
      "name": "Black Truffle",
      "category": "Seasonings",
      "currentStock": 0.2,
      "unit": "lbs",
      "costPerUnit": 800.00,
      "totalValue": 160.00,
      "usageType": "Seasonal",
      "avgDailyUsage": 0.02,
      "daysRemaining": 10,
      "recipeCount": 3,
      "popularRecipes": ["Truffle Pasta", "Truffle Risotto", "Beef Wellington"],
      "supplier": "Gourmet Truffles Ltd",
      "lastOrdered": "2025-06-10T00:00:00",
      "location": "Special Storage",
      "preservationMethod": "Climate Controlled",
      "qualityGrade": "Luxury",
      "image": "https://picsum.photos/300/200?random=4&keyword=truffle"
    },
    {
      "id": "ING005",
      "name": "Organic Tomatoes",
      "category": "Vegetables",
      "currentStock": 15,
      "unit": "lbs",
      "costPerUnit": 4.50,
      "totalValue": 67.50,
      "usageType": "High Usage",
      "avgDailyUsage": 3.5,
      "daysRemaining": 4,
      "recipeCount": 22,
      "popularRecipes": ["Marinara Sauce", "Bruschetta", "Caprese Salad"],
      "supplier": "Organic Valley Farms",
      "lastOrdered": "2025-06-18T00:00:00",
      "location": "Produce Section",
      "preservationMethod": "Refrigerated",
      "qualityGrade": "Organic",
      "image": "https://picsum.photos/300/200?random=5&keyword=tomatoes"
    },
    {
      "id": "ING006",
      "name": "Prime Beef Tenderloin",
      "category": "Proteins",
      "currentStock": 12,
      "unit": "lbs",
      "costPerUnit": 35.99,
      "totalValue": 431.88,
      "usageType": "Medium Usage",
      "avgDailyUsage": 2.5,
      "daysRemaining": 5,
      "recipeCount": 8,
      "popularRecipes": ["Beef Wellington", "Filet Mignon", "Beef Carpaccio"],
      "supplier": "Premium Meats Co",
      "lastOrdered": "2025-06-16T00:00:00",
      "location": "Meat Freezer",
      "preservationMethod": "Frozen",
      "qualityGrade": "Prime",
      "image": "https://picsum.photos/300/200?random=6&keyword=beef"
    },
  ];

  List<Map<String, dynamic>> get filteredIngredients {
    return ingredients.where((ingredient) {
      bool matchesSearch = "${ingredient["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${ingredient["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || ingredient["category"] == selectedCategory;
      bool matchesUsage = selectedUsageType == "All" || ingredient["usageType"] == selectedUsageType;
      
      return matchesSearch && matchesCategory && matchesUsage;
    }).toList();
  }

  Color getUsageTypeColor(String usageType) {
    switch (usageType) {
      case "High Usage": return dangerColor;
      case "Medium Usage": return warningColor;
      case "Low Usage": return successColor;
      case "Seasonal": return infoColor;
      default: return disabledColor;
    }
  }

  Color getQualityGradeColor(String grade) {
    switch (grade) {
      case "Luxury": return Color(0xFFFFD700);
      case "Premium": return primaryColor;
      case "Artisan": return secondaryColor;
      case "Organic": return successColor;
      case "Standard": return disabledBoldColor;
      default: return disabledColor;
    }
  }

  Color getDaysRemainingColor(int days) {
    if (days <= 3) return dangerColor;
    if (days <= 7) return warningColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredient Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Ingredients",
                    value: searchQuery,
                    hint: "Search by name or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
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
                    label: "Usage Type",
                    items: usageTypeOptions,
                    value: selectedUsageType,
                    onChanged: (value, label) {
                      selectedUsageType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.restaurant, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${ingredients.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Ingredients",
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.trending_up, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${ingredients.where((ing) => ing["usageType"] == "High Usage").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Usage",
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${ingredients.where((ing) => (ing["daysRemaining"] as int) <= 7).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Expiring",
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
            ),

            // Total Value
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: successColor, size: 24),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Ingredient Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((ingredients.map((ing) => ing["totalValue"] as double).reduce((a, b) => a + b)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Ingredients List
            ...filteredIngredients.map((ingredient) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getUsageTypeColor("${ingredient["usageType"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          bottomLeft: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${ingredient["image"]}",
                          width: 100,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${ingredient["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getQualityGradeColor("${ingredient["qualityGrade"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getQualityGradeColor("${ingredient["qualityGrade"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${ingredient["qualityGrade"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getQualityGradeColor("${ingredient["qualityGrade"]}"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getUsageTypeColor("${ingredient["usageType"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getUsageTypeColor("${ingredient["usageType"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${ingredient["usageType"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getUsageTypeColor("${ingredient["usageType"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${ingredient["id"]} • ${ingredient["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.inventory, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(ingredient["currentStock"] as double).toStringAsFixed(1)} ${ingredient["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.schedule, size: 14, color: getDaysRemainingColor(ingredient["daysRemaining"] as int)),
                                  SizedBox(width: 4),
                                  Text(
                                    "${ingredient["daysRemaining"]} days",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: getDaysRemainingColor(ingredient["daysRemaining"] as int),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.restaurant_menu, size: 14, color: primaryColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${ingredient["recipeCount"]} recipes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${((ingredient["totalValue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Popular Recipes Section
                  if ((ingredient["popularRecipes"] as List).isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        border: Border(
                          top: BorderSide(color: disabledOutlineBorderColor),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Popular Recipes:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: 4,
                            children: (ingredient["popularRecipes"] as List).take(3).map((recipe) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: primaryColor.withAlpha(50)),
                              ),
                              child: Text(
                                "$recipe",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${ingredient["location"]} • ${ingredient["preservationMethod"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.business, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${ingredient["supplier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Daily use: ${(ingredient["avgDailyUsage"] as double).toStringAsFixed(1)} ${ingredient["unit"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Last Ordered: ${DateTime.parse("${ingredient["lastOrdered"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Recipes",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Reorder",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSeasonalMenuView extends StatefulWidget {
  const RmaSeasonalMenuView({super.key});

  @override
  State<RmaSeasonalMenuView> createState() => _RmaSeasonalMenuViewState();
}

class _RmaSeasonalMenuViewState extends State<RmaSeasonalMenuView> {
  String selectedSeason = "summer";
  String selectedCategory = "all";
  bool showAvailabilityOnly = true;
  
  Map<String, List<Map<String, dynamic>>> seasonalMenus = {
    "spring": [
      {
        "id": "spring_1",
        "name": "Fresh Spring Salad",
        "description": "Mixed greens with strawberries, goat cheese, and balsamic vinaigrette",
        "category": "salads",
        "price": 14.99,
        "cost": 5.50,
        "margin": 63.2,
        "available": true,
        "startDate": "2025-03-01",
        "endDate": "2025-05-31",
        "ingredients": ["mixed greens", "strawberries", "goat cheese", "balsamic", "walnuts"],
        "allergens": ["dairy", "nuts"],
        "nutritionalInfo": {"calories": 320, "protein": 12, "carbs": 15, "fat": 18},
        "popularity": 8.5,
        "orders": 156,
        "image": "https://picsum.photos/300/200?random=1&keyword=spring+salad"
      },
      {
        "id": "spring_2",
        "name": "Asparagus Risotto",
        "description": "Creamy risotto with fresh asparagus and parmesan",
        "category": "mains",
        "price": 18.99,
        "cost": 7.25,
        "margin": 61.8,
        "available": true,
        "startDate": "2025-03-15",
        "endDate": "2025-05-15",
        "ingredients": ["arborio rice", "asparagus", "parmesan", "white wine", "vegetable broth"],
        "allergens": ["dairy", "alcohol"],
        "nutritionalInfo": {"calories": 420, "protein": 15, "carbs": 52, "fat": 16},
        "popularity": 7.2,
        "orders": 89,
        "image": "https://picsum.photos/300/200?random=2&keyword=risotto"
      }
    ],
    "summer": [
      {
        "id": "summer_1",
        "name": "Grilled Peach Chicken",
        "description": "Grilled chicken breast with caramelized peaches and herbs",
        "category": "mains",
        "price": 22.99,
        "cost": 8.75,
        "margin": 61.9,
        "available": true,
        "startDate": "2025-06-01",
        "endDate": "2025-08-31",
        "ingredients": ["chicken breast", "fresh peaches", "rosemary", "honey", "olive oil"],
        "allergens": [],
        "nutritionalInfo": {"calories": 380, "protein": 35, "carbs": 18, "fat": 14},
        "popularity": 9.1,
        "orders": 245,
        "image": "https://picsum.photos/300/200?random=3&keyword=grilled+chicken"
      },
      {
        "id": "summer_2",
        "name": "Watermelon Gazpacho",
        "description": "Chilled watermelon soup with mint and feta cheese",
        "category": "soups",
        "price": 11.99,
        "cost": 4.25,
        "margin": 64.6,
        "available": true,
        "startDate": "2025-06-15",
        "endDate": "2025-08-15",
        "ingredients": ["watermelon", "cucumber", "mint", "feta", "lime"],
        "allergens": ["dairy"],
        "nutritionalInfo": {"calories": 180, "protein": 6, "carbs": 22, "fat": 8},
        "popularity": 6.8,
        "orders": 67,
        "image": "https://picsum.photos/300/200?random=4&keyword=gazpacho"
      },
      {
        "id": "summer_3",
        "name": "Berry Parfait",
        "description": "Layered yogurt with seasonal berries and granola",
        "category": "desserts",
        "price": 8.99,
        "cost": 3.50,
        "margin": 61.1,
        "available": true,
        "startDate": "2025-06-01",
        "endDate": "2025-08-31",
        "ingredients": ["greek yogurt", "mixed berries", "granola", "honey"],
        "allergens": ["dairy", "gluten"],
        "nutritionalInfo": {"calories": 280, "protein": 12, "carbs": 35, "fat": 9},
        "popularity": 8.7,
        "orders": 189,
        "image": "https://picsum.photos/300/200?random=5&keyword=parfait"
      }
    ],
    "fall": [
      {
        "id": "fall_1",
        "name": "Pumpkin Ravioli",
        "description": "Handmade ravioli stuffed with pumpkin and sage butter",
        "category": "mains",
        "price": 19.99,
        "cost": 7.50,
        "margin": 62.5,
        "available": false,
        "startDate": "2025-09-01",
        "endDate": "2025-11-30",
        "ingredients": ["pasta", "pumpkin", "sage", "butter", "parmesan"],
        "allergens": ["gluten", "dairy"],
        "nutritionalInfo": {"calories": 450, "protein": 16, "carbs": 48, "fat": 22},
        "popularity": 8.9,
        "orders": 203,
        "image": "https://picsum.photos/300/200?random=6&keyword=ravioli"
      },
      {
        "id": "fall_2",
        "name": "Apple Cider Glazed Pork",
        "description": "Tender pork tenderloin with apple cider glaze",
        "category": "mains",
        "price": 24.99,
        "cost": 9.25,
        "margin": 63.0,
        "available": false,
        "startDate": "2025-09-15",
        "endDate": "2025-11-15",
        "ingredients": ["pork tenderloin", "apple cider", "apples", "thyme", "butter"],
        "allergens": ["dairy"],
        "nutritionalInfo": {"calories": 420, "protein": 32, "carbs": 25, "fat": 18},
        "popularity": 7.6,
        "orders": 134,
        "image": "https://picsum.photos/300/200?random=7&keyword=pork"
      }
    ],
    "winter": [
      {
        "id": "winter_1",
        "name": "Hearty Beef Stew",
        "description": "Slow-cooked beef stew with root vegetables",
        "category": "soups",
        "price": 16.99,
        "cost": 6.75,
        "margin": 60.3,
        "available": false,
        "startDate": "2025-12-01",
        "endDate": "2025-02-28",
        "ingredients": ["beef chuck", "carrots", "potatoes", "onions", "herbs"],
        "allergens": [],
        "nutritionalInfo": {"calories": 380, "protein": 28, "carbs": 22, "fat": 20},
        "popularity": 8.3,
        "orders": 178,
        "image": "https://picsum.photos/300/200?random=8&keyword=stew"
      },
      {
        "id": "winter_2",
        "name": "Spiced Hot Chocolate",
        "description": "Rich hot chocolate with cinnamon and whipped cream",
        "category": "beverages",
        "price": 6.99,
        "cost": 2.25,
        "margin": 67.8,
        "available": false,
        "startDate": "2025-12-01",
        "endDate": "2025-02-28",
        "ingredients": ["dark chocolate", "milk", "cinnamon", "vanilla", "whipped cream"],
        "allergens": ["dairy"],
        "nutritionalInfo": {"calories": 320, "protein": 8, "carbs": 35, "fat": 18},
        "popularity": 9.0,
        "orders": 267,
        "image": "https://picsum.photos/300/200?random=9&keyword=hot+chocolate"
      }
    ]
  };

  List<String> seasons = ["spring", "summer", "fall", "winter"];
  List<String> seasonLabels = ["Spring", "Summer", "Fall", "Winter"];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Mains", "value": "mains"},
    {"label": "Salads", "value": "salads"},
    {"label": "Soups", "value": "soups"},
    {"label": "Desserts", "value": "desserts"},
    {"label": "Beverages", "value": "beverages"},
  ];

  Widget _buildSeasonSelector() {
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
            "Select Season",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: List.generate(seasons.length, (index) {
              final season = seasons[index];
              final isSelected = selectedSeason == season;
              final menuCount = seasonalMenus[season]?.length ?? 0;
              final availableCount = seasonalMenus[season]?.where((item) => item["available"] as bool).length ?? 0;
              
              return GestureDetector(
                onTap: () {
                  selectedSeason = season;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _getSeasonIcon(season),
                        color: isSelected ? Colors.white : primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        seasonLabels[index],
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$menuCount items",
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "$availableCount available",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  IconData _getSeasonIcon(String season) {
    switch (season) {
      case "spring":
        return Icons.local_florist;
      case "summer":
        return Icons.wb_sunny;
      case "fall":
        return Icons.nature;
      case "winter":
        return Icons.ac_unit;
      default:
        return Icons.restaurant_menu;
    }
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
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
            child: QSwitch(
              items: [
                {
                  "label": "Available Only",
                  "value": true,
                  "checked": showAvailabilityOnly,
                }
              ],
              value: [
                if (showAvailabilityOnly)
                  {
                    "label": "Available Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showAvailabilityOnly = values.isNotEmpty;
                setState(() {});
              },
            ),
          ),
          QButton(
            label: "Add Item",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              //navigateTo('RmaAddSeasonalItemView')
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    final isAvailable = item["available"] as bool;
    final marginColor = (item["margin"] as double) >= 60 ? successColor : 
                       (item["margin"] as double) >= 40 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isAvailable ? successColor : disabledBoldColor,
          width: 2,
        ),
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
                image: NetworkImage("${item["image"]}"),
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
                      color: isAvailable ? successColor : disabledBoldColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      isAvailable ? "AVAILABLE" : "SEASONAL",
                      style: TextStyle(
                        fontSize: 10,
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
                      color: marginColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${(item["margin"] as double).toStringAsFixed(1)}% margin",
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
                        "${(item["popularity"] as double).toStringAsFixed(1)}",
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
                        "${item["name"]}",
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
                        "${item["category"]}",
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
                  "${item["description"]}",
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
                    children: [
                      Row(
                        children: [
                          _buildDetailItem("Season", "${item["startDate"]} - ${item["endDate"]}"),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          _buildDetailItem("Price", "\$${((item["price"] as double)).currency}"),
                          _buildDetailItem("Orders", "${item["orders"]}"),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nutrition (per serving):",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(item["nutritionalInfo"] as Map)["calories"]} cal • ${(item["nutritionalInfo"] as Map)["protein"]}g protein",
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
                      if ((item["allergens"] as List).isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "Allergens: ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (item["allergens"] as List).join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: isAvailable ? "Add to Menu" : "Schedule",
                        icon: isAvailable ? Icons.add : Icons.schedule,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaAddSeasonalToMenuView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaEditSeasonalItemView')
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.analytics,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaSeasonalAnalyticsView')
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

  Widget _buildDetailItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredItems {
    final items = seasonalMenus[selectedSeason] ?? [];
    return items.where((item) {
      if (selectedCategory != "all" && item["category"] != selectedCategory) {
        return false;
      }
      if (showAvailabilityOnly && !(item["available"] as bool)) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Menu"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //navigateTo('RmaSeasonalCalendarView')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RmaSeasonalAnalyticsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSeasonSelector(),
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
                    "${seasonLabels[seasons.indexOf(selectedSeason)]} Menu Items (${filteredItems.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  if (filteredItems.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            _getSeasonIcon(selectedSeason),
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No seasonal items found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Add seasonal items to take advantage of fresh ingredients",
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
                      children: filteredItems.map((item) => _buildMenuItemCard(item)).toList(),
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

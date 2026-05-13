import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDailySpecialsView extends StatefulWidget {
  const RfsDailySpecialsView({super.key});

  @override
  State<RfsDailySpecialsView> createState() => _RfsDailySpecialsViewState();
}

class _RfsDailySpecialsViewState extends State<RfsDailySpecialsView> {
  int currentTab = 0;
  String selectedDay = "Today";
  String selectedCategory = "All";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> dailySpecials = [
    {
      "id": 1,
      "name": "Grilled Salmon Special",
      "description": "Fresh Atlantic salmon with lemon herbs and seasonal vegetables",
      "originalPrice": 28.99,
      "specialPrice": 22.99,
      "discount": 21,
      "category": "Main Course",
      "day": "Monday",
      "timeSlot": "All Day",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=1&keyword=salmon",
      "preparationTime": 25,
      "availability": 15,
      "soldToday": 8,
      "ingredients": ["Atlantic Salmon", "Lemon", "Herbs", "Vegetables"],
      "allergens": ["Fish"],
      "calories": 380,
      "chef": "Chef Marco",
      "rating": 4.8,
      "reviews": 24
    },
    {
      "id": 2,
      "name": "Tuesday Taco Trio",
      "description": "Three authentic tacos with different fillings and spicy salsa",
      "originalPrice": 16.99,
      "specialPrice": 12.99,
      "discount": 24,
      "category": "Main Course",
      "day": "Tuesday",
      "timeSlot": "Lunch",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=2&keyword=tacos",
      "preparationTime": 15,
      "availability": 25,
      "soldToday": 12,
      "ingredients": ["Corn Tortillas", "Beef", "Chicken", "Fish", "Salsa"],
      "allergens": ["Gluten", "Dairy"],
      "calories": 520,
      "chef": "Chef Rosa",
      "rating": 4.6,
      "reviews": 31
    },
    {
      "id": 3,
      "name": "Wednesday Wine & Pasta",
      "description": "Premium pasta with wine reduction sauce and parmesan",
      "originalPrice": 24.99,
      "specialPrice": 19.99,
      "discount": 20,
      "category": "Main Course",
      "day": "Wednesday",
      "timeSlot": "Dinner",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=3&keyword=pasta",
      "preparationTime": 20,
      "availability": 18,
      "soldToday": 6,
      "ingredients": ["Pasta", "Wine", "Parmesan", "Herbs"],
      "allergens": ["Gluten", "Dairy"],
      "calories": 450,
      "chef": "Chef Antonio",
      "rating": 4.9,
      "reviews": 18
    },
    {
      "id": 4,
      "name": "Thursday BBQ Platter",
      "description": "Mixed BBQ with ribs, chicken, and signature sauce",
      "originalPrice": 32.99,
      "specialPrice": 26.99,
      "discount": 18,
      "category": "Main Course",
      "day": "Thursday",
      "timeSlot": "All Day",
      "isActive": false,
      "image": "https://picsum.photos/200/200?random=4&keyword=bbq",
      "preparationTime": 35,
      "availability": 12,
      "soldToday": 4,
      "ingredients": ["Pork Ribs", "Chicken", "BBQ Sauce", "Coleslaw"],
      "allergens": ["Soy"],
      "calories": 680,
      "chef": "Chef Jake",
      "rating": 4.7,
      "reviews": 22
    },
    {
      "id": 5,
      "name": "Friday Fish & Chips",
      "description": "Traditional beer-battered fish with crispy chips and mushy peas",
      "originalPrice": 19.99,
      "specialPrice": 15.99,
      "discount": 20,
      "category": "Main Course",
      "day": "Friday",
      "timeSlot": "All Day",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=5&keyword=fish-chips",
      "preparationTime": 18,
      "availability": 20,
      "soldToday": 15,
      "ingredients": ["White Fish", "Beer Batter", "Potatoes", "Mushy Peas"],
      "allergens": ["Fish", "Gluten"],
      "calories": 520,
      "chef": "Chef Oliver",
      "rating": 4.5,
      "reviews": 42
    },
    {
      "id": 6,
      "name": "Weekend Brunch Special",
      "description": "Eggs benedict with smoked salmon and hollandaise sauce",
      "originalPrice": 21.99,
      "specialPrice": 17.99,
      "discount": 18,
      "category": "Brunch",
      "day": "Saturday",
      "timeSlot": "Brunch",
      "isActive": true,
      "image": "https://picsum.photos/200/200?random=6&keyword=eggs-benedict",
      "preparationTime": 22,
      "availability": 16,
      "soldToday": 9,
      "ingredients": ["English Muffin", "Eggs", "Smoked Salmon", "Hollandaise"],
      "allergens": ["Gluten", "Dairy", "Eggs", "Fish"],
      "calories": 420,
      "chef": "Chef Emma",
      "rating": 4.8,
      "reviews": 28
    }
  ];

  List<String> dayOptions = ["Today", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<String> categoryOptions = ["All", "Main Course", "Appetizer", "Dessert", "Brunch", "Beverage"];

  List<Map<String, dynamic>> get filteredSpecials {
    return dailySpecials.where((special) {
      bool matchesSearch = special["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          special["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDay = selectedDay == "Today" || special["day"] == selectedDay;
      bool matchesCategory = selectedCategory == "All" || special["category"] == selectedCategory;
      bool matchesStatus = !showActiveOnly || special["isActive"];
      return matchesSearch && matchesDay && matchesCategory && matchesStatus;
    }).toList();
  }

  void _showSpecialDetails(Map<String, dynamic> special) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${special["name"]}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${special["image"]}",
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${special["description"]}",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${(special["specialPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: successColor),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(special["originalPrice"] as double).toStringAsFixed(2)}",
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
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${special["discount"]}% OFF",
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Chef", "${special["chef"]}"),
                _buildDetailRow("Day", "${special["day"]}"),
                _buildDetailRow("Time Slot", "${special["timeSlot"]}"),
                _buildDetailRow("Prep Time", "${special["preparationTime"]} mins"),
                _buildDetailRow("Available", "${special["availability"]} portions"),
                _buildDetailRow("Sold Today", "${special["soldToday"]}"),
                _buildDetailRow("Calories", "${special["calories"]}"),
                _buildDetailRow("Rating", "${special["rating"]} (${special["reviews"]} reviews)"),
                SizedBox(height: spSm),
                Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (special["ingredients"] as List).map((ingredient) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${ingredient}",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Text("Allergens:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (special["allergens"] as List).map((allergen) {
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

  Widget _buildSpecialCard(Map<String, dynamic> special) {
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
                  "${special["image"]}",
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
                    color: special["isActive"] ? successColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    special["isActive"] ? "ACTIVE" : "INACTIVE",
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
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${special["discount"]}% OFF",
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
                  "${special["name"]}",
                  style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: spXs),
                Text(
                  "${special["description"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${(special["specialPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: successColor),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(special["originalPrice"] as double).toStringAsFixed(2)}",
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
                      "${special["rating"]}",
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
                        "${special["day"]}",
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
                        "${special["timeSlot"]}",
                        style: TextStyle(fontSize: 10, color: infoColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${special["availability"]} left",
                      style: TextStyle(fontSize: 12, color: warningColor, fontWeight: FontWeight.w600),
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
                        onPressed: () => _showSpecialDetails(special),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: special["isActive"] ? Icons.pause : Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          special["isActive"] = !special["isActive"];
                        });
                        ss(special["isActive"] ? "Special activated" : "Special deactivated");
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

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> activeSpecials = dailySpecials.where((s) => s["isActive"]).toList();
    int totalSoldToday = dailySpecials.fold(0, (sum, special) => sum + (special["soldToday"] as int));
    double totalRevenue = dailySpecials.fold(0.0, (sum, special) => 
        sum + ((special["soldToday"] as int) * (special["specialPrice"] as double)));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Specials Overview", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
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
                        "${activeSpecials.length}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      Text("Active Specials", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
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
                        "$totalSoldToday",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor),
                      ),
                      Text("Sold Today", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
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
                        "\$${totalRevenue.toStringAsFixed(0)}",
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
                  label: "Day",
                  items: dayOptions.map((day) => {"label": day, "value": day}).toList(),
                  value: selectedDay,
                  onChanged: (value, label) {
                    selectedDay = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Search specials...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
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
          
          // Specials List
          Text("Current Specials (${filteredSpecials.length})", 
               style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          ...filteredSpecials.map((special) => _buildSpecialCard(special)).toList(),
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
          Text("Daily Specials Analytics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
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
                Text("Weekly Performance", style: TextStyle(fontWeight: FontWeight.bold)),
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
          
          // Top Performing Specials
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
                Text("Top Performing Specials", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...dailySpecials.take(3).map((special) {
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
                            "${special["image"]}",
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
                              Text("${special["name"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("${special["soldToday"]} sold • \$${(special["specialPrice"] as double).toStringAsFixed(2)}", 
                                   style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("⭐ ${special["rating"]}", style: TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildScheduleTab() {
    Map<String, List<Map<String, dynamic>>> specialsByDay = {};
    for (var special in dailySpecials) {
      String day = special["day"];
      if (!specialsByDay.containsKey(day)) {
        specialsByDay[day] = [];
      }
      specialsByDay[day]!.add(special);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Weekly Schedule", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          ...specialsByDay.entries.map((entry) {
            String day = entry.key;
            List<Map<String, dynamic>> daySpecials = entry.value;
            
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
                      Text(day, style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("${daySpecials.length} specials", 
                           style: TextStyle(color: disabledBoldColor)),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...daySpecials.map((special) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: special["isActive"] ? primaryColor.withAlpha(10) : disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${special["image"]}",
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
                                Text("${special["name"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                                Text("${special["timeSlot"]} • \$${(special["specialPrice"] as double).toStringAsFixed(2)}", 
                                     style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: special["isActive"] ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              special["isActive"] ? "ACTIVE" : "INACTIVE",
                              style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
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
      title: "Daily Specials",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildScheduleTab(),
      ],
    );
  }
}

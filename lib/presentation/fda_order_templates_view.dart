import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderTemplatesView extends StatefulWidget {
  const FdaOrderTemplatesView({super.key});

  @override
  State<FdaOrderTemplatesView> createState() => _FdaOrderTemplatesViewState();
}

class _FdaOrderTemplatesViewState extends State<FdaOrderTemplatesView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Quick Meals", "value": "Quick Meals"},
    {"label": "Team Orders", "value": "Team Orders"},
    {"label": "Family Dinner", "value": "Family Dinner"},
    {"label": "Breakfast", "value": "Breakfast"},
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "template1",
      "name": "Monday Morning Boost",
      "description": "Perfect breakfast to start your week",
      "category": "Breakfast",
      "restaurant": "Coffee Corner",
      "restaurantImage": "https://picsum.photos/80/80?random=1&keyword=coffee",
      "image": "https://picsum.photos/120/120?random=1&keyword=breakfast",
      "totalPrice": 18.50,
      "estimatedTime": "15-20 mins",
      "itemCount": 3,
      "rating": 4.8,
      "usageCount": 12,
      "lastUsed": "2024-01-14",
      "isQuickOrder": true,
      "tags": ["Healthy", "Quick", "Energizing"],
      "items": [
        {"name": "Avocado Toast", "quantity": 1, "price": 8.99},
        {"name": "Fresh Orange Juice", "quantity": 1, "price": 4.50},
        {"name": "Greek Yogurt", "quantity": 1, "price": 5.00},
      ],
    },
    {
      "id": "template2",
      "name": "Office Lunch Special",
      "description": "Quick and satisfying lunch for busy workdays",
      "category": "Quick Meals",
      "restaurant": "Burger Palace",
      "restaurantImage": "https://picsum.photos/80/80?random=2&keyword=burger",
      "image": "https://picsum.photos/120/120?random=2&keyword=lunch",
      "totalPrice": 24.99,
      "estimatedTime": "25-30 mins",
      "itemCount": 2,
      "rating": 4.5,
      "usageCount": 8,
      "lastUsed": "2024-01-13",
      "isQuickOrder": false,
      "tags": ["Fast", "Filling", "Office"],
      "items": [
        {"name": "Classic Burger", "quantity": 1, "price": 12.99},
        {"name": "French Fries", "quantity": 1, "price": 4.99},
        {"name": "Soft Drink", "quantity": 1, "price": 2.99},
      ],
    },
    {
      "id": "template3",
      "name": "Team Meeting Order",
      "description": "Perfect for office meetings and group discussions",
      "category": "Team Orders",
      "restaurant": "Pizza Corner",
      "restaurantImage": "https://picsum.photos/80/80?random=3&keyword=pizza",
      "image": "https://picsum.photos/120/120?random=3&keyword=meeting",
      "totalPrice": 65.00,
      "estimatedTime": "35-40 mins",
      "itemCount": 6,
      "rating": 4.7,
      "usageCount": 5,
      "lastUsed": "2024-01-10",
      "isQuickOrder": false,
      "tags": ["Sharing", "Meeting", "Value"],
      "items": [
        {"name": "Large Margherita Pizza", "quantity": 2, "price": 18.99},
        {"name": "Caesar Salad", "quantity": 2, "price": 8.50},
        {"name": "Garlic Bread", "quantity": 2, "price": 5.00},
      ],
    },
    {
      "id": "template4",
      "name": "Family Dinner Night",
      "description": "Delicious dinner for the whole family",
      "category": "Family Dinner",
      "restaurant": "Pasta House",
      "restaurantImage": "https://picsum.photos/80/80?random=4&keyword=pasta",
      "image": "https://picsum.photos/120/120?random=4&keyword=family",
      "totalPrice": 45.75,
      "estimatedTime": "30-35 mins",
      "itemCount": 4,
      "rating": 4.9,
      "usageCount": 15,
      "lastUsed": "2024-01-12",
      "isQuickOrder": true,
      "tags": ["Family", "Dinner", "Italian"],
      "items": [
        {"name": "Spaghetti Carbonara", "quantity": 2, "price": 14.99},
        {"name": "Chicken Parmesan", "quantity": 1, "price": 16.99},
        {"name": "Tiramisu", "quantity": 1, "price": 6.99},
      ],
    },
    {
      "id": "template5",
      "name": "Healthy Power Bowl",
      "description": "Nutritious and energizing meal",
      "category": "Quick Meals",
      "restaurant": "Green Bowl",
      "restaurantImage": "https://picsum.photos/80/80?random=5&keyword=salad",
      "image": "https://picsum.photos/120/120?random=5&keyword=healthy",
      "totalPrice": 16.25,
      "estimatedTime": "20-25 mins",
      "itemCount": 2,
      "rating": 4.6,
      "usageCount": 7,
      "lastUsed": "2024-01-11",
      "isQuickOrder": true,
      "tags": ["Healthy", "Vegan", "Fresh"],
      "items": [
        {"name": "Quinoa Power Bowl", "quantity": 1, "price": 12.99},
        {"name": "Green Smoothie", "quantity": 1, "price": 3.25},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    List<Map<String, dynamic>> filtered = templates;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((template) => template["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((template) =>
        (template["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (template["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (template["restaurant"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Templates",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Templates", icon: Icon(Icons.bookmark)),
        Tab(text: "Quick Order", icon: Icon(Icons.flash_on)),
        Tab(text: "Create New", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildMyTemplatesTab(),
        _buildQuickOrderTab(),
        _buildCreateTemplateTab(),
      ],
    );
  }

  Widget _buildMyTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
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
                  label: "Search Templates",
                  value: searchQuery,
                  hint: "Search by name, restaurant, or description",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Filter by Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Templates Grid
          if (filteredTemplates.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 60,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Templates Found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or create a new template",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: disabledColor),
                  ),
                ],
              ),
            )
          else
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 300,
              children: filteredTemplates.map((template) => _buildTemplateCard(template)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Template Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Container(
              height: 120,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    "${template["image"]}",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 12, color: warningColor),
                          SizedBox(width: 2),
                          Text(
                            "${template["rating"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (template["isQuickOrder"])
                    Positioned(
                      top: spXs,
                      left: spXs,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.flash_on, size: 12, color: Colors.white),
                            SizedBox(width: 2),
                            Text(
                              "Quick",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Template Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${template["description"]}",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Restaurant Info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${template["restaurantImage"]}",
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${template["restaurant"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                // Tags
                QHorizontalScroll(
                  children: (template["tags"] as List).map((tag) => 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ).toList(),
                ),

                // Stats
                Row(
                  children: [
                    Icon(Icons.restaurant_menu, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${template["itemCount"]} items",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    SizedBox(width: spXs),
                    Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${template["estimatedTime"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ],
                ),

                // Usage Stats
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.replay, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "Used ${template["usageCount"]} times",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Text(
                        "Last: ${template["lastUsed"]}",
                        style: TextStyle(fontSize: 10, color: disabledColor),
                      ),
                    ],
                  ),
                ),

                // Price and Actions
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "\$${((template["totalPrice"] as double).toStringAsFixed(2))}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showTemplateOptions(template);
                      },
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Order Now",
                        size: bs.sm,
                        onPressed: () {
                          _orderFromTemplate(template);
                        },
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          _editTemplate(template);
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
    );
  }

  Widget _buildQuickOrderTab() {
    List<Map<String, dynamic>> quickTemplates = templates
        .where((template) => template["isQuickOrder"] == true)
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Order Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: Colors.white, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Order Templates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "One-tap ordering for your favorite meals",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Templates List
          ...quickTemplates.map((template) => _buildQuickOrderCard(template)).toList(),

          // Add Quick Order Template
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: primaryColor.withAlpha(50),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.add_circle_outline, size: 40, color: primaryColor),
                SizedBox(height: spXs),
                Text(
                  "Create Quick Order Template",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Convert any template to quick order",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Browse Templates",
                  size: bs.sm,
                  onPressed: () {
                    selectedTab = 0;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOrderCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${template["image"]}",
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
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${template["restaurant"]} • ${template["estimatedTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                Text(
                  "\$${((template["totalPrice"] as double).toStringAsFixed(2))}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.flash_on,
            size: bs.sm,
            onPressed: () {
              _quickOrder(template);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTemplateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create Template Options
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
                  "Create New Template",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Save your favorite orders as templates for quick reordering",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Template Creation Options
          _buildCreateOption(
            "From Current Cart",
            "Save items currently in your cart as template",
            Icons.shopping_cart,
            primaryColor,
            () {
              ss("Creating template from cart...");
            },
          ),

          _buildCreateOption(
            "From Order History",
            "Convert a previous order into a template",
            Icons.history,
            infoColor,
            () {
              // navigateTo('OrderHistoryView')
            },
          ),

          _buildCreateOption(
            "Start from Scratch",
            "Browse restaurants and build custom template",
            Icons.restaurant_menu,
            successColor,
            () {
              // navigateTo('RestaurantListView')
            },
          ),

          _buildCreateOption(
            "Team Template",
            "Create template for team or group orders",
            Icons.group,
            warningColor,
            () {
              _showTeamTemplateDialog();
            },
          ),

          // Template Tips
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
                    Icon(Icons.lightbulb_outline, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "Template Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ...[
                  "Templates save time on repeated orders",
                  "You can customize templates before ordering",
                  "Share team templates with colleagues",
                  "Quick order templates enable one-tap ordering",
                ].map((tip) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ", style: TextStyle(color: primaryColor)),
                    Expanded(
                      child: Text(
                        tip,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateOption(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: color.withAlpha(50),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: disabledColor),
          ],
        ),
      ),
    );
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    // Show bottom sheet with template options
    ss("Template options for ${template["name"]}");
  }

  void _orderFromTemplate(Map<String, dynamic> template) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Adding template items to cart...");
  }

  void _editTemplate(Map<String, dynamic> template) {
    ss("Editing template: ${template["name"]}");
  }

  void _quickOrder(Map<String, dynamic> template) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Quick order placed successfully!");
  }

  void _showTeamTemplateDialog() {
    ss("Team template creation coming soon!");
  }
}

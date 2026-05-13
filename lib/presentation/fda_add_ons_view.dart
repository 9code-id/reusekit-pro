import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAddOnsView extends StatefulWidget {
  const FdaAddOnsView({super.key});

  @override
  State<FdaAddOnsView> createState() => _FdaAddOnsViewState();
}

class _FdaAddOnsViewState extends State<FdaAddOnsView> {
  List<String> selectedAddOns = [];
  
  List<Map<String, dynamic>> addOnCategories = [
    {
      "title": "Beverages",
      "icon": Icons.local_drink,
      "items": [
        {
          "id": "coke",
          "name": "Coca-Cola",
          "description": "Classic refreshing cola drink",
          "price": 2.50,
          "image": "https://picsum.photos/60/60?random=1&keyword=cola",
          "popular": true,
        },
        {
          "id": "sprite",
          "name": "Sprite",
          "description": "Lemon-lime flavored soda",
          "price": 2.50,
          "image": "https://picsum.photos/60/60?random=2&keyword=sprite",
          "popular": false,
        },
        {
          "id": "orange_juice",
          "name": "Fresh Orange Juice",
          "description": "100% natural orange juice",
          "price": 3.50,
          "image": "https://picsum.photos/60/60?random=3&keyword=orange",
          "popular": true,
        },
        {
          "id": "water",
          "name": "Mineral Water",
          "description": "Premium bottled water",
          "price": 1.50,
          "image": "https://picsum.photos/60/60?random=4&keyword=water",
          "popular": false,
        },
      ],
    },
    {
      "title": "Sides & Appetizers",
      "icon": Icons.food_bank,
      "items": [
        {
          "id": "garlic_bread",
          "name": "Garlic Bread",
          "description": "Crispy bread with garlic butter",
          "price": 4.99,
          "image": "https://picsum.photos/60/60?random=5&keyword=bread",
          "popular": true,
        },
        {
          "id": "chicken_wings",
          "name": "Buffalo Wings (6pcs)",
          "description": "Spicy chicken wings with blue cheese",
          "price": 8.99,
          "image": "https://picsum.photos/60/60?random=6&keyword=wings",
          "popular": true,
        },
        {
          "id": "onion_rings",
          "name": "Onion Rings",
          "description": "Crispy battered onion rings",
          "price": 5.99,
          "image": "https://picsum.photos/60/60?random=7&keyword=onion",
          "popular": false,
        },
        {
          "id": "mozzarella_sticks",
          "name": "Mozzarella Sticks (4pcs)",
          "description": "Fried cheese sticks with marinara",
          "price": 6.99,
          "image": "https://picsum.photos/60/60?random=8&keyword=cheese",
          "popular": true,
        },
      ],
    },
    {
      "title": "Desserts",
      "icon": Icons.cake,
      "items": [
        {
          "id": "tiramisu",
          "name": "Tiramisu",
          "description": "Classic Italian coffee-flavored dessert",
          "price": 5.99,
          "image": "https://picsum.photos/60/60?random=9&keyword=tiramisu",
          "popular": true,
        },
        {
          "id": "ice_cream",
          "name": "Vanilla Ice Cream",
          "description": "Premium vanilla ice cream (2 scoops)",
          "price": 3.99,
          "image": "https://picsum.photos/60/60?random=10&keyword=icecream",
          "popular": false,
        },
        {
          "id": "chocolate_cake",
          "name": "Chocolate Cake",
          "description": "Rich chocolate cake slice",
          "price": 4.99,
          "image": "https://picsum.photos/60/60?random=11&keyword=chocolate",
          "popular": true,
        },
        {
          "id": "cannoli",
          "name": "Sicilian Cannoli (2pcs)",
          "description": "Traditional Italian pastry with ricotta",
          "price": 6.99,
          "image": "https://picsum.photos/60/60?random=12&keyword=cannoli",
          "popular": false,
        },
      ],
    },
    {
      "title": "Extras",
      "icon": Icons.add_circle,
      "items": [
        {
          "id": "extra_sauce",
          "name": "Extra Marinara Sauce",
          "description": "Additional portion of house marinara",
          "price": 0.99,
          "image": "https://picsum.photos/60/60?random=13&keyword=sauce",
          "popular": false,
        },
        {
          "id": "parmesan",
          "name": "Grated Parmesan",
          "description": "Fresh grated parmesan cheese",
          "price": 1.50,
          "image": "https://picsum.photos/60/60?random=14&keyword=parmesan",
          "popular": true,
        },
        {
          "id": "chili_flakes",
          "name": "Chili Flakes",
          "description": "Spicy red pepper flakes",
          "price": 0.50,
          "image": "https://picsum.photos/60/60?random=15&keyword=chili",
          "popular": false,
        },
        {
          "id": "napkins",
          "name": "Extra Napkins",
          "description": "Additional napkins and utensils",
          "price": 0.00,
          "image": "https://picsum.photos/60/60?random=16&keyword=napkin",
          "popular": false,
        },
      ],
    },
  ];

  String selectedCategory = "All";
  bool showPopularOnly = false;

  List<String> get categories {
    List<String> cats = ["All"];
    cats.addAll(addOnCategories.map((cat) => cat["title"] as String));
    return cats;
  }

  List<Map<String, dynamic>> get filteredAddOns {
    List<Map<String, dynamic>> allItems = [];
    
    for (var category in addOnCategories) {
      if (selectedCategory == "All" || category["title"] == selectedCategory) {
        List<Map<String, dynamic>> items = 
            (category["items"] as List).cast<Map<String, dynamic>>();
        
        for (var item in items) {
          if (!showPopularOnly || (item["popular"] as bool)) {
            allItems.add({
              ...item,
              "category": category["title"],
              "categoryIcon": category["icon"],
            });
          }
        }
      }
    }
    
    return allItems;
  }

  double get totalAddOnPrice {
    double total = 0;
    for (String addOnId in selectedAddOns) {
      for (var category in addOnCategories) {
        List<Map<String, dynamic>> items = 
            (category["items"] as List).cast<Map<String, dynamic>>();
        var item = items.firstWhere(
          (item) => item["id"] == addOnId,
          orElse: () => {},
        );
        if (item.isNotEmpty) {
          total += (item["price"] as num).toDouble();
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add-Ons"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showAddOnInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Order Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "https://picsum.photos/60/60?random=pizza&keyword=pizza",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Margherita Pizza (Large)",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Base Price: \$18.99",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Filter Section
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Choose Add-Ons (${selectedAddOns.length} selected)",
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
                          color: showPopularOnly ? warningColor.withAlpha(20) : secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: showPopularOnly ? warningColor : secondaryColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              showPopularOnly ? Icons.star : Icons.apps,
                              color: showPopularOnly ? warningColor : secondaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              showPopularOnly ? "Popular" : "All Items",
                              style: TextStyle(
                                fontSize: 12,
                                color: showPopularOnly ? warningColor : secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Category Filter
                  QCategoryPicker(
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Popular Filter Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show popular items only",
                              "value": true,
                              "checked": showPopularOnly,
                            }
                          ],
                          value: [
                            if (showPopularOnly)
                              {
                                "label": "Show popular items only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showPopularOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Add-Ons Grid
                  if (filteredAddOns.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No add-ons found",
                            style: TextStyle(
                              fontSize: fsH6,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredAddOns.map((addOn) {
                        bool isSelected = selectedAddOns.contains(addOn["id"]);
                        
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image and Popular Badge
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                      topRight: Radius.circular(radiusMd),
                                    ),
                                    child: Image.network(
                                      "${addOn["image"]}",
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (addOn["popular"] as bool) ...[
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "Popular",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  Positioned(
                                    top: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        addOn["categoryIcon"] as IconData,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Content
                              Padding(
                                padding: EdgeInsets.all(spMd),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${addOn["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${addOn["description"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${addOn["category"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          (addOn["price"] as num) > 0 
                                              ? "\$${(addOn["price"] as num).toStringAsFixed(2)}"
                                              : "FREE",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: (addOn["price"] as num) > 0 
                                                ? primaryColor 
                                                : successColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: spMd),

                                    // Add Button
                                    Container(
                                      width: double.infinity,
                                      child: QButton(
                                        label: isSelected ? "Remove" : "Add",
                                        size: bs.sm,
                                        onPressed: () {
                                          _toggleAddOn(addOn["id"]);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          if (selectedAddOns.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedAddOns.length} Add-ons Selected",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Total: \$${totalAddOnPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Continue",
                        size: bs.md,
                        onPressed: () {
                          _proceedWithAddOns();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _toggleAddOn(String addOnId) {
    if (selectedAddOns.contains(addOnId)) {
      selectedAddOns.remove(addOnId);
    } else {
      selectedAddOns.add(addOnId);
    }
    setState(() {});
  }

  void _proceedWithAddOns() {
    if (selectedAddOns.isEmpty) {
      sw("Please select at least one add-on");
      return;
    }
    
    ss("Add-ons selected successfully!");
    back();
  }

  void _showAddOnInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add-Ons Guide"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Select items to enhance your order"),
            Text("• Popular items are marked with a star"),
            Text("• Filter by category for easier browsing"),
            Text("• Free items don't add to your total"),
            Text("• You can add multiple items"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}

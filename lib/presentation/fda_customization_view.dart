import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCustomizationView extends StatefulWidget {
  const FdaCustomizationView({super.key});

  @override
  State<FdaCustomizationView> createState() => _FdaCustomizationViewState();
}

class _FdaCustomizationViewState extends State<FdaCustomizationView> {
  Map<String, dynamic> selectedOptions = {};
  String specialInstructions = "";
  
  List<Map<String, dynamic>> customizationCategories = [
    {
      "id": "size",
      "title": "Size",
      "type": "single",
      "required": true,
      "options": [
        {
          "id": "small",
          "name": "Small (8\")",
          "price": 0,
          "description": "Perfect for 1 person",
        },
        {
          "id": "medium",
          "name": "Medium (10\")",
          "price": 3.00,
          "description": "Good for 2-3 people",
        },
        {
          "id": "large",
          "name": "Large (12\")",
          "price": 6.00,
          "description": "Great for 3-4 people",
        },
      ],
    },
    {
      "id": "crust",
      "title": "Crust Type",
      "type": "single",
      "required": true,
      "options": [
        {
          "id": "thin",
          "name": "Thin Crust",
          "price": 0,
          "description": "Crispy and light",
        },
        {
          "id": "thick",
          "name": "Thick Crust",
          "price": 1.50,
          "description": "Soft and fluffy",
        },
        {
          "id": "stuffed",
          "name": "Cheese Stuffed",
          "price": 3.00,
          "description": "Filled with mozzarella",
        },
      ],
    },
    {
      "id": "toppings",
      "title": "Extra Toppings",
      "type": "multiple",
      "required": false,
      "options": [
        {
          "id": "pepperoni",
          "name": "Pepperoni",
          "price": 2.50,
          "description": "Spicy Italian sausage",
        },
        {
          "id": "mushrooms",
          "name": "Mushrooms",
          "price": 1.50,
          "description": "Fresh button mushrooms",
        },
        {
          "id": "olives",
          "name": "Black Olives",
          "price": 1.00,
          "description": "Mediterranean black olives",
        },
        {
          "id": "peppers",
          "name": "Bell Peppers",
          "price": 1.50,
          "description": "Colorful bell peppers",
        },
        {
          "id": "onions",
          "name": "Red Onions",
          "price": 1.00,
          "description": "Sweet red onions",
        },
        {
          "id": "cheese",
          "name": "Extra Cheese",
          "price": 2.00,
          "description": "Double mozzarella",
        },
      ],
    },
    {
      "id": "spice",
      "title": "Spice Level",
      "type": "single",
      "required": false,
      "options": [
        {
          "id": "mild",
          "name": "Mild",
          "price": 0,
          "description": "No heat",
        },
        {
          "id": "medium",
          "name": "Medium",
          "price": 0,
          "description": "Slight heat",
        },
        {
          "id": "hot",
          "name": "Hot",
          "price": 0,
          "description": "Spicy kick",
        },
        {
          "id": "extra_hot",
          "name": "Extra Hot",
          "price": 0.50,
          "description": "Very spicy",
        },
      ],
    },
  ];

  double basePrice = 12.99;

  @override
  void initState() {
    super.initState();
    // Set default selections for required options
    selectedOptions["size"] = "small";
    selectedOptions["crust"] = "thin";
    selectedOptions["toppings"] = <String>[];
  }

  double get totalPrice {
    double total = basePrice;
    
    for (var category in customizationCategories) {
      String categoryId = category["id"];
      List<Map<String, dynamic>> options = 
          (category["options"] as List).cast<Map<String, dynamic>>();
      
      if (category["type"] == "single") {
        String? selectedId = selectedOptions[categoryId];
        if (selectedId != null) {
          var option = options.firstWhere((opt) => opt["id"] == selectedId);
          total += (option["price"] as num).toDouble();
        }
      } else if (category["type"] == "multiple") {
        List<String> selectedIds = 
            (selectedOptions[categoryId] as List<String>?) ?? [];
        for (String id in selectedIds) {
          var option = options.firstWhere((opt) => opt["id"] == id);
          total += (option["price"] as num).toDouble();
        }
      }
    }
    
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customize Your Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showCustomizationInfo();
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
                  // Food Item Header
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
                            "https://picsum.photos/80/80?random=pizza&keyword=pizza",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Margherita Pizza",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Classic Italian pizza with fresh tomatoes, mozzarella, and basil",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Base Price: \$${basePrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Customization Categories
                  ...customizationCategories.map((category) {
                    return _buildCategorySection(category);
                  }).toList(),

                  SizedBox(height: spLg),

                  // Special Instructions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Instructions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QMemoField(
                        label: "Additional requests",
                        value: specialInstructions,
                        hint: "Any special requests for your order?",
                        onChanged: (value) {
                          specialInstructions = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Order Summary
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        _buildSummaryItem("Base Price", basePrice),
                        ..._buildCustomizationSummary(),
                        Divider(color: successColor.withAlpha(50)),
                        _buildSummaryItem("Total", totalPrice, isTotal: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
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
                      child: Text(
                        "Total: \$${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Add to Cart",
                      size: bs.md,
                      onPressed: _canAddToCart() ? () {
                        _addToCart();
                      } : null,
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

  Widget _buildCategorySection(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${category["title"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (category["required"] as bool) ...[
                SizedBox(width: spXs),
                Text(
                  "*",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: dangerColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          
          ...(category["options"] as List).map<Widget>((option) {
            return _buildOptionCard(category, option);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOptionCard(Map<String, dynamic> category, Map<String, dynamic> option) {
    String categoryId = category["id"];
    String optionId = option["id"];
    bool isSelected = false;
    
    if (category["type"] == "single") {
      isSelected = selectedOptions[categoryId] == optionId;
    } else {
      List<String> selectedIds = 
          (selectedOptions[categoryId] as List<String>?) ?? [];
      isSelected = selectedIds.contains(optionId);
    }

    return GestureDetector(
      onTap: () {
        _selectOption(category, option);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: category["type"] == "single" 
                    ? BoxShape.circle 
                    : BoxShape.rectangle,
                borderRadius: category["type"] == "single" 
                    ? null 
                    : BorderRadius.circular(radiusXs),
                color: isSelected ? primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? primaryColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      category["type"] == "single" 
                          ? Icons.radio_button_checked 
                          : Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${option["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                      ),
                      if ((option["price"] as num) > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : secondaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+\$${(option["price"] as num).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (option.containsKey("description")) ...[
                    SizedBox(height: spXs),
                    Text(
                      "${option["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double price, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? successColor : primaryColor,
            ),
          ),
          Text(
            "\$${price.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? successColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCustomizationSummary() {
    List<Widget> items = [];
    
    for (var category in customizationCategories) {
      String categoryId = category["id"];
      List<Map<String, dynamic>> options = 
          (category["options"] as List).cast<Map<String, dynamic>>();
      
      if (category["type"] == "single") {
        String? selectedId = selectedOptions[categoryId];
        if (selectedId != null) {
          var option = options.firstWhere((opt) => opt["id"] == selectedId);
          if ((option["price"] as num) > 0) {
            items.add(_buildSummaryItem(
              "${option["name"]}",
              (option["price"] as num).toDouble(),
            ));
          }
        }
      } else if (category["type"] == "multiple") {
        List<String> selectedIds = 
            (selectedOptions[categoryId] as List<String>?) ?? [];
        for (String id in selectedIds) {
          var option = options.firstWhere((opt) => opt["id"] == id);
          items.add(_buildSummaryItem(
            "${option["name"]}",
            (option["price"] as num).toDouble(),
          ));
        }
      }
    }
    
    return items;
  }

  void _selectOption(Map<String, dynamic> category, Map<String, dynamic> option) {
    String categoryId = category["id"];
    String optionId = option["id"];
    
    if (category["type"] == "single") {
      selectedOptions[categoryId] = optionId;
    } else {
      List<String> selectedIds = 
          (selectedOptions[categoryId] as List<String>?) ?? [];
      
      if (selectedIds.contains(optionId)) {
        selectedIds.remove(optionId);
      } else {
        selectedIds.add(optionId);
      }
      
      selectedOptions[categoryId] = selectedIds;
    }
    
    setState(() {});
  }

  bool _canAddToCart() {
    for (var category in customizationCategories) {
      if (category["required"] as bool) {
        String categoryId = category["id"];
        if (!selectedOptions.containsKey(categoryId) || 
            selectedOptions[categoryId] == null) {
          return false;
        }
      }
    }
    return true;
  }

  void _addToCart() {
    ss("Item customized and added to cart!");
    back();
  }

  void _showCustomizationInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Customization Guide"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Required options are marked with *"),
            Text("• Single choice options allow one selection"),
            Text("• Multiple choice options allow many selections"),
            Text("• Extra charges apply for premium options"),
            Text("• Special instructions are optional"),
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

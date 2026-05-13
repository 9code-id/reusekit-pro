import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaItemModifiersView extends StatefulWidget {
  const RmaItemModifiersView({super.key});

  @override
  State<RmaItemModifiersView> createState() => _RmaItemModifiersViewState();
}

class _RmaItemModifiersViewState extends State<RmaItemModifiersView> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> modifierGroups = [
    {
      "id": "size",
      "name": "Size Options",
      "description": "Choose your preferred size",
      "type": "single",
      "required": true,
      "minSelect": 1,
      "maxSelect": 1,
      "modifiers": [
        {"id": "small", "name": "Small", "price": 0.0},
        {"id": "medium", "name": "Medium", "price": 2.50},
        {"id": "large", "name": "Large", "price": 4.00},
        {"id": "xlarge", "name": "Extra Large", "price": 6.50},
      ]
    },
    {
      "id": "extras",
      "name": "Extra Toppings",
      "description": "Add extra toppings (multiple selection allowed)",
      "type": "multiple",
      "required": false,
      "minSelect": 0,
      "maxSelect": 5,
      "modifiers": [
        {"id": "cheese", "name": "Extra Cheese", "price": 1.50},
        {"id": "bacon", "name": "Bacon", "price": 2.00},
        {"id": "mushrooms", "name": "Mushrooms", "price": 1.00},
        {"id": "olives", "name": "Olives", "price": 0.75},
        {"id": "pepperoni", "name": "Pepperoni", "price": 1.75},
        {"id": "jalapeños", "name": "Jalapeños", "price": 0.50},
      ]
    },
    {
      "id": "sauce",
      "name": "Sauce Selection",
      "description": "Choose your sauce",
      "type": "single",
      "required": true,
      "minSelect": 1,
      "maxSelect": 1,
      "modifiers": [
        {"id": "ketchup", "name": "Ketchup", "price": 0.0},
        {"id": "mayo", "name": "Mayonnaise", "price": 0.0},
        {"id": "bbq", "name": "BBQ Sauce", "price": 0.25},
        {"id": "spicy", "name": "Spicy Sauce", "price": 0.25},
        {"id": "ranch", "name": "Ranch Dressing", "price": 0.50},
      ]
    },
    {
      "id": "drinks",
      "name": "Drink Options",
      "description": "Choose your beverage",
      "type": "single",
      "required": false,
      "minSelect": 0,
      "maxSelect": 1,
      "modifiers": [
        {"id": "water", "name": "Water", "price": 0.0},
        {"id": "soda", "name": "Soft Drink", "price": 2.50},
        {"id": "juice", "name": "Fresh Juice", "price": 3.50},
        {"id": "coffee", "name": "Coffee", "price": 2.25},
        {"id": "tea", "name": "Tea", "price": 1.75},
      ]
    },
    {
      "id": "sides",
      "name": "Side Dishes",
      "description": "Add side dishes to your order",
      "type": "multiple",
      "required": false,
      "minSelect": 0,
      "maxSelect": 3,
      "modifiers": [
        {"id": "fries", "name": "French Fries", "price": 3.50},
        {"id": "onion_rings", "name": "Onion Rings", "price": 4.00},
        {"id": "salad", "name": "Side Salad", "price": 4.50},
        {"id": "soup", "name": "Soup of the Day", "price": 3.25},
        {"id": "breadsticks", "name": "Garlic Breadsticks", "price": 2.75},
      ]
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Size Options", "value": "size"},
    {"label": "Extra Toppings", "value": "extras"},
    {"label": "Sauce Selection", "value": "sauce"},
    {"label": "Drink Options", "value": "drinks"},
    {"label": "Side Dishes", "value": "sides"},
  ];

  Widget _buildSearchAndFilter() {
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
          QTextField(
            label: "Search modifiers...",
            value: searchQuery,
            hint: "Search by modifier name or group",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Filter by Category",
            items: categories,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModifierGroup(Map<String, dynamic> group) {
    final modifiers = group["modifiers"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${group["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (group["required"] as bool)
                          Container(
                            margin: EdgeInsets.only(left: spSm),
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Required",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${group["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Selection: ${group["minSelect"]}-${group["maxSelect"]} • Type: ${group["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaEditModifierGroupView')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: modifiers.map((modifier) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${modifier["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if ((modifier["price"] as double) > 0)
                          Text(
                            "+\$${((modifier["price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else
                          Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaEditModifierView')
                        },
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaDeleteModifierView')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Modifier",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                //navigateTo('RmaAddModifierView')
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredGroups {
    return modifierGroups.where((group) {
      if (selectedCategory != "all" && group["id"] != selectedCategory) {
        return false;
      }
      
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final groupName = (group["name"] as String).toLowerCase();
        final modifiers = group["modifiers"] as List;
        
        if (groupName.contains(query)) return true;
        
        return modifiers.any((modifier) =>
          (modifier["name"] as String).toLowerCase().contains(query));
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Modifiers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('RmaAddModifierGroupView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('RmaModifierSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            if (filteredGroups.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No modifiers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredGroups.map((group) => _buildModifierGroup(group)),
          ],
        ),
      ),
    );
  }
}

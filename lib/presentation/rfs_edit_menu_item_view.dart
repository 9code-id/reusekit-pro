import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsEditMenuItemView extends StatefulWidget {
  const RfsEditMenuItemView({super.key});

  @override
  State<RfsEditMenuItemView> createState() => _RfsEditMenuItemViewState();
}

class _RfsEditMenuItemViewState extends State<RfsEditMenuItemView> {
  final formKey = GlobalKey<FormState>();
  
  // Mock existing data - would come from route parameters or API
  Map<String, dynamic> existingItem = {
    "id": "MI001",
    "name": "Grilled Salmon with Herbs",
    "description": "Fresh Atlantic salmon grilled to perfection, seasoned with aromatic herbs and served with lemon butter sauce. Accompanied by roasted vegetables and wild rice pilaf.",
    "price": 28.99,
    "cost": 12.50,
    "category": "Main Course",
    "subcategory": "Seafood",
    "preparationTime": 25,
    "servingSize": "1 portion",
    "spiceLevel": "Mild",
    "chef": "Marcus Thompson",
    "kitchenStation": "Grill Station",
    "isVegetarian": false,
    "isVegan": false,
    "isGlutenFree": false,
    "isAvailable": true,
    "images": [
      "https://picsum.photos/400/300?random=1&keyword=salmon",
      "https://picsum.photos/400/300?random=2&keyword=grilled-fish",
    ],
    "ingredients": "Fresh Atlantic Salmon (200g), Mixed herbs (rosemary, thyme, dill), Lemon butter sauce, Roasted seasonal vegetables, Wild rice pilaf, Olive oil, Sea salt, Black pepper",
    "allergens": "Fish, Dairy, Gluten",
    "nutritionalInfo": {
      "calories": 485,
      "protein": 42,
      "carbs": 28,
      "fat": 22,
      "fiber": 4,
      "sodium": 680
    }
  };
  
  String itemName = "";
  String description = "";
  String price = "";
  String cost = "";
  String category = "";
  String subcategory = "";
  String preparationTime = "";
  String servingSize = "";
  String spiceLevel = "Mild";
  String chef = "";
  String kitchenStation = "";
  
  bool isVegetarian = false;
  bool isVegan = false;
  bool isGlutenFree = false;
  bool isAvailable = true;
  
  List<String> productImages = [];
  String ingredients = "";
  String allergens = "";
  
  String calories = "";
  String protein = "";
  String carbs = "";
  String fat = "";
  String fiber = "";
  String sodium = "";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Appetizers", "value": "Appetizers"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Salads", "value": "Salads"},
    {"label": "Soups", "value": "Soups"},
  ];

  List<Map<String, dynamic>> subcategoryItems = [
    {"label": "Seafood", "value": "Seafood"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Pasta", "value": "Pasta"},
    {"label": "Pizza", "value": "Pizza"},
    {"label": "Asian", "value": "Asian"},
  ];

  List<Map<String, dynamic>> spiceLevelItems = [
    {"label": "Mild", "value": "Mild"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Hot", "value": "Hot"},
    {"label": "Extra Hot", "value": "Extra Hot"},
  ];

  List<Map<String, dynamic>> chefItems = [
    {"label": "Marcus Thompson", "value": "Marcus Thompson"},
    {"label": "Sarah Chen", "value": "Sarah Chen"},
    {"label": "Roberto Martinez", "value": "Roberto Martinez"},
    {"label": "Emily Johnson", "value": "Emily Johnson"},
    {"label": "David Kim", "value": "David Kim"},
  ];

  List<Map<String, dynamic>> stationItems = [
    {"label": "Grill Station", "value": "Grill Station"},
    {"label": "Sauté Station", "value": "Sauté Station"},
    {"label": "Cold Station", "value": "Cold Station"},
    {"label": "Pastry Station", "value": "Pastry Station"},
    {"label": "Fry Station", "value": "Fry Station"},
    {"label": "Pizza Station", "value": "Pizza Station"},
  ];

  bool loading = false;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    itemName = "${existingItem["name"]}";
    description = "${existingItem["description"]}";
    price = "${existingItem["price"]}";
    cost = "${existingItem["cost"]}";
    category = "${existingItem["category"]}";
    subcategory = "${existingItem["subcategory"]}";
    preparationTime = "${existingItem["preparationTime"]}";
    servingSize = "${existingItem["servingSize"]}";
    spiceLevel = "${existingItem["spiceLevel"]}";
    chef = "${existingItem["chef"]}";
    kitchenStation = "${existingItem["kitchenStation"]}";
    
    isVegetarian = existingItem["isVegetarian"] as bool;
    isVegan = existingItem["isVegan"] as bool;
    isGlutenFree = existingItem["isGlutenFree"] as bool;
    isAvailable = existingItem["isAvailable"] as bool;
    
    productImages = List<String>.from(existingItem["images"] as List);
    ingredients = "${existingItem["ingredients"]}";
    allergens = "${existingItem["allergens"]}";
    
    final nutrition = existingItem["nutritionalInfo"] as Map<String, dynamic>;
    calories = "${nutrition["calories"]}";
    protein = "${nutrition["protein"]}";
    carbs = "${nutrition["carbs"]}";
    fat = "${nutrition["fat"]}";
    fiber = "${nutrition["fiber"]}";
    sodium = "${nutrition["sodium"]}";
    
    setState(() {});
  }

  void _markAsChanged() {
    if (!hasChanges) {
      hasChanges = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Menu Item"),
        actions: [
          if (hasChanges)
            Container(
              margin: EdgeInsets.only(right: spXs),
              child: QButton(
                label: "Save",
                size: bs.sm,
                onPressed: () => _saveChanges(),
              ),
            ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            color: disabledBoldColor,
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: loading 
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    // Status Banner
                    if (hasChanges)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: warningColor.withAlpha(51),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "You have unsaved changes",
                                style: TextStyle(
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Save Now",
                              size: bs.sm,
                              color: warningColor,
                              onPressed: () => _saveChanges(),
                            ),
                          ],
                        ),
                      ),

                    // Basic Information
                    _buildSection(
                      "Basic Information",
                      [
                        QTextField(
                          label: "Item Name",
                          value: itemName,
                          hint: "Enter menu item name",
                          validator: Validator.required,
                          onChanged: (value) {
                            itemName = value;
                            _markAsChanged();
                          },
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Category",
                                items: categoryItems,
                                value: category,
                                onChanged: (value, label) {
                                  category = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Subcategory",
                                items: subcategoryItems,
                                value: subcategory,
                                onChanged: (value, label) {
                                  subcategory = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QNumberField(
                                label: "Preparation Time (min)",
                                value: preparationTime,
                                hint: "Minutes",
                                onChanged: (value) {
                                  preparationTime = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Serving Size",
                                value: servingSize,
                                hint: "e.g., 1 portion",
                                onChanged: (value) {
                                  servingSize = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        QDropdownField(
                          label: "Spice Level",
                          items: spiceLevelItems,
                          value: spiceLevel,
                          onChanged: (value, label) {
                            spiceLevel = value;
                            _markAsChanged();
                          },
                        ),
                      ],
                    ),

                    // Pricing & Kitchen
                    _buildSection(
                      "Pricing & Kitchen",
                      [
                        Row(
                          children: [
                            Expanded(
                              child: QNumberField(
                                label: "Selling Price (\$)",
                                value: price,
                                hint: "0.00",
                                validator: Validator.required,
                                onChanged: (value) {
                                  price = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QNumberField(
                                label: "Cost (\$)",
                                value: cost,
                                hint: "0.00",
                                validator: Validator.required,
                                onChanged: (value) {
                                  cost = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        // Profit Margin Display
                        if (price.isNotEmpty && cost.isNotEmpty) ...[
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: successColor.withAlpha(51),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Current Profit Margin:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${_calculateProfitMargin()}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Assigned Chef",
                                items: chefItems,
                                value: chef,
                                onChanged: (value, label) {
                                  chef = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Kitchen Station",
                                items: stationItems,
                                value: kitchenStation,
                                onChanged: (value, label) {
                                  kitchenStation = value;
                                  _markAsChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        QSwitch(
                          label: "Item Availability",
                          items: [
                            {
                              "label": "Available for orders",
                              "value": true,
                              "checked": isAvailable,
                            }
                          ],
                          value: [
                            if (isAvailable)
                              {
                                "label": "Available for orders",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isAvailable = values.isNotEmpty;
                            _markAsChanged();
                          },
                        ),
                      ],
                    ),

                    // Images & Description
                    _buildSection(
                      "Images & Description",
                      [
                        QMultiImagePicker(
                          label: "Product Images",
                          value: productImages,
                          maxImages: 5,
                          hint: "Add up to 5 high-quality images",
                          helper: "First image will be used as the main display image",
                          onChanged: (value) {
                            productImages = value;
                            _markAsChanged();
                          },
                        ),
                        
                        QMemoField(
                          label: "Description",
                          value: description,
                          hint: "Detailed description of the menu item...",
                          validator: Validator.required,
                          onChanged: (value) {
                            description = value;
                            _markAsChanged();
                          },
                        ),
                        
                        QMemoField(
                          label: "Ingredients",
                          value: ingredients,
                          hint: "List all ingredients, separated by commas",
                          onChanged: (value) {
                            ingredients = value;
                            _markAsChanged();
                          },
                        ),
                      ],
                    ),

                    // Dietary & Nutrition
                    _buildSection(
                      "Dietary & Nutrition",
                      [
                        QSwitch(
                          label: "Dietary Preferences",
                          items: [
                            {
                              "label": "Vegetarian",
                              "value": "vegetarian",
                              "checked": isVegetarian,
                            },
                            {
                              "label": "Vegan", 
                              "value": "vegan",
                              "checked": isVegan,
                            },
                            {
                              "label": "Gluten Free",
                              "value": "glutenFree",
                              "checked": isGlutenFree,
                            }
                          ],
                          value: [
                            if (isVegetarian) {"label": "Vegetarian", "value": "vegetarian", "checked": true},
                            if (isVegan) {"label": "Vegan", "value": "vegan", "checked": true},
                            if (isGlutenFree) {"label": "Gluten Free", "value": "glutenFree", "checked": true},
                          ],
                          onChanged: (values, ids) {
                            isVegetarian = ids.contains("vegetarian");
                            isVegan = ids.contains("vegan"); 
                            isGlutenFree = ids.contains("glutenFree");
                            _markAsChanged();
                          },
                        ),
                        
                        QTextField(
                          label: "Allergens",
                          value: allergens,
                          hint: "List allergens, separated by commas (e.g., Nuts, Dairy, Eggs)",
                          onChanged: (value) {
                            allergens = value;
                            _markAsChanged();
                          },
                        ),
                        
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Nutritional Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 150,
                          children: [
                            QNumberField(
                              label: "Calories",
                              value: calories,
                              hint: "kcal",
                              onChanged: (value) {
                                calories = value;
                                _markAsChanged();
                              },
                            ),
                            QNumberField(
                              label: "Protein",
                              value: protein,
                              hint: "grams",
                              onChanged: (value) {
                                protein = value;
                                _markAsChanged();
                              },
                            ),
                            QNumberField(
                              label: "Carbs",
                              value: carbs,
                              hint: "grams",
                              onChanged: (value) {
                                carbs = value;
                                _markAsChanged();
                              },
                            ),
                            QNumberField(
                              label: "Fat",
                              value: fat,
                              hint: "grams",
                              onChanged: (value) {
                                fat = value;
                                _markAsChanged();
                              },
                            ),
                            QNumberField(
                              label: "Fiber",
                              value: fiber,
                              hint: "grams",
                              onChanged: (value) {
                                fiber = value;
                                _markAsChanged();
                              },
                            ),
                            QNumberField(
                              label: "Sodium",
                              value: sodium,
                              hint: "mg",
                              onChanged: (value) {
                                sodium = value;
                                _markAsChanged();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: hasChanges ? "Save Changes" : "No Changes",
                            size: bs.md,
                            icon: hasChanges ? Icons.save : Icons.check,
                            color: hasChanges ? primaryColor : successColor,
                            onPressed: hasChanges ? () => _saveChanges() : null,
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.restore,
                          size: bs.md,
                          color: dangerColor,
                          onPressed: hasChanges ? () => _discardChanges() : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: children,
          ),
        ],
      ),
    );
  }

  String _calculateProfitMargin() {
    if (price.isEmpty || cost.isEmpty) return "0.0";
    
    double priceValue = double.tryParse(price) ?? 0;
    double costValue = double.tryParse(cost) ?? 0;
    
    if (priceValue == 0) return "0.0";
    
    double margin = ((priceValue - costValue) / priceValue) * 100;
    return margin.toStringAsFixed(1);
  }

  void _saveChanges() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }
    
    if (itemName.isEmpty) {
      se("Item name is required");
      return;
    }
    
    if (price.isEmpty || cost.isEmpty) {
      se("Price and cost are required");
      return;
    }
    
    if (description.isEmpty) {
      se("Description is required");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    hasChanges = false;
    setState(() {});
    
    ss("Menu item updated successfully!");
  }

  void _discardChanges() async {
    bool isConfirmed = await confirm("Are you sure you want to discard all changes?");
    if (isConfirmed) {
      _loadExistingData();
      hasChanges = false;
      setState(() {});
      si("Changes discarded");
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              ListTile(
                leading: Icon(Icons.copy, color: primaryColor),
                title: Text("Duplicate Item"),
                subtitle: Text("Create a copy of this menu item"),
                onTap: () {
                  back();
                  ss("Item duplicated successfully");
                },
              ),
              
              ListTile(
                leading: Icon(Icons.analytics, color: infoColor),
                title: Text("View Analytics"),
                subtitle: Text("Sales performance and trends"),
                onTap: () {
                  back();
                  si("Analytics feature coming soon");
                },
              ),
              
              ListTile(
                leading: Icon(Icons.history, color: warningColor),
                title: Text("View History"),
                subtitle: Text("Previous edits and changes"),
                onTap: () {
                  back();
                  si("History feature coming soon");
                },
              ),
              
              ListTile(
                leading: Icon(
                  isAvailable ? Icons.visibility_off : Icons.visibility,
                  color: isAvailable ? warningColor : successColor,
                ),
                title: Text(isAvailable ? "Make Unavailable" : "Make Available"),
                subtitle: Text(
                  isAvailable 
                      ? "Hide from customer menu" 
                      : "Show in customer menu"
                ),
                onTap: () {
                  isAvailable = !isAvailable;
                  _markAsChanged();
                  back();
                  ss(isAvailable 
                      ? "Item is now available" 
                      : "Item is now unavailable");
                },
              ),
              
              Divider(),
              
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Item"),
                subtitle: Text("Permanently remove this item"),
                onTap: () async {
                  back();
                  bool isConfirmed = await confirm("Are you sure you want to delete this menu item? This action cannot be undone.");
                  if (isConfirmed) {
                    loading = true;
                    setState(() {});
                    
                    await Future.delayed(Duration(seconds: 1));
                    
                    ss("Menu item deleted successfully");
                    back();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaEditItemView extends StatefulWidget {
  const RmaEditItemView({super.key});

  @override
  State<RmaEditItemView> createState() => _RmaEditItemViewState();
}

class _RmaEditItemViewState extends State<RmaEditItemView> {
  final formKey = GlobalKey<FormState>();
  
  // Current item data (would be passed from previous screen)
  Map<String, dynamic> currentItem = {
    "id": "item_001",
    "name": "Grilled Chicken Breast",
    "description": "Tender grilled chicken breast served with seasonal vegetables and mashed potatoes",
    "category": "Main Course",
    "price": 24.99,
    "cost": 8.50,
    "images": [
      "https://picsum.photos/300/200?random=1&keyword=chicken",
      "https://picsum.photos/300/200?random=2&keyword=grilled",
    ],
    "status": "active",
    "dietary": ["Gluten-Free", "High-Protein"],
    "allergens": ["None"],
    "preparationTime": 25,
    "calories": 420,
    "protein": 35.5,
    "carbs": 12.0,
    "fat": 18.2,
    "variants": [
      {"name": "Regular", "price": 24.99},
      {"name": "Large", "price": 29.99},
    ]
  };
  
  // Form fields
  String itemName = "";
  String description = "";
  String selectedCategory = "";
  String price = "";
  String cost = "";
  List<String> itemImages = [];
  String selectedStatus = "";
  List<String> selectedDietary = [];
  List<String> selectedAllergens = [];
  String preparationTime = "";
  String calories = "";
  String protein = "";
  String carbs = "";
  String fat = "";
  List<Map<String, dynamic>> variants = [];
  
  // Form data
  List<Map<String, dynamic>> categoryItems = [
    {"label": "Appetizers", "value": "Appetizers"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Salads", "value": "Salads"},
    {"label": "Soups", "value": "Soups"},
  ];
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Out of Stock", "value": "out_of_stock"},
  ];
  
  List<Map<String, dynamic>> dietaryOptions = [
    {"label": "Vegetarian", "value": "Vegetarian", "checked": false},
    {"label": "Vegan", "value": "Vegan", "checked": false},
    {"label": "Gluten-Free", "value": "Gluten-Free", "checked": false},
    {"label": "Dairy-Free", "value": "Dairy-Free", "checked": false},
    {"label": "Keto", "value": "Keto", "checked": false},
    {"label": "Low-Carb", "value": "Low-Carb", "checked": false},
    {"label": "High-Protein", "value": "High-Protein", "checked": false},
  ];
  
  List<Map<String, dynamic>> allergenOptions = [
    {"label": "None", "value": "None", "checked": false},
    {"label": "Nuts", "value": "Nuts", "checked": false},
    {"label": "Dairy", "value": "Dairy", "checked": false},
    {"label": "Gluten", "value": "Gluten", "checked": false},
    {"label": "Eggs", "value": "Eggs", "checked": false},
    {"label": "Shellfish", "value": "Shellfish", "checked": false},
    {"label": "Soy", "value": "Soy", "checked": false},
  ];
  
  bool loading = false;
  
  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }
  
  void _initializeFormData() {
    // Populate form with current item data
    itemName = "${currentItem["name"]}";
    description = "${currentItem["description"]}";
    selectedCategory = "${currentItem["category"]}";
    price = "${currentItem["price"]}";
    cost = "${currentItem["cost"]}";
    itemImages = List<String>.from(currentItem["images"] as List);
    selectedStatus = "${currentItem["status"]}";
    preparationTime = "${currentItem["preparationTime"]}";
    calories = "${currentItem["calories"]}";
    protein = "${currentItem["protein"]}";
    carbs = "${currentItem["carbs"]}";
    fat = "${currentItem["fat"]}";
    variants = List<Map<String, dynamic>>.from(currentItem["variants"] as List);
    
    // Set dietary restrictions
    List<String> itemDietary = List<String>.from(currentItem["dietary"] as List);
    for (var option in dietaryOptions) {
      option["checked"] = itemDietary.contains(option["value"]);
    }
    selectedDietary = dietaryOptions
        .where((option) => option["checked"] == true)
        .map((option) => option["value"] as String)
        .toList();
    
    // Set allergens
    List<String> itemAllergens = List<String>.from(currentItem["allergens"] as List);
    for (var option in allergenOptions) {
      option["checked"] = itemAllergens.contains(option["value"]);
    }
    selectedAllergens = allergenOptions
        .where((option) => option["checked"] == true)
        .map((option) => option["value"] as String)
        .toList();
  }
  
  void _updateItem() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Menu item updated successfully!");
    //navigateTo(RmaMenuItemsView());
  }
  
  void _addVariant() {
    variants.add({
      "name": "",
      "price": 0.0,
    });
    setState(() {});
  }
  
  void _removeVariant(int index) {
    variants.removeAt(index);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Menu Item"),
        actions: [
          if (loading)
            Container(
              margin: EdgeInsets.all(spSm),
              child: CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Item Name",
                      value: itemName,
                      validator: Validator.required,
                      onChanged: (value) {
                        itemName = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: categoryItems,
                      value: selectedCategory,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Status",
                      items: statusItems,
                      value: selectedStatus,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Pricing Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pricing",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Price (\$)",
                            value: price,
                            validator: Validator.required,
                            onChanged: (value) {
                              price = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Cost (\$)",
                            value: cost,
                            validator: Validator.required,
                            onChanged: (value) {
                              cost = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profit Margin:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${price.isNotEmpty && cost.isNotEmpty ? (((double.tryParse(price) ?? 0) - (double.tryParse(cost) ?? 0)) / (double.tryParse(price) ?? 1) * 100).toStringAsFixed(1) : '0.0'}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Images Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Item Images",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMultiImagePicker(
                      label: "Product Images",
                      value: itemImages,
                      maxImages: 5,
                      onChanged: (value) {
                        itemImages = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Kitchen Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kitchen Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Preparation Time (minutes)",
                      value: preparationTime,
                      validator: Validator.required,
                      onChanged: (value) {
                        preparationTime = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Dietary & Allergens
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dietary Restrictions & Allergens",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      label: "Dietary Restrictions",
                      items: dietaryOptions,
                      value: dietaryOptions.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        // Update dietary options
                        for (var option in dietaryOptions) {
                          option["checked"] = values.any((v) => v["value"] == option["value"]);
                        }
                        selectedDietary = values.map((v) => v["value"] as String).toList();
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      label: "Allergens",
                      items: allergenOptions,
                      value: allergenOptions.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        // Update allergen options
                        for (var option in allergenOptions) {
                          option["checked"] = values.any((v) => v["value"] == option["value"]);
                        }
                        selectedAllergens = values.map((v) => v["value"] as String).toList();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Nutrition Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nutrition Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Calories",
                      value: calories,
                      onChanged: (value) {
                        calories = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Protein (g)",
                            value: protein,
                            onChanged: (value) {
                              protein = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Carbs (g)",
                            value: carbs,
                            onChanged: (value) {
                              carbs = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Fat (g)",
                            value: fat,
                            onChanged: (value) {
                              fat = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Variants Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Item Variants",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Add Variant",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addVariant,
                        ),
                      ],
                    ),
                    if (variants.isEmpty)
                      Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inventory_2,
                              size: 48,
                              color: disabledBoldColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No variants added",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Add variants like Regular, Large, etc.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ...List.generate(variants.length, (index) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              flex: 2,
                              child: QTextField(
                                label: "Variant Name",
                                value: "${variants[index]["name"]}",
                                onChanged: (value) {
                                  variants[index]["name"] = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: QNumberField(
                                label: "Price (\$)",
                                value: "${variants[index]["price"]}",
                                onChanged: (value) {
                                  variants[index]["price"] = double.tryParse(value) ?? 0.0;
                                  setState(() {});
                                },
                              ),
                            ),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _removeVariant(index),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              
              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Updating..." : "Update Item",
                  size: bs.md,
                  onPressed: loading ? () {} : _updateItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

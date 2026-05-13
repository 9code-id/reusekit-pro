import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaMenuItemCreateView extends StatefulWidget {
  const FmaMenuItemCreateView({super.key});

  @override
  State<FmaMenuItemCreateView> createState() => _FmaMenuItemCreateViewState();
}

class _FmaMenuItemCreateViewState extends State<FmaMenuItemCreateView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String itemName = "";
  String description = "";
  String category = "";
  double price = 0.0;
  String preparationTime = "";
  bool isAvailable = true;
  bool isFeatured = false;
  bool isSpicy = false;
  bool isVegetarian = false;
  bool isVegan = false;
  bool isGlutenFree = false;
  
  // Images
  List<String> itemImages = [];
  
  // Nutritional Information
  String calories = "";
  String protein = "";
  String carbs = "";
  String fat = "";
  String fiber = "";
  String sodium = "";
  
  // Ingredients
  List<String> ingredients = [];
  String newIngredient = "";
  
  // Allergens
  List<String> selectedAllergens = [];
  
  // Pricing & Variants
  List<Map<String, dynamic>> variants = [];
  String variantName = "";
  double variantPrice = 0.0;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Appetizers", "value": "appetizers"},
    {"label": "Main Course", "value": "main_course"},
    {"label": "Desserts", "value": "desserts"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Salads", "value": "salads"},
    {"label": "Soups", "value": "soups"},
  ];
  
  List<Map<String, dynamic>> preparationTimeOptions = [
    {"label": "5-10 minutes", "value": "5-10"},
    {"label": "10-15 minutes", "value": "10-15"},
    {"label": "15-20 minutes", "value": "15-20"},
    {"label": "20-30 minutes", "value": "20-30"},
    {"label": "30+ minutes", "value": "30+"},
  ];
  
  List<String> allergensList = [
    "Dairy", "Eggs", "Fish", "Shellfish", "Tree Nuts", 
    "Peanuts", "Wheat", "Soy", "Sesame"
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Menu Item"),
        actions: [
          TextButton(
            onPressed: _saveMenuItem,
            child: Text(
              "Save",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Basic Information Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
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
                      hint: "Enter the name of the menu item",
                      validator: Validator.required,
                      onChanged: (value) {
                        itemName = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the menu item",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: categoryOptions,
                      value: category,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        category = value;
                        setState(() {});
                      },
                    ),
                    QNumberField(
                      label: "Price (\$)",
                      value: price.toString(),
                      validator: Validator.required,
                      onChanged: (value) {
                        price = double.tryParse("$value") ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Preparation Time",
                      items: preparationTimeOptions,
                      value: preparationTime,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        preparationTime = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Images Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
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
                      label: "Upload Images",
                      value: itemImages,
                      maxImages: 5,
                      hint: "Add up to 5 high-quality images",
                      validator: (images) {
                        if (images == null || images.isEmpty) {
                          return "At least one image is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        itemImages = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Status & Properties Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Status & Properties",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Available for order",
                          "value": "available",
                          "checked": isAvailable,
                        },
                        {
                          "label": "Featured item",
                          "value": "featured",
                          "checked": isFeatured,
                        },
                        {
                          "label": "Spicy",
                          "value": "spicy",
                          "checked": isSpicy,
                        },
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
                          "value": "gluten_free",
                          "checked": isGlutenFree,
                        },
                      ],
                      value: [
                        if (isAvailable) {"label": "Available for order", "value": "available", "checked": true},
                        if (isFeatured) {"label": "Featured item", "value": "featured", "checked": true},
                        if (isSpicy) {"label": "Spicy", "value": "spicy", "checked": true},
                        if (isVegetarian) {"label": "Vegetarian", "value": "vegetarian", "checked": true},
                        if (isVegan) {"label": "Vegan", "value": "vegan", "checked": true},
                        if (isGlutenFree) {"label": "Gluten Free", "value": "gluten_free", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isAvailable = values.any((v) => v["value"] == "available");
                          isFeatured = values.any((v) => v["value"] == "featured");
                          isSpicy = values.any((v) => v["value"] == "spicy");
                          isVegetarian = values.any((v) => v["value"] == "vegetarian");
                          isVegan = values.any((v) => v["value"] == "vegan");
                          isGlutenFree = values.any((v) => v["value"] == "gluten_free");
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              // Nutritional Information Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Nutritional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Calories",
                            value: calories,
                            hint: "kcal",
                            onChanged: (value) {
                              calories = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Protein",
                            value: protein,
                            hint: "g",
                            onChanged: (value) {
                              protein = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Carbohydrates",
                            value: carbs,
                            hint: "g",
                            onChanged: (value) {
                              carbs = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Fat",
                            value: fat,
                            hint: "g",
                            onChanged: (value) {
                              fat = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Fiber",
                            value: fiber,
                            hint: "g",
                            onChanged: (value) {
                              fiber = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Sodium",
                            value: sodium,
                            hint: "mg",
                            onChanged: (value) {
                              sodium = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Ingredients Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Ingredient",
                            value: newIngredient,
                            hint: "Enter ingredient name",
                            onChanged: (value) {
                              newIngredient = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: newIngredient.isNotEmpty ? _addIngredient : null,
                        ),
                      ],
                    ),
                    if (ingredients.isNotEmpty) ...[
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: ingredients.map((ingredient) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  ingredient,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () => _removeIngredient(ingredient),
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: primaryColor,
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
              
              // Allergens Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Allergen Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: allergensList.map((allergen) => {
                        "label": allergen,
                        "value": allergen.toLowerCase(),
                        "checked": selectedAllergens.contains(allergen.toLowerCase()),
                      }).toList(),
                      value: selectedAllergens.map((allergen) => {
                        "label": allergen,
                        "value": allergen,
                        "checked": true,
                      }).toList(),
                      onChanged: (values, ids) {
                        setState(() {
                          selectedAllergens = values.map((v) => v["value"] as String).toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              // Variants Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Size Variants (Optional)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QTextField(
                            label: "Variant Name",
                            value: variantName,
                            hint: "e.g., Small, Medium, Large",
                            onChanged: (value) {
                              variantName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Price (\$)",
                            value: variantPrice.toString(),
                            onChanged: (value) {
                              variantPrice = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: (variantName.isNotEmpty && variantPrice > 0) ? _addVariant : null,
                        ),
                      ],
                    ),
                    if (variants.isNotEmpty) ...[
                      ...variants.map((variant) => Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
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
                            Expanded(
                              child: Text(
                                "${variant["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "\$${(variant["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _removeVariant(variant),
                              child: Icon(
                                Icons.delete,
                                size: 16,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ],
                ),
              ),
              
              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Menu Item",
                  size: bs.md,
                  onPressed: _saveMenuItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _addIngredient() {
    if (newIngredient.trim().isNotEmpty && !ingredients.contains(newIngredient.trim())) {
      setState(() {
        ingredients.add(newIngredient.trim());
        newIngredient = "";
      });
    }
  }
  
  void _removeIngredient(String ingredient) {
    setState(() {
      ingredients.remove(ingredient);
    });
  }
  
  void _addVariant() {
    if (variantName.trim().isNotEmpty && variantPrice > 0) {
      setState(() {
        variants.add({
          "name": variantName.trim(),
          "price": variantPrice,
        });
        variantName = "";
        variantPrice = 0.0;
      });
    }
  }
  
  void _removeVariant(Map<String, dynamic> variant) {
    setState(() {
      variants.remove(variant);
    });
  }
  
  void _saveMenuItem() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Menu item created successfully!");
      
      // Navigate back or to menu list
      back();
    }
  }
}

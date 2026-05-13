import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaMenuItemEditView extends StatefulWidget {
  const FmaMenuItemEditView({super.key});

  @override
  State<FmaMenuItemEditView> createState() => _FmaMenuItemEditViewState();
}

class _FmaMenuItemEditViewState extends State<FmaMenuItemEditView> {
  final formKey = GlobalKey<FormState>();
  
  String itemName = "Beef Burger Deluxe";
  String description = "Premium beef patty with fresh lettuce, tomatoes, onions, and special sauce on a toasted bun";
  String category = "Main Course";
  String price = "15.99";
  String preparationTime = "15";
  bool isAvailable = true;
  bool isVegetarian = false;
  bool isSpicy = false;
  bool isGlutenFree = false;
  List<String> images = [
    "https://picsum.photos/400/300?random=1&keyword=burger",
    "https://picsum.photos/400/300?random=2&keyword=food",
    "https://picsum.photos/400/300?random=3&keyword=restaurant"
  ];
  List<String> ingredients = ["Beef Patty", "Lettuce", "Tomato", "Onion", "Special Sauce", "Sesame Bun"];
  String allergens = "Contains gluten, may contain traces of nuts";
  String calories = "650";
  String customization = "Extra cheese, No onions, Extra sauce";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Beverage", "value": "Beverage"},
    {"label": "Side Dish", "value": "Side Dish"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Menu Item"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool isConfirmed = await confirm("Are you sure you want to delete this menu item?");
              if (isConfirmed) {
                ss("Menu item deleted successfully");
                // navigateTo(FmaMenuManagementView());
              }
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Item Images
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  color: Colors.grey[100],
                ),
                child: QHorizontalScroll(
                  children: List.generate(images.length, (index) {
                    return Container(
                      width: 280,
                      margin: EdgeInsets.only(right: index < images.length - 1 ? spSm : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${images[index]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Basic Information
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
                      hint: "Describe the menu item in detail",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: categoryItems,
                      value: category,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        category = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Pricing & Timing
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
                      "Pricing & Timing",
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
                            label: "Prep Time (min)",
                            value: preparationTime,
                            validator: Validator.required,
                            onChanged: (value) {
                              preparationTime = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Calories",
                      value: calories,
                      hint: "Approximate calorie content",
                      onChanged: (value) {
                        calories = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Item Properties
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
                      "Item Properties",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Available for Order",
                          "value": true,
                          "checked": isAvailable,
                        }
                      ],
                      value: [if (isAvailable) {"label": "Available for Order", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Vegetarian",
                          "value": true,
                          "checked": isVegetarian,
                        }
                      ],
                      value: [if (isVegetarian) {"label": "Vegetarian", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isVegetarian = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Spicy",
                          "value": true,
                          "checked": isSpicy,
                        }
                      ],
                      value: [if (isSpicy) {"label": "Spicy", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isSpicy = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Gluten Free",
                          "value": true,
                          "checked": isGlutenFree,
                        }
                      ],
                      value: [if (isGlutenFree) {"label": "Gluten Free", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isGlutenFree = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Ingredients & Allergens
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
                      "Ingredients & Allergens",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: ingredients.map((ingredient) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  ingredient,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    QMemoField(
                      label: "Allergen Information",
                      value: allergens,
                      hint: "List any allergens or dietary warnings",
                      onChanged: (value) {
                        allergens = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Customization Options
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
                      "Customization Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Available Customizations",
                      value: customization,
                      hint: "List available customization options",
                      onChanged: (value) {
                        customization = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Changes",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Menu item updated successfully");
                          // navigateTo(FmaMenuManagementView());
                        }
                      },
                    ),
                  ),
                  QButton(
                    label: "Preview",
                    color: secondaryColor,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo(FmaMenuItemPreviewView());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

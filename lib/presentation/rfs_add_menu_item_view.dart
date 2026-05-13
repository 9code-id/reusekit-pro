import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsAddMenuItemView extends StatefulWidget {
  const RfsAddMenuItemView({super.key});

  @override
  State<RfsAddMenuItemView> createState() => _RfsAddMenuItemViewState();
}

class _RfsAddMenuItemViewState extends State<RfsAddMenuItemView> {
  final formKey = GlobalKey<FormState>();
  
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

  int currentStep = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Menu Item"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _saveMenuItem(),
          ),
        ],
      ),
      body: loading 
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: Stepper(
                currentStep: currentStep,
                onStepTapped: (step) {
                  currentStep = step;
                  setState(() {});
                },
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      if (details.stepIndex < 4)
                        QButton(
                          label: "Next",
                          size: bs.sm,
                          onPressed: details.onStepContinue,
                        ),
                      if (details.stepIndex == 4)
                        QButton(
                          label: "Save Item",
                          size: bs.sm,
                          icon: Icons.save,
                          onPressed: () => _saveMenuItem(),
                        ),
                      SizedBox(width: spSm),
                      if (details.stepIndex > 0)
                        QButton(
                          label: "Back",
                          size: bs.sm,
                          color: disabledBoldColor,
                          onPressed: details.onStepCancel,
                        ),
                    ],
                  );
                },
                onStepContinue: () {
                  if (currentStep < 4) {
                    currentStep++;
                    setState(() {});
                  }
                },
                onStepCancel: () {
                  if (currentStep > 0) {
                    currentStep--;
                    setState(() {});
                  }
                },
                steps: [
                  Step(
                    title: Text("Basic Information"),
                    content: _buildBasicInfoStep(),
                    isActive: currentStep == 0,
                  ),
                  Step(
                    title: Text("Pricing & Kitchen"),
                    content: _buildPricingStep(),
                    isActive: currentStep == 1,
                  ),
                  Step(
                    title: Text("Images & Description"),
                    content: _buildImagesStep(),
                    isActive: currentStep == 2,
                  ),
                  Step(
                    title: Text("Dietary & Nutrition"),
                    content: _buildDietaryStep(),
                    isActive: currentStep == 3,
                  ),
                  Step(
                    title: Text("Review & Save"),
                    content: _buildReviewStep(),
                    isActive: currentStep == 4,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Item Name",
          value: itemName,
          hint: "Enter menu item name",
          validator: Validator.required,
          onChanged: (value) {
            itemName = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Category",
          items: categoryItems,
          value: category,
          onChanged: (value, label) {
            category = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Subcategory",
          items: subcategoryItems,
          value: subcategory,
          onChanged: (value, label) {
            subcategory = value;
            setState(() {});
          },
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
                  setState(() {});
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
                  setState(() {});
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
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPricingStep() {
    return Column(
      spacing: spSm,
      children: [
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
                  setState(() {});
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
                  setState(() {});
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
                  "Profit Margin:",
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
        
        QDropdownField(
          label: "Assigned Chef",
          items: chefItems,
          value: chef,
          onChanged: (value, label) {
            chef = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Kitchen Station",
          items: stationItems,
          value: kitchenStation,
          onChanged: (value, label) {
            kitchenStation = value;
            setState(() {});
          },
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
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildImagesStep() {
    return Column(
      spacing: spSm,
      children: [
        QMultiImagePicker(
          label: "Product Images",
          value: productImages,
          maxImages: 5,
          hint: "Add up to 5 high-quality images",
          helper: "First image will be used as the main display image",
          onChanged: (value) {
            productImages = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Description",
          value: description,
          hint: "Detailed description of the menu item...",
          validator: Validator.required,
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Ingredients",
          value: ingredients,
          hint: "List all ingredients, separated by commas",
          onChanged: (value) {
            ingredients = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildDietaryStep() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Dietary Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QSwitch(
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
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Allergens",
          value: allergens,
          hint: "List allergens, separated by commas (e.g., Nuts, Dairy, Eggs)",
          onChanged: (value) {
            allergens = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "Nutritional Information (Optional)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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
                setState(() {});
              },
            ),
            QNumberField(
              label: "Protein",
              value: protein,
              hint: "grams",
              onChanged: (value) {
                protein = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Carbs",
              value: carbs,
              hint: "grams",
              onChanged: (value) {
                carbs = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Fat",
              value: fat,
              hint: "grams",
              onChanged: (value) {
                fat = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Fiber",
              value: fiber,
              hint: "grams",
              onChanged: (value) {
                fiber = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Sodium",
              value: sodium,
              hint: "mg",
              onChanged: (value) {
                sodium = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Menu Item",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
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
              // Basic Info
              _buildReviewSection("Basic Information", [
                _buildReviewItem("Name", itemName),
                _buildReviewItem("Category", category),
                _buildReviewItem("Subcategory", subcategory),
                _buildReviewItem("Prep Time", "$preparationTime min"),
                _buildReviewItem("Serving Size", servingSize),
                _buildReviewItem("Spice Level", spiceLevel),
              ]),
              
              Divider(),
              
              // Pricing
              _buildReviewSection("Pricing & Kitchen", [
                _buildReviewItem("Price", "\$$price"),
                _buildReviewItem("Cost", "\$$cost"),
                _buildReviewItem("Profit Margin", "${_calculateProfitMargin()}%"),
                _buildReviewItem("Chef", chef),
                _buildReviewItem("Station", kitchenStation),
                _buildReviewItem("Available", isAvailable ? "Yes" : "No"),
              ]),
              
              if (description.isNotEmpty) ...[
                Divider(),
                _buildReviewSection("Description", [
                  Container(
                    width: double.infinity,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ]),
              ],
              
              if (productImages.isNotEmpty) ...[
                Divider(),
                _buildReviewSection("Images", [
                  Text("${productImages.length} image(s) selected"),
                ]),
              ],
              
              if (isVegetarian || isVegan || isGlutenFree) ...[
                Divider(),
                _buildReviewSection("Dietary", [
                  if (isVegetarian) _buildReviewItem("", "Vegetarian"),
                  if (isVegan) _buildReviewItem("", "Vegan"),
                  if (isGlutenFree) _buildReviewItem("", "Gluten Free"),
                ]),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Menu Item",
            size: bs.md,
            icon: Icons.add,
            onPressed: () => _saveMenuItem(),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...children,
        SizedBox(height: spSm),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value) {
    if (value.isEmpty) return SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          if (label.isNotEmpty) ...[
            SizedBox(
              width: 100,
              child: Text(
                "$label:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
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

  void _saveMenuItem() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }
    
    if (itemName.isEmpty) {
      se("Item name is required");
      currentStep = 0;
      setState(() {});
      return;
    }
    
    if (price.isEmpty || cost.isEmpty) {
      se("Price and cost are required");
      currentStep = 1;
      setState(() {});
      return;
    }
    
    if (description.isEmpty) {
      se("Description is required");
      currentStep = 2;
      setState(() {});
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Menu item created successfully!");
    back();
  }
}

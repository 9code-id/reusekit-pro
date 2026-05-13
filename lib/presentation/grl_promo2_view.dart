import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo2View extends StatefulWidget {
  @override
  State<GrlPromo2View> createState() => _GrlPromo2ViewState();
}

class _GrlPromo2ViewState extends State<GrlPromo2View> {
  String title = "";
  String description = "";
  String discountType = "percentage";
  double discountValue = 0.0;
  double minPurchase = 0.0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  String selectedCategory = "electronics";
  List<String> selectedProducts = [];
  bool isLimitedQuantity = false;
  int quantityLimit = 100;
  
  List<Map<String, dynamic>> categories = [
    {"label": "Electronics", "value": "electronics"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Food & Dining", "value": "food"},
    {"label": "Travel", "value": "travel"},
    {"label": "Health & Beauty", "value": "health"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> products = [
    {"name": "Smartphones", "category": "electronics"},
    {"name": "Laptops", "category": "electronics"},
    {"name": "Headphones", "category": "electronics"},
    {"name": "Men's Clothing", "category": "fashion"},
    {"name": "Women's Clothing", "category": "fashion"},
    {"name": "Shoes", "category": "fashion"},
    {"name": "Restaurant Meals", "category": "food"},
    {"name": "Groceries", "category": "food"},
    {"name": "Flight Tickets", "category": "travel"},
    {"name": "Hotel Bookings", "category": "travel"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = products
        .where((product) => product["category"] == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Promotion"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              _previewPromotion();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.campaign,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Promotion Title",
                      value: title,
                      hint: "Enter an attractive title",
                      onChanged: (value) {
                        title = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe your promotion in detail",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Discount Configuration
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Discount Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Discount Type",
                      items: [
                        {"label": "Percentage (%)", "value": "percentage"},
                        {"label": "Fixed Amount (\$)", "value": "fixed"},
                        {"label": "Free Shipping", "value": "shipping"},
                      ],
                      value: discountType,
                      onChanged: (value, label) {
                        discountType = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    if (discountType != "shipping")
                      QNumberField(
                        label: discountType == "percentage" ? "Discount Percentage" : "Discount Amount",
                        value: discountValue.toString(),
                        hint: discountType == "percentage" ? "Enter percentage (0-100)" : "Enter amount",
                        onChanged: (value) {
                          discountValue = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    if (discountType != "shipping") SizedBox(height: spMd),
                    QNumberField(
                      label: "Minimum Purchase Amount",
                      value: minPurchase.toString(),
                      hint: "Enter minimum purchase required",
                      onChanged: (value) {
                        minPurchase = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Date Range
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Promotion Period",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Start Date",
                            value: startDate,
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QDatePicker(
                            label: "End Date",
                            value: endDate,
                            onChanged: (value) {
                              endDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Duration: ${endDate.difference(startDate).inDays} days",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Category & Products
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Category & Products",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        selectedProducts.clear();
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Applicable Products",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...filteredProducts.map((product) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: QSwitch(
                        items: [
                          {
                            "label": "${product["name"]}",
                            "value": product["name"],
                            "checked": selectedProducts.contains(product["name"]),
                          }
                        ],
                        value: selectedProducts.contains(product["name"]) 
                            ? [{"label": "${product["name"]}", "value": product["name"], "checked": true}] 
                            : [],
                        onChanged: (values, ids) {
                          if (values.isNotEmpty) {
                            if (!selectedProducts.contains(product["name"])) {
                              selectedProducts.add(product["name"]);
                            }
                          } else {
                            selectedProducts.remove(product["name"]);
                          }
                          setState(() {});
                        },
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Advanced Settings
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Advanced Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QSwitch(
                      items: [
                        {
                          "label": "Limit Quantity",
                          "value": true,
                          "checked": isLimitedQuantity,
                        }
                      ],
                      value: isLimitedQuantity 
                          ? [{"label": "Limit Quantity", "value": true, "checked": true}] 
                          : [],
                      onChanged: (values, ids) {
                        isLimitedQuantity = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (isLimitedQuantity) ...[
                      SizedBox(height: spMd),
                      QNumberField(
                        label: "Quantity Limit",
                        value: quantityLimit.toString(),
                        hint: "Enter maximum number of uses",
                        onChanged: (value) {
                          quantityLimit = int.tryParse(value) ?? 100;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Create Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Promotion",
                size: bs.md,
                onPressed: _canCreatePromotion() ? () {
                  _createPromotion();
                } : null,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Save Draft Button
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _saveDraft();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor),
                  padding: EdgeInsets.symmetric(vertical: spMd),
                ),
                child: Text(
                  "Save as Draft",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canCreatePromotion() {
    return title.isNotEmpty &&
           description.isNotEmpty &&
           (discountType == "shipping" || discountValue > 0) &&
           selectedProducts.isNotEmpty &&
           endDate.isAfter(startDate);
  }

  void _createPromotion() {
    if (!_canCreatePromotion()) {
      se("Please fill in all required fields");
      return;
    }
    
    ss("Promotion created successfully!");
    // navigateTo(PromotionListView());
  }

  void _saveDraft() {
    si("Promotion saved as draft");
    // Save to local storage or database
  }

  void _previewPromotion() {
    if (title.isEmpty) {
      se("Please enter a promotion title first");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Promotion Preview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            if (description.isNotEmpty)
              Text(
                description,
                style: TextStyle(fontSize: 14),
              ),
            SizedBox(height: spMd),
            if (discountType != "shipping")
              Text(
                "Discount: ${discountType == "percentage" ? "${discountValue.toInt()}%" : "\$${discountValue.toStringAsFixed(2)}"}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            if (minPurchase > 0)
              Text(
                "Min. Purchase: \$${minPurchase.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 12),
              ),
            Text(
              "Valid: ${startDate.day}/${startDate.month} - ${endDate.day}/${endDate.month}",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}

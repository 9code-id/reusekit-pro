import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount3View extends StatefulWidget {
  @override
  State<GrlDiscount3View> createState() => _GrlDiscount3ViewState();
}

class _GrlDiscount3ViewState extends State<GrlDiscount3View> {
  String discountTitle = "";
  String discountCode = "";
  String discountDescription = "";
  String discountType = "percentage";
  String discountValue = "";
  String minOrderAmount = "";
  String maxDiscountAmount = "";
  String maxUsageLimit = "";
  String validFromDate = "";
  String validToDate = "";
  String selectedCategory = "all";
  bool isPublicCoupon = true;
  bool autoGenerateCode = false;
  bool isActive = false;

  List<Map<String, dynamic>> discountTypeOptions = [
    {"label": "Percentage Discount (%)", "value": "percentage"},
    {"label": "Fixed Amount (\$)", "value": "fixed_amount"},
    {"label": "Free Shipping", "value": "free_shipping"},
    {"label": "Buy One Get One", "value": "bogo"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Fashion & Apparel", "value": "fashion"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports & Outdoors", "value": "sports"},
    {"label": "Books & Media", "value": "books"},
    {"label": "Health & Beauty", "value": "health"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Discount"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDiscount,
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
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_offer, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Create New Discount",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Set up a new discount coupon to boost sales and attract customers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Basic Information
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Discount Title",
                value: discountTitle,
                validator: Validator.required,
                hint: "Enter a descriptive name for your discount",
                onChanged: (value) {
                  discountTitle = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Discount Code",
                      value: discountCode,
                      validator: Validator.required,
                      hint: "e.g., SAVE20, WELCOME10",
                      onChanged: (value) {
                        discountCode = value.toUpperCase();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Generate",
                    size: bs.sm,
                    onPressed: _generateDiscountCode,
                  ),
                ],
              ),
              QMemoField(
                label: "Description",
                value: discountDescription,
                hint: "Describe what this discount offers",
                onChanged: (value) {
                  discountDescription = value;
                  setState(() {});
                },
              ),

              // Discount Configuration
              Text(
                "Discount Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QDropdownField(
                label: "Discount Type",
                items: discountTypeOptions,
                value: discountType,
                onChanged: (value, label) {
                  discountType = value;
                  setState(() {});
                },
              ),
              if (discountType != "free_shipping")
                QNumberField(
                  label: _getDiscountValueLabel(),
                  value: discountValue,
                  validator: Validator.required,
                  hint: _getDiscountValueHint(),
                  onChanged: (value) {
                    discountValue = value;
                    setState(() {});
                  },
                ),

              // Conditions & Limits
              Text(
                "Conditions & Limits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QNumberField(
                label: "Minimum Order Amount (\$)",
                value: minOrderAmount,
                hint: "Leave empty for no minimum",
                onChanged: (value) {
                  minOrderAmount = value;
                  setState(() {});
                },
              ),
              if (discountType == "percentage")
                QNumberField(
                  label: "Maximum Discount Amount (\$)",
                  value: maxDiscountAmount,
                  hint: "Cap the maximum discount value",
                  onChanged: (value) {
                    maxDiscountAmount = value;
                    setState(() {});
                  },
                ),
              QNumberField(
                label: "Usage Limit",
                value: maxUsageLimit,
                hint: "Leave empty for unlimited usage",
                onChanged: (value) {
                  maxUsageLimit = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Apply to Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              // Validity Period
              Text(
                "Validity Period",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Valid From",
                      value: validFromDate.isNotEmpty ? DateTime.parse(validFromDate) : DateTime.now(),
                      onChanged: (value) {
                        validFromDate = value.toIso8601String();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "Valid To",
                      value: validToDate.isNotEmpty ? DateTime.parse(validToDate) : DateTime.now().add(Duration(days: 30)),
                      onChanged: (value) {
                        validToDate = value.toIso8601String();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Advanced Settings
              Text(
                "Advanced Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Make Public",
                                "value": true,
                                "checked": isPublicCoupon,
                              }
                            ],
                            value: [if (isPublicCoupon) {"label": "Make Public", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              isPublicCoupon = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Activate Immediately",
                                "value": true,
                                "checked": isActive,
                              }
                            ],
                            value: [if (isActive) {"label": "Activate Immediately", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              isActive = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Preview
              Text(
                "Discount Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              _buildDiscountPreview(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      size: bs.md,
                      onPressed: _saveDraft,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Create Discount",
                      size: bs.md,
                      onPressed: _saveDiscount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountPreview() {
    if (discountTitle.isEmpty || discountCode.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: disabledColor.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: disabledOutlineBorderColor, style: BorderStyle.solid),
        ),
        child: Text(
          "Fill in the discount details to see preview",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: _getDiscountColor().withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getDiscountColor().withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getDiscountLabel(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getDiscountColor(),
                  ),
                ),
              ),
              Spacer(),
              if (isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "ACTIVE",
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            discountTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (discountDescription.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              discountDescription,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          SizedBox(height: spSm),
          
          // Coupon Code
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: primaryColor, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Code: $discountCode",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: primaryColor,
                ),
              ],
            ),
          ),

          // Conditions
          if (_hasConditions()) ...[
            SizedBox(height: spSm),
            Text(
              "Conditions:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            if (minOrderAmount.isNotEmpty)
              Text(
                "• Minimum order: \$${double.tryParse(minOrderAmount)?.toStringAsFixed(2) ?? minOrderAmount}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            if (maxDiscountAmount.isNotEmpty && discountType == "percentage")
              Text(
                "• Maximum discount: \$${double.tryParse(maxDiscountAmount)?.toStringAsFixed(2) ?? maxDiscountAmount}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            if (maxUsageLimit.isNotEmpty)
              Text(
                "• Limited to ${maxUsageLimit} uses",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            if (selectedCategory != "all")
              Text(
                "• Applies to: ${_getCategoryLabel()}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
          ],

          // Validity
          if (validFromDate.isNotEmpty && validToDate.isNotEmpty) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Valid: ${DateTime.parse(validFromDate).toLocal().toString().split(' ')[0]} - ${DateTime.parse(validToDate).toLocal().toString().split(' ')[0]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _generateDiscountCode() {
    String prefix = discountType == "percentage" ? "SAVE" : 
                   discountType == "fixed_amount" ? "OFF" :
                   discountType == "free_shipping" ? "SHIP" : "DEAL";
    String suffix = discountValue.isNotEmpty ? discountValue.split('.')[0] : "10";
    discountCode = "$prefix$suffix";
    setState(() {});
  }

  void _saveDiscount() {
    if (formKey.currentState!.validate()) {
      ss("Discount created successfully!");
      // Navigate back or to success page
    }
  }

  void _saveDraft() {
    ss("Discount saved as draft");
  }

  String _getDiscountValueLabel() {
    switch (discountType) {
      case "percentage":
        return "Discount Percentage (%)";
      case "fixed_amount":
        return "Discount Amount (\$)";
      case "bogo":
        return "Free Items Quantity";
      default:
        return "Discount Value";
    }
  }

  String _getDiscountValueHint() {
    switch (discountType) {
      case "percentage":
        return "e.g., 20 (for 20% off)";
      case "fixed_amount":
        return "e.g., 50 (for \$50 off)";
      case "bogo":
        return "e.g., 1 (for buy 2 get 1 free)";
      default:
        return "Enter discount value";
    }
  }

  Color _getDiscountColor() {
    switch (discountType) {
      case "percentage":
        return successColor;
      case "fixed_amount":
        return primaryColor;
      case "free_shipping":
        return infoColor;
      case "bogo":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  String _getDiscountLabel() {
    if (discountValue.isEmpty) return "SPECIAL OFFER";
    
    switch (discountType) {
      case "percentage":
        return "${discountValue}% OFF";
      case "fixed_amount":
        return "\$${discountValue} OFF";
      case "free_shipping":
        return "FREE SHIPPING";
      case "bogo":
        return "BUY ${(int.tryParse(discountValue) ?? 1) + 1} GET ${discountValue}";
      default:
        return "SPECIAL OFFER";
    }
  }

  String _getCategoryLabel() {
    Map<String, dynamic>? category = categoryOptions.firstWhere(
      (cat) => cat["value"] == selectedCategory,
      orElse: () => {"label": "Unknown"},
    );
    return category["label"];
  }

  bool _hasConditions() {
    return minOrderAmount.isNotEmpty || 
           maxDiscountAmount.isNotEmpty || 
           maxUsageLimit.isNotEmpty || 
           selectedCategory != "all";
  }
}

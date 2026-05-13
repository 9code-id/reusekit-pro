import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmAddProductView extends StatefulWidget {
  const IwmAddProductView({super.key});

  @override
  State<IwmAddProductView> createState() => _IwmAddProductViewState();
}

class _IwmAddProductViewState extends State<IwmAddProductView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String productName = "";
  String brand = "";
  String selectedCategory = "";
  String selectedSubcategory = "";
  String description = "";
  String shortDescription = "";
  
  // Pricing & Inventory
  String price = "";
  String cost = "";
  String sku = "";
  String barcode = "";
  String stock = "";
  String minStock = "";
  String maxStock = "";
  String reorderPoint = "";
  
  // Product Details
  String weight = "";
  String dimensions = "";
  String selectedSupplier = "";
  String supplierCode = "";
  String selectedStatus = "active";
  
  // Images and Media
  List<String> productImages = [];
  
  // Variants
  List<Map<String, dynamic>> variants = [];
  
  // Features and Specifications
  List<String> features = [];
  Map<String, String> specifications = {};
  List<String> tags = [];
  
  List<Map<String, dynamic>> categories = [
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
  ];
  
  List<Map<String, dynamic>> subcategories = [
    {"label": "Smartphones", "value": "smartphones"},
    {"label": "Laptops", "value": "laptops"},
    {"label": "Tablets", "value": "tablets"},
    {"label": "Audio", "value": "audio"},
    {"label": "Accessories", "value": "accessories"},
  ];
  
  List<Map<String, dynamic>> suppliers = [
    {"label": "TechSupply Co.", "value": "techsupply"},
    {"label": "Global Electronics", "value": "global_elec"},
    {"label": "Fashion Distributors", "value": "fashion_dist"},
    {"label": "Food Wholesalers", "value": "food_wholesale"},
    {"label": "SportGear Inc.", "value": "sportgear"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Inactive", "value": "inactive"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
        actions: [
          QButton(
            label: "Save Draft",
            size: bs.sm,
            onPressed: _saveDraft,
          ),
          SizedBox(width: spSm),
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
              _buildBasicInformation(),
              _buildPricingInventory(),
              _buildProductDetails(),
              _buildImagesSection(),
              _buildVariantsSection(),
              _buildFeaturesSpecs(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
            label: "Product Name",
            value: productName,
            validator: Validator.required,
            hint: "Enter product name",
            onChanged: (value) {
              productName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Brand",
                  value: brand,
                  validator: Validator.required,
                  hint: "Enter brand name",
                  onChanged: (value) {
                    brand = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Subcategory",
            items: subcategories,
            value: selectedSubcategory,
            onChanged: (value, label) {
              selectedSubcategory = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Product Description",
            value: description,
            validator: Validator.required,
            hint: "Enter detailed product description",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Short Description",
            value: shortDescription,
            hint: "Brief product summary for listings",
            onChanged: (value) {
              shortDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingInventory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pricing & Inventory",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Selling Price (\$)",
                  value: price,
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
                  label: "Cost Price (\$)",
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
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "SKU",
                  value: sku,
                  validator: Validator.required,
                  hint: "Product SKU code",
                  onChanged: (value) {
                    sku = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Barcode",
                  value: barcode,
                  hint: "Product barcode",
                  onChanged: (value) {
                    barcode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Initial Stock",
                  value: stock,
                  validator: Validator.required,
                  onChanged: (value) {
                    stock = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Minimum Stock",
                  value: minStock,
                  validator: Validator.required,
                  onChanged: (value) {
                    minStock = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Maximum Stock",
                  value: maxStock,
                  onChanged: (value) {
                    maxStock = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Reorder Point",
                  value: reorderPoint,
                  onChanged: (value) {
                    reorderPoint = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (price.isNotEmpty && cost.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Profit: \$${_calculateProfit().toStringAsFixed(2)} (${_calculateMargin().toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Details",
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
                  label: "Weight (kg)",
                  value: weight,
                  hint: "Product weight",
                  onChanged: (value) {
                    weight = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Dimensions (L x W x H)",
                  value: dimensions,
                  hint: "Length x Width x Height",
                  onChanged: (value) {
                    dimensions = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Supplier",
                  items: suppliers,
                  value: selectedSupplier,
                  onChanged: (value, label) {
                    selectedSupplier = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Supplier Code",
                  value: supplierCode,
                  hint: "Supplier product code",
                  onChanged: (value) {
                    supplierCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Product Images",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${productImages.length}/5",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          QMultiImagePicker(
            label: "Product Photos",
            value: productImages,
            maxImages: 5,
            hint: "Add high-quality product images",
            validator: (images) {
              if (images == null || images.isEmpty) {
                return "At least one product image is required";
              }
              return null;
            },
            onChanged: (value) {
              productImages = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVariantsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Product Variants",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                label: "Add Variant",
                size: bs.sm,
                onPressed: _addVariant,
              ),
            ],
          ),
          if (variants.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 32,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No variants added yet",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Add variants like colors, sizes, or models",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          else
            ...variants.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> variant = entry.value;
              return _buildVariantItem(variant, index);
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildVariantItem(Map<String, dynamic> variant, int index) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${variant["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "SKU: ${variant["sku"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontFamily: "monospace",
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Price: \$${((variant["price"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
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
  }

  Widget _buildFeaturesSpecs() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features & Specifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Key Features",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                label: "Add Feature",
                size: bs.sm,
                onPressed: _addFeature,
              ),
            ],
          ),
          if (features.isEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                "No features added yet",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            )
          else
            ...features.asMap().entries.map((entry) {
              int index = entry.key;
              String feature = entry.value;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _removeFeature(index),
                      child: Icon(Icons.close, color: dangerColor, size: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
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
              label: "Publish Product",
              size: bs.md,
              onPressed: _publishProduct,
            ),
          ),
        ],
      ),
    );
  }

  void _addVariant() {
    // Show dialog or navigate to add variant screen
    ss("Add variant feature coming soon");
  }

  void _removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void _addFeature() {
    // Show dialog to add feature
    ss("Add feature dialog coming soon");
  }

  void _removeFeature(int index) {
    setState(() {
      features.removeAt(index);
    });
  }

  void _saveDraft() {
    if (formKey.currentState!.validate()) {
      selectedStatus = "draft";
      ss("Product saved as draft successfully");
      // Navigate back or show success
      back();
    }
  }

  void _publishProduct() {
    if (formKey.currentState!.validate()) {
      selectedStatus = "active";
      ss("Product published successfully");
      // Navigate back or show success
      back();
    }
  }

  double _calculateProfit() {
    double priceValue = double.tryParse(price) ?? 0.0;
    double costValue = double.tryParse(cost) ?? 0.0;
    return priceValue - costValue;
  }

  double _calculateMargin() {
    double priceValue = double.tryParse(price) ?? 0.0;
    double costValue = double.tryParse(cost) ?? 0.0;
    if (priceValue > 0) {
      return ((priceValue - costValue) / priceValue) * 100;
    }
    return 0.0;
  }
}

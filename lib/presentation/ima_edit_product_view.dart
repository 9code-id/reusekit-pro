import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaEditProductView extends StatefulWidget {
  const ImaEditProductView({super.key});

  @override
  State<ImaEditProductView> createState() => _ImaEditProductViewState();
}

class _ImaEditProductViewState extends State<ImaEditProductView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information - Pre-filled with existing data
  String productName = "iPhone 14 Pro Max";
  String brand = "Apple";
  String sku = "IP14PM-256GB-PURPLE";
  String barcode = "123456789012";
  String description = "The iPhone 14 Pro Max features a 6.7-inch Super Retina XDR display with ProMotion technology. Powered by the A16 Bionic chip, it delivers incredible performance and efficiency.";
  String shortDescription = "Latest iPhone with advanced Pro camera system and A16 Bionic chip";
  
  // Category and Classification
  String selectedCategory = "Electronics";
  String selectedSubcategory = "Smartphones";
  String supplier = "Apple Inc.";
  String tags = "smartphone, apple, pro, premium, 5g";
  
  // Pricing
  String sellingPrice = "1199.99";
  String comparePrice = "1299.99";
  String costPrice = "899.99";
  
  // Inventory
  String stockQuantity = "45";
  String minimumStock = "10";
  String maximumStock = "100";
  String weight = "0.24";
  String dimensions = "160.7×77.6×7.85 mm";
  
  // Product Images
  List<String> productImages = [
    "https://picsum.photos/400/400?random=1&keyword=phone",
    "https://picsum.photos/400/400?random=2&keyword=phone",
    "https://picsum.photos/400/400?random=3&keyword=phone",
  ];
  
  // Status and Visibility
  String productStatus = "Active";
  bool trackInventory = true;
  bool allowBackorders = false;
  bool taxable = true;
  bool requiresShipping = true;
  
  // Edit tracking
  Map<String, dynamic> originalData = {};
  bool hasChanges = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Books", "value": "Books"},
    {"label": "Beauty", "value": "Beauty"},
  ];

  List<Map<String, dynamic>> subcategories = [
    {"label": "Smartphones", "value": "Smartphones", "parent": "Electronics"},
    {"label": "Laptops", "value": "Laptops", "parent": "Electronics"},
    {"label": "Tablets", "value": "Tablets", "parent": "Electronics"},
    {"label": "Accessories", "value": "Accessories", "parent": "Electronics"},
    {"label": "Men's Clothing", "value": "Men's Clothing", "parent": "Clothing"},
    {"label": "Women's Clothing", "value": "Women's Clothing", "parent": "Clothing"},
    {"label": "Shoes", "value": "Shoes", "parent": "Clothing"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Archived", "value": "Archived"},
  ];

  List<Map<String, dynamic>> get filteredSubcategories {
    return subcategories.where((sub) => sub["parent"] == selectedCategory).toList();
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _saveOriginalData();
  }

  void _saveOriginalData() {
    originalData = {
      "productName": productName,
      "brand": brand,
      "sku": sku,
      "barcode": barcode,
      "description": description,
      "shortDescription": shortDescription,
      "selectedCategory": selectedCategory,
      "selectedSubcategory": selectedSubcategory,
      "supplier": supplier,
      "tags": tags,
      "sellingPrice": sellingPrice,
      "comparePrice": comparePrice,
      "costPrice": costPrice,
      "stockQuantity": stockQuantity,
      "minimumStock": minimumStock,
      "maximumStock": maximumStock,
      "weight": weight,
      "dimensions": dimensions,
      "productImages": List.from(productImages),
      "productStatus": productStatus,
      "trackInventory": trackInventory,
      "allowBackorders": allowBackorders,
      "taxable": taxable,
      "requiresShipping": requiresShipping,
    };
  }

  void _checkForChanges() {
    Map<String, dynamic> currentData = {
      "productName": productName,
      "brand": brand,
      "sku": sku,
      "barcode": barcode,
      "description": description,
      "shortDescription": shortDescription,
      "selectedCategory": selectedCategory,
      "selectedSubcategory": selectedSubcategory,
      "supplier": supplier,
      "tags": tags,
      "sellingPrice": sellingPrice,
      "comparePrice": comparePrice,
      "costPrice": costPrice,
      "stockQuantity": stockQuantity,
      "minimumStock": minimumStock,
      "maximumStock": maximumStock,
      "weight": weight,
      "dimensions": dimensions,
      "productImages": List.from(productImages),
      "productStatus": productStatus,
      "trackInventory": trackInventory,
      "allowBackorders": allowBackorders,
      "taxable": taxable,
      "requiresShipping": requiresShipping,
    };

    bool changed = false;
    for (String key in originalData.keys) {
      if (originalData[key].toString() != currentData[key].toString()) {
        changed = true;
        break;
      }
    }

    if (hasChanges != changed) {
      hasChanges = changed;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (hasChanges) {
              _showUnsavedChangesDialog();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          if (hasChanges)
            Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Unsaved",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: hasChanges ? () => _resetToOriginal() : null,
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
              // Changes Summary
              if (hasChanges)
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "You have unsaved changes. Don't forget to save your updates.",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Product Info Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        productImages.isNotEmpty ? productImages[0] : "https://picsum.photos/80/80?random=1",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "SKU: $sku",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "Status: $productStatus",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(180),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Basic Information Section
              _buildSectionCard(
                title: "Basic Information",
                icon: Icons.info,
                children: [
                  QTextField(
                    label: "Product Name *",
                    value: productName,
                    hint: "Enter product name",
                    validator: Validator.required,
                    onChanged: (value) {
                      productName = value;
                      _checkForChanges();
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Brand",
                          value: brand,
                          hint: "Enter brand name",
                          onChanged: (value) {
                            brand = value;
                            _checkForChanges();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "SKU *",
                          value: sku,
                          hint: "Enter SKU",
                          validator: Validator.required,
                          onChanged: (value) {
                            sku = value;
                            _checkForChanges();
                          },
                        ),
                      ),
                    ],
                  ),

                  QTextField(
                    label: "Barcode",
                    value: barcode,
                    hint: "Enter barcode",
                    onChanged: (value) {
                      barcode = value;
                      _checkForChanges();
                    },
                  ),

                  QMemoField(
                    label: "Product Description",
                    value: description,
                    hint: "Enter detailed product description",
                    maxLines: 4,
                    onChanged: (value) {
                      description = value;
                      _checkForChanges();
                    },
                  ),

                  QTextField(
                    label: "Short Description",
                    value: shortDescription,
                    hint: "Brief product description for listings",
                    onChanged: (value) {
                      shortDescription = value;
                      _checkForChanges();
                    },
                  ),
                ],
              ),

              // Category Section
              _buildSectionCard(
                title: "Category & Classification",
                icon: Icons.category,
                children: [
                  QDropdownField(
                    label: "Category *",
                    items: categories,
                    value: selectedCategory,
                    validator: Validator.required,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      if (filteredSubcategories.isEmpty || 
                          !filteredSubcategories.any((sub) => sub["value"] == selectedSubcategory)) {
                        selectedSubcategory = "";
                      }
                      _checkForChanges();
                    },
                  ),

                  if (selectedCategory.isNotEmpty && filteredSubcategories.isNotEmpty)
                    QDropdownField(
                      label: "Subcategory",
                      items: filteredSubcategories,
                      value: selectedSubcategory,
                      onChanged: (value, label) {
                        selectedSubcategory = value;
                        _checkForChanges();
                      },
                    ),

                  QTextField(
                    label: "Supplier",
                    value: supplier,
                    hint: "Enter supplier name",
                    onChanged: (value) {
                      supplier = value;
                      _checkForChanges();
                    },
                  ),

                  QTextField(
                    label: "Tags",
                    value: tags,
                    hint: "Enter tags separated by commas",
                    onChanged: (value) {
                      tags = value;
                      _checkForChanges();
                    },
                  ),
                ],
              ),

              // Pricing Section
              _buildSectionCard(
                title: "Pricing",
                icon: Icons.attach_money,
                children: [
                  QNumberField(
                    label: "Selling Price *",
                    value: sellingPrice,
                    validator: Validator.required,
                    onChanged: (value) {
                      sellingPrice = value;
                      _checkForChanges();
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Compare at Price",
                          value: comparePrice,
                          onChanged: (value) {
                            comparePrice = value;
                            _checkForChanges();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Cost Price",
                          value: costPrice,
                          onChanged: (value) {
                            costPrice = value;
                            _checkForChanges();
                          },
                        ),
                      ),
                    ],
                  ),

                  // Profit Margin Display
                  if (sellingPrice.isNotEmpty && costPrice.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Profit Margin: ${_calculateProfitMargin()}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Inventory Section
              _buildSectionCard(
                title: "Inventory Management",
                icon: Icons.inventory,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Track inventory for this product",
                        "value": true,
                        "checked": trackInventory,
                      }
                    ],
                    value: trackInventory ? [{"label": "Track inventory for this product", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      trackInventory = values.isNotEmpty;
                      _checkForChanges();
                    },
                  ),

                  if (trackInventory) ...[
                    QNumberField(
                      label: "Stock Quantity *",
                      value: stockQuantity,
                      validator: Validator.required,
                      onChanged: (value) {
                        stockQuantity = value;
                        _checkForChanges();
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Minimum Stock",
                            value: minimumStock,
                            onChanged: (value) {
                              minimumStock = value;
                              _checkForChanges();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Maximum Stock",
                            value: maximumStock,
                            onChanged: (value) {
                              maximumStock = value;
                              _checkForChanges();
                            },
                          ),
                        ),
                      ],
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Allow backorders when out of stock",
                          "value": true,
                          "checked": allowBackorders,
                        }
                      ],
                      value: allowBackorders ? [{"label": "Allow backorders when out of stock", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        allowBackorders = values.isNotEmpty;
                        _checkForChanges();
                      },
                    ),
                  ],
                ],
              ),

              // Shipping Section
              _buildSectionCard(
                title: "Shipping Information",
                icon: Icons.local_shipping,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "This product requires shipping",
                        "value": true,
                        "checked": requiresShipping,
                      }
                    ],
                    value: requiresShipping ? [{"label": "This product requires shipping", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      requiresShipping = values.isNotEmpty;
                      _checkForChanges();
                    },
                  ),

                  if (requiresShipping) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Weight (kg)",
                            value: weight,
                            onChanged: (value) {
                              weight = value;
                              _checkForChanges();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Dimensions (L×W×H)",
                            value: dimensions,
                            hint: "e.g., 10×5×3 cm",
                            onChanged: (value) {
                              dimensions = value;
                              _checkForChanges();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),

              // Images Section
              _buildSectionCard(
                title: "Product Images",
                icon: Icons.photo_library,
                children: [
                  QMultiImagePicker(
                    label: "Product Images",
                    value: productImages,
                    maxImages: 10,
                    hint: "Add product photos (up to 10 images)",
                    helper: "Upload high-quality images to showcase your product",
                    onChanged: (value) {
                      productImages = value;
                      _checkForChanges();
                    },
                  ),
                ],
              ),

              // Settings Section
              _buildSectionCard(
                title: "Product Settings",
                icon: Icons.settings,
                children: [
                  QDropdownField(
                    label: "Product Status",
                    items: statusOptions,
                    value: productStatus,
                    onChanged: (value, label) {
                      productStatus = value;
                      _checkForChanges();
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "This product is taxable",
                        "value": true,
                        "checked": taxable,
                      }
                    ],
                    value: taxable ? [{"label": "This product is taxable", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      taxable = values.isNotEmpty;
                      _checkForChanges();
                    },
                  ),
                ],
              ),

              // Action Buttons
              SizedBox(height: spLg),
              if (hasChanges) ...[
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Discard Changes",
                        icon: Icons.cancel,
                        size: bs.md,
                        onPressed: () {
                          _resetToOriginal();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Save Changes",
                        icon: Icons.save,
                        size: bs.md,
                        onPressed: () {
                          _saveChanges();
                        },
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "No Changes to Save",
                    icon: Icons.check,
                    size: bs.md,
                    onPressed: null,
                  ),
                ),
              ],

              // Additional Actions
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Product",
                      icon: Icons.visibility,
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to product detail view
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Duplicate",
                      icon: Icons.copy,
                      size: bs.sm,
                      onPressed: () {
                        _duplicateProduct();
                      },
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

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  String _calculateProfitMargin() {
    double selling = double.tryParse(sellingPrice) ?? 0;
    double cost = double.tryParse(costPrice) ?? 0;
    
    if (selling == 0) return "0.0";
    
    double margin = ((selling - cost) / selling) * 100;
    return margin.toStringAsFixed(1);
  }

  void _showUnsavedChangesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Unsaved Changes"),
          content: Text("You have unsaved changes. What would you like to do?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetToOriginal();
                Navigator.pop(context);
              },
              child: Text("Discard Changes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Continue Editing"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _saveChanges();
              },
              child: Text("Save & Exit"),
            ),
          ],
        );
      },
    );
  }

  void _resetToOriginal() {
    productName = originalData["productName"];
    brand = originalData["brand"];
    sku = originalData["sku"];
    barcode = originalData["barcode"];
    description = originalData["description"];
    shortDescription = originalData["shortDescription"];
    selectedCategory = originalData["selectedCategory"];
    selectedSubcategory = originalData["selectedSubcategory"];
    supplier = originalData["supplier"];
    tags = originalData["tags"];
    sellingPrice = originalData["sellingPrice"];
    comparePrice = originalData["comparePrice"];
    costPrice = originalData["costPrice"];
    stockQuantity = originalData["stockQuantity"];
    minimumStock = originalData["minimumStock"];
    maximumStock = originalData["maximumStock"];
    weight = originalData["weight"];
    dimensions = originalData["dimensions"];
    productImages = List.from(originalData["productImages"]);
    productStatus = originalData["productStatus"];
    trackInventory = originalData["trackInventory"];
    allowBackorders = originalData["allowBackorders"];
    taxable = originalData["taxable"];
    requiresShipping = originalData["requiresShipping"];
    
    hasChanges = false;
    setState(() {});
    
    ss("Changes discarded, product restored to original state");
  }

  void _saveChanges() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      isLoading = false;
      hasChanges = false;
      _saveOriginalData(); // Update original data
      setState(() {});

      ss("Product updated successfully!");
    }
  }

  void _duplicateProduct() {
    ss("Product duplicated successfully!");
    // Navigate to add product with pre-filled data
  }
}

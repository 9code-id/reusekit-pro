import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm4View extends StatefulWidget {
  @override
  State<GrlForm4View> createState() => _GrlForm4ViewState();
}

class _GrlForm4ViewState extends State<GrlForm4View> {
  final formKey = GlobalKey<FormState>();
  
  String productName = "";
  String productDescription = "";
  String productPrice = "";
  String productSKU = "";
  String selectedCategory = "";
  String selectedBrand = "";
  String selectedCondition = "";
  String stockQuantity = "";
  String weight = "";
  String dimensions = "";
  String warranty = "";
  String shippingCost = "";
  List<String> productImages = [];
  String productVideo = "";
  String features = "";
  String specifications = "";
  String tags = "";
  bool featured = false;
  bool freeShipping = false;
  bool inStock = true;
  bool onSale = false;
  String salePrice = "";
  DateTime saleEndDate = DateTime.now().add(Duration(days: 30));

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
    {"label": "Toys", "value": "toys"},
    {"label": "Beauty", "value": "beauty"},
    {"label": "Automotive", "value": "automotive"},
  ];

  List<Map<String, dynamic>> brandItems = [
    {"label": "Apple", "value": "apple"},
    {"label": "Samsung", "value": "samsung"},
    {"label": "Nike", "value": "nike"},
    {"label": "Adidas", "value": "adidas"},
    {"label": "Sony", "value": "sony"},
    {"label": "LG", "value": "lg"},
    {"label": "Generic", "value": "generic"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "New", "value": "new"},
    {"label": "Like New", "value": "like_new"},
    {"label": "Very Good", "value": "very_good"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
    {"label": "Poor", "value": "poor"},
  ];

  Future<void> _saveProduct() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Product saved successfully!");
      
      //navigateTo ProductListView
    }
  }

  Future<void> _publishProduct() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Product published successfully!");
      
      //navigateTo ProductListView
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Fill in product details to add to your store");
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(30), successColor.withAlpha(30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(60)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Information",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Add detailed information about your product",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              QTextField(
                label: "Product Name",
                value: productName,
                validator: Validator.required,
                hint: "Enter a descriptive product name",
                onChanged: (value) {
                  productName = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Product Description",
                value: productDescription,
                validator: Validator.required,
                hint: "Describe your product in detail",
                onChanged: (value) {
                  productDescription = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Price (\$)",
                      value: productPrice,
                      validator: Validator.required,
                      onChanged: (value) {
                        productPrice = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "SKU",
                      value: productSKU,
                      hint: "Product identifier",
                      onChanged: (value) {
                        productSKU = value;
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
                      label: "Category",
                      items: categoryItems,
                      value: selectedCategory,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Brand",
                      items: brandItems,
                      value: selectedBrand,
                      onChanged: (value, label) {
                        selectedBrand = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QDropdownField(
                label: "Condition",
                items: conditionItems,
                value: selectedCondition,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedCondition = value;
                  setState(() {});
                },
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Inventory & Shipping",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Stock Quantity",
                            value: stockQuantity,
                            validator: Validator.required,
                            onChanged: (value) {
                              stockQuantity = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Weight (kg)",
                            value: weight,
                            onChanged: (value) {
                              weight = value;
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
                            label: "Dimensions (L×W×H)",
                            value: dimensions,
                            hint: "e.g. 10×5×3 cm",
                            onChanged: (value) {
                              dimensions = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Shipping Cost (\$)",
                            value: shippingCost,
                            onChanged: (value) {
                              shippingCost = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              QTextField(
                label: "Warranty",
                value: warranty,
                hint: "e.g. 1 year manufacturer warranty",
                onChanged: (value) {
                  warranty = value;
                  setState(() {});
                },
              ),

              QMultiImagePicker(
                label: "Product Images",
                value: productImages,
                validator: (images) {
                  if (images == null || images.isEmpty) {
                    return "At least one product image is required";
                  }
                  return null;
                },
                hint: "Upload high-quality product photos",
                onChanged: (value) {
                  productImages = value;
                  setState(() {});
                },
              ),

              QImagePicker(
                label: "Product Video (Optional)",
                value: productVideo,
                hint: "Upload a product demo video",
                onChanged: (value) {
                  productVideo = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Key Features",
                value: features,
                hint: "List the main features, one per line",
                onChanged: (value) {
                  features = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Technical Specifications",
                value: specifications,
                hint: "Detailed technical specs",
                onChanged: (value) {
                  specifications = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Tags",
                value: tags,
                hint: "Separate tags with commas (e.g. electronics, gadget, smart)",
                onChanged: (value) {
                  tags = value;
                  setState(() {});
                },
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Sales & Promotions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Featured Product",
                          "value": "featured",
                          "checked": featured,
                        },
                        {
                          "label": "Free Shipping",
                          "value": "free_shipping",
                          "checked": freeShipping,
                        },
                        {
                          "label": "In Stock",
                          "value": "in_stock",
                          "checked": inStock,
                        },
                        {
                          "label": "On Sale",
                          "value": "on_sale",
                          "checked": onSale,
                        }
                      ],
                      value: [
                        if (featured) {"label": "Featured Product", "value": "featured", "checked": true},
                        if (freeShipping) {"label": "Free Shipping", "value": "free_shipping", "checked": true},
                        if (inStock) {"label": "In Stock", "value": "in_stock", "checked": true},
                        if (onSale) {"label": "On Sale", "value": "on_sale", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        featured = values.any((v) => v["value"] == "featured");
                        freeShipping = values.any((v) => v["value"] == "free_shipping");
                        inStock = values.any((v) => v["value"] == "in_stock");
                        onSale = values.any((v) => v["value"] == "on_sale");
                        setState(() {});
                      },
                    ),

                    if (onSale) ...[
                      Row(
                        children: [
                          Expanded(
                            child: QNumberField(
                              label: "Sale Price (\$)",
                              value: salePrice,
                              validator: onSale ? Validator.required : null,
                              onChanged: (value) {
                                salePrice = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDatePicker(
                              label: "Sale End Date",
                              value: saleEndDate,
                              onChanged: (value) {
                                saleEndDate = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your product will be reviewed before going live. Ensure all information is accurate and complete.",
                        style: TextStyle(
                          fontSize: 13,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      size: bs.sm,
                      onPressed: _saveProduct,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Publish Product",
                      size: bs.md,
                      onPressed: _publishProduct,
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
}

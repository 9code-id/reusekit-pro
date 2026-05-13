import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProductVariantsView extends StatefulWidget {
  const PosProductVariantsView({super.key});

  @override
  State<PosProductVariantsView> createState() => _PosProductVariantsViewState();
}

class _PosProductVariantsViewState extends State<PosProductVariantsView> {
  String searchQuery = "";
  String selectedProduct = "";
  bool isLoading = false;
  
  // Variant form fields
  String variantName = "";
  String variantPrice = "";
  String variantCost = "";
  String variantSku = "";
  String variantBarcode = "";
  bool variantActive = true;

  List<Map<String, dynamic>> products = [
    {"label": "All Products", "value": ""},
    {"label": "Cappuccino", "value": "prod_001"},
    {"label": "Chocolate Croissant", "value": "prod_002"},
    {"label": "Fresh Orange Juice", "value": "prod_003"},
    {"label": "Caesar Salad", "value": "prod_004"},
    {"label": "Green Tea Latte", "value": "prod_005"},
  ];

  List<Map<String, dynamic>> variants = [
    {
      "id": "var_001",
      "product_id": "prod_001",
      "product_name": "Cappuccino",
      "name": "Small",
      "price": 3.50,
      "cost": 1.00,
      "sku": "BEV-CAP-001-S",
      "barcode": "1234567890130",
      "stock": 45,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 156,
      "last_sold": "2024-12-19 14:30:00"
    },
    {
      "id": "var_002",
      "product_id": "prod_001",
      "product_name": "Cappuccino",
      "name": "Medium",
      "price": 4.50,
      "cost": 1.25,
      "sku": "BEV-CAP-001-M",
      "barcode": "1234567890131",
      "stock": 67,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 234,
      "last_sold": "2024-12-19 13:45:00"
    },
    {
      "id": "var_003",
      "product_id": "prod_001",
      "product_name": "Cappuccino",
      "name": "Large",
      "price": 5.50,
      "cost": 1.50,
      "sku": "BEV-CAP-001-L",
      "barcode": "1234567890132",
      "stock": 38,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 189,
      "last_sold": "2024-12-19 12:20:00"
    },
    {
      "id": "var_004",
      "product_id": "prod_002",
      "product_name": "Chocolate Croissant",
      "name": "Regular",
      "price": 3.25,
      "cost": 0.85,
      "sku": "PAS-CHO-001-R",
      "barcode": "1234567890140",
      "stock": 24,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 89,
      "last_sold": "2024-12-19 11:15:00"
    },
    {
      "id": "var_005",
      "product_id": "prod_002",
      "product_name": "Chocolate Croissant",
      "name": "Mini",
      "price": 2.25,
      "cost": 0.65,
      "sku": "PAS-CHO-001-MINI",
      "barcode": "1234567890141",
      "stock": 0,
      "is_active": false,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 23,
      "last_sold": "2024-12-15 16:30:00"
    },
    {
      "id": "var_006",
      "product_id": "prod_003",
      "product_name": "Fresh Orange Juice",
      "name": "Small (8oz)",
      "price": 4.50,
      "cost": 1.50,
      "sku": "BEV-ORA-001-S",
      "barcode": "1234567890150",
      "stock": 18,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 67,
      "last_sold": "2024-12-19 10:45:00"
    },
    {
      "id": "var_007",
      "product_id": "prod_003",
      "product_name": "Fresh Orange Juice",
      "name": "Large (16oz)",
      "price": 6.50,
      "cost": 2.10,
      "sku": "BEV-ORA-001-L",
      "barcode": "1234567890151",
      "stock": 22,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "total_sold": 45,
      "last_sold": "2024-12-19 09:30:00"
    },
  ];

  List<Map<String, dynamic>> get filteredVariants {
    return variants.where((variant) {
      bool matchesSearch = variant["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          variant["product_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          variant["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProduct = selectedProduct.isEmpty || variant["product_id"] == selectedProduct;
      
      return matchesSearch && matchesProduct;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Variants"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddVariantModal();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo('VariantAnalyticsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildVariantStats(),
          Expanded(
            child: _buildVariantList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search variants...",
                  value: searchQuery,
                  hint: "Name, product, or SKU",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                icon: Icons.search,
                size: bs.md,
                onPressed: () {},
              ),
            ],
          ),
          
          QDropdownField(
            label: "Filter by Product",
            items: products,
            value: selectedProduct,
            onChanged: (value, label) {
              selectedProduct = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVariantStats() {
    int totalVariants = variants.length;
    int activeVariants = variants.where((v) => v["is_active"] as bool).length;
    int outOfStock = variants.where((v) => (v["stock"] as int) == 0).length;
    double avgPrice = variants.isNotEmpty 
        ? (variants.fold(0.0, (sum, v) => sum + (v["price"] as double)) / variants.length)
        : 0.0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: _buildStatCard(
              title: "Total",
              value: totalVariants.toString(),
              color: primaryColor,
              icon: Icons.tune,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Active",
              value: activeVariants.toString(),
              color: successColor,
              icon: Icons.check_circle,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Out of Stock",
              value: outOfStock.toString(),
              color: dangerColor,
              icon: Icons.warning,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Avg Price",
              value: "\$${avgPrice.toStringAsFixed(2)}",
              color: warningColor,
              icon: Icons.attach_money,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (filteredVariants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.tune,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No variants found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Add Variant",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                _showAddVariantModal();
              },
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: filteredVariants.map((variant) {
          return _buildVariantCard(variant);
        }).toList(),
      ),
    );
  }

  Widget _buildVariantCard(Map<String, dynamic> variant) {
    bool isOutOfStock = (variant["stock"] as int) == 0;
    bool isInactive = !(variant["is_active"] as bool);
    double profitMargin = ((variant["price"] as double) - (variant["cost"] as double)) / (variant["price"] as double) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isOutOfStock ? dangerColor :
                 isInactive ? disabledColor :
                 disabledOutlineBorderColor,
          width: isOutOfStock || isInactive ? 2 : 1,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${variant["product_name"]} - ${variant["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (isOutOfStock)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OUT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (isInactive)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "INACTIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text(
                          "SKU: ${variant["sku"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Stock: ${variant["stock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOutOfStock ? dangerColor : successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: _buildVariantMetric(
                  label: "Price",
                  value: "\$${(variant["price"] as double).toStringAsFixed(2)}",
                  color: primaryColor,
                  icon: Icons.attach_money,
                ),
              ),
              Expanded(
                child: _buildVariantMetric(
                  label: "Cost",
                  value: "\$${(variant["cost"] as double).toStringAsFixed(2)}",
                  color: warningColor,
                  icon: Icons.receipt,
                ),
              ),
              Expanded(
                child: _buildVariantMetric(
                  label: "Profit",
                  value: "${profitMargin.toStringAsFixed(1)}%",
                  color: successColor,
                  icon: Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildVariantMetric(
                  label: "Sold",
                  value: "${variant["total_sold"]}",
                  color: infoColor,
                  icon: Icons.shopping_cart,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Barcode: ${variant["barcode"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last Sold: ${DateTime.parse(variant["last_sold"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      _showEditVariantModal(variant);
                    },
                  ),
                  QButton(
                    icon: Icons.content_copy,
                    size: bs.sm,
                    onPressed: () {
                      _duplicateVariant(variant);
                    },
                  ),
                  QButton(
                    icon: Icons.add_shopping_cart,
                    size: bs.sm,
                    onPressed: isOutOfStock ? null : () {
                      ss("${variant["product_name"]} - ${variant["name"]} added to cart");
                    },
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      _showVariantOptions(variant);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantMetric({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddVariantModal() {
    variantName = "";
    variantPrice = "";
    variantCost = "";
    variantSku = "";
    variantBarcode = "";
    variantActive = true;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            top: spMd,
            left: spMd,
            right: spMd,
            bottom: MediaQuery.of(context).viewInsets.bottom + spMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Add New Variant",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              QDropdownField(
                label: "Product",
                items: products.where((p) => p["value"].isNotEmpty).toList(),
                value: selectedProduct,
                onChanged: (value, label) {
                  selectedProduct = value;
                  setModalState(() {});
                },
              ),
              
              QTextField(
                label: "Variant Name",
                value: variantName,
                hint: "e.g., Small, Medium, Large",
                onChanged: (value) {
                  variantName = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Price (\$)",
                      value: variantPrice,
                      onChanged: (value) {
                        variantPrice = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QNumberField(
                      label: "Cost (\$)",
                      value: variantCost,
                      onChanged: (value) {
                        variantCost = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "SKU",
                value: variantSku,
                hint: "Enter variant SKU",
                onChanged: (value) {
                  variantSku = value;
                  setModalState(() {});
                },
              ),
              
              QTextField(
                label: "Barcode",
                value: variantBarcode,
                hint: "Enter or scan barcode",
                onChanged: (value) {
                  variantBarcode = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Variant Active",
                          "value": true,
                          "checked": variantActive,
                        }
                      ],
                      value: [
                        if (variantActive)
                          {
                            "label": "Variant Active",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        variantActive = values.isNotEmpty;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Variant",
                  size: bs.md,
                  onPressed: _canAddVariant() ? () {
                    _addVariant();
                    Navigator.pop(context);
                  } : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditVariantModal(Map<String, dynamic> variant) {
    variantName = variant["name"];
    variantPrice = (variant["price"] as double).toString();
    variantCost = (variant["cost"] as double).toString();
    variantSku = variant["sku"];
    variantBarcode = variant["barcode"];
    variantActive = variant["is_active"];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            top: spMd,
            left: spMd,
            right: spMd,
            bottom: MediaQuery.of(context).viewInsets.bottom + spMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Edit Variant",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              Text(
                "${variant["product_name"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              QTextField(
                label: "Variant Name",
                value: variantName,
                hint: "e.g., Small, Medium, Large",
                onChanged: (value) {
                  variantName = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Price (\$)",
                      value: variantPrice,
                      onChanged: (value) {
                        variantPrice = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QNumberField(
                      label: "Cost (\$)",
                      value: variantCost,
                      onChanged: (value) {
                        variantCost = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "SKU",
                value: variantSku,
                hint: "Enter variant SKU",
                onChanged: (value) {
                  variantSku = value;
                  setModalState(() {});
                },
              ),
              
              QTextField(
                label: "Barcode",
                value: variantBarcode,
                hint: "Enter or scan barcode",
                onChanged: (value) {
                  variantBarcode = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Variant Active",
                          "value": true,
                          "checked": variantActive,
                        }
                      ],
                      value: [
                        if (variantActive)
                          {
                            "label": "Variant Active",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        variantActive = values.isNotEmpty;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: _canAddVariant() ? () {
                    _updateVariant(variant);
                    Navigator.pop(context);
                  } : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canAddVariant() {
    return variantName.isNotEmpty && 
           variantPrice.isNotEmpty && 
           variantCost.isNotEmpty &&
           variantSku.isNotEmpty;
  }

  void _addVariant() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    
    variants.add({
      "id": "var_${DateTime.now().millisecondsSinceEpoch}",
      "product_id": selectedProduct,
      "product_name": products.firstWhere((p) => p["value"] == selectedProduct)["label"],
      "name": variantName,
      "price": double.tryParse(variantPrice) ?? 0,
      "cost": double.tryParse(variantCost) ?? 0,
      "sku": variantSku,
      "barcode": variantBarcode,
      "stock": 0,
      "is_active": variantActive,
      "created_date": DateTime.now().toIso8601String(),
      "total_sold": 0,
      "last_sold": DateTime.now().toIso8601String(),
    });
    
    hideLoading();
    setState(() {});
    ss("Variant added successfully");
  }

  void _updateVariant(Map<String, dynamic> variant) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    
    int index = variants.indexWhere((v) => v["id"] == variant["id"]);
    if (index != -1) {
      variants[index]["name"] = variantName;
      variants[index]["price"] = double.tryParse(variantPrice) ?? 0;
      variants[index]["cost"] = double.tryParse(variantCost) ?? 0;
      variants[index]["sku"] = variantSku;
      variants[index]["barcode"] = variantBarcode;
      variants[index]["is_active"] = variantActive;
    }
    
    hideLoading();
    setState(() {});
    ss("Variant updated successfully");
  }

  void _duplicateVariant(Map<String, dynamic> variant) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    
    variants.add({
      "id": "var_${DateTime.now().millisecondsSinceEpoch}",
      "product_id": variant["product_id"],
      "product_name": variant["product_name"],
      "name": "${variant["name"]} (Copy)",
      "price": variant["price"],
      "cost": variant["cost"],
      "sku": "${variant["sku"]}-COPY",
      "barcode": "",
      "stock": 0,
      "is_active": true,
      "created_date": DateTime.now().toIso8601String(),
      "total_sold": 0,
      "last_sold": DateTime.now().toIso8601String(),
    });
    
    hideLoading();
    setState(() {});
    ss("Variant duplicated successfully");
  }

  void _showVariantOptions(Map<String, dynamic> variant) {
    // Variant options implementation
  }
}

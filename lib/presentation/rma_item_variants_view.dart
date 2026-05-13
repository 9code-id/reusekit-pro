import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaItemVariantsView extends StatefulWidget {
  const RmaItemVariantsView({super.key});

  @override
  State<RmaItemVariantsView> createState() => _RmaItemVariantsViewState();
}

class _RmaItemVariantsViewState extends State<RmaItemVariantsView> {
  final formKey = GlobalKey<FormState>();
  
  // Item information (would be passed from previous screen)
  Map<String, dynamic> itemData = {
    "id": "item_001",
    "name": "Grilled Chicken Breast",
    "category": "Main Course",
    "basePrice": 24.99,
    "image": "https://picsum.photos/300/200?random=1&keyword=chicken"
  };
  
  // Variants data
  List<Map<String, dynamic>> variants = [
    {
      "id": "var_001",
      "name": "Regular",
      "price": 24.99,
      "cost": 8.50,
      "sku": "GCB-REG",
      "stock": 25,
      "minStock": 5,
      "status": "active",
      "weight": "250g",
      "calories": 420,
      "isDefault": true,
      "salesCount": 145,
      "lastSold": "2024-01-15T14:30:00",
    },
    {
      "id": "var_002",
      "name": "Large",
      "price": 29.99,
      "cost": 11.20,
      "sku": "GCB-LRG",
      "stock": 18,
      "minStock": 5,
      "status": "active",
      "weight": "350g",
      "calories": 580,
      "isDefault": false,
      "salesCount": 89,
      "lastSold": "2024-01-15T13:45:00",
    },
    {
      "id": "var_003",
      "name": "Small",
      "price": 19.99,
      "cost": 6.75,
      "sku": "GCB-SML",
      "stock": 3,
      "minStock": 5,
      "status": "low_stock",
      "weight": "180g",
      "calories": 300,
      "isDefault": false,
      "salesCount": 67,
      "lastSold": "2024-01-15T12:20:00",
    },
    {
      "id": "var_004",
      "name": "Family Size",
      "price": 45.99,
      "cost": 18.50,
      "sku": "GCB-FAM",
      "stock": 0,
      "minStock": 3,
      "status": "out_of_stock",
      "weight": "600g",
      "calories": 840,
      "isDefault": false,
      "salesCount": 23,
      "lastSold": "2024-01-14T19:15:00",
    },
  ];
  
  // Form fields for new variant
  String variantName = "";
  String variantPrice = "";
  String variantCost = "";
  String variantSku = "";
  String variantStock = "";
  String variantWeight = "";
  String variantCalories = "";
  bool isDefault = false;
  
  // State
  bool showAddForm = false;
  bool loading = false;
  String searchQuery = "";
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Variants", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Low Stock", "value": "low_stock"},
    {"label": "Out of Stock", "value": "out_of_stock"},
  ];
  
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredVariants = variants.where((variant) {
      bool matchesSearch = "${variant["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${variant["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = selectedFilter == "all" || variant["status"] == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Variants"),
        actions: [
          if (loading)
            Container(
              margin: EdgeInsets.all(spSm),
              child: CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${itemData["image"]}",
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
                          "${itemData["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${itemData["category"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Base Price: \$${(itemData["basePrice"] as double).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: showAddForm ? "Cancel" : "Add Variant",
                    icon: showAddForm ? Icons.close : Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      showAddForm = !showAddForm;
                      if (!showAddForm) {
                        _clearForm();
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Total Variants",
                  "${variants.length}",
                  Icons.inventory_2,
                  primaryColor,
                ),
                _buildStatCard(
                  "Active",
                  "${variants.where((v) => v["status"] == "active").length}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildStatCard(
                  "Low Stock",
                  "${variants.where((v) => v["status"] == "low_stock").length}",
                  Icons.warning,
                  warningColor,
                ),
                _buildStatCard(
                  "Out of Stock",
                  "${variants.where((v) => v["status"] == "out_of_stock").length}",
                  Icons.error,
                  dangerColor,
                ),
              ],
            ),
            
            // Add Variant Form
            if (showAddForm)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Variant",
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
                            flex: 2,
                            child: QTextField(
                              label: "Variant Name",
                              value: variantName,
                              validator: Validator.required,
                              onChanged: (value) {
                                variantName = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QTextField(
                              label: "SKU",
                              value: variantSku,
                              validator: Validator.required,
                              onChanged: (value) {
                                variantSku = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QNumberField(
                              label: "Price (\$)",
                              value: variantPrice,
                              validator: Validator.required,
                              onChanged: (value) {
                                variantPrice = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Cost (\$)",
                              value: variantCost,
                              validator: Validator.required,
                              onChanged: (value) {
                                variantCost = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Stock",
                              value: variantStock,
                              validator: Validator.required,
                              onChanged: (value) {
                                variantStock = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Weight",
                              value: variantWeight,
                              onChanged: (value) {
                                variantWeight = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QNumberField(
                              label: "Calories",
                              value: variantCalories,
                              onChanged: (value) {
                                variantCalories = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QSwitch(
                        items: [
                          {
                            "label": "Set as default variant",
                            "value": true,
                            "checked": isDefault,
                          }
                        ],
                        value: isDefault ? [{"label": "Set as default variant", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          isDefault = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: loading ? "Adding..." : "Add Variant",
                          size: bs.md,
                          onPressed: loading ? () {} : _addVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Search and Filter
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search variants...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Filter by Status",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Variants List
            Text(
              "Variants (${filteredVariants.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            if (filteredVariants.isEmpty)
              Container(
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No variants found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            
            ...List.generate(filteredVariants.length, (index) {
              final variant = filteredVariants[index];
              return _buildVariantCard(variant);
            }),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVariantCard(Map<String, dynamic> variant) {
    Color statusColor = _getStatusColor(variant["status"]);
    String statusLabel = _getStatusLabel(variant["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: variant["isDefault"] == true 
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${variant["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (variant["isDefault"] == true) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "DEFAULT",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "SKU: ${variant["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: statusColor.withAlpha(50)),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          // Price and Cost Info
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildInfoItem("Price", "\$${(variant["price"] as double).currency}", successColor),
              _buildInfoItem("Cost", "\$${(variant["cost"] as double).currency}", warningColor),
              _buildInfoItem("Stock", "${variant["stock"]}", 
                  (variant["stock"] as int) <= (variant["minStock"] as int) ? dangerColor : successColor),
              _buildInfoItem("Sales", "${variant["salesCount"]}", primaryColor),
            ],
          ),
          
          // Additional Info
          if (variant["weight"] != null || variant["calories"] != null)
            Row(
              children: [
                if (variant["weight"] != null) ...[
                  Icon(
                    Icons.monitor_weight,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${variant["weight"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                ],
                if (variant["calories"] != null) ...[
                  Icon(
                    Icons.local_fire_department,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${variant["calories"]} cal",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          
          // Profit Margin
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profit Margin:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(((variant["price"] as double) - (variant["cost"] as double)) / (variant["price"] as double) * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
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
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo(RmaEditVariantView());
                  },
                ),
              ),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () => _deleteVariant(variant["id"]),
              ),
              if (!variant["isDefault"])
                QButton(
                  label: "Set Default",
                  size: bs.sm,
                  onPressed: () => _setDefaultVariant(variant["id"]),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "low_stock":
        return warningColor;
      case "out_of_stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "low_stock":
        return "Low Stock";
      case "out_of_stock":
        return "Out of Stock";
      default:
        return "Unknown";
    }
  }
  
  void _addVariant() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    // Add new variant
    variants.add({
      "id": "var_${DateTime.now().millisecondsSinceEpoch}",
      "name": variantName,
      "price": double.tryParse(variantPrice) ?? 0.0,
      "cost": double.tryParse(variantCost) ?? 0.0,
      "sku": variantSku,
      "stock": int.tryParse(variantStock) ?? 0,
      "minStock": 5,
      "status": "active",
      "weight": variantWeight.isNotEmpty ? variantWeight : null,
      "calories": variantCalories.isNotEmpty ? int.tryParse(variantCalories) : null,
      "isDefault": isDefault,
      "salesCount": 0,
      "lastSold": null,
    });
    
    // If set as default, update other variants
    if (isDefault) {
      for (var variant in variants) {
        if (variant["id"] != variants.last["id"]) {
          variant["isDefault"] = false;
        }
      }
    }
    
    _clearForm();
    showAddForm = false;
    loading = false;
    setState(() {});
    
    ss("Variant added successfully!");
  }
  
  void _deleteVariant(String variantId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this variant?");
    if (!isConfirmed) return;
    
    variants.removeWhere((variant) => variant["id"] == variantId);
    setState(() {});
    
    ss("Variant deleted successfully!");
  }
  
  void _setDefaultVariant(String variantId) async {
    // Update all variants
    for (var variant in variants) {
      variant["isDefault"] = variant["id"] == variantId;
    }
    setState(() {});
    
    ss("Default variant updated!");
  }
  
  void _clearForm() {
    variantName = "";
    variantPrice = "";
    variantCost = "";
    variantSku = "";
    variantStock = "";
    variantWeight = "";
    variantCalories = "";
    isDefault = false;
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPricingManagementView extends StatefulWidget {
  const PosPricingManagementView({super.key});

  @override
  State<PosPricingManagementView> createState() => _PosPricingManagementViewState();
}

class _PosPricingManagementViewState extends State<PosPricingManagementView> {
  String selectedCategory = "all";
  String searchQuery = "";
  String selectedPriceRule = "regular";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Books", "value": "books"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> priceRules = [
    {"label": "Regular Price", "value": "regular"},
    {"label": "Member Price", "value": "member"},
    {"label": "Wholesale Price", "value": "wholesale"},
    {"label": "Bulk Discount", "value": "bulk"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Wireless Headphones",
      "sku": "WH-001",
      "category": "electronics",
      "cost": 45.00,
      "regular_price": 89.99,
      "member_price": 79.99,
      "wholesale_price": 65.00,
      "bulk_price": 60.00,
      "margin": 50.0,
      "status": "active",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
    },
    {
      "id": "prod_002",
      "name": "Cotton T-Shirt",
      "sku": "CT-002",
      "category": "clothing",
      "cost": 8.50,
      "regular_price": 24.99,
      "member_price": 22.49,
      "wholesale_price": 18.00,
      "bulk_price": 16.00,
      "margin": 65.9,
      "status": "active",
      "image": "https://picsum.photos/80/80?random=2&keyword=shirt"
    },
    {
      "id": "prod_003",
      "name": "Coffee Beans 1kg",
      "sku": "CB-003",
      "category": "food",
      "cost": 12.00,
      "regular_price": 32.99,
      "member_price": 29.69,
      "wholesale_price": 25.00,
      "bulk_price": 22.00,
      "margin": 63.6,
      "status": "active",
      "image": "https://picsum.photos/80/80?random=3&keyword=coffee"
    },
    {
      "id": "prod_004",
      "name": "Programming Book",
      "sku": "PB-004",
      "category": "books",
      "cost": 15.00,
      "regular_price": 49.99,
      "member_price": 44.99,
      "wholesale_price": 35.00,
      "bulk_price": 30.00,
      "margin": 70.0,
      "status": "inactive",
      "image": "https://picsum.photos/80/80?random=4&keyword=book"
    },
    {
      "id": "prod_005",
      "name": "Garden Tools Set",
      "sku": "GT-005",
      "category": "home",
      "cost": 25.00,
      "regular_price": 79.99,
      "member_price": 71.99,
      "wholesale_price": 55.00,
      "bulk_price": 50.00,
      "margin": 68.8,
      "status": "active",
      "image": "https://picsum.photos/80/80?random=5&keyword=garden"
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == "all" || product["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _updatePrice(String productId, String priceType, double newPrice) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final productIndex = products.indexWhere((p) => p["id"] == productId);
    if (productIndex != -1) {
      products[productIndex][priceType] = newPrice;
      
      // Recalculate margin
      final cost = products[productIndex]["cost"] as double;
      final regularPrice = products[productIndex]["regular_price"] as double;
      products[productIndex]["margin"] = ((regularPrice - cost) / regularPrice * 100);
    }

    loading = false;
    setState(() {});
    ss("Price updated successfully");
  }

  void _bulkUpdatePrices() async {
    bool isConfirmed = await confirm("Apply bulk price update to ${filteredProducts.length} products?");
    if (isConfirmed) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(milliseconds: 1000));

      loading = false;
      setState(() {});
      ss("Bulk price update completed");
    }
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Products",
                  value: searchQuery,
                  hint: "Enter product name or SKU",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Price Rule",
                  items: priceRules,
                  value: selectedPriceRule,
                  onChanged: (value, label) {
                    selectedPriceRule = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStats() {
    final activeProducts = products.where((p) => p["status"] == "active").length;
    final averageMargin = products.where((p) => p["status"] == "active")
        .map((p) => p["margin"] as double)
        .fold(0.0, (sum, margin) => sum + margin) / activeProducts;
    final totalRevenue = products.where((p) => p["status"] == "active")
        .map((p) => p["regular_price"] as double)
        .fold(0.0, (sum, price) => sum + price);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.inventory,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$activeProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Active Products",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${averageMargin.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Avg Margin",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.attach_money,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${totalRevenue.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Total Value",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final cost = product["cost"] as double;
    final regularPrice = product["regular_price"] as double;
    final memberPrice = product["member_price"] as double;
    final wholesalePrice = product["wholesale_price"] as double;
    final bulkPrice = product["bulk_price"] as double;
    final margin = product["margin"] as double;
    final isActive = product["status"] == "active";

    Color marginColor = successColor;
    if (margin < 30) marginColor = dangerColor;
    else if (margin < 50) marginColor = warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isActive ? disabledOutlineBorderColor : dangerColor,
          width: isActive ? 1 : 2,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    Text(
                      "SKU: ${product["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: marginColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${margin.toStringAsFixed(1)}% margin",
                            style: TextStyle(
                              fontSize: 10,
                              color: marginColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isActive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isActive ? "ACTIVE" : "INACTIVE",
                            style: TextStyle(
                              fontSize: 10,
                              color: isActive ? successColor : dangerColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showEditPriceDialog(product);
                },
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${cost.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Regular",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${regularPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Member",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${memberPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wholesale",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${wholesalePrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditPriceDialog(Map<String, dynamic> product) {
    String regularPrice = (product["regular_price"] as double).toString();
    String memberPrice = (product["member_price"] as double).toString();
    String wholesalePrice = (product["wholesale_price"] as double).toString();
    String bulkPrice = (product["bulk_price"] as double).toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Prices - ${product["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Regular Price (\$)",
              value: regularPrice,
              onChanged: (value) {
                regularPrice = value;
              },
            ),
            QNumberField(
              label: "Member Price (\$)",
              value: memberPrice,
              onChanged: (value) {
                memberPrice = value;
              },
            ),
            QNumberField(
              label: "Wholesale Price (\$)",
              value: wholesalePrice,
              onChanged: (value) {
                wholesalePrice = value;
              },
            ),
            QNumberField(
              label: "Bulk Price (\$)",
              value: bulkPrice,
              onChanged: (value) {
                bulkPrice = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              _updatePrice(product["id"], "regular_price", double.tryParse(regularPrice) ?? 0.0);
              _updatePrice(product["id"], "member_price", double.tryParse(memberPrice) ?? 0.0);
              _updatePrice(product["id"], "wholesale_price", double.tryParse(wholesalePrice) ?? 0.0);
              _updatePrice(product["id"], "bulk_price", double.tryParse(bulkPrice) ?? 0.0);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.update),
            onPressed: _bulkUpdatePrices,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPricingStats(),
            _buildFilters(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products (${filteredProducts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Bulk Update",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: _bulkUpdatePrices,
                ),
              ],
            ),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              ...filteredProducts.map((product) => _buildProductCard(product)),
          ],
        ),
      ),
    );
  }
}

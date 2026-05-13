import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductVariantsView extends StatefulWidget {
  const SpaProductVariantsView({super.key});

  @override
  State<SpaProductVariantsView> createState() => _SpaProductVariantsViewState();
}

class _SpaProductVariantsViewState extends State<SpaProductVariantsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedBrand = "All";
  
  List<String> categories = ["All", "Skincare", "Hair Care", "Aromatherapy", "Equipment", "Accessories"];
  List<String> brands = ["All", "LuxeSpa Pro", "AromaElite", "ThermalSpa", "NaturalGlow", "SalonGrade"];
  
  Map<String, dynamic> selectedProduct = {
    "id": "PROD001",
    "name": "Premium Anti-Aging Serum",
    "brand": "LuxeSpa Pro",
    "category": "Skincare",
    "basePrice": 89.99,
    "description": "Advanced anti-aging formula with hyaluronic acid and peptides",
    "image": "https://picsum.photos/300/300?random=1&keyword=serum",
    "inStock": true,
    "totalVariants": 12,
    "activeVariants": 10
  };
  
  List<Map<String, dynamic>> productVariants = [
    {
      "id": "VAR001",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - 30ml",
      "size": "30ml",
      "color": null,
      "material": null,
      "scent": "Unscented",
      "sku": "PAS-30-UN",
      "price": 89.99,
      "compareAtPrice": 109.99,
      "costPrice": 45.00,
      "stockQuantity": 156,
      "lowStockThreshold": 20,
      "weight": 0.05,
      "dimensions": "3x3x8 cm",
      "image": "https://picsum.photos/200/200?random=1&keyword=serum",
      "isActive": true,
      "isDefault": true,
      "popularity": 95
    },
    {
      "id": "VAR002",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - 50ml",
      "size": "50ml",
      "color": null,
      "material": null,
      "scent": "Unscented",
      "sku": "PAS-50-UN",
      "price": 149.99,
      "compareAtPrice": 179.99,
      "costPrice": 75.00,
      "stockQuantity": 89,
      "lowStockThreshold": 15,
      "weight": 0.08,
      "dimensions": "4x4x10 cm",
      "image": "https://picsum.photos/200/200?random=2&keyword=serum",
      "isActive": true,
      "isDefault": false,
      "popularity": 88
    },
    {
      "id": "VAR003",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - 30ml Rose",
      "size": "30ml",
      "color": null,
      "material": null,
      "scent": "Rose",
      "sku": "PAS-30-RS",
      "price": 94.99,
      "compareAtPrice": 114.99,
      "costPrice": 48.00,
      "stockQuantity": 67,
      "lowStockThreshold": 20,
      "weight": 0.05,
      "dimensions": "3x3x8 cm",
      "image": "https://picsum.photos/200/200?random=3&keyword=rose",
      "isActive": true,
      "isDefault": false,
      "popularity": 82
    },
    {
      "id": "VAR004",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - 30ml Lavender",
      "size": "30ml",
      "color": null,
      "material": null,
      "scent": "Lavender",
      "sku": "PAS-30-LV",
      "price": 94.99,
      "compareAtPrice": 114.99,
      "costPrice": 48.00,
      "stockQuantity": 23,
      "lowStockThreshold": 20,
      "weight": 0.05,
      "dimensions": "3x3x8 cm",
      "image": "https://picsum.photos/200/200?random=4&keyword=lavender",
      "isActive": true,
      "isDefault": false,
      "popularity": 79
    },
    {
      "id": "VAR005",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - Travel Size 15ml",
      "size": "15ml",
      "color": null,
      "material": null,
      "scent": "Unscented",
      "sku": "PAS-15-UN",
      "price": 54.99,
      "compareAtPrice": 69.99,
      "costPrice": 28.00,
      "stockQuantity": 134,
      "lowStockThreshold": 25,
      "weight": 0.03,
      "dimensions": "2x2x6 cm",
      "image": "https://picsum.photos/200/200?random=5&keyword=travel",
      "isActive": true,
      "isDefault": false,
      "popularity": 91
    },
    {
      "id": "VAR006",
      "productId": "PROD001",
      "name": "Premium Anti-Aging Serum - Gift Set",
      "size": "30ml + 15ml",
      "color": null,
      "material": null,
      "scent": "Mixed",
      "sku": "PAS-GS-MX",
      "price": 124.99,
      "compareAtPrice": 159.99,
      "costPrice": 65.00,
      "stockQuantity": 45,
      "lowStockThreshold": 10,
      "weight": 0.12,
      "dimensions": "15x10x8 cm",
      "image": "https://picsum.photos/200/200?random=6&keyword=gift",
      "isActive": true,
      "isDefault": false,
      "popularity": 85
    }
  ];
  
  List<Map<String, dynamic>> products = [
    {
      "id": "PROD001",
      "name": "Premium Anti-Aging Serum",
      "brand": "LuxeSpa Pro",
      "category": "Skincare",
      "image": "https://picsum.photos/150/150?random=1&keyword=serum",
      "variants": 6,
      "basePrice": 54.99,
      "topPrice": 149.99,
      "totalStock": 514,
      "isActive": true
    },
    {
      "id": "PROD002",
      "name": "Essential Oil Diffuser",
      "brand": "AromaElite",
      "category": "Aromatherapy",
      "image": "https://picsum.photos/150/150?random=2&keyword=diffuser",
      "variants": 4,
      "basePrice": 129.99,
      "topPrice": 299.99,
      "totalStock": 87,
      "isActive": true
    },
    {
      "id": "PROD003",
      "name": "Massage Stone Set",
      "brand": "ThermalSpa",
      "category": "Equipment",
      "image": "https://picsum.photos/150/150?random=3&keyword=stones",
      "variants": 3,
      "basePrice": 89.99,
      "topPrice": 199.99,
      "totalStock": 156,
      "isActive": true
    },
    {
      "id": "PROD004",
      "name": "Hair Treatment Mask",
      "brand": "SalonGrade",
      "category": "Hair Care",
      "image": "https://picsum.photos/150/150?random=4&keyword=hair",
      "variants": 8,
      "basePrice": 29.99,
      "topPrice": 89.99,
      "totalStock": 267,
      "isActive": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _getFilteredProducts();
    List<Map<String, dynamic>> filteredVariants = _getFilteredVariants();
    
    return QTabBar(
      title: "Product Variants",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Products", icon: Icon(Icons.inventory)),
        Tab(text: "Variants", icon: Icon(Icons.tune)),
      ],
      tabChildren: [
        _buildProductsTab(filteredProducts),
        _buildVariantsTab(filteredVariants),
      ],
    );
  }
  
  Widget _buildProductsTab(List<Map<String, dynamic>> products) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search products...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
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
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Brand",
                        items: brands.map((brand) => {"label": brand, "value": brand}).toList(),
                        value: selectedBrand,
                        onChanged: (value, label) {
                          selectedBrand = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Product Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Product Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Total Products", "${products.length}", primaryColor, Icons.inventory),
                    _buildStatCard("Total Variants", "${products.fold(0, (sum, product) => sum + (product["variants"] as int))}", successColor, Icons.tune),
                    _buildStatCard("Total Stock", "${products.fold(0, (sum, product) => sum + (product["totalStock"] as int))}", infoColor, Icons.storage),
                    _buildStatCard("Active Products", "${products.where((p) => p["isActive"]).length}", warningColor, Icons.check_circle),
                  ],
                ),
              ],
            ),
          ),
          
          // Products Grid
          if (products.isNotEmpty)
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: products.map((product) => _buildProductCard(product)).toList(),
            )
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No products found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildVariantsTab(List<Map<String, dynamic>> variants) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Selected Product Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Managing Variants For:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${selectedProduct["image"]}",
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
                            "${selectedProduct["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${selectedProduct["brand"]} • ${selectedProduct["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${selectedProduct["totalVariants"]} variants (${selectedProduct["activeVariants"]} active)",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Change Product",
                      size: bs.sm,
                      icon: Icons.swap_horiz,
                      color: infoColor,
                      onPressed: () {
                        _changeProduct();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Variant Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Variant Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Variant",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        _addVariant();
                      },
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Total Variants", "${variants.length}", primaryColor, Icons.tune),
                    _buildStatCard("In Stock", "${variants.where((v) => (v["stockQuantity"] as int) > 0).length}", successColor, Icons.check_circle),
                    _buildStatCard("Low Stock", "${variants.where((v) => (v["stockQuantity"] as int) <= (v["lowStockThreshold"] as int)).length}", warningColor, Icons.warning),
                    _buildStatCard("Out of Stock", "${variants.where((v) => (v["stockQuantity"] as int) == 0).length}", dangerColor, Icons.error),
                  ],
                ),
              ],
            ),
          ),
          
          // Variants List
          if (variants.isNotEmpty)
            ...variants.map((variant) => _buildVariantItem(variant)).toList()
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
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
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Create your first variant for this product",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Create Variant",
                    size: bs.md,
                    icon: Icons.add,
                    onPressed: () {
                      _addVariant();
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${product["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${product["variants"]} Variants",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Brand and Category
                Row(
                  children: [
                    Text(
                      "${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${product["category"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Product Name
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Price Range
                Row(
                  children: [
                    Text(
                      "\$${(product["basePrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      " - \$${(product["topPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Stock Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.storage,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Total Stock: ${product["totalStock"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Manage Variants Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Manage Variants",
                    size: bs.md,
                    icon: Icons.tune,
                    onPressed: () {
                      _selectProduct(product);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVariantItem(Map<String, dynamic> variant) {
    bool isLowStock = (variant["stockQuantity"] as int) <= (variant["lowStockThreshold"] as int);
    bool isOutOfStock = (variant["stockQuantity"] as int) == 0;
    Color stockColor = isOutOfStock ? dangerColor : isLowStock ? warningColor : successColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: variant["isDefault"] ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${variant["image"]}",
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
                    Row(
                      children: [
                        Text(
                          "${variant["sku"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (variant["isDefault"]) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "DEFAULT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${variant["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        if (variant["size"] != null)
                          _buildVariantAttribute("Size", variant["size"]),
                        if (variant["scent"] != null)
                          _buildVariantAttribute("Scent", variant["scent"]),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: variant["isActive"] ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  variant["isActive"] ? "ACTIVE" : "INACTIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          // Pricing and Stock Info
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildVariantInfoCard("Price", "\$${(variant["price"] as double).toStringAsFixed(2)}", Icons.attach_money, successColor),
              _buildVariantInfoCard("Compare At", "\$${(variant["compareAtPrice"] as double).toStringAsFixed(2)}", Icons.compare, infoColor),
              _buildVariantInfoCard("Cost", "\$${(variant["costPrice"] as double).toStringAsFixed(2)}", Icons.shopping_cart, warningColor),
              _buildVariantInfoCard("Stock", "${variant["stockQuantity"]}", Icons.inventory, stockColor),
            ],
          ),
          
          // Additional Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.scale,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Weight: ${variant["weight"]}kg",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.straighten,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Dimensions: ${variant["dimensions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (isLowStock && !isOutOfStock)
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Low stock alert - below ${variant["lowStockThreshold"]} units",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                if (isOutOfStock)
                  Row(
                    children: [
                      Icon(
                        Icons.error,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Out of stock - immediate attention required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Variant",
                  size: bs.sm,
                  icon: Icons.edit,
                  color: infoColor,
                  onPressed: () {
                    _editVariant(variant);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Update Stock",
                  size: bs.sm,
                  icon: Icons.inventory,
                  color: stockColor,
                  onPressed: () {
                    _updateStock(variant);
                  },
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                color: primaryColor,
                onPressed: () {
                  _showVariantOptions(variant);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildVariantAttribute(String label, String value) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontSize: 11,
          color: infoColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  Widget _buildVariantInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = List.from(products);
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    // Filter by brand
    if (selectedBrand != "All") {
      filtered = filtered.where((product) => product["brand"] == selectedBrand).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) => 
        (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (product["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }
  
  List<Map<String, dynamic>> _getFilteredVariants() {
    return productVariants.where((variant) => variant["productId"] == selectedProduct["id"]).toList();
  }
  
  void _selectProduct(Map<String, dynamic> product) {
    selectedProduct = product;
    selectedTab = 1;
    setState(() {});
    ss("Switched to managing variants for ${product["name"]}");
  }
  
  void _changeProduct() {
    selectedTab = 0;
    setState(() {});
  }
  
  void _addVariant() {
    ss("Adding new variant for ${selectedProduct["name"]}");
  }
  
  void _editVariant(Map<String, dynamic> variant) {
    ss("Editing variant ${variant["sku"]}");
  }
  
  void _updateStock(Map<String, dynamic> variant) {
    ss("Updating stock for variant ${variant["sku"]}");
  }
  
  void _showVariantOptions(Map<String, dynamic> variant) {
    ss("Showing options for variant ${variant["sku"]}");
  }
}

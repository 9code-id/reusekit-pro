import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProductListView extends StatefulWidget {
  const PosProductListView({super.key});

  @override
  State<PosProductListView> createState() => _PosProductListViewState();
}

class _PosProductListViewState extends State<PosProductListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String statusFilter = "all";
  bool isLoading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Food", "value": "food"},
    {"label": "Pastries", "value": "pastries"},
    {"label": "Snacks", "value": "snacks"},
    {"label": "Merchandise", "value": "merchandise"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Out of Stock", "value": "out_of_stock"},
    {"label": "Low Stock", "value": "low_stock"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Cappuccino",
      "category": "beverages",
      "price": 4.50,
      "cost": 1.25,
      "stock": 150,
      "min_stock": 20,
      "sku": "BEV-CAP-001",
      "barcode": "1234567890123",
      "is_active": true,
      "image": "https://picsum.photos/100/100?random=1&keyword=coffee",
      "last_sold": "2024-12-19 12:30:00",
      "total_sold": 245,
      "profit_margin": 72.2
    },
    {
      "id": "prod_002",
      "name": "Chocolate Croissant",
      "category": "pastries",
      "price": 3.25,
      "cost": 0.85,
      "stock": 8,
      "min_stock": 10,
      "sku": "PAS-CHO-001",
      "barcode": "1234567890124",
      "is_active": true,
      "image": "https://picsum.photos/100/100?random=2&keyword=croissant",
      "last_sold": "2024-12-19 14:15:00",
      "total_sold": 189,
      "profit_margin": 73.8
    },
    {
      "id": "prod_003",
      "name": "Fresh Orange Juice",
      "category": "beverages",
      "price": 5.50,
      "cost": 1.80,
      "stock": 0,
      "min_stock": 15,
      "sku": "BEV-ORA-001",
      "barcode": "1234567890125",
      "is_active": true,
      "image": "https://picsum.photos/100/100?random=3&keyword=orange",
      "last_sold": "2024-12-18 16:45:00",
      "total_sold": 98,
      "profit_margin": 67.3
    },
    {
      "id": "prod_004",
      "name": "Blueberry Muffin",
      "category": "pastries",
      "price": 2.75,
      "cost": 0.60,
      "stock": 18,
      "min_stock": 12,
      "sku": "PAS-BLU-001",
      "barcode": "1234567890126",
      "is_active": true,
      "image": "https://picsum.photos/100/100?random=4&keyword=muffin",
      "last_sold": "2024-12-19 13:20:00",
      "total_sold": 156,
      "profit_margin": 78.2
    },
    {
      "id": "prod_005",
      "name": "Caesar Salad",
      "category": "food",
      "price": 8.95,
      "cost": 3.20,
      "stock": 35,
      "min_stock": 10,
      "sku": "FOO-CAE-001",
      "barcode": "1234567890127",
      "is_active": true,
      "image": "https://picsum.photos/100/100?random=5&keyword=salad",
      "last_sold": "2024-12-19 11:30:00",
      "total_sold": 67,
      "profit_margin": 64.2
    },
    {
      "id": "prod_006",
      "name": "Green Tea Latte",
      "category": "beverages",
      "price": 4.25,
      "cost": 1.15,
      "stock": 88,
      "min_stock": 25,
      "sku": "BEV-GRE-001",
      "barcode": "1234567890128",
      "is_active": false,
      "image": "https://picsum.photos/100/100?random=6&keyword=tea",
      "last_sold": "2024-12-15 09:15:00",
      "total_sold": 23,
      "profit_margin": 72.9
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          product["barcode"].toString().contains(searchQuery);
      
      bool matchesCategory = selectedCategory == "all" || product["category"] == selectedCategory;
      
      bool matchesStatus = true;
      if (statusFilter == "active") {
        matchesStatus = product["is_active"] as bool;
      } else if (statusFilter == "inactive") {
        matchesStatus = !(product["is_active"] as bool);
      } else if (statusFilter == "out_of_stock") {
        matchesStatus = (product["stock"] as int) == 0;
      } else if (statusFilter == "low_stock") {
        matchesStatus = (product["stock"] as int) > 0 && (product["stock"] as int) <= (product["min_stock"] as int);
      }
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('PosAddProductView')
            },
          ),
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {
              // navigateTo('PosBulkImportView')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildQuickStats(),
          Expanded(
            child: _buildProductList(),
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
                  label: "Search products...",
                  value: searchQuery,
                  hint: "Name, SKU, or barcode",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                icon: Icons.qr_code_scanner,
                size: bs.md,
                onPressed: () {
                  // navigateTo('PosBarcodeScanner')
                },
              ),
            ],
          ),
          
          Row(
            spacing: spSm,
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
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: statusFilter,
                  onChanged: (value, label) {
                    statusFilter = value;
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

  Widget _buildQuickStats() {
    int totalProducts = products.length;
    int activeProducts = products.where((p) => p["is_active"] as bool).length;
    int outOfStock = products.where((p) => (p["stock"] as int) == 0).length;
    int lowStock = products.where((p) => (p["stock"] as int) > 0 && (p["stock"] as int) <= (p["min_stock"] as int)).length;

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
              value: totalProducts.toString(),
              color: primaryColor,
              icon: Icons.inventory,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Active",
              value: activeProducts.toString(),
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
              title: "Low Stock",
              value: lowStock.toString(),
              color: warningColor,
              icon: Icons.trending_down,
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
              fontSize: 16,
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

  Widget _buildProductList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No products found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Add Product",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // navigateTo('PosAddProductView')
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
        children: filteredProducts.map((product) {
          return _buildProductCard(product);
        }).toList(),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool isOutOfStock = (product["stock"] as int) == 0;
    bool isLowStock = (product["stock"] as int) > 0 && (product["stock"] as int) <= (product["min_stock"] as int);
    bool isInactive = !(product["is_active"] as bool);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isOutOfStock ? dangerColor :
                 isLowStock ? warningColor :
                 isInactive ? disabledColor :
                 disabledOutlineBorderColor,
          width: isOutOfStock || isLowStock || isInactive ? 2 : 1,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            spacing: spMd,
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
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${product["name"]}",
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
                        if (isLowStock)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "LOW",
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
                          "SKU: ${product["sku"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Stock: ${product["stock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOutOfStock ? dangerColor : 
                                   isLowStock ? warningColor : successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text(
                          "\$${(product["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Cost: \$${(product["cost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(product["profit_margin"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Last Sold: ${DateTime.parse(product["last_sold"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Total Sold: ${product["total_sold"]} units",
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
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo('PosProductDetailView', arguments: product)
                    },
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo('PosEditProductView', arguments: product)
                    },
                  ),
                  QButton(
                    icon: Icons.add_shopping_cart,
                    size: bs.sm,
                    onPressed: isOutOfStock ? null : () {
                      ss("${product["name"]} added to cart");
                    },
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      _showProductOptions(product);
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

  void _showMoreOptions() {
    // More options implementation
  }

  void _showProductOptions(Map<String, dynamic> product) {
    // Product options implementation
  }
}

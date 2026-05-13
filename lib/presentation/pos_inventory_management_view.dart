import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosInventoryManagementView extends StatefulWidget {
  const PosInventoryManagementView({super.key});

  @override
  State<PosInventoryManagementView> createState() => _PosInventoryManagementViewState();
}

class _PosInventoryManagementViewState extends State<PosInventoryManagementView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  String sortBy = "name";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Books", "value": "books"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "In Stock", "value": "in_stock"},
    {"label": "Low Stock", "value": "low_stock"},
    {"label": "Out of Stock", "value": "out_of_stock"},
    {"label": "Discontinued", "value": "discontinued"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Product Name", "value": "name"},
    {"label": "Stock Quantity", "value": "stock"},
    {"label": "Price", "value": "price"},
    {"label": "Last Updated", "value": "updated"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Wireless Headphones",
      "sku": "WH-001",
      "category": "electronics",
      "price": 89.99,
      "cost": 45.00,
      "stock_quantity": 25,
      "min_stock": 10,
      "max_stock": 100,
      "status": "in_stock",
      "location": "A1-B2",
      "supplier": "TechCorp",
      "last_updated": "2024-06-18",
      "units_sold": 147,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
    },
    {
      "id": "prod_002",
      "name": "Bluetooth Speaker",
      "sku": "BS-002",
      "category": "electronics",
      "price": 129.99,
      "cost": 65.00,
      "stock_quantity": 8,
      "min_stock": 15,
      "max_stock": 80,
      "status": "low_stock",
      "location": "A2-C1",
      "supplier": "AudioMax",
      "last_updated": "2024-06-17",
      "units_sold": 89,
      "image": "https://picsum.photos/80/80?random=2&keyword=speaker"
    },
    {
      "id": "prod_003",
      "name": "Cotton T-Shirt",
      "sku": "CT-003",
      "category": "clothing",
      "price": 24.99,
      "cost": 8.50,
      "stock_quantity": 0,
      "min_stock": 20,
      "max_stock": 200,
      "status": "out_of_stock",
      "location": "B1-A3",
      "supplier": "FashionHub",
      "last_updated": "2024-06-16",
      "units_sold": 234,
      "image": "https://picsum.photos/80/80?random=3&keyword=shirt"
    },
    {
      "id": "prod_004",
      "name": "Coffee Beans 1kg",
      "sku": "CB-004",
      "category": "food",
      "price": 32.99,
      "cost": 12.00,
      "stock_quantity": 45,
      "min_stock": 30,
      "max_stock": 150,
      "status": "in_stock",
      "location": "C1-D2",
      "supplier": "CoffeeMart",
      "last_updated": "2024-06-18",
      "units_sold": 67,
      "image": "https://picsum.photos/80/80?random=4&keyword=coffee"
    },
    {
      "id": "prod_005",
      "name": "Programming Book",
      "sku": "PB-005",
      "category": "books",
      "price": 49.99,
      "cost": 15.00,
      "stock_quantity": 5,
      "min_stock": 5,
      "max_stock": 50,
      "status": "low_stock",
      "location": "D1-E1",
      "supplier": "BookWorld",
      "last_updated": "2024-06-15",
      "units_sold": 23,
      "image": "https://picsum.photos/80/80?random=5&keyword=book"
    },
    {
      "id": "prod_006",
      "name": "Garden Tools Set",
      "sku": "GT-006",
      "category": "home",
      "price": 79.99,
      "cost": 25.00,
      "stock_quantity": 12,
      "min_stock": 8,
      "max_stock": 60,
      "status": "in_stock",
      "location": "E1-F2",
      "supplier": "GardenPro",
      "last_updated": "2024-06-18",
      "units_sold": 34,
      "image": "https://picsum.photos/80/80?random=6&keyword=garden"
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    var filtered = products.where((product) {
      final matchesCategory = selectedCategory == "all" || product["category"] == selectedCategory;
      final matchesStatus = selectedStatus == "all" || product["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesStatus && matchesSearch;
    }).toList();

    // Sort products
    filtered.sort((a, b) {
      switch (sortBy) {
        case "stock":
          return (b["stock_quantity"] as int).compareTo(a["stock_quantity"] as int);
        case "price":
          return (b["price"] as double).compareTo(a["price"] as double);
        case "updated":
          return b["last_updated"].toString().compareTo(a["last_updated"].toString());
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });

    return filtered;
  }

  void _updateStock(String productId, int newQuantity) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final productIndex = products.indexWhere((p) => p["id"] == productId);
    if (productIndex != -1) {
      products[productIndex]["stock_quantity"] = newQuantity;
      products[productIndex]["last_updated"] = DateTime.now().toString().substring(0, 10);
      
      // Update status based on stock levels
      final minStock = products[productIndex]["min_stock"] as int;
      if (newQuantity == 0) {
        products[productIndex]["status"] = "out_of_stock";
      } else if (newQuantity <= minStock) {
        products[productIndex]["status"] = "low_stock";
      } else {
        products[productIndex]["status"] = "in_stock";
      }
    }

    loading = false;
    setState(() {});
    ss("Stock updated successfully");
  }

  void _bulkUpdateStock() async {
    bool isConfirmed = await confirm("Apply bulk stock update to ${filteredProducts.length} products?");
    if (isConfirmed) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(milliseconds: 1000));

      loading = false;
      setState(() {});
      ss("Bulk stock update completed");
    }
  }

  void _generateInventoryReport() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));

    loading = false;
    setState(() {});
    si("Inventory report generated and exported");
  }

  Widget _buildInventoryStats() {
    final totalProducts = products.length;
    final inStockProducts = products.where((p) => p["status"] == "in_stock").length;
    final lowStockProducts = products.where((p) => p["status"] == "low_stock").length;
    final outOfStockProducts = products.where((p) => p["status"] == "out_of_stock").length;
    final totalValue = products.map((p) => (p["stock_quantity"] as int) * (p["cost"] as double))
        .fold(0.0, (sum, value) => sum + value);

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
                  "$totalProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Products",
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
                  Icons.check_circle,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$inStockProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "In Stock",
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
                  Icons.warning,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$lowStockProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Low Stock",
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
                  Icons.error,
                  color: dangerColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$outOfStockProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Out of Stock",
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

  Widget _buildInventoryValue() {
    final totalValue = products.map((p) => (p["stock_quantity"] as int) * (p["cost"] as double))
        .fold(0.0, (sum, value) => sum + value);
    final totalRetailValue = products.map((p) => (p["stock_quantity"] as int) * (p["price"] as double))
        .fold(0.0, (sum, value) => sum + value);

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
                  Icons.attach_money,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${totalValue.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Cost Value",
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
                  "\$${totalRetailValue.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Retail Value",
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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

  Widget _buildProductCard(Map<String, dynamic> product) {
    final stockQuantity = product["stock_quantity"] as int;
    final minStock = product["min_stock"] as int;
    final maxStock = product["max_stock"] as int;
    final status = product["status"] as String;
    final price = product["price"] as double;
    final cost = product["cost"] as double;
    final unitsSold = product["units_sold"] as int;

    Color statusColor = successColor;
    if (status == "out_of_stock") statusColor = dangerColor;
    else if (status == "low_stock") statusColor = warningColor;
    else if (status == "discontinued") statusColor = disabledBoldColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(50)),
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
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${product["sku"]} | Location: ${product["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Supplier: ${product["supplier"]}",
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
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$unitsSold SOLD",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
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
                  _showEditStockDialog(product);
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
                      "Current Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$stockQuantity",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                      "Min / Max",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$minStock / $maxStock",
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
                      "Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${price.toStringAsFixed(2)}",
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
                      "Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((stockQuantity * cost)).toStringAsFixed(2)}",
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
          // Stock level indicator
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: (stockQuantity / maxStock).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditStockDialog(Map<String, dynamic> product) {
    String newStock = (product["stock_quantity"] as int).toString();
    String newMinStock = (product["min_stock"] as int).toString();
    String newMaxStock = (product["max_stock"] as int).toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Stock - ${product["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Current Stock",
              value: newStock,
              onChanged: (value) {
                newStock = value;
              },
            ),
            QNumberField(
              label: "Minimum Stock",
              value: newMinStock,
              onChanged: (value) {
                newMinStock = value;
              },
            ),
            QNumberField(
              label: "Maximum Stock",
              value: newMaxStock,
              onChanged: (value) {
                newMaxStock = value;
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
              _updateStock(product["id"], int.tryParse(newStock) ?? 0);
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
        title: Text("Inventory Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _generateInventoryReport,
          ),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: _bulkUpdateStock,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInventoryStats(),
            _buildInventoryValue(),
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
                  label: "Export Report",
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: _generateInventoryReport,
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

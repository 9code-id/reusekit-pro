import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaProductListView extends StatefulWidget {
  const ImaProductListView({super.key});

  @override
  State<ImaProductListView> createState() => _ImaProductListViewState();
}

class _ImaProductListViewState extends State<ImaProductListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String sortBy = "name";
  bool isAscending = true;

  List<Map<String, dynamic>> products = [
    {
      "id": "PRD001",
      "name": "iPhone 14 Pro Max 256GB",
      "sku": "IP14PM-256",
      "category": "Electronics",
      "brand": "Apple",
      "price": 1199.99,
      "stock": 45,
      "reserved": 12,
      "sold": 234,
      "status": "Active",
      "image": "https://picsum.photos/150/150?random=1&keyword=phone",
      "rating": 4.8,
      "createdAt": "2024-01-15",
      "updatedAt": "2024-01-15",
    },
    {
      "id": "PRD002",
      "name": "Samsung Galaxy S23 Ultra 512GB",
      "sku": "SGS23U-512",
      "category": "Electronics",
      "brand": "Samsung",
      "price": 1099.99,
      "stock": 32,
      "reserved": 8,
      "sold": 187,
      "status": "Active",
      "image": "https://picsum.photos/150/150?random=2&keyword=phone",
      "rating": 4.7,
      "createdAt": "2024-01-14",
      "updatedAt": "2024-01-14",
    },
    {
      "id": "PRD003",
      "name": "MacBook Air M2 13\" 512GB",
      "sku": "MBA-M2-512",
      "category": "Electronics",
      "brand": "Apple",
      "price": 1499.99,
      "stock": 3,
      "reserved": 5,
      "sold": 89,
      "status": "Low Stock",
      "image": "https://picsum.photos/150/150?random=3&keyword=laptop",
      "rating": 4.9,
      "createdAt": "2024-01-13",
      "updatedAt": "2024-01-13",
    },
    {
      "id": "PRD004",
      "name": "iPad Pro 11\" 256GB WiFi",
      "sku": "IPP11-256",
      "category": "Electronics",
      "brand": "Apple",
      "price": 899.99,
      "stock": 0,
      "reserved": 7,
      "sold": 156,
      "status": "Out of Stock",
      "image": "https://picsum.photos/150/150?random=4&keyword=tablet",
      "rating": 4.6,
      "createdAt": "2024-01-12",
      "updatedAt": "2024-01-12",
    },
    {
      "id": "PRD005",
      "name": "AirPods Pro 3rd Generation",
      "sku": "APP3-WHITE",
      "category": "Accessories",
      "brand": "Apple",
      "price": 249.99,
      "stock": 67,
      "reserved": 15,
      "sold": 345,
      "status": "Active",
      "image": "https://picsum.photos/150/150?random=5&keyword=headphones",
      "rating": 4.5,
      "createdAt": "2024-01-11",
      "updatedAt": "2024-01-11",
    },
    {
      "id": "PRD006",
      "name": "Sony WH-1000XM5 Wireless",
      "sku": "WH1000XM5-BLK",
      "category": "Accessories",
      "brand": "Sony",
      "price": 399.99,
      "stock": 28,
      "reserved": 6,
      "sold": 123,
      "status": "Active",
      "image": "https://picsum.photos/150/150?random=6&keyword=headphones",
      "rating": 4.7,
      "createdAt": "2024-01-10",
      "updatedAt": "2024-01-10",
    },
    {
      "id": "PRD007",
      "name": "Nike Air Max 270 Black",
      "sku": "NAM270-BLK-42",
      "category": "Sports",
      "brand": "Nike",
      "price": 129.99,
      "stock": 2,
      "reserved": 3,
      "sold": 67,
      "status": "Low Stock",
      "image": "https://picsum.photos/150/150?random=7&keyword=shoes",
      "rating": 4.4,
      "createdAt": "2024-01-09",
      "updatedAt": "2024-01-09",
    },
    {
      "id": "PRD008",
      "name": "Adidas Ultraboost 22 White",
      "sku": "UB22-WHT-43",
      "category": "Sports",
      "brand": "Adidas",
      "price": 189.99,
      "stock": 0,
      "reserved": 0,
      "sold": 45,
      "status": "Out of Stock",
      "image": "https://picsum.photos/150/150?random=8&keyword=shoes",
      "rating": 4.3,
      "createdAt": "2024-01-08",
      "updatedAt": "2024-01-08",
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Accessories", "value": "Accessories"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Home & Garden", "value": "Home & Garden"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "Active"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Archived", "value": "Archived"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Price", "value": "price"},
    {"label": "Stock", "value": "stock"},
    {"label": "Created Date", "value": "createdAt"},
    {"label": "Sales", "value": "sold"},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || product["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || product["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    // Sort products
    filtered.sort((a, b) {
      int comparison = 0;
      switch (sortBy) {
        case "name":
          comparison = a["name"].toString().compareTo(b["name"].toString());
          break;
        case "price":
          comparison = (a["price"] as double).compareTo(b["price"] as double);
          break;
        case "stock":
          comparison = (a["stock"] as int).compareTo(b["stock"] as int);
          break;
        case "sold":
          comparison = (a["sold"] as int).compareTo(b["sold"] as int);
          break;
        case "createdAt":
          comparison = a["createdAt"].toString().compareTo(b["createdAt"].toString());
          break;
      }
      return isAscending ? comparison : -comparison;
    });

    return filtered;
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
              // Navigate to add product
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
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.withAlpha(20),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: TextField(
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Search products, SKU, or brand...",
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: disabledBoldColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.tune,
                      size: bs.sm,
                      onPressed: () {
                        _showAdvancedFilters();
                      },
                    ),
                  ],
                ),

                // Quick Filters
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: "${category["value"]}",
                              child: Text("${category["label"]}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedCategory = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: DropdownButton<String>(
                          value: selectedStatus,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: statusOptions.map((status) {
                            return DropdownMenuItem<String>(
                              value: "${status["value"]}",
                              child: Text("${status["label"]}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedStatus = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // Sort Options
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: DropdownButton<String>(
                          value: sortBy,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: sortOptions.map((sort) {
                            return DropdownMenuItem<String>(
                              value: "${sort["value"]}",
                              child: Text("${sort["label"]}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            sortBy = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isAscending = !isAscending;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  "${filteredProducts.length} products found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _clearFilters();
                  },
                  child: Text(
                    "Clear Filters",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add product
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    Color statusColor = successColor;
    if (product["status"] == "Low Stock") statusColor = warningColor;
    if (product["status"] == "Out of Stock") statusColor = dangerColor;
    if (product["status"] == "Draft") statusColor = disabledBoldColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${product["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "SKU: ${product["sku"]} • ${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${product["category"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: warningColor,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${product["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      // Edit product
                    },
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      _showProductMenu(product);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Product Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(product["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${product["stock"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: (product["stock"] as int) > 10 
                              ? successColor 
                              : (product["stock"] as int) > 0 
                                  ? warningColor 
                                  : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Reserved",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${product["reserved"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Sold",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${product["sold"]}",
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
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.download),
                title: Text("Export Products"),
                onTap: () {
                  Navigator.pop(context);
                  _exportProducts();
                },
              ),
              ListTile(
                leading: Icon(Icons.upload),
                title: Text("Import Products"),
                onTap: () {
                  Navigator.pop(context);
                  _importProducts();
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Bulk Edit"),
                onTap: () {
                  Navigator.pop(context);
                  _bulkEdit();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAdvancedFilters() {
    // Show advanced filter dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Advanced Filters"),
          content: Text("Advanced filtering options coming soon..."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showProductMenu(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.visibility),
                title: Text("View Details"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to product details
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Product"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit product
                },
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text("Duplicate"),
                onTap: () {
                  Navigator.pop(context);
                  _duplicateProduct(product);
                },
              ),
              ListTile(
                leading: Icon(Icons.archive),
                title: Text("Archive"),
                onTap: () {
                  Navigator.pop(context);
                  _archiveProduct(product);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProduct(product);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearFilters() {
    searchQuery = "";
    selectedCategory = "all";
    selectedStatus = "all";
    sortBy = "name";
    isAscending = true;
    setState(() {});
  }

  void _exportProducts() {
    ss("Products exported successfully!");
  }

  void _importProducts() {
    si("Import products functionality coming soon!");
  }

  void _bulkEdit() {
    si("Bulk edit functionality coming soon!");
  }

  void _duplicateProduct(Map<String, dynamic> product) {
    ss("Product duplicated: ${product["name"]}");
  }

  void _archiveProduct(Map<String, dynamic> product) {
    ss("Product archived: ${product["name"]}");
  }

  void _deleteProduct(Map<String, dynamic> product) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this product?");
    if (isConfirmed) {
      ss("Product deleted: ${product["name"]}");
    }
  }
}

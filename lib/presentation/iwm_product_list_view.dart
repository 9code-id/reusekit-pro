import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProductListView extends StatefulWidget {
  const IwmProductListView({super.key});

  @override
  State<IwmProductListView> createState() => _IwmProductListViewState();
}

class _IwmProductListViewState extends State<IwmProductListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedSupplier = "all";
  bool showLowStock = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Draft", "value": "draft"},
    {"label": "Discontinued", "value": "discontinued"},
  ];
  
  List<Map<String, dynamic>> suppliers = [
    {"label": "All Suppliers", "value": "all"},
    {"label": "TechSupply Co.", "value": "techsupply"},
    {"label": "Fashion Distributors", "value": "fashion_dist"},
    {"label": "Global Electronics", "value": "global_elec"},
    {"label": "SportGear Inc.", "value": "sportgear"},
  ];
  
  List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "iPhone 15 Pro Max 256GB",
      "sku": "IPH15PM-256",
      "category": "Electronics",
      "brand": "Apple",
      "supplier": "TechSupply Co.",
      "price": 1199.99,
      "cost": 899.00,
      "profit": 300.99,
      "margin": 25.1,
      "stock": 0,
      "minStock": 10,
      "maxStock": 100,
      "reserved": 5,
      "available": 0,
      "status": "active",
      "barcode": "123456789012",
      "weight": 0.221,
      "dimensions": "15.9 x 7.7 x 0.83 cm",
      "lastRestocked": "2024-01-10",
      "totalSold": 245,
      "revenue": 293995.55,
      "image": "https://picsum.photos/60/60?random=1&keyword=iphone",
      "tags": ["flagship", "premium", "new"],
      "lowStockAlert": true
    },
    {
      "id": "2",
      "name": "Samsung Galaxy Buds Pro",
      "sku": "SGB-PRO-BLK",
      "category": "Electronics",
      "brand": "Samsung",
      "supplier": "Global Electronics",
      "price": 199.99,
      "cost": 120.00,
      "profit": 79.99,
      "margin": 40.0,
      "stock": 3,
      "minStock": 15,
      "maxStock": 80,
      "reserved": 2,
      "available": 1,
      "status": "active",
      "barcode": "123456789013",
      "weight": 0.013,
      "dimensions": "5.0 x 2.5 x 2.8 cm",
      "lastRestocked": "2024-01-08",
      "totalSold": 189,
      "revenue": 37798.11,
      "image": "https://picsum.photos/60/60?random=2&keyword=earbuds",
      "tags": ["wireless", "noise-canceling"],
      "lowStockAlert": true
    },
    {
      "id": "3",
      "name": "Nike Air Max 270 White",
      "sku": "NAM270-WHT-10",
      "category": "Clothing",
      "brand": "Nike",
      "supplier": "Fashion Distributors",
      "price": 149.99,
      "cost": 85.00,
      "profit": 64.99,
      "margin": 43.3,
      "stock": 125,
      "minStock": 25,
      "maxStock": 200,
      "reserved": 8,
      "available": 117,
      "status": "active",
      "barcode": "123456789014",
      "weight": 0.285,
      "dimensions": "32.0 x 12.0 x 11.0 cm",
      "lastRestocked": "2024-01-12",
      "totalSold": 567,
      "revenue": 85049.33,
      "image": "https://picsum.photos/60/60?random=3&keyword=shoes",
      "tags": ["comfortable", "popular", "running"],
      "lowStockAlert": false
    },
    {
      "id": "4",
      "name": "Organic Coffee Beans 1kg",
      "sku": "OCB-1KG-ARB",
      "category": "Food & Beverages",
      "brand": "Green Mountain",
      "supplier": "Food Wholesalers",
      "price": 24.99,
      "cost": 12.50,
      "profit": 12.49,
      "margin": 50.0,
      "stock": 15,
      "minStock": 30,
      "maxStock": 500,
      "reserved": 0,
      "available": 15,
      "status": "active",
      "barcode": "123456789015",
      "weight": 1.0,
      "dimensions": "20.0 x 15.0 x 8.0 cm",
      "lastRestocked": "2024-01-14",
      "totalSold": 892,
      "revenue": 22291.08,
      "image": "https://picsum.photos/60/60?random=4&keyword=coffee",
      "tags": ["organic", "fair-trade", "premium"],
      "lowStockAlert": true
    },
    {
      "id": "5",
      "name": "Wireless Bluetooth Speaker",
      "sku": "WBS-BT50-BLK",
      "category": "Electronics",
      "brand": "JBL",
      "supplier": "TechSupply Co.",
      "price": 89.99,
      "cost": 54.00,
      "profit": 35.99,
      "margin": 40.0,
      "stock": 67,
      "minStock": 20,
      "maxStock": 150,
      "reserved": 3,
      "available": 64,
      "status": "active",
      "barcode": "123456789016",
      "weight": 0.540,
      "dimensions": "18.0 x 6.8 x 6.8 cm",
      "lastRestocked": "2024-01-09",
      "totalSold": 234,
      "revenue": 21057.66,
      "image": "https://picsum.photos/60/60?random=5&keyword=speaker",
      "tags": ["portable", "waterproof", "bluetooth"],
      "lowStockAlert": false
    },
    {
      "id": "6",
      "name": "Gaming Mechanical Keyboard",
      "sku": "GMK-RGB-87",
      "category": "Electronics",
      "brand": "Corsair",
      "supplier": "Global Electronics",
      "price": 159.99,
      "cost": 95.00,
      "profit": 64.99,
      "margin": 40.6,
      "stock": 45,
      "minStock": 15,
      "maxStock": 80,
      "reserved": 2,
      "available": 43,
      "status": "active",
      "barcode": "123456789017",
      "weight": 1.2,
      "dimensions": "43.6 x 16.6 x 3.4 cm",
      "lastRestocked": "2024-01-11",
      "totalSold": 178,
      "revenue": 28478.22,
      "image": "https://picsum.photos/60/60?random=6&keyword=keyboard",
      "tags": ["gaming", "rgb", "mechanical"],
      "lowStockAlert": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _getFilteredProducts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildProductStats(filteredProducts),
            _buildProductList(filteredProducts),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Products",
            value: searchQuery,
            hint: "Search by name, SKU, brand, or supplier...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Low Stock Only",
                      "value": true,
                      "checked": showLowStock,
                    }
                  ],
                  value: [
                    if (showLowStock)
                      {
                        "label": "Show Low Stock Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showLowStock = values.isNotEmpty;
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

  Widget _buildProductStats(List<Map<String, dynamic>> filteredProducts) {
    int totalProducts = filteredProducts.length;
    int activeProducts = filteredProducts.where((p) => p["status"] == "active").length;
    int lowStockProducts = filteredProducts.where((p) => p["lowStockAlert"] == true).length;
    double totalValue = filteredProducts.fold(0.0, (sum, p) => sum + ((p["stock"] as int) * (p["price"] as double)));
    
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$totalProducts",
                  style: TextStyle(
                    fontSize: 20,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$activeProducts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
                  "$lowStockProducts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${totalValue.currency}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
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
        ],
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> filteredProducts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Product List (${filteredProducts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.download,
              label: "Export",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredProducts.map((product) => _buildProductListItem(product)),
      ],
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    bool isLowStock = product["lowStockAlert"];
    bool isOutOfStock = (product["stock"] as int) == 0;
    Color stockColor = isOutOfStock ? dangerColor : isLowStock ? warningColor : successColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isLowStock ? Border(
          left: BorderSide(
            width: 4,
            color: stockColor,
          ),
        ) : null,
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
                        if (isLowStock)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: stockColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              isOutOfStock ? "OUT OF STOCK" : "LOW STOCK",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: stockColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "SKU: ${product["sku"]} • ${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${product["category"]} • ${product["supplier"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Text(
                    "\$${((product["price"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${(product["margin"] as double).toStringAsFixed(1)}% margin",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem("Stock", "${product["stock"]}", stockColor),
                    ),
                    Expanded(
                      child: _buildInfoItem("Available", "${product["available"]}", primaryColor),
                    ),
                    Expanded(
                      child: _buildInfoItem("Reserved", "${product["reserved"]}", warningColor),
                    ),
                    Expanded(
                      child: _buildInfoItem("Min Stock", "${product["minStock"]}", disabledBoldColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem("Total Sold", "${product["totalSold"]}", primaryColor),
                    ),
                    Expanded(
                      child: _buildInfoItem("Revenue", "\$${((product["revenue"] as double)).currency}", successColor),
                    ),
                    Expanded(
                      child: _buildInfoItem("Last Restocked", "${product["lastRestocked"]}", disabledBoldColor),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QButton(
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
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
    );
  }

  Widget _buildInfoItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = products;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        return product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               product["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedCategory != "all") {
      filtered = filtered.where((product) => product["category"].toString().toLowerCase() == selectedCategory).toList();
    }
    
    if (selectedStatus != "all") {
      filtered = filtered.where((product) => product["status"] == selectedStatus).toList();
    }
    
    if (selectedSupplier != "all") {
      filtered = filtered.where((product) => product["supplier"].toString().toLowerCase().contains(selectedSupplier)).toList();
    }
    
    if (showLowStock) {
      filtered = filtered.where((product) => product["lowStockAlert"] == true).toList();
    }
    
    return filtered;
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProductCatalogView extends StatefulWidget {
  const PosProductCatalogView({super.key});

  @override
  State<PosProductCatalogView> createState() => _PosProductCatalogViewState();
}

class _PosProductCatalogViewState extends State<PosProductCatalogView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "name";
  bool showOutOfStock = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "count": 147},
    {"label": "Beverages", "value": "beverages", "count": 45},
    {"label": "Food", "value": "food", "count": 38},
    {"label": "Pastries", "value": "pastries", "count": 22},
    {"label": "Snacks", "value": "snacks", "count": 18},
    {"label": "Merchandise", "value": "merchandise", "count": 12},
    {"label": "Dairy", "value": "dairy", "count": 12},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Cappuccino",
      "category": "beverages",
      "price": 4.50,
      "cost": 1.25,
      "stock": 150,
      "sku": "BEV-CAP-001",
      "image": "https://picsum.photos/300/300?random=1&keyword=coffee",
      "description": "Rich espresso with steamed milk foam",
      "is_active": true,
      "barcode": "1234567890123",
      "profit_margin": 72.2
    },
    {
      "id": "prod_002",
      "name": "Chocolate Croissant",
      "category": "pastries",
      "price": 3.25,
      "cost": 0.85,
      "stock": 24,
      "sku": "PAS-CHO-001",
      "image": "https://picsum.photos/300/300?random=2&keyword=croissant",
      "description": "Buttery croissant with rich chocolate filling",
      "is_active": true,
      "barcode": "1234567890124",
      "profit_margin": 73.8
    },
    {
      "id": "prod_003",
      "name": "Fresh Orange Juice",
      "category": "beverages",
      "price": 5.50,
      "cost": 1.80,
      "stock": 0,
      "sku": "BEV-ORA-001",
      "image": "https://picsum.photos/300/300?random=3&keyword=orange",
      "description": "Freshly squeezed orange juice",
      "is_active": true,
      "barcode": "1234567890125",
      "profit_margin": 67.3
    },
    {
      "id": "prod_004",
      "name": "Blueberry Muffin",
      "category": "pastries",
      "price": 2.75,
      "cost": 0.60,
      "stock": 18,
      "sku": "PAS-BLU-001",
      "image": "https://picsum.photos/300/300?random=4&keyword=muffin",
      "description": "Soft muffin loaded with fresh blueberries",
      "is_active": true,
      "barcode": "1234567890126",
      "profit_margin": 78.2
    },
    {
      "id": "prod_005",
      "name": "Caesar Salad",
      "category": "food",
      "price": 8.95,
      "cost": 3.20,
      "stock": 35,
      "sku": "FOO-CAE-001",
      "image": "https://picsum.photos/300/300?random=5&keyword=salad",
      "description": "Fresh romaine lettuce with caesar dressing",
      "is_active": true,
      "barcode": "1234567890127",
      "profit_margin": 64.2
    },
    {
      "id": "prod_006",
      "name": "Green Tea Latte",
      "category": "beverages",
      "price": 4.25,
      "cost": 1.15,
      "stock": 88,
      "sku": "BEV-GRE-001",
      "image": "https://picsum.photos/300/300?random=6&keyword=tea",
      "description": "Smooth green tea with steamed milk",
      "is_active": false,
      "barcode": "1234567890128",
      "profit_margin": 72.9
    },
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "name"},
    {"label": "Price Low-High", "value": "price_asc"},
    {"label": "Price High-Low", "value": "price_desc"},
    {"label": "Stock Level", "value": "stock"},
    {"label": "Profit Margin", "value": "profit"},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory.toLowerCase();
      
      bool matchesStock = showOutOfStock || (product["stock"] as int) > 0;
      
      return matchesSearch && matchesCategory && matchesStock;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Catalog"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('PosAddProductView')
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // navigateTo('PosBarcodeScanner')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildCategoryTabs(),
          Expanded(
            child: _buildProductGrid(),
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
                icon: Icons.search,
                size: bs.md,
                onPressed: () {},
              ),
            ],
          ),
          
          Row(
            spacing: spSm,
            children: [
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
              QButton(
                icon: Icons.filter_list,
                size: bs.md,
                onPressed: () {
                  _showAdvancedFilters();
                },
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Out of Stock",
                      "value": true,
                      "checked": showOutOfStock,
                    }
                  ],
                  value: [
                    if (showOutOfStock)
                      {
                        "label": "Show Out of Stock",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showOutOfStock = values.isNotEmpty;
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

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      child: QHorizontalScroll(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category["label"];
          return GestureDetector(
            onTap: () {
              selectedCategory = category["label"];
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: spXs),
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${category["label"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white.withAlpha(40) : disabledColor.withAlpha(60),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${category["count"]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid() {
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
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredProducts.map((product) {
        return _buildProductCard(product);
      }).toList(),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool isOutOfStock = (product["stock"] as int) == 0;
    bool isInactive = !(product["is_active"] as bool);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isOutOfStock)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Out of Stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (isInactive)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Inactive",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Product Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${product["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SKU: ${product["sku"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Stock: ${product["stock"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: isOutOfStock ? dangerColor : successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${(product["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Cost: \$${(product["cost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
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
                
                SizedBox(height: spSm),
                
                Row(
                  spacing: spXs,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('PosProductDetailView', arguments: product)
                        },
                      ),
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
                        // Add to cart
                        ss("${product["name"]} added to cart");
                      },
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

  void _showAdvancedFilters() {
    // Advanced filters modal implementation
  }
}

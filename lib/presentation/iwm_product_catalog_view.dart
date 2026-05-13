import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProductCatalogView extends StatefulWidget {
  const IwmProductCatalogView({super.key});

  @override
  State<IwmProductCatalogView> createState() => _IwmProductCatalogViewState();
}

class _IwmProductCatalogViewState extends State<IwmProductCatalogView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedBrand = "all";
  String selectedPriceRange = "all";
  String sortBy = "name";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
  ];
  
  List<Map<String, dynamic>> brands = [
    {"label": "All Brands", "value": "all"},
    {"label": "Apple", "value": "apple"},
    {"label": "Samsung", "value": "samsung"},
    {"label": "Nike", "value": "nike"},
    {"label": "Sony", "value": "sony"},
    {"label": "Adidas", "value": "adidas"},
  ];
  
  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$50", "value": "under_50"},
    {"label": "\$50 - \$200", "value": "50_200"},
    {"label": "\$200 - \$500", "value": "200_500"},
    {"label": "Over \$500", "value": "over_500"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name (A-Z)", "value": "name"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Recently Added", "value": "recent"},
    {"label": "Best Selling", "value": "popular"},
  ];
  
  List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "iPhone 15 Pro Max",
      "brand": "Apple",
      "category": "Electronics",
      "price": 1199.99,
      "cost": 899.00,
      "sku": "IPH15PM-256-BLU",
      "barcode": "123456789012",
      "stock": 45,
      "minStock": 10,
      "description": "Latest iPhone with A17 Pro chip, 256GB storage, and advanced camera system",
      "images": [
        "https://picsum.photos/300/300?random=1&keyword=iphone",
        "https://picsum.photos/300/300?random=11&keyword=phone",
        "https://picsum.photos/300/300?random=21&keyword=mobile"
      ],
      "specifications": {
        "Screen Size": "6.7 inches",
        "Storage": "256GB",
        "RAM": "8GB",
        "Camera": "48MP Triple Camera",
        "Battery": "4441 mAh"
      },
      "variants": [
        {"name": "Natural Titanium", "price": 1199.99, "stock": 45},
        {"name": "Blue Titanium", "price": 1199.99, "stock": 32},
        {"name": "White Titanium", "price": 1199.99, "stock": 28}
      ],
      "status": "active",
      "tags": ["new", "flagship", "premium"],
      "rating": 4.8,
      "reviews": 1247,
      "dateAdded": "2024-01-15"
    },
    {
      "id": "2",
      "name": "Samsung Galaxy S24 Ultra",
      "brand": "Samsung",
      "category": "Electronics",
      "price": 1299.99,
      "cost": 950.00,
      "sku": "SGS24U-512-BLK",
      "barcode": "123456789013",
      "stock": 28,
      "minStock": 15,
      "description": "Flagship Android phone with S Pen, 512GB storage, and 200MP camera",
      "images": [
        "https://picsum.photos/300/300?random=2&keyword=samsung",
        "https://picsum.photos/300/300?random=12&keyword=galaxy",
        "https://picsum.photos/300/300?random=22&keyword=android"
      ],
      "specifications": {
        "Screen Size": "6.8 inches",
        "Storage": "512GB",
        "RAM": "12GB",
        "Camera": "200MP Quad Camera",
        "Battery": "5000 mAh"
      },
      "variants": [
        {"name": "Titanium Black", "price": 1299.99, "stock": 28},
        {"name": "Titanium Gray", "price": 1299.99, "stock": 22},
        {"name": "Titanium Violet", "price": 1299.99, "stock": 15}
      ],
      "status": "active",
      "tags": ["s-pen", "premium", "camera"],
      "rating": 4.6,
      "reviews": 892,
      "dateAdded": "2024-01-12"
    },
    {
      "id": "3",
      "name": "Nike Air Max 270",
      "brand": "Nike",
      "category": "Clothing",
      "price": 149.99,
      "cost": 85.00,
      "sku": "NAM270-WHT-10",
      "barcode": "123456789014",
      "stock": 125,
      "minStock": 25,
      "description": "Comfortable running shoes with Air Max technology and modern design",
      "images": [
        "https://picsum.photos/300/300?random=3&keyword=nike",
        "https://picsum.photos/300/300?random=13&keyword=shoes",
        "https://picsum.photos/300/300?random=23&keyword=sneakers"
      ],
      "specifications": {
        "Material": "Mesh and Synthetic",
        "Sole": "Rubber with Air Max",
        "Closure": "Lace-up",
        "Weight": "285g",
        "Technology": "Air Max 270"
      },
      "variants": [
        {"name": "White/Black", "price": 149.99, "stock": 125},
        {"name": "Black/Red", "price": 149.99, "stock": 98},
        {"name": "Blue/White", "price": 149.99, "stock": 76}
      ],
      "status": "active",
      "tags": ["comfortable", "running", "lifestyle"],
      "rating": 4.4,
      "reviews": 2156,
      "dateAdded": "2024-01-10"
    },
    {
      "id": "4",
      "name": "Sony WH-1000XM5 Headphones",
      "brand": "Sony",
      "category": "Electronics",
      "price": 399.99,
      "cost": 240.00,
      "sku": "SWH1000XM5-BLK",
      "barcode": "123456789015",
      "stock": 67,
      "minStock": 20,
      "description": "Premium noise-canceling wireless headphones with 30-hour battery life",
      "images": [
        "https://picsum.photos/300/300?random=4&keyword=headphones",
        "https://picsum.photos/300/300?random=14&keyword=sony",
        "https://picsum.photos/300/300?random=24&keyword=audio"
      ],
      "specifications": {
        "Battery Life": "30 hours",
        "Noise Canceling": "Industry Leading",
        "Connectivity": "Bluetooth 5.2",
        "Weight": "250g",
        "Drivers": "30mm"
      },
      "variants": [
        {"name": "Black", "price": 399.99, "stock": 67},
        {"name": "Silver", "price": 399.99, "stock": 43},
        {"name": "Midnight Blue", "price": 399.99, "stock": 28}
      ],
      "status": "active",
      "tags": ["wireless", "noise-canceling", "premium"],
      "rating": 4.7,
      "reviews": 1589,
      "dateAdded": "2024-01-08"
    },
    {
      "id": "5",
      "name": "Adidas Ultraboost 22",
      "brand": "Adidas",
      "category": "Clothing",
      "price": 179.99,
      "cost": 105.00,
      "sku": "AUB22-BLK-9",
      "barcode": "123456789016",
      "stock": 89,
      "minStock": 30,
      "description": "High-performance running shoes with Boost technology and Primeknit upper",
      "images": [
        "https://picsum.photos/300/300?random=5&keyword=adidas",
        "https://picsum.photos/300/300?random=15&keyword=ultraboost",
        "https://picsum.photos/300/300?random=25&keyword=running"
      ],
      "specifications": {
        "Upper": "Primeknit",
        "Midsole": "Boost Technology",
        "Outsole": "Continental Rubber",
        "Weight": "310g",
        "Drop": "10mm"
      },
      "variants": [
        {"name": "Core Black", "price": 179.99, "stock": 89},
        {"name": "Cloud White", "price": 179.99, "stock": 72},
        {"name": "Solar Red", "price": 179.99, "stock": 54}
      ],
      "status": "active",
      "tags": ["boost", "running", "performance"],
      "rating": 4.5,
      "reviews": 934,
      "dateAdded": "2024-01-05"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Catalog"),
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
            _buildSearchAndFilters(),
            _buildCatalogStats(),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
            hint: "Search by name, SKU, brand, or category...",
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
                  label: "Brand",
                  items: brands,
                  value: selectedBrand,
                  onChanged: (value, label) {
                    selectedBrand = value;
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
                  label: "Price Range",
                  items: priceRanges,
                  value: selectedPriceRange,
                  onChanged: (value, label) {
                    selectedPriceRange = value;
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

  Widget _buildCatalogStats() {
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
                  "${products.length}",
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${products.where((p) => p["status"] == "active").length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${categories.length - 1}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Categories",
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
                  "${brands.length - 1}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Brands",
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

  Widget _buildProductGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Product Catalog",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.view_list,
              size: bs.sm,
              onPressed: () {},
            ),
            SizedBox(width: spXs),
            QButton(
              icon: Icons.grid_view,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: products.map((product) => _buildProductCard(product)).toList(),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool isLowStock = (product["stock"] as int) <= (product["minStock"] as int);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${(product["images"] as List)[0]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              if (isLowStock)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "LOW STOCK",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${product["brand"]} • ${product["category"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "SKU: ${product["sku"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                        fontFamily: "monospace",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < (product["rating"] as double).floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 12,
                        color: warningColor,
                      );
                    }),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]} (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Stock: ${product["stock"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: isLowStock ? dangerColor : successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
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
}

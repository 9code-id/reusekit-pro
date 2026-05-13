import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct5View extends StatefulWidget {
  @override
  State<GrlProduct5View> createState() => _GrlProduct5ViewState();
}

class _GrlProduct5ViewState extends State<GrlProduct5View> {
  String selectedFilter = 'all';
  String searchQuery = '';
  int currentPage = 0;

  List<Map<String, dynamic>> filters = [
    {"label": "All Products", "value": "all"},
    {"label": "On Sale", "value": "sale"},
    {"label": "New Arrivals", "value": "new"},
    {"label": "Best Sellers", "value": "bestsellers"},
    {"label": "Free Shipping", "value": "freeshipping"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Premium Skincare Set",
      "price": 129.99,
      "originalPrice": 169.99,
      "image": "https://picsum.photos/400/400?random=1&keyword=skincare",
      "rating": 4.8,
      "reviews": 2341,
      "category": "Beauty",
      "brand": "GlowUp",
      "isNew": true,
      "onSale": true,
      "freeShipping": true,
      "isBestseller": true,
      "tags": ["Anti-aging", "Organic", "Dermatologist Tested"],
      "description": "Complete skincare routine with premium ingredients for glowing skin",
      "variants": [
        {"type": "Normal Skin", "price": 129.99},
        {"type": "Dry Skin", "price": 139.99},
        {"type": "Oily Skin", "price": 134.99},
      ],
    },
    {
      "id": 2,
      "name": "Wireless Gaming Mouse",
      "price": 89.99,
      "originalPrice": 119.99,
      "image": "https://picsum.photos/400/400?random=2&keyword=mouse",
      "rating": 4.6,
      "reviews": 1456,
      "category": "Electronics",
      "brand": "GameTech",
      "isNew": false,
      "onSale": true,
      "freeShipping": true,
      "isBestseller": true,
      "tags": ["RGB Lighting", "Ergonomic", "High DPI"],
      "description": "Professional gaming mouse with customizable RGB lighting",
      "variants": [
        {"type": "Black", "price": 89.99},
        {"type": "White", "price": 94.99},
        {"type": "RGB Edition", "price": 99.99},
      ],
    },
    {
      "id": 3,
      "name": "Organic Coffee Beans",
      "price": 24.99,
      "originalPrice": 29.99,
      "image": "https://picsum.photos/400/400?random=3&keyword=coffee",
      "rating": 4.7,
      "reviews": 892,
      "category": "Food",
      "brand": "BrewMaster",
      "isNew": true,
      "onSale": false,
      "freeShipping": false,
      "isBestseller": false,
      "tags": ["Organic", "Fair Trade", "Single Origin"],
      "description": "Premium organic coffee beans sourced from mountain farms",
      "variants": [
        {"type": "Light Roast", "price": 24.99},
        {"type": "Medium Roast", "price": 24.99},
        {"type": "Dark Roast", "price": 26.99},
      ],
    },
    {
      "id": 4,
      "name": "Smart Home Security Camera",
      "price": 199.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/400/400?random=4&keyword=camera",
      "rating": 4.5,
      "reviews": 1123,
      "category": "Smart Home",
      "brand": "SecureView",
      "isNew": false,
      "onSale": true,
      "freeShipping": true,
      "isBestseller": true,
      "tags": ["4K Video", "Night Vision", "Motion Detection"],
      "description": "Advanced security camera with AI-powered motion detection",
      "variants": [
        {"type": "Indoor", "price": 199.99},
        {"type": "Outdoor", "price": 229.99},
        {"type": "Pro Bundle", "price": 299.99},
      ],
    },
    {
      "id": 5,
      "name": "Luxury Silk Scarf",
      "price": 79.99,
      "originalPrice": 99.99,
      "image": "https://picsum.photos/400/400?random=5&keyword=scarf",
      "rating": 4.4,
      "reviews": 534,
      "category": "Fashion",
      "brand": "ElegantWear",
      "isNew": true,
      "onSale": true,
      "freeShipping": false,
      "isBestseller": false,
      "tags": ["Pure Silk", "Handmade", "Limited Edition"],
      "description": "Handcrafted silk scarf with exclusive designer patterns",
      "variants": [
        {"type": "Floral Blue", "price": 79.99},
        {"type": "Abstract Red", "price": 84.99},
        {"type": "Classic Black", "price": 79.99},
      ],
    },
    {
      "id": 6,
      "name": "Protein Powder Supplement",
      "price": 49.99,
      "originalPrice": 59.99,
      "image": "https://picsum.photos/400/400?random=6&keyword=protein",
      "rating": 4.6,
      "reviews": 2456,
      "category": "Health",
      "brand": "FitNutrition",
      "isNew": false,
      "onSale": true,
      "freeShipping": true,
      "isBestseller": true,
      "tags": ["Whey Protein", "Low Sugar", "30 Servings"],
      "description": "High-quality whey protein for muscle building and recovery",
      "variants": [
        {"type": "Vanilla", "price": 49.99},
        {"type": "Chocolate", "price": 49.99},
        {"type": "Strawberry", "price": 52.99},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (product["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (product["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply category filter
    switch (selectedFilter) {
      case 'sale':
        filtered = filtered.where((product) => product["onSale"] as bool).toList();
        break;
      case 'new':
        filtered = filtered.where((product) => product["isNew"] as bool).toList();
        break;
      case 'bestsellers':
        filtered = filtered.where((product) => product["isBestseller"] as bool).toList();
        break;
      case 'freeshipping':
        filtered = filtered.where((product) => product["freeShipping"] as bool).toList();
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Premium Products",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("${products.length}", "Products"),
                    _buildStatItem("${products.where((p) => p["onSale"] as bool).length}", "On Sale"),
                    _buildStatItem("${products.where((p) => p["isNew"] as bool).length}", "New"),
                    _buildStatItem("${products.where((p) => p["freeShipping"] as bool).length}", "Free Ship"),
                  ],
                ),
              ],
            ),
          ),

          // Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: filters.map((filter) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter["value"];
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: spMd),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedFilter == filter["value"]
                        ? primaryColor
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedFilter == filter["value"]
                          ? primaryColor
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    "${filter["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selectedFilter == filter["value"]
                          ? Colors.white
                          : disabledBoldColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),

          // Products Grid
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 200,
              children: filteredProducts.map((product) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowLg],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image with Overlay
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          child: Image.network(
                            "${product["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Badges
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product["isNew"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "NEW",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              if (product["onSale"] as bool)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "SALE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Bestseller Badge
                        if (product["isBestseller"] as bool)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        // Overlay Gradient
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withAlpha(100),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Category Label
                        Positioned(
                          bottom: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${product["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Product Details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand
                          Text(
                            "${product["brand"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: spXs),

                          // Product Name
                          Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spSm),

                          // Description
                          Text(
                            "${product["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spMd),

                          // Tags
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: (product["tags"] as List).map((tag) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                          ),

                          SizedBox(height: spMd),

                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${product["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "(${product["reviews"]} reviews)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Price Section
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
                              if ((product["originalPrice"] as double) > (product["price"] as double))
                                Padding(
                                  padding: EdgeInsets.only(left: spSm),
                                  child: Text(
                                    "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(height: spSm),

                          // Free Shipping
                          if (product["freeShipping"] as bool)
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Free Shipping",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                          SizedBox(height: spMd),

                          // Variants Info
                          Text(
                            "${(product["variants"] as List).length} variants available",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          SizedBox(height: spMd),

                          // Add to Cart Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Add to Cart",
                              size: bs.md,
                              onPressed: () {
                                _showVariantDialog(product);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Products"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Enter product name, brand, or category...",
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        actions: [
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showVariantDialog(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Variant"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: (product["variants"] as List).map((variant) => 
            Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${variant["type"]}"),
                  Text("\$${(variant["price"] as double).toStringAsFixed(2)}"),
                ],
              ),
            )
          ).toList(),
        ),
        actions: [
          QButton(
            label: "Add to Cart",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Product added to cart!");
            },
          ),
        ],
      ),
    );
  }
}

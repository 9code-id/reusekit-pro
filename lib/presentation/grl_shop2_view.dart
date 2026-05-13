import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop2View extends StatefulWidget {
  @override
  State<GrlShop2View> createState() => _GrlShop2ViewState();
}

class _GrlShop2ViewState extends State<GrlShop2View> {
  String searchQuery = "";
  String selectedCategory = "all";
  String sortBy = "featured";
  List<String> cartItems = [];
  List<String> wishlistItems = [];
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "icon": Icons.grid_view},
    {"label": "Electronics", "value": "electronics", "icon": Icons.devices},
    {"label": "Fashion", "value": "fashion", "icon": Icons.checkroom},
    {"label": "Home", "value": "home", "icon": Icons.home},
    {"label": "Sports", "value": "sports", "icon": Icons.sports},
    {"label": "Books", "value": "books", "icon": Icons.menu_book},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "Wireless Headphones Pro",
      "price": 299.99,
      "originalPrice": 399.99,
      "category": "electronics",
      "rating": 4.8,
      "reviews": 1250,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "brand": "AudioTech",
      "discount": 25,
      "inStock": true,
      "freeShipping": true,
      "features": ["Noise Cancelling", "40H Battery", "Quick Charge"],
    },
    {
      "id": "2",
      "name": "Designer Leather Jacket",
      "price": 189.99,
      "originalPrice": 249.99,
      "category": "fashion",
      "rating": 4.6,
      "reviews": 890,
      "image": "https://picsum.photos/300/300?random=2&keyword=jacket",
      "brand": "StyleCo",
      "discount": 24,
      "inStock": true,
      "freeShipping": false,
      "features": ["Genuine Leather", "Premium Quality", "Modern Fit"],
    },
    {
      "id": "3",
      "name": "Smart Home Hub",
      "price": 149.99,
      "originalPrice": 199.99,
      "category": "home",
      "rating": 4.7,
      "reviews": 756,
      "image": "https://picsum.photos/300/300?random=3&keyword=smart+home",
      "brand": "HomeTech",
      "discount": 25,
      "inStock": true,
      "freeShipping": true,
      "features": ["Voice Control", "App Integration", "Easy Setup"],
    },
    {
      "id": "4",
      "name": "Running Shoes Elite",
      "price": 129.99,
      "originalPrice": 169.99,
      "category": "sports",
      "rating": 4.9,
      "reviews": 2100,
      "image": "https://picsum.photos/300/300?random=4&keyword=running+shoes",
      "brand": "SportMax",
      "discount": 24,
      "inStock": true,
      "freeShipping": true,
      "features": ["Lightweight", "Breathable", "Shock Absorption"],
    },
    {
      "id": "5",
      "name": "Programming Books Set",
      "price": 89.99,
      "originalPrice": 129.99,
      "category": "books",
      "rating": 4.5,
      "reviews": 423,
      "image": "https://picsum.photos/300/300?random=5&keyword=books",
      "brand": "TechBooks",
      "discount": 31,
      "inStock": true,
      "freeShipping": false,
      "features": ["5 Books Bundle", "Latest Edition", "Expert Authors"],
    },
    {
      "id": "6",
      "name": "Smartphone Case Premium",
      "price": 24.99,
      "originalPrice": 34.99,
      "category": "electronics",
      "rating": 4.4,
      "reviews": 678,
      "image": "https://picsum.photos/300/300?random=6&keyword=phone+case",
      "brand": "ProtectPro",
      "discount": 29,
      "inStock": true,
      "freeShipping": true,
      "features": ["Drop Protection", "Wireless Charging", "Clear Design"],
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) => 
        (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (product["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    switch (sortBy) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "discount":
        filtered.sort((a, b) => (b["discount"] as int).compareTo(a["discount"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop & Compare"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // navigateTo(CartView());
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "${cartItems.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // navigateTo(WishlistView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
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
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.tune,
                      size: bs.sm,
                      onPressed: () {
                        _showFilterDialog();
                      },
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Category Filter
                QHorizontalScroll(
                  children: categories.map((category) => GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == category["value"] ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedCategory == category["value"] ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category["icon"],
                            size: 16,
                            color: selectedCategory == category["value"] ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selectedCategory == category["value"] ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredProducts.length} Products Found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _showSortDialog(),
                  child: Row(
                    children: [
                      Text(
                        "Sort by",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Products Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredProducts.map((product) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image with Discount Badge
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
                          if ((product["discount"] as int) > 0)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "-${product["discount"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                String productId = product["id"];
                                if (wishlistItems.contains(productId)) {
                                  wishlistItems.remove(productId);
                                } else {
                                  wishlistItems.add(productId);
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(230),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  wishlistItems.contains(product["id"]) 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                  size: 20,
                                  color: wishlistItems.contains(product["id"]) 
                                    ? dangerColor 
                                    : disabledBoldColor,
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
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            
                            // Rating and Reviews
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) => Icon(
                                    index < (product["rating"] as double).floor() 
                                      ? Icons.star 
                                      : Icons.star_border,
                                    size: 16,
                                    color: warningColor,
                                  )),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${product["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Features
                            Wrap(
                              spacing: spXs,
                              runSpacing: 4,
                              children: (product["features"] as List).take(2).map((feature) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Price and Add to Cart
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if ((product["originalPrice"] as double) > (product["price"] as double))
                                        Text(
                                          "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      Text(
                                        "\$${((product["price"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (product["freeShipping"] as bool)
                                        Text(
                                          "Free Shipping",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: cartItems.contains(product["id"]) 
                                    ? Icons.shopping_cart 
                                    : Icons.add_shopping_cart,
                                  size: bs.sm,
                                  onPressed: () {
                                    String productId = product["id"];
                                    if (cartItems.contains(productId)) {
                                      cartItems.remove(productId);
                                      ss("Removed from cart");
                                    } else {
                                      cartItems.add(productId);
                                      ss("Added to cart");
                                    }
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // Filter dialog implementation would go here
    si("Filter options coming soon");
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Sort Products",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSortOption("Featured", "featured"),
            _buildSortOption("Price: Low to High", "price_low"),
            _buildSortOption("Price: High to Low", "price_high"),
            _buildSortOption("Highest Rated", "rating"),
            _buildSortOption("Biggest Discount", "discount"),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: sortBy == value ? FontWeight.bold : FontWeight.normal,
          color: sortBy == value ? primaryColor : Colors.black,
        ),
      ),
      trailing: sortBy == value 
        ? Icon(Icons.check, color: primaryColor, size: 20)
        : null,
      onTap: () {
        sortBy = value;
        setState(() {});
        Navigator.pop(context);
      },
    );
  }
}

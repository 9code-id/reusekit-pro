import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop1View extends StatefulWidget {
  @override
  State<GrlShop1View> createState() => _GrlShop1ViewState();
}

class _GrlShop1ViewState extends State<GrlShop1View> {
  String selectedCategory = 'all';
  String searchQuery = '';
  String sortBy = 'popular';
  
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "price": 89.99,
      "originalPrice": 129.99,
      "discount": 31,
      "rating": 4.5,
      "reviews": 1247,
      "category": "electronics",
      "brand": "AudioTech",
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "isFavorite": true,
      "isOnSale": true,
      "freeShipping": true,
      "estimatedDelivery": "2-3 days",
      "inStock": true,
      "stockCount": 23,
      "features": ["Noise Cancellation", "30h Battery", "Quick Charge"],
      "colors": ["Black", "White", "Blue"],
    },
    {
      "id": 2,
      "name": "Smart Fitness Tracker",
      "price": 199.99,
      "originalPrice": 249.99,
      "discount": 20,
      "rating": 4.3,
      "reviews": 892,
      "category": "health",
      "brand": "FitMax",
      "image": "https://picsum.photos/300/300?random=2&keyword=fitness",
      "isFavorite": false,
      "isOnSale": true,
      "freeShipping": true,
      "estimatedDelivery": "1-2 days",
      "inStock": true,
      "stockCount": 67,
      "features": ["Heart Rate Monitor", "GPS Tracking", "Waterproof"],
      "colors": ["Black", "Pink", "Gray"],
    },
    {
      "id": 3,
      "name": "Organic Cotton T-Shirt",
      "price": 29.99,
      "originalPrice": 39.99,
      "discount": 25,
      "rating": 4.7,
      "reviews": 543,
      "category": "fashion",
      "brand": "EcoWear",
      "image": "https://picsum.photos/300/300?random=3&keyword=tshirt",
      "isFavorite": true,
      "isOnSale": false,
      "freeShipping": false,
      "estimatedDelivery": "3-5 days",
      "inStock": true,
      "stockCount": 156,
      "features": ["100% Organic", "Eco-Friendly", "Soft Fabric"],
      "colors": ["White", "Black", "Navy", "Green"],
    },
    {
      "id": 4,
      "name": "LED Desk Lamp with USB Charging",
      "price": 45.99,
      "originalPrice": 59.99,
      "discount": 23,
      "rating": 4.4,
      "reviews": 327,
      "category": "home",
      "brand": "BrightHome",
      "image": "https://picsum.photos/300/300?random=4&keyword=lamp",
      "isFavorite": false,
      "isOnSale": true,
      "freeShipping": true,
      "estimatedDelivery": "2-3 days",
      "inStock": true,
      "stockCount": 89,
      "features": ["USB Charging Port", "Adjustable Brightness", "Touch Control"],
      "colors": ["White", "Black"],
    },
    {
      "id": 5,
      "name": "Stainless Steel Water Bottle",
      "price": 24.99,
      "originalPrice": 34.99,
      "discount": 29,
      "rating": 4.6,
      "reviews": 782,
      "category": "lifestyle",
      "brand": "HydroFlow",
      "image": "https://picsum.photos/300/300?random=5&keyword=bottle",
      "isFavorite": false,
      "isOnSale": true,
      "freeShipping": false,
      "estimatedDelivery": "2-4 days",
      "inStock": true,
      "stockCount": 234,
      "features": ["24h Cold", "12h Hot", "BPA Free"],
      "colors": ["Silver", "Black", "Blue", "Pink"],
    },
    {
      "id": 6,
      "name": "Wireless Phone Charger Pad",
      "price": 34.99,
      "originalPrice": 49.99,
      "discount": 30,
      "rating": 4.2,
      "reviews": 456,
      "category": "electronics",
      "brand": "ChargeTech",
      "image": "https://picsum.photos/300/300?random=6&keyword=charger",
      "isFavorite": true,
      "isOnSale": true,
      "freeShipping": true,
      "estimatedDelivery": "1-2 days",
      "inStock": false,
      "stockCount": 0,
      "features": ["Fast Charging", "LED Indicator", "Non-Slip Surface"],
      "colors": ["Black", "White"],
    },
  ];

  List<String> categories = ['all', 'electronics', 'fashion', 'home', 'health', 'lifestyle'];
  List<String> sortOptions = ['popular', 'price-low', 'price-high', 'rating', 'newest'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            width: double.infinity,
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
                        hint: "Enter product name or brand",
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
                      onPressed: () {},
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Category Filter
                QHorizontalScroll(
                  children: categories.map((category) => Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory == category ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == category ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spSm),
                
                // Sort Options
                Row(
                  children: [
                    Text(
                      "Sort:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: sortOptions.map((sort) => Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              sortBy = sort;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: sortBy == sort ? successColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                sort.replaceAll('-', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: sortBy == sort ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Products Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Special Offers Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [successColor, successColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Special Offers",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Up to 50% off on selected items • Free shipping on orders over \$50",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Products Count
                  Text(
                    "${_getFilteredProducts().length} products found",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Products Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: _getFilteredProducts().map((product) => Container(
                      margin: EdgeInsets.only(bottom: spMd),
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
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                  ),
                                  child: Image.network(
                                    "${product["image"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Badges
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Column(
                                  children: [
                                    if (product["isOnSale"] as bool)
                                      Container(
                                        margin: EdgeInsets.only(bottom: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${product["discount"]}% OFF",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    if (product["freeShipping"] as bool)
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
                                          "FREE SHIP",
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
                              // Favorite Button
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: GestureDetector(
                                  onTap: () {
                                    product["isFavorite"] = !(product["isFavorite"] as bool);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(230),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      product["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                                      color: product["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              // Stock Status
                              if (!(product["inStock"] as bool))
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(128),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusLg),
                                        topRight: Radius.circular(radiusLg),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spMd,
                                          vertical: spSm,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Text(
                                          "OUT OF STOCK",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
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
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                
                                // Product Name
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                                        index < (product["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                        color: warningColor,
                                        size: 14,
                                      )),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${product["rating"]} (${product["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Price
                                Row(
                                  children: [
                                    Text(
                                      "\$${((product["price"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (product["isOnSale"] as bool) ...[
                                      SizedBox(width: spSm),
                                      Text(
                                        "\$${((product["originalPrice"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Features
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: (product["features"] as List).take(2).map((feature) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "$feature",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  )).toList(),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Delivery Info
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_shipping,
                                      size: 14,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${product["estimatedDelivery"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Add to Cart Button
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: product["inStock"] as bool ? "Add to Cart" : "Notify Me",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = products;
    
    // Filter by category
    if (selectedCategory != 'all') {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        return product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort products
    switch (sortBy) {
      case 'price-low':
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case 'price-high':
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case 'rating':
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case 'newest':
        // Sort by id (assuming higher id = newer)
        filtered.sort((a, b) => (b["id"] as int).compareTo(a["id"] as int));
        break;
      default: // popular
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
    }
    
    return filtered;
  }
}

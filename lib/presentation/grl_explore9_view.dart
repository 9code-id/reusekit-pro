import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore9View extends StatefulWidget {
  @override
  State<GrlExplore9View> createState() => _GrlExplore9ViewState();
}

class _GrlExplore9ViewState extends State<GrlExplore9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedBrand = "All Brands";
  String selectedPriceRange = "All Prices";
  String selectedSort = "Featured";
  bool showSaleOnly = false;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Beauty", "value": "Beauty"},
    {"label": "Books", "value": "Books"},
    {"label": "Toys", "value": "Toys"},
  ];
  
  List<Map<String, dynamic>> brandOptions = [
    {"label": "All Brands", "value": "All Brands"},
    {"label": "Apple", "value": "Apple"},
    {"label": "Samsung", "value": "Samsung"},
    {"label": "Nike", "value": "Nike"},
    {"label": "Adidas", "value": "Adidas"},
    {"label": "Sony", "value": "Sony"},
    {"label": "Canon", "value": "Canon"},
  ];
  
  List<Map<String, dynamic>> priceOptions = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Under \$50", "value": "Under 50"},
    {"label": "\$50 - \$100", "value": "50-100"},
    {"label": "\$100 - \$250", "value": "100-250"},
    {"label": "\$250 - \$500", "value": "250-500"},
    {"label": "Over \$500", "value": "Over 500"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Featured", "value": "Featured"},
    {"label": "Price: Low to High", "value": "Price Low"},
    {"label": "Price: High to Low", "value": "Price High"},
    {"label": "Customer Rating", "value": "Rating"},
    {"label": "Newest", "value": "Newest"},
    {"label": "Best Seller", "value": "Best Seller"},
  ];
  
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "brand": "Apple",
      "category": "Electronics",
      "price": 1199,
      "originalPrice": 1299,
      "discount": 8,
      "rating": 4.8,
      "reviews": 2341,
      "image": "https://picsum.photos/300/300?random=1&keyword=iphone",
      "isOnSale": true,
      "isBestSeller": true,
      "isNew": false,
      "freeShipping": true,
      "features": ["256GB", "Titanium", "Pro Camera"],
      "availability": "In Stock",
      "seller": "TechStore Plus",
      "sellerRating": 4.9,
      "deliveryTime": "1-2 days",
    },
    {
      "id": 2,
      "name": "Air Jordan 1 Retro High",
      "brand": "Nike",
      "category": "Fashion",
      "price": 170,
      "originalPrice": 170,
      "discount": 0,
      "rating": 4.6,
      "reviews": 1567,
      "image": "https://picsum.photos/300/300?random=2&keyword=sneakers",
      "isOnSale": false,
      "isBestSeller": false,
      "isNew": true,
      "freeShipping": false,
      "features": ["Leather Upper", "Classic Design", "Multiple Colors"],
      "availability": "Limited Stock",
      "seller": "Sneaker World",
      "sellerRating": 4.7,
      "deliveryTime": "3-5 days",
    },
    {
      "id": 3,
      "name": "Samsung 55\" 4K Smart TV",
      "brand": "Samsung",
      "category": "Electronics",
      "price": 599,
      "originalPrice": 799,
      "discount": 25,
      "rating": 4.5,
      "reviews": 892,
      "image": "https://picsum.photos/300/300?random=3&keyword=tv",
      "isOnSale": true,
      "isBestSeller": true,
      "isNew": false,
      "freeShipping": true,
      "features": ["4K UHD", "Smart TV", "HDR10+"],
      "availability": "In Stock",
      "seller": "Electronics Hub",
      "sellerRating": 4.8,
      "deliveryTime": "2-3 days",
    },
    {
      "id": 4,
      "name": "Yoga Mat Premium",
      "brand": "Adidas",
      "category": "Sports",
      "price": 49,
      "originalPrice": 69,
      "discount": 29,
      "rating": 4.4,
      "reviews": 445,
      "image": "https://picsum.photos/300/300?random=4&keyword=yoga",
      "isOnSale": true,
      "isBestSeller": false,
      "isNew": false,
      "freeShipping": false,
      "features": ["Non-slip", "Eco-friendly", "6mm Thick"],
      "availability": "In Stock",
      "seller": "FitGear Store",
      "sellerRating": 4.6,
      "deliveryTime": "2-4 days",
    },
    {
      "id": 5,
      "name": "Canon EOS R5 Camera",
      "brand": "Canon",
      "category": "Electronics",
      "price": 3899,
      "originalPrice": 3899,
      "discount": 0,
      "rating": 4.9,
      "reviews": 234,
      "image": "https://picsum.photos/300/300?random=5&keyword=camera",
      "isOnSale": false,
      "isBestSeller": false,
      "isNew": true,
      "freeShipping": true,
      "features": ["45MP", "8K Video", "Image Stabilization"],
      "availability": "Pre-order",
      "seller": "Camera Pro",
      "sellerRating": 4.9,
      "deliveryTime": "7-10 days",
    },
    {
      "id": 6,
      "name": "Skincare Essentials Kit",
      "brand": "Beauty Co",
      "category": "Beauty",
      "price": 89,
      "originalPrice": 120,
      "discount": 26,
      "rating": 4.7,
      "reviews": 756,
      "image": "https://picsum.photos/300/300?random=6&keyword=skincare",
      "isOnSale": true,
      "isBestSeller": true,
      "isNew": false,
      "freeShipping": false,
      "features": ["Cleanser", "Serum", "Moisturizer"],
      "availability": "In Stock",
      "seller": "Beauty Express",
      "sellerRating": 4.5,
      "deliveryTime": "1-3 days",
    },
  ];
  
  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      bool matchesBrand = selectedBrand == "All Brands" || product["brand"] == selectedBrand;
      bool matchesSale = !showSaleOnly || product["isOnSale"];
      
      return matchesSearch && matchesCategory && matchesBrand && matchesSale;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Marketplace"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flash Sale Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    dangerColor,
                    warningColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "FLASH SALE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Up to 50% Off",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Limited time deals on top brands",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "12:34:56",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Time left",
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            QTextField(
              label: "Search products, brands...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Filters
            QHorizontalScroll(
              children: [
                _buildQuickFilter("Best Sellers", Icons.trending_up, primaryColor),
                _buildQuickFilter("On Sale", Icons.local_offer, dangerColor),
                _buildQuickFilter("Free Shipping", Icons.local_shipping, successColor),
                _buildQuickFilter("New Arrivals", Icons.fiber_new, infoColor),
                _buildQuickFilter("Top Rated", Icons.star, warningColor),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Brand",
                    items: brandOptions,
                    value: selectedBrand,
                    onChanged: (value, label) {
                      selectedBrand = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Sale Only Toggle
            Row(
              children: [
                Text(
                  "Show sale items only",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: showSaleOnly,
                  onChanged: (value) {
                    showSaleOnly = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredProducts.length} Products",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.grid_view,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.view_list,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Products Grid
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: filteredProducts.map((product) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image with Badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${product["image"]}",
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Discount Badge
                          if (product["isOnSale"])
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "-${product["discount"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          
                          // Status Badges
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (product["isNew"])
                                  Container(
                                    margin: EdgeInsets.only(bottom: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "NEW",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (product["isBestSeller"])
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Best Seller",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Favorite Button
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(220),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: primaryColor,
                                  size: 18,
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
                          children: [
                            // Brand
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Product Name
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
                            
                            SizedBox(height: spXs),
                            
                            // Rating
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${product["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Features
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (product["features"] as List).take(2).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Price Section
                            Row(
                              children: [
                                Text(
                                  "\$${product["price"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (product["isOnSale"])
                                  Padding(
                                    padding: EdgeInsets.only(left: spXs),
                                    child: Text(
                                      "\$${product["originalPrice"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Seller Info
                            Row(
                              children: [
                                Text(
                                  "${product["seller"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 12,
                                ),
                                Text(
                                  "${product["sellerRating"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Add to Cart Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Add to Cart",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickFilter(String label, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spSm,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: color.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

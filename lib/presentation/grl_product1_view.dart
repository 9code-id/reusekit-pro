import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct1View extends StatefulWidget {
  @override
  State<GrlProduct1View> createState() => _GrlProduct1ViewState();
}

class _GrlProduct1ViewState extends State<GrlProduct1View> {
  String selectedCategory = "all";
  String sortBy = "popularity";
  bool isGridView = true;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "count": 245},
    {"label": "Electronics", "value": "electronics", "count": 89},
    {"label": "Fashion", "value": "fashion", "count": 67},
    {"label": "Home & Garden", "value": "home", "count": 45},
    {"label": "Sports", "value": "sports", "count": 34},
    {"label": "Books", "value": "books", "count": 10},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "price": 149.99,
      "originalPrice": 199.99,
      "discount": 25,
      "rating": 4.8,
      "reviews": 2847,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "category": "electronics",
      "brand": "TechSound",
      "inStock": true,
      "fastShipping": true,
      "tags": ["wireless", "bluetooth", "premium"],
    },
    {
      "id": 2,
      "name": "Premium Cotton T-Shirt",
      "price": 29.99,
      "originalPrice": 39.99,
      "discount": 25,
      "rating": 4.6,
      "reviews": 1234,
      "image": "https://picsum.photos/300/300?random=2&keyword=tshirt",
      "category": "fashion",
      "brand": "ComfortWear",
      "inStock": true,
      "fastShipping": false,
      "tags": ["cotton", "comfortable", "basic"],
    },
    {
      "id": 3,
      "name": "Smart Home Security Camera",
      "price": 299.99,
      "originalPrice": 399.99,
      "discount": 25,
      "rating": 4.9,
      "reviews": 567,
      "image": "https://picsum.photos/300/300?random=3&keyword=camera",
      "category": "electronics",
      "brand": "SecureHome",
      "inStock": false,
      "fastShipping": true,
      "tags": ["smart", "security", "wifi"],
    },
    {
      "id": 4,
      "name": "Ergonomic Office Chair",
      "price": 399.99,
      "originalPrice": 499.99,
      "discount": 20,
      "rating": 4.7,
      "reviews": 891,
      "image": "https://picsum.photos/300/300?random=4&keyword=chair",
      "category": "home",
      "brand": "OfficeComfort",
      "inStock": true,
      "fastShipping": true,
      "tags": ["ergonomic", "office", "comfortable"],
    },
    {
      "id": 5,
      "name": "Fitness Tracker Watch",
      "price": 199.99,
      "originalPrice": 249.99,
      "discount": 20,
      "rating": 4.5,
      "reviews": 1456,
      "image": "https://picsum.photos/300/300?random=5&keyword=watch",
      "category": "sports",
      "brand": "FitTech",
      "inStock": true,
      "fastShipping": true,
      "tags": ["fitness", "health", "waterproof"],
    },
    {
      "id": 6,
      "name": "Organic Coffee Beans",
      "price": 24.99,
      "originalPrice": 29.99,
      "discount": 17,
      "rating": 4.8,
      "reviews": 743,
      "image": "https://picsum.photos/300/300?random=6&keyword=coffee",
      "category": "food",
      "brand": "PureBrew",
      "inStock": true,
      "fastShipping": false,
      "tags": ["organic", "premium", "arabica"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Catalog"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Filter
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
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
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${category["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory == category["value"] ? Colors.white : primaryColor,
                        ),
                      ),
                      Text(
                        "${category["count"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: selectedCategory == category["value"] ? Colors.white70 : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),

          // Sort & View Controls
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                bottom: BorderSide(color: disabledColor),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "${filteredProducts.length} products",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: _showSortDialog,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 18,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by: ${_getSortLabel()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Product Grid/List
          Expanded(
            child: isGridView ? _buildGridView(filteredProducts) : _buildListView(filteredProducts),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> products) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: products.map((product) => Container(
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
                    height: 180,
                    width: double.infinity,
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
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (product["fastShipping"] as bool)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.local_shipping,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: primaryColor,
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
                    SizedBox(height: spXs),
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(product["rating"] as double).toStringAsFixed(1)}",
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
                    Row(
                      children: [
                        Text(
                          "\$${(product["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if ((product["originalPrice"] as double) > (product["price"] as double)) ...[
                          SizedBox(width: spSm),
                          Text(
                            "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: product["inStock"] as bool ? "Add to Cart" : "Out of Stock",
                        size: bs.sm,
                        icon: product["inStock"] as bool ? Icons.shopping_cart : Icons.inventory,
                        onPressed: product["inStock"] as bool ? () => _addToCart(product) : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> products) {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                // Product Image
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${product["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if ((product["discount"] as int) > 0)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              bottomRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "-${product["discount"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                
                SizedBox(width: spMd),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${product["brand"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          if (product["fastShipping"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Fast Shipping",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${product["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(product["rating"] as double).toStringAsFixed(1)}",
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
                          if ((product["originalPrice"] as double) > (product["price"] as double)) ...[
                            SizedBox(width: spSm),
                            Text(
                              "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                          Spacer(),
                          QButton(
                            label: product["inStock"] as bool ? "Add to Cart" : "Out of Stock",
                            size: bs.sm,
                            icon: product["inStock"] as bool ? Icons.shopping_cart : Icons.inventory,
                            onPressed: product["inStock"] as bool ? () => _addToCart(product) : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = products;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((p) => p["category"] == selectedCategory).toList();
    }
    
    // Sort products
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
      case "reviews":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      case "newest":
        // Sort by id (assuming higher id = newer)
        filtered.sort((a, b) => (b["id"] as int).compareTo(a["id"] as int));
        break;
    }
    
    return filtered;
  }

  String _getSortLabel() {
    switch (sortBy) {
      case "popularity":
        return "Popularity";
      case "price_low":
        return "Price: Low to High";
      case "price_high":
        return "Price: High to Low";
      case "rating":
        return "Rating";
      case "reviews":
        return "Most Reviews";
      case "newest":
        return "Newest";
      default:
        return "Popularity";
    }
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sort Products"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            "popularity",
            "price_low",
            "price_high", 
            "rating",
            "reviews",
            "newest"
          ].map((sort) => RadioListTile<String>(
            title: Text(_getSortLabelForValue(sort)),
            value: sort,
            groupValue: sortBy,
            onChanged: (value) {
              sortBy = value!;
              setState(() {});
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  String _getSortLabelForValue(String value) {
    switch (value) {
      case "popularity":
        return "Popularity";
      case "price_low":
        return "Price: Low to High";
      case "price_high":
        return "Price: High to Low";
      case "rating":
        return "Rating";
      case "reviews":
        return "Most Reviews";
      case "newest":
        return "Newest";
      default:
        return "Popularity";
    }
  }

  void _showFilterDialog() {
    // Show advanced filter dialog
    si("Advanced filters coming soon!");
  }

  void _addToCart(Map<String, dynamic> product) {
    ss("${product["name"]} added to cart!");
  }
}

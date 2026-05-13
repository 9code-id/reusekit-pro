import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch3View extends StatefulWidget {
  @override
  State<GrlSearch3View> createState() => _GrlSearch3ViewState();
}

class _GrlSearch3ViewState extends State<GrlSearch3View> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedPriceRange = "all";
  String selectedLocation = "all";
  bool isMapView = false;

  List<Map<String, dynamic>> trendingSearches = [
    {"query": "iPhone 15 Pro", "trend": "up", "change": "+25%"},
    {"query": "MacBook Air M3", "trend": "up", "change": "+15%"},
    {"query": "Gaming Laptop", "trend": "down", "change": "-8%"},
    {"query": "Wireless Earbuds", "trend": "up", "change": "+12%"}
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "brand": "Apple",
      "price": 1199.99,
      "originalPrice": 1299.99,
      "rating": 4.8,
      "reviews": 1250,
      "image": "https://picsum.photos/200/200?random=1&keyword=phone",
      "category": "electronics",
      "location": "New York",
      "seller": "TechStore Pro",
      "condition": "new",
      "shipping": "Free",
      "discount": 8,
      "inStock": true,
      "featured": true
    },
    {
      "id": 2,
      "name": "MacBook Air M3 15-inch",
      "brand": "Apple",
      "price": 1299.99,
      "originalPrice": 1399.99,
      "rating": 4.9,
      "reviews": 890,
      "image": "https://picsum.photos/200/200?random=2&keyword=laptop",
      "category": "electronics",
      "location": "California",
      "seller": "Apple Store",
      "condition": "new",
      "shipping": "Free",
      "discount": 7,
      "inStock": true,
      "featured": false
    },
    {
      "id": 3,
      "name": "Sony WH-1000XM5 Headphones",
      "brand": "Sony",
      "price": 299.99,
      "originalPrice": 399.99,
      "rating": 4.7,
      "reviews": 2100,
      "image": "https://picsum.photos/200/200?random=3&keyword=headphones",
      "category": "electronics",
      "location": "Texas",
      "seller": "AudioWorld",
      "condition": "new",
      "shipping": "\$9.99",
      "discount": 25,
      "inStock": true,
      "featured": false
    },
    {
      "id": 4,
      "name": "Gaming Chair Pro X",
      "brand": "GamerMax",
      "price": 299.99,
      "originalPrice": 399.99,
      "rating": 4.5,
      "reviews": 650,
      "image": "https://picsum.photos/200/200?random=4&keyword=chair",
      "category": "furniture",
      "location": "Florida",
      "seller": "FurnitureHub",
      "condition": "new",
      "shipping": "Free",
      "discount": 25,
      "inStock": false,
      "featured": false
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Furniture", "value": "furniture"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Books", "value": "books"}
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$100", "value": "under_100"},
    {"label": "\$100 - \$500", "value": "100_500"},
    {"label": "\$500 - \$1000", "value": "500_1000"},
    {"label": "Over \$1000", "value": "over_1000"}
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "New York", "value": "new_york"},
    {"label": "California", "value": "california"},
    {"label": "Texas", "value": "texas"},
    {"label": "Florida", "value": "florida"}
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    if (selectedLocation != "all") {
      filtered = filtered.where((item) => item["location"].toString().toLowerCase().contains(selectedLocation.replaceAll("_", " "))).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Search"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              // Show advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar with Voice
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Search products...",
                      value: searchQuery,
                      hint: "What are you looking for?",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.mic,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      // Start voice search
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      // Visual search
                    },
                  ),
                ],
              ),
            ),

            // Quick Filters
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
                    label: "Location",
                    items: locations,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Price Range Filter
            QDropdownField(
              label: "Price Range",
              items: priceRanges,
              value: selectedPriceRange,
              onChanged: (value, label) {
                selectedPriceRange = value;
                setState(() {});
              },
            ),

            // Content based on search state
            if (searchQuery.isEmpty) ...[
              // Trending Searches
              Text(
                "Trending Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spXs,
                children: trendingSearches.map((trending) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowXs],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          (trending["trend"] as String) == "up" 
                              ? Icons.trending_up 
                              : Icons.trending_down,
                          color: (trending["trend"] as String) == "up" 
                              ? successColor 
                              : dangerColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${trending["query"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (trending["trend"] as String) == "up" 
                                ? successColor.withAlpha(30) 
                                : dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${trending["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: (trending["trend"] as String) == "up" 
                                  ? successColor 
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Featured Products
              SizedBox(height: spMd),
              Text(
                "Featured Products",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: products.where((p) => p["featured"] as bool).map((product) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                "${product["image"]}",
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              if ((product["discount"] as int) > 0) ...[
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "-${(product["discount"] as int)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Product Info
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
                                "${product["brand"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(product["rating"] as num).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${(product["reviews"] as int)})",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${((product["price"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  if ((product["discount"] as int) > 0) ...[
                                    SizedBox(width: spXs),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredProducts.length} products found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort by: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Best Match",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),

              // Product Grid
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: filteredProducts.map((product) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                "${product["image"]}",
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              // Stock Status
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (product["inStock"] as bool) 
                                        ? successColor 
                                        : dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    (product["inStock"] as bool) ? "In Stock" : "Out of Stock",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Discount Badge
                              if ((product["discount"] as int) > 0) ...[
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "-${(product["discount"] as int)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${product["brand"]} • ${product["seller"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(product["rating"] as num).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${(product["reviews"] as int)})",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
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
                                        "\$${((product["price"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      if ((product["discount"] as int) > 0) ...[
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
                                  Text(
                                    "${product["shipping"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: "${product["shipping"]}" == "Free" 
                                          ? successColor 
                                          : disabledBoldColor,
                                      fontWeight: FontWeight.w600,
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
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

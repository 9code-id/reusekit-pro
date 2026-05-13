import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsCategoryView extends StatefulWidget {
  const EcsCategoryView({super.key});

  @override
  State<EcsCategoryView> createState() => _EcsCategoryViewState();
}

class _EcsCategoryViewState extends State<EcsCategoryView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Popular";
  String priceRange = "All";
  double minPrice = 0;
  double maxPrice = 1000;
  bool showFilters = false;

  final List<String> categories = [
    "All",
    "Electronics",
    "Fashion",
    "Home & Garden",
    "Sports",
    "Books",
    "Health & Beauty",
    "Automotive",
    "Toys",
    "Food & Beverage",
  ];

  final List<String> sortOptions = [
    "Popular",
    "Price: Low to High",
    "Price: High to Low",
    "Rating",
    "Newest",
    "Best Selling",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/300?random=31&keyword=headphones",
      "rating": 4.5,
      "reviews": 324,
      "discount": 31,
      "category": "Electronics",
      "badge": "Bestseller",
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Smart Fitness Watch",
      "price": 199.99,
      "originalPrice": 299.99,
      "image": "https://picsum.photos/300/300?random=32&keyword=watch",
      "rating": 4.8,
      "reviews": 156,
      "discount": 33,
      "category": "Electronics",
      "badge": "New",
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Premium Running Shoes",
      "price": 79.99,
      "originalPrice": 120.00,
      "image": "https://picsum.photos/300/300?random=33&keyword=shoes",
      "rating": 4.3,
      "reviews": 89,
      "discount": 33,
      "category": "Fashion",
      "badge": "Sale",
      "inStock": false,
    },
    {
      "id": 4,
      "name": "Automatic Coffee Maker",
      "price": 159.99,
      "originalPrice": 219.99,
      "image": "https://picsum.photos/300/300?random=34&keyword=coffee",
      "rating": 4.6,
      "reviews": 67,
      "discount": 27,
      "category": "Home & Garden",
      "badge": "Popular",
      "inStock": true,
    },
    {
      "id": 5,
      "name": "Gaming Mouse",
      "price": 49.99,
      "originalPrice": 79.99,
      "image": "https://picsum.photos/300/300?random=35&keyword=mouse",
      "rating": 4.4,
      "reviews": 234,
      "discount": 38,
      "category": "Electronics",
      "badge": "Deal",
      "inStock": true,
    },
    {
      "id": 6,
      "name": "Yoga Mat Premium",
      "price": 29.99,
      "originalPrice": 49.99,
      "image": "https://picsum.photos/300/300?random=36&keyword=yoga",
      "rating": 4.2,
      "reviews": 112,
      "discount": 40,
      "category": "Sports",
      "badge": "Hot",
      "inStock": true,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = searchQuery.isEmpty ||
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || 
          product["category"] == selectedCategory;
      bool matchesPrice = (product["price"] as double) >= minPrice && 
          (product["price"] as double) <= maxPrice;
      
      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Show search dialog or navigate to search page
            },
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: spMd),
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search products...",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        showFilters = !showFilters;
                        setState(() {});
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: showFilters ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: showFilters ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: showFilters ? Colors.white : disabledBoldColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (showFilters) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QCategoryPicker(
                          items: categories.map((category) => {
                            "label": category,
                            "value": category,
                          }).toList(),
                          value: selectedCategory,
                          onChanged: (index, label, value, item) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Sort By",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Sort Options",
                          items: sortOptions.map((option) => {
                            "label": option,
                            "value": option,
                          }).toList(),
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Clear Filters",
                                color: disabledBoldColor,
                                size: bs.sm,
                                onPressed: () {
                                  selectedCategory = "All";
                                  sortBy = "Popular";
                                  minPrice = 0;
                                  maxPrice = 1000;
                                  searchQuery = "";
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Apply",
                                size: bs.sm,
                                onPressed: () {
                                  showFilters = false;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Results Summary
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredProducts.length} products found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                if (selectedCategory != "All")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedCategory,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {
                            selectedCategory = "All";
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: primaryColor,
                          ),
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
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                              child: Image.network(
                                "${product["image"]}",
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (product["badge"] != null) ...[
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getBadgeColor("${product["badge"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${product["badge"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                            if (!(product["inStock"] as bool)) ...[
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Out of Stock",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product["name"]}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${product["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
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
                              SizedBox(height: spXs),
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
                                  SizedBox(width: spXs),
                                  if (product["originalPrice"] != null) ...[
                                    Text(
                                      "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                  Spacer(),
                                  if (product["discount"] != null) ...[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "-${product["discount"]}%",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: (product["inStock"] as bool) ? "Add to Cart" : "Notify Me",
                                  color: (product["inStock"] as bool) ? primaryColor : disabledBoldColor,
                                  size: bs.sm,
                                  onPressed: () {
                                    if (product["inStock"] as bool) {
                                      ss("${product["name"]} added to cart!");
                                    } else {
                                      ss("You'll be notified when ${product["name"]} is back in stock");
                                    }
                                  },
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
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge.toLowerCase()) {
      case 'new':
        return successColor;
      case 'sale':
        return dangerColor;
      case 'hot':
        return warningColor;
      case 'bestseller':
        return primaryColor;
      case 'popular':
        return infoColor;
      case 'deal':
        return Colors.orange;
      default:
        return primaryColor;
    }
  }
}

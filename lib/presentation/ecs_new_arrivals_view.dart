import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsNewArrivalsView extends StatefulWidget {
  const EcsNewArrivalsView({super.key});

  @override
  State<EcsNewArrivalsView> createState() => _EcsNewArrivalsViewState();
}

class _EcsNewArrivalsViewState extends State<EcsNewArrivalsView> {
  String selectedCategory = "All";
  String selectedSort = "Newest First";
  String viewMode = "grid";
  bool showOnlyAvailable = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Living", "value": "Home & Living"},
    {"label": "Beauty", "value": "Beauty"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "Newest First"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Highest Rated", "value": "Highest Rated"},
  ];

  List<Map<String, dynamic>> newArrivals = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "price": 1199.99,
      "originalPrice": 1299.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=iphone",
      "rating": 4.9,
      "reviews": 234,
      "category": "Electronics",
      "arrivalDate": "2024-06-10",
      "isNew": true,
      "discount": 8,
      "stock": 50,
      "colors": ["Black", "White", "Blue", "Gold"],
      "isAvailable": true,
      "description": "Latest iPhone with advanced camera system and titanium design",
    },
    {
      "id": 2,
      "name": "Summer Floral Dress",
      "price": 79.99,
      "originalPrice": 99.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=dress",
      "rating": 4.7,
      "reviews": 156,
      "category": "Fashion",
      "arrivalDate": "2024-06-08",
      "isNew": true,
      "discount": 20,
      "stock": 25,
      "colors": ["Pink", "Blue", "Yellow"],
      "isAvailable": true,
      "description": "Elegant summer dress perfect for any occasion",
    },
    {
      "id": 3,
      "name": "Smart Home Hub",
      "price": 149.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=smarthome",
      "rating": 4.8,
      "reviews": 89,
      "category": "Electronics",
      "arrivalDate": "2024-06-07",
      "isNew": true,
      "discount": 25,
      "stock": 0,
      "colors": ["White", "Black"],
      "isAvailable": false,
      "description": "Control all your smart devices from one central hub",
    },
    {
      "id": 4,
      "name": "Organic Skincare Set",
      "price": 129.99,
      "originalPrice": 160.00,
      "image": "https://picsum.photos/300/300?random=4&keyword=skincare",
      "rating": 4.9,
      "reviews": 312,
      "category": "Beauty",
      "arrivalDate": "2024-06-06",
      "isNew": true,
      "discount": 19,
      "stock": 75,
      "colors": ["Natural"],
      "isAvailable": true,
      "description": "Complete organic skincare routine for healthy glowing skin",
    },
    {
      "id": 5,
      "name": "Minimalist Coffee Table",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=table",
      "rating": 4.6,
      "reviews": 67,
      "category": "Home & Living",
      "arrivalDate": "2024-06-05",
      "isNew": true,
      "discount": 25,
      "stock": 15,
      "colors": ["Oak", "Walnut", "White"],
      "isAvailable": true,
      "description": "Modern minimalist coffee table for contemporary living spaces",
    },
    {
      "id": 6,
      "name": "Athletic Running Shoes",
      "price": 159.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=shoes",
      "rating": 4.8,
      "reviews": 445,
      "category": "Sports",
      "arrivalDate": "2024-06-04",
      "isNew": true,
      "discount": 20,
      "stock": 120,
      "colors": ["Black", "White", "Blue", "Red"],
      "isAvailable": true,
      "description": "High-performance running shoes with advanced cushioning",
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    var filtered = newArrivals.where((product) {
      if (selectedCategory != "All" && product["category"] != selectedCategory) return false;
      if (showOnlyAvailable && !product["isAvailable"]) return false;
      return true;
    }).toList();

    // Sort products
    switch (selectedSort) {
      case "Newest First":
        filtered.sort((a, b) => DateTime.parse(b["arrivalDate"]).compareTo(DateTime.parse(a["arrivalDate"])));
        break;
      case "Price: Low to High":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "Most Popular":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      case "Highest Rated":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Arrivals"),
        actions: [
          IconButton(
            onPressed: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
            icon: Icon(viewMode == "grid" ? Icons.view_list : Icons.grid_view),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.fiber_new,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fresh Arrivals",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${newArrivals.length} new products this week",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Up to",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "25% OFF",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter & Sort Section
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter & Sort",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
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
                        label: "Sort By",
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
                QSwitch(
                  items: [
                    {
                      "label": "Show only available items",
                      "value": true,
                      "checked": showOnlyAvailable,
                    }
                  ],
                  value: [
                    if (showOnlyAvailable)
                      {
                        "label": "Show only available items",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showOnlyAvailable = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Results Count
            Row(
              children: [
                Text(
                  "Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${products.length} products found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Products Grid/List
            if (viewMode == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: products.map((product) {
                  return _buildProductCard(product);
                }).toList(),
              )
            else
              Column(
                spacing: spSm,
                children: products.map((product) {
                  return _buildProductListItem(product);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // New Badge
              if (product["isNew"])
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
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
                ),
              // Discount Badge
              if (product["discount"] > 0)
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
                      "-${product["discount"]}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              // Out of Stock
              if (!product["isAvailable"])
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
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
                            color: dangerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Price
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (product["discount"] > 0) ...[
                      SizedBox(width: spSm),
                      Text(
                        "\$${(product["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Arrival Date
                Text(
                  "Arrived ${DateTime.parse(product["arrivalDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Colors
                Row(
                  children: [
                    Text(
                      "Colors: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(product["colors"] as List).length} available",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Add to Cart Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: product["isAvailable"] ? "Add to Cart" : "Notify Me",
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
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              if (product["isNew"])
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      "NEW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spSm),

          // Product Info
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (product["discount"] > 0) ...[
                      SizedBox(width: spSm),
                      Text(
                        "\$${(product["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]} (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (!product["isAvailable"])
                      Text(
                        "Out of Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Action Button
          QButton(
            label: product["isAvailable"] ? "Add" : "Notify",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite7View extends StatefulWidget {
  @override
  State<GrlFavorite7View> createState() => _GrlFavorite7ViewState();
}

class _GrlFavorite7ViewState extends State<GrlFavorite7View> {
  String searchQuery = "";
  String selectedBrand = "All";
  String sortBy = "Price";
  bool showOnlyInStock = false;

  List<Map<String, dynamic>> favoriteProducts = [
    {
      "id": 1,
      "name": "Wireless Headphones Pro",
      "brand": "TechSound",
      "price": 199.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/150/150?random=1&keyword=headphones",
      "rating": 4.8,
      "reviews": 2450,
      "inStock": true,
      "stockCount": 15,
      "category": "Electronics",
      "description": "Premium wireless headphones with noise cancellation",
      "features": ["Noise Canceling", "40h Battery", "Quick Charge"],
      "discount": 20,
      "freeShipping": true,
      "warranty": "2 years"
    },
    {
      "id": 2,
      "name": "Smart Fitness Watch",
      "brand": "FitTech",
      "price": 299.99,
      "originalPrice": 349.99,
      "image": "https://picsum.photos/150/150?random=2&keyword=watch",
      "rating": 4.6,
      "reviews": 1230,
      "inStock": true,
      "stockCount": 8,
      "category": "Wearables",
      "description": "Advanced fitness tracking with heart rate monitor",
      "features": ["GPS", "Heart Rate", "Waterproof"],
      "discount": 14,
      "freeShipping": true,
      "warranty": "1 year"
    },
    {
      "id": 3,
      "name": "Gaming Mechanical Keyboard",
      "brand": "GamePro",
      "price": 129.99,
      "originalPrice": 159.99,
      "image": "https://picsum.photos/150/150?random=3&keyword=keyboard",
      "rating": 4.9,
      "reviews": 890,
      "inStock": false,
      "stockCount": 0,
      "category": "Gaming",
      "description": "RGB mechanical keyboard with custom switches",
      "features": ["RGB Lighting", "Mechanical", "Programmable"],
      "discount": 19,
      "freeShipping": false,
      "warranty": "3 years"
    },
    {
      "id": 4,
      "name": "Laptop Stand Adjustable",
      "brand": "OfficeMax",
      "price": 49.99,
      "originalPrice": 69.99,
      "image": "https://picsum.photos/150/150?random=4&keyword=stand",
      "rating": 4.4,
      "reviews": 567,
      "inStock": true,
      "stockCount": 25,
      "category": "Accessories",
      "description": "Ergonomic laptop stand for better posture",
      "features": ["Adjustable", "Aluminum", "Portable"],
      "discount": 29,
      "freeShipping": true,
      "warranty": "1 year"
    },
    {
      "id": 5,
      "name": "Smartphone Camera Lens Kit",
      "brand": "PhotoPro",
      "price": 79.99,
      "originalPrice": 99.99,
      "image": "https://picsum.photos/150/150?random=5&keyword=camera",
      "rating": 4.7,
      "reviews": 345,
      "inStock": true,
      "stockCount": 12,
      "category": "Photography",
      "description": "Professional lens kit for smartphone photography",
      "features": ["Wide Angle", "Macro", "Fisheye"],
      "discount": 20,
      "freeShipping": true,
      "warranty": "6 months"
    }
  ];

  List<Map<String, dynamic>> get filteredProducts {
    var filtered = favoriteProducts.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesBrand = selectedBrand == "All" || product["brand"] == selectedBrand;
      bool matchesStock = !showOnlyInStock || (product["inStock"] as bool);
      
      return matchesSearch && matchesBrand && matchesStock;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Price":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Discount":
          return (b["discount"] as int).compareTo(a["discount"] as int);
        case "Reviews":
          return (b["reviews"] as int).compareTo(a["reviews"] as int);
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  _buildStatCard("Total Items", "${favoriteProducts.length}", Icons.favorite),
                  _buildStatCard("In Stock", "${favoriteProducts.where((p) => p["inStock"] as bool).length}", Icons.inventory),
                  _buildStatCard("Avg Savings", "${((favoriteProducts.map((p) => p["discount"] as int).reduce((a, b) => a + b)) / favoriteProducts.length).toStringAsFixed(0)}%", Icons.savings),
                ],
              ),
            ),

            // Search and Filters
            Row(
              spacing: spSm,
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // Filter Options
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Brand",
                    items: [
                      {"label": "All Brands", "value": "All"},
                      {"label": "TechSound", "value": "TechSound"},
                      {"label": "FitTech", "value": "FitTech"},
                      {"label": "GamePro", "value": "GamePro"},
                      {"label": "OfficeMax", "value": "OfficeMax"},
                      {"label": "PhotoPro", "value": "PhotoPro"},
                    ],
                    value: selectedBrand,
                    onChanged: (value, label) {
                      selectedBrand = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Price", "value": "Price"},
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Discount", "value": "Discount"},
                      {"label": "Reviews", "value": "Reviews"},
                      {"label": "Name", "value": "Name"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // In Stock Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only in-stock products",
                  "value": true,
                  "checked": showOnlyInStock,
                }
              ],
              value: showOnlyInStock ? [{"label": "Show only in-stock products", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyInStock = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Products List
            if (filteredProducts.isEmpty)
              Container(
                height: 200,
                child: Column(
                  spacing: spSm,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No favorite products found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Browse Products",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            else
              ...filteredProducts.map((product) => _buildProductCard(product)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool inStock = product["inStock"] as bool;
    double savings = (product["originalPrice"] as double) - (product["price"] as double);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: spSm,
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
                  if (product["discount"] as int > 0)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
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
                ],
              ),

              // Product Info
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: inStock ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            inStock ? "In Stock" : "Out of Stock",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${product["brand"]} • ${product["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${product["rating"]} (${product["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Price and Savings
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$${(product["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Save \$${savings.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                if (inStock)
                  Text(
                    "${product["stockCount"]} left",
                    style: TextStyle(
                      fontSize: 11,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (product["freeShipping"] as bool)
                  Container(
                    margin: EdgeInsets.only(left: spXs),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Free Shipping",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Product Description
          Text(
            "${product["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),

          // Features
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (product["features"] as List).map((feature) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                feature,
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: inStock ? "Add to Cart" : "Notify Me",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.favorite,
                size: bs.sm,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Remove '${product["name"]}' from favorites?");
                  if (isConfirmed) {
                    favoriteProducts.removeWhere((p) => p["id"] == product["id"]);
                    setState(() {});
                    ss("Product removed from favorites");
                  }
                },
              ),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                color: infoColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

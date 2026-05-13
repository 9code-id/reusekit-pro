import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop4View extends StatefulWidget {
  @override
  State<GrlShop4View> createState() => _GrlShop4ViewState();
}

class _GrlShop4ViewState extends State<GrlShop4View> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedPriceRange = "all";
  List<String> selectedBrands = [];
  double minPrice = 0;
  double maxPrice = 1000;
  bool showFilters = false;

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/400/300?random=1&keyword=headphones",
      "rating": 4.8,
      "reviews": 1250,
      "category": "electronics",
      "brand": "TechSound",
      "discount": 25,
      "isNew": false,
      "isBestseller": true,
      "description": "Premium wireless headphones with noise cancellation",
      "colors": ["Black", "White", "Silver"],
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Smart Watch Pro",
      "price": 449.99,
      "originalPrice": 599.99,
      "image": "https://picsum.photos/400/300?random=2&keyword=smartwatch",
      "rating": 4.6,
      "reviews": 890,
      "category": "electronics",
      "brand": "WatchTech",
      "discount": 25,
      "isNew": true,
      "isBestseller": false,
      "description": "Advanced smartwatch with health monitoring",
      "colors": ["Black", "Silver", "Gold"],
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Running Shoes",
      "price": 129.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/400/300?random=3&keyword=shoes",
      "rating": 4.7,
      "reviews": 2100,
      "category": "sports",
      "brand": "SportMax",
      "discount": 28,
      "isNew": false,
      "isBestseller": true,
      "description": "Comfortable running shoes for all terrains",
      "colors": ["Black", "Blue", "Red"],
      "inStock": true,
    },
    {
      "id": 4,
      "name": "Leather Jacket",
      "price": 199.99,
      "originalPrice": 299.99,
      "image": "https://picsum.photos/400/300?random=4&keyword=jacket",
      "rating": 4.5,
      "reviews": 450,
      "category": "fashion",
      "brand": "StyleCraft",
      "discount": 33,
      "isNew": false,
      "isBestseller": false,
      "description": "Premium leather jacket with modern design",
      "colors": ["Black", "Brown", "Tan"],
      "inStock": false,
    },
    {
      "id": 5,
      "name": "Gaming Keyboard",
      "price": 89.99,
      "originalPrice": 119.99,
      "image": "https://picsum.photos/400/300?random=5&keyword=keyboard",
      "rating": 4.9,
      "reviews": 1850,
      "category": "electronics",
      "brand": "GameMaster",
      "discount": 25,
      "isNew": true,
      "isBestseller": true,
      "description": "Mechanical gaming keyboard with RGB lighting",
      "colors": ["Black", "White"],
      "inStock": true,
    },
    {
      "id": 6,
      "name": "Yoga Mat",
      "price": 39.99,
      "originalPrice": 59.99,
      "image": "https://picsum.photos/400/300?random=6&keyword=yoga",
      "rating": 4.4,
      "reviews": 680,
      "category": "sports",
      "brand": "FitLife",
      "discount": 33,
      "isNew": false,
      "isBestseller": false,
      "description": "Non-slip yoga mat for all fitness levels",
      "colors": ["Purple", "Blue", "Green"],
      "inStock": true,
    },
  ];

  List<String> categories = ["all", "electronics", "sports", "fashion", "home"];
  List<String> brands = ["TechSound", "WatchTech", "SportMax", "StyleCraft", "GameMaster", "FitLife"];
  List<String> priceRanges = ["all", "under50", "50to100", "100to300", "over300"];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = searchQuery.isEmpty || 
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || 
          product["category"] == selectedCategory;
      
      bool matchesBrand = selectedBrands.isEmpty || 
          selectedBrands.contains(product["brand"]);
      
      bool matchesPrice = true;
      double price = product["price"] as double;
      
      switch (selectedPriceRange) {
        case "under50":
          matchesPrice = price < 50;
          break;
        case "50to100":
          matchesPrice = price >= 50 && price <= 100;
          break;
        case "100to300":
          matchesPrice = price >= 100 && price <= 300;
          break;
        case "over300":
          matchesPrice = price > 300;
          break;
        default:
          matchesPrice = price >= minPrice && price <= maxPrice;
      }
      
      return matchesSearch && matchesCategory && matchesBrand && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
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
          // Search and Filter Header
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
                        showFilters = !showFilters;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                
                if (showFilters) ...[
                  SizedBox(height: spMd),
                  
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
                            color: selectedCategory == category ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: selectedCategory == category ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            category == "all" ? "All" : category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedCategory == category ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Price Range Filter
                  Row(
                    children: [
                      Text(
                        "Price Range:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Select Price",
                          items: [
                            {"label": "All Prices", "value": "all"},
                            {"label": "Under \$50", "value": "under50"},
                            {"label": "\$50 - \$100", "value": "50to100"},
                            {"label": "\$100 - \$300", "value": "100to300"},
                            {"label": "Over \$300", "value": "over300"},
                          ],
                          value: selectedPriceRange,
                          onChanged: (value, label) {
                            selectedPriceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          
          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredProducts.length} Products Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sort by: Popular",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: disabledBoldColor,
                ),
              ],
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
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Stack(
                      children: [
                        Container(
                          height: 200,
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
                              if (product["isBestseller"] as bool)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "BESTSELLER",
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
                        
                        // Discount Badge
                        if ((product["discount"] as int) > 0)
                          Positioned(
                            top: spSm,
                            right: spSm,
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
                        
                        // Favorite Button
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              color: primaryColor,
                              size: 20,
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
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${product["brand"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
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
                          
                          // Price
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
                          
                          SizedBox(height: spSm),
                          
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
                              ...(product["colors"] as List).take(3).map((color) => Container(
                                width: 16,
                                height: 16,
                                margin: EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: _getColorFromName(color),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: disabledOutlineBorderColor,
                                  ),
                                ),
                              )).toList(),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Stock Status
                          Row(
                            children: [
                              Icon(
                                product["inStock"] as bool ? Icons.check_circle : Icons.cancel,
                                color: product["inStock"] as bool ? successColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                product["inStock"] as bool ? "In Stock" : "Out of Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: product["inStock"] as bool ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Add to Cart Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Add to Cart",
                              size: bs.sm,
                              onPressed: product["inStock"] as bool ? () {} : null,
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

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'brown':
        return Colors.brown;
      case 'silver':
        return Colors.grey;
      case 'gold':
        return Colors.amber;
      case 'tan':
        return Colors.brown[300]!;
      default:
        return primaryColor;
    }
  }
}

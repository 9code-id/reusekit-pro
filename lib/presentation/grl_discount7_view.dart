import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount7View extends StatefulWidget {
  @override
  State<GrlDiscount7View> createState() => _GrlDiscount7ViewState();
}

class _GrlDiscount7ViewState extends State<GrlDiscount7View> {
  String selectedPriceRange = "All";
  List<Map<String, dynamic>> priceRanges = [
    {"label": "All", "value": "All"},
    {"label": "Under \$50", "value": "Under \$50"},
    {"label": "\$50 - \$100", "value": "\$50 - \$100"},
    {"label": "\$100 - \$200", "value": "\$100 - \$200"},
    {"label": "Over \$200", "value": "Over \$200"},
  ];

  List<Map<String, dynamic>> discountedProducts = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Earbuds",
      "brand": "TechPro",
      "originalPrice": 129.99,
      "discountedPrice": 39.99,
      "discountPercentage": 69,
      "image": "https://picsum.photos/300/200?random=1&keyword=earbuds",
      "rating": 4.5,
      "reviewCount": 2847,
      "category": "Electronics",
      "tags": ["Best Seller", "Limited Time"],
      "freeShipping": true,
      "stockCount": 45,
    },
    {
      "id": 2,
      "name": "Smartwatch Fitness Tracker",
      "brand": "FitTech",
      "originalPrice": 199.99,
      "discountedPrice": 89.99,
      "discountPercentage": 55,
      "image": "https://picsum.photos/300/200?random=2&keyword=watch",
      "rating": 4.3,
      "reviewCount": 1256,
      "category": "Electronics",
      "tags": ["New Arrival"],
      "freeShipping": true,
      "stockCount": 23,
    },
    {
      "id": 3,
      "name": "Premium Coffee Maker",
      "brand": "BrewMaster",
      "originalPrice": 299.99,
      "discountedPrice": 149.99,
      "discountPercentage": 50,
      "image": "https://picsum.photos/300/200?random=3&keyword=coffee",
      "rating": 4.7,
      "reviewCount": 892,
      "category": "Home & Kitchen",
      "tags": ["Editor's Choice"],
      "freeShipping": true,
      "stockCount": 12,
    },
    {
      "id": 4,
      "name": "Portable Bluetooth Speaker",
      "brand": "SoundWave",
      "originalPrice": 79.99,
      "discountedPrice": 29.99,
      "discountPercentage": 63,
      "image": "https://picsum.photos/300/200?random=4&keyword=speaker",
      "rating": 4.2,
      "reviewCount": 1567,
      "category": "Electronics",
      "tags": ["Hot Deal"],
      "freeShipping": false,
      "stockCount": 67,
    },
    {
      "id": 5,
      "name": "Gaming Mechanical Keyboard",
      "brand": "GamePro",
      "originalPrice": 159.99,
      "discountedPrice": 79.99,
      "discountPercentage": 50,
      "image": "https://picsum.photos/300/200?random=5&keyword=keyboard",
      "rating": 4.6,
      "reviewCount": 743,
      "category": "Gaming",
      "tags": ["Gamer's Choice"],
      "freeShipping": true,
      "stockCount": 18,
    },
    {
      "id": 6,
      "name": "Air Fryer XL",
      "brand": "CookSmart",
      "originalPrice": 199.99,
      "discountedPrice": 99.99,
      "discountPercentage": 50,
      "image": "https://picsum.photos/300/200?random=6&keyword=airfryer",
      "rating": 4.4,
      "reviewCount": 1324,
      "category": "Home & Kitchen",
      "tags": ["Healthy Choice"],
      "freeShipping": true,
      "stockCount": 8,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedPriceRange == "All") return discountedProducts;
    
    return discountedProducts.where((product) {
      double price = product["discountedPrice"] as double;
      switch (selectedPriceRange) {
        case "Under \$50":
          return price < 50;
        case "\$50 - \$100":
          return price >= 50 && price <= 100;
        case "\$100 - \$200":
          return price > 100 && price <= 200;
        case "Over \$200":
          return price > 200;
        default:
          return true;
      }
    }).toList();
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case "Best Seller":
        return primaryColor;
      case "Limited Time":
        return dangerColor;
      case "New Arrival":
        return successColor;
      case "Editor's Choice":
        return infoColor;
      case "Hot Deal":
        return warningColor;
      case "Gamer's Choice":
        return primaryColor;
      case "Healthy Choice":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Deals"),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with countdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "24-Hour Flash Sale",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Save up to 70% on selected items",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Ends in 18:42:35",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredProducts.length} deals available",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Price filter
            Row(
              children: [
                Text(
                  "Price Range:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: priceRanges,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Products grid
            if (filteredProducts.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No deals found",
                      style: TextStyle(
                        fontSize: 18,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your price range",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredProducts.map((product) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image with badges
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${product["image"]}",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Discount badge
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
                                  "-${product["discountPercentage"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),

                            // Free shipping badge
                            if (product["freeShipping"] as bool)
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "FREE SHIP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),

                            // Stock warning
                            if ((product["stockCount"] as int) < 20)
                              Positioned(
                                bottom: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${product["stockCount"]} left",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Brand and tags
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
                                  if ((product["tags"] as List).isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getTagColor((product["tags"] as List)[0] as String),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${(product["tags"] as List)[0]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),

                              // Product name
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),

                              // Rating and reviews
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${product["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${product["reviewCount"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${product["category"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),

                              // Price section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$${((product["originalPrice"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Save \$${(((product["originalPrice"] as double) - (product["discountedPrice"] as double)).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "\$${((product["discountedPrice"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),

                              // Action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Add to Cart",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    width: 40,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_outline,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
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
        ),
      ),
    );
  }
}

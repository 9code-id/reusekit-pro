import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct8View extends StatefulWidget {
  @override
  State<GrlProduct8View> createState() => _GrlProduct8ViewState();
}

class _GrlProduct8ViewState extends State<GrlProduct8View> {
  String selectedComparison = 'features';
  List<String> selectedProducts = [];

  List<Map<String, dynamic>> comparisonTypes = [
    {"label": "Features", "value": "features"},
    {"label": "Specifications", "value": "specifications"},
    {"label": "Pricing", "value": "pricing"},
    {"label": "Reviews", "value": "reviews"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "brand": "Apple",
      "price": 1199.99,
      "image": "https://picsum.photos/400/400?random=1&keyword=iphone",
      "rating": 4.8,
      "reviews": 3421,
      "category": "Smartphones",
      "features": {
        "Display": "6.7\" Super Retina XDR",
        "Processor": "A17 Pro Chip",
        "Camera": "48MP Triple Camera",
        "Battery": "29 hours video",
        "Storage": "256GB - 1TB",
        "5G": true,
        "Wireless Charging": true,
        "Face ID": true,
        "Water Resistant": "IP68",
      },
      "specifications": {
        "Dimensions": "159.9 × 76.7 × 8.25 mm",
        "Weight": "221g",
        "Display Type": "OLED",
        "Resolution": "2796 × 1290",
        "RAM": "8GB",
        "Operating System": "iOS 17",
        "Connectivity": "5G, Wi-Fi 6E, Bluetooth 5.3",
        "Colors": "4 options",
      },
      "pros": [
        "Excellent camera quality",
        "Premium build quality",
        "Long software support",
        "Great performance",
      ],
      "cons": [
        "Expensive",
        "No headphone jack",
        "Lightning to USB-C transition",
      ],
    },
    {
      "id": 2,
      "name": "Samsung Galaxy S24 Ultra",
      "brand": "Samsung",
      "price": 1099.99,
      "image": "https://picsum.photos/400/400?random=2&keyword=samsung",
      "rating": 4.7,
      "reviews": 2876,
      "category": "Smartphones",
      "features": {
        "Display": "6.8\" Dynamic AMOLED 2X",
        "Processor": "Snapdragon 8 Gen 3",
        "Camera": "200MP Quad Camera",
        "Battery": "5000mAh",
        "Storage": "256GB - 1TB",
        "5G": true,
        "Wireless Charging": true,
        "S Pen": true,
        "Water Resistant": "IP68",
      },
      "specifications": {
        "Dimensions": "162.3 × 79.0 × 8.6 mm",
        "Weight": "232g",
        "Display Type": "Dynamic AMOLED 2X",
        "Resolution": "3120 × 1440",
        "RAM": "12GB",
        "Operating System": "Android 14",
        "Connectivity": "5G, Wi-Fi 7, Bluetooth 5.3",
        "Colors": "4 options",
      },
      "pros": [
        "S Pen functionality",
        "Excellent display",
        "Versatile camera system",
        "Good value for money",
      ],
      "cons": [
        "Bloatware",
        "Battery life could be better",
        "Large size",
      ],
    },
    {
      "id": 3,
      "name": "Google Pixel 8 Pro",
      "brand": "Google",
      "price": 899.99,
      "image": "https://picsum.photos/400/400?random=3&keyword=pixel",
      "rating": 4.6,
      "reviews": 1892,
      "category": "Smartphones",
      "features": {
        "Display": "6.7\" LTPO OLED",
        "Processor": "Google Tensor G3",
        "Camera": "50MP Triple Camera",
        "Battery": "5050mAh",
        "Storage": "128GB - 1TB",
        "5G": true,
        "Wireless Charging": true,
        "Magic Eraser": true,
        "Water Resistant": "IP68",
      },
      "specifications": {
        "Dimensions": "162.6 × 76.5 × 8.8 mm",
        "Weight": "213g",
        "Display Type": "LTPO OLED",
        "Resolution": "2992 × 1344",
        "RAM": "12GB",
        "Operating System": "Android 14",
        "Connectivity": "5G, Wi-Fi 7, Bluetooth 5.3",
        "Colors": "3 options",
      },
      "pros": [
        "Clean Android experience",
        "Excellent AI features",
        "Great camera software",
        "Regular updates",
      ],
      "cons": [
        "Battery life average",
        "Heating issues",
        "Limited availability",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Comparison"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                selectedProducts.clear();
              });
              si("Comparison cleared");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Product Selection Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Products to Compare",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Choose up to 3 products for detailed comparison",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                // Comparison Type Selector
                QHorizontalScroll(
                  children: comparisonTypes.map((type) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedComparison = type["value"];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedComparison == type["value"]
                            ? primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Text(
                        "${type["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedComparison == type["value"]
                              ? Colors.white
                              : primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Product Selection
          if (selectedProducts.length < 3)
            Container(
              height: 200,
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Products",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: QHorizontalScroll(
                      children: products.where((product) => 
                        !selectedProducts.contains(product["id"].toString())
                      ).map((product) => _buildProductSelectionCard(product)).toList(),
                    ),
                  ),
                ],
              ),
            ),

          // Selected Products for Comparison
          if (selectedProducts.isNotEmpty)
            Expanded(
              child: selectedProducts.length == 1
                  ? _buildSingleProductView()
                  : _buildComparisonView(),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.compare_arrows,
                      size: 80,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Select products to compare",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Choose products from above to see detailed comparison",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductSelectionCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        if (selectedProducts.length < 3) {
          setState(() {
            selectedProducts.add(product["id"].toString());
          });
          ss("${product["name"]} added to comparison");
        } else {
          sw("Maximum 3 products can be compared");
        }
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(color: primaryColor.withAlpha(50)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
              child: Image.network(
                "${product["image"]}",
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(product["price"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.star, size: 12, color: warningColor),
                      SizedBox(width: 2),
                      Text(
                        "${product["rating"]}",
                        style: TextStyle(fontSize: 10),
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
  }

  Widget _buildSingleProductView() {
    final product = products.firstWhere((p) => p["id"].toString() == selectedProducts[0]);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${product["image"]}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${product["brand"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(product["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: 4),
                        Text("${product["rating"]} (${product["reviews"]} reviews)"),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: dangerColor),
                onPressed: () {
                  setState(() {
                    selectedProducts.remove(product["id"].toString());
                  });
                },
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Content based on selected comparison type
          if (selectedComparison == 'features')
            _buildSingleProductFeatures(product)
          else if (selectedComparison == 'specifications')
            _buildSingleProductSpecifications(product)
          else if (selectedComparison == 'pricing')
            _buildSingleProductPricing(product)
          else if (selectedComparison == 'reviews')
            _buildSingleProductReviews(product),
        ],
      ),
    );
  }

  Widget _buildComparisonView() {
    final comparisonProducts = products.where((p) => 
      selectedProducts.contains(p["id"].toString())
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Product Headers
          Row(
            children: comparisonProducts.map((product) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${product["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProducts.remove(product["id"].toString());
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(product["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),

          SizedBox(height: spMd),

          // Comparison Content
          if (selectedComparison == 'features')
            _buildFeaturesComparison(comparisonProducts)
          else if (selectedComparison == 'specifications')
            _buildSpecificationsComparison(comparisonProducts)
          else if (selectedComparison == 'pricing')
            _buildPricingComparison(comparisonProducts)
          else if (selectedComparison == 'reviews')
            _buildReviewsComparison(comparisonProducts),
        ],
      ),
    );
  }

  Widget _buildSingleProductFeatures(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Features",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        ...(product["features"] as Map<String, dynamic>).entries.map((entry) => 
          Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${entry.value}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleProductSpecifications(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Specifications",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: (product["specifications"] as Map<String, dynamic>).entries.map((entry) => 
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleProductPricing(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pricing Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current Price"),
                  Text(
                    "\$${(product["price"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rating"),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: warningColor),
                      Text(" ${product["rating"]}"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reviews"),
                  Text("${product["reviews"]} reviews"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSingleProductReviews(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pros & Cons",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pros",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(product["pros"] as List).map((pro) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 16, color: successColor),
                        SizedBox(width: spSm),
                        Expanded(child: Text("$pro", style: TextStyle(fontSize: 12))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cons",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(product["cons"] as List).map((con) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Icon(Icons.remove, size: 16, color: dangerColor),
                        SizedBox(width: spSm),
                        Expanded(child: Text("$con", style: TextStyle(fontSize: 12))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesComparison(List<Map<String, dynamic>> products) {
    // Get all unique features
    Set<String> allFeatures = {};
    for (var product in products) {
      allFeatures.addAll((product["features"] as Map<String, dynamic>).keys);
    }

    return Column(
      children: allFeatures.map((feature) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feature,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: products.map((product) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: Text(
                    "${(product["features"] as Map<String, dynamic>)[feature] ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSpecificationsComparison(List<Map<String, dynamic>> products) {
    Set<String> allSpecs = {};
    for (var product in products) {
      allSpecs.addAll((product["specifications"] as Map<String, dynamic>).keys);
    }

    return Column(
      children: allSpecs.map((spec) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              spec,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: products.map((product) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: Text(
                    "${(product["specifications"] as Map<String, dynamic>)[spec] ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildPricingComparison(List<Map<String, dynamic>> products) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: products.map((product) => Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${(product["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text("Price", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: spMd),
              Row(
                children: products.map((product) => Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 16, color: warningColor),
                          Text(" ${product["rating"]}"),
                        ],
                      ),
                      Text("Rating", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsComparison(List<Map<String, dynamic>> products) {
    return Column(
      children: products.map((product) => Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${product["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pros", style: TextStyle(color: successColor, fontWeight: FontWeight.bold)),
                      ...(product["pros"] as List).map((pro) => Text("• $pro", style: TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cons", style: TextStyle(color: dangerColor, fontWeight: FontWeight.bold)),
                      ...(product["cons"] as List).map((con) => Text("• $con", style: TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }
}

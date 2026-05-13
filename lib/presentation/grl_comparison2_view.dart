import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComparison2View extends StatefulWidget {
  @override
  State<GrlComparison2View> createState() => _GrlComparison2ViewState();
}

class _GrlComparison2ViewState extends State<GrlComparison2View> {
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "MacBook Pro 14\"",
      "brand": "Apple",
      "price": 1999.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=macbook",
      "rating": 4.8,
      "reviews": 2847,
      "specifications": {
        "Processor": "M3 Pro Chip",
        "Memory": "18GB Unified Memory",
        "Storage": "512GB SSD",
        "Display": "14.2\" Liquid Retina XDR",
        "Battery": "Up to 18 hours",
        "Weight": "1.6 kg",
        "Ports": "3x Thunderbolt 4, HDMI, MagSafe 3",
        "Graphics": "Integrated GPU",
      },
      "features": [
        "Touch ID",
        "Backlit Keyboard",
        "Force Touch Trackpad",
        "macOS Sonoma",
        "Studio-quality mics",
      ],
      "score": 9.1,
      "isSelected": true,
    },
    {
      "id": 2,
      "name": "Dell XPS 13",
      "brand": "Dell",
      "price": 1299.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=laptop",
      "rating": 4.5,
      "reviews": 1923,
      "specifications": {
        "Processor": "Intel Core i7-13700H",
        "Memory": "16GB LPDDR5",
        "Storage": "512GB PCIe NVMe SSD",
        "Display": "13.4\" FHD+ InfinityEdge",
        "Battery": "Up to 12 hours",
        "Weight": "1.2 kg",
        "Ports": "2x Thunderbolt 4, microSD",
        "Graphics": "Intel Iris Xe",
      },
      "features": [
        "Windows Hello",
        "Precision Touchpad",
        "Killer Wi-Fi 6E",
        "Windows 11",
        "CNC Machined Aluminum",
      ],
      "score": 8.4,
      "isSelected": true,
    },
    {
      "id": 3,
      "name": "ThinkPad X1 Carbon",
      "brand": "Lenovo",
      "price": 1599.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=thinkpad",
      "rating": 4.6,
      "reviews": 1456,
      "specifications": {
        "Processor": "Intel Core i7-13700U",
        "Memory": "16GB LPDDR5",
        "Storage": "1TB PCIe Gen4 SSD",
        "Display": "14\" WUXGA IPS",
        "Battery": "Up to 15 hours",
        "Weight": "1.1 kg",
        "Ports": "2x Thunderbolt 4, 2x USB-A",
        "Graphics": "Intel Iris Xe",
      },
      "features": [
        "ThinkPad TrackPoint",
        "Fingerprint Reader",
        "Dolby Audio",
        "Windows 11 Pro",
        "Military-grade Durability",
      ],
      "score": 8.7,
      "isSelected": false,
    },
    {
      "id": 4,
      "name": "Surface Laptop 5",
      "brand": "Microsoft",
      "price": 1299.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=surface",
      "rating": 4.3,
      "reviews": 1134,
      "specifications": {
        "Processor": "Intel Core i7-12700H",
        "Memory": "16GB LPDDR5x",
        "Storage": "512GB PCIe SSD",
        "Display": "13.5\" PixelSense Touchscreen",
        "Battery": "Up to 17 hours",
        "Weight": "1.3 kg",
        "Ports": "1x USB-C, 1x USB-A, Surface Connect",
        "Graphics": "Intel Iris Xe",
      },
      "features": [
        "Windows Hello",
        "Precision Touchpad",
        "Omnisonic Speakers",
        "Windows 11",
        "Alcantara Keyboard",
      ],
      "score": 8.2,
      "isSelected": false,
    },
  ];

  List<Map<String, dynamic>> get selectedProducts => 
      products.where((product) => product["isSelected"] as bool).toList();

  List<String> get allSpecKeys {
    Set<String> keys = {};
    for (var product in selectedProducts) {
      keys.addAll((product["specifications"] as Map<String, dynamic>).keys);
    }
    return keys.toList()..sort();
  }

  void _toggleProductSelection(int productId) {
    int selectedCount = selectedProducts.length;
    
    // Find the product and check if it's currently selected
    int productIndex = products.indexWhere((p) => p["id"] == productId);
    bool isCurrentlySelected = products[productIndex]["isSelected"] as bool;
    
    // Don't allow deselecting if only 2 products are selected
    if (isCurrentlySelected && selectedCount <= 2) {
      se("You must select at least 2 products to compare");
      return;
    }
    
    // Don't allow selecting more than 4 products
    if (!isCurrentlySelected && selectedCount >= 4) {
      se("You can compare up to 4 products at once");
      return;
    }
    
    products[productIndex]["isSelected"] = !isCurrentlySelected;
    setState(() {});
  }

  Color _getScoreColor(double score) {
    if (score >= 9.0) return successColor;
    if (score >= 8.5) return primaryColor;
    if (score >= 8.0) return infoColor;
    if (score >= 7.5) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laptop Comparison"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              _showProductSelector();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with selected products count
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(radiusLg),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.compare,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comparing ${selectedProducts.length} Products",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Side by side comparison",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Change",
                    size: bs.sm,
                    onPressed: _showProductSelector,
                  ),
                ],
              ),
            ),

            // Product overview cards
            Container(
              height: 280,
              padding: EdgeInsets.symmetric(vertical: spMd),
              child: QHorizontalScroll(
                children: selectedProducts.map((product) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(
                      left: selectedProducts.indexOf(product) == 0 ? spMd : spSm,
                      right: selectedProducts.indexOf(product) == selectedProducts.length - 1 ? spMd : 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${product["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Product details
                        Padding(
                          padding: EdgeInsets.all(spSm),
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
                              SizedBox(height: 2),
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
                                    "(${product["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),

                              // Score
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getScoreColor(product["score"] as double).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Score: ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${product["score"]}/10",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getScoreColor(product["score"] as double),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spXs),

                              // Price
                              Text(
                                "\$${((product["price"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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

            // Specifications comparison table
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detailed Comparison",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Comparison table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        // Header row
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Specification",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              ...selectedProducts.map((product) {
                                return Expanded(
                                  child: Text(
                                    "${product["brand"]} ${product["name"]}".split(' ').take(2).join(' '),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                        // Specification rows
                        Column(
                          children: allSpecKeys.map((specKey) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: disabledColor.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      specKey,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  ...selectedProducts.map((product) {
                                    Map<String, dynamic> specs = product["specifications"] as Map<String, dynamic>;
                                    String value = specs[specKey] ?? "N/A";
                                    
                                    return Expanded(
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: primaryColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spLg),

                  // Features comparison
                  Text(
                    "Key Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Column(
                    spacing: spMd,
                    children: selectedProducts.map((product) {
                      return Container(
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
                              "${product["brand"]} ${product["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (product["features"] as List<String>).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Title
            Text(
              "Select Products to Compare",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Choose 2-4 products to compare side by side",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),

            // Products list
            Expanded(
              child: Column(
                spacing: spMd,
                children: products.map((product) {
                  bool isSelected = product["isSelected"] as bool;
                  
                  return GestureDetector(
                    onTap: () => _toggleProductSelection(product["id"] as int),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor.withAlpha(100),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Checkbox
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: spSm),

                          // Product image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${product["image"]}",
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),

                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product["brand"]} ${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "\$${((product["price"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
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
                }).toList(),
              ),
            ),

            // Apply button
            SizedBox(height: spMd),
            QButton(
              label: "Apply Selection (${selectedProducts.length} selected)",
              size: bs.md,
              onPressed: () {
                if (selectedProducts.length < 2) {
                  se("Please select at least 2 products to compare");
                  return;
                }
                back();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsColorOptionsView extends StatefulWidget {
  const EcsColorOptionsView({super.key});

  @override
  State<EcsColorOptionsView> createState() => _EcsColorOptionsViewState();
}

class _EcsColorOptionsViewState extends State<EcsColorOptionsView> {
  String selectedColor = "Red";
  int selectedColorIndex = 0;

  List<Map<String, dynamic>> productColors = [
    {
      "name": "Classic Red",
      "code": "red",
      "color": Colors.red,
      "available": true,
      "stock": 25,
      "price": 99.99,
      "image": "https://picsum.photos/400/400?random=1&keyword=red",
      "description": "Bold and vibrant red color option",
    },
    {
      "name": "Ocean Blue",
      "code": "blue",
      "color": Colors.blue,
      "available": true,
      "stock": 15,
      "price": 99.99,
      "image": "https://picsum.photos/400/400?random=2&keyword=blue",
      "description": "Deep ocean blue with premium finish",
    },
    {
      "name": "Forest Green",
      "code": "green",
      "color": Colors.green,
      "available": true,
      "stock": 8,
      "price": 104.99,
      "image": "https://picsum.photos/400/400?random=3&keyword=green",
      "description": "Natural forest green color",
    },
    {
      "name": "Sunset Orange",
      "code": "orange",
      "color": Colors.orange,
      "available": false,
      "stock": 0,
      "price": 99.99,
      "image": "https://picsum.photos/400/400?random=4&keyword=orange",
      "description": "Vibrant sunset orange - currently out of stock",
    },
    {
      "name": "Royal Purple",
      "code": "purple",
      "color": Colors.purple,
      "available": true,
      "stock": 12,
      "price": 109.99,
      "image": "https://picsum.photos/400/400?random=5&keyword=purple",
      "description": "Luxurious royal purple finish",
    },
    {
      "name": "Midnight Black",
      "code": "black",
      "color": Colors.black,
      "available": true,
      "stock": 30,
      "price": 99.99,
      "image": "https://picsum.photos/400/400?random=6&keyword=black",
      "description": "Classic midnight black color",
    },
    {
      "name": "Pearl White",
      "code": "white",
      "color": Colors.white,
      "available": true,
      "stock": 20,
      "price": 99.99,
      "image": "https://picsum.photos/400/400?random=7&keyword=white",
      "description": "Elegant pearl white finish",
    },
    {
      "name": "Rose Gold",
      "code": "rose_gold",
      "color": Colors.pink,
      "available": true,
      "stock": 5,
      "price": 119.99,
      "image": "https://picsum.photos/400/400?random=8&keyword=pink",
      "description": "Premium rose gold with metallic finish",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentColor = productColors[selectedColorIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Color Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              ss("Added to wishlist");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Product Image Section
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Stack(
                        children: [
                          Image.network(
                            "${currentColor["image"]}",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          
                          // Stock Status Overlay
                          if (!(currentColor["available"] as bool))
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black.withAlpha(153),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spMd,
                                    vertical: spSm,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "OUT OF STOCK",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Price Badge
                          Positioned(
                            top: spMd,
                            right: spMd,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [shadowSm],
                              ),
                              child: Text(
                                "\$${(currentColor["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          // Stock Count (if available)
                          if (currentColor["available"] as bool)
                            Positioned(
                              top: spMd,
                              left: spMd,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${currentColor["stock"]} in stock",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Color Info Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: currentColor["color"] as Color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: disabledOutlineBorderColor,
                                  width: 2,
                                ),
                                boxShadow: [shadowSm],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${currentColor["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${currentColor["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Stock and Availability Info
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (currentColor["available"] as bool) 
                                ? successColor.withAlpha(25) 
                                : dangerColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                (currentColor["available"] as bool) 
                                    ? Icons.check_circle 
                                    : Icons.error,
                                color: (currentColor["available"] as bool) 
                                    ? successColor 
                                    : dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  (currentColor["available"] as bool)
                                      ? "In Stock - ${currentColor["stock"]} units available"
                                      : "Currently out of stock",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: (currentColor["available"] as bool) 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Color Selection Grid
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Colors",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),

                        // Color Grid
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: productColors.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> color = entry.value;
                            bool isSelected = index == selectedColorIndex;
                            bool isAvailable = color["available"] as bool;

                            return GestureDetector(
                              onTap: () {
                                selectedColorIndex = index;
                                selectedColor = "${color["name"]}";
                                setState(() {});
                              },
                              child: Container(
                                width: 80,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected 
                                        ? primaryColor 
                                        : disabledOutlineBorderColor,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  boxShadow: isSelected ? [shadowMd] : [shadowSm],
                                ),
                                child: Column(
                                  children: [
                                    // Color Circle
                                    Container(
                                      margin: EdgeInsets.all(spSm),
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: color["color"] as Color,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 1,
                                        ),
                                      ),
                                      child: !isAvailable
                                          ? Icon(
                                              Icons.close,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),

                                    // Color Name
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: spXs),
                                        child: Text(
                                          "${color["name"]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: isSelected 
                                                ? FontWeight.bold 
                                                : FontWeight.normal,
                                            color: isAvailable 
                                                ? (isSelected ? primaryColor : disabledBoldColor)
                                                : disabledColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                    // Price
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? primaryColor 
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(radiusSm),
                                        ),
                                      ),
                                      child: Text(
                                        "\$${(color["price"] as double).toStringAsFixed(0)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected 
                                              ? Colors.white 
                                              : disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Related Products Section
                  Container(
                    margin: EdgeInsets.all(spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You might also like",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        QHorizontalScroll(
                          children: List.generate(5, (index) {
                            return Container(
                              width: 120,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: disabledOutlineBorderColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(radiusSm),
                                    ),
                                    child: Image.network(
                                      "https://picsum.photos/120/80?random=${index + 10}",
                                      width: double.infinity,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(spSm),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Related Item ${index + 1}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "\$${(89.99 + index * 10).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Selected Color Summary
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: currentColor["color"] as Color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${currentColor["name"]} - \$${(currentColor["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (currentColor["available"] as bool)
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add to Cart",
                        icon: Icons.shopping_cart,
                        size: bs.md,
                        onPressed: (currentColor["available"] as bool) ? () {
                          ss("${currentColor["name"]} added to cart");
                        } : null,
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.md,
                      onPressed: () {
                        ss("Added to wishlist");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

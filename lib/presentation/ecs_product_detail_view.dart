import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductDetailView extends StatefulWidget {
  const EcsProductDetailView({super.key});

  @override
  State<EcsProductDetailView> createState() => _EcsProductDetailViewState();
}

class _EcsProductDetailViewState extends State<EcsProductDetailView> {
  int selectedImageIndex = 0;
  int quantity = 1;
  String selectedSize = "M";
  String selectedColor = "Blue";
  bool isFavorite = false;
  int selectedTabIndex = 0;

  Map<String, dynamic> product = {
    "id": 1,
    "name": "Premium Wireless Bluetooth Headphones",
    "brand": "AudioTech",
    "price": 89.99,
    "originalPrice": 129.99,
    "discount": 31,
    "rating": 4.5,
    "reviews": 234,
    "sold": 1250,
    "inStock": true,
    "stockCount": 45,
    "description": "Experience superior sound quality with our premium wireless headphones. Featuring advanced noise cancellation, 30-hour battery life, and ultra-comfortable design for all-day use.",
    "features": [
      "30-hour battery life",
      "Active noise cancellation",
      "Wireless charging case",
      "Premium leather ear cups",
      "Universal compatibility",
      "Voice assistant support"
    ],
    "specifications": {
      "Weight": "250g",
      "Battery": "30 hours",
      "Connectivity": "Bluetooth 5.0",
      "Range": "33 feet",
      "Charging": "USB-C & Wireless",
      "Compatibility": "All devices"
    },
    "images": [
      "https://picsum.photos/400/400?random=20&keyword=headphones",
      "https://picsum.photos/400/400?random=21&keyword=headphones",
      "https://picsum.photos/400/400?random=22&keyword=headphones",
      "https://picsum.photos/400/400?random=23&keyword=headphones",
    ],
    "colors": ["Blue", "Black", "White", "Red"],
    "sizes": ["S", "M", "L", "XL"],
  };

  List<Map<String, dynamic>> reviews = [
    {
      "user": "John Smith",
      "rating": 5,
      "date": "2 days ago",
      "comment": "Amazing sound quality! The noise cancellation works perfectly and the battery life is excellent.",
      "helpful": 12,
    },
    {
      "user": "Sarah Johnson",
      "rating": 4,
      "date": "1 week ago",
      "comment": "Very comfortable to wear for long periods. Great value for money.",
      "helpful": 8,
    },
    {
      "user": "Mike Wilson",
      "rating": 5,
      "date": "2 weeks ago",
      "comment": "Best headphones I've ever owned. The wireless charging is a nice touch.",
      "helpful": 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          GestureDetector(
            onTap: () {
              isFavorite = !isFavorite;
              setState(() {});
              ss(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : disabledBoldColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            Icons.share,
            color: disabledBoldColor,
            size: 24,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Images
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                    ),
                    child: Image.network(
                      "${(product["images"] as List)[selectedImageIndex]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  if ((product["discount"] as int) > 0)
                    Positioned(
                      top: spMd,
                      left: spMd,
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
                          "${product["discount"]}% OFF",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: spMd,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      child: QHorizontalScroll(
                        children: List.generate((product["images"] as List).length, (index) {
                          final isSelected = selectedImageIndex == index;
                          return GestureDetector(
                            onTap: () {
                              selectedImageIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(left: index == 0 ? spMd : spXs),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${(product["images"] as List)[index]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Info
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${product["brand"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${product["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (product["rating"] as double).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 16,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${product["rating"]} (${product["reviews"]} reviews)",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${((product["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((product["originalPrice"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${product["sold"]} sold",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Stock Status
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: product["inStock"] 
                          ? successColor.withAlpha(20)
                          : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: product["inStock"] 
                            ? successColor.withAlpha(50)
                            : dangerColor.withAlpha(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          product["inStock"] ? Icons.check_circle : Icons.error,
                          color: product["inStock"] ? successColor : dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          product["inStock"] 
                              ? "In Stock (${product["stockCount"]} items left)"
                              : "Out of Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: product["inStock"] ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Size and Color Selection
                  if ((product["sizes"] as List).isNotEmpty)
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Size: $selectedSize",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          QHorizontalScroll(
                            children: (product["sizes"] as List).map<Widget>((size) {
                              final isSelected = selectedSize == size;
                              return GestureDetector(
                                onTap: () {
                                  selectedSize = size;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.white,
                                    border: Border.all(
                                      color: isSelected ? primaryColor : disabledColor,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "$size",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                  if ((product["colors"] as List).isNotEmpty)
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Color: $selectedColor",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          QHorizontalScroll(
                            children: (product["colors"] as List).map<Widget>((color) {
                              final isSelected = selectedColor == color;
                              return GestureDetector(
                                onTap: () {
                                  selectedColor = color;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.white,
                                    border: Border.all(
                                      color: isSelected ? primaryColor : disabledColor,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "$color",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                  // Quantity Selector
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          "Quantity:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  quantity--;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledColor),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: disabledColor),
                                  bottom: BorderSide(color: disabledColor),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "$quantity",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (quantity < (product["stockCount"] as int)) {
                                  quantity++;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledColor),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Tabs
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTabIndex = 0;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: selectedTabIndex == 0 
                                            ? primaryColor 
                                            : disabledColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Description",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTabIndex == 0 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTabIndex = 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: selectedTabIndex == 1 
                                            ? primaryColor 
                                            : disabledColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Reviews",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTabIndex == 1 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        if (selectedTabIndex == 0) ...[
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spMd,
                              children: [
                                Text(
                                  "${product["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    height: 1.6,
                                  ),
                                ),
                                Text(
                                  "Key Features:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                ...(product["features"] as List).map((feature) {
                                  return Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "$feature",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ] else ...[
                          Container(
                            width: double.infinity,
                            child: Column(
                              spacing: spMd,
                              children: reviews.map((review) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spSm,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${review["user"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "${review["date"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < (review["rating"] as int)
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: warningColor,
                                            size: 14,
                                          );
                                        }),
                                      ),
                                      Text(
                                        "${review["comment"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: disabledColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Helpful (${review["helpful"]})",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Add to Cart",
                size: bs.md,
                onPressed: product["inStock"] ? () {
                  ss("Added to cart!");
                } : null,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Buy Now",
                size: bs.md,
                onPressed: product["inStock"] ? () {
                  ss("Proceeding to checkout...");
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

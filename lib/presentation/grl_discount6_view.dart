import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount6View extends StatefulWidget {
  @override
  State<GrlDiscount6View> createState() => _GrlDiscount6ViewState();
}

class _GrlDiscount6ViewState extends State<GrlDiscount6View> {
  String selectedSort = "Biggest Discount";
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Biggest Discount", "value": "Biggest Discount"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Newest First", "value": "Newest First"},
  ];

  List<Map<String, dynamic>> clearanceItems = [
    {
      "id": 1,
      "name": "Samsung Galaxy S23",
      "brand": "Samsung",
      "originalPrice": 899.0,
      "clearancePrice": 399.0,
      "discount": 56,
      "image": "https://picsum.photos/300/200?random=1&keyword=phone",
      "stock": 12,
      "rating": 4.6,
      "category": "Electronics",
      "condition": "New",
      "savings": 500.0,
    },
    {
      "id": 2,
      "name": "Nike Running Shoes",
      "brand": "Nike",
      "originalPrice": 180.0,
      "clearancePrice": 79.0,
      "discount": 56,
      "image": "https://picsum.photos/300/200?random=2&keyword=shoes",
      "stock": 8,
      "rating": 4.4,
      "category": "Fashion",
      "condition": "New",
      "savings": 101.0,
    },
    {
      "id": 3,
      "name": "KitchenAid Mixer",
      "brand": "KitchenAid",
      "originalPrice": 449.0,
      "clearancePrice": 199.0,
      "discount": 56,
      "image": "https://picsum.photos/300/200?random=3&keyword=mixer",
      "stock": 5,
      "rating": 4.8,
      "category": "Home",
      "condition": "Open Box",
      "savings": 250.0,
    },
    {
      "id": 4,
      "name": "Gaming Chair",
      "brand": "DXRacer",
      "originalPrice": 399.0,
      "clearancePrice": 149.0,
      "discount": 63,
      "image": "https://picsum.photos/300/200?random=4&keyword=chair",
      "stock": 3,
      "rating": 4.2,
      "category": "Furniture",
      "condition": "Refurbished",
      "savings": 250.0,
    },
    {
      "id": 5,
      "name": "Wireless Headphones",
      "brand": "Sony",
      "originalPrice": 299.0,
      "clearancePrice": 89.0,
      "discount": 70,
      "image": "https://picsum.photos/300/200?random=5&keyword=headphones",
      "stock": 15,
      "rating": 4.5,
      "category": "Electronics",
      "condition": "New",
      "savings": 210.0,
    },
    {
      "id": 6,
      "name": "Coffee Machine",
      "brand": "Breville",
      "originalPrice": 699.0,
      "clearancePrice": 299.0,
      "discount": 57,
      "image": "https://picsum.photos/300/200?random=6&keyword=coffee",
      "stock": 7,
      "rating": 4.7,
      "category": "Home",
      "condition": "Display Model",
      "savings": 400.0,
    },
  ];

  List<Map<String, dynamic>> get sortedItems {
    List<Map<String, dynamic>> items = List.from(clearanceItems);
    
    switch (selectedSort) {
      case "Biggest Discount":
        items.sort((a, b) => (b["discount"] as int).compareTo(a["discount"] as int));
        break;
      case "Price: Low to High":
        items.sort((a, b) => (a["clearancePrice"] as double).compareTo(b["clearancePrice"] as double));
        break;
      case "Price: High to Low":
        items.sort((a, b) => (b["clearancePrice"] as double).compareTo(a["clearancePrice"] as double));
        break;
      case "Newest First":
        // Keep original order for newest first
        break;
    }
    return items;
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "New":
        return successColor;
      case "Open Box":
        return infoColor;
      case "Refurbished":
        return warningColor;
      case "Display Model":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clearance Sale"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
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
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Final Clearance",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Up to 70% off - Last chance!",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Limited quantities - While supplies last",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Sort and filter
            Row(
              children: [
                Text(
                  "Sort by:",
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
            SizedBox(height: spMd),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "${clearanceItems.length} Items",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.savings, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Save \$${((clearanceItems.map((item) => item["savings"] as double).reduce((a, b) => a + b)).toDouble()).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Items grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: sortedItems.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: dangerColor.withAlpha(100),
                      width: 1,
                    ),
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
                              "${item["image"]}",
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
                                "-${item["discount"]}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          // Condition badge
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getConditionColor(item["condition"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["condition"]}".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),

                          // Stock indicator
                          if ((item["stock"] as int) <= 5)
                            Positioned(
                              bottom: spSm,
                              right: spSm,
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
                                  "Only ${item["stock"]} left",
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
                            // Brand
                            Text(
                              "${item["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),

                            // Product name
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 16,
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
                                  size: 16,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                                      "\$${((item["originalPrice"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Save \$${((item["savings"] as double).toDouble()).currency}",
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
                                  "\$${((item["clearancePrice"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),

                            // Add to cart button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Add to Cart",
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

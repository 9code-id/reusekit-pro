import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRecentlyViewedView extends StatefulWidget {
  const EcsRecentlyViewedView({super.key});

  @override
  State<EcsRecentlyViewedView> createState() => _EcsRecentlyViewedViewState();
}

class _EcsRecentlyViewedViewState extends State<EcsRecentlyViewedView> {
  String sortBy = "Recent";
  
  List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": "1",
      "name": "Wireless Bluetooth Headphones",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "category": "Electronics",
      "rating": 4.5,
      "reviews": 156,
      "viewedAt": "2024-01-15T16:30:00Z",
      "inStock": true,
      "discount": 31,
    },
    {
      "id": "2",
      "name": "Organic Cotton T-Shirt",
      "price": 24.99,
      "originalPrice": 34.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=tshirt",
      "category": "Clothing",
      "rating": 4.3,
      "reviews": 89,
      "viewedAt": "2024-01-15T14:20:00Z",
      "inStock": true,
      "discount": 29,
    },
    {
      "id": "3",
      "name": "Smart Watch Series 5",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=smartwatch",
      "category": "Electronics",
      "rating": 4.7,
      "reviews": 234,
      "viewedAt": "2024-01-15T12:45:00Z",
      "inStock": false,
      "discount": 25,
    },
    {
      "id": "4",
      "name": "Coffee Maker Deluxe",
      "price": 149.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/300?random=4&keyword=coffee",
      "category": "Home & Kitchen",
      "rating": 4.4,
      "reviews": 178,
      "viewedAt": "2024-01-15T10:15:00Z",
      "inStock": true,
      "discount": 25,
    },
    {
      "id": "5",
      "name": "Yoga Mat Premium",
      "price": 39.99,
      "originalPrice": 59.99,
      "image": "https://picsum.photos/300/300?random=5&keyword=yoga",
      "category": "Sports & Fitness",
      "rating": 4.6,
      "reviews": 145,
      "viewedAt": "2024-01-14T18:30:00Z",
      "inStock": true,
      "discount": 33,
    },
    {
      "id": "6",
      "name": "LED Desk Lamp",
      "price": 59.99,
      "originalPrice": 79.99,
      "image": "https://picsum.photos/300/300?random=6&keyword=lamp",
      "category": "Home & Office",
      "rating": 4.2,
      "reviews": 67,
      "viewedAt": "2024-01-14T16:45:00Z",
      "inStock": true,
      "discount": 25,
    },
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recently Viewed", "value": "Recent"},
    {"label": "Price: Low to High", "value": "PriceLow"},
    {"label": "Price: High to Low", "value": "PriceHigh"},
    {"label": "Highest Rated", "value": "Rating"},
    {"label": "Most Reviews", "value": "Reviews"},
  ];

  bool loading = false;

  void _sortProducts() {
    switch (sortBy) {
      case "Recent":
        recentlyViewed.sort((a, b) => 
            DateTime.parse(b["viewedAt"]).compareTo(DateTime.parse(a["viewedAt"])));
        break;
      case "PriceLow":
        recentlyViewed.sort((a, b) => 
            (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "PriceHigh":
        recentlyViewed.sort((a, b) => 
            (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "Rating":
        recentlyViewed.sort((a, b) => 
            (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Reviews":
        recentlyViewed.sort((a, b) => 
            (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
    }
    setState(() {});
  }

  void _clearHistory() async {
    bool isConfirmed = await confirm("Are you sure you want to clear your viewing history?");
    if (isConfirmed) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 1));

      recentlyViewed.clear();
      loading = false;
      setState(() {});

      ss("Viewing history cleared");
    }
  }

  void _removeItem(String productId) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    recentlyViewed.removeWhere((product) => product["id"] == productId);
    loading = false;
    setState(() {});

    ss("Item removed from history");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recently Viewed"),
        actions: [
          if (recentlyViewed.isNotEmpty)
            QButton(
              icon: Icons.clear_all,
              size: bs.sm,
              onPressed: _clearHistory,
            ),
        ],
      ),
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: spMd,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Updating...",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          : recentlyViewed.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: spMd,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.history,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "No Recently Viewed Items",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Products you view will appear here for easy access",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Start Shopping",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('shop')
                        },
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Header with Sort
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Your Viewing History",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${recentlyViewed.length} items viewed",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: QDropdownField(
                              label: "Sort by",
                              items: sortOptions,
                              value: sortBy,
                              onChanged: (value, label) {
                                sortBy = value;
                                _sortProducts();
                              },
                            ),
                          ),
                        ],
                      ),

                      // Recently Viewed Products Grid
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: recentlyViewed.map((product) {
                          bool inStock = product["inStock"] as bool;
                          DateTime viewedAt = DateTime.parse(product["viewedAt"]);
                          String timeAgo = _getTimeAgo(viewedAt);

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
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
                                          topLeft: Radius.circular(radiusMd),
                                          topRight: Radius.circular(radiusMd),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(radiusMd),
                                          topRight: Radius.circular(radiusMd),
                                        ),
                                        child: Image.network(
                                          "${product["image"]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Discount Badge
                                    if ((product["discount"] as int) > 0)
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
                                            "${product["discount"]}% OFF",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Remove Button
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: GestureDetector(
                                        onTap: () => _removeItem(product["id"]),
                                        child: Container(
                                          padding: EdgeInsets.all(spXs),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(220),
                                            shape: BoxShape.circle,
                                            boxShadow: [shadowSm],
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Stock Status
                                    if (!inStock)
                                      Positioned(
                                        bottom: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: disabledBoldColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "Out of Stock",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                // Product Details
                                Container(
                                  padding: EdgeInsets.all(spMd),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spSm,
                                    children: [
                                      // Category and Time
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${product["category"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            timeAgo,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Product Name
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

                                      // Rating and Reviews
                                      Row(
                                        children: [
                                          Row(
                                            spacing: spXs,
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < (product["rating"] as double).floor()
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                size: 12,
                                                color: warningColor,
                                              );
                                            }),
                                          ),
                                          SizedBox(width: spXs),
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

                                      // Price
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
                                    ],
                                  ),
                                ),

                                // Action Buttons
                                Container(
                                  padding: EdgeInsets.all(spMd),
                                  child: Row(
                                    spacing: spSm,
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            //navigateTo('product_detail/${product["id"]}')
                                          },
                                        ),
                                      ),
                                      QButton(
                                        icon: Icons.shopping_cart,
                                        size: bs.sm,
                                        onPressed: inStock
                                            ? () {
                                                //navigateTo('add_to_cart/${product["id"]}')
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      // Quick Actions
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spMd,
                          children: [
                            Text(
                              "Quick Actions",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Continue Shopping",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('shop')
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: QButton(
                                    label: "View Wishlist",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('wishlist')
                                    },
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
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }
}

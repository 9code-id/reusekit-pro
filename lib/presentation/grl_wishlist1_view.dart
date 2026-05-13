import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist1View extends StatefulWidget {
  @override
  State<GrlWishlist1View> createState() => _GrlWishlist1ViewState();
}

class _GrlWishlist1ViewState extends State<GrlWishlist1View> {
  bool loading = false;
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home", "value": "Home"},
    {"label": "Books", "value": "Books"},
  ];

  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "title": "Wireless Headphones",
      "brand": "Sony",
      "price": 299.99,
      "originalPrice": 399.99,
      "discount": 25,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "category": "Electronics",
      "rating": 4.5,
      "reviews": 2842,
      "inStock": true,
      "dateAdded": "2024-12-01",
    },
    {
      "id": 2,
      "title": "Designer Handbag",
      "brand": "Coach",
      "price": 250.00,
      "originalPrice": 320.00,
      "discount": 22,
      "image": "https://picsum.photos/300/300?random=2&keyword=handbag",
      "category": "Fashion",
      "rating": 4.8,
      "reviews": 1543,
      "inStock": false,
      "dateAdded": "2024-11-28",
    },
    {
      "id": 3,
      "title": "Smart Coffee Maker",
      "brand": "Breville",
      "price": 189.99,
      "originalPrice": 229.99,
      "discount": 17,
      "image": "https://picsum.photos/300/300?random=3&keyword=coffee",
      "category": "Home",
      "rating": 4.3,
      "reviews": 987,
      "inStock": true,
      "dateAdded": "2024-12-05",
    },
    {
      "id": 4,
      "title": "Programming Guide",
      "brand": "O'Reilly",
      "price": 45.99,
      "originalPrice": 59.99,
      "discount": 23,
      "image": "https://picsum.photos/300/300?random=4&keyword=book",
      "category": "Books",
      "rating": 4.7,
      "reviews": 2156,
      "inStock": true,
      "dateAdded": "2024-11-15",
    },
    {
      "id": 5,
      "title": "Smartwatch Pro",
      "brand": "Apple",
      "price": 449.99,
      "originalPrice": 499.99,
      "discount": 10,
      "image": "https://picsum.photos/300/300?random=5&keyword=watch",
      "category": "Electronics",
      "rating": 4.9,
      "reviews": 3421,
      "inStock": true,
      "dateAdded": "2024-12-10",
    },
    {
      "id": 6,
      "title": "Winter Jacket",
      "brand": "North Face",
      "price": 179.99,
      "originalPrice": 220.00,
      "discount": 18,
      "image": "https://picsum.photos/300/300?random=6&keyword=jacket",
      "category": "Fashion",
      "rating": 4.4,
      "reviews": 856,
      "inStock": true,
      "dateAdded": "2024-11-22",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return wishlistItems.where((item) {
      bool matchesSearch = "${item["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["brand"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Wishlist shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search wishlist",
                          value: searchQuery,
                          hint: "Search by product or brand",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Stats Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${wishlistItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${(wishlistItems.fold(0.0, (sum, item) => sum + (item["price"] as double))).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${wishlistItems.where((item) => item["inStock"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "In Stock",
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

            // Wishlist Items
            if (filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No items found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredItems.map((item) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (!(item["inStock"] as bool))
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Out of Stock",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "${item["brand"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " (${item["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "\$${(item["price"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${(item["originalPrice"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["discount"]}% OFF",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: QButton(
                                    label: "Add to Cart",
                                    size: bs.sm,
                                    onPressed: (item["inStock"] as bool) ? () {
                                      ss("Added to cart successfully");
                                    } : null,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Remove this item from wishlist?");
                                    if (isConfirmed) {
                                      wishlistItems.removeWhere((i) => i["id"] == item["id"]);
                                      setState(() {});
                                      ss("Item removed from wishlist");
                                    }
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
              }).toList(),
          ],
        ),
      ),
    );
  }
}

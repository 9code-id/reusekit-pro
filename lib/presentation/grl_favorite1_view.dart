import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite1View extends StatefulWidget {
  @override
  State<GrlFavorite1View> createState() => _GrlFavorite1ViewState();
}

class _GrlFavorite1ViewState extends State<GrlFavorite1View> {
  String selectedCategory = "All";
  String sortBy = "name";

  List<Map<String, dynamic>> favoriteProducts = [
    {
      "id": "1",
      "name": "Premium Wireless Headphones",
      "category": "Electronics",
      "price": 299.99,
      "originalPrice": 399.99,
      "rating": 4.8,
      "reviews": 1245,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "brand": "AudioTech",
      "discount": 25,
      "inStock": true,
      "addedDate": "2024-12-15"
    },
    {
      "id": "2",
      "name": "Organic Cotton T-Shirt",
      "category": "Fashion",
      "price": 39.99,
      "originalPrice": 59.99,
      "rating": 4.6,
      "reviews": 892,
      "image": "https://picsum.photos/300/300?random=2&keyword=tshirt",
      "brand": "EcoWear",
      "discount": 33,
      "inStock": true,
      "addedDate": "2024-12-10"
    },
    {
      "id": "3",
      "name": "Smart Home Speaker",
      "category": "Electronics",
      "price": 129.99,
      "originalPrice": 179.99,
      "rating": 4.5,
      "reviews": 2156,
      "image": "https://picsum.photos/300/300?random=3&keyword=speaker",
      "brand": "SmartHome",
      "discount": 28,
      "inStock": false,
      "addedDate": "2024-12-08"
    },
    {
      "id": "4",
      "name": "Professional Camera Lens",
      "category": "Photography",
      "price": 899.99,
      "originalPrice": 1299.99,
      "rating": 4.9,
      "reviews": 567,
      "image": "https://picsum.photos/300/300?random=4&keyword=camera",
      "brand": "LensMaster",
      "discount": 31,
      "inStock": true,
      "addedDate": "2024-12-05"
    },
    {
      "id": "5",
      "name": "Fitness Tracker Watch",
      "category": "Health",
      "price": 199.99,
      "originalPrice": 249.99,
      "rating": 4.4,
      "reviews": 1876,
      "image": "https://picsum.photos/300/300?random=5&keyword=watch",
      "brand": "FitLife",
      "discount": 20,
      "inStock": true,
      "addedDate": "2024-12-01"
    }
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = selectedCategory == "All"
        ? List.from(favoriteProducts)
        : favoriteProducts.where((product) => product["category"] == selectedCategory).toList();

    switch (sortBy) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "discount":
        filtered.sort((a, b) => (b["discount"] as int).compareTo(a["discount"] as int));
        break;
      default:
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
    }

    return filtered;
  }

  List<String> get categories {
    Set<String> categorySet = {"All"};
    for (var product in favoriteProducts) {
      categorySet.add(product["category"] as String);
    }
    return categorySet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteProducts.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Favorite Items",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${favoriteProducts.fold(0.0, (sum, product) => sum + (product["price"] as double)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${favoriteProducts.fold(0.0, (sum, product) => sum + ((product["originalPrice"] as double) - (product["price"] as double))).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Savings",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Name", "value": "name"},
                      {"label": "Price: Low to High", "value": "price_low"},
                      {"label": "Price: High to Low", "value": "price_high"},
                      {"label": "Rating", "value": "rating"},
                      {"label": "Discount", "value": "discount"},
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
            SizedBox(height: spMd),

            // Products Grid
            filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: spXl),
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No favorite products found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Products you favorite will appear here",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Browse Products",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                : ResponsiveGridView(
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
                            // Product Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(radiusLg),
                                  ),
                                  child: Image.network(
                                    "${product["image"]}",
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: GestureDetector(
                                    onTap: () async {
                                      bool isConfirmed = await confirm("Remove this product from favorites?");
                                      if (isConfirmed) {
                                        favoriteProducts.removeWhere((p) => p["id"] == product["id"]);
                                        setState(() {});
                                        ss("Product removed from favorites");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [shadowSm],
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: dangerColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
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
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (!(product["inStock"] as bool))
                                  Positioned(
                                    bottom: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(180),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Out of Stock",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            // Product Details
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["brand"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spSm),
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
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${product["reviews"]})",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${(product["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      if ((product["discount"] as int) > 0)
                                        Text(
                                          "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spMd),
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: (product["inStock"] as bool) ? "Add to Cart" : "Notify Me",
                                      size: bs.sm,
                                      onPressed: () {
                                        if (product["inStock"] as bool) {
                                          ss("Added to cart successfully");
                                        } else {
                                          ss("You'll be notified when back in stock");
                                        }
                                      },
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

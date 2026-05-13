import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome3View extends StatefulWidget {
  @override
  State<GrlHome3View> createState() => _GrlHome3ViewState();
}

class _GrlHome3ViewState extends State<GrlHome3View> {
  String searchQuery = "";
  int currentSlide = 0;
  
  final List<Map<String, dynamic>> bannerSlides = [
    {
      "title": "Summer Sale",
      "subtitle": "Up to 70% off on selected items",
      "image": "https://picsum.photos/400/200?random=1&keyword=sale",
      "buttonText": "Shop Now",
      "color": warningColor,
    },
    {
      "title": "New Arrivals",
      "subtitle": "Discover the latest fashion trends",
      "image": "https://picsum.photos/400/200?random=2&keyword=fashion",
      "buttonText": "Explore",
      "color": primaryColor,
    },
    {
      "title": "Free Shipping",
      "subtitle": "On orders over \$50",
      "image": "https://picsum.photos/400/200?random=3&keyword=shipping",
      "buttonText": "Learn More",
      "color": successColor,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Electronics",
      "icon": Icons.devices,
      "color": infoColor,
      "itemCount": 245,
      "image": "https://picsum.photos/100/100?random=4&keyword=electronics",
    },
    {
      "name": "Fashion",
      "icon": Icons.checkroom,
      "color": primaryColor,
      "itemCount": 567,
      "image": "https://picsum.photos/100/100?random=5&keyword=fashion",
    },
    {
      "name": "Home & Garden",
      "icon": Icons.home,
      "color": successColor,
      "itemCount": 123,
      "image": "https://picsum.photos/100/100?random=6&keyword=home",
    },
    {
      "name": "Sports",
      "icon": Icons.sports_soccer,
      "color": warningColor,
      "itemCount": 89,
      "image": "https://picsum.photos/100/100?random=7&keyword=sports",
    },
    {
      "name": "Books",
      "icon": Icons.menu_book,
      "color": dangerColor,
      "itemCount": 345,
      "image": "https://picsum.photos/100/100?random=8&keyword=books",
    },
    {
      "name": "Health",
      "icon": Icons.health_and_safety,
      "color": infoColor,
      "itemCount": 156,
      "image": "https://picsum.photos/100/100?random=9&keyword=health",
    },
  ];

  final List<Map<String, dynamic>> trendingProducts = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 199.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/150/150?random=10&keyword=headphones",
      "rating": 4.8,
      "reviews": 1245,
      "discount": 20,
      "isFavorite": false,
    },
    {
      "id": 2,
      "name": "Smart Watch",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/150/150?random=11&keyword=watch",
      "rating": 4.9,
      "reviews": 867,
      "discount": 25,
      "isFavorite": true,
    },
    {
      "id": 3,
      "name": "Gaming Laptop",
      "price": 1299.99,
      "originalPrice": 1599.99,
      "image": "https://picsum.photos/150/150?random=12&keyword=laptop",
      "rating": 4.7,
      "reviews": 456,
      "discount": 19,
      "isFavorite": false,
    },
    {
      "id": 4,
      "name": "Bluetooth Speaker",
      "price": 89.99,
      "originalPrice": 119.99,
      "image": "https://picsum.photos/150/150?random=13&keyword=speaker",
      "rating": 4.6,
      "reviews": 789,
      "discount": 25,
      "isFavorite": true,
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Track Order",
      "icon": Icons.local_shipping,
      "color": primaryColor,
    },
    {
      "title": "Customer Service",
      "icon": Icons.headset_mic,
      "color": infoColor,
    },
    {
      "title": "Return Item",
      "icon": Icons.keyboard_return,
      "color": warningColor,
    },
    {
      "title": "Gift Cards",
      "icon": Icons.card_giftcard,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search products, brands...",
                      value: searchQuery,
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
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.tune,
                    color: infoColor,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Banner Slider
            Container(
              height: 200,
              child: QHorizontalScroll(
                children: bannerSlides.map((slide) {
                  return Container(
                    width: MediaQuery.of(context).size.width - (spMd * 2),
                    margin: EdgeInsets.symmetric(horizontal: spMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${slide["image"]}",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withAlpha(100),
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spMd,
                          left: spMd,
                          right: spMd,
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${slide["title"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${slide["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                              QButton(
                                label: "${slide["buttonText"]}",
                                color: slide["color"] as Color,
                                size: bs.sm,
                                onPressed: () {},
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

            // Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: quickActions.map((action) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (action["color"] as Color).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  action["icon"] as IconData,
                                  size: 20,
                                  color: action["color"] as Color,
                                ),
                              ),
                              Text(
                                "${action["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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

            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Shop by Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 110,
                    children: categories.map((category) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${category["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "${category["name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${category["itemCount"]} items",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
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

            // Trending Products
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Row(
                    children: [
                      Text(
                        "Trending Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QHorizontalScroll(
                  children: trendingProducts.map((product) {
                    return Container(
                      width: 180,
                      margin: EdgeInsets.only(
                        left: spMd,
                        right: product == trendingProducts.last ? spMd : 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                child: Image.network(
                                  "${product["image"]}",
                                  width: double.infinity,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
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
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(230),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    (product["isFavorite"] as bool) ? Icons.favorite : Icons.favorite_border,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    Text(
                                      "${(product["rating"] as num).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "(${product["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${((product["price"] as num).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${((product["originalPrice"] as num).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
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

            // Bottom Spacing
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

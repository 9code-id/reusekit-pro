import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsHomeView extends StatefulWidget {
  const EcsHomeView({super.key});

  @override
  State<EcsHomeView> createState() => _EcsHomeViewState();
}

class _EcsHomeViewState extends State<EcsHomeView> {
  String searchQuery = "";
  int selectedCategoryIndex = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.grid_view, "color": Colors.blue},
    {"name": "Electronics", "icon": Icons.devices, "color": Colors.orange},
    {"name": "Fashion", "icon": Icons.checkroom, "color": Colors.pink},
    {"name": "Home", "icon": Icons.home, "color": Colors.green},
    {"name": "Sports", "icon": Icons.sports_soccer, "color": Colors.red},
    {"name": "Books", "icon": Icons.book, "color": Colors.purple},
  ];

  final List<Map<String, dynamic>> banners = [
    {
      "image": "https://picsum.photos/400/200?random=1&keyword=sale",
      "title": "Summer Sale",
      "subtitle": "Up to 70% Off",
      "color": Colors.red,
    },
    {
      "image": "https://picsum.photos/400/200?random=2&keyword=fashion",
      "title": "New Fashion Collection",
      "subtitle": "Latest Trends",
      "color": Colors.purple,
    },
    {
      "image": "https://picsum.photos/400/200?random=3&keyword=electronics",
      "title": "Tech Deals",
      "subtitle": "Best Prices",
      "color": Colors.blue,
    },
  ];

  final List<Map<String, dynamic>> featuredProducts = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 89.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/200/200?random=11&keyword=headphones",
      "rating": 4.5,
      "reviews": 324,
      "discount": 31,
      "badge": "Bestseller",
    },
    {
      "id": 2,
      "name": "Smart Watch",
      "price": 199.99,
      "originalPrice": 299.99,
      "image": "https://picsum.photos/200/200?random=12&keyword=watch",
      "rating": 4.8,
      "reviews": 156,
      "discount": 33,
      "badge": "New",
    },
    {
      "id": 3,
      "name": "Running Shoes",
      "price": 79.99,
      "originalPrice": 120.00,
      "image": "https://picsum.photos/200/200?random=13&keyword=shoes",
      "rating": 4.3,
      "reviews": 89,
      "discount": 33,
      "badge": "Sale",
    },
    {
      "id": 4,
      "name": "Coffee Maker",
      "price": 159.99,
      "originalPrice": 219.99,
      "image": "https://picsum.photos/200/200?random=14&keyword=coffee",
      "rating": 4.6,
      "reviews": 67,
      "discount": 27,
      "badge": "Popular",
    },
  ];

  final List<Map<String, dynamic>> flashSaleProducts = [
    {
      "id": 5,
      "name": "Bluetooth Speaker",
      "price": 29.99,
      "originalPrice": 59.99,
      "image": "https://picsum.photos/150/150?random=21&keyword=speaker",
      "timeLeft": "2h 30m",
      "stock": 5,
      "sold": 43,
    },
    {
      "id": 6,
      "name": "Phone Case",
      "price": 9.99,
      "originalPrice": 19.99,
      "image": "https://picsum.photos/150/150?random=22&keyword=phone",
      "timeLeft": "1h 45m",
      "stock": 12,
      "sold": 78,
    },
    {
      "id": 7,
      "name": "Wireless Charger",
      "price": 19.99,
      "originalPrice": 39.99,
      "image": "https://picsum.photos/150/150?random=23&keyword=charger",
      "timeLeft": "3h 15m",
      "stock": 8,
      "sold": 34,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spMd, spMd, spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusLg),
                  bottomRight: Radius.circular(radiusLg),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                            Text(
                              "John Doe",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Center(
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: spMd),
                              Icon(
                                Icons.search,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search products...",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    searchQuery = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Categories Section
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: List.generate(categories.length, (index) {
                      final category = categories[index];
                      final isSelected = selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          selectedCategoryIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryColor
                                      : (category["color"] as Color).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: isSelected
                                        ? primaryColor
                                        : (category["color"] as Color).withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  category["icon"] as IconData,
                                  color: isSelected ? Colors.white : category["color"] as Color,
                                  size: 28,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${category["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Banner Section
            Container(
              height: 180,
              child: QHorizontalScroll(
                children: List.generate(banners.length, (index) {
                  final banner = banners[index];
                  return Container(
                    width: 320,
                    margin: EdgeInsets.only(left: index == 0 ? spMd : 0, right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Stack(
                        children: [
                          Image.network(
                            "${banner["image"]}",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black.withValues(alpha: 0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${banner["title"]}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${banner["subtitle"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                                SizedBox(height: spMd),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: banner["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Shop Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Flash Sale Section
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Flash Sale",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Ends in 5h 23m",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // ss('Next page'));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: List.generate(flashSaleProducts.length, (index) {
                      final product = flashSaleProducts[index];
                      return Container(
                        width: 140,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                  child: Image.network(
                                    "${product["image"]}",
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${product["timeLeft"]}",
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
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${(product["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${product["stock"]} left",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${product["sold"]} sold",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
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
                    }),
                  ),
                ],
              ),
            ),

            // Featured Products Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Featured Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // ss('Next page'));
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: featuredProducts.map((product) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                  child: Image.network(
                                    "${product["image"]}",
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${product["badge"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
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
                                  SizedBox(height: spXs),
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
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "-${product["discount"]}%",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: "Add to Cart",
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Product added to cart!");
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
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}

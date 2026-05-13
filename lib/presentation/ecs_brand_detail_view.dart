import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsBrandDetailView extends StatefulWidget {
  const EcsBrandDetailView({super.key});

  @override
  State<EcsBrandDetailView> createState() => _EcsBrandDetailViewState();
}

class _EcsBrandDetailViewState extends State<EcsBrandDetailView> {
  bool isFollowing = false;
  String selectedCategory = "All Products";
  
  List<String> productCategories = [
    "All Products",
    "New Arrivals",
    "Best Sellers",
    "On Sale",
    "Smartphones",
    "Laptops",
    "Accessories",
  ];

  Map<String, dynamic> brandInfo = {
    "name": "Apple",
    "logo": "https://picsum.photos/100/100?random=1&keyword=apple",
    "banner": "https://picsum.photos/400/200?random=1&keyword=technology",
    "description": "Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software, and online services.",
    "founded": "1976",
    "headquarters": "Cupertino, California",
    "website": "www.apple.com",
    "rating": 4.8,
    "totalReviews": 12450,
    "followers": 2580000,
    "totalProducts": 156,
    "isVerified": true,
    "categories": ["Electronics", "Computers", "Smartphones", "Accessories"],
    "socialMedia": {
      "facebook": "apple",
      "twitter": "apple",
      "instagram": "apple",
    },
  };

  List<Map<String, dynamic>> featuredProducts = [
    {
      "id": "1",
      "name": "iPhone 15 Pro",
      "image": "https://picsum.photos/300/300?random=10&keyword=phone",
      "price": 999.0,
      "originalPrice": 1099.0,
      "rating": 4.9,
      "reviews": 324,
      "isOnSale": true,
      "badge": "New",
    },
    {
      "id": "2",
      "name": "MacBook Air M2",
      "image": "https://picsum.photos/300/300?random=11&keyword=laptop",
      "price": 1299.0,
      "originalPrice": 1399.0,
      "rating": 4.8,
      "reviews": 567,
      "isOnSale": true,
      "badge": "Sale",
    },
    {
      "id": "3",
      "name": "AirPods Pro",
      "image": "https://picsum.photos/300/300?random=12&keyword=headphones",
      "price": 249.0,
      "originalPrice": 0.0,
      "rating": 4.7,
      "reviews": 892,
      "isOnSale": false,
      "badge": "",
    },
    {
      "id": "4",
      "name": "iPad Pro 12.9",
      "image": "https://picsum.photos/300/300?random=13&keyword=tablet",
      "price": 1099.0,
      "originalPrice": 1199.0,
      "rating": 4.8,
      "reviews": 445,
      "isOnSale": true,
      "badge": "Best Seller",
    },
  ];

  List<Map<String, dynamic>> brandStats = [
    {
      "title": "Products",
      "value": "156",
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Followers",
      "value": "2.5M",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Rating",
      "value": "4.8",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "title": "Reviews",
      "value": "12.4K",
      "icon": Icons.rate_review,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> brandHighlights = [
    {
      "title": "Innovation Leader",
      "description": "Pioneering technology solutions",
      "icon": Icons.lightbulb,
    },
    {
      "title": "Premium Quality", 
      "description": "High-quality materials and design",
      "icon": Icons.diamond,
    },
    {
      "title": "Global Warranty",
      "description": "Worldwide support and service",
      "icon": Icons.public,
    },
    {
      "title": "Eco-Friendly",
      "description": "Sustainable and environment-conscious",
      "icon": Icons.eco,
    },
  ];

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      String message = isFollowing 
          ? "You are now following Apple" 
          : "You unfollowed Apple";
      ss(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Header with Banner
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    "${brandInfo["banner"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(100),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: spMd,
                  child: GestureDetector(
                    onTap: () => back(),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.share,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Brand Info Section
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusMd),
                          child: Image.network(
                            "${brandInfo["logo"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${brandInfo["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (brandInfo["isVerified"])
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 24,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${brandInfo["rating"]} (${brandInfo["totalReviews"]} reviews)",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${brandInfo["followers"]} followers",
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

                  SizedBox(height: spMd),

                  // Follow Button
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isFollowing ? "Following" : "Follow Brand",
                          onPressed: _toggleFollow,
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {
                          // Contact brand
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Brand Description
                  Text(
                    "${brandInfo["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Brand Stats
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: brandStats.map((stat) {
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 24,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${stat["title"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Brand Highlights
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why Choose ${brandInfo["name"]}?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: brandHighlights.map((highlight) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              highlight["icon"],
                              color: primaryColor,
                              size: 32,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${highlight["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${highlight["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
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

            // Product Categories
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shop by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: productCategories.map((category) {
                      bool isSelected = selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          selectedCategory = category;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Featured Products
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // View all products
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
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
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(radiusMd),
                                    ),
                                    child: Image.network(
                                      "${product["image"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (product["badge"].isNotEmpty)
                                  Positioned(
                                    top: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: product["badge"] == "Sale" 
                                            ? dangerColor 
                                            : product["badge"] == "New"
                                                ? successColor
                                                : warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${product["badge"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${product["rating"]} (${product["reviews"]})",
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
                                        "\$${(product["price"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (product["originalPrice"] > 0) ...[
                                        SizedBox(width: spSm),
                                        Text(
                                          "\$${(product["originalPrice"] as double).currency}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: spMd),
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: "View Product",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to product detail
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

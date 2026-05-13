import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo10View extends StatefulWidget {
  @override
  State<GrlPromo10View> createState() => _GrlPromo10ViewState();
}

class _GrlPromo10ViewState extends State<GrlPromo10View> {
  List<Map<String, dynamic>> promoCategories = [
    {"label": "All", "value": "all"},
    {"label": "Food", "value": "food"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Tech", "value": "tech"},
    {"label": "Travel", "value": "travel"},
  ];

  String selectedCategory = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> promoData = [
    {
      "id": 1,
      "title": "Summer Fashion Sale",
      "description": "Get up to 70% off on all summer collection. Limited time offer!",
      "discount": 70,
      "category": "fashion",
      "image": "https://picsum.photos/400/200?random=1&keyword=fashion",
      "brand": "StyleHub",
      "validUntil": "2025-07-15",
      "code": "SUMMER70",
      "originalPrice": 299.99,
      "discountedPrice": 89.99,
      "isExpiring": false,
      "isFeatured": true,
    },
    {
      "id": 2,
      "title": "Tech Gadgets Mega Sale",
      "description": "Latest smartphones, laptops, and accessories at unbeatable prices",
      "discount": 45,
      "category": "tech",
      "image": "https://picsum.photos/400/200?random=2&keyword=technology",
      "brand": "TechWorld",
      "validUntil": "2025-06-30",
      "code": "TECH45",
      "originalPrice": 899.99,
      "discountedPrice": 494.99,
      "isExpiring": true,
      "isFeatured": true,
    },
    {
      "id": 3,
      "title": "Gourmet Food Festival",
      "description": "Delicious meals and premium ingredients with exclusive discounts",
      "discount": 30,
      "category": "food",
      "image": "https://picsum.photos/400/200?random=3&keyword=food",
      "brand": "FoodieHub",
      "validUntil": "2025-07-20",
      "code": "GOURMET30",
      "originalPrice": 159.99,
      "discountedPrice": 111.99,
      "isExpiring": false,
      "isFeatured": false,
    },
    {
      "id": 4,
      "title": "Holiday Travel Deals",
      "description": "Book your dream vacation with massive savings on hotels and flights",
      "discount": 55,
      "category": "travel",
      "image": "https://picsum.photos/400/200?random=4&keyword=travel",
      "brand": "WanderLust",
      "validUntil": "2025-08-01",
      "code": "TRAVEL55",
      "originalPrice": 1299.99,
      "discountedPrice": 584.99,
      "isExpiring": false,
      "isFeatured": true,
    },
    {
      "id": 5,
      "title": "Home Décor Bonanza",
      "description": "Transform your living space with stylish furniture and accessories",
      "discount": 40,
      "category": "fashion",
      "image": "https://picsum.photos/400/200?random=5&keyword=furniture",
      "brand": "HomeStyle",
      "validUntil": "2025-07-10",
      "code": "HOME40",
      "originalPrice": 599.99,
      "discountedPrice": 359.99,
      "isExpiring": true,
      "isFeatured": false,
    },
    {
      "id": 6,
      "title": "Beauty & Wellness Week",
      "description": "Premium skincare, makeup, and wellness products at special prices",
      "discount": 35,
      "category": "fashion",
      "image": "https://picsum.photos/400/200?random=6&keyword=beauty",
      "brand": "GlowUp",
      "validUntil": "2025-06-28",
      "code": "BEAUTY35",
      "originalPrice": 249.99,
      "discountedPrice": 162.49,
      "isExpiring": true,
      "isFeatured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPromos {
    return promoData.where((promo) {
      bool matchesCategory = selectedCategory == "all" || 
          promo["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          "${promo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${promo["brand"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredPromos {
    return promoData.where((promo) => promo["isFeatured"] == true).toList();
  }

  List<Map<String, dynamic>> get expiringPromos {
    return promoData.where((promo) => promo["isExpiring"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exclusive Promotions"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search promotions...",
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
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Filter by Category",
              items: promoCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Featured Promotions Section
            Text(
              "Featured Deals",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: featuredPromos.map((promo) {
                return Container(
                  width: 320,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promo Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${promo["image"]}",
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${promo["discount"]}% OFF",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Promo Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${promo["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${promo["brand"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${promo["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$${((promo["discountedPrice"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${((promo["originalPrice"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Claim Offer",
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

            // Expiring Soon Section
            Text(
              "Expiring Soon",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            QHorizontalScroll(
              children: expiringPromos.map((promo) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: dangerColor.withAlpha(100)),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                color: dangerColor.withAlpha(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${promo["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${promo["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${promo["brand"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Expires: ${promo["validUntil"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Get Code",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // All Promotions
            Text(
              "All Promotions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredPromos.map((promo) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promo Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${promo["image"]}",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: promo["isExpiring"] == true ? dangerColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${promo["discount"]}% OFF",
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
                      ),
                      
                      // Promo Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${promo["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${promo["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$${((promo["discountedPrice"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${((promo["originalPrice"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
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

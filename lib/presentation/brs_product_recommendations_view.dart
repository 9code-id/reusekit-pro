import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsProductRecommendationsView extends StatefulWidget {
  const BrsProductRecommendationsView({super.key});

  @override
  State<BrsProductRecommendationsView> createState() => _BrsProductRecommendationsViewState();
}

class _BrsProductRecommendationsViewState extends State<BrsProductRecommendationsView> {
  String selectedCategory = "All";
  String selectedHairType = "All";
  
  List<String> categories = ["All", "Hair Care", "Beard Care", "Styling", "Tools", "Accessories"];
  List<String> hairTypes = ["All", "Oily", "Dry", "Normal", "Curly", "Straight", "Thick", "Thin"];

  List<Map<String, dynamic>> recommendedProducts = [
    {
      "id": 1,
      "name": "Premium Hair Pomade",
      "brand": "BarberPro",
      "category": "Styling",
      "hairType": ["Normal", "Thick"],
      "description": "High-hold pomade with natural shine for all-day styling",
      "price": 24.99,
      "originalPrice": 29.99,
      "rating": 4.8,
      "reviews": 156,
      "image": "https://picsum.photos/300/300?random=1&keyword=pomade",
      "isRecommended": true,
      "inStock": true,
      "discount": 17,
      "benefits": ["Long-lasting hold", "Natural shine", "Easy to wash out"],
      "suitableFor": "Professional styling and daily use"
    },
    {
      "id": 2,
      "name": "Organic Beard Oil",
      "brand": "NaturalGrooming",
      "category": "Beard Care",
      "hairType": ["All"],
      "description": "Nourishing beard oil with essential oils for healthy growth",
      "price": 18.50,
      "originalPrice": 22.00,
      "rating": 4.9,
      "reviews": 89,
      "image": "https://picsum.photos/300/300?random=2&keyword=beard",
      "isRecommended": true,
      "inStock": true,
      "discount": 16,
      "benefits": ["Moisturizes skin", "Promotes growth", "Reduces itching"],
      "suitableFor": "All beard types and lengths"
    },
    {
      "id": 3,
      "name": "Clarifying Shampoo",
      "brand": "HairEssentials",
      "category": "Hair Care",
      "hairType": ["Oily", "Normal"],
      "description": "Deep cleansing shampoo that removes buildup and excess oil",
      "price": 16.99,
      "originalPrice": 19.99,
      "rating": 4.7,
      "reviews": 234,
      "image": "https://picsum.photos/300/300?random=3&keyword=shampoo",
      "isRecommended": false,
      "inStock": true,
      "discount": 15,
      "benefits": ["Deep cleansing", "Oil control", "Volumizing effect"],
      "suitableFor": "Oily and normal hair types"
    },
    {
      "id": 4,
      "name": "Professional Hair Dryer",
      "brand": "SalonTech",
      "category": "Tools",
      "hairType": ["All"],
      "description": "Ionic hair dryer with multiple heat settings and cool shot",
      "price": 89.99,
      "originalPrice": 129.99,
      "rating": 4.6,
      "reviews": 67,
      "image": "https://picsum.photos/300/300?random=4&keyword=dryer",
      "isRecommended": true,
      "inStock": false,
      "discount": 31,
      "benefits": ["Fast drying", "Reduced frizz", "Multiple settings"],
      "suitableFor": "Professional and home use"
    },
    {
      "id": 5,
      "name": "Moisturizing Conditioner",
      "brand": "HairEssentials",
      "category": "Hair Care",
      "hairType": ["Dry", "Curly"],
      "description": "Rich conditioner that hydrates and detangles dry hair",
      "price": 14.99,
      "originalPrice": 17.99,
      "rating": 4.8,
      "reviews": 178,
      "image": "https://picsum.photos/300/300?random=5&keyword=conditioner",
      "isRecommended": false,
      "inStock": true,
      "discount": 17,
      "benefits": ["Deep hydration", "Detangling", "Softness"],
      "suitableFor": "Dry and damaged hair"
    },
    {
      "id": 6,
      "name": "Precision Trimmer",
      "brand": "CutMaster",
      "category": "Tools",
      "hairType": ["All"],
      "description": "Cordless precision trimmer for detailed grooming",
      "price": 45.00,
      "originalPrice": 55.00,
      "rating": 4.9,
      "reviews": 123,
      "image": "https://picsum.photos/300/300?random=6&keyword=trimmer",
      "isRecommended": true,
      "inStock": true,
      "discount": 18,
      "benefits": ["Precision cutting", "Cordless design", "Long battery life"],
      "suitableFor": "Detail work and touch-ups"
    },
    {
      "id": 7,
      "name": "Styling Wax",
      "brand": "FlexHold",
      "category": "Styling",
      "hairType": ["Thick", "Curly"],
      "description": "Flexible hold wax for textured and natural-looking styles",
      "price": 19.99,
      "originalPrice": 24.99,
      "rating": 4.5,
      "reviews": 98,
      "image": "https://picsum.photos/300/300?random=7&keyword=wax",
      "isRecommended": false,
      "inStock": true,
      "discount": 20,
      "benefits": ["Flexible hold", "Natural texture", "Re-workable"],
      "suitableFor": "Textured and casual styles"
    },
    {
      "id": 8,
      "name": "Luxury Shaving Set",
      "brand": "ClassicShave",
      "category": "Accessories",
      "hairType": ["All"],
      "description": "Complete shaving set with brush, cream, and aftershave",
      "price": 75.00,
      "originalPrice": 95.00,
      "rating": 4.9,
      "reviews": 45,
      "image": "https://picsum.photos/300/300?random=8&keyword=shaving",
      "isRecommended": true,
      "inStock": true,
      "discount": 21,
      "benefits": ["Complete set", "Premium quality", "Perfect gift"],
      "suitableFor": "Traditional wet shaving enthusiasts"
    }
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return recommendedProducts.where((product) {
      bool categoryMatch = selectedCategory == "All" || product["category"] == selectedCategory;
      bool hairTypeMatch = selectedHairType == "All" || (product["hairType"] as List).contains(selectedHairType);
      return categoryMatch && hairTypeMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get recommendedForYou {
    return filteredProducts.where((product) => product["isRecommended"] as bool).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              ss("Opening product search...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personalized for You",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Curated products based on your preferences and history",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),

            // Filters Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Products",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Category Filter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QHorizontalScroll(
                        children: categories.map((category) {
                          bool isSelected = selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              selectedCategory = category;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Hair Type Filter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hair Type",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QHorizontalScroll(
                        children: hairTypes.map((hairType) {
                          bool isSelected = selectedHairType == hairType;
                          return GestureDetector(
                            onTap: () {
                              selectedHairType = hairType;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? successColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: isSelected ? successColor : disabledBoldColor,
                                ),
                              ),
                              child: Text(
                                hairType,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recommended For You Section
            if (recommendedForYou.isNotEmpty)
              Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Recommended for You",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: recommendedForYou.take(3).map((product) {
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(right: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                          border: Border.all(color: warningColor.withAlpha(100), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                  ),
                                  child: Image.network(
                                    "${product["image"]}",
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "RECOMMENDED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                if ((product["discount"] as int) > 0)
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
                                        "${product["discount"]}% OFF",
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
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                spacing: spSm,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${product["brand"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${((product["originalPrice"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "\$${((product["price"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  QButton(
                                    label: "Add to Cart",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("${product["name"]} added to cart!");
                                    },
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

            // All Products Section
            Text(
              "All Products (${filteredProducts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Products Grid
            ResponsiveGridView(
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${product["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (product["isRecommended"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "RECOMMENDED",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if ((product["discount"] as int) > 0)
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
                                  "${product["discount"]}% OFF",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (!(product["inStock"] as bool))
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "OUT OF STOCK",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Product Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
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
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "(${product["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((product["discount"] as int) > 0)
                              Row(
                                children: [
                                  Text(
                                    "\$${((product["originalPrice"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "\$${((product["price"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                "\$${((product["price"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),

                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: (product["inStock"] as bool) ? "Add to Cart" : "Out of Stock",
                                size: bs.sm,
                                onPressed: (product["inStock"] as bool) ? () {
                                  ss("${product["name"]} added to cart!");
                                } : null,
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

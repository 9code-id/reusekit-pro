import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRecommendationsView extends StatefulWidget {
  const EcsRecommendationsView({super.key});

  @override
  State<EcsRecommendationsView> createState() => _EcsRecommendationsViewState();
}

class _EcsRecommendationsViewState extends State<EcsRecommendationsView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "For You", "value": "For You"},
    {"label": "Similar Items", "value": "Similar Items"},
    {"label": "Trending", "value": "Trending"},
    {"label": "New Arrivals", "value": "New Arrivals"},
  ];

  List<Map<String, dynamic>> recommendedProducts = [
    {
      "id": "1",
      "name": "Premium Wireless Earbuds",
      "price": 79.99,
      "originalPrice": 99.99,
      "image": "https://picsum.photos/300/300?random=11&keyword=earbuds",
      "category": "Electronics",
      "rating": 4.6,
      "reviews": 234,
      "recommendationType": "For You",
      "reason": "Based on your recent purchases",
      "inStock": true,
      "discount": 20,
      "tags": ["bestseller", "wireless"],
    },
    {
      "id": "2",
      "name": "Smart Fitness Tracker",
      "price": 129.99,
      "originalPrice": 159.99,
      "image": "https://picsum.photos/300/300?random=12&keyword=fitness",
      "category": "Health & Fitness",
      "rating": 4.4,
      "reviews": 189,
      "recommendationType": "Trending",
      "reason": "Popular among your interests",
      "inStock": true,
      "discount": 19,
      "tags": ["trending", "health"],
    },
    {
      "id": "3",
      "name": "Organic Skincare Set",
      "price": 45.99,
      "originalPrice": 65.99,
      "image": "https://picsum.photos/300/300?random=13&keyword=skincare",
      "category": "Beauty",
      "rating": 4.7,
      "reviews": 167,
      "recommendationType": "Similar Items",
      "reason": "Similar to items you viewed",
      "inStock": true,
      "discount": 30,
      "tags": ["organic", "bestseller"],
    },
    {
      "id": "4",
      "name": "Minimalist Desk Organizer",
      "price": 34.99,
      "originalPrice": 49.99,
      "image": "https://picsum.photos/300/300?random=14&keyword=desk",
      "category": "Home & Office",
      "rating": 4.3,
      "reviews": 98,
      "recommendationType": "For You",
      "reason": "Matches your style preferences",
      "inStock": true,
      "discount": 30,
      "tags": ["minimalist", "office"],
    },
    {
      "id": "5",
      "name": "Sustainable Water Bottle",
      "price": 24.99,
      "originalPrice": 34.99,
      "image": "https://picsum.photos/300/300?random=15&keyword=bottle",
      "category": "Sports & Outdoors",
      "rating": 4.5,
      "reviews": 145,
      "recommendationType": "New Arrivals",
      "reason": "New eco-friendly option",
      "inStock": true,
      "discount": 29,
      "tags": ["eco-friendly", "new"],
    },
    {
      "id": "6",
      "name": "Bluetooth Speaker Pro",
      "price": 89.99,
      "originalPrice": 119.99,
      "image": "https://picsum.photos/300/300?random=16&keyword=speaker",
      "category": "Electronics",
      "rating": 4.6,
      "reviews": 203,
      "recommendationType": "Similar Items",
      "reason": "Similar to your recent audio purchases",
      "inStock": false,
      "discount": 25,
      "tags": ["audio", "portable"],
    },
  ];

  List<Map<String, dynamic>> personalizedSections = [
    {
      "title": "Because You Bought Electronics",
      "subtitle": "Recommended accessories and related items",
      "icon": Icons.devices,
      "color": primaryColor,
      "count": 12,
    },
    {
      "title": "Complete Your Look",
      "subtitle": "Perfect matches for your style",
      "icon": Icons.style,
      "color": successColor,
      "count": 8,
    },
    {
      "title": "Customers Who Bought This Also Bought",
      "subtitle": "Popular combinations",
      "icon": Icons.people,
      "color": infoColor,
      "count": 15,
    },
    {
      "title": "Back in Stock",
      "subtitle": "Items from your wishlist are now available",
      "icon": Icons.inventory,
      "color": warningColor,
      "count": 5,
    },
  ];

  List<Map<String, dynamic>> getFilteredProducts() {
    if (selectedCategory == "All") {
      return recommendedProducts;
    }
    return recommendedProducts.where((product) => 
        product["recommendationType"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = getFilteredProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
        actions: [
          QButton(
            icon: Icons.tune,
            size: bs.sm,
            onPressed: () {
              //navigateTo('recommendation_preferences')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.recommend,
                    size: 32,
                    color: primaryColor,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Personalized for You",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Discover products tailored to your preferences and shopping history",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            QCategoryPicker(
              label: "Filter Recommendations",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Personalized Sections
            if (selectedCategory == "All") ...[
              Text(
                "Recommendation Categories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: personalizedSections.map((section) {
                  return GestureDetector(
                    onTap: () {
                      //navigateTo('recommendation_section/${section["title"]}')
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (section["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  section["icon"] as IconData,
                                  size: 24,
                                  color: section["color"] as Color,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (section["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${section["count"]} items",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: section["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${section["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${section["subtitle"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "View All",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('recommendation_section/${section["title"]}')
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Recommended Products
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        selectedCategory == "All" 
                            ? "Featured Recommendations" 
                            : "$selectedCategory Recommendations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredProducts.length} products found",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('all_recommendations')
                  },
                ),
              ],
            ),

            if (filteredProducts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Recommendations Found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try selecting a different category or browse our catalog",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredProducts.map((product) {
                  bool inStock = product["inStock"] as bool;
                  List<String> tags = (product["tags"] as List).cast<String>();

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
                            // Recommendation Badge
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${product["recommendationType"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                              // Category and Tags
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
                                  if (tags.isNotEmpty) ...[
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
                                        tags.first.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                  ],
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

                              // Recommendation Reason
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb,
                                      size: 14,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${product["reason"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: infoColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                              QButton(
                                icon: Icons.favorite_border,
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('add_to_wishlist/${product["id"]}')
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

            // More Actions
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
                    "Improve Your Recommendations",
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
                          label: "Rate Products",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('rate_products')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Preferences",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('recommendation_preferences')
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
}

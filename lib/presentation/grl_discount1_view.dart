import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount1View extends StatefulWidget {
  @override
  State<GrlDiscount1View> createState() => _GrlDiscount1ViewState();
}

class _GrlDiscount1ViewState extends State<GrlDiscount1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Food", "value": "Food"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Beauty", "value": "Beauty"},
  ];

  List<Map<String, dynamic>> discounts = [
    {
      "id": 1,
      "title": "50% Off Summer Collection",
      "description": "Get amazing discounts on summer fashion items",
      "discount": 50,
      "code": "SUMMER50",
      "category": "Fashion",
      "image": "https://picsum.photos/300/200?random=1&keyword=fashion",
      "expiryDate": "2024-07-31",
      "brand": "FashionHub",
      "originalPrice": 199.99,
      "discountedPrice": 99.99,
      "isFeatured": true,
    },
    {
      "id": 2,
      "title": "Buy 2 Get 1 Free",
      "description": "Purchase any 2 items and get the 3rd one absolutely free",
      "discount": 33,
      "code": "BUY2GET1",
      "category": "Food",
      "image": "https://picsum.photos/300/200?random=2&keyword=food",
      "expiryDate": "2024-08-15",
      "brand": "FoodMart",
      "originalPrice": 89.97,
      "discountedPrice": 59.98,
      "isFeatured": false,
    },
    {
      "id": 3,
      "title": "Electronics Flash Sale",
      "description": "Limited time offer on latest gadgets and electronics",
      "discount": 40,
      "code": "TECH40",
      "category": "Electronics",
      "image": "https://picsum.photos/300/200?random=3&keyword=electronics",
      "expiryDate": "2024-07-25",
      "brand": "TechWorld",
      "originalPrice": 299.99,
      "discountedPrice": 179.99,
      "isFeatured": true,
    },
    {
      "id": 4,
      "title": "Beauty Bundle Deals",
      "description": "Complete your beauty routine with our special bundle offers",
      "discount": 25,
      "code": "BEAUTY25",
      "category": "Beauty",
      "image": "https://picsum.photos/300/200?random=4&keyword=beauty",
      "expiryDate": "2024-08-10",
      "brand": "BeautyPlus",
      "originalPrice": 149.99,
      "discountedPrice": 112.49,
      "isFeatured": false,
    },
    {
      "id": 5,
      "title": "Weekend Special",
      "description": "Exclusive weekend discounts on selected items",
      "discount": 30,
      "code": "WEEKEND30",
      "category": "All",
      "image": "https://picsum.photos/300/200?random=5&keyword=shopping",
      "expiryDate": "2024-07-28",
      "brand": "ShopMart",
      "originalPrice": 79.99,
      "discountedPrice": 55.99,
      "isFeatured": true,
    },
  ];

  List<Map<String, dynamic>> get filteredDiscounts {
    return discounts.where((discount) {
      bool matchesSearch = "${discount["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${discount["brand"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || discount["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discounts & Offers"),
        actions: [
          Icon(Icons.favorite_border, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.notifications_none, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search discounts...",
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
            
            SizedBox(height: spMd),
            
            // Category Filter
            QCategoryPicker(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Featured Discounts Section
            Text(
              "Featured Offers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: filteredDiscounts.where((d) => d["isFeatured"] == true).map((discount) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${discount["image"]}",
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
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
                                "${discount["discount"]}% OFF",
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
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${discount["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${discount["brand"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "\$${((discount["originalPrice"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${((discount["discountedPrice"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${discount["code"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${discount["expiryDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // All Discounts Section
            Row(
              children: [
                Text(
                  "All Discounts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredDiscounts.length} offers",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Discount List
            Column(
              children: filteredDiscounts.map((discount) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${discount["image"]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${discount["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${discount["discount"]}%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${discount["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "\$${((discount["discountedPrice"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "\$${((discount["originalPrice"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "Get Deal",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
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

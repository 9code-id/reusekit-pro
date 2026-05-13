import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo7View extends StatefulWidget {
  @override
  State<GrlPromo7View> createState() => _GrlPromo7ViewState();
}

class _GrlPromo7ViewState extends State<GrlPromo7View> {
  int selectedIndex = 0;
  
  List<Map<String, dynamic>> promoTypes = [
    {
      "title": "Bundle Deals",
      "description": "Buy more, save more with combo offers",
      "icon": Icons.shopping_basket,
      "color": Color(0xFF4CAF50),
      "deals": [
        {
          "id": "1",
          "title": "Tech Bundle Supreme",
          "description": "Smartphone + Wireless Earbuds + Power Bank",
          "originalPrice": 899.99,
          "bundlePrice": 599.99,
          "savings": 300.0,
          "discountPercent": 33,
          "items": [
            {
              "name": "iPhone 15 Pro",
              "price": 699.99,
              "image": "https://picsum.photos/80/80?random=1&keyword=iphone",
            },
            {
              "name": "AirPods Pro",
              "price": 149.99,
              "image": "https://picsum.photos/80/80?random=2&keyword=airpods",
            },
            {
              "name": "MagSafe Power Bank",
              "price": 50.01,
              "image": "https://picsum.photos/80/80?random=3&keyword=powerbank",
            },
          ],
          "validUntil": "2024-12-31",
          "limitedStock": 45,
          "totalStock": 100,
          "rating": 4.8,
          "isPopular": true,
        },
        {
          "id": "2",
          "title": "Home Office Essentials",
          "description": "Desk + Chair + Lamp + Organizer Set",
          "originalPrice": 549.99,
          "bundlePrice": 379.99,
          "savings": 170.0,
          "discountPercent": 31,
          "items": [
            {
              "name": "Standing Desk",
              "price": 299.99,
              "image": "https://picsum.photos/80/80?random=4&keyword=desk",
            },
            {
              "name": "Ergonomic Chair",
              "price": 199.99,
              "image": "https://picsum.photos/80/80?random=5&keyword=chair",
            },
            {
              "name": "LED Desk Lamp",
              "price": 50.01,
              "image": "https://picsum.photos/80/80?random=6&keyword=lamp",
            },
          ],
          "validUntil": "2025-01-15",
          "limitedStock": 23,
          "totalStock": 80,
          "rating": 4.6,
          "isPopular": false,
        },
      ],
    },
    {
      "title": "Buy 1 Get 1",
      "description": "Double the value with BOGO offers",
      "icon": Icons.add_circle_outline,
      "color": Color(0xFFE91E63),
      "deals": [
        {
          "id": "3",
          "title": "Fashion BOGO Bonanza",
          "description": "Buy any shirt, get another shirt free",
          "category": "Fashion",
          "image": "https://picsum.photos/300/200?random=7&keyword=shirts",
          "originalPrice": 89.99,
          "offerPrice": 89.99,
          "freeItem": "Second shirt (equal or lesser value)",
          "validUntil": "2024-12-28",
          "availableItems": 156,
          "minPrice": 29.99,
          "maxPrice": 89.99,
          "brands": ["StyleHub", "FashionPlace", "TrendyWear"],
          "rating": 4.4,
        },
        {
          "id": "4",
          "title": "Beauty Products BOGO",
          "description": "Buy skincare, get makeup free",
          "category": "Beauty",
          "image": "https://picsum.photos/300/200?random=8&keyword=beauty",
          "originalPrice": 75.99,
          "offerPrice": 75.99,
          "freeItem": "Free makeup set worth \$45",
          "validUntil": "2025-01-10",
          "availableItems": 89,
          "minPrice": 25.99,
          "maxPrice": 125.99,
          "brands": ["GlowSkin", "BeautyFirst", "LuxeCosmetics"],
          "rating": 4.7,
        },
      ],
    },
    {
      "title": "Cashback Offers",
      "description": "Get money back on every purchase",
      "icon": Icons.account_balance_wallet,
      "color": Color(0xFF2196F3),
      "deals": [
        {
          "id": "5",
          "title": "Electronics Cashback",
          "description": "Up to 15% cashback on electronics",
          "category": "Electronics",
          "image": "https://picsum.photos/300/200?random=9&keyword=electronics",
          "cashbackPercent": 15,
          "minPurchase": 100.0,
          "maxCashback": 200.0,
          "validUntil": "2024-12-30",
          "eligibleBrands": ["TechZone", "ElectroWorld", "GadgetHub"],
          "paymentMethods": ["Credit Card", "Digital Wallet", "Bank Transfer"],
          "cashbackCredit": "Within 7 business days",
          "rating": 4.5,
        },
        {
          "id": "6",
          "title": "Grocery Cashback Bonanza",
          "description": "10% cashback on all grocery items",
          "category": "Grocery",
          "image": "https://picsum.photos/300/200?random=10&keyword=grocery",
          "cashbackPercent": 10,
          "minPurchase": 50.0,
          "maxCashback": 75.0,
          "validUntil": "2025-01-05",
          "eligibleBrands": ["FreshMart", "GroceryPlus", "OrganicStore"],
          "paymentMethods": ["All payment methods"],
          "cashbackCredit": "Instant to wallet",
          "rating": 4.3,
        },
      ],
    },
    {
      "title": "Free Shipping",
      "description": "No delivery charges on eligible orders",
      "icon": Icons.local_shipping,
      "color": Color(0xFFFF9800),
      "deals": [
        {
          "id": "7",
          "title": "Free Shipping Weekend",
          "description": "Free delivery on all orders above \$25",
          "image": "https://picsum.photos/300/200?random=11&keyword=delivery",
          "minOrderValue": 25.0,
          "normalShippingFee": 8.99,
          "deliveryTime": "2-3 business days",
          "availableAreas": "All major cities",
          "validUntil": "2024-12-29",
          "eligibleCategories": ["All categories"],
          "excludedItems": ["Oversized furniture", "Hazardous materials"],
          "rating": 4.6,
        },
        {
          "id": "8",
          "title": "Premium Free Shipping",
          "description": "Same day delivery for premium members",
          "image": "https://picsum.photos/300/200?random=12&keyword=express",
          "minOrderValue": 0.0,
          "normalShippingFee": 15.99,
          "deliveryTime": "Same day delivery",
          "availableAreas": "Metro cities only",
          "validUntil": "2025-01-31",
          "eligibleCategories": ["Electronics", "Fashion", "Books"],
          "membershipRequired": true,
          "rating": 4.8,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var currentPromoType = promoTypes[selectedIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Promo Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: spMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: promoTypes.length,
              itemBuilder: (context, index) {
                var promoType = promoTypes[index];
                bool isSelected = selectedIndex == index;
                
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (promoType["color"] as Color) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: isSelected ? [shadowMd] : [shadowSm],
                        border: Border.all(
                          color: isSelected ? (promoType["color"] as Color) : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            promoType["icon"] as IconData,
                            color: isSelected ? Colors.white : (promoType["color"] as Color),
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${promoType["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${promoType["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white.withAlpha(180) : disabledBoldColor,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        currentPromoType["icon"] as IconData,
                        color: currentPromoType["color"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${currentPromoType["title"]} Deals",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Bundle Deals
                  if (selectedIndex == 0) ...[
                    ...(currentPromoType["deals"] as List).map((deal) {
                      double stockPercentage = ((deal["limitedStock"] as int) / (deal["totalStock"] as int)) * 100;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${deal["title"]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (deal["isPopular"] as bool) ...[
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(radiusSm),
                                                ),
                                                child: Text(
                                                  "Popular",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${deal["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "${deal["discountPercent"]}% OFF",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Bundle Items
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd),
                              child: Column(
                                children: [
                                  Row(
                                    children: (deal["items"] as List).asMap().entries.map((entry) {
                                      int index = entry.key;
                                      var item = entry.value;
                                      bool isLast = index == (deal["items"] as List).length - 1;
                                      
                                      return Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(radiusLg),
                                                    child: Image.network(
                                                      "${item["image"]}",
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(height: spSm),
                                                  Text(
                                                    "${item["name"]}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: primaryColor,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "\$${((item["price"] as double)).currency}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                      decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (!isLast) ...[
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: spXs),
                                                child: Icon(
                                                  Icons.add,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Pricing
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusLg),
                                  bottomRight: Radius.circular(radiusLg),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bundle Price",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${((deal["originalPrice"] as double)).currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Text(
                                                "\$${((deal["bundlePrice"] as double)).currency}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: successColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "You save \$${((deal["savings"] as double)).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${deal["rating"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Valid until ${deal["validUntil"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Stock Progress
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Limited Stock: ${deal["limitedStock"]} left",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "${(100 - stockPercentage).toInt()}% remaining",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      LinearProgressIndicator(
                                        value: stockPercentage / 100,
                                        backgroundColor: Colors.grey[300],
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          stockPercentage > 80 ? dangerColor : 
                                          stockPercentage > 60 ? warningColor : successColor,
                                        ),
                                        minHeight: 6,
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Action Button
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: "Add Bundle to Cart",
                                      size: bs.md,
                                      onPressed: () {
                                        ss("Bundle added to cart!");
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
                  ],
                  
                  // BOGO Deals
                  if (selectedIndex == 1) ...[
                    ...(currentPromoType["deals"] as List).map((deal) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${deal["image"]}",
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spMd,
                                    left: spMd,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Text(
                                        "BUY 1 GET 1",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Content
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${deal["title"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${deal["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                  
                                  // Offer Details
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      border: Border.all(
                                        color: dangerColor.withAlpha(100),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_offer,
                                              color: dangerColor,
                                              size: 20,
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "Special Offer",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Text(
                                          "Free Item: ${deal["freeItem"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: dangerColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "Price Range: \$${((deal["minPrice"] as double)).currency} - \$${((deal["maxPrice"] as double)).currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Available Items: ${deal["availableItems"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Brands
                                  Text(
                                    "Available Brands:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Wrap(
                                    spacing: spSm,
                                    runSpacing: spSm,
                                    children: (deal["brands"] as List).map((brand) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "$brand",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Bottom Info and Action
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${deal["rating"]} Rating",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Valid until ${deal["validUntil"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      QButton(
                                        label: "Shop Now",
                                        size: bs.md,
                                        onPressed: () {
                                          ss("Opening BOGO deal...");
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
                  
                  // Cashback Deals
                  if (selectedIndex == 2) ...[
                    ...(currentPromoType["deals"] as List).map((deal) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image with Cashback Badge
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${deal["image"]}",
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spMd,
                                    right: spMd,
                                    child: Container(
                                      padding: EdgeInsets.all(spMd),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${deal["cashbackPercent"]}%",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "CASHBACK",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Content
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${deal["title"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${deal["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Cashback Details
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      border: Border.all(
                                        color: successColor.withAlpha(100),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Min. Purchase",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${((deal["minPurchase"] as double)).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Max. Cashback",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${((deal["maxCashback"] as double)).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Credit Time",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${deal["cashbackCredit"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Eligible Brands
                                  Text(
                                    "Eligible Brands:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Wrap(
                                    spacing: spSm,
                                    runSpacing: spSm,
                                    children: (deal["eligibleBrands"] as List).map((brand) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "$brand",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Payment Methods
                                  Text(
                                    "Payment Methods:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    (deal["paymentMethods"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Bottom Info and Action
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${deal["rating"]} Rating",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Valid until ${deal["validUntil"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      QButton(
                                        label: "Start Shopping",
                                        size: bs.md,
                                        onPressed: () {
                                          ss("Starting cashback shopping...");
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
                  
                  // Free Shipping Deals
                  if (selectedIndex == 3) ...[
                    ...(currentPromoType["deals"] as List).map((deal) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${deal["image"]}",
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spMd,
                                    left: spMd,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.local_shipping,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "FREE SHIPPING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Content
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${deal["title"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${deal["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Shipping Details
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      border: Border.all(
                                        color: Colors.orange.withAlpha(100),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        if ((deal["minOrderValue"] as double) > 0) ...[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Min. Order Value",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "\$${((deal["minOrderValue"] as double)).currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spSm),
                                        ],
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Normal Shipping",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${((deal["normalShippingFee"] as double)).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: dangerColor,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery Time",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${deal["deliveryTime"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Available Areas",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${deal["availableAreas"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Eligible Categories
                                  Text(
                                    "Eligible Categories:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    (deal["eligibleCategories"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  if (deal["excludedItems"] != null) ...[
                                    SizedBox(height: spSm),
                                    Text(
                                      "Excluded Items: ${(deal["excludedItems"] as List).join(", ")}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                  
                                  if (deal["membershipRequired"] != null && deal["membershipRequired"] as bool) ...[
                                    SizedBox(height: spSm),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: infoColor,
                                            size: 16,
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "Premium membership required",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: infoColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Bottom Info and Action
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${deal["rating"]} Rating",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Valid until ${deal["validUntil"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      QButton(
                                        label: "Shop Now",
                                        size: bs.md,
                                        onPressed: () {
                                          ss("Starting free shipping shopping...");
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

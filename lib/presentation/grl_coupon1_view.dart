import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon1View extends StatefulWidget {
  @override
  State<GrlCoupon1View> createState() => _GrlCoupon1ViewState();
}

class _GrlCoupon1ViewState extends State<GrlCoupon1View> {
  String selectedCategory = 'all';
  
  List<Map<String, dynamic>> coupons = [
    {
      "id": "CPN001",
      "title": "Summer Sale",
      "description": "Get 30% off on all summer collection items",
      "discountType": "percentage",
      "discountValue": 30,
      "minPurchase": 50.0,
      "category": "fashion",
      "brand": "Fashion Store",
      "validUntil": "2024-07-31",
      "usageLimit": 100,
      "usageCount": 45,
      "terms": "Valid on summer collection only. Cannot be combined with other offers.",
      "featured": true,
      "color": 0xFFFF6B6B,
    },
    {
      "id": "CPN002", 
      "title": "Free Delivery",
      "description": "Free shipping on orders above \$25",
      "discountType": "free_shipping",
      "discountValue": 0,
      "minPurchase": 25.0,
      "category": "food",
      "brand": "Food Express",
      "validUntil": "2024-02-15",
      "usageLimit": 500,
      "usageCount": 234,
      "terms": "Valid for online orders only. Not applicable on weekend deliveries.",
      "featured": false,
      "color": 0xFF4ECDC4,
    },
    {
      "id": "CPN003",
      "title": "Tech Tuesday",
      "description": "Buy 2 Get 1 Free on selected electronics",
      "discountType": "buy_x_get_y",
      "discountValue": 1,
      "minPurchase": 0.0,
      "category": "electronics",
      "brand": "Tech World",
      "validUntil": "2024-02-06",
      "usageLimit": 50,
      "usageCount": 12,
      "terms": "Applicable on selected items only. Lowest priced item will be free.",
      "featured": true,
      "color": 0xFF45B7D1,
    },
    {
      "id": "CPN004",
      "title": "Health & Wellness",
      "description": "\$15 off on health and beauty products",
      "discountType": "fixed_amount",
      "discountValue": 15,
      "minPurchase": 40.0,
      "category": "health",
      "brand": "Wellness Plus",
      "validUntil": "2024-03-01",
      "usageLimit": 200,
      "usageCount": 89,
      "terms": "Valid on health and beauty category. One coupon per customer.",
      "featured": false,
      "color": 0xFF96CEB4,
    },
    {
      "id": "CPN005",
      "title": "Entertainment Bundle",
      "description": "50% off on movie tickets and snacks combo",
      "discountType": "percentage",
      "discountValue": 50,
      "minPurchase": 20.0,
      "category": "entertainment",
      "brand": "CineMax",
      "validUntil": "2024-01-31",
      "usageLimit": 75,
      "usageCount": 68,
      "terms": "Valid for combo purchases only. Not valid on premium shows.",
      "featured": true,
      "color": 0xFFFECA57,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Coupons"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // navigateTo(QRScannerView());
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo(CouponHistoryView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Savings Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.savings,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Your Savings Dashboard",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${coupons.length}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$247",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Saved",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${coupons.where((c) => c["featured"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Featured",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: [
                'all', 'fashion', 'food', 'electronics', 'health', 'entertainment', 'travel'
              ].map((category) => GestureDetector(
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
                    color: selectedCategory == category ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedCategory == category ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: selectedCategory == category ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Coupons List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Section
                  if (coupons.any((c) => c["featured"] as bool)) ...[
                    Text(
                      "Featured Deals",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    ...coupons.where((coupon) {
                      bool categoryMatch = selectedCategory == 'all' || coupon["category"] == selectedCategory;
                      return categoryMatch && (coupon["featured"] as bool);
                    }).map((coupon) => _buildCouponCard(coupon, true)),
                    
                    SizedBox(height: spMd),
                  ],
                  
                  Text(
                    "All Coupons",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Regular Coupons
                  ...coupons.where((coupon) {
                    if (selectedCategory != 'all' && coupon["category"] != selectedCategory) return false;
                    return true;
                  }).map((coupon) => _buildCouponCard(coupon, false)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, bool isFeatured) {
    Color couponColor = Color(coupon["color"] as int);
    double usagePercentage = (coupon["usageCount"] as int) / (coupon["usageLimit"] as int);
    bool isExpiringSoon = _isExpiringSoon(coupon["validUntil"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: isFeatured ? [shadowLg] : [shadowMd],
        border: isFeatured ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        children: [
          // Coupon Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: couponColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: couponColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    _getCategoryIcon(coupon["category"]),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${coupon["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (isFeatured) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "FEATURED",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "${coupon["brand"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isExpiringSoon)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "EXPIRING SOON",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    SizedBox(height: spXs),
                    Text(
                      "${coupon["id"]}",
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
          
          // Coupon Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount Display
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: couponColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _getDiscountDisplay(coupon),
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: couponColor,
                            ),
                          ),
                          Text(
                            _getDiscountType(coupon["discountType"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: couponColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${coupon["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          if (coupon["minPurchase"] > 0) ...[
                            Text(
                              "Min. purchase: \$${(coupon["minPurchase"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Usage Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Usage",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${coupon["usageCount"]}/${coupon["usageLimit"]} used",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: usagePercentage.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: usagePercentage > 0.8 ? dangerColor : couponColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Validity and Terms
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Valid until ${coupon["validUntil"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isExpiringSoon ? dangerColor : Colors.black,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Terms
                Text(
                  "${coupon["terms"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Use Coupon",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo(UseCouponView());
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'fashion':
        return Icons.checkroom;
      case 'food':
        return Icons.restaurant;
      case 'electronics':
        return Icons.devices;
      case 'health':
        return Icons.medical_services;
      case 'entertainment':
        return Icons.movie;
      case 'travel':
        return Icons.flight;
      default:
        return Icons.local_offer;
    }
  }

  String _getDiscountDisplay(Map<String, dynamic> coupon) {
    String type = coupon["discountType"];
    int value = coupon["discountValue"] as int;
    
    switch (type) {
      case 'percentage':
        return "${value}%";
      case 'fixed_amount':
        return "\$${value}";
      case 'buy_x_get_y':
        return "BUY 2\nGET ${value}";
      case 'free_shipping':
        return "FREE\nSHIP";
      default:
        return "${value}%";
    }
  }

  String _getDiscountType(String type) {
    switch (type) {
      case 'percentage':
        return "OFF";
      case 'fixed_amount':
        return "OFF";
      case 'buy_x_get_y':
        return "FREE";
      case 'free_shipping':
        return "SHIPPING";
      default:
        return "OFF";
    }
  }

  bool _isExpiringSoon(String validUntil) {
    DateTime expiry = DateTime.parse(validUntil);
    DateTime now = DateTime.now();
    return expiry.difference(now).inDays <= 7;
  }
}

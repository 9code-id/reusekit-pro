import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon2View extends StatefulWidget {
  @override
  State<GrlCoupon2View> createState() => _GrlCoupon2ViewState();
}

class _GrlCoupon2ViewState extends State<GrlCoupon2View> {
  String selectedTab = 'active';
  
  List<Map<String, dynamic>> userCoupons = [
    {
      "id": "UC001",
      "couponId": "CPN001",
      "title": "Summer Sale",
      "description": "30% off on summer collection",
      "discountType": "percentage",
      "discountValue": 30,
      "brand": "Fashion Store",
      "status": "active",
      "acquiredDate": "2024-01-15",
      "validUntil": "2024-07-31",
      "usedDate": null,
      "orderNumber": null,
      "savedAmount": null,
      "category": "fashion",
      "color": 0xFFFF6B6B,
    },
    {
      "id": "UC002",
      "couponId": "CPN002",
      "title": "Free Delivery",
      "description": "Free shipping on orders above \$25",
      "discountType": "free_shipping",
      "discountValue": 0,
      "brand": "Food Express",
      "status": "used",
      "acquiredDate": "2024-01-10",
      "validUntil": "2024-02-15",
      "usedDate": "2024-01-20",
      "orderNumber": "ORD-2024-001",
      "savedAmount": 8.99,
      "category": "food",
      "color": 0xFF4ECDC4,
    },
    {
      "id": "UC003",
      "couponId": "CPN003",
      "title": "Tech Tuesday",
      "description": "Buy 2 Get 1 Free on electronics",
      "discountType": "buy_x_get_y",
      "discountValue": 1,
      "brand": "Tech World",
      "status": "expired",
      "acquiredDate": "2024-01-05",
      "validUntil": "2024-01-25",
      "usedDate": null,
      "orderNumber": null,
      "savedAmount": null,
      "category": "electronics",
      "color": 0xFF45B7D1,
    },
    {
      "id": "UC004",
      "couponId": "CPN004",
      "title": "Health & Wellness",
      "description": "\$15 off on health products",
      "discountType": "fixed_amount",
      "discountValue": 15,
      "brand": "Wellness Plus",
      "status": "used",
      "acquiredDate": "2024-01-12",
      "validUntil": "2024-03-01",
      "usedDate": "2024-01-22",
      "orderNumber": "ORD-2024-002",
      "savedAmount": 15.00,
      "category": "health",
      "color": 0xFF96CEB4,
    },
    {
      "id": "UC005",
      "couponId": "CPN005",
      "title": "Movie Night",
      "description": "50% off on movie tickets",
      "discountType": "percentage",
      "discountValue": 50,
      "brand": "CineMax",
      "status": "active",
      "acquiredDate": "2024-01-18",
      "validUntil": "2024-02-28",
      "usedDate": null,
      "orderNumber": null,
      "savedAmount": null,
      "category": "entertainment",
      "color": 0xFFFECA57,
    },
  ];

  Map<String, dynamic> userStats = {
    "totalSaved": 247.50,
    "couponsUsed": 15,
    "activeCoupons": 8,
    "expiredCoupons": 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Coupons"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo(CouponAnalyticsView());
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(DiscoverCouponsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Savings Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
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
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Total Savings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "\$${((userStats["totalSaved"] as double)).currency}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                Text(
                  "Money saved with coupons",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
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
                              "${userStats["couponsUsed"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Used",
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
                              "${userStats["activeCoupons"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active",
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
                              "${userStats["expiredCoupons"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Expired",
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
          
          // Tab Navigation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                'active', 'used', 'expired'
              ].map((tab) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedTab = tab;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: selectedTab == tab ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      tab.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: selectedTab == tab ? Colors.white : primaryColor,
                      ),
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
                  // Quick Actions for Active Tab
                  if (selectedTab == 'active') ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Tip: Use your active coupons before they expire to maximize savings!",
                              style: TextStyle(
                                fontSize: 14,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],
                  
                  Text(
                    "${selectedTab.toUpperCase()} COUPONS",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Coupon Cards
                  ...userCoupons.where((coupon) => coupon["status"] == selectedTab).map((coupon) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                      border: coupon["status"] == 'expired' 
                          ? Border.all(color: disabledBoldColor.withAlpha(128)) 
                          : null,
                    ),
                    child: Opacity(
                      opacity: coupon["status"] == 'expired' ? 0.6 : 1.0,
                      child: Column(
                        children: [
                          // Coupon Header
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Color(coupon["color"] as int).withAlpha(20),
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
                                    color: Color(coupon["color"] as int),
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
                                      Text(
                                        "${coupon["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(coupon["status"]),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${coupon["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
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
                                // Description
                                Text(
                                  "${coupon["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Discount Value
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: Color(coupon["color"] as int).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Text(
                                        _getDiscountDisplay(coupon),
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(coupon["color"] as int),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Acquired: ${coupon["acquiredDate"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          if (coupon["usedDate"] != null) ...[
                                            Text(
                                              "Used: ${coupon["usedDate"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: successColor,
                                              ),
                                            ),
                                          ] else ...[
                                            Text(
                                              "Valid until: ${coupon["validUntil"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _isExpiringSoon(coupon["validUntil"]) ? dangerColor : primaryColor,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Used Details
                                if (coupon["status"] == 'used') ...[
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.receipt,
                                              size: 16,
                                              color: successColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Order: ${coupon["orderNumber"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (coupon["savedAmount"] != null) ...[
                                          SizedBox(height: spXs),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.savings,
                                                size: 16,
                                                color: successColor,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "Saved: \$${(coupon["savedAmount"] as double).currency}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: successColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                ],
                                
                                // Expiring Soon Warning
                                if (coupon["status"] == 'active' && _isExpiringSoon(coupon["validUntil"])) ...[
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          size: 16,
                                          color: dangerColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Expires in ${_getDaysUntilExpiry(coupon["validUntil"])} days",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                ],
                                
                                // Action Buttons
                                if (coupon["status"] == 'active') ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Use Now",
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
                                    ],
                                  ),
                                ] else if (coupon["status"] == 'used') ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Order",
                                          size: bs.sm,
                                          onPressed: () {
                                            // navigateTo(OrderDetailsView());
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.receipt,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Find Similar",
                                          size: bs.sm,
                                          onPressed: () {
                                            // navigateTo(SimilarCouponsView());
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.delete,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                  
                  // Empty State
                  if (userCoupons.where((coupon) => coupon["status"] == selectedTab).isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox,
                            size: 64,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No ${selectedTab} coupons",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            selectedTab == 'active' 
                                ? "Discover new coupons to start saving!"
                                : "Your ${selectedTab} coupons will appear here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (selectedTab == 'active') ...[
                            SizedBox(height: spMd),
                            QButton(
                              label: "Discover Coupons",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(DiscoverCouponsView());
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
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
      default:
        return Icons.local_offer;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'used':
        return primaryColor;
      case 'expired':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _getDiscountDisplay(Map<String, dynamic> coupon) {
    String type = coupon["discountType"];
    int value = coupon["discountValue"] as int;
    
    switch (type) {
      case 'percentage':
        return "${value}% OFF";
      case 'fixed_amount':
        return "\$${value} OFF";
      case 'buy_x_get_y':
        return "BUY 2 GET ${value} FREE";
      case 'free_shipping':
        return "FREE SHIPPING";
      default:
        return "${value}% OFF";
    }
  }

  bool _isExpiringSoon(String validUntil) {
    DateTime expiry = DateTime.parse(validUntil);
    DateTime now = DateTime.now();
    return expiry.difference(now).inDays <= 7;
  }

  int _getDaysUntilExpiry(String validUntil) {
    DateTime expiry = DateTime.parse(validUntil);
    DateTime now = DateTime.now();
    return expiry.difference(now).inDays;
  }
}

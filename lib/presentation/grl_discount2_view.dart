import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount2View extends StatefulWidget {
  @override
  State<GrlDiscount2View> createState() => _GrlDiscount2ViewState();
}

class _GrlDiscount2ViewState extends State<GrlDiscount2View> {
  int selectedTabIndex = 0;
  String couponCode = "";
  
  List<Map<String, dynamic>> activeCoupons = [
    {
      "id": 1,
      "title": "Summer Sale",
      "code": "SUMMER30",
      "discount": 30,
      "type": "percentage",
      "description": "Get 30% off on all summer collection items",
      "expiryDate": "2024-08-31",
      "minAmount": 50.0,
      "maxDiscount": 100.0,
      "usageCount": 245,
      "totalUsage": 1000,
      "category": "Fashion",
      "image": "https://picsum.photos/80/80?random=1&keyword=summer",
      "isPopular": true,
    },
    {
      "id": 2,
      "title": "Free Delivery",
      "code": "FREEDEL",
      "discount": 5,
      "type": "flat",
      "description": "Free delivery on orders above \$25",
      "expiryDate": "2024-07-30",
      "minAmount": 25.0,
      "maxDiscount": 5.0,
      "usageCount": 89,
      "totalUsage": 500,
      "category": "Delivery",
      "image": "https://picsum.photos/80/80?random=2&keyword=delivery",
      "isPopular": false,
    },
    {
      "id": 3,
      "title": "Electronics Deal",
      "code": "TECH20",
      "discount": 20,
      "type": "percentage",
      "description": "20% discount on electronics and gadgets",
      "expiryDate": "2024-08-15",
      "minAmount": 100.0,
      "maxDiscount": 200.0,
      "usageCount": 156,
      "totalUsage": 800,
      "category": "Electronics",
      "image": "https://picsum.photos/80/80?random=3&keyword=electronics",
      "isPopular": true,
    },
  ];
  
  List<Map<String, dynamic>> expiredCoupons = [
    {
      "id": 4,
      "title": "Spring Collection",
      "code": "SPRING25",
      "discount": 25,
      "type": "percentage",
      "description": "25% off on spring fashion items",
      "expiryDate": "2024-06-30",
      "minAmount": 40.0,
      "maxDiscount": 75.0,
      "usageCount": 567,
      "totalUsage": 567,
      "category": "Fashion",
      "image": "https://picsum.photos/80/80?random=4&keyword=spring",
      "isPopular": false,
    },
    {
      "id": 5,
      "title": "Weekend Special",
      "code": "WEEKEND15",
      "discount": 15,
      "type": "percentage",
      "description": "Weekend only special discount",
      "expiryDate": "2024-06-25",
      "minAmount": 30.0,
      "maxDiscount": 50.0,
      "usageCount": 234,
      "totalUsage": 300,
      "category": "General",
      "image": "https://picsum.photos/80/80?random=5&keyword=weekend",
      "isPopular": false,
    },
  ];

  void _applyCoupon() {
    if (couponCode.isNotEmpty) {
      bool isValid = activeCoupons.any((coupon) => coupon["code"].toString().toLowerCase() == couponCode.toLowerCase());
      if (isValid) {
        ss("Coupon applied successfully!");
        couponCode = "";
        setState(() {});
      } else {
        se("Invalid or expired coupon code");
      }
    }
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, bool isExpired) {
    double progress = (coupon["usageCount"] as int) / (coupon["totalUsage"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isExpired ? disabledColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: coupon["isPopular"] == true ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${coupon["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${coupon["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isExpired ? disabledBoldColor : primaryColor,
                              ),
                            ),
                          ),
                          if (coupon["isPopular"] == true && !isExpired)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "POPULAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${coupon["description"]}",
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
                          Icon(
                            Icons.local_offer,
                            size: 16,
                            color: isExpired ? disabledBoldColor : successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            coupon["type"] == "percentage" 
                                ? "${coupon["discount"]}% OFF"
                                : "\$${(coupon["discount"] as num).toStringAsFixed(2)} OFF",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isExpired ? disabledBoldColor : successColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Min: \$${((coupon["minAmount"] as double)).currency}",
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
            
            SizedBox(height: spSm),
            
            // Coupon Code Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isExpired ? disabledColor.withAlpha(20) : primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isExpired ? disabledColor : primaryColor,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Coupon Code",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${coupon["code"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isExpired ? disabledBoldColor : primaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isExpired)
                    QButton(
                      label: "Copy",
                      size: bs.sm,
                      onPressed: () {
                        ss("Coupon code copied!");
                      },
                    ),
                ],
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Usage Progress
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Usage: ${coupon["usageCount"]}/${coupon["totalUsage"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Expires: ${coupon["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isExpired ? dangerColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isExpired ? disabledBoldColor : progress > 0.8 ? dangerColor : successColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Coupons"),
        actions: [
          Icon(Icons.help_outline, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Apply Coupon Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Have a Coupon Code?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Enter your coupon code below to apply discount",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: QTextField(
                            label: "Enter coupon code",
                            value: couponCode,
                            onChanged: (value) {
                              couponCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: _applyCoupon,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Tab Section
            Container(
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTabIndex = 0;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTabIndex == 0 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Active (${activeCoupons.length})",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTabIndex == 0 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTabIndex = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTabIndex == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Expired (${expiredCoupons.length})",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedTabIndex == 1 ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Coupons List
            if (selectedTabIndex == 0) ...[
              if (activeCoupons.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Active Coupons",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Check back later for new offers and discounts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: activeCoupons.map((coupon) => _buildCouponCard(coupon, false)).toList(),
                ),
            ] else ...[
              if (expiredCoupons.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Expired Coupons",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Your expired coupons will appear here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: expiredCoupons.map((coupon) => _buildCouponCard(coupon, true)).toList(),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

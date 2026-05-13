import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsCouponsView extends StatefulWidget {
  const EcsCouponsView({super.key});

  @override
  State<EcsCouponsView> createState() => _EcsCouponsViewState();
}

class _EcsCouponsViewState extends State<EcsCouponsView> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> availableCoupons = [
    {
      "id": 1,
      "code": "SAVE30",
      "title": "30% Off Everything",
      "description": "Get 30% discount on all items in your cart",
      "discountType": "percentage",
      "discountValue": 30,
      "minOrderValue": 50.0,
      "maxDiscount": 100.0,
      "validUntil": "2025-07-01",
      "usageLimit": 1000,
      "usedCount": 234,
      "category": "General",
      "isExpiringSoon": false,
      "isFeatured": true,
      "termsAndConditions": [
        "Valid on all products except sale items",
        "Cannot be combined with other offers",
        "Valid for one-time use per customer"
      ]
    },
    {
      "id": 2,
      "code": "FREESHIP",
      "title": "Free Shipping",
      "description": "Free shipping on orders over \$25",
      "discountType": "free_shipping",
      "discountValue": 0,
      "minOrderValue": 25.0,
      "maxDiscount": 0.0,
      "validUntil": "2025-06-20",
      "usageLimit": 500,
      "usedCount": 456,
      "category": "Shipping",
      "isExpiringSoon": true,
      "isFeatured": false,
      "termsAndConditions": [
        "Valid on standard shipping only",
        "Excludes oversized items",
        "Valid within continental US only"
      ]
    },
    {
      "id": 3,
      "code": "NEWUSER20",
      "title": "New Customer Special",
      "description": "20% off for first-time customers",
      "discountType": "percentage",
      "discountValue": 20,
      "minOrderValue": 0.0,
      "maxDiscount": 50.0,
      "validUntil": "2025-12-31",
      "usageLimit": 0,
      "usedCount": 1289,
      "category": "New Customer",
      "isExpiringSoon": false,
      "isFeatured": true,
      "termsAndConditions": [
        "Valid for new customers only",
        "Valid on first purchase",
        "Cannot be combined with other offers"
      ]
    },
    {
      "id": 4,
      "code": "ELECTRONICS50",
      "title": "\$50 Off Electronics",
      "description": "Get \$50 off on electronics over \$200",
      "discountType": "fixed",
      "discountValue": 50,
      "minOrderValue": 200.0,
      "maxDiscount": 50.0,
      "validUntil": "2025-06-18",
      "usageLimit": 100,
      "usedCount": 89,
      "category": "Electronics",
      "isExpiringSoon": true,
      "isFeatured": false,
      "termsAndConditions": [
        "Valid on electronics category only",
        "Minimum order value \$200",
        "Limited time offer"
      ]
    },
    {
      "id": 5,
      "code": "FASHION25",
      "title": "Fashion Week Sale",
      "description": "25% off on all fashion items",
      "discountType": "percentage",
      "discountValue": 25,
      "minOrderValue": 30.0,
      "maxDiscount": 75.0,
      "validUntil": "2025-08-15",
      "usageLimit": 2000,
      "usedCount": 567,
      "category": "Fashion",
      "isExpiringSoon": false,
      "isFeatured": false,
      "termsAndConditions": [
        "Valid on fashion category only",
        "Includes clothing, shoes, and accessories",
        "Cannot be combined with clearance items"
      ]
    }
  ];

  List<Map<String, dynamic>> usedCoupons = [
    {
      "id": 101,
      "code": "WELCOME10",
      "title": "Welcome Bonus",
      "description": "10% off welcome discount",
      "discountValue": 10,
      "usedOn": "2025-06-10",
      "orderValue": 89.99,
      "savedAmount": 9.00,
      "orderId": "ORD-12345"
    },
    {
      "id": 102,
      "code": "BIRTHDAY15",
      "title": "Birthday Special",
      "description": "15% birthday discount",
      "discountValue": 15,
      "usedOn": "2025-05-28",
      "orderValue": 156.78,
      "savedAmount": 23.52,
      "orderId": "ORD-12346"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Coupons & Offers",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Available", icon: Icon(Icons.local_offer)),
        Tab(text: "Used", icon: Icon(Icons.history)),
        Tab(text: "Expired", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildAvailableCouponsTab(),
        _buildUsedCouponsTab(),
        _buildExpiredCouponsTab(),
      ],
    );
  }

  Widget _buildAvailableCouponsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildCouponsHeader(),
          _buildCouponStats(),
          _buildExpiringSoonSection(),
          _buildFeaturedCoupons(),
          _buildAllCoupons(),
          _buildCouponTips(),
        ],
      ),
    );
  }

  Widget _buildUsedCouponsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildUsedCouponsStats(),
          _buildUsedCouponsList(),
        ],
      ),
    );
  }

  Widget _buildExpiredCouponsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(Icons.schedule, color: disabledBoldColor, size: 48),
                SizedBox(height: spSm),
                Text(
                  "No Expired Coupons",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Great! You haven't missed any coupons yet.",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildCouponsHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            successColor,
            successColor.withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_offer, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Text(
                "Save More",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Exclusive coupons just for you",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Stack savings with our special offers",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponStats() {
    int totalCoupons = availableCoupons.length;
    int expiringSoon = availableCoupons.where((c) => c["isExpiringSoon"] == true).length;
    double totalSavings = availableCoupons.fold(0.0, (sum, coupon) => 
        sum + (coupon["discountType"] == "percentage" 
            ? (coupon["maxDiscount"] as double) 
            : (coupon["discountValue"] as num).toDouble()));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Available", "${totalCoupons}", Icons.local_offer, primaryColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Expiring", "${expiringSoon}", Icons.schedule, warningColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Max Save", "\$${totalSavings.toInt()}", Icons.savings, successColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: color, size: 20),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiringSoonSection() {
    List<Map<String, dynamic>> expiringSoon = availableCoupons
        .where((coupon) => coupon["isExpiringSoon"] == true)
        .toList();

    if (expiringSoon.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: dangerColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Expiring Soon",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        ...expiringSoon.map((coupon) => _buildCouponCard(coupon, isUrgent: true)),
      ],
    );
  }

  Widget _buildFeaturedCoupons() {
    List<Map<String, dynamic>> featuredCoupons = availableCoupons
        .where((coupon) => coupon["isFeatured"] == true)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: warningColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Featured Offers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        ...featuredCoupons.map((coupon) => _buildCouponCard(coupon, isFeatured: true)),
      ],
    );
  }

  Widget _buildAllCoupons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "All Available Coupons",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...availableCoupons.map((coupon) => _buildCouponCard(coupon)),
      ],
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, {bool isUrgent = false, bool isFeatured = false}) {
    double usagePercentage = coupon["usageLimit"] > 0 
        ? (coupon["usedCount"] as int) / (coupon["usageLimit"] as int)
        : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isUrgent 
              ? dangerColor.withAlpha(100)
              : isFeatured 
                  ? warningColor.withAlpha(100)
                  : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getCouponIcon(coupon["discountType"]),
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${coupon["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (isFeatured)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "FEATURED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${coupon["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${coupon["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Valid until ${DateTime.parse(coupon["validUntil"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isUrgent ? dangerColor : disabledBoldColor,
                                  fontWeight: isUrgent ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: primaryColor,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupon Code",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${coupon["code"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              // Copy to clipboard
                              ss("Coupon code ${coupon["code"]} copied to clipboard!");
                            },
                            child: Icon(
                              Icons.copy,
                              color: primaryColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (coupon["usageLimit"] > 0)
                  Column(
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Used: ${coupon["usedCount"]}/${coupon["usageLimit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(usagePercentage * 100).toInt()}% claimed",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: usagePercentage,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Apply Coupon",
                        size: bs.sm,
                        onPressed: () {
                          ss("Coupon ${coupon["code"]} applied to your cart!");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        _showCouponDetails(coupon);
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
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
  }

  Widget _buildUsedCouponsStats() {
    double totalSaved = usedCoupons.fold(0.0, (sum, coupon) => sum + (coupon["savedAmount"] as double));
    int totalOrders = usedCoupons.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Total Saved", "\$${totalSaved.toStringAsFixed(2)}", Icons.savings, successColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Orders", "${totalOrders}", Icons.shopping_cart, primaryColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Avg Save", "\$${(totalSaved / totalOrders).toStringAsFixed(2)}", Icons.trending_up, infoColor),
          ),
        ],
      ),
    );
  }

  Widget _buildUsedCouponsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Coupon History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...usedCoupons.map((coupon) => _buildUsedCouponCard(coupon)),
      ],
    );
  }

  Widget _buildUsedCouponCard(Map<String, dynamic> coupon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.check_circle,
              color: successColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${coupon["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Code: ${coupon["code"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Used on ${DateTime.parse(coupon["usedOn"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Saved \$${(coupon["savedAmount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              //navigateTo EcsOrderDetailView with orderId
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.receipt,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Coupon Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              _buildTipItem("Check minimum order values before applying"),
              _buildTipItem("Some coupons cannot be combined together"),
              _buildTipItem("Set reminders for expiring coupons"),
              _buildTipItem("Share unused coupons with friends"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getCouponIcon(String discountType) {
    switch (discountType) {
      case "percentage":
        return Icons.percent;
      case "fixed":
        return Icons.attach_money;
      case "free_shipping":
        return Icons.local_shipping;
      default:
        return Icons.local_offer;
    }
  }

  void _showCouponDetails(Map<String, dynamic> coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${coupon["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Terms & Conditions:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...(coupon["termsAndConditions"] as List).map((term) => 
              Padding(
                padding: EdgeInsets.only(left: spSm, bottom: spXs),
                child: Text(
                  "• ${term}",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
              )
            ),
            SizedBox(height: spSm),
            if (coupon["minOrderValue"] > 0)
              Text(
                "Minimum order: \$${((coupon["minOrderValue"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            if (coupon["maxDiscount"] > 0)
              Text(
                "Maximum discount: \$${((coupon["maxDiscount"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}

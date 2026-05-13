import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCouponsView extends StatefulWidget {
  const SpaCouponsView({super.key});

  @override
  State<SpaCouponsView> createState() => _SpaCouponsViewState();
}

class _SpaCouponsViewState extends State<SpaCouponsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool showExpired = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Skincare", "value": "Skincare"},
    {"label": "Makeup", "value": "Makeup"},
    {"label": "Haircare", "value": "Haircare"},
    {"label": "Body Care", "value": "Body Care"},
    {"label": "Free Shipping", "value": "Free Shipping"},
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "id": "SAVE30",
      "title": "30% Off Skincare",
      "description": "Get 30% off on all skincare products",
      "discount": "30% OFF",
      "category": "Skincare",
      "type": "percentage",
      "value": 30,
      "minOrder": 50.00,
      "maxDiscount": 100.00,
      "validUntil": "2024-12-31",
      "isExpired": false,
      "isUsed": false,
      "usageCount": 342,
      "color": Colors.green,
      "terms": [
        "Valid on skincare products only",
        "Minimum order \$50",
        "Cannot be combined with other offers",
        "Maximum discount \$100"
      ],
    },
    {
      "id": "FREESHIP",
      "title": "Free Shipping",
      "description": "Free shipping on orders over \$25",
      "discount": "FREE SHIP",
      "category": "Free Shipping",
      "type": "shipping",
      "value": 0,
      "minOrder": 25.00,
      "maxDiscount": 15.00,
      "validUntil": "2024-12-15",
      "isExpired": false,
      "isUsed": true,
      "usageCount": 1256,
      "color": Colors.blue,
      "terms": [
        "Minimum order \$25",
        "Standard shipping only",
        "Excludes oversized items"
      ],
    },
    {
      "id": "MAKEUP20",
      "title": "20% Off Makeup",
      "description": "Save 20% on all makeup products",
      "discount": "\$20 OFF",
      "category": "Makeup",
      "type": "fixed",
      "value": 20,
      "minOrder": 75.00,
      "maxDiscount": 20.00,
      "validUntil": "2024-11-30",
      "isExpired": true,
      "isUsed": false,
      "usageCount": 89,
      "color": Colors.pink,
      "terms": [
        "Valid on makeup products only",
        "Minimum order \$75",
        "One use per customer"
      ],
    },
    {
      "id": "WELCOME15",
      "title": "Welcome Offer",
      "description": "15% off for new customers",
      "discount": "15% OFF",
      "category": "All",
      "type": "percentage",
      "value": 15,
      "minOrder": 30.00,
      "maxDiscount": 50.00,
      "validUntil": "2025-01-31",
      "isExpired": false,
      "isUsed": false,
      "usageCount": 567,
      "color": Colors.orange,
      "terms": [
        "New customers only",
        "Minimum order \$30",
        "Valid for first purchase only"
      ],
    },
    {
      "id": "HAIR25",
      "title": "Hair Care Special",
      "description": "Buy 2 get 1 free on haircare",
      "discount": "BUY 2 GET 1",
      "category": "Haircare",
      "type": "bogo",
      "value": 0,
      "minOrder": 0.00,
      "maxDiscount": 0.00,
      "validUntil": "2024-12-20",
      "isExpired": false,
      "isUsed": false,
      "usageCount": 198,
      "color": Colors.purple,
      "terms": [
        "Buy 2 haircare products, get 1 free",
        "Lowest priced item free",
        "Cannot be combined with other offers"
      ],
    },
    {
      "id": "BODY10",
      "title": "Body Care Bundle",
      "description": "\$10 off body care sets",
      "discount": "\$10 OFF",
      "category": "Body Care",
      "type": "fixed",
      "value": 10,
      "minOrder": 40.00,
      "maxDiscount": 10.00,
      "validUntil": "2024-12-25",
      "isExpired": false,
      "isUsed": false,
      "usageCount": 234,
      "color": Colors.teal,
      "terms": [
        "Valid on body care sets only",
        "Minimum order \$40",
        "Limited time offer"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredCoupons {
    List<Map<String, dynamic>> filtered = coupons;
    
    if (!showExpired) {
      filtered = filtered.where((coupon) => coupon["isExpired"] == false).toList();
    }
    
    if (selectedCategory != "All") {
      filtered = filtered.where((coupon) => coupon["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((coupon) => 
        coupon["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        coupon["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        coupon["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupons & Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showUsedCoupons();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildCouponStats(),
            _buildFeaturedOffer(),
            _buildCouponsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: QTextField(
                  label: "Search coupons...",
                  value: searchQuery,
                  hint: "Search by code, title, or description",
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
                onPressed: () {
                  // Search action
                },
              ),
            ],
          ),
          Text(
            "Filter by Category",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Expired Coupons",
                      "value": true,
                      "checked": showExpired,
                    }
                  ],
                  value: [
                    if (showExpired)
                      {"label": "Show Expired Coupons", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showExpired = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCouponStats() {
    int activeCoupons = coupons.where((c) => c["isExpired"] == false).length;
    int usedCoupons = coupons.where((c) => c["isUsed"] == true).length;
    int totalSavings = coupons.fold(0, (sum, coupon) => sum + (coupon["usageCount"] as int));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Your Coupon Stats",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$activeCoupons",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Available",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$usedCoupons",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Used",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${(totalSavings / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Uses",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildFeaturedOffer() {
    final featuredCoupon = coupons.first;
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withAlpha(180),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,  
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "FEATURED OFFER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.star, color: Colors.white, size: 20),
            ],
          ),
          Text(
            "${featuredCoupon["title"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "${featuredCoupon["description"]}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${featuredCoupon["discount"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              QButton(
                label: "Use Now",
                size: bs.sm,
                onPressed: () {
                  _useCoupon(featuredCoupon);
                },
              ),
            ],
          ),
          Text(
            "Valid until ${featuredCoupon["validUntil"]} • ${featuredCoupon["usageCount"]} uses",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "All Coupons",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredCoupons.length} found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredCoupons.map((coupon) {
          return _buildCouponCard(coupon);
        }).toList(),
      ],
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon) {
    bool isExpired = coupon["isExpired"] == true;
    bool isUsed = coupon["isUsed"] == true;
    Color cardColor = isExpired ? disabledColor : (coupon["color"] as Color);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isExpired ? Border.all(color: disabledOutlineBorderColor) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: cardColor.withAlpha(isExpired ? 60 : 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                bottomLeft: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${coupon["discount"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isExpired ? disabledBoldColor : Colors.white,
                  ),
                ),
                if (coupon["minOrder"] > 0)
                  Text(
                    "Min \$${(coupon["minOrder"] as double).currency}",
                    style: TextStyle(
                      fontSize: 10,
                      color: isExpired ? disabledBoldColor : Colors.white.withAlpha(200),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: cardColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${coupon["id"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isExpired ? disabledBoldColor : cardColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      if (isUsed)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "USED",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      if (isExpired && !isUsed)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "EXPIRED",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "${coupon["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isExpired ? disabledBoldColor : primaryColor,
                    ),
                  ),
                  Text(
                    "${coupon["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isExpired ? disabledBoldColor : disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: isExpired ? disabledBoldColor : warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Valid until ${coupon["validUntil"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: isExpired ? disabledBoldColor : disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${coupon["usageCount"]} uses",
                        style: TextStyle(
                          fontSize: 10,
                          color: isExpired ? disabledBoldColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QButton(
                        label: "View Terms",
                        size: bs.sm,
                        onPressed: () {
                          _showCouponDetails(coupon);
                        },
                      ),
                      Spacer(),
                      if (!isExpired && !isUsed)
                        QButton(
                          label: "Use Coupon",
                          size: bs.sm,
                          onPressed: () {
                            _useCoupon(coupon);
                          },
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
  }

  void _useCoupon(Map<String, dynamic> coupon) {
    if (coupon["isExpired"] == true) {
      se("This coupon has expired");
      return;
    }
    
    if (coupon["isUsed"] == true) {
      si("This coupon has already been used");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Use Coupon"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Coupon Code: ${coupon["id"]}"),
            Text("Discount: ${coupon["discount"]}"),
            if (coupon["minOrder"] > 0)
              Text("Minimum Order: \$${(coupon["minOrder"] as double).currency}"),
            SizedBox(height: spSm),
            Text("Apply this coupon to your cart?"),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Coupon ${coupon["id"]} applied to cart");
              coupon["isUsed"] = true;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _showCouponDetails(Map<String, dynamic> coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${coupon["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms & Conditions:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            ...((coupon["terms"] as List).map((term) {
              return Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• "),
                    Expanded(child: Text("$term")),
                  ],
                ),
              );
            }).toList()),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showUsedCoupons() {
    List<Map<String, dynamic>> usedCoupons = coupons.where((c) => c["isUsed"] == true).toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Used Coupons"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (usedCoupons.isEmpty)
                Text("No coupons used yet")
              else
                ...usedCoupons.map((coupon) {
                  return ListTile(
                    title: Text("${coupon["title"]}"),
                    subtitle: Text("Code: ${coupon["id"]}"),
                    trailing: Text("${coupon["discount"]}"),
                  );
                }).toList(),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}

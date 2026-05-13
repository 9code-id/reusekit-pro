import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCouponsView extends StatefulWidget {
  const FdaCouponsView({super.key});

  @override
  State<FdaCouponsView> createState() => _FdaCouponsViewState();
}

class _FdaCouponsViewState extends State<FdaCouponsView> {
  String selectedFilter = "All";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "available"},
    {"label": "Used", "value": "used"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "id": "coupon1",
      "title": "Welcome Bonus",
      "description": "Get 30% off your first order",
      "code": "WELCOME30",
      "discount": "30% OFF",
      "discountValue": 30,
      "discountType": "percentage",
      "minOrder": 25.00,
      "maxDiscount": 15.00,
      "validFrom": "2024-03-01",
      "validUntil": "2024-04-30",
      "status": "available",
      "isUsed": false,
      "usageCount": 0,
      "usageLimit": 1,
      "applicableRestaurants": "All restaurants",
      "category": "first_order",
      "image": "https://picsum.photos/100/100?random=1&keyword=coupon",
    },
    {
      "id": "coupon2",
      "title": "Free Delivery",
      "description": "No delivery charges on orders above \$20",
      "code": "FREEDEL20",
      "discount": "FREE DELIVERY",
      "discountValue": 5.00,
      "discountType": "fixed",
      "minOrder": 20.00,
      "maxDiscount": 5.00,
      "validFrom": "2024-03-15",
      "validUntil": "2024-03-31",
      "status": "available",
      "isUsed": false,
      "usageCount": 2,
      "usageLimit": 5,
      "applicableRestaurants": "All restaurants",
      "category": "delivery",
      "image": "https://picsum.photos/100/100?random=2&keyword=delivery",
    },
    {
      "id": "coupon3",
      "title": "Pizza Party",
      "description": "Buy 2 pizzas and get 1 free",
      "code": "PIZZA3FOR2",
      "discount": "BUY 2 GET 1",
      "discountValue": 100,
      "discountType": "bogo",
      "minOrder": 35.00,
      "maxDiscount": 20.00,
      "validFrom": "2024-03-10",
      "validUntil": "2024-03-25",
      "status": "used",
      "isUsed": true,
      "usageCount": 1,
      "usageLimit": 1,
      "applicableRestaurants": "Pizza restaurants only",
      "category": "food_type",
      "image": "https://picsum.photos/100/100?random=3&keyword=pizza",
    },
    {
      "id": "coupon4",
      "title": "Weekend Special",
      "description": "25% off on weekend orders",
      "code": "WEEKEND25",
      "discount": "25% OFF",
      "discountValue": 25,
      "discountType": "percentage",
      "minOrder": 30.00,
      "maxDiscount": 12.00,
      "validFrom": "2024-02-01",
      "validUntil": "2024-02-29",
      "status": "expired",
      "isUsed": false,
      "usageCount": 0,
      "usageLimit": 3,
      "applicableRestaurants": "Selected restaurants",
      "category": "weekend",
      "image": "https://picsum.photos/100/100?random=4&keyword=weekend",
    },
    {
      "id": "coupon5",
      "title": "Lunch Deal",
      "description": "\$5 off on lunch orders",
      "code": "LUNCH5",
      "discount": "\$5 OFF",
      "discountValue": 5.00,
      "discountType": "fixed",
      "minOrder": 15.00,
      "maxDiscount": 5.00,
      "validFrom": "2024-03-20",
      "validUntil": "2024-04-20",
      "status": "available",
      "isUsed": false,
      "usageCount": 1,
      "usageLimit": 10,
      "applicableRestaurants": "Lunch restaurants",
      "category": "meal_time",
      "image": "https://picsum.photos/100/100?random=5&keyword=lunch",
    },
    {
      "id": "coupon6",
      "title": "Birthday Treat",
      "description": "Special birthday discount - 40% off",
      "code": "BIRTHDAY40",
      "discount": "40% OFF",
      "discountValue": 40,
      "discountType": "percentage",
      "minOrder": 20.00,
      "maxDiscount": 25.00,
      "validFrom": "2024-03-18",
      "validUntil": "2024-03-24",
      "status": "available",
      "isUsed": false,
      "usageCount": 0,
      "usageLimit": 1,
      "applicableRestaurants": "All restaurants",
      "category": "special",
      "image": "https://picsum.photos/100/100?random=6&keyword=birthday",
    },
  ];

  List<Map<String, dynamic>> get filteredCoupons {
    if (selectedFilter == "All") return coupons;
    return coupons.where((coupon) => coupon["status"] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "used":
        return infoColor;
      case "expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "available":
        return "Available";
      case "used":
        return "Used";
      case "expired":
        return "Expired";
      default:
        return "Unknown";
    }
  }

  void _copyCouponCode(String code) {
    ss("Coupon code $code copied to clipboard!");
  }

  void _useCoupon(Map<String, dynamic> coupon) {
    if (coupon["status"] != "available") {
      se("This coupon is not available for use");
      return;
    }
    
    ss("Applying coupon ${coupon["code"]}...");
    // Navigate to restaurant selection or cart
  }

  void _viewCouponDetails(Map<String, dynamic> coupon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${coupon["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Coupon Visual
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor.withAlpha(200), primaryColor],
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${coupon["discount"]}",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${coupon["code"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${coupon["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    // Coupon Details
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Minimum Order", "\$${(coupon["minOrder"] as double).toStringAsFixed(2)}"),
                          _buildDetailRow("Maximum Discount", "\$${(coupon["maxDiscount"] as double).toStringAsFixed(2)}"),
                          _buildDetailRow("Valid From", "${coupon["validFrom"]}"),
                          _buildDetailRow("Valid Until", "${coupon["validUntil"]}"),
                          _buildDetailRow("Usage", "${coupon["usageCount"]}/${coupon["usageLimit"]} times"),
                          _buildDetailRow("Applicable To", "${coupon["applicableRestaurants"]}"),
                          _buildDetailRow("Status", getStatusText(coupon["status"])),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),
                    // Action Buttons
                    if (coupon["status"] == "available") ...[
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Copy Code",
                              size: bs.md,
                              onPressed: () {
                                back();
                                _copyCouponCode(coupon["code"]);
                              },
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: QButton(
                              label: "Use Now",
                              size: bs.md,
                              onPressed: () {
                                back();
                                _useCoupon(coupon);
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: getStatusColor(coupon["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          coupon["status"] == "used" 
                            ? "This coupon has been used"
                            : "This coupon has expired",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getStatusColor(coupon["status"]),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _searchCoupons() {
    // Implement search functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Coupons"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchCoupons,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Stats Header
                Container(
                  margin: EdgeInsets.all(spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${coupons.where((c) => c["status"] == "available").length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                      Container(width: 1, height: 30, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${coupons.where((c) => c["status"] == "used").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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
                      Container(width: 1, height: 30, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${coupons.where((c) => c["status"] == "expired").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Expired",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Filter Tabs
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    children: filterOptions.map((filter) {
                      bool isSelected = selectedFilter == filter["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedFilter = filter["value"];
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "${filter["label"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: spMd),

                // Coupons List
                Expanded(
                  child: filteredCoupons.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.discount,
                                size: 80,
                                color: disabledColor,
                              ),
                              SizedBox(height: spMd),
                              Text(
                                "No coupons found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Check back later for new coupons",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: filteredCoupons.length,
                          itemBuilder: (context, index) {
                            final coupon = filteredCoupons[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                                border: coupon["status"] == "available" 
                                  ? Border.all(color: successColor.withAlpha(50), width: 2)
                                  : null,
                              ),
                              child: Row(
                                children: [
                                  // Coupon Image
                                  Container(
                                    width: 80,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusMd),
                                        bottomLeft: Radius.circular(radiusMd),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage("${coupon["image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  
                                  // Coupon Details
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(spMd),
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
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(coupon["status"]).withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusSm),
                                                ),
                                                child: Text(
                                                  getStatusText(coupon["status"]),
                                                  style: TextStyle(
                                                    color: getStatusColor(coupon["status"]),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spSm),
                                          Text(
                                            "${coupon["description"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(height: spSm),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                                decoration: BoxDecoration(
                                                  color: primaryColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusSm),
                                                ),
                                                child: Text(
                                                  "${coupon["code"]}",
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Valid until ${coupon["validUntil"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Action Buttons
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    child: Column(
                                      children: [
                                        QButton(
                                          icon: Icons.visibility,
                                          size: bs.sm,
                                          onPressed: () => _viewCouponDetails(coupon),
                                        ),
                                        if (coupon["status"] == "available") ...[
                                          SizedBox(height: spXs),
                                          QButton(
                                            icon: Icons.content_copy,
                                            size: bs.sm,
                                            onPressed: () => _copyCouponCode(coupon["code"]),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon4View extends StatefulWidget {
  @override
  State<GrlCoupon4View> createState() => _GrlCoupon4ViewState();
}

class _GrlCoupon4ViewState extends State<GrlCoupon4View> {
  String couponCode = "";
  String searchQuery = "";
  String selectedCategory = "All";

  List<String> categories = ["All", "Food", "Shopping", "Travel", "Electronics", "Health"];

  List<Map<String, dynamic>> availableCoupons = [
    {
      "id": "FOOD50",
      "title": "50% Off Restaurant Orders",
      "description": "Get 50% discount on orders above \$30 at participating restaurants",
      "category": "Food",
      "discount_type": "percentage",
      "discount_value": 50,
      "min_order": 30.00,
      "max_discount": 25.00,
      "expiry_date": "2024-02-15",
      "usage_limit": 1,
      "terms": "Valid for first-time users only. Cannot be combined with other offers.",
      "merchant": "Restaurant Partners",
      "image": "https://picsum.photos/300/150?random=1&keyword=restaurant",
      "is_featured": true,
      "remaining_days": 12,
    },
    {
      "id": "SHOP25",
      "title": "25% Off Fashion Items",
      "description": "Save 25% on all fashion and accessories",
      "category": "Shopping",
      "discount_type": "percentage",
      "discount_value": 25,
      "min_order": 50.00,
      "max_discount": 100.00,
      "expiry_date": "2024-02-20",
      "usage_limit": 2,
      "terms": "Valid on selected brands. Sale items excluded.",
      "merchant": "Fashion Store",
      "image": "https://picsum.photos/300/150?random=2&keyword=fashion",
      "is_featured": false,
      "remaining_days": 17,
    },
    {
      "id": "TRAVEL100",
      "title": "\$100 Off Hotel Bookings",
      "description": "Get \$100 discount on hotel reservations",
      "category": "Travel",
      "discount_type": "fixed",
      "discount_value": 100,
      "min_order": 300.00,
      "max_discount": 100.00,
      "expiry_date": "2024-03-01",
      "usage_limit": 1,
      "terms": "Valid for bookings of 3 nights or more. Weekend surcharges may apply.",
      "merchant": "Hotel Partners",
      "image": "https://picsum.photos/300/150?random=3&keyword=hotel",
      "is_featured": true,
      "remaining_days": 26,
    },
    {
      "id": "TECH15",
      "title": "15% Off Electronics",
      "description": "Save on the latest gadgets and electronics",
      "category": "Electronics",
      "discount_type": "percentage",
      "discount_value": 15,
      "min_order": 100.00,
      "max_discount": 200.00,
      "expiry_date": "2024-02-10",
      "usage_limit": 1,
      "terms": "Valid on select items. Warranty terms apply.",
      "merchant": "Tech Store",
      "image": "https://picsum.photos/300/150?random=4&keyword=electronics",
      "is_featured": false,
      "remaining_days": 7,
    },
    {
      "id": "HEALTH30",
      "title": "30% Off Health Products",
      "description": "Discount on vitamins, supplements, and health products",
      "category": "Health",
      "discount_type": "percentage",
      "discount_value": 30,
      "min_order": 25.00,
      "max_discount": 50.00,
      "expiry_date": "2024-02-25",
      "usage_limit": 3,
      "terms": "Valid on non-prescription items only.",
      "merchant": "Health Store",
      "image": "https://picsum.photos/300/150?random=5&keyword=health",
      "is_featured": false,
      "remaining_days": 22,
    },
  ];

  List<Map<String, dynamic>> get filteredCoupons {
    List<Map<String, dynamic>> filtered = availableCoupons;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((coupon) => "${coupon["category"]}" == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((coupon) =>
        "${coupon["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${coupon["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${coupon["merchant"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Sort featured first, then by expiry date
    filtered.sort((a, b) {
      if (a["is_featured"] && !b["is_featured"]) return -1;
      if (!a["is_featured"] && b["is_featured"]) return 1;
      return (a["remaining_days"] as int).compareTo(b["remaining_days"] as int);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Coupons"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Add Coupon Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                // Manual Coupon Entry
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Enter coupon code",
                        value: couponCode,
                        hint: "e.g. SAVE50",
                        onChanged: (value) {
                          couponCode = value.toUpperCase();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Apply",
                      size: bs.sm,
                      onPressed: couponCode.isNotEmpty ? () => _applyCouponCode() : null,
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search coupons...",
                        value: searchQuery,
                        hint: "Search by title, store, or category",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.qr_code_scanner,
                      size: bs.sm,
                      onPressed: () => _scanQRCode(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: categories.map((category) {
                    bool isSelected = category == selectedCategory;
                    return GestureDetector(
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
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
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
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredCoupons.length} coupon${filteredCoupons.length != 1 ? 's' : ''} available",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSortOptions(),
                  child: Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.sort,
                        color: primaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Coupons List
          Expanded(
            child: filteredCoupons.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredCoupons.length,
                  itemBuilder: (context, index) {
                    final coupon = filteredCoupons[index];
                    return _buildCouponCard(coupon, index);
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, int index) {
    bool isFeatured = coupon["is_featured"] as bool;
    bool isExpiringSoon = (coupon["remaining_days"] as int) <= 7;
    String discountText = "${coupon["discount_type"]}" == "percentage"
      ? "${coupon["discount_value"]}% OFF"
      : "\$${(coupon["discount_value"] as num).toStringAsFixed(0)} OFF";

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isFeatured ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image and Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${coupon["image"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              if (isFeatured)
                Positioned(
                  top: spSm,
                  left: spSm,
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
                      "FEATURED",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (isExpiringSoon)
                Positioned(
                  top: spSm,
                  right: spSm,
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
                      "EXPIRING SOON",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // Discount Badge
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    discountText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${coupon["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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
                ),
                SizedBox(height: spSm),

                // Merchant and Validity
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${coupon["merchant"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      color: isExpiringSoon ? dangerColor : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${coupon["remaining_days"]} days left",
                      style: TextStyle(
                        fontSize: 12,
                        color: isExpiringSoon ? dangerColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Terms Summary
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Min order: \$${(coupon["min_order"] as double).toStringAsFixed(0)}\n"
                        "• Max discount: \$${(coupon["max_discount"] as double).toStringAsFixed(0)}\n"
                        "• Usage limit: ${coupon["usage_limit"]} time${(coupon["usage_limit"] as int) > 1 ? 's' : ''}\n"
                        "• Valid until: ${coupon["expiry_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Collect Coupon",
                        size: bs.md,
                        onPressed: () => _collectCoupon(coupon),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () => _shareCoupon(coupon),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.info_outline,
                      size: bs.sm,
                      onPressed: () => _showCouponDetails(coupon),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No coupons found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            searchQuery.isNotEmpty
              ? "Try adjusting your search terms"
              : "Check back later for new deals",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spMd),
          if (searchQuery.isNotEmpty)
            QButton(
              label: "Clear Search",
              size: bs.md,
              onPressed: () {
                searchQuery = "";
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  void _applyCouponCode() {
    if (couponCode.isNotEmpty) {
      // Check if code exists
      bool codeExists = availableCoupons.any((coupon) => "${coupon["id"]}" == couponCode);
      
      if (codeExists) {
        ss("Coupon code '$couponCode' applied successfully!");
        couponCode = "";
        setState(() {});
      } else {
        se("Invalid coupon code. Please try again.");
      }
    }
  }

  void _scanQRCode() {
    ss("QR Code scanner opened");
  }

  void _collectCoupon(Map<String, dynamic> coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        title: Text(
          "Collect Coupon",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_offer,
              color: successColor,
              size: 48,
            ),
            SizedBox(height: spMd),
            Text(
              "${coupon["title"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "This coupon has been added to your collection. You can use it at checkout.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Got it!",
              size: bs.md,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  void _shareCoupon(Map<String, dynamic> coupon) {
    ss("Sharing coupon: ${coupon["title"]}");
  }

  void _showCouponDetails(Map<String, dynamic> coupon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Coupon Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${coupon["title"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${coupon["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Terms & Conditions:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${coupon["terms"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Collect This Coupon",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  _collectCoupon(coupon);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort Coupons",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildSortOption("Featured First", () {}),
            _buildSortOption("Expiring Soon", () {}),
            _buildSortOption("Highest Discount", () {}),
            _buildSortOption("Newest First", () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}

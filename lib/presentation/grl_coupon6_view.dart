import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon6View extends StatefulWidget {
  @override
  State<GrlCoupon6View> createState() => _GrlCoupon6ViewState();
}

class _GrlCoupon6ViewState extends State<GrlCoupon6View> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "count": 24},
    {"label": "Restaurant", "value": "Restaurant", "count": 8},
    {"label": "Fashion", "value": "Fashion", "count": 6},
    {"label": "Electronics", "value": "Electronics", "count": 5},
    {"label": "Travel", "value": "Travel", "count": 3},
    {"label": "Health", "value": "Health", "count": 2},
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "id": "1",
      "title": "Weekend Special",
      "description": "Get 50% off on all weekend orders",
      "discount": "50% OFF",
      "category": "Restaurant",
      "brand": "Pizza Palace",
      "code": "WEEKEND50",
      "validUntil": "Dec 31, 2024",
      "minOrder": 25.0,
      "maxDiscount": 15.0,
      "usageCount": 1248,
      "maxUsage": 2000,
      "image": "https://picsum.photos/300/200?random=1&keyword=pizza",
      "isExpiring": false,
      "isPopular": true,
      "color": Color(0xFFE91E63),
    },
    {
      "id": "2", 
      "title": "New User Bonus",
      "description": "Special discount for first-time customers",
      "discount": "30% OFF",
      "category": "Fashion",
      "brand": "Style Studio",
      "code": "NEWUSER30",
      "validUntil": "Jan 15, 2025",
      "minOrder": 50.0,
      "maxDiscount": 20.0,
      "usageCount": 892,
      "maxUsage": 1500,
      "image": "https://picsum.photos/300/200?random=2&keyword=fashion",
      "isExpiring": true,
      "isPopular": false,
      "color": Color(0xFF9C27B0),
    },
    {
      "id": "3",
      "title": "Flash Sale",
      "description": "Limited time offer on electronics",
      "discount": "25% OFF",
      "category": "Electronics",
      "brand": "Tech World",
      "code": "FLASH25",
      "validUntil": "Dec 25, 2024",
      "minOrder": 100.0,
      "maxDiscount": 50.0,
      "usageCount": 567,
      "maxUsage": 1000,
      "image": "https://picsum.photos/300/200?random=3&keyword=electronics",
      "isExpiring": false,
      "isPopular": true,
      "color": Color(0xFF2196F3),
    },
    {
      "id": "4",
      "title": "Travel Package",
      "description": "Save on your next vacation booking",
      "discount": "40% OFF",
      "category": "Travel",
      "brand": "Dream Travel",
      "code": "TRAVEL40",
      "validUntil": "Mar 31, 2025",
      "minOrder": 500.0,
      "maxDiscount": 200.0,
      "usageCount": 234,
      "maxUsage": 500,
      "image": "https://picsum.photos/300/200?random=4&keyword=travel",
      "isExpiring": false,
      "isPopular": false,
      "color": Color(0xFF4CAF50),
    },
    {
      "id": "5",
      "title": "Health & Wellness",
      "description": "Discount on health products and services",
      "discount": "35% OFF",
      "category": "Health",
      "brand": "Wellness Plus",
      "code": "HEALTH35",
      "validUntil": "Feb 28, 2025",
      "minOrder": 75.0,
      "maxDiscount": 30.0,
      "usageCount": 445,
      "maxUsage": 800,
      "image": "https://picsum.photos/300/200?random=5&keyword=health",
      "isExpiring": true,
      "isPopular": false,
      "color": Color(0xFFFF9800),
    },
    {
      "id": "6",
      "title": "Holiday Special",
      "description": "Celebrate the holidays with great savings",
      "discount": "45% OFF",
      "category": "Fashion",
      "brand": "Holiday Store",
      "code": "HOLIDAY45",
      "validUntil": "Jan 10, 2025",
      "minOrder": 80.0,
      "maxDiscount": 40.0,
      "usageCount": 1567,
      "maxUsage": 2500,
      "image": "https://picsum.photos/300/200?random=6&keyword=holiday",
      "isExpiring": false,
      "isPopular": true,
      "color": Color(0xFFFF5722),
    },
  ];

  List<Map<String, dynamic>> get filteredCoupons {
    var filtered = coupons.where((coupon) {
      bool matchesCategory = selectedCategory == "All" || coupon["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          "${coupon["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${coupon["brand"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${coupon["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
    
    // Sort by popularity and expiring status
    filtered.sort((a, b) {
      if (a["isPopular"] != b["isPopular"]) {
        return (b["isPopular"] as bool) ? 1 : -1;
      }
      if (a["isExpiring"] != b["isExpiring"]) {
        return (a["isExpiring"] as bool) ? -1 : 1;
      }
      return 0;
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
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
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
                    label: "Search coupons",
                    value: searchQuery,
                    hint: "Search by brand, category, or offer",
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
            
            SizedBox(height: spLg),
            
            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withAlpha(30) : primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${category["count"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredCoupons.length} Coupons Available",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Sort by Expiry",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Coupons List
            ...filteredCoupons.map((coupon) {
              double usagePercentage = ((coupon["usageCount"] as int) / (coupon["maxUsage"] as int)) * 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Discount Badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          child: Image.network(
                            "${coupon["image"]}",
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Discount Badge
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: coupon["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${coupon["discount"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        // Popular Badge
                        if (coupon["isPopular"] as bool)
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Popular",
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
                        
                        // Expiring Badge
                        if (coupon["isExpiring"] as bool)
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Expiring Soon",
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
                    
                    // Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand and Title
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${coupon["brand"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${coupon["title"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: (coupon["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${coupon["category"]}",
                                  style: TextStyle(
                                    color: coupon["color"] as Color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Description
                          Text(
                            "${coupon["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Coupon Code
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: disabledOutlineBorderColor,
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
                                      SizedBox(height: 4),
                                      Text(
                                        "${coupon["code"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                          
                          SizedBox(height: spMd),
                          
                          // Usage Progress
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Usage Progress",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${coupon["usageCount"]}/${coupon["maxUsage"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: usagePercentage / 100,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        usagePercentage > 80 ? dangerColor : 
                                        usagePercentage > 60 ? warningColor : successColor,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Terms and Action
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Min. order: \$${((coupon["minOrder"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Max. discount: \$${((coupon["maxDiscount"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Valid until: ${coupon["validUntil"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: coupon["isExpiring"] as bool ? dangerColor : disabledBoldColor,
                                        fontWeight: coupon["isExpiring"] as bool ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Use Coupon",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Coupon applied successfully!");
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
        ),
      ),
    );
  }
}

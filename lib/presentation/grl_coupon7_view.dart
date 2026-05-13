import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon7View extends StatefulWidget {
  @override
  State<GrlCoupon7View> createState() => _GrlCoupon7ViewState();
}

class _GrlCoupon7ViewState extends State<GrlCoupon7View> {
  String selectedTab = "My Coupons";
  String filterStatus = "All";
  
  List<Map<String, dynamic>> tabs = [
    {"label": "My Coupons", "value": "My Coupons", "count": 8},
    {"label": "Used", "value": "Used", "count": 12},
    {"label": "Expired", "value": "Expired", "count": 5},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Almost Full", "value": "Almost Full"},
  ];

  List<Map<String, dynamic>> myCoupons = [
    {
      "id": "1",
      "title": "Free Delivery",
      "description": "No delivery charges on orders above \$20",
      "discount": "FREE",
      "discountValue": 5.99,
      "category": "Restaurant",
      "brand": "Food Express",
      "code": "FREEDEL20",
      "validUntil": "2024-12-31",
      "daysLeft": 8,
      "minOrder": 20.0,
      "maxDiscount": 5.99,
      "usageCount": 0,
      "maxUsage": 1,
      "status": "Active",
      "savedAt": "2024-12-15",
      "image": "https://picsum.photos/80/80?random=1&keyword=delivery",
      "color": Color(0xFF4CAF50),
      "isExpiring": false,
      "isFavorite": true,
    },
    {
      "id": "2",
      "title": "Birthday Special",
      "description": "Celebrate with 40% off everything",
      "discount": "40% OFF",
      "discountValue": 25.0,
      "category": "Fashion",
      "brand": "Style Zone",
      "code": "BIRTHDAY40",
      "validUntil": "2024-12-25",
      "daysLeft": 3,
      "minOrder": 50.0,
      "maxDiscount": 25.0,
      "usageCount": 0,
      "maxUsage": 1,
      "status": "Expiring Soon",
      "savedAt": "2024-12-10",
      "image": "https://picsum.photos/80/80?random=2&keyword=birthday",
      "color": Color(0xFFE91E63),
      "isExpiring": true,
      "isFavorite": false,
    },
    {
      "id": "3",
      "title": "Tech Discount",
      "description": "Save big on latest electronics",
      "discount": "30% OFF",
      "discountValue": 50.0,
      "category": "Electronics",
      "brand": "ElectroWorld",
      "code": "TECH30",
      "validUntil": "2025-01-15",
      "daysLeft": 25,
      "minOrder": 100.0,
      "maxDiscount": 50.0,
      "usageCount": 0,
      "maxUsage": 1,
      "status": "Active",
      "savedAt": "2024-12-12",
      "image": "https://picsum.photos/80/80?random=3&keyword=electronics",
      "color": Color(0xFF2196F3),
      "isExpiring": false,
      "isFavorite": true,
    },
  ];

  List<Map<String, dynamic>> usedCoupons = [
    {
      "id": "4",
      "title": "Weekend Deal",
      "description": "Special weekend offer",
      "discount": "25% OFF",
      "discountValue": 15.0,
      "category": "Restaurant",
      "brand": "Burger King",
      "code": "WEEKEND25",
      "usedAt": "2024-12-18",
      "orderValue": 60.0,
      "savedAmount": 15.0,
      "image": "https://picsum.photos/80/80?random=4&keyword=burger",
      "color": Color(0xFFFF9800),
    },
    {
      "id": "5",
      "title": "Holiday Sale",
      "description": "Holiday shopping discount",
      "discount": "35% OFF",
      "discountValue": 30.0,
      "category": "Fashion",
      "brand": "Fashion Hub",
      "code": "HOLIDAY35",
      "usedAt": "2024-12-16",
      "orderValue": 85.0,
      "savedAmount": 30.0,
      "image": "https://picsum.photos/80/80?random=5&keyword=fashion",
      "color": Color(0xFF9C27B0),
    },
  ];

  List<Map<String, dynamic>> expiredCoupons = [
    {
      "id": "6",
      "title": "Summer Sale",
      "description": "Summer collection discount",
      "discount": "20% OFF",
      "category": "Fashion",
      "brand": "Summer Store",
      "code": "SUMMER20",
      "expiredAt": "2024-11-30",
      "daysExpired": 20,
      "image": "https://picsum.photos/80/80?random=6&keyword=summer",
      "color": Color(0xFFFF5722),
    },
  ];

  List<Map<String, dynamic>> get currentCoupons {
    if (selectedTab == "My Coupons") {
      var filtered = myCoupons.where((coupon) {
        if (filterStatus == "All") return true;
        return coupon["status"] == filterStatus;
      }).toList();
      
      // Sort by expiring status and days left
      filtered.sort((a, b) {
        if (a["isExpiring"] != b["isExpiring"]) {
          return (a["isExpiring"] as bool) ? -1 : 1;
        }
        return (a["daysLeft"] as int).compareTo(b["daysLeft"] as int);
      });
      
      return filtered;
    } else if (selectedTab == "Used") {
      return usedCoupons;
    } else {
      return expiredCoupons;
    }
  }

  double get totalSavings {
    double total = 0;
    for (var coupon in usedCoupons) {
      total += (coupon["savedAmount"] as double);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Coupons"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Savings Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
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
                        "Total Savings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${totalSavings.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "From ${usedCoupons.length} used coupons",
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Tab Navigation
            Row(
              children: tabs.map((tab) {
                bool isSelected = selectedTab == tab["value"];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      margin: EdgeInsets.only(right: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${tab["label"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withAlpha(30) : primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${tab["count"]}",
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
            
            SizedBox(height: spMd),
            
            // Filter for My Coupons
            if (selectedTab == "My Coupons") ...[
              QHorizontalScroll(
                children: statusFilters.map((filter) {
                  bool isSelected = filterStatus == filter["value"];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        filterStatus = filter["value"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          "${filter["label"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
            ],
            
            // Coupons List
            if (selectedTab == "My Coupons") ...[
              Text(
                "${currentCoupons.length} Active Coupons",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              ...currentCoupons.map((coupon) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: coupon["isExpiring"] as bool 
                        ? Border.all(color: dangerColor.withAlpha(100), width: 2)
                        : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Coupon Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${coupon["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            SizedBox(width: spMd),
                            
                            // Coupon Info
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
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          coupon["isFavorite"] = !(coupon["isFavorite"] as bool);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          coupon["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                                          color: coupon["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
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
                                    "${coupon["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Discount Badge
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: coupon["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${coupon["discount"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                                child: Text(
                                  "${coupon["code"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              QButton(
                                label: "Copy",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Code copied!");
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Validity and Status
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: coupon["isExpiring"] as bool ? dangerColor : successColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${coupon["daysLeft"]} days left",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: coupon["isExpiring"] as bool ? dangerColor : successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Min. order: \$${((coupon["minOrder"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: "Use Now",
                              size: bs.sm,
                              onPressed: () {
                                ss("Redirecting to store...");
                              },
                            ),
                          ],
                        ),
                        
                        // Expiring Warning
                        if (coupon["isExpiring"] as bool) ...[
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: dangerColor.withAlpha(100),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "This coupon expires in ${coupon["daysLeft"]} days!",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
            
            // Used Coupons
            if (selectedTab == "Used") ...[
              Text(
                "Recently Used Coupons",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              ...usedCoupons.map((coupon) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${coupon["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
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
                                "Used on ${coupon["usedAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Saved: \$${((coupon["savedAmount"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Used",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
            
            // Expired Coupons
            if (selectedTab == "Expired") ...[
              Text(
                "Expired Coupons",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              ...expiredCoupons.map((coupon) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.network(
                              "${coupon["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${coupon["brand"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Expired on ${coupon["expiredAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Expired",
                            style: TextStyle(
                              color: dangerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}

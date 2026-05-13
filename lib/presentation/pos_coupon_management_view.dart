import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCouponManagementView extends StatefulWidget {
  const PosCouponManagementView({super.key});

  @override
  State<PosCouponManagementView> createState() => _PosCouponManagementViewState();
}

class _PosCouponManagementViewState extends State<PosCouponManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> coupons = [
    {
      "id": "CPN001",
      "code": "SUMMER30",
      "title": "Summer Sale Coupon",
      "description": "30% off on summer collection items",
      "type": "percentage",
      "discount": 30,
      "status": "active",
      "isPublic": true,
      "usageLimit": 500,
      "usageCount": 234,
      "userLimit": 1,
      "minAmount": 50,
      "maxDiscount": 100,
      "validFrom": "2024-06-01",
      "validTo": "2024-08-31",
      "applicableCategories": ["Clothing", "Accessories"],
      "excludedProducts": [],
      "firstTimeOnly": false,
      "createdBy": "John Doe",
      "createdAt": "2024-05-15",
      "lastUsed": "2024-06-18"
    },
    {
      "id": "CPN002",
      "code": "WELCOME20",
      "title": "Welcome Coupon",
      "description": "20% discount for new customers",
      "type": "percentage",
      "discount": 20,
      "status": "active",
      "isPublic": false,
      "usageLimit": 1000,
      "usageCount": 456,
      "userLimit": 1,
      "minAmount": 25,
      "maxDiscount": 50,
      "validFrom": "2024-01-01",
      "validTo": "2024-12-31",
      "applicableCategories": ["All"],
      "excludedProducts": [],
      "firstTimeOnly": true,
      "createdBy": "Sarah Johnson",
      "createdAt": "2024-01-01",
      "lastUsed": "2024-06-18"
    },
    {
      "id": "CPN003",
      "code": "FIXED50",
      "title": "Fixed Discount Coupon",
      "description": "Get \$50 off on orders above \$200",
      "type": "fixed",
      "discount": 50,
      "status": "scheduled",
      "isPublic": true,
      "usageLimit": 200,
      "usageCount": 0,
      "userLimit": 2,
      "minAmount": 200,
      "maxDiscount": 50,
      "validFrom": "2024-07-01",
      "validTo": "2024-07-31",
      "applicableCategories": ["All"],
      "excludedProducts": ["PROD001", "PROD002"],
      "firstTimeOnly": false,
      "createdBy": "Mike Wilson",
      "createdAt": "2024-06-20",
      "lastUsed": null
    },
    {
      "id": "CPN004",
      "code": "FREESHIP",
      "title": "Free Shipping Coupon",
      "description": "Free shipping on all orders",
      "type": "shipping",
      "discount": 0,
      "status": "active",
      "isPublic": true,
      "usageLimit": 1000,
      "usageCount": 678,
      "userLimit": 5,
      "minAmount": 30,
      "maxDiscount": 15,
      "validFrom": "2024-03-01",
      "validTo": "2024-09-30",
      "applicableCategories": ["All"],
      "excludedProducts": [],
      "firstTimeOnly": false,
      "createdBy": "Emily Brown",
      "createdAt": "2024-02-25",
      "lastUsed": "2024-06-18"
    },
    {
      "id": "CPN005",
      "code": "EXPIRED15",
      "title": "Expired Coupon",
      "description": "15% off - This coupon has expired",
      "type": "percentage",
      "discount": 15,
      "status": "expired",
      "isPublic": false,
      "usageLimit": 300,
      "usageCount": 145,
      "userLimit": 1,
      "minAmount": 40,
      "maxDiscount": 60,
      "validFrom": "2024-01-01",
      "validTo": "2024-05-31",
      "applicableCategories": ["Electronics"],
      "excludedProducts": [],
      "firstTimeOnly": false,
      "createdBy": "Alex Davis",
      "createdAt": "2023-12-15",
      "lastUsed": "2024-05-30"
    }
  ];

  List<Map<String, dynamic>> get filteredCoupons {
    return coupons.where((coupon) {
      bool matchesSearch = "${coupon["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${coupon["code"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || coupon["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || coupon["type"] == selectedType;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return infoColor;
      case "expired":
        return dangerColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String getTypeLabel(String type) {
    switch (type) {
      case "percentage":
        return "Percentage";
      case "fixed":
        return "Fixed Amount";
      case "shipping":
        return "Free Shipping";
      default:
        return type.toUpperCase();
    }
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with coupon code
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${coupon["code"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
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
                        "${coupon["id"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: getStatusColor(coupon["status"]).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${coupon["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(coupon["status"]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
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
                
                // Discount details
                Row(
                  children: [
                    Icon(
                      Icons.local_offer,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      getTypeLabel(coupon["type"]),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (coupon["type"] != "shipping")
                      Text(
                        coupon["type"] == "percentage" 
                            ? "${coupon["discount"]}%" 
                            : "\$${coupon["discount"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    Spacer(),
                    if (coupon["isPublic"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "PUBLIC",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    if (coupon["firstTimeOnly"] == true) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "NEW CUSTOMERS",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                
                // Conditions
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Min Amount: \$${coupon["minAmount"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if (coupon["maxDiscount"] != null)
                            Text(
                              "Max Discount: \$${coupon["maxDiscount"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Usage per user: ${coupon["userLimit"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Validity and usage
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${coupon["validFrom"]} - ${coupon["validTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Used: ${coupon["usageCount"]}/${coupon["usageLimit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (coupon["usageCount"] as int) / (coupon["usageLimit"] as int),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          // Edit coupon logic
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: coupon["status"] == "active" ? "Pause" : "Activate",
                        size: bs.sm,
                        onPressed: () {
                          // Toggle coupon status
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.copy,
                      size: bs.sm,
                      onPressed: () {
                        // Copy coupon code
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
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
  }

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${coupons.where((c) => c["status"] == "active").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${coupons.where((c) => c["isPublic"] == true).length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Public",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${coupons.fold(0, (sum, c) => sum + (c["usageCount"] as int))}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new coupon
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search coupons...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Scheduled", "value": "scheduled"},
                      {"label": "Expired", "value": "expired"},
                      {"label": "Paused", "value": "paused"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: [
                      {"label": "All Types", "value": "all"},
                      {"label": "Percentage", "value": "percentage"},
                      {"label": "Fixed Amount", "value": "fixed"},
                      {"label": "Free Shipping", "value": "shipping"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Coupons list
            Text(
              "Coupons (${filteredCoupons.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredCoupons.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No coupons found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredCoupons.map((coupon) => _buildCouponCard(coupon)),
          ],
        ),
      ),
    );
  }
}

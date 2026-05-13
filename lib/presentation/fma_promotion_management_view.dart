import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPromotionManagementView extends StatefulWidget {
  const FmaPromotionManagementView({super.key});

  @override
  State<FmaPromotionManagementView> createState() => _FmaPromotionManagementViewState();
}

class _FmaPromotionManagementViewState extends State<FmaPromotionManagementView> {
  int currentTab = 0;
  
  // Active Promotions Variables
  String promoTitle = "";
  String promoDescription = "";
  String promoType = "percentage";
  String discountValue = "";
  String minimumOrder = "";
  String maxDiscount = "";
  String promoCode = "";
  String startDate = "";
  String endDate = "";
  String targetAudience = "all";
  List<String> selectedMenuItems = [];
  bool isActive = true;
  
  // Coupon Variables
  String couponCode = "";
  String couponDescription = "";
  String couponType = "fixed";
  String couponValue = "";
  String usageLimit = "";
  bool isFirstTimeOnly = false;
  bool allowMultipleUse = false;
  
  // Loyalty Variables
  String loyaltyRuleName = "";
  String pointsPerDollar = "1";
  String redemptionRate = "100";
  String bonusCondition = "birthday";
  String bonusPoints = "50";
  
  // Flash Sale Variables
  String flashSaleTitle = "";
  String flashSaleDiscount = "";
  String flashSaleDuration = "60";
  String notificationTime = "15";
  bool autoStart = false;
  
  // Sample Data
  List<Map<String, dynamic>> promotions = [
    {
      "id": 1,
      "title": "Summer Special",
      "description": "20% off on all cold drinks and ice creams",
      "type": "percentage",
      "discount": 20.0,
      "code": "SUMMER20",
      "start_date": "2024-06-01",
      "end_date": "2024-08-31",
      "status": "active",
      "usage_count": 145,
      "revenue": 2850.50,
      "target": "all",
      "minimum_order": 25.0
    },
    {
      "id": 2,
      "title": "Lunch Hour Deal",
      "description": "Buy 2 get 1 free on selected lunch items",
      "type": "buy_x_get_y",
      "discount": 0.0,
      "code": "LUNCH2FOR1",
      "start_date": "2024-06-15",
      "end_date": "2024-06-30",
      "status": "active",
      "usage_count": 89,
      "revenue": 1320.75,
      "target": "lunch_items",
      "minimum_order": 0.0
    },
    {
      "id": 3,
      "title": "First Time Customer",
      "description": "15% off for new customers",
      "type": "percentage",
      "discount": 15.0,
      "code": "WELCOME15",
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "status": "active",
      "usage_count": 267,
      "revenue": 4250.25,
      "target": "new_customers",
      "minimum_order": 20.0
    },
    {
      "id": 4,
      "title": "Weekend Boost",
      "description": "\$5 off orders above \$30 on weekends",
      "type": "fixed",
      "discount": 5.0,
      "code": "WEEKEND5",
      "start_date": "2024-06-01",
      "end_date": "2024-07-31",
      "status": "paused",
      "usage_count": 156,
      "revenue": 1890.00,
      "target": "weekend",
      "minimum_order": 30.0
    },
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "id": 1,
      "code": "SAVE10",
      "description": "\$10 off orders above \$50",
      "type": "fixed",
      "value": 10.0,
      "usage_count": 45,
      "usage_limit": 100,
      "created_date": "2024-06-01",
      "expiry_date": "2024-06-30",
      "is_active": true,
      "first_time_only": false
    },
    {
      "id": 2,
      "code": "NEWBIE25",
      "description": "25% off for first-time customers",
      "type": "percentage",
      "value": 25.0,
      "usage_count": 89,
      "usage_limit": 200,
      "created_date": "2024-05-15",
      "expiry_date": "2024-12-31",
      "is_active": true,
      "first_time_only": true
    },
    {
      "id": 3,
      "code": "FAMILY15",
      "description": "15% off family meals",
      "type": "percentage",
      "value": 15.0,
      "usage_count": 67,
      "usage_limit": 150,
      "created_date": "2024-06-10",
      "expiry_date": "2024-07-10",
      "is_active": true,
      "first_time_only": false
    },
    {
      "id": 4,
      "code": "BIRTHDAY20",
      "description": "\$20 off birthday celebrations",
      "type": "fixed",
      "value": 20.0,
      "usage_count": 23,
      "usage_limit": 50,
      "created_date": "2024-06-01",
      "expiry_date": "2024-06-30",
      "is_active": false,
      "first_time_only": false
    },
  ];

  List<Map<String, dynamic>> loyaltyPrograms = [
    {
      "id": 1,
      "name": "VIP Rewards",
      "points_per_dollar": 2,
      "redemption_rate": 100,
      "active_members": 450,
      "total_points_issued": 125000,
      "total_points_redeemed": 89000,
      "average_balance": 285,
      "status": "active"
    },
    {
      "id": 2,
      "name": "Birthday Bonus",
      "points_per_dollar": 0,
      "redemption_rate": 50,
      "active_members": 1200,
      "total_points_issued": 60000,
      "total_points_redeemed": 45000,
      "average_balance": 125,
      "status": "active"
    },
    {
      "id": 3,
      "name": "Referral Rewards",
      "points_per_dollar": 0,
      "redemption_rate": 200,
      "active_members": 320,
      "total_points_issued": 64000,
      "total_points_redeemed": 38000,
      "average_balance": 385,
      "status": "active"
    },
  ];

  List<Map<String, dynamic>> flashSales = [
    {
      "id": 1,
      "title": "Happy Hour Special",
      "discount": 30.0,
      "start_time": "15:00",
      "end_time": "17:00",
      "duration": 120,
      "items_sold": 87,
      "revenue": 1450.25,
      "status": "completed",
      "date": "2024-06-18"
    },
    {
      "id": 2,
      "title": "Midnight Munchies",
      "discount": 25.0,
      "start_time": "22:00",
      "end_time": "24:00",
      "duration": 120,
      "items_sold": 23,
      "revenue": 425.50,
      "status": "scheduled",
      "date": "2024-06-20"
    },
    {
      "id": 3,
      "title": "Weekend Flash Sale",
      "discount": 40.0,
      "start_time": "12:00",
      "end_time": "14:00",
      "duration": 120,
      "items_sold": 156,
      "revenue": 2850.75,
      "status": "completed",
      "date": "2024-06-16"
    },
    {
      "id": 4,
      "title": "Coffee Rush",
      "discount": 20.0,
      "start_time": "07:00",
      "end_time": "09:00",
      "duration": 120,
      "items_sold": 0,
      "revenue": 0.0,
      "status": "active",
      "date": "2024-06-19"
    },
  ];

  List<Map<String, dynamic>> promoTypeOptions = [
    {"label": "Percentage Discount", "value": "percentage"},
    {"label": "Fixed Amount Off", "value": "fixed"},
    {"label": "Buy X Get Y", "value": "buy_x_get_y"},
    {"label": "Free Shipping", "value": "free_shipping"},
  ];

  List<Map<String, dynamic>> audienceOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "New Customers", "value": "new_customers"},
    {"label": "VIP Customers", "value": "vip"},
    {"label": "Lunch Items", "value": "lunch_items"},
    {"label": "Weekend Diners", "value": "weekend"},
    {"label": "Mobile App Users", "value": "mobile_users"},
  ];

  List<Map<String, dynamic>> couponTypeOptions = [
    {"label": "Fixed Amount", "value": "fixed"},
    {"label": "Percentage", "value": "percentage"},
    {"label": "Free Item", "value": "free_item"},
    {"label": "Free Delivery", "value": "free_delivery"},
  ];

  List<Map<String, dynamic>> bonusConditions = [
    {"label": "Customer Birthday", "value": "birthday"},
    {"label": "Order Above Amount", "value": "order_amount"},
    {"label": "Frequency Bonus", "value": "frequency"},
    {"label": "Referral Bonus", "value": "referral"},
  ];

  void _createPromotion() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Promotion '${promoTitle}' created successfully");
    
    // Reset form
    promoTitle = "";
    promoDescription = "";
    promoType = "percentage";
    discountValue = "";
    minimumOrder = "";
    maxDiscount = "";
    promoCode = "";
    startDate = "";
    endDate = "";
    targetAudience = "all";
    selectedMenuItems = [];
    isActive = true;
    setState(() {});
  }

  void _createCoupon() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Coupon '${couponCode}' created successfully");
    
    // Reset form
    couponCode = "";
    couponDescription = "";
    couponType = "fixed";
    couponValue = "";
    usageLimit = "";
    isFirstTimeOnly = false;
    allowMultipleUse = false;
    setState(() {});
  }

  void _createLoyaltyRule() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Loyalty rule '${loyaltyRuleName}' created successfully");
    
    // Reset form
    loyaltyRuleName = "";
    pointsPerDollar = "1";
    redemptionRate = "100";
    bonusCondition = "birthday";
    bonusPoints = "50";
    setState(() {});
  }

  void _createFlashSale() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Flash sale '${flashSaleTitle}' ${autoStart ? "started" : "scheduled"} successfully");
    
    // Reset form
    flashSaleTitle = "";
    flashSaleDiscount = "";
    flashSaleDuration = "60";
    notificationTime = "15";
    autoStart = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Promotion Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Promotions", icon: Icon(Icons.local_offer)),
        Tab(text: "Coupons", icon: Icon(Icons.confirmation_number)),
        Tab(text: "Loyalty", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Flash Sales", icon: Icon(Icons.flash_on)),
      ],
      tabChildren: [
        _buildPromotionsTab(),
        _buildCouponsTab(),
        _buildLoyaltyTab(),
        _buildFlashSalesTab(),
      ],
    );
  }

  Widget _buildPromotionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Promotion Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Active Promotions", "${promotions.where((p) => p["status"] == "active").length}", Icons.local_offer, primaryColor),
              _buildStatCard("Total Usage", "${promotions.fold(0, (sum, p) => sum + (p["usage_count"] as int))}", Icons.redeem, successColor),
              _buildStatCard("Total Revenue", "\$${(promotions.fold(0.0, (sum, p) => sum + (p["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Discount", "${(promotions.fold(0.0, (sum, p) => sum + (p["discount"] as double)) / promotions.length).toStringAsFixed(1)}%", Icons.percent, infoColor),
            ],
          ),

          // Create Promotion Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create New Promotion",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Promotion Title",
                        value: promoTitle,
                        hint: "Enter promotion title",
                        onChanged: (value) {
                          promoTitle = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Promo Code",
                        value: promoCode,
                        hint: "Enter promo code",
                        onChanged: (value) {
                          promoCode = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Promotion Description",
                  value: promoDescription,
                  hint: "Describe the promotion details",
                  onChanged: (value) {
                    promoDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Promotion Type",
                        items: promoTypeOptions,
                        value: promoType,
                        onChanged: (value, label) {
                          promoType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: promoType == "percentage" ? "Discount %" : "Discount Amount",
                        value: discountValue,
                        onChanged: (value) {
                          discountValue = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Minimum Order (\$)",
                        value: minimumOrder,
                        onChanged: (value) {
                          minimumOrder = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Max Discount (\$)",
                        value: maxDiscount,
                        onChanged: (value) {
                          maxDiscount = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Start Date",
                        value: startDate.isNotEmpty 
                            ? DateTime.parse(startDate) 
                            : DateTime.now(),
                        onChanged: (value) {
                          startDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDatePicker(
                        label: "End Date",
                        value: endDate.isNotEmpty 
                            ? DateTime.parse(endDate) 
                            : DateTime.now().add(Duration(days: 30)),
                        onChanged: (value) {
                          endDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QDropdownField(
                  label: "Target Audience",
                  items: audienceOptions,
                  value: targetAudience,
                  onChanged: (value, label) {
                    targetAudience = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Activate immediately",
                            "value": true,
                            "checked": isActive,
                          }
                        ],
                        value: [
                          if (isActive)
                            {
                              "label": "Activate immediately",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isActive = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Promotion",
                        icon: Icons.add,
                        onPressed: _createPromotion,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Active Promotions List
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Current Promotions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...promotions.map((promo) {
                  Color statusColor = promo["status"] == "active" 
                      ? successColor 
                      : promo["status"] == "scheduled"
                          ? warningColor 
                          : disabledBoldColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${promo["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${promo["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${promo["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${promo["code"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${promo["type"] == "percentage" ? "${(promo["discount"] as double).toStringAsFixed(0)}%" : "\$${(promo["discount"] as double).currency}"} off",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.redeem, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(promo["usage_count"] as int).toString()} uses",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.attach_money, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "\$${(promo["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${promo["start_date"]} - ${promo["end_date"]}",
                              style: TextStyle(fontSize: 10, color: disabledBoldColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () => si("Editing promotion: ${promo["title"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: promo["status"] == "active" ? "Pause" : "Activate",
                              size: bs.sm,
                              onPressed: () => si("${promo["status"] == "active" ? "Paused" : "Activated"} promotion"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.analytics,
                              size: bs.sm,
                              onPressed: () => si("Viewing promotion analytics"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Coupon Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Active Coupons", "${coupons.where((c) => c["is_active"] == true).length}", Icons.confirmation_number, primaryColor),
              _buildStatCard("Total Uses", "${coupons.fold(0, (sum, c) => sum + (c["usage_count"] as int))}", Icons.redeem, successColor),
              _buildStatCard("Usage Rate", "${((coupons.fold(0, (sum, c) => sum + (c["usage_count"] as int)) / coupons.fold(0, (sum, c) => sum + (c["usage_limit"] as int))) * 100).toStringAsFixed(1)}%", Icons.trending_up, infoColor),
              _buildStatCard("Total Savings", "\$${(coupons.fold(0.0, (sum, c) => sum + ((c["usage_count"] as int) * (c["value"] as double)))).currency}", Icons.savings, warningColor),
            ],
          ),

          // Create Coupon Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create New Coupon",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Coupon Code",
                        value: couponCode,
                        hint: "Enter coupon code",
                        onChanged: (value) {
                          couponCode = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Coupon Type",
                        items: couponTypeOptions,
                        value: couponType,
                        onChanged: (value, label) {
                          couponType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Coupon Description",
                  value: couponDescription,
                  hint: "Describe how the coupon works",
                  onChanged: (value) {
                    couponDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: couponType == "percentage" ? "Discount %" : "Discount Amount (\$)",
                        value: couponValue,
                        onChanged: (value) {
                          couponValue = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Usage Limit",
                        value: usageLimit,
                        onChanged: (value) {
                          usageLimit = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "First-time customers only",
                            "value": true,
                            "checked": isFirstTimeOnly,
                          }
                        ],
                        value: [
                          if (isFirstTimeOnly)
                            {
                              "label": "First-time customers only",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isFirstTimeOnly = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Allow multiple uses per customer",
                            "value": true,
                            "checked": allowMultipleUse,
                          }
                        ],
                        value: [
                          if (allowMultipleUse)
                            {
                              "label": "Allow multiple uses per customer",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          allowMultipleUse = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Coupon",
                        icon: Icons.add,
                        onPressed: _createCoupon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Coupons List
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Active Coupons",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...coupons.map((coupon) {
                  Color statusColor = coupon["is_active"] == true 
                      ? successColor 
                      : disabledBoldColor;
                  
                  double usagePercentage = ((coupon["usage_count"] as int) / (coupon["usage_limit"] as int)) * 100;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${coupon["code"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                coupon["is_active"] == true ? "ACTIVE" : "INACTIVE",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
                            Text(
                              "${coupon["type"] == "percentage" ? "${(coupon["value"] as double).toStringAsFixed(0)}%" : "\$${(coupon["value"] as double).currency}"} discount",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (coupon["first_time_only"] == true) ...[
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "FIRST TIME",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Usage: ${(coupon["usage_count"] as int).toString()}/${(coupon["usage_limit"] as int).toString()}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: usagePercentage / 100,
                                    backgroundColor: disabledOutlineBorderColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      usagePercentage > 80 ? dangerColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${usagePercentage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: usagePercentage > 80 ? dangerColor : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () => si("Editing coupon: ${coupon["code"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: coupon["is_active"] == true ? "Deactivate" : "Activate",
                              size: bs.sm,
                              onPressed: () => si("${coupon["is_active"] == true ? "Deactivated" : "Activated"} coupon"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Loyalty Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Members", "${loyaltyPrograms.fold(0, (sum, l) => sum + (l["active_members"] as int))}", Icons.people, primaryColor),
              _buildStatCard("Points Issued", "${loyaltyPrograms.fold(0, (sum, l) => sum + (l["total_points_issued"] as int))}", Icons.add_circle, successColor),
              _buildStatCard("Points Redeemed", "${loyaltyPrograms.fold(0, (sum, l) => sum + (l["total_points_redeemed"] as int))}", Icons.redeem, warningColor),
              _buildStatCard("Avg. Balance", "${(loyaltyPrograms.fold(0, (sum, l) => sum + (l["average_balance"] as int)) / loyaltyPrograms.length).toStringAsFixed(0)} pts", Icons.account_balance_wallet, infoColor),
            ],
          ),

          // Create Loyalty Rule Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create Loyalty Rule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Rule Name",
                  value: loyaltyRuleName,
                  hint: "Enter loyalty rule name",
                  onChanged: (value) {
                    loyaltyRuleName = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Points per Dollar",
                        value: pointsPerDollar,
                        onChanged: (value) {
                          pointsPerDollar = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Redemption Rate (pts per \$1)",
                        value: redemptionRate,
                        onChanged: (value) {
                          redemptionRate = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Bonus Condition",
                        items: bonusConditions,
                        value: bonusCondition,
                        onChanged: (value, label) {
                          bonusCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Bonus Points",
                        value: bonusPoints,
                        onChanged: (value) {
                          bonusPoints = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Rule",
                        icon: Icons.add,
                        onPressed: _createLoyaltyRule,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Loyalty Programs List
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Loyalty Programs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...loyaltyPrograms.map((program) {
                  double redemptionRate = ((program["total_points_redeemed"] as int) / (program["total_points_issued"] as int)) * 100;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${program["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${program["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 150,
                          children: [
                            _buildLoyaltyMetric("Members", "${(program["active_members"] as int).toString()}", Icons.people),
                            _buildLoyaltyMetric("Points Issued", "${(program["total_points_issued"] as int).toString()}", Icons.add_circle),
                            _buildLoyaltyMetric("Points Redeemed", "${(program["total_points_redeemed"] as int).toString()}", Icons.redeem),
                            _buildLoyaltyMetric("Avg. Balance", "${(program["average_balance"] as int).toString()}", Icons.account_balance_wallet),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Redemption Rate: ${redemptionRate.toStringAsFixed(1)}%",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: redemptionRate / 100,
                                    backgroundColor: disabledOutlineBorderColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () => si("Viewing program: ${program["name"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => si("Editing program"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSalesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Flash Sale Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Sales", "${flashSales.length}", Icons.flash_on, primaryColor),
              _buildStatCard("Items Sold", "${flashSales.fold(0, (sum, f) => sum + (f["items_sold"] as int))}", Icons.shopping_cart, successColor),
              _buildStatCard("Total Revenue", "\$${(flashSales.fold(0.0, (sum, f) => sum + (f["revenue"] as double))).currency}", Icons.attach_money, warningColor),
              _buildStatCard("Avg. Discount", "${(flashSales.fold(0.0, (sum, f) => sum + (f["discount"] as double)) / flashSales.length).toStringAsFixed(1)}%", Icons.percent, infoColor),
            ],
          ),

          // Create Flash Sale Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create Flash Sale",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Flash Sale Title",
                        value: flashSaleTitle,
                        hint: "Enter flash sale title",
                        onChanged: (value) {
                          flashSaleTitle = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Discount %",
                        value: flashSaleDiscount,
                        onChanged: (value) {
                          flashSaleDiscount = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Duration (minutes)",
                        value: flashSaleDuration,
                        onChanged: (value) {
                          flashSaleDuration = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Notify customers (minutes before)",
                        value: notificationTime,
                        onChanged: (value) {
                          notificationTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Start immediately",
                            "value": true,
                            "checked": autoStart,
                          }
                        ],
                        value: [
                          if (autoStart)
                            {
                              "label": "Start immediately",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          autoStart = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: autoStart ? "Start Flash Sale" : "Schedule Flash Sale",
                        icon: Icons.flash_on,
                        onPressed: _createFlashSale,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Flash Sales List
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Flash Sale History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...flashSales.map((sale) {
                  Color statusColor = sale["status"] == "active" 
                      ? successColor 
                      : sale["status"] == "scheduled"
                          ? warningColor 
                          : disabledBoldColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${sale["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${sale["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "${(sale["discount"] as double).toStringAsFixed(0)}% off",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${sale["start_time"]} - ${sale["end_time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${sale["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        if (sale["status"] == "completed") ...[
                          Row(
                            children: [
                              Icon(Icons.shopping_cart, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${(sale["items_sold"] as int).toString()} items sold",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "\$${(sale["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],

                        Row(
                          children: [
                            Spacer(),
                            if (sale["status"] == "active") ...[
                              QButton(
                                label: "End Sale",
                                size: bs.sm,
                                onPressed: () => si("Flash sale ended"),
                              ),
                              SizedBox(width: spXs),
                            ],
                            if (sale["status"] == "scheduled") ...[
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () => si("Editing flash sale"),
                              ),
                              SizedBox(width: spXs),
                            ],
                            QButton(
                              icon: Icons.analytics,
                              size: bs.sm,
                              onPressed: () => si("Viewing sale analytics"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

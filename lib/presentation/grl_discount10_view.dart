import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount10View extends StatefulWidget {
  @override
  State<GrlDiscount10View> createState() => _GrlDiscount10ViewState();
}

class _GrlDiscount10ViewState extends State<GrlDiscount10View> {
  String selectedFilter = "All Rewards";
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Rewards", "value": "All Rewards"},
    {"label": "Available", "value": "Available"},
    {"label": "Redeemed", "value": "Redeemed"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "id": 1,
      "title": "20% Off Next Purchase",
      "description": "Get 20% discount on your next order of \$50 or more",
      "pointsRequired": 500,
      "discountValue": "20%",
      "minPurchase": 50.0,
      "category": "Discount",
      "validUntil": "Dec 31, 2024",
      "isRedeemed": false,
      "isExpired": false,
      "icon": Icons.local_offer,
      "color": primaryColor,
      "termsAndConditions": [
        "Valid for one-time use only",
        "Cannot be combined with other offers",
        "Minimum purchase of \$50 required",
        "Valid on all product categories",
      ],
    },
    {
      "id": 2,
      "title": "Free Shipping Voucher",
      "description": "Enjoy free shipping on any order, no minimum required",
      "pointsRequired": 200,
      "discountValue": "Free",
      "minPurchase": 0.0,
      "category": "Shipping",
      "validUntil": "Jan 15, 2025",
      "isRedeemed": true,
      "isExpired": false,
      "icon": Icons.local_shipping,
      "color": successColor,
      "termsAndConditions": [
        "Valid for standard shipping only",
        "Cannot be used for express delivery",
        "Valid for domestic orders only",
      ],
    },
    {
      "id": 3,
      "title": "\$10 Store Credit",
      "description": "Get \$10 credit to use on any future purchase",
      "pointsRequired": 1000,
      "discountValue": "\$10",
      "minPurchase": 0.0,
      "category": "Credit",
      "validUntil": "Mar 30, 2025",
      "isRedeemed": false,
      "isExpired": false,
      "icon": Icons.account_balance_wallet,
      "color": infoColor,
      "termsAndConditions": [
        "Credit expires 90 days after redemption",
        "Can be used on multiple orders",
        "Non-transferable and non-refundable",
      ],
    },
    {
      "id": 4,
      "title": "Buy 2 Get 1 Free",
      "description": "Purchase any 2 items and get the lowest priced one free",
      "pointsRequired": 750,
      "discountValue": "BOGO",
      "minPurchase": 25.0,
      "category": "Promotion",
      "validUntil": "Aug 15, 2024",
      "isRedeemed": false,
      "isExpired": true,
      "icon": Icons.card_giftcard,
      "color": warningColor,
      "termsAndConditions": [
        "Applies to items of equal or lesser value",
        "Valid on selected categories only",
        "Cannot be combined with other promotions",
      ],
    },
    {
      "id": 5,
      "title": "VIP Early Access",
      "description": "Get 24-hour early access to flash sales and new arrivals",
      "pointsRequired": 1500,
      "discountValue": "VIP",
      "minPurchase": 0.0,
      "category": "Access",
      "validUntil": "Dec 31, 2024",
      "isRedeemed": false,
      "isExpired": false,
      "icon": Icons.star,
      "color": warningColor,
      "termsAndConditions": [
        "Valid for 30 days from redemption",
        "Applies to participating sales only",
        "One-time redemption per customer",
      ],
    },
  ];

  int get currentPoints => 2150;

  List<Map<String, dynamic>> get filteredRewards {
    switch (selectedFilter) {
      case "Available":
        return rewards.where((r) => !(r["isRedeemed"] as bool) && !(r["isExpired"] as bool)).toList();
      case "Redeemed":
        return rewards.where((r) => r["isRedeemed"] as bool).toList();
      case "Expired":
        return rewards.where((r) => r["isExpired"] as bool).toList();
      default:
        return rewards;
    }
  }

  void _redeemReward(Map<String, dynamic> reward) async {
    if ((reward["pointsRequired"] as int) > currentPoints) {
      se("Insufficient points to redeem this reward");
      return;
    }

    bool isConfirmed = await confirm("Redeem this reward for ${reward["pointsRequired"]} points?");
    if (isConfirmed) {
      reward["isRedeemed"] = true;
      setState(() {});
      ss("Reward redeemed successfully!");
    }
  }

  void _showRewardDetails(Map<String, dynamic> reward) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Reward header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (reward["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    reward["icon"] as IconData,
                    color: reward["color"] as Color,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${reward["title"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${reward["category"]}",
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
            SizedBox(height: spMd),

            // Description
            Text(
              "${reward["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),

            // Reward details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (reward["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Points Required:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${reward["pointsRequired"]} pts",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if ((reward["minPurchase"] as double) > 0)
                    Column(
                      children: [
                        SizedBox(height: spXs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Minimum Purchase:",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((reward["minPurchase"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Valid Until:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${reward["validUntil"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Terms and conditions
            Text(
              "Terms & Conditions:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spXs,
              children: (reward["termsAndConditions"] as List).map((term) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$term",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Action button
            if (!(reward["isRedeemed"] as bool) && !(reward["isExpired"] as bool))
              QButton(
                label: "Redeem for ${reward["pointsRequired"]} Points",
                size: bs.md,
                onPressed: () {
                  back();
                  _redeemReward(reward);
                },
              )
            else if (reward["isRedeemed"] as bool)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor),
                ),
                child: Text(
                  "Already Redeemed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledColor),
                ),
                child: Text(
                  "Expired",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: disabledColor,
                  ),
                ),
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
        title: Text("Reward Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points balance card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Points Balance",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                            Text(
                              "${currentPoints.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Points",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Earn more points with every purchase",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Filter dropdown
            Row(
              children: [
                Text(
                  "Filter:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Stats row
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
                          "${rewards.where((r) => !(r["isRedeemed"] as bool) && !(r["isExpired"] as bool)).length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
                          "${rewards.where((r) => r["isRedeemed"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Redeemed",
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
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${rewards.where((r) => r["isExpired"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: disabledColor,
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
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Rewards list
            if (filteredRewards.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.card_giftcard,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No rewards found",
                      style: TextStyle(
                        fontSize: 18,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try changing your filter selection",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                spacing: spMd,
                children: filteredRewards.map((reward) {
                  bool canRedeem = !(reward["isRedeemed"] as bool) && 
                                  !(reward["isExpired"] as bool) && 
                                  (reward["pointsRequired"] as int) <= currentPoints;
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: (reward["isExpired"] as bool) 
                            ? disabledColor 
                            : (reward["isRedeemed"] as bool)
                                ? successColor
                                : (reward["color"] as Color).withAlpha(100),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with status
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                      ? disabledColor.withAlpha(30)
                                      : (reward["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  reward["icon"] as IconData,
                                  color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                      ? disabledColor
                                      : reward["color"] as Color,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${reward["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                                  ? disabledColor
                                                  : primaryColor,
                                            ),
                                          ),
                                        ),
                                        if (reward["isRedeemed"] as bool)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "REDEEMED",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        else if (reward["isExpired"] as bool)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: disabledColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "EXPIRED",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      "${reward["category"]}",
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
                          SizedBox(height: spSm),

                          // Description
                          Text(
                            "${reward["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                  ? disabledColor
                                  : disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),

                          // Points and value
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                      ? disabledColor.withAlpha(30)
                                      : primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.stars,
                                      size: 16,
                                      color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                          ? disabledColor
                                          : primaryColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${reward["pointsRequired"]} pts",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                            ? disabledColor
                                            : primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                      ? disabledColor.withAlpha(30)
                                      : (reward["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${reward["discountValue"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: (reward["isExpired"] as bool) || (reward["isRedeemed"] as bool)
                                        ? disabledColor
                                        : reward["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Valid until
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: disabledColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Valid until ${reward["validUntil"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () => _showRewardDetails(reward),
                                ),
                              ),
                              SizedBox(width: spSm),
                              if (canRedeem)
                                Expanded(
                                  child: QButton(
                                    label: "Redeem",
                                    size: bs.sm,
                                    onPressed: () => _redeemReward(reward),
                                  ),
                                )
                              else if (!(reward["isRedeemed"] as bool) && !(reward["isExpired"] as bool))
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(color: disabledColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Need ${(reward["pointsRequired"] as int) - currentPoints} more pts",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

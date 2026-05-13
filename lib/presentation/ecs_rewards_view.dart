import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRewardsView extends StatefulWidget {
  const EcsRewardsView({super.key});

  @override
  State<EcsRewardsView> createState() => _EcsRewardsViewState();
}

class _EcsRewardsViewState extends State<EcsRewardsView> {
  int currentTab = 0;
  int availablePoints = 2850;
  
  List<Map<String, dynamic>> featuredRewards = [
    {
      "id": 1,
      "title": "iPhone 15 Pro",
      "description": "Latest iPhone with 256GB storage",
      "pointsCost": 50000,
      "originalPrice": 1199.99,
      "category": "Electronics",
      "image": "https://picsum.photos/400/400?random=1&keyword=iphone",
      "isFeatured": true,
      "isLimited": true,
      "stock": 5,
      "validDays": 30,
      "rating": 4.9,
      "reviews": 2456,
    },
    {
      "id": 2,
      "title": "Luxury Spa Weekend",
      "description": "2-night spa retreat for two people",
      "pointsCost": 25000,
      "originalPrice": 599.99,
      "category": "Experience",
      "image": "https://picsum.photos/400/400?random=2&keyword=spa",
      "isFeatured": true,
      "isLimited": false,
      "stock": 0,
      "validDays": 90,
      "rating": 4.8,
      "reviews": 856,
    },
    {
      "id": 3,
      "title": "Gaming Setup Bundle",
      "description": "Complete gaming setup with monitor, keyboard, and mouse",
      "pointsCost": 35000,
      "originalPrice": 899.99,
      "category": "Electronics",
      "image": "https://picsum.photos/400/400?random=3&keyword=gaming",
      "isFeatured": true,
      "isLimited": true,
      "stock": 12,
      "validDays": 60,
      "rating": 4.7,
      "reviews": 1234,
    },
  ];

  List<Map<String, dynamic>> allRewards = [
    {
      "id": 4,
      "title": "\$100 Gift Card",
      "description": "Universal gift card for any purchase",
      "pointsCost": 10000,
      "originalPrice": 100.0,
      "category": "Gift Cards",
      "image": "https://picsum.photos/400/400?random=4&keyword=giftcard",
      "isFeatured": false,
      "isLimited": false,
      "stock": 0,
      "validDays": 365,
      "rating": 4.9,
      "reviews": 3456,
    },
    {
      "id": 5,
      "title": "Wireless Headphones",
      "description": "Premium noise-canceling headphones",
      "pointsCost": 8500,
      "originalPrice": 249.99,
      "category": "Electronics",
      "image": "https://picsum.photos/400/400?random=5&keyword=headphones",
      "isFeatured": false,
      "isLimited": false,
      "stock": 0,
      "validDays": 30,
      "rating": 4.6,
      "reviews": 789,
    },
    {
      "id": 6,
      "title": "Fitness Tracker",
      "description": "Advanced fitness tracking smartwatch",
      "pointsCost": 12000,
      "originalPrice": 299.99,
      "category": "Electronics",
      "image": "https://picsum.photos/400/400?random=6&keyword=fitness",
      "isFeatured": false,
      "isLimited": true,
      "stock": 8,
      "validDays": 45,
      "rating": 4.5,
      "reviews": 567,
    },
    {
      "id": 7,
      "title": "Coffee Machine Deluxe",
      "description": "Professional espresso machine for home",
      "pointsCost": 15000,
      "originalPrice": 399.99,
      "category": "Home",
      "image": "https://picsum.photos/400/400?random=7&keyword=coffee",
      "isFeatured": false,
      "isLimited": false,
      "stock": 0,
      "validDays": 60,
      "rating": 4.7,
      "reviews": 445,
    },
    {
      "id": 8,
      "title": "Designer Handbag",
      "description": "Limited edition luxury handbag",
      "pointsCost": 20000,
      "originalPrice": 549.99,
      "category": "Fashion",
      "image": "https://picsum.photos/400/400?random=8&keyword=handbag",
      "isFeatured": false,
      "isLimited": true,
      "stock": 3,
      "validDays": 30,
      "rating": 4.8,
      "reviews": 234,
    },
  ];

  List<Map<String, dynamic>> myRewards = [
    {
      "id": 101,
      "title": "\$50 Gift Card",
      "description": "Redeemed gift card",
      "pointsUsed": 5000,
      "redeemedDate": "2025-06-10",
      "status": "active",
      "validUntil": "2026-06-10",
      "code": "GC50-ABC123",
      "usedAmount": 25.0,
      "remainingValue": 25.0,
    },
    {
      "id": 102,
      "title": "Free Shipping Voucher",
      "description": "Free shipping on any order",
      "pointsUsed": 500,
      "redeemedDate": "2025-06-08",
      "status": "used",
      "validUntil": "2025-06-22",
      "code": "SHIP-DEF456",
      "usedAmount": 0.0,
      "remainingValue": 0.0,
    },
    {
      "id": 103,
      "title": "\$20 Discount Voucher",
      "description": "Discount voucher for electronics",
      "pointsUsed": 2000,
      "redeemedDate": "2025-05-25",
      "status": "expired",
      "validUntil": "2025-06-01",
      "code": "DISC-GHI789",
      "usedAmount": 0.0,
      "remainingValue": 0.0,
    },
  ];

  String selectedCategory = "All";
  List<String> categories = ["All", "Electronics", "Gift Cards", "Experience", "Fashion", "Home"];

  List<Map<String, dynamic>> get filteredRewards {
    List<Map<String, dynamic>> combined = [...featuredRewards, ...allRewards];
    if (selectedCategory == "All") {
      return combined;
    }
    return combined.where((reward) => reward["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rewards Store",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.store)),
        Tab(text: "My Rewards", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Featured", icon: Icon(Icons.star)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildMyRewardsTab(),
        _buildFeaturedTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildRewardsHeader(),
          _buildPointsBalance(),
          _buildCategoryFilter(),
          _buildRewardsGrid(),
        ],
      ),
    );
  }

  Widget _buildMyRewardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildMyRewardsStats(),
          _buildActiveRewards(),
          _buildRewardsHistory(),
        ],
      ),
    );
  }

  Widget _buildFeaturedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildFeaturedHeader(),
          _buildFeaturedRewardsGrid(),
          _buildLimitedTimeOffers(),
        ],
      ),
    );
  }

  Widget _buildRewardsHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(180),
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
              Icon(Icons.store, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Text(
                "Rewards Store",
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
            "Turn your points into amazing rewards",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Exclusive items and experiences await",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsBalance() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: successColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Points",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${availablePoints.toString()}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              //navigateTo EcsLoyaltyPointsView
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Earn More",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: categories.map((category) {
            bool isSelected = selectedCategory == category;
            return GestureDetector(
              onTap: () {
                selectedCategory = category;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
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
    );
  }

  Widget _buildRewardsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredRewards.map((reward) {
        return _buildRewardCard(reward);
      }).toList(),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> reward) {
    bool canAfford = (reward["pointsCost"] as int) <= availablePoints;
    bool isLimited = reward["isLimited"] && (reward["stock"] as int) > 0;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isLimited ? Border.all(color: warningColor.withAlpha(100)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${reward["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (reward["isFeatured"])
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
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
                ),
              if (isLimited)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${reward["stock"]} LEFT",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${reward["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${reward["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${reward["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (reward["rating"] as double).floor() 
                              ? Icons.star 
                              : Icons.star_border,
                          color: warningColor,
                          size: 14,
                        );
                      }),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${reward["rating"]} (${reward["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${reward["pointsCost"]} points",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: canAfford ? successColor : dangerColor,
                          ),
                        ),
                        Text(
                          "Worth \$${((reward["originalPrice"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: canAfford ? "Redeem" : "Need ${(reward["pointsCost"] as int) - availablePoints} more",
                    size: bs.sm,
                    onPressed: canAfford ? () => _redeemReward(reward) : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyRewardsStats() {
    int activeCount = myRewards.where((r) => r["status"] == "active").length;
    int usedCount = myRewards.where((r) => r["status"] == "used").length;
    double totalValue = myRewards.fold(0.0, (sum, r) => sum + (r["remainingValue"] as double));
    
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
            child: _buildStatItem("Active", "${activeCount}", Icons.card_giftcard, successColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Used", "${usedCount}", Icons.check_circle, infoColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Value", "\$${totalValue.toStringAsFixed(2)}", Icons.savings, warningColor),
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
            color: color,
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

  Widget _buildActiveRewards() {
    List<Map<String, dynamic>> activeRewards = myRewards.where((r) => r["status"] == "active").toList();
    
    if (activeRewards.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: disabledColor.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Column(
          children: [
            Icon(Icons.card_giftcard, color: disabledBoldColor, size: 48),
            SizedBox(height: spSm),
            Text(
              "No Active Rewards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Redeem rewards from the store to see them here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Rewards",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...activeRewards.map((reward) => _buildMyRewardCard(reward)),
      ],
    );
  }

  Widget _buildRewardsHistory() {
    List<Map<String, dynamic>> historyRewards = myRewards.where((r) => r["status"] != "active").toList();
    
    if (historyRewards.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Rewards History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...historyRewards.map((reward) => _buildMyRewardCard(reward)),
      ],
    );
  }

  Widget _buildMyRewardCard(Map<String, dynamic> reward) {
    Color statusColor = _getStatusColor(reward["status"]);
    IconData statusIcon = _getStatusIcon(reward["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${reward["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${reward["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${reward["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Redeemed: ${DateTime.parse(reward["redeemedDate"]).dMMMy}",
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
          if (reward["status"] == "active") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: statusColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Code:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${reward["code"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          ss("Code ${reward["code"]} copied to clipboard!");
                        },
                        child: Icon(
                          Icons.copy,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if ((reward["remainingValue"] as double) > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Remaining Value:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(reward["remainingValue"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Valid until:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${DateTime.parse(reward["validUntil"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeaturedHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Featured Rewards",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Exclusive and limited-time rewards",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedRewardsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: featuredRewards.map((reward) {
        return _buildRewardCard(reward);
      }).toList(),
    );
  }

  Widget _buildLimitedTimeOffers() {
    List<Map<String, dynamic>> limitedOffers = [...featuredRewards, ...allRewards]
        .where((reward) => reward["isLimited"] && (reward["stock"] as int) > 0)
        .toList();

    if (limitedOffers.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: dangerColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Limited Stock",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        ...limitedOffers.map((reward) => _buildLimitedOfferCard(reward)),
      ],
    );
  }

  Widget _buildLimitedOfferCard(Map<String, dynamic> reward) {
    bool canAfford = (reward["pointsCost"] as int) <= availablePoints;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${reward["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${reward["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${reward["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "ONLY ${reward["stock"]} LEFT",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${reward["pointsCost"]} points",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: canAfford ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: canAfford ? "Redeem" : "Need More",
            size: bs.sm,
            onPressed: canAfford ? () => _redeemReward(reward) : null,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "used":
        return infoColor;
      case "expired":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.card_giftcard;
      case "used":
        return Icons.check_circle;
      case "expired":
        return Icons.schedule;
      default:
        return Icons.redeem;
    }
  }

  void _redeemReward(Map<String, dynamic> reward) async {
    bool isConfirmed = await confirm(
      "Redeem ${reward["title"]} for ${reward["pointsCost"]} points?"
    );
    
    if (isConfirmed) {
      setState(() {
        availablePoints -= (reward["pointsCost"] as int);
        if (reward["isLimited"]) {
          reward["stock"] = (reward["stock"] as int) - 1;
        }
      });
      
      ss("${reward["title"]} redeemed successfully! Check your rewards for details.");
    }
  }
}

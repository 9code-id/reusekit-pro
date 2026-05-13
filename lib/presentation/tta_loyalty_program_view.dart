import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaLoyaltyProgramView extends StatefulWidget {
  const TtaLoyaltyProgramView({super.key});

  @override
  State<TtaLoyaltyProgramView> createState() => _TtaLoyaltyProgramViewState();
}

class _TtaLoyaltyProgramViewState extends State<TtaLoyaltyProgramView> {
  int selectedTab = 0; // 0: Overview, 1: Benefits, 2: Activity, 3: Offers

  final Map<String, dynamic> membershipData = {
    "status": "Gold",
    "nextTier": "Platinum",
    "memberSince": "2022-03-15",
    "memberId": "TTA789456123",
    "currentPoints": 12580,
    "nextTierPoints": 25000,
    "pointsNeeded": 12420,
    "annualSpend": 4275.50,
    "tripsCompleted": 18,
    "countriesVisited": 12,
    "favoriteDestination": "Japan"
  };

  final List<Map<String, dynamic>> membershipTiers = [
    {
      "tier": "Silver",
      "minPoints": 0,
      "color": 0xFF9E9E9E,
      "benefits": [
        "5% discount on bookings",
        "Priority customer support",
        "Free booking changes",
        "Birthday bonus points"
      ]
    },
    {
      "tier": "Gold",
      "minPoints": 5000,
      "color": 0xFFFFD700,
      "benefits": [
        "10% discount on bookings", 
        "Priority customer support",
        "Free booking changes",
        "Birthday bonus points",
        "Free room upgrades",
        "Late checkout",
        "Airport lounge access"
      ]
    },
    {
      "tier": "Platinum",
      "minPoints": 25000,
      "color": 0xFFE5E4E2,
      "benefits": [
        "15% discount on bookings",
        "Dedicated concierge",
        "Free booking changes",
        "Birthday bonus points",
        "Free room upgrades",
        "Late checkout",
        "Airport lounge access",
        "Guaranteed availability",
        "Welcome amenities"
      ]
    },
    {
      "tier": "Diamond",
      "minPoints": 50000,
      "color": 0xFFB9F2FF,
      "benefits": [
        "20% discount on bookings",
        "Personal travel advisor",
        "Free booking changes",
        "Birthday bonus points",
        "Free room upgrades",
        "Late checkout",
        "Airport lounge access",
        "Guaranteed availability", 
        "Welcome amenities",
        "Exclusive experiences",
        "Partner airline benefits"
      ]
    }
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "type": "earned",
      "points": 450,
      "description": "Hotel booking - Grand Palace Paris",
      "date": "2024-06-25",
      "reference": "HTL-2024-789456"
    },
    {
      "type": "redeemed",
      "points": -200,
      "description": "Room upgrade at Swiss Alpine Resort",
      "date": "2024-06-20",
      "reference": "UPG-2024-456789"
    },
    {
      "type": "earned",
      "points": 320,
      "description": "Flight booking - Tokyo to New York",
      "date": "2024-06-15",
      "reference": "FLT-2024-123456"
    },
    {
      "type": "bonus",
      "points": 500,
      "description": "Birthday bonus points",
      "date": "2024-06-10",
      "reference": "BON-2024-111222"
    },
    {
      "type": "earned",
      "points": 280,
      "description": "Car rental - Enterprise BMW X3",
      "date": "2024-06-05",
      "reference": "CAR-2024-334455"
    }
  ];

  final List<Map<String, dynamic>> specialOffers = [
    {
      "title": "Double Points Weekend",
      "description": "Earn 2x points on all hotel bookings this weekend",
      "validUntil": "2024-07-15",
      "type": "points",
      "image": "https://picsum.photos/300/150?random=1&keyword=hotel",
      "discount": "2x Points"
    },
    {
      "title": "City Break Special",
      "description": "15% off city hotels in Europe + 500 bonus points",
      "validUntil": "2024-07-30",
      "type": "discount",
      "image": "https://picsum.photos/300/150?random=2&keyword=city",
      "discount": "15% OFF"
    },
    {
      "title": "Luxury Resort Package",
      "description": "Book 3 nights, get 4th night free at premium resorts",
      "validUntil": "2024-08-15",
      "type": "package",
      "image": "https://picsum.photos/300/150?random=3&keyword=resort",
      "discount": "Buy 3 Get 1"
    },
    {
      "title": "Airport Transfer Credit",
      "description": "Free airport transfer on bookings over \$500",
      "validUntil": "2024-07-20",
      "type": "service",
      "image": "https://picsum.photos/300/150?random=4&keyword=airport",
      "discount": "Free Transfer"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loyalty Program"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Navigate to help
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMembershipCard(),
          _buildTabBar(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    final currentTier = membershipTiers.firstWhere((tier) => tier["tier"] == membershipData["status"]);
    final nextTier = membershipTiers.firstWhere((tier) => tier["tier"] == membershipData["nextTier"]);
    final progress = (membershipData["currentPoints"] as int) / (membershipData["nextTierPoints"] as int);
    
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(currentTier["color"] as int),
            Color(currentTier["color"] as int).withAlpha(204),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowLg],
      ),
      child: Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${membershipData["status"]} Member",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Member since ${DateTime.parse(membershipData["memberSince"]).year}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(204),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.stars,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            Text(
              "Current Points",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(204),
              ),
            ),
            Text(
              "${(membershipData["currentPoints"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Next Tier: ${membershipData["nextTier"]}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(204),
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(77),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "${(membershipData["pointsNeeded"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')} points to ${membershipData["nextTier"]}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(204),
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Member ID: ${membershipData["memberId"]}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ["Overview", "Benefits", "Activity", "Offers"];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: index < tabs.length - 1 ? spXs : 0),
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildBenefitsTab();
      case 2:
        return _buildActivityTab();
      case 3:
        return _buildOffersTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGrid(),
          SizedBox(height: spMd),
          _buildQuickActions(),
          SizedBox(height: spMd),
          _buildRecentHighlights(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Travel Stats",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.flight_takeoff,
                  value: "${membershipData["tripsCompleted"]}",
                  label: "Trips Completed",
                  color: infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.public,
                  value: "${membershipData["countriesVisited"]}",
                  label: "Countries Visited",
                  color: successColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.attach_money,
                  value: "\$${(membershipData["annualSpend"] as double).toStringAsFixed(0)}",
                  label: "Annual Spend",
                  color: warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.favorite,
                  value: "${membershipData["favoriteDestination"]}",
                  label: "Favorite Destination",
                  color: dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Redeem Points",
                  size: bs.md,
                  onPressed: () {
                    // Navigate to redeem points
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Transfer Points",
                  size: bs.md,
                  onPressed: () {
                    // Navigate to transfer points
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "View All Benefits",
              size: bs.md,
              onPressed: () {
                selectedTab = 1;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHighlights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  selectedTab = 2;
                  setState(() {});
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: recentActivity.take(3).map((activity) {
              return _buildActivityItem(activity, isCompact: true);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsTab() {
    final currentTierIndex = membershipTiers.indexWhere((tier) => tier["tier"] == membershipData["status"]);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Current tier benefits
          _buildCurrentTierBenefits(),
          SizedBox(height: spMd),
          // All tiers comparison
          Column(
            children: membershipTiers.map((tier) {
              final isCurrent = tier["tier"] == membershipData["status"];
              final isLocked = membershipTiers.indexOf(tier) > currentTierIndex;
              
              return _buildTierCard(tier, isCurrent, isLocked);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTierBenefits() {
    final currentTier = membershipTiers.firstWhere((tier) => tier["tier"] == membershipData["status"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Color(currentTier["color"] as int).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: Color(currentTier["color"] as int).withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.stars,
                color: Color(currentTier["color"] as int),
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Your ${currentTier["tier"]} Benefits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Color(currentTier["color"] as int),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: (currentTier["benefits"] as List).map((benefit) {
              return Padding(
                padding: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color(currentTier["color"] as int),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$benefit",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(currentTier["color"] as int),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTierCard(Map<String, dynamic> tier, bool isCurrent, bool isLocked) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isCurrent ? Color(tier["color"] as int) : disabledOutlineBorderColor,
          width: isCurrent ? 2 : 1,
        ),
        boxShadow: isCurrent ? [shadowMd] : [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(tier["color"] as int),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${tier["tier"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (isCurrent) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "CURRENT",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
              ],
              if (isLocked) ...[
                SizedBox(width: spSm),
                Icon(Icons.lock, color: disabledBoldColor, size: 16),
              ],
              Spacer(),
              Text(
                "${(tier["minPoints"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}+ points",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: (tier["benefits"] as List).map((benefit) {
              return Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Icon(
                      isLocked ? Icons.lock : Icons.check_circle,
                      color: isLocked ? disabledColor : Color(tier["color"] as int),
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$benefit",
                        style: TextStyle(
                          fontSize: 12,
                          color: isLocked ? disabledBoldColor : primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Points Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: recentActivity.map((activity) {
              return _buildActivityItem(activity);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, {bool isCompact = false}) {
    Color getActivityColor() {
      switch (activity["type"]) {
        case "earned":
          return successColor;
        case "redeemed":
          return dangerColor;
        case "bonus":
          return warningColor;
        default:
          return primaryColor;
      }
    }

    IconData getActivityIcon() {
      switch (activity["type"]) {
        case "earned":
          return Icons.add_circle;
        case "redeemed":
          return Icons.remove_circle;
        case "bonus":
          return Icons.stars;
        default:
          return Icons.circle;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: getActivityColor().withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              getActivityIcon(),
              color: getActivityColor(),
              size: 20,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: isCompact ? 12 : 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: isCompact ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!isCompact) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Ref: ${activity["reference"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${activity["points"] > 0 ? '+' : ''}${activity["points"]}",
                style: TextStyle(
                  fontSize: isCompact ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: getActivityColor(),
                ),
              ),
              Text(
                "${DateTime.parse(activity["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Exclusive Member Offers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: specialOffers.map((offer) {
              return _buildOfferCard(offer);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    Color getOfferColor() {
      switch (offer["type"]) {
        case "points":
          return successColor;
        case "discount":
          return dangerColor;
        case "package":
          return warningColor;
        case "service":
          return infoColor;
        default:
          return primaryColor;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${offer["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: getOfferColor(),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${offer["discount"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${offer["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Valid until ${DateTime.parse(offer["validUntil"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Claim Offer",
                      size: bs.sm,
                      onPressed: () {
                        ss("Offer claimed successfully!");
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
}

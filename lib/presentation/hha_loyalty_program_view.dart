import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaLoyaltyProgramView extends StatefulWidget {
  const HhaLoyaltyProgramView({super.key});

  @override
  State<HhaLoyaltyProgramView> createState() => _HhaLoyaltyProgramViewState();
}

class _HhaLoyaltyProgramViewState extends State<HhaLoyaltyProgramView> {
  String searchQuery = "";
  String selectedTier = "All";
  String selectedStatus = "All";
  int currentTab = 0;

  final List<Map<String, dynamic>> tierOptions = [
    {"label": "All", "value": "All"},
    {"label": "Bronze", "value": "Bronze"},
    {"label": "Silver", "value": "Silver"},
    {"label": "Gold", "value": "Gold"},
    {"label": "Platinum", "value": "Platinum"},
    {"label": "Diamond", "value": "Diamond"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  final List<Map<String, dynamic>> loyaltyMembers = [
    {
      "id": "LP001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "tier": "Platinum",
      "status": "Active",
      "points": 12500,
      "totalSpent": 25000.00,
      "joinDate": "2022-03-15",
      "lastActivity": "2024-01-20",
      "totalBookings": 45,
      "averageStay": 3.2,
      "preferredRoomType": "Suite",
      "phone": "+1 234-567-8901",
    },
    {
      "id": "LP002",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "tier": "Gold",
      "status": "Active",
      "points": 8750,
      "totalSpent": 18500.00,
      "joinDate": "2022-07-10",
      "lastActivity": "2024-01-18",
      "totalBookings": 32,
      "averageStay": 2.8,
      "preferredRoomType": "Deluxe",
      "phone": "+1 234-567-8902",
    },
    {
      "id": "LP003",
      "name": "Emma Wilson",
      "email": "emma.wilson@email.com",
      "tier": "Silver",
      "status": "Active",
      "points": 4250,
      "totalSpent": 9800.00,
      "joinDate": "2023-01-22",
      "lastActivity": "2024-01-15",
      "totalBookings": 18,
      "averageStay": 2.5,
      "preferredRoomType": "Standard",
      "phone": "+1 234-567-8903",
    },
    {
      "id": "LP004",
      "name": "David Rodriguez",
      "email": "david.rodriguez@email.com",
      "tier": "Diamond",
      "status": "Active",
      "points": 18900,
      "totalSpent": 45000.00,
      "joinDate": "2021-11-05",
      "lastActivity": "2024-01-22",
      "totalBookings": 67,
      "averageStay": 4.1,
      "preferredRoomType": "Presidential Suite",
      "phone": "+1 234-567-8904",
    },
    {
      "id": "LP005",
      "name": "Lisa Anderson",
      "email": "lisa.anderson@email.com",
      "tier": "Bronze",
      "status": "Inactive",
      "points": 1200,
      "totalSpent": 2800.00,
      "joinDate": "2023-08-12",
      "lastActivity": "2023-11-05",
      "totalBookings": 6,
      "averageStay": 1.8,
      "preferredRoomType": "Standard",
      "phone": "+1 234-567-8905",
    },
  ];

  final List<Map<String, dynamic>> loyaltyTiers = [
    {
      "name": "Bronze",
      "minPoints": 0,
      "maxPoints": 2499,
      "color": 0xFF8B4513,
      "benefits": ["5% discount", "Free WiFi", "Late checkout"],
      "members": 245,
      "percentage": 45.2,
    },
    {
      "name": "Silver",
      "minPoints": 2500,
      "maxPoints": 4999,
      "color": 0xFFC0C0C0,
      "benefits": ["10% discount", "Room upgrade", "Priority check-in", "Free breakfast"],
      "members": 128,
      "percentage": 23.6,
    },
    {
      "name": "Gold",
      "minPoints": 5000,
      "maxPoints": 9999,
      "color": 0xFFFFD700,
      "benefits": ["15% discount", "Suite upgrade", "Free minibar", "Spa access"],
      "members": 89,
      "percentage": 16.4,
    },
    {
      "name": "Platinum",
      "minPoints": 10000,
      "maxPoints": 19999,
      "color": 0xFFE5E4E2,
      "benefits": ["20% discount", "Premium suite", "Personal concierge", "Airport transfer"],
      "members": 56,
      "percentage": 10.3,
    },
    {
      "name": "Diamond",
      "minPoints": 20000,
      "maxPoints": null,
      "color": 0xFF185ADB,
      "benefits": ["25% discount", "Presidential suite", "24/7 butler", "Helicopter transfer", "Exclusive events"],
      "members": 24,
      "percentage": 4.4,
    },
  ];

  final List<Map<String, dynamic>> rewardCategories = [
    {"name": "Room Upgrades", "pointsRequired": 2500, "popularity": 85, "redeemed": 156},
    {"name": "Free Nights", "pointsRequired": 5000, "popularity": 92, "redeemed": 89},
    {"name": "Spa Services", "pointsRequired": 1500, "popularity": 78, "redeemed": 234},
    {"name": "Dining Credits", "pointsRequired": 1000, "popularity": 88, "redeemed": 312},
    {"name": "Airport Transfer", "pointsRequired": 800, "popularity": 65, "redeemed": 145},
    {"name": "Late Checkout", "pointsRequired": 500, "popularity": 95, "redeemed": 456},
  ];

  List<Map<String, dynamic>> get filteredMembers {
    return loyaltyMembers.where((member) {
      final matchesSearch = member["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesTier = selectedTier == "All" || member["tier"] == selectedTier;
      final matchesStatus = selectedStatus == "All" || member["status"] == selectedStatus;
      
      return matchesSearch && matchesTier && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Loyalty Program",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Tiers", icon: Icon(Icons.emoji_events)),
        Tab(text: "Rewards", icon: Icon(Icons.card_giftcard)),
      ],
      tabChildren: [
        _buildMembersTab(),
        _buildTiersTab(),
        _buildRewardsTab(),
      ],
    );
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildMemberFilters(),
          _buildMembershipStats(),
          _buildMembersList(),
        ],
      ),
    );
  }

  Widget _buildTiersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildTiersList(),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildRewardsList(),
        ],
      ),
    );
  }

  Widget _buildMemberFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Members",
            value: searchQuery,
            hint: "Search by name, email, or ID...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Tier",
                  items: tierOptions,
                  value: selectedTier,
                  onChanged: (value, label) {
                    selectedTier = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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

  Widget _buildMembershipStats() {
    final totalMembers = loyaltyMembers.length;
    final activeMembers = loyaltyMembers.where((m) => m["status"] == "Active").length;
    final totalPoints = loyaltyMembers.fold(0, (sum, m) => sum + (m["points"] as int));
    final avgSpending = loyaltyMembers.fold(0.0, (sum, m) => sum + (m["totalSpent"] as double)) / totalMembers;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Members", totalMembers.toString(), Icons.people, primaryColor),
        _buildStatCard("Active Members", activeMembers.toString(), Icons.people_alt, successColor),
        _buildStatCard("Total Points", "${(totalPoints / 1000).toStringAsFixed(0)}K", Icons.star, warningColor),
        _buildStatCard("Avg Spending", "\$${avgSpending.currency}", Icons.attach_money, infoColor),
      ],
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
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Live",
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Loyalty Members (${filteredMembers.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Member",
                  icon: Icons.person_add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add member
                  },
                ),
              ],
            ),
          ),
          ...filteredMembers.map((member) => _buildMemberItem(member)),
        ],
      ),
    );
  }

  Widget _buildMemberItem(Map<String, dynamic> member) {
    final tier = loyaltyTiers.firstWhere((t) => t["name"] == member["tier"]);
    final tierColor = Color(tier["color"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs, left: spMd, right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: tierColor.withAlpha(20),
                child: Text(
                  "${member["name"].toString().split(' ').map((n) => n[0]).join('')}",
                  style: TextStyle(
                    color: tierColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${member["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: tierColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${member["tier"]}",
                      style: TextStyle(
                        color: tierColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: member["status"] == "Active" ? successColor.withAlpha(20) :
                             member["status"] == "Inactive" ? warningColor.withAlpha(20) :
                             dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${member["status"]}",
                      style: TextStyle(
                        color: member["status"] == "Active" ? successColor :
                               member["status"] == "Inactive" ? warningColor :
                               dangerColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Points: ${member["points"]} • Total Spent: \$${(member["totalSpent"] as double).currency}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${member["totalBookings"]} bookings • Avg ${(member["averageStay"] as double).toStringAsFixed(1)} nights",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Last Activity: ${member["lastActivity"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "View Profile",
                size: bs.sm,
                onPressed: () {
                  // Navigate to member profile
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTiersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Loyalty Tiers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...loyaltyTiers.map((tier) => _buildTierItem(tier)),
        ],
      ),
    );
  }

  Widget _buildTierItem(Map<String, dynamic> tier) {
    final tierColor = Color(tier["color"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm, left: spMd, right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: tierColor.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusSm),
        color: tierColor.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: tierColor, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tier["name"]} Tier",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: tierColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${tier["minPoints"]}${tier["maxPoints"] != null ? " - ${tier["maxPoints"]}" : "+"} points required",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${tier["members"]} members",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${(tier["percentage"] as double).toStringAsFixed(1)}% of total",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Benefits:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (tier["benefits"] as List<String>).map((benefit) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: tierColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                benefit,
                style: TextStyle(
                  fontSize: 12,
                  color: tierColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Reward Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Reward",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add reward
                  },
                ),
              ],
            ),
          ),
          ...rewardCategories.map((reward) => _buildRewardItem(reward)),
        ],
      ),
    );
  }

  Widget _buildRewardItem(Map<String, dynamic> reward) {
    final popularity = reward["popularity"] as int;
    final popularityColor = popularity >= 85 ? successColor : popularity >= 70 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs, left: spMd, right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.card_giftcard, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${reward["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${reward["pointsRequired"]} points required",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${reward["redeemed"]} redeemed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$popularity% popular",
                        style: TextStyle(
                          fontSize: 12,
                          color: popularityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        popularity >= 85 ? Icons.trending_up :
                        popularity >= 70 ? Icons.trending_flat :
                        Icons.trending_down,
                        color: popularityColor,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: popularity / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: popularityColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmReferralProgramView extends StatefulWidget {
  const EcmReferralProgramView({super.key});

  @override
  State<EcmReferralProgramView> createState() => _EcmReferralProgramViewState();
}

class _EcmReferralProgramViewState extends State<EcmReferralProgramView> {
  int currentTab = 0;
  
  // Referral Program Settings
  Map<String, dynamic> programSettings = {
    "isActive": true,
    "referrerReward": 25.0,
    "referrerRewardType": "percentage", // percentage or fixed
    "refereeReward": 15.0,
    "refereeRewardType": "percentage",
    "minimumPurchase": 100.0,
    "maxReferrals": 10,
    "validityDays": 30,
    "trackingMethod": "email", // email or phone
    "autoApplyRewards": true,
    "requireVerification": true,
    "allowSelfReferral": false,
    "programName": "EventMasters Referral Program",
    "description": "Refer friends and earn rewards for every successful registration",
  };

  // Referral Analytics
  Map<String, dynamic> referralAnalytics = {
    "totalReferrals": 456,
    "successfulReferrals": 342,
    "conversionRate": 75.0,
    "totalRewards": 8760.0,
    "averageReward": 25.60,
    "topReferrer": "Sarah Mitchell",
    "monthlyGrowth": 23.5,
    "lifetimeValue": 156.80,
  };

  // Referral Tiers
  List<Map<String, dynamic>> referralTiers = [
    {
      "id": "bronze",
      "name": "Bronze",
      "minReferrals": 0,
      "maxReferrals": 4,
      "reward": 15.0,
      "rewardType": "percentage",
      "color": Color(0xFFCD7F32),
      "benefits": ["15% reward", "Basic support", "Monthly newsletters"],
      "icon": Icons.star_border,
    },
    {
      "id": "silver",
      "name": "Silver",
      "minReferrals": 5,
      "maxReferrals": 9,
      "reward": 20.0,
      "rewardType": "percentage",
      "color": Color(0xFFC0C0C0),
      "benefits": ["20% reward", "Priority support", "Exclusive events", "Early access"],
      "icon": Icons.star_half,
    },
    {
      "id": "gold",
      "name": "Gold",
      "minReferrals": 10,
      "maxReferrals": 19,
      "reward": 25.0,
      "rewardType": "percentage",
      "color": Color(0xFFFFD700),
      "benefits": ["25% reward", "VIP support", "Free event tickets", "Marketing materials"],
      "icon": Icons.star,
    },
    {
      "id": "platinum",
      "name": "Platinum",
      "minReferrals": 20,
      "maxReferrals": 999,
      "reward": 30.0,
      "rewardType": "percentage",
      "color": Color(0xFFE5E4E7),
      "benefits": ["30% reward", "Dedicated manager", "Custom commission rates", "Co-marketing opportunities"],
      "icon": Icons.stars,
    },
  ];

  // Referral Users
  List<Map<String, dynamic>> referralUsers = [
    {
      "id": "user_1",
      "name": "Sarah Mitchell",
      "email": "sarah.mitchell@email.com",
      "joinDate": "2024-01-05T00:00:00Z",
      "referralCode": "SARAH-REF-001",
      "totalReferrals": 23,
      "successfulReferrals": 18,
      "totalEarned": 450.0,
      "pendingRewards": 75.0,
      "lastReferral": "2024-01-14T10:30:00Z",
      "tier": "gold",
      "status": "active",
      "conversionRate": 78.3,
      "averageTicketValue": 185.0,
    },
    {
      "id": "user_2",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "joinDate": "2024-01-08T00:00:00Z",
      "referralCode": "MICHAEL-REF-002",
      "totalReferrals": 15,
      "successfulReferrals": 12,
      "totalEarned": 300.0,
      "pendingRewards": 50.0,
      "lastReferral": "2024-01-13T14:22:00Z",
      "tier": "silver",
      "status": "active",
      "conversionRate": 80.0,
      "averageTicketValue": 220.0,
    },
    {
      "id": "user_3",
      "name": "Jennifer Rodriguez",
      "email": "jennifer.r@email.com",
      "joinDate": "2024-01-12T00:00:00Z",
      "referralCode": "JENNIFER-REF-003",
      "totalReferrals": 8,
      "successfulReferrals": 6,
      "totalEarned": 120.0,
      "pendingRewards": 30.0,
      "lastReferral": "2024-01-15T09:45:00Z",
      "tier": "silver",
      "status": "active",
      "conversionRate": 75.0,
      "averageTicketValue": 150.0,
    },
    {
      "id": "user_4",
      "name": "David Kim",
      "email": "david.kim@email.com",
      "joinDate": "2024-01-03T00:00:00Z",
      "referralCode": "DAVID-REF-004",
      "totalReferrals": 32,
      "successfulReferrals": 25,
      "totalEarned": 750.0,
      "pendingRewards": 125.0,
      "lastReferral": "2024-01-15T16:15:00Z",
      "tier": "platinum",
      "status": "active",
      "conversionRate": 78.1,
      "averageTicketValue": 195.0,
    },
    {
      "id": "user_5",
      "name": "Lisa Thompson",
      "email": "lisa.thompson@email.com",
      "joinDate": "2024-01-10T00:00:00Z",
      "referralCode": "LISA-REF-005",
      "totalReferrals": 4,
      "successfulReferrals": 3,
      "totalEarned": 45.0,
      "pendingRewards": 15.0,
      "lastReferral": "2024-01-12T11:30:00Z",
      "tier": "bronze",
      "status": "active",
      "conversionRate": 75.0,
      "averageTicketValue": 125.0,
    },
  ];

  // Referral Activities
  List<Map<String, dynamic>> referralActivities = [
    {
      "id": "activity_1",
      "type": "successful_referral",
      "referrer": "Sarah Mitchell",
      "referee": "John Anderson",
      "amount": 25.0,
      "date": "2024-01-15T16:30:00Z",
      "status": "completed",
      "ticketType": "VIP",
      "ticketPrice": 299.0,
    },
    {
      "id": "activity_2",
      "type": "new_referrer",
      "referrer": "Alex Johnson",
      "referee": null,
      "amount": 0.0,
      "date": "2024-01-15T14:22:00Z",
      "status": "pending",
      "ticketType": null,
      "ticketPrice": 0.0,
    },
    {
      "id": "activity_3",
      "type": "reward_paid",
      "referrer": "Michael Chen",
      "referee": "Emma Davis",
      "amount": 30.0,
      "date": "2024-01-15T12:15:00Z",
      "status": "completed",
      "ticketType": "Premium",
      "ticketPrice": 199.0,
    },
    {
      "id": "activity_4",
      "type": "tier_upgrade",
      "referrer": "Jennifer Rodriguez",
      "referee": null,
      "amount": 0.0,
      "date": "2024-01-15T10:45:00Z",
      "status": "completed",
      "ticketType": null,
      "ticketPrice": 0.0,
    },
    {
      "id": "activity_5",
      "type": "failed_referral",
      "referrer": "David Kim",
      "referee": "Mark Wilson",
      "amount": 0.0,
      "date": "2024-01-15T09:30:00Z",
      "status": "failed",
      "ticketType": "Standard",
      "ticketPrice": 99.0,
    },
  ];

  String selectedTier = "all";
  String selectedStatus = "all";
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Referral Program",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Referrers", icon: Icon(Icons.people)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReferrersTab(),
        _buildSettingsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Program Status
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${programSettings["programName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: programSettings["isActive"] ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        programSettings["isActive"] ? "ACTIVE" : "INACTIVE",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${programSettings["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Key Metrics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Program Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Referrals", "${referralAnalytics["totalReferrals"]}", Icons.people, infoColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Success Rate", "${(referralAnalytics["conversionRate"] as double).toStringAsFixed(1)}%", Icons.trending_up, successColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Rewards", "\$${((referralAnalytics["totalRewards"] as double) / 1000).toStringAsFixed(1)}K", Icons.attach_money, warningColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Monthly Growth", "+${(referralAnalytics["monthlyGrowth"] as double).toStringAsFixed(1)}%", Icons.trending_up, dangerColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Referral Tiers
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
                  "Referral Tiers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: referralTiers.map((tier) {
                    return _buildTierCard(tier);
                  }).toList(),
                ),
              ],
            ),
          ),

          // Recent Activities
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
                Row(
                  children: [
                    Text(
                      "Recent Activities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                ...referralActivities.take(5).map((activity) => _buildActivityItem(activity)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferrersTab() {
    List<Map<String, dynamic>> filteredUsers = referralUsers.where((user) {
      bool tierMatch = selectedTier == "all" || user["tier"] == selectedTier;
      bool statusMatch = selectedStatus == "all" || user["status"] == selectedStatus;
      return tierMatch && statusMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Top Performers
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Top Performers This Month",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Active Referrers", "${referralUsers.where((u) => u["status"] == "active").length}", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Top Referrer", "${referralAnalytics["topReferrer"]}", Icons.star, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Tier",
                    items: [
                      {"label": "All Tiers", "value": "all"},
                      {"label": "Bronze", "value": "bronze"},
                      {"label": "Silver", "value": "silver"},
                      {"label": "Gold", "value": "gold"},
                      {"label": "Platinum", "value": "platinum"},
                    ],
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
                    label: "Filter by Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Inactive", "value": "inactive"},
                      {"label": "Suspended", "value": "suspended"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Referrers List
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
                  "Referral Partners",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...filteredUsers.map((user) => _buildReferrerCard(user)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Program Configuration
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
                  "Program Configuration",
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
                        label: "Program Name",
                        value: "${programSettings["programName"]}",
                        onChanged: (value) {
                          programSettings["programName"] = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QMemoField(
                  label: "Description",
                  value: "${programSettings["description"]}",
                  onChanged: (value) {
                    programSettings["description"] = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Text(
                      "Program Status",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: programSettings["isActive"] as bool,
                      onChanged: (value) {
                        programSettings["isActive"] = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reward Settings
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
                  "Reward Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Referrer Reward",
                        value: "${programSettings["referrerReward"]}",
                        onChanged: (value) {
                          programSettings["referrerReward"] = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Reward Type",
                        items: [
                          {"label": "Percentage", "value": "percentage"},
                          {"label": "Fixed Amount", "value": "fixed"},
                        ],
                        value: "${programSettings["referrerRewardType"]}",
                        onChanged: (value, label) {
                          programSettings["referrerRewardType"] = value;
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
                        label: "Referee Reward",
                        value: "${programSettings["refereeReward"]}",
                        onChanged: (value) {
                          programSettings["refereeReward"] = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Reward Type",
                        items: [
                          {"label": "Percentage", "value": "percentage"},
                          {"label": "Fixed Amount", "value": "fixed"},
                        ],
                        value: "${programSettings["refereeRewardType"]}",
                        onChanged: (value, label) {
                          programSettings["refereeRewardType"] = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Minimum Purchase Amount (\$)",
                  value: "${programSettings["minimumPurchase"]}",
                  onChanged: (value) {
                    programSettings["minimumPurchase"] = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Program Rules
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
                  "Program Rules",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Max Referrals per User",
                        value: "${programSettings["maxReferrals"]}",
                        onChanged: (value) {
                          programSettings["maxReferrals"] = int.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Validity Days",
                        value: "${programSettings["validityDays"]}",
                        onChanged: (value) {
                          programSettings["validityDays"] = int.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                _buildSettingToggle("Auto Apply Rewards", "Automatically apply rewards when conditions are met", programSettings["autoApplyRewards"] as bool, (value) {
                  programSettings["autoApplyRewards"] = value;
                  setState(() {});
                }),
                _buildSettingToggle("Require Verification", "Require email/phone verification for rewards", programSettings["requireVerification"] as bool, (value) {
                  programSettings["requireVerification"] = value;
                  setState(() {});
                }),
                _buildSettingToggle("Allow Self Referral", "Allow users to refer themselves", programSettings["allowSelfReferral"] as bool, (value) {
                  programSettings["allowSelfReferral"] = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Save Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              icon: Icons.save,
              onPressed: () {
                ss("Referral program settings saved successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overall Analytics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Referral Program Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Referrals", "${referralAnalytics["totalReferrals"]}", Icons.people, infoColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Successful", "${referralAnalytics["successfulReferrals"]}", Icons.check_circle, successColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Conversion Rate", "${(referralAnalytics["conversionRate"] as double).toStringAsFixed(1)}%", Icons.trending_up, warningColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Avg. Reward", "\$${(referralAnalytics["averageReward"] as double).toStringAsFixed(2)}", Icons.attach_money, dangerColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tier Distribution
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
                  "Tier Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...referralTiers.map((tier) => _buildTierDistribution(tier)),
              ],
            ),
          ),

          // Performance Metrics
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
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildMetricItem("Lifetime Value", "\$${(referralAnalytics["lifetimeValue"] as double).toStringAsFixed(2)}", Icons.account_balance_wallet, infoColor),
                _buildMetricItem("Monthly Growth", "+${(referralAnalytics["monthlyGrowth"] as double).toStringAsFixed(1)}%", Icons.trending_up, successColor),
                _buildMetricItem("Top Referrer", "${referralAnalytics["topReferrer"]}", Icons.star, warningColor),
                _buildMetricItem("Total Rewards Paid", "\$${((referralAnalytics["totalRewards"] as double) / 1000).toStringAsFixed(1)}K", Icons.payment, dangerColor),
              ],
            ),
          ),

          // Recent Trends
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
                  "Recent Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildTrendChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierCard(Map<String, dynamic> tier) {
    int userCount = referralUsers.where((user) => user["tier"] == tier["id"]).length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: tier["color"] as Color),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                tier["icon"] as IconData,
                color: tier["color"] as Color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${tier["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: tier["color"] as Color,
                  ),
                ),
              ),
              Text(
                "$userCount users",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${tier["minReferrals"]}-${tier["maxReferrals"] == 999 ? "∞" : tier["maxReferrals"]} referrals",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(tier["reward"] as double).toStringAsFixed(0)}% reward",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Text(
              (tier["benefits"] as List).join(" • "),
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    String type = activity["type"] as String;
    IconData icon;
    Color color;
    String title;
    
    switch (type) {
      case "successful_referral":
        icon = Icons.check_circle;
        color = successColor;
        title = "Successful Referral";
        break;
      case "new_referrer":
        icon = Icons.person_add;
        color = infoColor;
        title = "New Referrer";
        break;
      case "reward_paid":
        icon = Icons.payment;
        color = warningColor;
        title = "Reward Paid";
        break;
      case "tier_upgrade":
        icon = Icons.star;
        color = dangerColor;
        title = "Tier Upgrade";
        break;
      case "failed_referral":
        icon = Icons.cancel;
        color = disabledBoldColor;
        title = "Failed Referral";
        break;
      default:
        icon = Icons.info;
        color = disabledBoldColor;
        title = "Activity";
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["referrer"]}${activity["referee"] != null ? " → ${activity["referee"]}" : ""}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if ((activity["amount"] as double) > 0)
                Text(
                  "\$${(activity["amount"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              Text(
                DateTime.parse("${activity["date"]}").dMMMy,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferrerCard(Map<String, dynamic> user) {
    String tier = user["tier"] as String;
    String status = user["status"] as String;
    
    Map<String, dynamic> tierData = referralTiers.firstWhere((t) => t["id"] == tier);
    Color tierColor = tierData["color"] as Color;
    Color statusColor = status == "active" ? successColor : 
                       status == "inactive" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${user["name"]}".substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: tierColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            tier.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${user["email"]}",
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
          Row(
            children: [
              Expanded(
                child: _buildUserMetric("Referrals", "${user["successfulReferrals"]}/${user["totalReferrals"]}", Icons.people),
              ),
              Expanded(
                child: _buildUserMetric("Earned", "\$${((user["totalEarned"] as double)).toStringAsFixed(0)}", Icons.attach_money),
              ),
              Expanded(
                child: _buildUserMetric("Rate", "${(user["conversionRate"] as double).toStringAsFixed(1)}%", Icons.trending_up),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Code: ${user["referralCode"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              if ((user["pendingRewards"] as double) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "\$${(user["pendingRewards"] as double).toStringAsFixed(0)} PENDING",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showReferrerOptions(user),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserMetric(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingToggle(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTierDistribution(Map<String, dynamic> tier) {
    int userCount = referralUsers.where((user) => user["tier"] == tier["id"]).length;
    double percentage = (userCount / referralUsers.length) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                tier["icon"] as IconData,
                color: tier["color"] as Color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "${tier["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "$userCount users (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: tier["color"] as Color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trending_up,
              size: 48,
              color: successColor,
            ),
            SizedBox(height: spSm),
            Text(
              "Referral Trends Chart",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Visual trend analysis will be displayed here",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReferrerOptions(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Referrer Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("View Profile"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Analytics"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Process Payment"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Send Message"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text("Suspend Account"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

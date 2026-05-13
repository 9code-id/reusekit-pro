import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaReferralProgramView extends StatefulWidget {
  const SpaReferralProgramView({super.key});

  @override
  State<SpaReferralProgramView> createState() => _SpaReferralProgramViewState();
}

class _SpaReferralProgramViewState extends State<SpaReferralProgramView> {
  String referralCode = "SPA2024XYZ";
  int totalReferrals = 8;
  double totalEarnings = 240.00;
  int availableCredits = 120;
  
  List<Map<String, dynamic>> referralHistory = [
    {
      "name": "Sarah Johnson",
      "date": "2024-12-15",
      "status": "completed",
      "reward": 30.00,
      "service": "Deep Tissue Massage",
    },
    {
      "name": "Emily Davis",
      "date": "2024-12-10",
      "status": "completed",
      "reward": 45.00,
      "service": "Full Spa Package",
    },
    {
      "name": "Michael Chen",
      "date": "2024-12-05",
      "status": "pending",
      "reward": 25.00,
      "service": "Facial Treatment",
    },
    {
      "name": "Jessica Wilson",
      "date": "2024-12-01",
      "status": "completed",
      "reward": 35.00,
      "service": "Aromatherapy Session",
    },
    {
      "name": "David Brown",
      "date": "2024-11-28",
      "status": "completed",
      "reward": 40.00,
      "service": "Couples Massage",
    },
  ];

  List<Map<String, dynamic>> rewardTiers = [
    {
      "referrals": "1-2",
      "reward": "15% commission",
      "bonus": "None",
      "description": "Get started with your first referrals",
    },
    {
      "referrals": "3-5",
      "reward": "20% commission",
      "bonus": "\$10 bonus",
      "description": "Unlock higher rewards",
    },
    {
      "referrals": "6-10",
      "reward": "25% commission",
      "bonus": "\$25 bonus",
      "description": "Premium tier benefits",
    },
    {
      "referrals": "10+",
      "reward": "30% commission",
      "bonus": "\$50 bonus",
      "description": "VIP referrer status",
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "\$${availableCredits.toDouble().currency}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Overview
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Referral Success",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "$totalReferrals Friends Referred",
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
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${totalEarnings.currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Earned",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
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
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${availableCredits.toDouble().currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Available Credits",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Referral Code Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Your Referral Code",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(100)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          referralCode,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Copy",
                        size: bs.sm,
                        onPressed: () {
                          _copyReferralCode();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Share this code with friends to earn rewards when they book their first spa service!",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "My Referrals",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Reward Tiers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: selectedTab == 0 ? _buildReferralsTab() : _buildRewardTiersTab(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _shareReferralCode();
        },
        backgroundColor: primaryColor,
        icon: Icon(Icons.share, color: Colors.white),
        label: Text(
          "Share Code",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReferralsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: referralHistory.map((referral) {
          Color statusColor = referral["status"] == "completed" ? successColor : warningColor;
          IconData statusIcon = referral["status"] == "completed" ? Icons.check_circle : Icons.schedule;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border.all(color: statusColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        statusIcon,
                        color: statusColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${referral["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${referral["service"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${(referral["reward"] as double).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(referral["date"]).dMMMy}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${referral["status"] == "completed" ? "Reward Earned" : "Pending Completion"}",
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRewardTiersTab() {
    int currentTier = totalReferrals <= 2 ? 0 : 
                     totalReferrals <= 5 ? 1 : 
                     totalReferrals <= 10 ? 2 : 3;
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "Current Tier: ${rewardTiers[currentTier]["referrals"]} Referrals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${rewardTiers[currentTier]["reward"]} + ${rewardTiers[currentTier]["bonus"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...rewardTiers.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> tier = entry.value;
            bool isCurrentTier = index == currentTier;
            bool isUnlocked = index <= currentTier;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isCurrentTier ? primaryColor.withAlpha(50) : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: isCurrentTier ? primaryColor : 
                         isUnlocked ? successColor.withAlpha(100) : 
                         disabledOutlineBorderColor,
                  width: isCurrentTier ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isUnlocked ? 
                             (isCurrentTier ? primaryColor : successColor) : 
                             disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isUnlocked ? Icons.check : Icons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${tier["referrals"]} Referrals",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isUnlocked ? primaryColor : disabledBoldColor,
                                fontSize: 16,
                              ),
                            ),
                            if (isCurrentTier) ...[
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "CURRENT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tier["reward"]} + ${tier["bonus"]}",
                          style: TextStyle(
                            color: isUnlocked ? successColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${tier["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
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
    );
  }

  void _copyReferralCode() {
    ss("Referral code copied to clipboard!");
  }

  void _shareReferralCode() {
    ss("Sharing referral code...");
  }
}

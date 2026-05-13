import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsReferralProgramView extends StatefulWidget {
  const EcsReferralProgramView({super.key});

  @override
  State<EcsReferralProgramView> createState() => _EcsReferralProgramViewState();
}

class _EcsReferralProgramViewState extends State<EcsReferralProgramView> {
  String referralCode = "SHOP2025ALEX";
  int totalReferrals = 12;
  double totalEarnings = 240.00;
  int pendingRewards = 3;

  List<Map<String, dynamic>> referralHistory = [
    {
      "id": "REF001",
      "friendName": "Sarah Johnson",
      "status": "Completed",
      "reward": 25.00,
      "date": "2024-12-10",
      "orderValue": 150.00,
    },
    {
      "id": "REF002",
      "friendName": "Mike Chen",
      "status": "Pending",
      "reward": 20.00,
      "date": "2024-12-08",
      "orderValue": 120.00,
    },
    {
      "id": "REF003",
      "friendName": "Emma Wilson",
      "status": "Completed",
      "reward": 30.00,
      "date": "2024-12-05",
      "orderValue": 200.00,
    },
    {
      "id": "REF004",
      "friendName": "David Smith",
      "status": "Expired",
      "reward": 0.00,
      "date": "2024-11-20",
      "orderValue": 0.00,
    },
  ];

  List<Map<String, dynamic>> rewardTiers = [
    {
      "level": "Bronze",
      "referrals": "1-5",
      "reward": "\$15 per referral",
      "bonus": "None",
      "current": false,
    },
    {
      "level": "Silver",
      "referrals": "6-15",
      "reward": "\$20 per referral",
      "bonus": "\$50 milestone bonus",
      "current": true,
    },
    {
      "level": "Gold",
      "referrals": "16-30",
      "reward": "\$25 per referral",
      "bonus": "\$100 milestone bonus",
      "current": false,
    },
    {
      "level": "Platinum",
      "referrals": "31+",
      "reward": "\$30 per referral",
      "bonus": "\$200 milestone bonus",
      "current": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Navigate to help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildReferralCodeCard(),
            _buildStatsCards(),
            _buildHowItWorksSection(),
            _buildRewardTiersSection(),
            _buildReferralHistorySection(),
            _buildShareSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralCodeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.white,
            size: 48,
          ),
          Text(
            "Your Referral Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.white.withAlpha(100)),
            ),
            child: Text(
              referralCode,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QButton(
                label: "Copy Code",
                icon: Icons.copy,
                color: Colors.white,
                size: bs.sm,
                onPressed: () {
                  ss("Referral code copied!");
                },
              ),
              QButton(
                label: "Share",
                icon: Icons.share,
                color: Colors.white,
                size: bs.sm,
                onPressed: () {
                  _shareReferralCode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 150,
      children: [
        _buildStatCard(
          "Total Referrals",
          "$totalReferrals",
          Icons.people,
          successColor,
        ),
        _buildStatCard(
          "Total Earnings",
          "\$${totalEarnings.toStringAsFixed(2)}",
          Icons.attach_money,
          primaryColor,
        ),
        _buildStatCard(
          "Pending Rewards",
          "$pendingRewards",
          Icons.pending_actions,
          warningColor,
        ),
        _buildStatCard(
          "Success Rate",
          "85%",
          Icons.trending_up,
          infoColor,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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

  Widget _buildHowItWorksSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "How It Works",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              _buildHowItWorksStep(
                "1",
                "Share Your Code",
                "Send your unique referral code to friends and family",
                Icons.share,
              ),
              _buildHowItWorksStep(
                "2",
                "Friend Makes Purchase",
                "Your friend uses your code and makes their first order",
                Icons.shopping_cart,
              ),
              _buildHowItWorksStep(
                "3",
                "Both Get Rewards",
                "You earn money, your friend gets a discount",
                Icons.card_giftcard,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksStep(String number, String title, String description, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
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
      ],
    );
  }

  Widget _buildRewardTiersSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Reward Tiers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: rewardTiers.map((tier) => _buildRewardTierCard(tier)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardTierCard(Map<String, dynamic> tier) {
    bool isCurrent = tier["current"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isCurrent ? primaryColor.withAlpha(25) : Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isCurrent ? primaryColor : disabledOutlineBorderColor,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isCurrent ? primaryColor : disabledBoldColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isCurrent ? Icons.star : Icons.star_border,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${tier["level"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    if (isCurrent) ...[
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "CURRENT",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${tier["referrals"]} referrals",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${tier["reward"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                if (tier["bonus"] != "None")
                  Text(
                    "Bonus: ${tier["bonus"]}",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralHistorySection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Referral History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  // Navigate to full history
                },
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: referralHistory.take(3).map((referral) => _buildReferralHistoryItem(referral)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralHistoryItem(Map<String, dynamic> referral) {
    Color statusColor;
    IconData statusIcon;
    
    switch (referral["status"]) {
      case "Completed":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = warningColor;
        statusIcon = Icons.pending;
        break;
      case "Expired":
        statusColor = dangerColor;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withAlpha(50),
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
                  "${referral["friendName"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Order: \$${((referral["orderValue"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${(DateTime.parse(referral["date"])).dMMMy}",
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
            spacing: spXs,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${referral["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              Text(
                "\$${((referral["reward"] as double)).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: referral["status"] == "Completed" ? successColor : disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(
            Icons.share,
            color: primaryColor,
            size: 48,
          ),
          Text(
            "Share & Earn More",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Share your referral code with friends via social media, messaging apps, or email to maximize your earnings.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShareButton(
                "WhatsApp",
                Icons.message,
                successColor,
                () => _shareViaWhatsApp(),
              ),
              _buildShareButton(
                "Message",
                Icons.sms,
                infoColor,
                () => _shareViaSMS(),
              ),
              _buildShareButton(
                "Email",
                Icons.email,
                warningColor,
                () => _shareViaEmail(),
              ),
              _buildShareButton(
                "More",
                Icons.more_horiz,
                primaryColor,
                () => _shareReferralCode(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _shareReferralCode() {
    ss("Referral code shared successfully!");
  }

  void _shareViaWhatsApp() {
    ss("Sharing via WhatsApp...");
  }

  void _shareViaSMS() {
    ss("Sharing via SMS...");
  }

  void _shareViaEmail() {
    ss("Sharing via Email...");
  }
}

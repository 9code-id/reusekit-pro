import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership10View extends StatefulWidget {
  const GrlMembership10View({Key? key}) : super(key: key);

  @override
  State<GrlMembership10View> createState() => _GrlMembership10ViewState();
}

class _GrlMembership10ViewState extends State<GrlMembership10View> {
  String referralCode = "JOHNDOE2024";
  int totalReferrals = 18;
  double totalEarnings = 456.80;
  int currentTierLevel = 2;

  List<Map<String, dynamic>> referralTiers = [
    {
      "level": 1,
      "name": "Bronze Referrer",
      "minReferrals": 0,
      "maxReferrals": 9,
      "commission": 10,
      "bonuses": ["Welcome bonus: \$10"],
      "color": Color(0xFFCD7F32),
      "icon": Icons.star_border,
    },
    {
      "level": 2,
      "name": "Silver Referrer",
      "minReferrals": 10,
      "maxReferrals": 24,
      "commission": 15,
      "bonuses": ["Monthly bonus: \$50", "Exclusive resources"],
      "color": Color(0xFFC0C0C0),
      "icon": Icons.star_half,
    },
    {
      "level": 3,
      "name": "Gold Referrer",
      "minReferrals": 25,
      "maxReferrals": 49,
      "commission": 20,
      "bonuses": ["Monthly bonus: \$100", "Priority support", "Early access"],
      "color": Color(0xFFFFD700),
      "icon": Icons.star,
    },
    {
      "level": 4,
      "name": "Platinum Referrer",
      "minReferrals": 50,
      "maxReferrals": 999,
      "commission": 25,
      "bonuses": ["Monthly bonus: \$200", "Personal account manager", "Custom promotions"],
      "color": Color(0xFFE5E4E2),
      "icon": Icons.diamond,
    },
  ];

  List<Map<String, dynamic>> referralHistory = [
    {
      "name": "Sarah Johnson",
      "email": "sarah.j@company.com",
      "joinDate": "2024-06-18",
      "plan": "Professional",
      "commission": 29.99,
      "status": "active",
    },
    {
      "name": "Mike Chen",
      "email": "mike.chen@startup.io",
      "joinDate": "2024-06-15",
      "plan": "Enterprise",
      "commission": 99.99,
      "status": "active",
    },
    {
      "name": "Emma Wilson",
      "email": "emma.w@agency.com",
      "joinDate": "2024-06-12",
      "plan": "Basic",
      "commission": 9.99,
      "status": "pending",
    },
    {
      "name": "David Rodriguez",
      "email": "d.rodriguez@tech.com",
      "joinDate": "2024-06-10",
      "plan": "Professional",
      "commission": 29.99,
      "status": "active",
    },
    {
      "name": "Lisa Thompson",
      "email": "lisa.t@business.com",
      "joinDate": "2024-06-08",
      "plan": "Enterprise",
      "commission": 99.99,
      "status": "cancelled",
    },
  ];

  List<Map<String, dynamic>> payoutHistory = [
    {
      "date": "2024-06-01",
      "amount": 156.75,
      "method": "PayPal",
      "status": "completed",
      "transactionId": "TXN-20240601-001",
    },
    {
      "date": "2024-05-01",
      "amount": 142.30,
      "method": "Bank Transfer",
      "status": "completed",
      "transactionId": "TXN-20240501-001",
    },
    {
      "date": "2024-04-01",
      "amount": 89.50,
      "method": "PayPal",
      "status": "completed",
      "transactionId": "TXN-20240401-001",
    },
    {
      "date": "2024-03-01",
      "amount": 68.25,
      "method": "PayPal",
      "status": "pending",
      "transactionId": "TXN-20240301-001",
    },
  ];

  Map<String, dynamic> get currentTier {
    return referralTiers.firstWhere((tier) => tier["level"] == currentTierLevel);
  }

  Map<String, dynamic> get nextTier {
    return currentTierLevel < referralTiers.length 
        ? referralTiers.firstWhere((tier) => tier["level"] == currentTierLevel + 1)
        : referralTiers.last;
  }

  double get progressToNextTier {
    if (currentTierLevel >= referralTiers.length) return 1.0;
    final current = currentTier;
    final next = nextTier;
    final progress = (totalReferrals - (current["minReferrals"] as int)) / 
                    ((next["minReferrals"] as int) - (current["minReferrals"] as int));
    return progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Sharing referral link");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (currentTier["color"] as Color).withAlpha(30),
                    (currentTier["color"] as Color).withAlpha(10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: (currentTier["color"] as Color).withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: currentTier["color"] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          currentTier["icon"] as IconData,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentTier["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentTier["commission"]}% commission rate",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: currentTier["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Level $currentTierLevel",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalReferrals",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Referrals",
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
                        height: 30,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${totalEarnings.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Earnings",
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
                        height: 30,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${nextTier["minReferrals"] - totalReferrals}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "To Next Level",
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

                  if (currentTierLevel < referralTiers.length) ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Text(
                          "Progress to ${nextTier["name"]}:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(progressToNextTier * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: currentTier["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progressToNextTier,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(currentTier["color"] as Color),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Referral Code
            Text(
              "Your Referral Code",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referral Code",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              referralCode,
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Copy",
                        size: bs.sm,
                        onPressed: () {
                          ss("Referral code copied to clipboard!");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Share this code with friends to earn ${currentTier["commission"]}% commission on their subscriptions",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Referral Tiers
            Text(
              "Referral Tiers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...referralTiers.map((tier) {
              final isCurrentTier = tier["level"] == currentTierLevel;
              final isUnlocked = totalReferrals >= (tier["minReferrals"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isCurrentTier 
                      ? (tier["color"] as Color).withAlpha(20)
                      : isUnlocked 
                          ? Colors.white 
                          : Colors.grey[50],
                  border: Border.all(
                    color: isCurrentTier 
                        ? (tier["color"] as Color)
                        : disabledOutlineBorderColor,
                    width: isCurrentTier ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: isUnlocked 
                            ? (tier["color"] as Color)
                            : disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        tier["icon"] as IconData,
                        color: Colors.white,
                        size: 16,
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
                                "${tier["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isUnlocked ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              if (isCurrentTier) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: tier["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "CURRENT",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${tier["minReferrals"]}-${tier["maxReferrals"] == 999 ? "∞" : tier["maxReferrals"]} referrals • ${tier["commission"]}% commission",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isUnlocked)
                      Icon(
                        Icons.lock,
                        color: disabledColor,
                        size: 16,
                      ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: spLg),

            // Recent Referrals
            Text(
              "Recent Referrals",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...referralHistory.take(5).map((referral) {
              final statusColor = referral["status"] == "active" ? successColor :
                                 referral["status"] == "pending" ? warningColor : dangerColor;
              
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: primaryColor,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${referral["plan"]} • ${referral["joinDate"]}",
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
                        Text(
                          "\$${(referral["commission"] as num).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${referral["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: spLg),

            // Payout History
            Text(
              "Payout History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...payoutHistory.map((payout) {
              final statusColor = payout["status"] == "completed" ? successColor : warningColor;
              
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
                        color: statusColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        payout["status"] == "completed" ? Icons.check : Icons.schedule,
                        color: statusColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${payout["method"]} • ${payout["date"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${payout["transactionId"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(payout["amount"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Share Referral Link",
                    size: bs.md,
                    onPressed: () {
                      ss("Sharing your referral link");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: QButton(
                      label: "Request Payout",
                      size: bs.md,
                      color: Colors.white,
                      onPressed: () {
                        ss("Payout request submitted");
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "Minimum payout amount: \$50 • Payments processed monthly",
              textAlign: TextAlign.center,
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
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsReferralProgramView extends StatefulWidget {
  const BrsReferralProgramView({super.key});

  @override
  State<BrsReferralProgramView> createState() => _BrsReferralProgramViewState();
}

class _BrsReferralProgramViewState extends State<BrsReferralProgramView> {
  String referralCode = "MARCUS2024";
  int totalReferrals = 12;
  double totalEarnings = 180.0;
  double pendingEarnings = 45.0;
  
  List<Map<String, dynamic>> referralHistory = [
    {
      "id": 1,
      "friendName": "John Smith",
      "email": "john@email.com",
      "status": "Completed",
      "reward": 15.0,
      "date": "2024-03-15",
      "firstBooking": "2024-03-16",
    },
    {
      "id": 2,
      "friendName": "Mike Johnson",
      "email": "mike@email.com",
      "status": "Pending",
      "reward": 15.0,
      "date": "2024-03-12",
      "firstBooking": "",
    },
    {
      "id": 3,
      "friendName": "David Wilson",
      "email": "david@email.com",
      "status": "Completed",
      "reward": 15.0,
      "date": "2024-03-10",
      "firstBooking": "2024-03-11",
    },
    {
      "id": 4,
      "friendName": "Tom Brown",
      "email": "tom@email.com",
      "status": "Expired",
      "reward": 0.0,
      "date": "2024-02-15",
      "firstBooking": "",
    },
    {
      "id": 5,
      "friendName": "Chris Davis",
      "email": "chris@email.com",
      "status": "Completed",
      "reward": 15.0,
      "date": "2024-03-08",
      "firstBooking": "2024-03-09",
    },
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "level": "Bronze",
      "minReferrals": 0,
      "maxReferrals": 4,
      "rewardPerReferral": 10.0,
      "bonus": 0.0,
      "benefits": ["Basic rewards", "Email support"],
    },
    {
      "level": "Silver",
      "minReferrals": 5,
      "maxReferrals": 9,
      "rewardPerReferral": 15.0,
      "bonus": 25.0,
      "benefits": ["Increased rewards", "Priority support", "Exclusive offers"],
    },
    {
      "level": "Gold",
      "minReferrals": 10,
      "maxReferrals": 19,
      "rewardPerReferral": 20.0,
      "bonus": 50.0,
      "benefits": ["Maximum rewards", "VIP support", "Special events", "Early access"],
    },
    {
      "level": "Platinum",
      "minReferrals": 20,
      "maxReferrals": 999,
      "rewardPerReferral": 25.0,
      "bonus": 100.0,
      "benefits": ["Premium rewards", "Dedicated manager", "Exclusive perks", "Custom offers"],
    },
  ];

  String getCurrentLevel() {
    for (final reward in rewards.reversed) {
      if (totalReferrals >= (reward["minReferrals"] as int)) {
        return reward["level"] as String;
      }
    }
    return "Bronze";
  }

  Map<String, dynamic> getCurrentLevelInfo() {
    return rewards.firstWhere((r) => r["level"] == getCurrentLevel());
  }

  Map<String, dynamic>? getNextLevelInfo() {
    final currentLevel = getCurrentLevel();
    final currentIndex = rewards.indexWhere((r) => r["level"] == currentLevel);
    if (currentIndex < rewards.length - 1) {
      return rewards[currentIndex + 1];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentLevelInfo = getCurrentLevelInfo();
    final nextLevelInfo = getNextLevelInfo();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show help/FAQ
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 40, color: Colors.white),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Refer & Earn",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Share the love, earn rewards",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "You're at ${getCurrentLevel()} level",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$totalReferrals",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Referrals",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalEarnings.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Earned",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${pendingEarnings.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Progress to Next Level
            if (nextLevelInfo != null) ...[
              Container(
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
                        Text(
                          "Progress to ${nextLevelInfo["level"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "$totalReferrals / ${nextLevelInfo["minReferrals"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: totalReferrals / (nextLevelInfo["minReferrals"] as int),
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${(nextLevelInfo["minReferrals"] as int) - totalReferrals} more referrals to unlock ${nextLevelInfo["level"]} level",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Next level reward: \$${(nextLevelInfo["rewardPerReferral"] as double).toStringAsFixed(0)} per referral + \$${(nextLevelInfo["bonus"] as double).toStringAsFixed(0)} bonus",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
            ],

            // Your Referral Code
            Text(
              "Your Referral Code",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          referralCode,
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Share this code with friends",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.copy,
                    size: bs.sm,
                    onPressed: () {
                      ss("Referral code copied!");
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Share Options
            Text(
              "Share with Friends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Share via SMS",
                    icon: Icons.sms,
                    size: bs.md,
                    onPressed: () {
                      // Share via SMS
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share via Email",
                    icon: Icons.email,
                    size: bs.md,
                    onPressed: () {
                      // Share via Email
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "WhatsApp",
                    icon: Icons.chat,
                    size: bs.md,
                    onPressed: () {
                      // Share via WhatsApp
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Social Media",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      // Share via Social Media
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // How It Works
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How It Works",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildHowItWorksStep(
                    "1",
                    "Share Your Code",
                    "Send your referral code to friends via SMS, email, or social media",
                    Icons.share,
                  ),
                  _buildHowItWorksStep(
                    "2",
                    "Friend Signs Up",
                    "Your friend downloads the app and enters your referral code",
                    Icons.person_add,
                  ),
                  _buildHowItWorksStep(
                    "3",
                    "Friend Books Service",
                    "Your friend completes their first booking within 30 days",
                    Icons.calendar_today,
                  ),
                  _buildHowItWorksStep(
                    "4",
                    "You Both Earn",
                    "You get \$${(currentLevelInfo["rewardPerReferral"] as double).toStringAsFixed(0)}, they get \$10 off their first service",
                    Icons.card_giftcard,
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Reward Levels
            Text(
              "Reward Levels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...rewards.map((reward) {
              final isCurrentLevel = reward["level"] == getCurrentLevel();
              final isAchieved = totalReferrals >= (reward["minReferrals"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCurrentLevel ? primaryColor.withAlpha(30) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isCurrentLevel ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: isCurrentLevel ? [shadowSm] : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isAchieved ? Icons.check_circle : Icons.lock,
                          color: isAchieved ? successColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${reward["level"]} Level",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCurrentLevel ? primaryColor : Colors.black,
                          ),
                        ),
                        Spacer(),
                        if (isCurrentLevel)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Current",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${reward["minReferrals"]}${(reward["maxReferrals"] as int) == 999 ? "+" : " - ${reward["maxReferrals"]}"} referrals",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "\$${(reward["rewardPerReferral"] as double).toStringAsFixed(0)} per referral",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        if ((reward["bonus"] as double) > 0) ...[
                          SizedBox(width: spSm),
                          Text(
                            "+ \$${(reward["bonus"] as double).toStringAsFixed(0)} bonus",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Referral History
            Text(
              "Referral History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...referralHistory.map((referral) {
              Color statusColor;
              IconData statusIcon;
              
              switch (referral["status"]) {
                case "Completed":
                  statusColor = successColor;
                  statusIcon = Icons.check_circle;
                  break;
                case "Pending":
                  statusColor = warningColor;
                  statusIcon = Icons.access_time;
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
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(statusIcon, color: statusColor, size: 20),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${referral["friendName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${referral["email"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Referred: ${referral["date"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
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
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${referral["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if ((referral["reward"] as double) > 0) ...[
                          SizedBox(height: spXs),
                          Text(
                            "+\$${(referral["reward"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksStep(String number, String title, String description, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
                    Icon(icon, size: 18, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
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
      ),
    );
  }
}

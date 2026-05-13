import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReferral1View extends StatefulWidget {
  @override
  State<GrlReferral1View> createState() => _GrlReferral1ViewState();
}

class _GrlReferral1ViewState extends State<GrlReferral1View> {
  String referralCode = "SARAH2024";
  String shareMessage = "";

  Map<String, dynamic> referralStats = {
    "total_referrals": 23,
    "successful_referrals": 18,
    "pending_referrals": 5,
    "total_earnings": 450.00,
    "this_month_earnings": 75.00,
    "next_milestone": 500.00,
  };

  List<Map<String, dynamic>> recentReferrals = [
    {
      "name": "John Smith",
      "email": "john@example.com",
      "status": "completed",
      "earning": 25.00,
      "date": "2024-01-15",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=man",
    },
    {
      "name": "Emily Johnson",
      "email": "emily@example.com",
      "status": "pending",
      "earning": 25.00,
      "date": "2024-01-14",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
    },
    {
      "name": "Mike Davis",
      "email": "mike@example.com",
      "status": "completed",
      "earning": 25.00,
      "date": "2024-01-12",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=person",
    },
    {
      "name": "Sarah Wilson",
      "email": "sarah@example.com",
      "status": "rejected",
      "earning": 0.00,
      "date": "2024-01-10",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=girl",
    },
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "milestone": 5,
      "reward": "\$50 Bonus",
      "completed": true,
    },
    {
      "milestone": 10,
      "reward": "\$100 Bonus",
      "completed": true,
    },
    {
      "milestone": 25,
      "reward": "\$200 Bonus + Premium Badge",
      "completed": false,
    },
    {
      "milestone": 50,
      "reward": "\$500 Bonus + VIP Status",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer & Earn"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earnings Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Total Earnings",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${((referralStats["total_earnings"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((referralStats["this_month_earnings"] as double).toDouble()).currency} this month",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Withdraw Earnings",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${referralStats["successful_referrals"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Successful",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${referralStats["pending_referrals"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Pending",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${referralStats["total_referrals"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total",
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
            SizedBox(height: spMd),

            // Referral Code Section
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
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            referralCode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.copy,
                        size: bs.sm,
                        onPressed: () {
                          // Copy to clipboard
                          ss("Referral code copied to clipboard");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Share Code",
                          size: bs.md,
                          onPressed: () => _showShareOptions(),
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
                            label: "Invite Contacts",
                            size: bs.md,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // How it Works
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How Referrals Work",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildHowItWorksStep("1", "Share your referral code with friends"),
                  _buildHowItWorksStep("2", "They sign up using your code"),
                  _buildHowItWorksStep("3", "You both earn \$25 when they complete their first order"),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Progress to Next Milestone
            Text(
              "Progress to Next Milestone",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${referralStats["successful_referrals"]}/25 Referrals",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$200 Bonus + Premium Badge",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: ((referralStats["successful_referrals"] as int) / 25),
                    backgroundColor: disabledOutlineBorderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${25 - (referralStats["successful_referrals"] as int)} more referrals to unlock next reward",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

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

            Column(
              children: recentReferrals.map((referral) {
                Color statusColor;
                String statusText;
                IconData statusIcon;

                switch ("${referral["status"]}") {
                  case "completed":
                    statusColor = successColor;
                    statusText = "Completed";
                    statusIcon = Icons.check_circle;
                    break;
                  case "pending":
                    statusColor = warningColor;
                    statusText = "Pending";
                    statusIcon = Icons.access_time;
                    break;
                  case "rejected":
                    statusColor = dangerColor;
                    statusText = "Rejected";
                    statusIcon = Icons.cancel;
                    break;
                  default:
                    statusColor = disabledBoldColor;
                    statusText = "Unknown";
                    statusIcon = Icons.help;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${referral["avatar"]}",
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${referral["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Text(
                                  "${referral["date"]}",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(referral["earning"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: (referral["earning"] as double) > 0 ? successColor : disabledBoldColor,
                            ),
                          ),
                          if ("${referral["status"]}" == "pending")
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // View All Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All Referrals",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share Your Referral Code",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.message, "SMS", () {}),
                _buildShareOption(Icons.email, "Email", () {}),
                _buildShareOption(Icons.share, "WhatsApp", () {}),
                _buildShareOption(Icons.link, "Copy Link", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 28,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        title: Text(
          "Referral Program",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "• Earn \$25 for each successful referral\n"
              "• Your friend also gets \$25 bonus\n"
              "• No limit on number of referrals\n"
              "• Earnings can be withdrawn anytime\n"
              "• Special bonuses at milestone achievements",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

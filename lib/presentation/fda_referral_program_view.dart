import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaReferralProgramView extends StatefulWidget {
  const FdaReferralProgramView({super.key});

  @override
  State<FdaReferralProgramView> createState() => _FdaReferralProgramViewState();
}

class _FdaReferralProgramViewState extends State<FdaReferralProgramView> {
  String myReferralCode = "FOODIE2024";
  int totalReferrals = 8;
  double totalEarnings = 240.50;
  int pendingReferrals = 2;
  bool isLoading = false;

  final List<Map<String, dynamic>> referralHistory = [
    {
      "id": "1",
      "friendName": "Sarah Johnson",
      "status": "completed",
      "joinDate": "2024-01-15",
      "earnings": 30.0,
      "friendEarnings": 20.0,
      "ordersCount": 5,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman"
    },
    {
      "id": "2",
      "friendName": "Mike Chen",
      "status": "completed",
      "joinDate": "2024-01-10",
      "earnings": 35.0,
      "friendEarnings": 25.0,
      "ordersCount": 7,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man"
    },
    {
      "id": "3",
      "friendName": "Emma Davis",
      "status": "pending",
      "joinDate": "2024-01-20",
      "earnings": 0.0,
      "friendEarnings": 0.0,
      "ordersCount": 0,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman"
    },
    {
      "id": "4",
      "friendName": "Alex Rodriguez",
      "status": "completed",
      "joinDate": "2024-01-08",
      "earnings": 45.0,
      "friendEarnings": 30.0,
      "ordersCount": 12,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man"
    },
    {
      "id": "5",
      "friendName": "Lisa Park",
      "status": "pending",
      "joinDate": "2024-01-22",
      "earnings": 0.0,
      "friendEarnings": 0.0,
      "ordersCount": 0,
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman"
    }
  ];

  final List<Map<String, dynamic>> rewardTiers = [
    {
      "referrals": 1,
      "yourReward": 30,
      "friendReward": 20,
      "description": "First referral bonus"
    },
    {
      "referrals": 5,
      "yourReward": 50,
      "friendReward": 30,
      "description": "5 friends milestone"
    },
    {
      "referrals": 10,
      "yourReward": 100,
      "friendReward": 50,
      "description": "10 friends milestone"
    },
    {
      "referrals": 25,
      "yourReward": 250,
      "friendReward": 100,
      "description": "VIP referrer status"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showReferralInfo(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsHeader(),
            SizedBox(height: spMd),
            _buildReferralCode(),
            SizedBox(height: spMd),
            _buildRewardTiers(),
            SizedBox(height: spMd),
            _buildReferralHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Container(
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
          Text(
            "Your Referral Stats",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total Referrals", "$totalReferrals", Icons.people),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Total Earnings", "\$${totalEarnings.toStringAsFixed(2)}", Icons.attach_money),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Pending", "$pendingReferrals", Icons.hourglass_empty),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Completed", "${totalReferrals - pendingReferrals}", Icons.check_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCode() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor, width: 2),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Your Referral Code",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor, style: BorderStyle.solid),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    myReferralCode,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => _copyReferralCode(),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Share Code",
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () => _shareReferralCode(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Send Invite",
                  icon: Icons.mail,
                  size: bs.sm,
                  onPressed: () => _sendInvite(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardTiers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reward Tiers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...rewardTiers.map((tier) => _buildRewardTierCard(tier)).toList(),
      ],
    );
  }

  Widget _buildRewardTierCard(Map<String, dynamic> tier) {
    final isAchieved = totalReferrals >= (tier["referrals"] as int);
    final isNext = totalReferrals < (tier["referrals"] as int) && 
                   (rewardTiers.indexOf(tier) == 0 || 
                    totalReferrals >= (rewardTiers[rewardTiers.indexOf(tier) - 1]["referrals"] as int));

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isAchieved ? successColor.withAlpha(30) : 
               isNext ? warningColor.withAlpha(30) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isAchieved ? successColor : 
                 isNext ? warningColor : disabledColor,
          width: 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isAchieved ? successColor : 
                     isNext ? warningColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${tier["referrals"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tier["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isAchieved ? successColor : primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "You: \$${tier["yourReward"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Friend: \$${tier["friendReward"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isAchieved)
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 24,
            )
          else if (isNext)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: warningColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReferralHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Referral History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => _refreshReferrals(),
              child: Icon(
                Icons.refresh,
                color: primaryColor,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...referralHistory.map((referral) => _buildReferralCard(referral)).toList(),
      ],
    );
  }

  Widget _buildReferralCard(Map<String, dynamic> referral) {
    final isCompleted = referral["status"] == "completed";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(
            color: isCompleted ? successColor : warningColor,
            width: 4,
          ),
        ),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${referral["avatar"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${referral["friendName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Joined: ${DateTime.parse(referral["joinDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (isCompleted) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${referral["ordersCount"]} orders placed",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isCompleted ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isCompleted ? "Completed" : "Pending",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isCompleted) ...[
                SizedBox(height: spXs),
                Text(
                  "\$${(referral["earnings"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _copyReferralCode() {
    // Copy to clipboard logic would go here
    ss("Referral code copied to clipboard!");
  }

  void _shareReferralCode() async {
    // Share functionality would go here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Share Referral Code"),
        content: Text("Choose how you'd like to share your referral code:"),
        actions: [
          QButton(
            label: "WhatsApp",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Shared via WhatsApp!");
            },
          ),
          QButton(
            label: "Facebook",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Shared via Facebook!");
            },
          ),
        ],
      ),
    );
  }

  void _sendInvite() async {
    // Send invite logic would go here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Send Invite"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Friend's Phone Number",
              value: "",
              hint: "+1 (555) 123-4567",
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Send",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Invite sent successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _refreshReferrals() async {
    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    isLoading = false;
    setState(() {});

    si("Referral data refreshed!");
  }

  void _showReferralInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How Referrals Work"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. Share your referral code with friends"),
            Text("2. Friend signs up and places first order"),
            Text("3. You both earn rewards!"),
            Text("4. More referrals = bigger rewards"),
            Text("5. Track your progress and earnings"),
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

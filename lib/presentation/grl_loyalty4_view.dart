import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty4View extends StatefulWidget {
  @override
  State<GrlLoyalty4View> createState() => _GrlLoyalty4ViewState();
}

class _GrlLoyalty4ViewState extends State<GrlLoyalty4View> {
  List<Map<String, dynamic>> referrals = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "status": "joined",
      "pointsEarned": 500,
      "joinDate": "2024-06-15",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
    },
    {
      "id": 2,
      "name": "Mike Wilson",
      "email": "mike.w@email.com",
      "status": "joined",
      "pointsEarned": 500,
      "joinDate": "2024-06-10",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
    },
    {
      "id": 3,
      "name": "Emily Davis",
      "email": "emily.d@email.com",
      "status": "pending",
      "pointsEarned": 0,
      "joinDate": "2024-06-20",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
    },
    {
      "id": 4,
      "name": "Alex Brown",
      "email": "alex.b@email.com",
      "status": "joined",
      "pointsEarned": 500,
      "joinDate": "2024-06-05",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
    },
    {
      "id": 5,
      "name": "Lisa Chen",
      "email": "lisa.c@email.com",
      "status": "expired",
      "pointsEarned": 0,
      "joinDate": "2024-05-20",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
    },
  ];

  String referralCode = "JOHN2024";
  int totalReferrals = 4;
  int totalPointsEarned = 1500;
  int pendingReferrals = 1;
  String selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareReferralCode();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReferralStats(),
            SizedBox(height: spLg),
            _buildReferralCode(),
            SizedBox(height: spLg),
            _buildShareOptions(),
            SizedBox(height: spLg),
            _buildReferralProgram(),
            SizedBox(height: spLg),
            _buildReferralsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralStats() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.group_add,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Referral Program",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Earn 500 points per friend",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Referrals", totalReferrals.toString()),
              ),
              Expanded(
                child: _buildStatItem("Points Earned", totalPointsEarned.toString()),
              ),
              Expanded(
                child: _buildStatItem("Pending", pendingReferrals.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildReferralCode() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Referral Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: primaryColor.withAlpha(50),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    referralCode,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle copy to clipboard
                    ss("Referral code copied to clipboard!");
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Share this code with friends to earn 500 points when they join",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOptions() {
    List<Map<String, dynamic>> shareOptions = [
      {
        "name": "WhatsApp",
        "icon": Icons.chat,
        "color": Colors.green,
      },
      {
        "name": "Instagram",
        "icon": Icons.camera_alt,
        "color": Colors.pink,
      },
      {
        "name": "Facebook",
        "icon": Icons.facebook,
        "color": Colors.blue,
      },
      {
        "name": "Twitter",
        "icon": Icons.alternate_email,
        "color": Colors.lightBlue,
      },
      {
        "name": "Email",
        "icon": Icons.email,
        "color": Colors.orange,
      },
      {
        "name": "SMS",
        "icon": Icons.sms,
        "color": Colors.teal,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share with Friends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: shareOptions.map((option) {
              return GestureDetector(
                onTap: () {
                  _shareViaApp(option["name"]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (option["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (option["color"] as Color).withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: option["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          option["icon"] as IconData,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${option["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: option["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralProgram() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How It Works",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildStep(1, "Share Code", "Share your referral code with friends", Icons.share),
          _buildStep(2, "Friend Joins", "Your friend signs up using your code", Icons.person_add),
          _buildStep(3, "Earn Points", "You both get 500 points instantly", Icons.stars),
          _buildStep(4, "Redeem Rewards", "Use points for amazing rewards", Icons.redeem),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildReferralsList() {
    List<Map<String, dynamic>> filteredReferrals = referrals.where((referral) {
      return selectedStatus == "All" || referral["status"] == selectedStatus.toLowerCase();
    }).toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Your Referrals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QCategoryPicker(
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Joined", "value": "Joined"},
                  {"label": "Pending", "value": "Pending"},
                  {"label": "Expired", "value": "Expired"},
                ],
                value: selectedStatus,
                onChanged: (index, label, value, item) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: filteredReferrals.map((referral) {
              String status = referral["status"];
              Color statusColor = status == "joined" ? successColor : 
                                 status == "pending" ? warningColor : dangerColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: statusColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${referral["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${referral["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${referral["email"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Joined: ${referral["joinDate"]}",
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "+${referral["pointsEarned"]} pts",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
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

  void _shareReferralCode() {
    ss("Sharing referral code...");
  }

  void _shareViaApp(String app) {
    ss("Sharing via $app...");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReferral9View extends StatefulWidget {
  @override
  State<GrlReferral9View> createState() => _GrlReferral9ViewState();
}

class _GrlReferral9ViewState extends State<GrlReferral9View> {
  String selectedContest = "monthly_champion";
  bool participateInContest = true;
  
  List<Map<String, dynamic>> activeContests = [
    {
      "title": "Monthly Champion",
      "value": "monthly_champion",
      "description": "Top referrer each month wins the grand prize",
      "prize": 5000.00,
      "duration": "30 days",
      "participants": 2847,
      "endDate": "2024-02-28",
      "status": "active",
      "requirements": ["10+ referrals", "75% conversion rate"],
      "currentRank": 12,
      "totalParticipants": 2847,
      "color": warningColor,
      "icon": Icons.emoji_events,
    },
    {
      "title": "Speed Referral",
      "value": "speed_referral",
      "description": "Most referrals in 24 hours",
      "prize": 1000.00,
      "duration": "24 hours",
      "participants": 1205,
      "endDate": "2024-01-25",
      "status": "active",
      "requirements": ["5+ referrals in 24h"],
      "currentRank": 5,
      "totalParticipants": 1205,
      "color": dangerColor,
      "icon": Icons.flash_on,
    },
    {
      "title": "Team Builder",
      "value": "team_builder",
      "description": "Build the largest referral network",
      "prize": 2500.00,
      "duration": "90 days",
      "participants": 856,
      "endDate": "2024-04-15",
      "status": "active",
      "requirements": ["Build team of 50+ sub-referrers"],
      "currentRank": 23,
      "totalParticipants": 856,
      "color": infoColor,
      "icon": Icons.group,
    },
  ];

  List<Map<String, dynamic>> pastContests = [
    {
      "title": "New Year Kickoff",
      "prize": 3000.00,
      "endDate": "2024-01-15",
      "status": "completed",
      "yourRank": 8,
      "totalParticipants": 1847,
      "reward": 150.00,
      "winner": "Sarah Johnson",
    },
    {
      "title": "Holiday Rush",
      "prize": 2000.00,
      "endDate": "2023-12-31",
      "status": "completed",
      "yourRank": 3,
      "totalParticipants": 2156,
      "reward": 500.00,
      "winner": "Mike Chen",
    },
  ];

  List<Map<String, dynamic>> leaderboardData = [
    {
      "rank": 1,
      "name": "Jessica Martinez",
      "avatar": "https://placehold.co/50x50?text=JM",
      "referrals": 127,
      "points": 8950,
      "tier": "Diamond",
      "country": "USA",
      "trend": "up",
    },
    {
      "rank": 2,
      "name": "Robert Kim", 
      "avatar": "https://placehold.co/50x50?text=RK",
      "referrals": 119,
      "points": 8420,
      "tier": "Platinum",
      "country": "Canada",
      "trend": "up",
    },
    {
      "rank": 3,
      "name": "Elena Rodriguez",
      "avatar": "https://placehold.co/50x50?text=ER",
      "referrals": 105,
      "points": 7890,
      "tier": "Platinum",
      "country": "Spain",
      "trend": "down",
    },
    {
      "rank": 4,
      "name": "David Zhang",
      "avatar": "https://placehold.co/50x50?text=DZ",
      "referrals": 98,
      "points": 7345,
      "tier": "Gold",
      "country": "Singapore",
      "trend": "stable",
    },
    {
      "rank": 5,
      "name": "Anna Williams",
      "avatar": "https://placehold.co/50x50?text=AW",
      "referrals": 94,
      "points": 7120,
      "tier": "Gold",
      "country": "UK",
      "trend": "up",
    },
  ];

  List<Map<String, dynamic>> contestPrizes = [
    {
      "position": "1st Place",
      "prize": "\$5,000 + Diamond Badge",
      "color": warningColor,
      "icon": Icons.looks_one,
    },
    {
      "position": "2nd Place",
      "prize": "\$2,500 + Platinum Badge",
      "color": Colors.grey[400],
      "icon": Icons.looks_two,
    },
    {
      "position": "3rd Place",
      "prize": "\$1,000 + Gold Badge",
      "color": Colors.orange[400],
      "icon": Icons.looks_3,
    },
    {
      "position": "Top 10",
      "prize": "\$250 + Silver Badge",
      "color": infoColor,
      "icon": Icons.star,
    },
    {
      "position": "Top 25",
      "prize": "\$100 + Bronze Badge",
      "color": successColor,
      "icon": Icons.military_tech,
    },
  ];

  Map<String, dynamic> userStats = {
    "currentRank": 12,
    "totalPoints": 3450,
    "monthlyReferrals": 23,
    "conversionRate": 78.5,
    "contestsWon": 2,
    "totalPrizeWon": 850.00,
  };

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedContestData = activeContests
        .firstWhere((contest) => contest["value"] == selectedContest);

    return Scaffold(
      appBar: AppBar(
        title: Text("Contests & Leaderboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Performance Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, infoColor],
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.leaderboard,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Performance",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Rank #${userStats["currentRank"]} this month",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Points",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${userStats["totalPoints"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referrals",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${userStats["monthlyReferrals"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Conversion",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${(userStats["conversionRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Contest Selection
            Container(
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
                    "Active Contests",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Select Contest",
                    items: activeContests,
                    value: selectedContest,
                    onChanged: (value, label) {
                      selectedContest = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Participate in selected contest",
                        "value": true,
                        "checked": participateInContest,
                      }
                    ],
                    value: [
                      if (participateInContest)
                        {
                          "label": "Participate in selected contest",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      participateInContest = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Selected Contest Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: selectedContestData["color"] as Color,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (selectedContestData["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          selectedContestData["icon"] as IconData,
                          color: selectedContestData["color"] as Color,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedContestData["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${selectedContestData["description"]}",
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
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Prize",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${(selectedContestData["prize"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: infoColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Participants",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${selectedContestData["participants"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: warningColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${selectedContestData["duration"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Current Position
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Your Position: #${selectedContestData["currentRank"]} of ${selectedContestData["totalParticipants"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Prize Structure
            Container(
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
                      Icon(
                        Icons.emoji_events,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Prize Structure",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Column(
                    spacing: spSm,
                    children: contestPrizes.map((prize) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (prize["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: prize["color"] as Color,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: prize["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                prize["icon"] as IconData,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${prize["position"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${prize["prize"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: prize["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Live Leaderboard
            Container(
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
                      Icon(
                        Icons.leaderboard,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Live Leaderboard",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                fontSize: 10,
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
                  
                  Column(
                    spacing: spSm,
                    children: leaderboardData.map((participant) {
                      Color rankColor = participant["rank"] == 1 
                          ? warningColor
                          : participant["rank"] == 2
                              ? Colors.grey[400]!
                              : participant["rank"] == 3
                                  ? Colors.orange[400]!
                                  : primaryColor;
                      
                      Color trendColor = participant["trend"] == "up"
                          ? successColor
                          : participant["trend"] == "down"
                              ? dangerColor
                              : disabledColor;
                      
                      IconData trendIcon = participant["trend"] == "up"
                          ? Icons.trending_up
                          : participant["trend"] == "down"
                              ? Icons.trending_down
                              : Icons.trending_flat;

                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: rankColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: rankColor.withAlpha(76),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: rankColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: participant["rank"] <= 3
                                    ? Icon(
                                        Icons.emoji_events,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : Text(
                                        "${participant["rank"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage("${participant["avatar"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${participant["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: rankColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${participant["tier"]}",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${participant["referrals"]} refs • ${participant["country"]}",
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
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${participant["points"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      trendIcon,
                                      color: trendColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Text(
                                  "points",
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
                    }).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Full Leaderboard",
                      size: bs.sm,
                      icon: Icons.list,
                      onPressed: () {
                        si("Opening full leaderboard");
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Past Contest Results
            Container(
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
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Past Contest Results",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Column(
                    spacing: spSm,
                    children: pastContests.map((contest) {
                      Color rankColor = contest["yourRank"] <= 3 
                          ? successColor 
                          : contest["yourRank"] <= 10
                              ? warningColor
                              : infoColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: rankColor.withAlpha(12),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: rankColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: rankColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                contest["yourRank"] <= 3 
                                    ? Icons.emoji_events
                                    : Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${contest["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Winner: ${contest["winner"]} • ${contest["endDate"]}",
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
                                  "Rank #${contest["yourRank"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: rankColor,
                                  ),
                                ),
                                Text(
                                  "+\$${(contest["reward"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
            ),

            // Total Contest Earnings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Contest Earnings",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(230),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${(userStats["totalPrizeWon"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Contests Won",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                      Text(
                        "${userStats["contestsWon"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

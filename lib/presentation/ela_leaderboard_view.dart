import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLeaderboardView extends StatefulWidget {
  const ElaLeaderboardView({super.key});

  @override
  State<ElaLeaderboardView> createState() => _ElaLeaderboardViewState();
}

class _ElaLeaderboardViewState extends State<ElaLeaderboardView> {
  String selectedPeriod = "Week";
  String selectedCategory = "Overall";
  
  List<String> periods = ["Week", "Month", "All Time"];
  List<String> categories = ["Overall", "Reading", "Quizzes", "Courses"];
  
  List<Map<String, dynamic>> leaderboardData = [
    {
      "rank": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "points": 2850,
      "streak": 28,
      "coursesCompleted": 12,
      "quizScore": 95,
      "isMe": false,
      "badge": "🏆",
    },
    {
      "rank": 2,
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "points": 2745,
      "streak": 25,
      "coursesCompleted": 11,
      "quizScore": 92,
      "isMe": false,
      "badge": "🥈",
    },
    {
      "rank": 3,
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=girl",
      "points": 2680,
      "streak": 22,
      "coursesCompleted": 10,
      "quizScore": 90,
      "isMe": false,
      "badge": "🥉",
    },
    {
      "rank": 4,
      "name": "You",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=user",
      "points": 2420,
      "streak": 18,
      "coursesCompleted": 8,
      "quizScore": 88,
      "isMe": true,
      "badge": "",
    },
    {
      "rank": 5,
      "name": "Alex Wilson",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "points": 2350,
      "streak": 15,
      "coursesCompleted": 9,
      "quizScore": 85,
      "isMe": false,
      "badge": "",
    },
    {
      "rank": 6,
      "name": "Lisa Brown",
      "avatar": "https://picsum.photos/40/40?random=6&keyword=woman",
      "points": 2180,
      "streak": 12,
      "coursesCompleted": 7,
      "quizScore": 82,
      "isMe": false,
      "badge": "",
    },
  ];

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.orange[300]!;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
        actions: [
          Icon(
            Icons.leaderboard,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current User Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "Your Rank",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "#4",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "2,420",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Points",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withAlpha(100),
                      ),
                      Column(
                        children: [
                          Text(
                            "18",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Day Streak",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withAlpha(100),
                      ),
                      Column(
                        children: [
                          Text(
                            "88%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Avg Score",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Top 3 Podium
            Text(
              "Top Performers",
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
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 2nd Place
                  _buildPodiumItem(leaderboardData[1], 60),
                  // 1st Place
                  _buildPodiumItem(leaderboardData[0], 80),
                  // 3rd Place
                  _buildPodiumItem(leaderboardData[2], 40),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Full Leaderboard
            Text(
              "Full Rankings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              children: leaderboardData.map((user) {
                bool isMe = user["isMe"] as bool;
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isMe ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: isMe ? Border.all(color: primaryColor, width: 2) : null,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      // Rank
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: getRankColor(user["rank"] as int),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "${user["rank"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),

                      // Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${user["avatar"]}",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),

                      // Name and Badge
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
                                    fontWeight: FontWeight.bold,
                                    color: isMe ? primaryColor : primaryColor,
                                  ),
                                ),
                                if (user["badge"] != "") ...[
                                  SizedBox(width: spXs),
                                  Text(
                                    "${user["badge"]}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                                if (isMe) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "You",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orange,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${user["streak"]} days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.school,
                                  color: primaryColor,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${user["coursesCompleted"]} courses",
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

                      // Points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(user["points"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "points",
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem(Map<String, dynamic> user, double height) {
    return Column(
      children: [
        // Avatar
        ClipRRect(
          borderRadius: BorderRadius.circular(radiusLg),
          child: Image.network(
            "${user["avatar"]}",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: spXs),
        
        // Name
        Text(
          "${user["name"]}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: spXs),
        
        // Badge
        Text(
          "${user["badge"]}",
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: spXs),
        
        // Points
        Text(
          "${(user["points"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        // Podium
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: getRankColor(user["rank"] as int),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusSm),
              topRight: Radius.circular(radiusSm),
            ),
          ),
          child: Center(
            child: Text(
              "${user["rank"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
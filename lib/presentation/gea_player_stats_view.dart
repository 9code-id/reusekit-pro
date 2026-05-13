import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPlayerStatsView extends StatefulWidget {
  const GeaPlayerStatsView({super.key});

  @override
  State<GeaPlayerStatsView> createState() => _GeaPlayerStatsViewState();
}

class _GeaPlayerStatsViewState extends State<GeaPlayerStatsView> {
  int selectedTimePeriod = 0;
  int selectedGameMode = 0;

  List<String> timePeriods = ["All Time", "This Season", "This Month", "This Week"];
  List<String> gameModes = ["All Modes", "Battle Royale", "Arena", "Campaign"];

  Map<String, dynamic> overallStats = {
    "totalKills": 8432,
    "totalDeaths": 3241,
    "kdRatio": 2.60,
    "winRate": 68.5,
    "accuracy": 76.3,
    "headshotRate": 34.2,
    "damageDealt": 2134567,
    "damageReceived": 987432,
    "gamesPlayed": 1247,
    "wins": 854,
    "losses": 393,
    "playtime": "234h 56m"
  };

  List<Map<String, dynamic>> weaponStats = [
    {
      "name": "Assault Rifle",
      "kills": 2847,
      "accuracy": 78.5,
      "headshots": 967,
      "damage": 645732,
      "favorite": true
    },
    {
      "name": "Sniper Rifle",
      "kills": 1523,
      "accuracy": 82.1,
      "headshots": 1204,
      "damage": 523891,
      "favorite": false
    },
    {
      "name": "Shotgun",
      "kills": 1289,
      "accuracy": 65.3,
      "headshots": 234,
      "damage": 287654,
      "favorite": false
    },
    {
      "name": "SMG",
      "kills": 2773,
      "accuracy": 71.2,
      "headshots": 445,
      "damage": 398234,
      "favorite": false
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {"period": "Jan", "kills": 645, "deaths": 287, "wins": 54},
    {"period": "Feb", "kills": 723, "deaths": 301, "wins": 61},
    {"period": "Mar", "kills": 812, "deaths": 334, "wins": 68},
    {"period": "Apr", "kills": 789, "deaths": 298, "wins": 72},
    {"period": "May", "kills": 891, "deaths": 342, "wins": 79},
    {"period": "Jun", "kills": 945, "deaths": 367, "wins": 83},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Statistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Statistics exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilterControls(),
            _buildOverallStats(),
            _buildPerformanceChart(),
            _buildDetailedStats(),
            _buildWeaponStats(),
            _buildComparisonStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: timePeriods.asMap().entries.map((entry) {
                    return {
                      "label": entry.value,
                      "value": entry.key,
                    };
                  }).toList(),
                  value: selectedTimePeriod,
                  onChanged: (value, label) {
                    selectedTimePeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Game Mode",
                  items: gameModes.asMap().entries.map((entry) {
                    return {
                      "label": entry.value,
                      "value": entry.key,
                    };
                  }).toList(),
                  value: selectedGameMode,
                  onChanged: (value, label) {
                    selectedGameMode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overall Performance",
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
            children: [
              _buildStatCard("K/D Ratio", "${overallStats["kdRatio"]}", successColor, Icons.gps_fixed),
              _buildStatCard("Win Rate", "${overallStats["winRate"]}%", infoColor, Icons.emoji_events),
              _buildStatCard("Accuracy", "${overallStats["accuracy"]}%", warningColor, Icons.center_focus_strong),
              _buildStatCard("Headshot Rate", "${overallStats["headshotRate"]}%", dangerColor, Icons.my_location),
              _buildStatCard("Total Kills", "${(overallStats["totalKills"] as int).currency}", primaryColor, Icons.clear_all),
              _buildStatCard("Games Played", "${(overallStats["gamesPlayed"] as int).currency}", secondaryColor, Icons.games),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildChartLegend("Kills", successColor),
                    SizedBox(width: spSm),
                    _buildChartLegend("Deaths", dangerColor),
                    SizedBox(width: spSm),
                    _buildChartLegend("Wins", infoColor),
                  ],
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: performanceData.map((data) => 
                      Expanded(child: _buildChartBar(data))
                    ).toList(),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: performanceData.map((data) => 
                    Expanded(
                      child: Text(
                        "${data["period"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    )
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChartBar(Map<String, dynamic> data) {
    double maxValue = 1000;
    double killsHeight = ((data["kills"] as int) / maxValue) * 120;
    double deathsHeight = ((data["deaths"] as int) / maxValue) * 120;
    double winsHeight = ((data["wins"] as int) / 100) * 120;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 8,
            height: killsHeight,
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(height: 2),
          Container(
            width: 8,
            height: deathsHeight,
            decoration: BoxDecoration(
              color: dangerColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(height: 2),
          Container(
            width: 8,
            height: winsHeight,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStats() {
    List<Map<String, dynamic>> detailedStats = [
      {"label": "Total Damage Dealt", "value": "${((overallStats["damageDealt"] as int) / 1000000).toStringAsFixed(1)}M", "icon": Icons.flash_on, "trend": "+12.5%"},
      {"label": "Total Damage Received", "value": "${((overallStats["damageReceived"] as int) / 1000000).toStringAsFixed(1)}M", "icon": Icons.shield, "trend": "-5.2%"},
      {"label": "Average Survival Time", "value": "12m 34s", "icon": Icons.timer, "trend": "+8.7%"},
      {"label": "First Blood Rate", "value": "42.1%", "icon": Icons.bloodtype, "trend": "+15.3%"},
      {"label": "Clutch Success Rate", "value": "28.9%", "icon": Icons.psychology, "trend": "+22.1%"},
      {"label": "Revive Success Rate", "value": "87.6%", "icon": Icons.favorite, "trend": "+3.4%"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detailed Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: detailedStats.map((stat) => _buildDetailedStatItem(stat)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStatItem(Map<String, dynamic> stat) {
    bool isPositiveTrend = stat["trend"].toString().startsWith('+');
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(stat["icon"], color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stat["label"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stat["value"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: isPositiveTrend ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: isPositiveTrend ? successColor : dangerColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${stat["trend"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isPositiveTrend ? successColor : dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponStats() {
    return Container(
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
              Icon(Icons.sports_kabaddi, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Weapon Statistics",
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
            children: weaponStats.map((weapon) => _buildWeaponItem(weapon)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponItem(Map<String, dynamic> weapon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: weapon["favorite"] ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: weapon["favorite"] ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${weapon["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (weapon["favorite"])
                Icon(Icons.favorite, color: dangerColor, size: 20),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildWeaponStat("Kills", "${weapon["kills"]}"),
              ),
              Expanded(
                child: _buildWeaponStat("Accuracy", "${weapon["accuracy"]}%"),
              ),
              Expanded(
                child: _buildWeaponStat("Headshots", "${weapon["headshots"]}"),
              ),
              Expanded(
                child: _buildWeaponStat("Damage", "${((weapon["damage"] as int) / 1000).toStringAsFixed(0)}K"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonStats() {
    List<Map<String, dynamic>> comparisons = [
      {
        "metric": "K/D Ratio",
        "myValue": 2.60,
        "avgValue": 1.45,
        "betterThan": 78.2
      },
      {
        "metric": "Win Rate",
        "myValue": 68.5,
        "avgValue": 45.3,
        "betterThan": 85.7
      },
      {
        "metric": "Accuracy", 
        "myValue": 76.3,
        "avgValue": 62.1,
        "betterThan": 72.4
      },
      {
        "metric": "Headshot Rate",
        "myValue": 34.2,
        "avgValue": 28.7,
        "betterThan": 69.8
      },
    ];

    return Container(
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
              Icon(Icons.compare_arrows, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Player Comparison",
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
            spacing: spMd,
            children: comparisons.map((comparison) => _buildComparisonItem(comparison)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(Map<String, dynamic> comparison) {
    double percentage = (comparison["betterThan"] as double) / 100;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "${comparison["metric"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
            Text(
              "Better than ${comparison["betterThan"]}% of players",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Row(
          children: [
            Text(
              "You: ${comparison["myValue"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Text(
              "Average: ${comparison["avgValue"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            percentage >= 0.8 ? successColor : 
            percentage >= 0.6 ? warningColor : 
            infoColor,
          ),
        ),
      ],
    );
  }
}

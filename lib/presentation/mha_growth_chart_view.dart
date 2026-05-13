import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaGrowthChartView extends StatefulWidget {
  const MhaGrowthChartView({super.key});

  @override
  State<MhaGrowthChartView> createState() => _MhaGrowthChartViewState();
}

class _MhaGrowthChartViewState extends State<MhaGrowthChartView> {
  int currentTab = 0;
  String selectedChild = "Emma Rose";
  String selectedMetric = "Weight";
  
  // Sample children data
  final List<Map<String, dynamic>> children = [
    {
      "name": "Emma Rose",
      "birth_date": "2024-09-15",
      "age_months": 9,
      "gender": "Female",
      "photo": "https://picsum.photos/80/80?random=1&keyword=baby"
    },
    {
      "name": "James Oliver",
      "birth_date": "2022-03-10",
      "age_months": 27,
      "gender": "Male",
      "photo": "https://picsum.photos/80/80?random=2&keyword=boy"
    },
  ];

  // Sample weight data
  final Map<String, List<Map<String, dynamic>>> weightData = {
    "Emma Rose": [
      {"age_months": 0, "value": 3.2, "percentile": 45, "date": "2024-09-15"},
      {"age_months": 1, "value": 4.1, "percentile": 50, "date": "2024-10-15"},
      {"age_months": 2, "value": 5.2, "percentile": 55, "date": "2024-11-15"},
      {"age_months": 3, "value": 6.0, "percentile": 52, "date": "2024-12-15"},
      {"age_months": 4, "value": 6.8, "percentile": 58, "date": "2025-01-15"},
      {"age_months": 5, "value": 7.3, "percentile": 55, "date": "2025-02-15"},
      {"age_months": 6, "value": 7.6, "percentile": 53, "date": "2025-03-15"},
      {"age_months": 7, "value": 7.8, "percentile": 55, "date": "2025-04-15"},
      {"age_months": 8, "value": 8.1, "percentile": 58, "date": "2025-05-15"},
      {"age_months": 9, "value": 8.5, "percentile": 60, "date": "2025-06-15"},
    ],
    "James Oliver": [
      {"age_months": 0, "value": 3.5, "percentile": 55, "date": "2022-03-10"},
      {"age_months": 6, "value": 8.2, "percentile": 60, "date": "2022-09-10"},
      {"age_months": 12, "value": 10.5, "percentile": 65, "date": "2023-03-10"},
      {"age_months": 18, "value": 11.8, "percentile": 62, "date": "2023-09-10"},
      {"age_months": 24, "value": 13.2, "percentile": 68, "date": "2024-03-10"},
      {"age_months": 27, "value": 14.1, "percentile": 70, "date": "2024-06-10"},
    ],
  };

  // Sample height data
  final Map<String, List<Map<String, dynamic>>> heightData = {
    "Emma Rose": [
      {"age_months": 0, "value": 48.0, "percentile": 42, "date": "2024-09-15"},
      {"age_months": 1, "value": 52.5, "percentile": 45, "date": "2024-10-15"},
      {"age_months": 2, "value": 56.8, "percentile": 48, "date": "2024-11-15"},
      {"age_months": 3, "value": 60.2, "percentile": 50, "date": "2024-12-15"},
      {"age_months": 4, "value": 62.5, "percentile": 52, "date": "2025-01-15"},
      {"age_months": 5, "value": 64.1, "percentile": 48, "date": "2025-02-15"},
      {"age_months": 6, "value": 65.8, "percentile": 50, "date": "2025-03-15"},
      {"age_months": 7, "value": 66.5, "percentile": 52, "date": "2025-04-15"},
      {"age_months": 8, "value": 67.2, "percentile": 55, "date": "2025-05-15"},
      {"age_months": 9, "value": 68.0, "percentile": 55, "date": "2025-06-15"},
    ],
    "James Oliver": [
      {"age_months": 0, "value": 50.2, "percentile": 58, "date": "2022-03-10"},
      {"age_months": 6, "value": 68.5, "percentile": 62, "date": "2022-09-10"},
      {"age_months": 12, "value": 76.8, "percentile": 65, "date": "2023-03-10"},
      {"age_months": 18, "value": 82.3, "percentile": 68, "date": "2023-09-10"},
      {"age_months": 24, "value": 87.5, "percentile": 70, "date": "2024-03-10"},
      {"age_months": 27, "value": 90.2, "percentile": 72, "date": "2024-06-10"},
    ],
  };

  // Sample head circumference data
  final Map<String, List<Map<String, dynamic>>> headData = {
    "Emma Rose": [
      {"age_months": 0, "value": 34.5, "percentile": 48, "date": "2024-09-15"},
      {"age_months": 1, "value": 37.2, "percentile": 50, "date": "2024-10-15"},
      {"age_months": 2, "value": 39.1, "percentile": 52, "date": "2024-11-15"},
      {"age_months": 3, "value": 40.8, "percentile": 55, "date": "2024-12-15"},
      {"age_months": 6, "value": 43.2, "percentile": 52, "date": "2025-03-15"},
      {"age_months": 9, "value": 44.5, "percentile": 58, "date": "2025-06-15"},
    ],
  };

  final List<Map<String, dynamic>> milestones = [
    {
      "age_months": 2,
      "milestone": "Holds head up",
      "category": "Motor",
      "achieved": true,
      "color": successColor
    },
    {
      "age_months": 4,
      "milestone": "Rolls over",
      "category": "Motor",
      "achieved": true,
      "color": successColor
    },
    {
      "age_months": 6,
      "milestone": "Sits without support",
      "category": "Motor",
      "achieved": true,
      "color": successColor
    },
    {
      "age_months": 8,
      "milestone": "Crawls",
      "category": "Motor",
      "achieved": true,
      "color": successColor
    },
    {
      "age_months": 12,
      "milestone": "First steps",
      "category": "Motor",
      "achieved": false,
      "color": warningColor
    },
    {
      "age_months": 12,
      "milestone": "Says first words",
      "category": "Language",
      "achieved": false,
      "color": warningColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Growth Charts",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Weight", icon: Icon(Icons.monitor_weight)),
        Tab(text: "Height", icon: Icon(Icons.height)),
        Tab(text: "Head", icon: Icon(Icons.circle)),
        Tab(text: "Milestones", icon: Icon(Icons.emoji_events)),
        Tab(text: "Percentiles", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildWeightTab(),
        _buildHeightTab(),
        _buildHeadTab(),
        _buildMilestonesTab(),
        _buildPercentilesTab(),
      ],
    );
  }

  Widget _buildWeightTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Selection
          _buildChildSelector(),
          SizedBox(height: spMd),
          
          // Current Stats Card
          Container(
            width: double.infinity,
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
            child: Column(
              children: [
                Text(
                  "Current Weight",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentValue("Weight")} kg",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentPercentile("Weight")}th Percentile",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Chart Placeholder
          Container(
            width: double.infinity,
            height: 250,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Weight Growth Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: successColor.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            color: successColor,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Interactive Growth Chart",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Track weight progress over time",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Weight History
          _buildDataHistory("Weight", weightData[selectedChild] ?? []),
        ],
      ),
    );
  }

  Widget _buildHeightTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Selection
          _buildChildSelector(),
          SizedBox(height: spMd),
          
          // Current Stats Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor, infoColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "Current Height",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentValue("Height")} cm",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentPercentile("Height")}th Percentile",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Chart Placeholder
          Container(
            width: double.infinity,
            height: 250,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Height Growth Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: infoColor,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Height Growth Curve",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Monitor height development",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Height History
          _buildDataHistory("Height", heightData[selectedChild] ?? []),
        ],
      ),
    );
  }

  Widget _buildHeadTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Selection
          _buildChildSelector(),
          SizedBox(height: spMd),
          
          // Current Stats Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor, warningColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "Head Circumference",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentValue("Head")} cm",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getCurrentPercentile("Head")}th Percentile",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Chart Placeholder
          Container(
            width: double.infinity,
            height: 250,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Head Circumference Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.donut_small,
                            color: warningColor,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Head Growth Chart",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Monitor brain development",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Head Circumference History
          _buildDataHistory("Head", headData[selectedChild] ?? []),
        ],
      ),
    );
  }

  Widget _buildMilestonesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Selection
          _buildChildSelector(),
          SizedBox(height: spMd),
          
          Text(
            "Developmental Milestones",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Progress Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Milestone Progress",
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
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${milestones.where((m) => m["achieved"] == true).length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Achieved",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.schedule,
                              color: warningColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${milestones.where((m) => m["achieved"] == false).length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Upcoming",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              Icons.percent,
                              color: infoColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((milestones.where((m) => m["achieved"] == true).length / milestones.length) * 100).round()}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Complete",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Milestones List
          ...milestones.map((milestone) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: milestone["color"],
                    width: 4,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (milestone["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Center(
                      child: Text(
                        "${milestone["age_months"]}m",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: milestone["color"],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${milestone["milestone"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (milestone["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${milestone["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: milestone["color"],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    milestone["achieved"] ? Icons.check_circle : Icons.schedule,
                    color: milestone["color"],
                    size: 24,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPercentilesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Selection
          _buildChildSelector(),
          SizedBox(height: spMd),
          
          Text(
            "Growth Percentiles",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Current Percentiles Card
          Container(
            width: double.infinity,
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
                  "Current Percentiles",
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
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_getCurrentPercentile("Weight")}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "th",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_getCurrentPercentile("Height")}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "th",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_getCurrentPercentile("Head")}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "th",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Head",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
          
          SizedBox(height: spMd),
          
          // Percentile Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: infoColor.withAlpha(60),
                width: 1,
              ),
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
                      "Understanding Percentiles",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Percentiles show how your child compares to other children of the same age and gender. For example, being in the 60th percentile means your child is larger than 60% of children their age.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Growth Trends
          Container(
            width: double.infinity,
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
                  "Growth Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Healthy Growth Pattern",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Your child is following a consistent growth curve, which is more important than the exact percentile.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildSelector() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QHorizontalScroll(
        children: children.map((child) {
          bool isSelected = selectedChild == child["name"];
          return GestureDetector(
            onTap: () {
              selectedChild = child["name"];
              setState(() {});
            },
            child: Container(
              width: 120,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(30) : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(child["photo"]),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${child["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${child["age_months"]} months",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDataHistory(String type, List<Map<String, dynamic>> data) {
    return Container(
      width: double.infinity,
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
            "$type History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...data.take(5).map((record) {
            String unit = type == "Weight" ? "kg" : "cm";
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${record["age_months"]} months",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${record["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${record["value"]} $unit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${record["percentile"]}th percentile",
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
        ],
      ),
    );
  }

  double _getCurrentValue(String type) {
    List<Map<String, dynamic>>? data;
    switch (type) {
      case "Weight":
        data = weightData[selectedChild];
        break;
      case "Height":
        data = heightData[selectedChild];
        break;
      case "Head":
        data = headData[selectedChild];
        break;
    }
    if (data == null || data.isEmpty) return 0.0;
    return (data.last["value"] as num).toDouble();
  }

  int _getCurrentPercentile(String type) {
    List<Map<String, dynamic>>? data;
    switch (type) {
      case "Weight":
        data = weightData[selectedChild];
        break;
      case "Height":
        data = heightData[selectedChild];
        break;
      case "Head":
        data = headData[selectedChild];
        break;
    }
    if (data == null || data.isEmpty) return 0;
    return (data.last["percentile"] as num).toInt();
  }
}

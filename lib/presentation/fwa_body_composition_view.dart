import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBodyCompositionView extends StatefulWidget {
  const FwaBodyCompositionView({super.key});

  @override
  State<FwaBodyCompositionView> createState() => _FwaBodyCompositionViewState();
}

class _FwaBodyCompositionViewState extends State<FwaBodyCompositionView> {
  List<Map<String, dynamic>> bodyCompositionData = [
    {
      "metric": "Body Fat",
      "value": 18.5,
      "unit": "%",
      "trend": "down",
      "target": 15.0,
      "color": warningColor,
      "icon": Icons.fitness_center,
    },
    {
      "metric": "Muscle Mass",
      "value": 65.2,
      "unit": "kg",
      "trend": "up",
      "target": 70.0,
      "color": successColor,
      "icon": Icons.local_fire_department,
    },
    {
      "metric": "Bone Mass",
      "value": 3.1,
      "unit": "kg",
      "trend": "stable",
      "target": 3.2,
      "color": infoColor,
      "icon": Icons.architecture,
    },
    {
      "metric": "Water",
      "value": 62.8,
      "unit": "%",
      "trend": "up",
      "target": 65.0,
      "color": primaryColor,
      "icon": Icons.water_drop,
    },
    {
      "metric": "Visceral Fat",
      "value": 8.0,
      "unit": "rating",
      "trend": "down",
      "target": 6.0,
      "color": dangerColor,
      "icon": Icons.warning,
    },
    {
      "metric": "Metabolic Age",
      "value": 26.0,
      "unit": "years",
      "trend": "down",
      "target": 25.0,
      "color": successColor,
      "icon": Icons.schedule,
    },
  ];

  List<Map<String, dynamic>> historyData = [
    {
      "date": "2024-01-15",
      "bodyFat": 19.2,
      "muscleMass": 64.1,
      "water": 61.5,
    },
    {
      "date": "2024-02-15",
      "bodyFat": 18.8,
      "muscleMass": 64.8,
      "water": 62.1,
    },
    {
      "date": "2024-03-15",
      "bodyFat": 18.5,
      "muscleMass": 65.2,
      "water": 62.8,
    },
  ];

  String selectedPeriod = "3 Months";
  List<String> periodOptions = ["1 Month", "3 Months", "6 Months", "1 Year"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Composition"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCard(),
            SizedBox(height: spMd),
            _buildCompositionMetrics(),
            SizedBox(height: spMd),
            _buildTrendChart(),
            SizedBox(height: spMd),
            _buildRecommendations(),
            SizedBox(height: spMd),
            _buildHistorySection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewMeasurement();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                Icons.assessment,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latest Analysis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "March 15, 2024",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildQuickStat("Body Fat", "18.5%", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStat("Muscle", "65.2kg", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStat("BMI", "23.4", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompositionMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detailed Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: bodyCompositionData.map((metric) {
            return _buildMetricCard(metric);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    Color trendColor = metric["trend"] == "up" 
        ? successColor 
        : metric["trend"] == "down" 
            ? dangerColor 
            : disabledBoldColor;
    
    IconData trendIcon = metric["trend"] == "up" 
        ? Icons.trending_up 
        : metric["trend"] == "down" 
            ? Icons.trending_down 
            : Icons.trending_flat;

    double progress = (metric["value"] as double) / (metric["target"] as double);
    if (progress > 1.0) progress = 1.0;

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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Icon(
                trendIcon,
                color: trendColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${metric["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Target: ${metric["target"]}${metric["unit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
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
              Expanded(
                child: Text(
                  "Progress Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  selectedPeriod,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: successColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Positive Trends Detected",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Body fat decreased by 0.7% this month",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Increase Protein Intake",
        "description": "Aim for 2.2g per kg body weight to support muscle growth",
        "icon": Icons.restaurant,
        "color": successColor,
      },
      {
        "title": "Add Strength Training",
        "description": "3-4 sessions per week to improve muscle mass",
        "icon": Icons.fitness_center,
        "color": warningColor,
      },
      {
        "title": "Hydration Focus",
        "description": "Increase water intake to reach 65% body water",
        "icon": Icons.water_drop,
        "color": infoColor,
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
          Text(
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: recommendations.map((rec) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (rec["color"] as Color).withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: rec["color"] as Color,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      rec["icon"] as IconData,
                      color: rec["color"] as Color,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${rec["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${rec["description"]}",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
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
              Expanded(
                child: Text(
                  "Recent History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: historyData.reversed.map((entry) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.analytics,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateTime.parse("${entry["date"]}").dMMMy,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Fat: ${entry["bodyFat"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Muscle: ${entry["muscleMass"]}kg",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _addNewMeasurement() {
    // Add new measurement logic
  }

  void _showInfoDialog() {
    // Show info about body composition
  }
}

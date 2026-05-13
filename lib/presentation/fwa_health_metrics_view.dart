import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaHealthMetricsView extends StatefulWidget {
  const FwaHealthMetricsView({super.key});

  @override
  State<FwaHealthMetricsView> createState() => _FwaHealthMetricsViewState();
}

class _FwaHealthMetricsViewState extends State<FwaHealthMetricsView> {
  List<Map<String, dynamic>> healthMetrics = [
    {
      "title": "Weight",
      "value": 68.5,
      "unit": "kg",
      "trend": "down",
      "change": -1.2,
      "icon": Icons.monitor_weight,
      "color": successColor,
      "target": 65.0,
      "progress": 0.7
    },
    {
      "title": "Body Fat",
      "value": 18.2,
      "unit": "%",
      "trend": "down",
      "change": -0.8,
      "icon": Icons.fitness_center,
      "color": warningColor,
      "target": 15.0,
      "progress": 0.6
    },
    {
      "title": "Muscle Mass",
      "value": 42.8,
      "unit": "kg",
      "trend": "up",
      "change": 0.5,
      "icon": Icons.accessibility_new,
      "color": primaryColor,
      "target": 45.0,
      "progress": 0.8
    },
    {
      "title": "BMI",
      "value": 22.4,
      "unit": "",
      "trend": "down",
      "change": -0.3,
      "icon": Icons.straighten,
      "color": successColor,
      "target": 21.0,
      "progress": 0.9
    },
    {
      "title": "Water %",
      "value": 58.3,
      "unit": "%",
      "trend": "up",
      "change": 0.4,
      "icon": Icons.water_drop,
      "color": infoColor,
      "target": 60.0,
      "progress": 0.8
    },
    {
      "title": "Visceral Fat",
      "value": 8.0,
      "unit": "level",
      "trend": "stable",
      "change": 0.0,
      "icon": Icons.favorite,
      "color": successColor,
      "target": 7.0,
      "progress": 0.7
    }
  ];

  List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "weight": 70.2, "bodyFat": 19.1},
    {"day": "Tue", "weight": 69.8, "bodyFat": 18.9},
    {"day": "Wed", "weight": 69.5, "bodyFat": 18.7},
    {"day": "Thu", "weight": 69.2, "bodyFat": 18.5},
    {"day": "Fri", "weight": 68.9, "bodyFat": 18.3},
    {"day": "Sat", "weight": 68.7, "bodyFat": 18.2},
    {"day": "Sun", "weight": 68.5, "bodyFat": 18.2}
  ];

  String selectedPeriod = "Week";
  List<String> periods = ["Week", "Month", "3 Months", "Year"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('Add Measurement')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time Period",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QCategoryPicker(
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
                    value: selectedPeriod,
                    onChanged: (index, label, value, item) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Health Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"],
                              size: 20,
                              color: metric["color"],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            metric["trend"] == "up" ? Icons.arrow_upward :
                            metric["trend"] == "down" ? Icons.arrow_downward :
                            Icons.remove,
                            size: 16,
                            color: metric["trend"] == "up" ? successColor :
                                  metric["trend"] == "down" ? dangerColor :
                                  disabledBoldColor,
                          ),
                        ],
                      ),
                      Row(
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
                      if ((metric["change"] as double) != 0.0)
                        Text(
                          "${(metric["change"] as double) > 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)} this week",
                          style: TextStyle(
                            fontSize: 12,
                            color: (metric["change"] as double) > 0 ? 
                                  (metric["trend"] == "up" ? successColor : dangerColor) :
                                  (metric["trend"] == "down" ? successColor : dangerColor),
                          ),
                        ),
                      SizedBox(height: spSm),
                      // Progress to target
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Target: ${metric["target"]} ${metric["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${((metric["progress"] as double) * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: metric["progress"],
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(metric["color"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Weekly Chart
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Row(
                      children: weeklyData.map((data) {
                        double maxWeight = weeklyData.map((d) => d["weight"] as double).reduce((a, b) => a > b ? a : b);
                        double minWeight = weeklyData.map((d) => d["weight"] as double).reduce((a, b) => a < b ? a : b);
                        double normalizedHeight = (((data["weight"] as double) - minWeight) / (maxWeight - minWeight)) * 150 + 30;
                        
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${data["weight"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      width: 20,
                                      height: normalizedHeight,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${data["day"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Log Weight",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('Log Weight')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Body Scan",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('Body Scan')
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View History",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('Metrics History')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('Export Data')
                          },
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

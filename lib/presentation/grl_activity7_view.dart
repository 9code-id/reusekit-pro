import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity7View extends StatefulWidget {
  @override
  State<GrlActivity7View> createState() => _GrlActivity7ViewState();
}

class _GrlActivity7ViewState extends State<GrlActivity7View> {
  int selectedMetric = 0;
  String selectedPeriod = "Week";
  
  final List<String> metrics = ["Steps", "Calories", "Distance", "Active Time"];
  final List<String> periods = ["Week", "Month", "3 Months", "Year"];
  
  final List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "steps": 8500, "calories": 420, "distance": 6.2, "activeTime": 45},
    {"day": "Tue", "steps": 7200, "calories": 350, "distance": 5.1, "activeTime": 38},
    {"day": "Wed", "steps": 9800, "calories": 480, "distance": 7.3, "activeTime": 52},
    {"day": "Thu", "steps": 6400, "calories": 310, "distance": 4.8, "activeTime": 35},
    {"day": "Fri", "steps": 10200, "calories": 520, "distance": 8.1, "activeTime": 58},
    {"day": "Sat", "steps": 12100, "calories": 610, "distance": 9.4, "activeTime": 65},
    {"day": "Sun", "steps": 5800, "calories": 280, "distance": 4.2, "activeTime": 32},
  ];

  final List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "avgSteps": 8200, "totalCalories": 12500, "totalDistance": 185.6, "totalTime": 1420},
    {"month": "Feb", "avgSteps": 8600, "totalCalories": 13200, "totalDistance": 195.2, "totalTime": 1580},
    {"month": "Mar", "avgSteps": 9100, "totalCalories": 14100, "totalDistance": 208.7, "totalTime": 1720},
    {"month": "Apr", "avgSteps": 8800, "totalCalories": 13800, "totalDistance": 201.3, "totalTime": 1650},
    {"month": "May", "avgSteps": 9500, "totalCalories": 14800, "totalDistance": 218.9, "totalTime": 1820},
    {"month": "Jun", "avgSteps": 10200, "totalCalories": 15600, "totalDistance": 235.4, "totalTime": 1950},
  ];

  final List<Map<String, dynamic>> personalRecords = [
    {
      "title": "Daily Steps",
      "value": "15,420",
      "unit": "steps",
      "date": "2024-06-15",
      "icon": Icons.directions_walk,
      "color": "blue",
      "improvement": "+1,200 from previous best"
    },
    {
      "title": "Weekly Calories",
      "value": "3,850",
      "unit": "calories",
      "date": "Week of Jun 10",
      "icon": Icons.local_fire_department,
      "color": "red",
      "improvement": "+350 from previous best"
    },
    {
      "title": "Monthly Distance",
      "value": "248.6",
      "unit": "km",
      "date": "June 2024",
      "icon": Icons.straighten,
      "color": "green",
      "improvement": "+15.2 km from previous best"
    },
    {
      "title": "Longest Workout",
      "value": "125",
      "unit": "minutes",
      "date": "2024-06-18",
      "icon": Icons.timer,
      "color": "purple",
      "improvement": "+18 min from previous best"
    },
  ];

  final List<Map<String, dynamic>> insights = [
    {
      "title": "Most Active Day",
      "value": "Saturday",
      "description": "You're 35% more active on weekends",
      "icon": Icons.trending_up,
      "color": "green"
    },
    {
      "title": "Peak Activity Time",
      "value": "6:00 PM",
      "description": "Evening workouts yield best results",
      "icon": Icons.schedule,
      "color": "blue"
    },
    {
      "title": "Consistency Score",
      "value": "87%",
      "description": "Great job maintaining regular activity",
      "icon": Icons.check_circle,
      "color": "green"
    },
    {
      "title": "Improvement Rate",
      "value": "+18%",
      "description": "Performance improved since last month",
      "icon": Icons.show_chart,
      "color": "purple"
    },
  ];

  Color _getMetricColor(String colorName) {
    switch (colorName) {
      case "blue": return primaryColor;
      case "red": return dangerColor;
      case "green": return successColor;
      case "purple": return Color(0xFF9C27B0);
      case "orange": return warningColor;
      default: return disabledColor;
    }
  }

  List<Map<String, dynamic>> get currentData {
    switch (selectedPeriod) {
      case "Week":
        return weeklyData;
      case "Month":
        return monthlyTrends;
      default:
        return weeklyData;
    }
  }

  double _getMaxValue() {
    String metricKey = metrics[selectedMetric].toLowerCase().replaceAll(' ', '');
    if (metricKey == "activetime") metricKey = "activeTime";
    
    return currentData.map((data) => 
      (data[metricKey] as num).toDouble()).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    String metricKey = metrics[selectedMetric].toLowerCase().replaceAll(' ', '');
    if (metricKey == "activetime") metricKey = "activeTime";
    double maxValue = _getMaxValue();
    
    // Calculate totals
    int totalSteps = weeklyData.fold(0, (sum, day) => sum + (day["steps"] as int));
    int totalCalories = weeklyData.fold(0, (sum, day) => sum + (day["calories"] as int));
    double totalDistance = weeklyData.fold(0.0, (sum, day) => sum + (day["distance"] as double));
    int totalTime = weeklyData.fold(0, (sum, day) => sum + (day["activeTime"] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period and Metric Selectors
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
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
                ),
              ],
            ),

            // Metric Tabs
            QCategoryPicker(
              items: metrics.map((metric) => {
                "label": metric,
                "value": metric,
              }).toList(),
              value: metrics[selectedMetric],
              onChanged: (index, label, value, item) {
                selectedMetric = index;
                setState(() {});
              },
            ),

            // Summary Stats Row
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
                        Icon(
                          Icons.directions_walk,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalSteps / 1000).toStringAsFixed(1)}k",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Steps",
                          style: TextStyle(
                            fontSize: 11,
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
                        Icon(
                          Icons.local_fire_department,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalCalories / 1000).toStringAsFixed(1)}k",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Calories",
                          style: TextStyle(
                            fontSize: 11,
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
                        Icon(
                          Icons.straighten,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${totalDistance.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "km",
                          style: TextStyle(
                            fontSize: 11,
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
                        Icon(
                          Icons.timer,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalTime / 60).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Chart Container
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "${metrics[selectedMetric]} - $selectedPeriod",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: currentData.map((data) {
                        double value = (data[metricKey] as num).toDouble();
                        double heightPercent = value / maxValue;
                        String label = selectedPeriod == "Month" ? "${data["month"]}" : "${data["day"]}";
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${value.toInt()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: 20,
                                  height: 160 * heightPercent,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  label,
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
                  ),
                ],
              ),
            ),

            // Personal Records
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Personal Records",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: personalRecords.map((record) {
                      Color color = _getMetricColor("${record["color"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: color,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  record["icon"] as IconData,
                                  color: color,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${record["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${record["value"]} ",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${record["unit"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Text(
                              "${record["date"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${record["improvement"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
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

            // Activity Insights
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Activity Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: insights.map((insight) {
                      Color color = _getMetricColor("${insight["color"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: color.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                insight["icon"] as IconData,
                                color: color,
                                size: 24,
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${insight["title"]}: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${insight["value"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Text(
                                    "${insight["description"]}",
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
            ),

            // Comparison Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Performance Comparison",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "This Week",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(totalSteps / 1000).toStringAsFixed(1)}k",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "steps",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        width: 1,
                        height: 60,
                        color: disabledColor,
                      ),
                      
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Last Week",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "52.1k",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "steps",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        width: 1,
                        height: 60,
                        color: disabledColor,
                      ),
                      
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "+7.9k",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "+15%",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
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
          ],
        ),
      ),
    );
  }
}

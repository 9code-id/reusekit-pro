import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaCropConditionsView extends StatefulWidget {
  const WcaCropConditionsView({super.key});

  @override
  State<WcaCropConditionsView> createState() => _WcaCropConditionsViewState();
}

class _WcaCropConditionsViewState extends State<WcaCropConditionsView> {
  String selectedField = "North Field";
  String selectedCrop = "Corn";
  int currentTab = 0;

  List<Map<String, dynamic>> fieldOptions = [
    {"label": "North Field", "value": "North Field"},
    {"label": "South Field", "value": "South Field"},
    {"label": "East Field", "value": "East Field"},
    {"label": "West Field", "value": "West Field"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Cotton", "value": "Cotton"},
  ];

  List<Map<String, dynamic>> cropHealthMetrics = [
    {
      "title": "Overall Health",
      "value": "87",
      "unit": "%",
      "status": "Good",
      "color": successColor,
      "icon": Icons.agriculture,
      "trend": "up",
    },
    {
      "title": "Growth Stage",
      "value": "V6",
      "unit": "Stage",
      "status": "On Track",
      "color": primaryColor,
      "icon": Icons.eco,
      "trend": "stable",
    },
    {
      "title": "Water Stress",
      "value": "Low",
      "unit": "Level",
      "status": "Optimal",
      "color": infoColor,
      "icon": Icons.water_drop,
      "trend": "down",
    },
    {
      "title": "Disease Risk",
      "value": "Medium",
      "unit": "Risk",
      "status": "Monitor",
      "color": warningColor,
      "icon": Icons.health_and_safety,
      "trend": "up",
    },
  ];

  List<Map<String, dynamic>> environmentalFactors = [
    {
      "factor": "Soil Temperature",
      "current": "72°F",
      "optimal": "68-75°F",
      "status": "Optimal",
      "color": successColor,
    },
    {
      "factor": "Soil Moisture",
      "current": "65%",
      "optimal": "60-70%",
      "status": "Good",
      "color": successColor,
    },
    {
      "factor": "Air Temperature",
      "current": "82°F",
      "optimal": "70-85°F",
      "status": "Good",
      "color": successColor,
    },
    {
      "factor": "Humidity",
      "current": "58%",
      "optimal": "50-65%",
      "status": "Optimal",
      "color": successColor,
    },
    {
      "factor": "Sunlight Hours",
      "current": "12.5 hrs",
      "optimal": "12-14 hrs",
      "status": "Good",
      "color": successColor,
    },
    {
      "factor": "Wind Speed",
      "current": "8 mph",
      "optimal": "5-15 mph",
      "status": "Optimal",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {
      "week": "Week 1",
      "health": 82,
      "growth": "V4",
      "weather": "Favorable",
      "irrigation": "Normal",
    },
    {
      "week": "Week 2",
      "health": 85,
      "growth": "V5",
      "weather": "Dry Spell",
      "irrigation": "Increased",
    },
    {
      "week": "Week 3",
      "health": 87,
      "growth": "V6",
      "weather": "Rain",
      "irrigation": "Reduced",
    },
    {
      "week": "Week 4",
      "health": 89,
      "growth": "V7",
      "weather": "Optimal",
      "irrigation": "Normal",
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "Irrigation",
      "message": "Consider irrigation in 2-3 days based on soil moisture levels",
      "priority": "medium",
      "time": "2 hours ago",
      "icon": Icons.water_drop,
    },
    {
      "type": "Pest Alert",
      "message": "Corn borer activity detected in neighboring fields",
      "priority": "high",
      "time": "5 hours ago",
      "icon": Icons.bug_report,
    },
    {
      "type": "Weather",
      "message": "High winds expected tomorrow - monitor young plants",
      "priority": "medium",
      "time": "1 day ago",
      "icon": Icons.air,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              si("Take crop photos for analysis");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing crop data...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor.withAlpha(20),
                    primaryColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.agriculture,
                    color: successColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Crop Health Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Real-time monitoring of crop conditions and environmental factors",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Field",
                    items: fieldOptions,
                    value: selectedField,
                    onChanged: (value, label) {
                      selectedField = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Crop Type",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Current Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: cropHealthMetrics.map((metric) {
                IconData trendIcon = metric["trend"] == "up"
                    ? Icons.trending_up
                    : metric["trend"] == "down"
                        ? Icons.trending_down
                        : Icons.trending_flat;

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
                          Icon(
                            metric["icon"],
                            color: metric["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Icon(
                            trendIcon,
                            color: metric["color"],
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
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
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: metric["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${metric["status"]}",
                          style: TextStyle(
                            color: metric["color"],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Environmental Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: environmentalFactors.map((factor) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${factor["factor"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Optimal: ${factor["optimal"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${factor["current"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: factor["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${factor["status"]}",
                          style: TextStyle(
                            color: factor["color"],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Recent Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: alerts.map((alert) {
                Color priorityColor = alert["priority"] == "high"
                    ? dangerColor
                    : alert["priority"] == "medium"
                        ? warningColor
                        : infoColor;

                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        alert["icon"],
                        color: priorityColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${alert["type"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${alert["time"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${alert["message"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 13,
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

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recommendations",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Monitor soil moisture levels closely over the next 48 hours",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Consider preventive pest management measures",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Optimize irrigation schedule based on weather forecast",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
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

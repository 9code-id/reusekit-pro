import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDataAnalyticsView extends StatefulWidget {
  const CmaDataAnalyticsView({super.key});

  @override
  State<CmaDataAnalyticsView> createState() => _CmaDataAnalyticsViewState();
}

class _CmaDataAnalyticsViewState extends State<CmaDataAnalyticsView> {
  String selectedVehicle = "VH001";
  String selectedPeriod = "month";
  String selectedMetric = "fuel";
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "label": "Honda Civic - ABC123",
      "value": "VH001",
    },
    {
      "id": "VH002", 
      "label": "Toyota Camry - XYZ789",
      "value": "VH002",
    },
    {
      "id": "VH003",
      "label": "BMW X5 - DEF456", 
      "value": "VH003",
    }
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "week"},
    {"label": "Last 30 Days", "value": "month"},
    {"label": "Last 90 Days", "value": "quarter"},
    {"label": "Last Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Fuel Consumption", "value": "fuel"},
    {"label": "Distance Traveled", "value": "distance"},
    {"label": "Driving Behavior", "value": "behavior"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> analyticsOverview = [
    {
      "title": "Fuel Efficiency",
      "value": "28.5",
      "unit": "mpg",
      "change": 5.2,
      "trend": "up",
      "description": "Average fuel economy improved",
      "icon": Icons.local_gas_station
    },
    {
      "title": "Total Distance",
      "value": "1,245",
      "unit": "miles",
      "change": 12.8,
      "trend": "up", 
      "description": "Monthly distance increased",
      "icon": Icons.straighten
    },
    {
      "title": "Drive Score",
      "value": "84",
      "unit": "/100",
      "change": -2.1,
      "trend": "down",
      "description": "Slight decrease in driving score",
      "icon": Icons.star
    },
    {
      "title": "CO2 Emissions",
      "value": "2.8",
      "unit": "tons",
      "change": -8.5,
      "trend": "down",
      "description": "Environmental impact reduced",
      "icon": Icons.eco
    }
  ];

  List<Map<String, dynamic>> fuelAnalytics = [
    {
      "week": "Week 1",
      "consumption": 25.8,
      "efficiency": 28.2,
      "cost": 89.50
    },
    {
      "week": "Week 2", 
      "consumption": 22.4,
      "efficiency": 30.1,
      "cost": 78.20
    },
    {
      "week": "Week 3",
      "consumption": 27.2,
      "efficiency": 26.8,
      "cost": 94.80
    },
    {
      "week": "Week 4",
      "consumption": 24.1,
      "efficiency": 29.5,
      "cost": 84.10
    }
  ];

  List<Map<String, dynamic>> drivingPatterns = [
    {
      "pattern": "City Driving",
      "percentage": 65,
      "avgSpeed": "22.5 mph",
      "fuelEfficiency": "24.2 mpg",
      "color": primaryColor
    },
    {
      "pattern": "Highway Driving",
      "percentage": 25,
      "avgSpeed": "68.3 mph", 
      "fuelEfficiency": "35.8 mpg",
      "color": successColor
    },
    {
      "pattern": "Rural Driving",
      "percentage": 10,
      "avgSpeed": "45.2 mph",
      "fuelEfficiency": "31.4 mpg",
      "color": warningColor
    }
  ];

  List<Map<String, dynamic>> timeAnalytics = [
    {
      "timeRange": "6 AM - 9 AM",
      "trips": 12,
      "avgDuration": "35 min",
      "avgDistance": "15.2 miles",
      "trafficLevel": "High"
    },
    {
      "timeRange": "9 AM - 12 PM",
      "trips": 8,
      "avgDuration": "22 min",
      "avgDistance": "8.7 miles",
      "trafficLevel": "Medium"
    },
    {
      "timeRange": "12 PM - 3 PM",
      "trips": 6,
      "avgDuration": "18 min",
      "avgDistance": "6.3 miles",
      "trafficLevel": "Low"
    },
    {
      "timeRange": "3 PM - 6 PM",
      "trips": 15,
      "avgDuration": "28 min",
      "avgDistance": "12.1 miles",
      "trafficLevel": "High"
    },
    {
      "timeRange": "6 PM - 9 PM",
      "trips": 10,
      "avgDuration": "25 min",
      "avgDistance": "11.8 miles", 
      "trafficLevel": "Medium"
    }
  ];

  List<Map<String, dynamic>> predictiveInsights = [
    {
      "insight": "Fuel Cost Prediction",
      "value": "\$340.50",
      "period": "Next Month",
      "confidence": 87,
      "recommendation": "Consider carpooling on Tuesdays"
    },
    {
      "insight": "Maintenance Due",
      "value": "Oil Change",
      "period": "2 weeks",
      "confidence": 95,
      "recommendation": "Schedule service appointment"
    },
    {
      "insight": "Optimal Route",
      "value": "Highway 101",
      "period": "Peak Hours",
      "confidence": 78,
      "recommendation": "Use alternate route during rush hour"
    },
    {
      "insight": "Eco Performance",
      "value": "+15% efficiency",
      "period": "With adjustments",
      "confidence": 82,
      "recommendation": "Maintain steady speeds between 45-65 mph"
    }
  ];

  List<Map<String, dynamic>> comparisonData = [
    {
      "metric": "Fuel Efficiency",
      "yourValue": 28.5,
      "avgValue": 25.2,
      "ranking": "Top 15%",
      "improvement": "13% better"
    },
    {
      "metric": "Safety Score",
      "yourValue": 84,
      "avgValue": 76,
      "ranking": "Top 25%",
      "improvement": "11% better"
    },
    {
      "metric": "CO2 Emissions",
      "yourValue": 2.8,
      "avgValue": 3.4,
      "ranking": "Top 20%",
      "improvement": "18% lower"
    },
    {
      "metric": "Monthly Cost",
      "yourValue": 340,
      "avgValue": 385,
      "ranking": "Top 30%",
      "improvement": "12% lower"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Selection Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Analytics Configuration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Vehicle",
                          items: vehicles,
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Focus Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Analytics Overview Cards
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dashboard, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Performance Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: analyticsOverview.map((data) {
                      Color trendColor = data["trend"] == "up" ? successColor : dangerColor;
                      if (data["title"] == "CO2 Emissions" && data["trend"] == "down") {
                        trendColor = successColor;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: trendColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  data["icon"] as IconData,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      data["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                                      color: trendColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(data["change"] as num) > 0 ? '+' : ''}${(data["change"] as num).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        color: trendColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${data["value"]}${data["unit"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${data["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${data["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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

            // Fuel Analytics Chart Placeholder
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.show_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Fuel Consumption Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Fuel Analytics Chart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Weekly consumption and efficiency trends",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: fuelAnalytics.map((data) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${data["week"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(data["efficiency"] as num).toStringAsFixed(1)} mpg",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
            ),

            // Driving Patterns Analysis
            Container(
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
                  Row(
                    children: [
                      Icon(Icons.pie_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Driving Patterns",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...drivingPatterns.map((pattern) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (pattern["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: (pattern["color"] as Color).withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${pattern["pattern"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${pattern["percentage"]}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pattern["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (pattern["percentage"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: pattern["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Avg Speed: ${pattern["avgSpeed"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Efficiency: ${pattern["fuelEfficiency"]}",
                                style: TextStyle(
                                  color: pattern["color"] as Color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
            ),

            // Time-based Analytics
            Container(
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
                  Row(
                    children: [
                      Icon(Icons.schedule, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Time-based Analytics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...timeAnalytics.map((timeData) {
                    Color trafficColor = successColor;
                    if (timeData["trafficLevel"] == "Medium") trafficColor = warningColor;
                    if (timeData["trafficLevel"] == "High") trafficColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: trafficColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: trafficColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${timeData["timeRange"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${timeData["trips"]} trips",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${timeData["avgDuration"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${timeData["avgDistance"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Distance",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: trafficColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${timeData["trafficLevel"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Predictive Insights
            Container(
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
                  Row(
                    children: [
                      Icon(Icons.psychology, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Predictive Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...predictiveInsights.map((insight) {
                    Color confidenceColor = successColor;
                    if ((insight["confidence"] as int) < 80) confidenceColor = warningColor;
                    if ((insight["confidence"] as int) < 60) confidenceColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: confidenceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: confidenceColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${insight["insight"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: confidenceColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${insight["confidence"]}% confident",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${insight["value"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: confidenceColor,
                                ),
                              ),
                              Text(
                                "${insight["period"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "💡 ${insight["recommendation"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Comparison with Average
            Container(
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
                  Row(
                    children: [
                      Icon(Icons.compare_arrows, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Performance vs Average",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...comparisonData.map((comparison) {
                    bool isLower = comparison["metric"].contains("Emissions") || comparison["metric"].contains("Cost");
                    bool isBetter = isLower 
                        ? (comparison["yourValue"] as num) < (comparison["avgValue"] as num)
                        : (comparison["yourValue"] as num) > (comparison["avgValue"] as num);
                    Color performanceColor = isBetter ? successColor : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: performanceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: performanceColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${comparison["metric"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${comparison["ranking"]}",
                                  style: TextStyle(
                                    color: performanceColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${comparison["yourValue"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Your Score",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${comparison["avgValue"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Average",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: performanceColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${comparison["improvement"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Analytics",
                    icon: Icons.share,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

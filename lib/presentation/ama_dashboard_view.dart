import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaDashboardView extends StatefulWidget {
  const AmaDashboardView({super.key});

  @override
  State<AmaDashboardView> createState() => _AmaDashboardViewState();
}

class _AmaDashboardViewState extends State<AmaDashboardView> {
  Map<String, dynamic> farmData = {
    "totalArea": 150.5,
    "plantedArea": 125.0,
    "harvestedArea": 80.0,
    "remainingArea": 45.0,
    "totalYield": 85.2,
    "expectedYield": 95.0,
    "efficiency": 89.7,
    "profitability": 78.5,
  };

  List<Map<String, dynamic>> weatherData = [
    {
      "day": "Mon",
      "temperature": 28,
      "humidity": 65,
      "rainfall": 5.2,
      "icon": Icons.wb_sunny,
    },
    {
      "day": "Tue",
      "temperature": 30,
      "humidity": 58,
      "rainfall": 0.0,
      "icon": Icons.wb_sunny,
    },
    {
      "day": "Wed",
      "temperature": 26,
      "humidity": 78,
      "rainfall": 12.5,
      "icon": Icons.grain,
    },
    {
      "day": "Thu",
      "temperature": 24,
      "humidity": 82,
      "rainfall": 18.3,
      "icon": Icons.grain,
    },
    {
      "day": "Fri",
      "temperature": 27,
      "humidity": 70,
      "rainfall": 3.1,
      "icon": Icons.wb_cloudy,
    },
  ];

  List<Map<String, dynamic>> crops = [
    {
      "name": "Rice",
      "area": 60.0,
      "stage": "Flowering",
      "health": "Excellent",
      "expectedHarvest": "2024-08-15",
      "progress": 0.75,
      "color": successColor,
    },
    {
      "name": "Corn",
      "area": 45.0,
      "stage": "Vegetative",
      "health": "Good",
      "expectedHarvest": "2024-09-20",
      "progress": 0.45,
      "color": warningColor,
    },
    {
      "name": "Vegetables",
      "area": 20.0,
      "stage": "Mature",
      "health": "Excellent",
      "expectedHarvest": "2024-07-25",
      "progress": 0.90,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "Weather Alert",
      "message": "Heavy rain expected in next 48 hours",
      "severity": "high",
      "time": "2 hours ago",
      "icon": Icons.warning,
      "color": dangerColor,
    },
    {
      "type": "Pest Detection",
      "message": "Brown planthopper detected in rice field A",
      "severity": "medium",
      "time": "4 hours ago",
      "icon": Icons.bug_report,
      "color": warningColor,
    },
    {
      "type": "Irrigation",
      "message": "Soil moisture low in corn field B",
      "severity": "medium",
      "time": "6 hours ago",
      "icon": Icons.water_drop,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "activity": "Field Inspection",
      "field": "Rice Field A",
      "time": "08:00 AM",
      "status": "completed",
    },
    {
      "activity": "Fertilizer Application",
      "field": "Corn Field B",
      "time": "10:30 AM",
      "status": "in_progress",
    },
    {
      "activity": "Pest Control",
      "field": "Vegetable Garden",
      "time": "02:00 PM",
      "status": "pending",
    },
    {
      "activity": "Harvest Planning",
      "field": "Rice Field C",
      "time": "04:00 PM",
      "status": "pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Dashboard"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            _buildFarmOverview(),
            _buildWeatherForecast(),
            _buildCropStatus(),
            _buildAlertsSection(),
            _buildTodayActivities(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.wb_sunny,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning, Farmer!",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Today is a perfect day for farming activities",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
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
                child: Column(
                  children: [
                    Text(
                      "28°C",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Temperature",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "65%",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Humidity",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "5.2mm",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Rainfall",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFarmOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Farm Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 150,
          children: [
            _buildOverviewCard(
              "Total Area",
              "${(farmData["totalArea"] as double).toStringAsFixed(1)} ha",
              Icons.landscape,
              primaryColor,
            ),
            _buildOverviewCard(
              "Planted Area",
              "${(farmData["plantedArea"] as double).toStringAsFixed(1)} ha",
              Icons.eco,
              successColor,
            ),
            _buildOverviewCard(
              "Expected Yield",
              "${(farmData["expectedYield"] as double).toStringAsFixed(1)} tons",
              Icons.agriculture,
              warningColor,
            ),
            _buildOverviewCard(
              "Efficiency",
              "${(farmData["efficiency"] as double).toStringAsFixed(1)}%",
              Icons.trending_up,
              infoColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "5-Day Weather Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: weatherData.map((weather) {
            return Container(
              width: 100,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "${weather["day"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Icon(
                    weather["icon"] as IconData,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${weather["temperature"]}°C",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${weather["humidity"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if ((weather["rainfall"] as double) > 0)
                    Text(
                      "${(weather["rainfall"] as double).toStringAsFixed(1)}mm",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCropStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Crop Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: crops.map((crop) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (crop["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.eco,
                          color: crop["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${crop["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(crop["area"] as double).toStringAsFixed(1)} ha • ${crop["stage"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${crop["health"]}",
                            style: TextStyle(
                              color: crop["color"] as Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${crop["expectedHarvest"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Growth Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${((crop["progress"] as double) * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: crop["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: crop["progress"] as double,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(crop["color"] as Color),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Alerts & Notifications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: alerts.map((alert) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: alert["color"] as Color,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    alert["icon"] as IconData,
                    color: alert["color"] as Color,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${alert["type"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: alert["color"] as Color,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${alert["time"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTodayActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Activities",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: activities.map((activity) {
            Color statusColor = activity["status"] == "completed"
                ? successColor
                : activity["status"] == "in_progress"
                    ? warningColor
                    : disabledBoldColor;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["activity"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${activity["field"]} • ${activity["time"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      activity["status"] == "completed"
                          ? "Completed"
                          : activity["status"] == "in_progress"
                              ? "In Progress"
                              : "Pending",
                      style: TextStyle(
                        color: statusColor,
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
      ],
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "Field Monitor",
        "subtitle": "Check field conditions",
        "icon": Icons.monitor,
        "color": primaryColor,
      },
      {
        "title": "Weather Report",
        "subtitle": "Detailed weather info",
        "icon": Icons.wb_cloudy,
        "color": infoColor,
      },
      {
        "title": "Pest Control",
        "subtitle": "Manage pest issues",
        "icon": Icons.bug_report,
        "color": warningColor,
      },
      {
        "title": "Harvest Plan",
        "subtitle": "Plan harvest schedule",
        "icon": Icons.agriculture,
        "color": successColor,
      },
    ];

    return Column(
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
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 150,
          children: actions.map((action) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${action["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${action["subtitle"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Open",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

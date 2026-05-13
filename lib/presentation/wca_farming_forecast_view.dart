import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaFarmingForecastView extends StatefulWidget {
  const WcaFarmingForecastView({super.key});

  @override
  State<WcaFarmingForecastView> createState() => _WcaFarmingForecastViewState();
}

class _WcaFarmingForecastViewState extends State<WcaFarmingForecastView> {
  String selectedCrop = "Corn";
  String selectedLocation = "Iowa, USA";
  int selectedDays = 7;

  List<Map<String, dynamic>> cropTypes = [
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Cotton", "value": "Cotton"},
    {"label": "Tomatoes", "value": "Tomatoes"},
  ];

  List<Map<String, dynamic>> forecastDays = [
    {"label": "3 Days", "value": 3},
    {"label": "7 Days", "value": 7},
    {"label": "14 Days", "value": 14},
    {"label": "30 Days", "value": 30},
  ];

  List<Map<String, dynamic>> farmingActivities = [
    {
      "date": "2024-06-17",
      "activity": "Ideal for Planting",
      "conditions": "Sunny, 75°F, Low Wind",
      "recommendation": "Perfect conditions for corn planting",
      "priority": "high",
      "icon": Icons.agriculture,
    },
    {
      "date": "2024-06-18",
      "activity": "Irrigation Needed",
      "conditions": "Hot, 88°F, No Rain",
      "recommendation": "Schedule irrigation for morning hours",
      "priority": "medium",
      "icon": Icons.water_drop,
    },
    {
      "date": "2024-06-19",
      "activity": "Avoid Harvesting",
      "conditions": "Thunderstorms, 72°F, High Wind",
      "recommendation": "Postpone harvest activities due to storms",
      "priority": "high",
      "icon": Icons.warning,
    },
    {
      "date": "2024-06-20",
      "activity": "Pest Management",
      "conditions": "Humid, 79°F, Light Rain",
      "recommendation": "Monitor for pest activity in humid conditions",
      "priority": "medium",
      "icon": Icons.bug_report,
    },
    {
      "date": "2024-06-21",
      "activity": "Fertilizer Application",
      "conditions": "Partly Cloudy, 76°F, Calm",
      "recommendation": "Good conditions for fertilizer application",
      "priority": "low",
      "icon": Icons.science,
    },
  ];

  List<Map<String, dynamic>> weatherMetrics = [
    {
      "title": "Growing Degree Days",
      "value": "1,245",
      "unit": "GDD",
      "change": "+45",
      "color": successColor,
      "icon": Icons.thermostat,
    },
    {
      "title": "Soil Moisture",
      "value": "67",
      "unit": "%",
      "change": "-3",
      "color": infoColor,
      "icon": Icons.opacity,
    },
    {
      "title": "UV Index",
      "value": "8.2",
      "unit": "High",
      "change": "+1.1",
      "color": warningColor,
      "icon": Icons.wb_sunny,
    },
    {
      "title": "Wind Speed",
      "value": "12",
      "unit": "mph",
      "change": "+2",
      "color": primaryColor,
      "icon": Icons.air,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farming Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Weather alerts enabled for farming activities");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Configure farming forecast preferences");
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
                          "Farm Weather Intelligence",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Optimize farming decisions with precision weather forecasts",
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
                    label: "Crop Type",
                    items: cropTypes,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Forecast Period",
                    items: forecastDays,
                    value: selectedDays,
                    onChanged: (value, label) {
                      selectedDays = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Farm Location",
              value: selectedLocation,
              hint: "Enter your farm location",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Text(
              "Current Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: weatherMetrics.map((metric) {
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
                              "${metric["change"]}",
                              style: TextStyle(
                                color: metric["color"],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Farming Activities Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: farmingActivities.map((activity) {
                Color priorityColor = activity["priority"] == "high"
                    ? dangerColor
                    : activity["priority"] == "medium"
                        ? warningColor
                        : successColor;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            activity["icon"],
                            color: priorityColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${activity["date"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${activity["priority"].toUpperCase()}",
                              style: TextStyle(
                                color: priorityColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${activity["activity"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["conditions"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: infoColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${activity["recommendation"]}",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Next Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Weather forecast updates every 6 hours",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Next update: Today at 6:00 PM",
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

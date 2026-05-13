import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSoilTemperatureView extends StatefulWidget {
  const WcaSoilTemperatureView({super.key});

  @override
  State<WcaSoilTemperatureView> createState() => _WcaSoilTemperatureViewState();
}

class _WcaSoilTemperatureViewState extends State<WcaSoilTemperatureView> {
  String selectedLocation = "Iowa, USA";
  String selectedDepth = "4 inches";
  String selectedPeriod = "Last 7 Days";

  List<Map<String, dynamic>> depthOptions = [
    {"label": "2 inches", "value": "2 inches"},
    {"label": "4 inches", "value": "4 inches"},
    {"label": "8 inches", "value": "8 inches"},
    {"label": "20 inches", "value": "20 inches"},
    {"label": "40 inches", "value": "40 inches"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Current Season", "value": "Current Season"},
  ];

  List<Map<String, dynamic>> currentReadings = [
    {
      "depth": "2 inches",
      "temperature": "68°F",
      "change": "+2.5°F",
      "status": "Rising",
      "color": warningColor,
      "icon": Icons.trending_up,
    },
    {
      "depth": "4 inches",
      "temperature": "65°F",
      "change": "+1.8°F",
      "status": "Rising",
      "color": successColor,
      "icon": Icons.trending_up,
    },
    {
      "depth": "8 inches",
      "temperature": "62°F",
      "change": "+1.2°F",
      "status": "Stable",
      "color": infoColor,
      "icon": Icons.trending_flat,
    },
    {
      "depth": "20 inches",
      "temperature": "58°F",
      "change": "+0.5°F",
      "status": "Stable",
      "color": infoColor,
      "icon": Icons.trending_flat,
    },
    {
      "depth": "40 inches",
      "temperature": "55°F",
      "change": "0°F",
      "status": "Stable",
      "color": primaryColor,
      "icon": Icons.trending_flat,
    },
  ];

  List<Map<String, dynamic>> dailyTemperatures = [
    {
      "date": "June 12",
      "temp2": 64,
      "temp4": 61,
      "temp8": 58,
      "avgAir": 72,
      "condition": "Sunny",
    },
    {
      "date": "June 13",
      "temp2": 66,
      "temp4": 62,
      "temp8": 59,
      "avgAir": 75,
      "condition": "Partly Cloudy",
    },
    {
      "date": "June 14",
      "temp2": 67,
      "temp4": 64,
      "temp8": 60,
      "avgAir": 78,
      "condition": "Sunny",
    },
    {
      "date": "June 15",
      "temp2": 65,
      "temp4": 63,
      "temp8": 61,
      "avgAir": 70,
      "condition": "Rainy",
    },
    {
      "date": "June 16",
      "temp2": 68,
      "temp4": 65,
      "temp8": 62,
      "avgAir": 74,
      "condition": "Sunny",
    },
  ];

  List<Map<String, dynamic>> plantingGuidelines = [
    {
      "crop": "Corn",
      "minTemp": "50°F",
      "optimalTemp": "55-60°F",
      "depth": "2 inches",
      "status": "Ready",
      "color": successColor,
    },
    {
      "crop": "Soybeans",
      "minTemp": "55°F",
      "optimalTemp": "60-65°F",
      "depth": "2 inches",
      "status": "Ready",
      "color": successColor,
    },
    {
      "crop": "Cotton",
      "minTemp": "60°F",
      "optimalTemp": "65-70°F",
      "depth": "2 inches",
      "status": "Almost Ready",
      "color": warningColor,
    },
    {
      "crop": "Wheat",
      "minTemp": "45°F",
      "optimalTemp": "50-55°F",
      "depth": "2 inches",
      "status": "Ready",
      "color": successColor,
    },
    {
      "crop": "Rice",
      "minTemp": "60°F",
      "optimalTemp": "65-70°F",
      "depth": "2 inches",
      "status": "Almost Ready",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> insights = [
    {
      "title": "Optimal Planting Window",
      "description": "Soil temperatures are ideal for corn and soybean planting",
      "icon": Icons.agriculture,
      "color": successColor,
      "priority": "high",
    },
    {
      "title": "Temperature Trend",
      "description": "Soil warming trend expected to continue for next 5 days",
      "icon": Icons.trending_up,
      "color": infoColor,
      "priority": "medium",
    },
    {
      "title": "Moisture Content",
      "description": "Good soil moisture levels detected at all depths",
      "icon": Icons.water_drop,
      "color": primaryColor,
      "priority": "low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soil Temperature"),
        actions: [
          IconButton(
            icon: Icon(Icons.thermostat),
            onPressed: () {
              si("Temperature probe calibration available");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing soil temperature data...");
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
                    primaryColor.withAlpha(20),
                    warningColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.thermostat,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Soil Temperature Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Track soil temperatures at multiple depths for optimal planting decisions",
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
                    label: "Depth",
                    items: depthOptions,
                    value: selectedDepth,
                    onChanged: (value, label) {
                      selectedDepth = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Location",
              value: selectedLocation,
              hint: "Enter your location",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Text(
              "Current Readings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: currentReadings.map((reading) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: reading["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          reading["icon"],
                          color: reading["color"],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reading["depth"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${reading["status"]}",
                              style: TextStyle(
                                color: reading["color"],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${reading["temperature"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${reading["change"]}",
                            style: TextStyle(
                              color: reading["color"],
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
            ),

            Text(
              "Temperature History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
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
                      Text(
                        "Daily Temperatures",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last 5 Days",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    spacing: spSm,
                    children: dailyTemperatures.map((day) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${day["date"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${day["condition"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
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
                                      "2\"",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${day["temp2"]}°F",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "4\"",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${day["temp4"]}°F",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "8\"",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${day["temp8"]}°F",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Air",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${day["avgAir"]}°F",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (day != dailyTemperatures.last) ...[
                            SizedBox(height: spXs),
                            Divider(color: disabledColor),
                            SizedBox(height: spXs),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Text(
              "Planting Guidelines",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: plantingGuidelines.map((guideline) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: guideline["color"],
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${guideline["crop"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Min: ${guideline["minTemp"]} at ${guideline["depth"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Optimal: ${guideline["optimalTemp"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: guideline["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${guideline["status"]}",
                          style: TextStyle(
                            color: guideline["color"],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Insights & Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: insights.map((insight) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        insight["icon"],
                        color: insight["color"],
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${insight["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${insight["description"]}",
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
                        Icons.schedule,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Next Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Soil temperature readings updated every 4 hours",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Next reading: Today at 4:00 PM",
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

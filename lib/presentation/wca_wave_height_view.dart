import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWaveHeightView extends StatefulWidget {
  const WcaWaveHeightView({super.key});

  @override
  State<WcaWaveHeightView> createState() => _WcaWaveHeightViewState();
}

class _WcaWaveHeightViewState extends State<WcaWaveHeightView> {
  String selectedLocation = "Malibu, CA";
  String selectedForecastType = "Surf Forecast";
  int selectedHours = 24;

  List<Map<String, dynamic>> forecastTypes = [
    {"label": "Surf Forecast", "value": "Surf Forecast"},
    {"label": "Marine Navigation", "value": "Marine Navigation"},
    {"label": "Fishing Conditions", "value": "Fishing Conditions"},
    {"label": "Sailing Forecast", "value": "Sailing Forecast"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Next 12 Hours", "value": 12},
    {"label": "Next 24 Hours", "value": 24},
    {"label": "Next 48 Hours", "value": 48},
    {"label": "Next 7 Days", "value": 168},
  ];

  List<Map<String, dynamic>> currentWaveData = [
    {
      "title": "Significant Wave Height",
      "value": "4-6",
      "unit": "ft",
      "direction": "NW",
      "period": "12 sec",
      "color": successColor,
      "icon": Icons.waves,
    },
    {
      "title": "Max Wave Height",
      "value": "8-10",
      "unit": "ft",
      "direction": "NW",
      "period": "14 sec",
      "color": warningColor,
      "icon": Icons.height,
    },
    {
      "title": "Wind Waves",
      "value": "2-3",
      "unit": "ft",
      "direction": "W",
      "period": "6 sec",
      "color": infoColor,
      "icon": Icons.air,
    },
    {
      "title": "Swell Height",
      "value": "5-7",
      "unit": "ft",
      "direction": "NW",
      "period": "13 sec",
      "color": primaryColor,
      "icon": Icons.tsunami,
    },
  ];

  List<Map<String, dynamic>> hourlyForecast = [
    {
      "time": "12:00 AM",
      "waveHeight": "4-6 ft",
      "period": "12s",
      "direction": "NW",
      "windSpeed": "15 kts",
      "rating": "Good",
      "color": successColor,
    },
    {
      "time": "6:00 AM",
      "waveHeight": "5-7 ft",
      "period": "13s",
      "direction": "NW",
      "windSpeed": "12 kts",
      "rating": "Excellent",
      "color": successColor,
    },
    {
      "time": "12:00 PM",
      "waveHeight": "6-8 ft",
      "period": "14s",
      "direction": "NW",
      "windSpeed": "18 kts",
      "rating": "Good",
      "color": successColor,
    },
    {
      "time": "6:00 PM",
      "waveHeight": "5-7 ft",
      "period": "13s",
      "direction": "W",
      "windSpeed": "20 kts",
      "rating": "Fair",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> surfBreaks = [
    {
      "name": "Malibu Point",
      "waveHeight": "4-6 ft",
      "quality": "Excellent",
      "crowd": "Heavy",
      "bestTide": "Mid-High",
      "color": successColor,
      "rating": 9.2,
    },
    {
      "name": "Manhattan Beach",
      "waveHeight": "3-5 ft",
      "quality": "Good",
      "crowd": "Moderate",
      "bestTide": "Low-Mid",
      "color": successColor,
      "rating": 7.8,
    },
    {
      "name": "Venice Breakwater",
      "waveHeight": "2-4 ft",
      "quality": "Fair",
      "crowd": "Light",
      "bestTide": "Any",
      "color": warningColor,
      "rating": 6.5,
    },
    {
      "name": "El Segundo",
      "waveHeight": "3-4 ft",
      "quality": "Good",
      "crowd": "Moderate",
      "bestTide": "Mid",
      "color": successColor,
      "rating": 7.2,
    },
  ];

  List<Map<String, dynamic>> waveCharts = [
    {
      "time": "00:00",
      "significant": 4.2,
      "maximum": 7.8,
      "windWave": 2.1,
      "swell": 5.6,
    },
    {
      "time": "06:00",
      "significant": 5.1,
      "maximum": 8.9,
      "windWave": 2.5,
      "swell": 6.2,
    },
    {
      "time": "12:00",
      "significant": 6.3,
      "maximum": 10.2,
      "windWave": 3.1,
      "swell": 7.1,
    },
    {
      "time": "18:00",
      "significant": 5.8,
      "maximum": 9.5,
      "windWave": 2.8,
      "swell": 6.7,
    },
  ];

  List<Map<String, dynamic>> safetyConditions = [
    {
      "category": "Swimming",
      "status": "Caution",
      "description": "Moderate surf conditions, strong currents possible",
      "recommendation": "Stay near lifeguards, experienced swimmers only",
      "color": warningColor,
      "icon": Icons.pool,
    },
    {
      "category": "Surfing",
      "status": "Excellent",
      "description": "Clean conditions with consistent waves",
      "recommendation": "Ideal for intermediate to advanced surfers",
      "color": successColor,
      "icon": Icons.surfing,
    },
    {
      "category": "Boating",
      "status": "Fair",
      "description": "Moderate seas, plan for larger waves",
      "recommendation": "Small craft advisory in effect",
      "color": warningColor,
      "icon": Icons.sailing,
    },
    {
      "category": "Fishing",
      "status": "Good",
      "description": "Good wave action for surf fishing",
      "recommendation": "Productive conditions from shore",
      "color": successColor,
      "icon": Icons.phishing,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wave Height Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.surfing),
            onPressed: () {
              si("Surf report details opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              si("Wave webcam view opened");
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
                    infoColor.withAlpha(20),
                    primaryColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.waves,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wave Height Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Detailed wave forecasts for surfing, boating, and marine activities",
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
                    label: "Forecast Type",
                    items: forecastTypes,
                    value: selectedForecastType,
                    onChanged: (value, label) {
                      selectedForecastType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRanges,
                    value: selectedHours,
                    onChanged: (value, label) {
                      selectedHours = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Location",
              value: selectedLocation,
              hint: "Enter beach or coastal location",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Text(
              "Current Wave Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: currentWaveData.map((wave) {
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
                            wave["icon"],
                            color: wave["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Text(
                            "${wave["direction"]}",
                            style: TextStyle(
                              color: wave["color"],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${wave["title"]}",
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
                            "${wave["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${wave["unit"]}",
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
                          color: wave["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${wave["period"]} period",
                          style: TextStyle(
                            color: wave["color"],
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
              "24-Hour Wave Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: hourlyForecast.map((forecast) {
                return Container(
                  width: 180,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: forecast["color"],
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${forecast["time"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: forecast["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${forecast["rating"]}",
                              style: TextStyle(
                                color: forecast["color"],
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.waves,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["waveHeight"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["period"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.navigation,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["direction"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.air,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["windSpeed"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
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
              "Local Surf Breaks",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: surfBreaks.map((surfBreak) {
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
                          Text(
                            "${surfBreak["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: surfBreak["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${surfBreak["rating"]}/10",
                              style: TextStyle(
                                color: surfBreak["color"],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Waves: ${surfBreak["waveHeight"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Quality: ${surfBreak["quality"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crowd: ${surfBreak["crowd"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Best Tide: ${surfBreak["bestTide"]}",
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
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Activity Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: safetyConditions.map((condition) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: condition["color"],
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        condition["icon"],
                        color: condition["color"],
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${condition["category"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: condition["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${condition["status"]}",
                                    style: TextStyle(
                                      color: condition["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${condition["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${condition["recommendation"]}",
                              style: TextStyle(
                                color: condition["color"],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Wave Height Explanation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Significant wave height represents the average of the highest 1/3 of waves",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Maximum wave height can be 1.5-2x the significant height",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Wave period affects wave power and surfability",
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

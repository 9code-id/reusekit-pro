import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaMarineWeatherView extends StatefulWidget {
  const WcaMarineWeatherView({super.key});

  @override
  State<WcaMarineWeatherView> createState() => _WcaMarineWeatherViewState();
}

class _WcaMarineWeatherViewState extends State<WcaMarineWeatherView> {
  String selectedLocation = "Pacific Coast, CA";
  String selectedZone = "Coastal Waters";
  int selectedDays = 3;

  List<Map<String, dynamic>> marineZones = [
    {"label": "Coastal Waters", "value": "Coastal Waters"},
    {"label": "Near Shore", "value": "Near Shore"},
    {"label": "Offshore", "value": "Offshore"},
    {"label": "Open Ocean", "value": "Open Ocean"},
  ];

  List<Map<String, dynamic>> forecastDays = [
    {"label": "Today", "value": 1},
    {"label": "3 Days", "value": 3},
    {"label": "7 Days", "value": 7},
    {"label": "14 Days", "value": 14},
  ];

  List<Map<String, dynamic>> currentConditions = [
    {
      "title": "Wave Height",
      "value": "3-5",
      "unit": "ft",
      "status": "Moderate",
      "color": warningColor,
      "icon": Icons.waves,
      "trend": "increasing",
    },
    {
      "title": "Wind Speed",
      "value": "15",
      "unit": "knots",
      "status": "Fresh Breeze",
      "color": infoColor,
      "icon": Icons.air,
      "trend": "steady",
    },
    {
      "title": "Visibility",
      "value": "8",
      "unit": "miles",
      "status": "Good",
      "color": successColor,
      "icon": Icons.visibility,
      "trend": "improving",
    },
    {
      "title": "Water Temp",
      "value": "68",
      "unit": "°F",
      "status": "Optimal",
      "color": primaryColor,
      "icon": Icons.thermostat,
      "trend": "stable",
    },
  ];

  List<Map<String, dynamic>> marineForecasts = [
    {
      "time": "6:00 AM",
      "condition": "Partly Cloudy",
      "windSpeed": "12 knots",
      "windDirection": "NW",
      "waveHeight": "2-3 ft",
      "visibility": "10 mi",
      "precipitation": "0%",
      "icon": Icons.wb_cloudy,
    },
    {
      "time": "12:00 PM",
      "condition": "Sunny",
      "windSpeed": "18 knots",
      "windDirection": "W",
      "waveHeight": "3-4 ft",
      "visibility": "12 mi",
      "precipitation": "0%",
      "icon": Icons.wb_sunny,
    },
    {
      "time": "6:00 PM",
      "condition": "Partly Cloudy",
      "windSpeed": "15 knots",
      "windDirection": "SW",
      "waveHeight": "3-5 ft",
      "visibility": "8 mi",
      "precipitation": "10%",
      "icon": Icons.wb_cloudy,
    },
    {
      "time": "12:00 AM",
      "condition": "Clear",
      "windSpeed": "10 knots",
      "windDirection": "SW",
      "waveHeight": "2-3 ft",
      "visibility": "15 mi",
      "precipitation": "0%",
      "icon": Icons.nights_stay,
    },
  ];

  List<Map<String, dynamic>> marineAlerts = [
    {
      "type": "Small Craft Advisory",
      "message": "Winds 15-25 knots and seas 4-7 feet expected",
      "validUntil": "June 17, 6:00 PM",
      "priority": "medium",
      "icon": Icons.warning,
      "areas": ["Coastal Waters", "Near Shore"],
    },
    {
      "type": "Dense Fog Advisory",
      "message": "Dense fog reducing visibility to less than 1 mile",
      "validUntil": "June 16, 10:00 AM",
      "priority": "high",
      "icon": Icons.visibility_off,
      "areas": ["Coastal Waters"],
    },
  ];

  List<Map<String, dynamic>> safetyRecommendations = [
    {
      "activity": "Recreational Boating",
      "recommendation": "Exercise caution due to moderate seas",
      "suitability": "Fair",
      "color": warningColor,
      "icon": Icons.sailing,
    },
    {
      "activity": "Fishing",
      "recommendation": "Good conditions for nearshore fishing",
      "suitability": "Good",
      "color": successColor,
      "icon": Icons.phishing,
    },
    {
      "activity": "Swimming",
      "recommendation": "Moderate surf conditions, swim near lifeguards",
      "suitability": "Fair",
      "color": warningColor,
      "icon": Icons.pool,
    },
    {
      "activity": "Surfing",
      "recommendation": "Ideal wave conditions for intermediate surfers",
      "suitability": "Excellent",
      "color": successColor,
      "icon": Icons.surfing,
    },
  ];

  List<Map<String, dynamic>> tideInformation = [
    {
      "time": "2:15 AM",
      "type": "Low",
      "height": "0.8 ft",
      "icon": Icons.trending_down,
    },
    {
      "time": "8:30 AM",
      "type": "High",
      "height": "5.2 ft",
      "icon": Icons.trending_up,
    },
    {
      "time": "2:45 PM",
      "type": "Low",
      "height": "1.2 ft",
      "icon": Icons.trending_down,
    },
    {
      "time": "9:10 PM",
      "type": "High",
      "height": "4.8 ft",
      "icon": Icons.trending_up,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marine Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.anchor),
            onPressed: () {
              si("Marine safety guidelines opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing marine weather data...");
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
                    Icons.sailing,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Marine Weather Center",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Comprehensive marine forecasts for safe navigation and activities",
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
                    label: "Marine Zone",
                    items: marineZones,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
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
              label: "Location",
              value: selectedLocation,
              hint: "Enter marine location",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            if (marineAlerts.isNotEmpty) ...[
              Text(
                "Marine Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: marineAlerts.map((alert) {
                  Color alertColor = alert["priority"] == "high"
                      ? dangerColor
                      : warningColor;

                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: alertColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: alertColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              alert["icon"],
                              color: alertColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${alert["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: alertColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Valid until: ${alert["validUntil"]}",
                          style: TextStyle(
                            color: alertColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

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
              children: currentConditions.map((condition) {
                IconData trendIcon = condition["trend"] == "increasing"
                    ? Icons.trending_up
                    : condition["trend"] == "decreasing"
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
                            condition["icon"],
                            color: condition["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Icon(
                            trendIcon,
                            color: condition["color"],
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${condition["title"]}",
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
                            "${condition["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["unit"]}",
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
                );
              }).toList(),
            ),

            Text(
              "24-Hour Marine Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: marineForecasts.map((forecast) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
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
                            "${forecast["time"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            forecast["icon"],
                            color: primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${forecast["condition"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.air,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["windSpeed"]} ${forecast["windDirection"]}",
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
                            Icons.waves,
                            color: warningColor,
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
                            Icons.visibility,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${forecast["visibility"]}",
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
              "Today's Tides",
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
                spacing: spSm,
                children: tideInformation.map((tide) {
                  Color tideColor = tide["type"] == "High" ? infoColor : warningColor;
                  
                  return Row(
                    children: [
                      Icon(
                        tide["icon"],
                        color: tideColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "${tide["time"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${tide["type"]} Tide",
                        style: TextStyle(
                          color: tideColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${tide["height"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            Text(
              "Activity Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: safetyRecommendations.map((rec) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: rec["color"],
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        rec["icon"],
                        color: rec["color"],
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
                                  "${rec["activity"]}",
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
                                    color: rec["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${rec["suitability"]}",
                                    style: TextStyle(
                                      color: rec["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${rec["recommendation"]}",
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
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Marine Safety Reminder",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Always check weather conditions before departing",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• File a float plan with someone on shore",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Carry proper safety equipment and communication devices",
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

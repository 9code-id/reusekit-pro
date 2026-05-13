import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaFishingConditionsView extends StatefulWidget {
  const WcaFishingConditionsView({super.key});

  @override
  State<WcaFishingConditionsView> createState() => _WcaFishingConditionsViewState();
}

class _WcaFishingConditionsViewState extends State<WcaFishingConditionsView> {
  String selectedSpot = "Lake Morrison";
  String selectedFishType = "Bass";

  List<Map<String, dynamic>> fishingSpots = [
    {"label": "Lake Morrison", "value": "Lake Morrison"},
    {"label": "River Creek", "value": "River Creek"},
    {"label": "Ocean Bay", "value": "Ocean Bay"},
    {"label": "Deep Sea Area", "value": "Deep Sea Area"},
  ];

  List<Map<String, dynamic>> fishTypes = [
    {"label": "Bass", "value": "Bass"},
    {"label": "Trout", "value": "Trout"},
    {"label": "Salmon", "value": "Salmon"},
    {"label": "Tuna", "value": "Tuna"},
  ];

  Map<String, dynamic> currentConditions = {
    "temperature": 22,
    "waterTemp": 18,
    "windSpeed": 8,
    "pressure": 1015,
    "humidity": 68,
    "moonPhase": "Waxing Crescent",
    "precipitation": 10,
    "fishingScore": 8.5,
    "bestTime": "06:00 - 09:00",
    "recommendation": "Excellent conditions for fishing",
    "baitSuggestion": "Live worms, small lures"
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "06:00", "score": 9.2, "activity": "Peak"},
    {"time": "08:00", "score": 8.8, "activity": "High"},
    {"time": "10:00", "score": 7.5, "activity": "Good"},
    {"time": "12:00", "score": 6.2, "activity": "Fair"},
    {"time": "14:00", "score": 5.8, "activity": "Fair"},
    {"time": "16:00", "score": 7.1, "activity": "Good"},
    {"time": "18:00", "score": 8.9, "activity": "High"},
    {"time": "20:00", "score": 9.0, "activity": "Peak"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fishing Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              si("Location services enabled");
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
                  colors: [infoColor, infoColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.set_meal,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fishing Forecast",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Real-time fishing conditions and predictions",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Fishing Spot",
                    items: fishingSpots,
                    value: selectedSpot,
                    onChanged: (value, label) {
                      selectedSpot = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Target Fish",
                    items: fishTypes,
                    value: selectedFishType,
                    onChanged: (value, label) {
                      selectedFishType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getScoreColor(currentConditions["fishingScore"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getScoreColor(currentConditions["fishingScore"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stars,
                        color: _getScoreColor(currentConditions["fishingScore"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Fishing Score",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentConditions["fishingScore"]}/10",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(currentConditions["fishingScore"]),
                    ),
                  ),
                  Text(
                    "${currentConditions["recommendation"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Weather Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                          Icon(
                            Icons.thermostat,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Air Temp",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["temperature"]}°C",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                          Icon(
                            Icons.waves,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Water Temp",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["waterTemp"]}°C",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                          Icon(
                            Icons.air,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Wind Speed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["windSpeed"]} km/h",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                          Icon(
                            Icons.compress,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Pressure",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["pressure"]} hPa",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Best Fishing Times Today",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 120,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Peak Activity: ${currentConditions["bestTime"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "BEST",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: hourlyForecast.map((hour) {
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getActivityColor(hour["activity"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getActivityColor(hour["activity"]).withAlpha(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${hour["score"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getActivityColor(hour["activity"]),
                              ),
                            ),
                            Text(
                              "${hour["activity"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
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

            Row(
              children: [
                Expanded(
                  child: Container(
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
                              Icons.nights_stay,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Moon Phase",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentConditions["moonPhase"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                              Icons.water_drop,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Humidity",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentConditions["humidity"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Fishing Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Recommended Bait: ${currentConditions["baitSuggestion"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Fish are most active during dawn and dusk",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Current weather conditions favor surface fishing",
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

  Color _getScoreColor(double score) {
    if (score >= 8.0) return successColor;
    if (score >= 6.0) return warningColor;
    return dangerColor;
  }

  Color _getActivityColor(String activity) {
    switch (activity) {
      case "Peak":
        return successColor;
      case "High":
        return infoColor;
      case "Good":
        return warningColor;
      case "Fair":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

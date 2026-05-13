import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHeatIndexView extends StatefulWidget {
  const WcaHeatIndexView({super.key});

  @override
  State<WcaHeatIndexView> createState() => _WcaHeatIndexViewState();
}

class _WcaHeatIndexViewState extends State<WcaHeatIndexView> {
  String selectedLocation = "Phoenix, AZ";
  int currentTemperature = 95;
  int currentHumidity = 60;
  int currentHeatIndex = 114;
  String riskLevel = "Extreme Caution";
  
  List<Map<String, dynamic>> heatIndexLevels = [
    {
      "range": "80-90°F",
      "level": "Caution",
      "color": "warning",
      "description": "Fatigue possible with prolonged exposure and/or physical activity",
      "precautions": ["Stay hydrated", "Take frequent breaks", "Avoid strenuous activity"],
    },
    {
      "range": "90-105°F",
      "level": "Extreme Caution",
      "color": "danger",
      "description": "Heat exhaustion and heat cramps possible with prolonged exposure",
      "precautions": ["Limit outdoor activities", "Seek shade frequently", "Wear light clothing"],
    },
    {
      "range": "105-130°F",
      "level": "Danger",
      "color": "danger",
      "description": "Heat exhaustion and heat stroke likely with continued exposure",
      "precautions": ["Avoid outdoor activity", "Stay in air conditioning", "Emergency hydration"],
    },
    {
      "range": "130°F+",
      "level": "Extreme Danger",
      "color": "danger",
      "description": "Heat stroke imminent with any exposure",
      "precautions": ["Do not go outside", "Seek immediate shelter", "Call emergency if symptoms"],
    },
  ];

  List<Map<String, dynamic>> hourlyHeatIndex = [
    {"time": "6 AM", "temp": 82, "humidity": 75, "heatIndex": 89, "risk": "Caution"},
    {"time": "9 AM", "temp": 88, "humidity": 70, "heatIndex": 97, "risk": "Extreme Caution"},
    {"time": "12 PM", "temp": 95, "humidity": 60, "heatIndex": 114, "risk": "Danger"},
    {"time": "3 PM", "temp": 98, "humidity": 55, "heatIndex": 120, "risk": "Danger"},
    {"time": "6 PM", "temp": 92, "humidity": 65, "heatIndex": 105, "risk": "Extreme Caution"},
    {"time": "9 PM", "temp": 85, "humidity": 70, "heatIndex": 93, "risk": "Extreme Caution"},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "high": 98, "low": 82, "humidity": 55, "heatIndex": 120, "risk": "Danger"},
    {"day": "Tue", "high": 96, "low": 80, "humidity": 60, "heatIndex": 116, "risk": "Danger"},
    {"day": "Wed", "high": 94, "low": 78, "humidity": 65, "heatIndex": 110, "risk": "Danger"},
    {"day": "Thu", "high": 91, "low": 76, "humidity": 70, "heatIndex": 102, "risk": "Extreme Caution"},
    {"day": "Fri", "high": 89, "low": 74, "humidity": 75, "heatIndex": 97, "risk": "Extreme Caution"},
    {"day": "Sat", "high": 92, "low": 77, "humidity": 68, "heatIndex": 106, "risk": "Danger"},
    {"day": "Sun", "high": 95, "low": 79, "humidity": 62, "heatIndex": 113, "risk": "Danger"},
  ];

  List<Map<String, dynamic>> safetyTips = [
    {
      "category": "Hydration",
      "icon": Icons.local_drink,
      "tips": [
        "Drink water every 15-20 minutes",
        "Avoid alcohol and caffeine",
        "Drink before you feel thirsty",
        "Monitor urine color for hydration",
      ],
    },
    {
      "category": "Clothing",
      "icon": Icons.checkroom,
      "tips": [
        "Wear light-colored, loose clothing",
        "Use wide-brimmed hats",
        "Choose breathable fabrics",
        "Avoid dark colors that absorb heat",
      ],
    },
    {
      "category": "Activity",
      "icon": Icons.directions_run,
      "tips": [
        "Limit outdoor activities during peak hours",
        "Take frequent breaks in shade",
        "Schedule activities for early morning",
        "Know the signs of heat exhaustion",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color riskColor = _getRiskColor(riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text("Heat Index"),
        actions: [
          IconButton(
            icon: Icon(Icons.warning),
            onPressed: () {
              si("View heat safety alerts");
            },
          ),
          IconButton(
            icon: Icon(Icons.thermostat),
            onPressed: () {
              si("Temperature settings");
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
                  colors: [dangerColor.withAlpha(20), warningColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.whatshot,
                    color: dangerColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Heat Index Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Real-time heat danger assessment",
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

            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
                border: Border.all(color: riskColor, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    "$currentHeatIndex°F",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  Text(
                    "Heat Index",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: riskColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      riskLevel,
                      style: TextStyle(
                        color: riskColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetric("Temperature", "$currentTemperature°F", Icons.thermostat),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: _buildMetric("Humidity", "$currentHumidity%", Icons.water_drop),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            QTextField(
              label: "Location",
              value: selectedLocation,
              hint: "Enter city name",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: riskColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: riskColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: riskColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Current Heat Warning",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Heat exhaustion and heat stroke likely with continued exposure",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Avoid outdoor activities • Stay in air conditioning • Emergency hydration",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Hourly Heat Index",
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
              child: QHorizontalScroll(
                children: hourlyHeatIndex.map((hour) {
                  Color hourRiskColor = _getRiskColor(hour["risk"]);

                  return Container(
                    width: 100,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: hourRiskColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: hourRiskColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${hour["time"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${hour["heatIndex"]}°F",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hourRiskColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${hour["temp"]}°F",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "${hour["humidity"]}%",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: hourRiskColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${hour["risk"]}",
                            style: TextStyle(
                              color: hourRiskColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            Text(
              "7-Day Heat Forecast",
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
                children: weeklyForecast.map((day) {
                  Color dayRiskColor = _getRiskColor(day["risk"]);

                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${day["high"]}°/${day["low"]}°F",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Humidity: ${day["humidity"]}%",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${day["heatIndex"]}°F",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dayRiskColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dayRiskColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${day["risk"]}",
                                style: TextStyle(
                                  color: dayRiskColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            Text(
              "Heat Index Scale",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...heatIndexLevels.map((level) {
              Color levelColor = _getRiskColor(level["level"]);

              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: levelColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: levelColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: levelColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${level["range"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${level["level"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: levelColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${level["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...((level["precautions"] as List<String>).map((precaution) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: levelColor,
                              size: 14,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                precaution,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
                  ],
                ),
              );
            }),

            Text(
              "Heat Safety Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...safetyTips.map((tipCategory) {
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
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
                          tipCategory["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${tipCategory["category"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...((tipCategory["tips"] as List<String>).map((tip) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                tip,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
                  ],
                ),
              );
            }),

            QButton(
              label: "Set Heat Alerts",
              size: bs.md,
              onPressed: () {
                si("Configuring heat index alerts");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "Caution":
        return warningColor;
      case "Extreme Caution":
        return warningColor;
      case "Danger":
        return dangerColor;
      case "Extreme Danger":
        return dangerColor;
      default:
        return infoColor;
    }
  }
}

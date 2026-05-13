import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWindChillView extends StatefulWidget {
  const WcaWindChillView({super.key});

  @override
  State<WcaWindChillView> createState() => _WcaWindChillViewState();
}

class _WcaWindChillViewState extends State<WcaWindChillView> {
  String selectedLocation = "Minneapolis, MN";
  int currentTemperature = 25;
  int currentWindSpeed = 20;
  int currentWindChill = 7;
  String riskLevel = "Extreme Cold";
  
  List<Map<String, dynamic>> windChillLevels = [
    {
      "range": "32°F+",
      "level": "Safe",
      "color": "success",
      "description": "No special precautions needed",
      "precautions": ["Normal winter clothing", "Stay aware of conditions"],
    },
    {
      "range": "20°F to 32°F",
      "level": "Cold",
      "color": "info",
      "description": "Uncomfortable but generally safe",
      "precautions": ["Dress warmly", "Limit exposure time", "Cover exposed skin"],
    },
    {
      "range": "-20°F to 20°F",
      "level": "Very Cold",
      "color": "warning",
      "description": "Frostbite possible in 30 minutes or less",
      "precautions": ["Dress in layers", "Cover all exposed skin", "Limit outdoor time"],
    },
    {
      "range": "-50°F to -20°F",
      "level": "Extreme Cold",
      "color": "danger",
      "description": "Frostbite possible in 10 minutes or less",
      "precautions": ["Avoid unnecessary exposure", "Emergency clothing only", "Monitor for frostbite"],
    },
    {
      "range": "Below -50°F",
      "level": "Life Threatening",
      "color": "danger",
      "description": "Frostbite possible in 5 minutes or less",
      "precautions": ["Do not go outside", "Emergency shelter", "Call for help if stranded"],
    },
  ];

  List<Map<String, dynamic>> hourlyWindChill = [
    {"time": "6 AM", "temp": 20, "wind": 25, "windChill": -2, "risk": "Extreme Cold"},
    {"time": "9 AM", "temp": 22, "wind": 22, "windChill": 2, "risk": "Extreme Cold"},
    {"time": "12 PM", "temp": 25, "wind": 20, "windChill": 7, "risk": "Extreme Cold"},
    {"time": "3 PM", "temp": 27, "wind": 18, "windChill": 12, "risk": "Very Cold"},
    {"time": "6 PM", "temp": 24, "wind": 22, "windChill": 5, "risk": "Extreme Cold"},
    {"time": "9 PM", "temp": 21, "wind": 24, "windChill": -1, "risk": "Extreme Cold"},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "high": 27, "low": 18, "wind": 20, "windChillLow": -3, "risk": "Extreme Cold"},
    {"day": "Tue", "high": 30, "low": 22, "wind": 15, "windChillLow": 8, "risk": "Very Cold"},
    {"day": "Wed", "high": 35, "low": 25, "wind": 12, "windChillLow": 16, "risk": "Very Cold"},
    {"day": "Thu", "high": 32, "low": 20, "wind": 18, "windChillLow": 3, "risk": "Extreme Cold"},
    {"day": "Fri", "high": 28, "low": 15, "wind": 22, "windChillLow": -7, "risk": "Extreme Cold"},
    {"day": "Sat", "high": 25, "low": 12, "wind": 25, "windChillLow": -12, "risk": "Extreme Cold"},
    {"day": "Sun", "high": 23, "low": 10, "wind": 28, "windChillLow": -16, "risk": "Extreme Cold"},
  ];

  List<Map<String, dynamic>> coldWeatherTips = [
    {
      "category": "Clothing",
      "icon": Icons.checkroom,
      "tips": [
        "Dress in loose, dry layers",
        "Cover all exposed skin",
        "Wear insulated, waterproof boots",
        "Use mittens instead of gloves",
        "Wear a hat that covers ears",
      ],
    },
    {
      "category": "Safety",
      "icon": Icons.security,
      "tips": [
        "Stay dry and change wet clothing immediately",
        "Limit time outdoors",
        "Keep moving to maintain circulation",
        "Stay hydrated and eat regularly",
        "Know signs of frostbite and hypothermia",
      ],
    },
    {
      "category": "Emergency",
      "icon": Icons.warning,
      "tips": [
        "Carry emergency supplies in vehicle",
        "Tell someone your travel plans",
        "Keep phone charged for emergencies",
        "Know nearest warming centers",
        "Seek immediate help for hypothermia symptoms",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color riskColor = _getRiskColor(riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text("Wind Chill"),
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              si("View cold weather alerts");
            },
          ),
          IconButton(
            icon: Icon(Icons.thermostat),
            onPressed: () {
              si("Temperature units");
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
                  colors: [infoColor.withAlpha(30), primaryColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.ac_unit,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wind Chill Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Real-time cold weather safety assessment",
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
                    "$currentWindChill°F",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  Text(
                    "Feels Like",
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
                        child: _buildMetric("Wind Speed", "$currentWindSpeed mph", Icons.air),
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
                        "Cold Weather Warning",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Frostbite possible in 10 minutes or less with current conditions",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Avoid unnecessary exposure • Dress in emergency winter clothing • Monitor for frostbite symptoms",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Hourly Wind Chill",
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
                children: hourlyWindChill.map((hour) {
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
                          "${hour["windChill"]}°F",
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
                          "${hour["wind"]} mph",
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
              "7-Day Wind Chill Forecast",
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
                                "Wind: ${day["wind"]} mph",
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
                              "Feels ${day["windChillLow"]}°F",
                              style: TextStyle(
                                fontSize: 14,
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
              "Wind Chill Scale",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...windChillLevels.map((level) {
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
              "Cold Weather Safety",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...coldWeatherTips.map((tipCategory) {
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
              label: "Set Cold Weather Alerts",
              size: bs.md,
              onPressed: () {
                si("Configuring wind chill alerts");
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
      case "Safe":
        return successColor;
      case "Cold":
        return infoColor;
      case "Very Cold":
        return warningColor;
      case "Extreme Cold":
        return dangerColor;
      case "Life Threatening":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}

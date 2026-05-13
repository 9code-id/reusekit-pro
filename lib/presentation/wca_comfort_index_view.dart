import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaComfortIndexView extends StatefulWidget {
  const WcaComfortIndexView({super.key});

  @override
  State<WcaComfortIndexView> createState() => _WcaComfortIndexViewState();
}

class _WcaComfortIndexViewState extends State<WcaComfortIndexView> {
  String selectedLocation = "New York";
  int currentComfortIndex = 75;
  String comfortLevel = "Comfortable";
  
  List<Map<String, dynamic>> comfortFactors = [
    {
      "name": "Temperature",
      "value": 72,
      "unit": "°F",
      "weight": 35,
      "status": "Optimal",
      "description": "Ideal temperature range",
      "icon": Icons.thermostat,
      "color": "success",
    },
    {
      "name": "Humidity",
      "value": 55,
      "unit": "%",
      "weight": 25,
      "status": "Good",
      "description": "Comfortable humidity level",
      "icon": Icons.water_drop,
      "color": "success",
    },
    {
      "name": "Wind Speed",
      "value": 8,
      "unit": "mph",
      "weight": 15,
      "status": "Light",
      "description": "Pleasant breeze",
      "icon": Icons.air,
      "color": "info",
    },
    {
      "name": "UV Index",
      "value": 6,
      "unit": "/10",
      "weight": 15,
      "status": "Moderate",
      "description": "Moderate UV exposure",
      "icon": Icons.wb_sunny,
      "color": "warning",
    },
    {
      "name": "Air Pressure",
      "value": 1013,
      "unit": "hPa",
      "weight": 10,
      "status": "Normal",
      "description": "Standard atmospheric pressure",
      "icon": Icons.compress,
      "color": "info",
    },
  ];

  List<Map<String, dynamic>> hourlyComfort = [
    {"time": "6 AM", "index": 68, "level": "Comfortable", "temp": 65, "humidity": 70},
    {"time": "9 AM", "index": 72, "level": "Comfortable", "temp": 68, "humidity": 65},
    {"time": "12 PM", "index": 75, "level": "Comfortable", "temp": 72, "humidity": 55},
    {"time": "3 PM", "index": 73, "level": "Comfortable", "temp": 75, "humidity": 50},
    {"time": "6 PM", "index": 76, "level": "Comfortable", "temp": 73, "humidity": 52},
    {"time": "9 PM", "index": 74, "level": "Comfortable", "temp": 70, "humidity": 58},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "index": 75, "level": "Comfortable", "high": 72, "low": 58},
    {"day": "Tue", "index": 68, "level": "Slightly Cool", "high": 69, "low": 55},
    {"day": "Wed", "index": 62, "level": "Cool", "high": 66, "low": 52},
    {"day": "Thu", "index": 71, "level": "Comfortable", "high": 70, "low": 56},
    {"day": "Fri", "index": 78, "level": "Very Comfortable", "high": 74, "low": 60},
    {"day": "Sat", "index": 76, "level": "Comfortable", "high": 76, "low": 62},
    {"day": "Sun", "index": 73, "level": "Comfortable", "high": 73, "low": 59},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comfort Index"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              si("Change location");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Comfort settings");
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
                  colors: [successColor.withAlpha(20), primaryColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sentiment_very_satisfied,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weather Comfort Index",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Real-time comfort assessment for $selectedLocation",
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
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$currentComfortIndex",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Comfort Index",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            comfortLevel,
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
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

            Text(
              "Comfort Factors",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...comfortFactors.map((factor) {
              Color factorColor = primaryColor;
              if (factor["color"] == "success") factorColor = successColor;
              if (factor["color"] == "warning") factorColor = warningColor;
              if (factor["color"] == "info") factorColor = infoColor;

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
                          factor["icon"] as IconData,
                          color: factorColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${factor["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${factor["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${factor["value"]}${factor["unit"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: factorColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: factorColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${factor["status"]}",
                                style: TextStyle(
                                  color: factorColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Impact: ${factor["weight"]}%",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (factor["weight"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: factorColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            Text(
              "Hourly Comfort Trend",
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
                  Text(
                    "Today's Comfort Index",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: hourlyComfort.map((hour) {
                      Color levelColor = successColor;
                      if ((hour["index"] as int) < 60) levelColor = warningColor;
                      if ((hour["index"] as int) > 80) levelColor = infoColor;

                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: levelColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: levelColor.withAlpha(50)),
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
                              "${hour["index"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: levelColor,
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
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Text(
              "7-Day Comfort Forecast",
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
                  Color dayColor = successColor;
                  if ((day["index"] as int) < 65) dayColor = warningColor;
                  if ((day["index"] as int) > 80) dayColor = infoColor;

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
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "${day["index"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dayColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dayColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${day["level"]}",
                              style: TextStyle(
                                color: dayColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${day["high"]}°/${day["low"]}°",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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
                        "Understanding Comfort Index",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• 0-30: Very Uncomfortable (extreme conditions)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 31-50: Uncomfortable (difficult conditions)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 51-70: Acceptable (tolerable conditions)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 71-85: Comfortable (ideal conditions)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• 86-100: Very Comfortable (perfect conditions)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Customize Comfort Settings",
              size: bs.md,
              onPressed: () {
                si("Opening comfort preferences");
              },
            ),
          ],
        ),
      ),
    );
  }
}

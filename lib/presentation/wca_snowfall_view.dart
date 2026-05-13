import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSnowfallView extends StatefulWidget {
  const WcaSnowfallView({super.key});

  @override
  State<WcaSnowfallView> createState() => _WcaSnowfallViewState();
}

class _WcaSnowfallViewState extends State<WcaSnowfallView> {
  String selectedTimeFrame = "24h";
  String selectedRegion = "Current Location";

  List<Map<String, dynamic>> timeFrameOptions = [
    {"label": "Next 24 Hours", "value": "24h"},
    {"label": "Next 48 Hours", "value": "48h"},
    {"label": "Next 7 Days", "value": "7d"},
    {"label": "Next 14 Days", "value": "14d"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "Current Location", "value": "Current Location"},
    {"label": "New York, NY", "value": "New York"},
    {"label": "Denver, CO", "value": "Denver"},
    {"label": "Chicago, IL", "value": "Chicago"},
    {"label": "Minneapolis, MN", "value": "Minneapolis"},
  ];

  List<Map<String, dynamic>> snowfallData = [
    {
      "time": "12:00 PM",
      "date": "Today",
      "intensity": "Light",
      "accumulation": "0.5 in",
      "temperature": "28°F",
      "windSpeed": "8 mph",
      "visibility": "3 miles",
      "probability": 85,
      "type": "Snow",
    },
    {
      "time": "3:00 PM",
      "date": "Today",
      "intensity": "Moderate",
      "accumulation": "1.2 in",
      "temperature": "26°F",
      "windSpeed": "12 mph",
      "visibility": "1.5 miles",
      "probability": 95,
      "type": "Heavy Snow",
    },
    {
      "time": "6:00 PM",
      "date": "Today",
      "intensity": "Heavy",
      "accumulation": "2.3 in",
      "temperature": "24°F",
      "windSpeed": "15 mph",
      "visibility": "0.8 miles",
      "probability": 98,
      "type": "Blizzard",
    },
    {
      "time": "9:00 PM",
      "date": "Today",
      "intensity": "Light",
      "accumulation": "0.8 in",
      "temperature": "22°F",
      "windSpeed": "10 mph",
      "visibility": "2 miles",
      "probability": 75,
      "type": "Snow Showers",
    },
    {
      "time": "6:00 AM",
      "date": "Tomorrow",
      "intensity": "Moderate",
      "accumulation": "1.8 in",
      "temperature": "20°F",
      "windSpeed": "18 mph",
      "visibility": "1 mile",
      "probability": 90,
      "type": "Snow Storm",
    },
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {
      "day": "Today",
      "date": "Dec 15",
      "totalAccumulation": "4.8 in",
      "highTemp": "28°F",
      "lowTemp": "18°F",
      "probability": 95,
    },
    {
      "day": "Tomorrow",
      "date": "Dec 16",
      "totalAccumulation": "2.1 in",
      "highTemp": "25°F",
      "lowTemp": "15°F",
      "probability": 80,
    },
    {
      "day": "Wednesday",
      "date": "Dec 17",
      "totalAccumulation": "0.3 in",
      "highTemp": "32°F",
      "lowTemp": "22°F",
      "probability": 45,
    },
    {
      "day": "Thursday",
      "date": "Dec 18",
      "totalAccumulation": "1.5 in",
      "highTemp": "29°F",
      "lowTemp": "19°F",
      "probability": 70,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snowfall Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Snowfall forecast shared");
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
            // Alert Banner
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Winter Storm Warning",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Heavy snowfall expected. Travel conditions may be hazardous.",
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Frame",
                    items: timeFrameOptions,
                    value: selectedTimeFrame,
                    onChanged: (value, label) {
                      selectedTimeFrame = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regionOptions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Current Conditions
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
                    "Current Snowfall",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.ac_unit,
                        color: infoColor,
                        size: 48,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Moderate Snow",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Accumulation: 1.2 inches/hour",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Visibility: 2.5 miles",
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
            ),

            // Hourly Snowfall Forecast
            Text(
              "Hourly Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...snowfallData.map((snow) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Text(
                          "${snow["time"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${snow["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Icon(
                    Icons.ac_unit,
                    color: _getIntensityColor(snow["intensity"]),
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${snow["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${snow["probability"]}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Accumulation: ${snow["accumulation"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Temp: ${snow["temperature"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Wind: ${snow["windSpeed"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Visibility: ${snow["visibility"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

            // Weekly Forecast
            Text(
              "Weekly Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...weeklyForecast.map((day) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${day["day"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${day["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Icon(
                    Icons.ac_unit,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: ${day["totalAccumulation"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${day["probability"]}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "High: ${day["highTemp"]} • Low: ${day["lowTemp"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

            // Snow Safety Tips
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
                        "Snow Safety Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Keep emergency supplies in your vehicle",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Allow extra time for travel",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Clear snow from vehicle completely before driving",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Check road conditions before departure",
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

  Color _getIntensityColor(String intensity) {
    switch (intensity.toLowerCase()) {
      case "light":
        return successColor;
      case "moderate":
        return warningColor;
      case "heavy":
        return dangerColor;
      default:
        return infoColor;
    }
  }
}

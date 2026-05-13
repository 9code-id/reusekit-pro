import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSeasonalPatternsView extends StatefulWidget {
  const WcaSeasonalPatternsView({super.key});

  @override
  State<WcaSeasonalPatternsView> createState() => _WcaSeasonalPatternsViewState();
}

class _WcaSeasonalPatternsViewState extends State<WcaSeasonalPatternsView> {
  String selectedLocation = "New York";
  String selectedSeason = "All Seasons";
  
  List<Map<String, dynamic>> seasonalData = [
    {
      "season": "Spring",
      "months": "March - May",
      "avgTemp": 16.2,
      "avgHigh": 21.4,
      "avgLow": 11.0,
      "precipitation": 315,
      "humidity": 58,
      "windSpeed": 15.2,
      "sunHours": 712,
      "rainyDays": 36,
      "characteristics": [
        "Gradual warming trend",
        "Frequent rain showers",
        "Variable weather patterns",
        "Blooming vegetation"
      ],
      "color": successColor,
      "icon": Icons.eco,
      "startDate": "March 20",
      "endDate": "June 20",
    },
    {
      "season": "Summer",
      "months": "June - August",
      "avgTemp": 25.8,
      "avgHigh": 29.1,
      "avgLow": 20.5,
      "precipitation": 295,
      "humidity": 65,
      "windSpeed": 11.8,
      "sunHours": 864,
      "rainyDays": 28,
      "characteristics": [
        "Hot and humid conditions",
        "Thunderstorm activity",
        "Peak tourism season",
        "High UV index"
      ],
      "color": dangerColor,
      "icon": Icons.wb_sunny,
      "startDate": "June 21",
      "endDate": "September 22",
    },
    {
      "season": "Autumn",
      "months": "September - November",
      "avgTemp": 17.5,
      "avgHigh": 22.3,
      "avgLow": 12.7,
      "precipitation": 268,
      "humidity": 61,
      "windSpeed": 13.5,
      "sunHours": 615,
      "rainyDays": 32,
      "characteristics": [
        "Cooling temperatures",
        "Colorful foliage",
        "Harvest season",
        "Comfortable weather"
      ],
      "color": warningColor,
      "icon": Icons.park,
      "startDate": "September 23",
      "endDate": "December 20",
    },
    {
      "season": "Winter",
      "months": "December - February",
      "avgTemp": 2.1,
      "avgHigh": 5.8,
      "avgLow": -1.6,
      "precipitation": 245,
      "humidity": 64,
      "windSpeed": 16.8,
      "sunHours": 456,
      "rainyDays": 28,
      "characteristics": [
        "Cold temperatures",
        "Snow and ice",
        "Short daylight hours",
        "Indoor activities peak"
      ],
      "color": infoColor,
      "icon": Icons.ac_unit,
      "startDate": "December 21",
      "endDate": "March 19",
    },
  ];

  List<Map<String, dynamic>> monthlyPatterns = [
    {"month": "January", "avgTemp": 1.2, "precipitation": 86, "dayLength": "9h 26m", "season": "Winter"},
    {"month": "February", "avgTemp": 2.8, "precipitation": 78, "dayLength": "10h 42m", "season": "Winter"},
    {"month": "March", "avgTemp": 8.5, "precipitation": 109, "dayLength": "12h 00m", "season": "Spring"},
    {"month": "April", "avgTemp": 15.2, "precipitation": 114, "dayLength": "13h 18m", "season": "Spring"},
    {"month": "May", "avgTemp": 20.9, "precipitation": 119, "dayLength": "14h 29m", "season": "Spring"},
    {"month": "June", "avgTemp": 25.8, "precipitation": 100, "dayLength": "15h 05m", "season": "Summer"},
    {"month": "July", "avgTemp": 28.2, "precipitation": 117, "dayLength": "14h 52m", "season": "Summer"},
    {"month": "August", "avgTemp": 27.1, "precipitation": 109, "dayLength": "13h 46m", "season": "Summer"},
    {"month": "September", "avgTemp": 22.8, "precipitation": 95, "dayLength": "12h 21m", "season": "Autumn"},
    {"month": "October", "avgTemp": 16.9, "precipitation": 89, "dayLength": "10h 54m", "season": "Autumn"},
    {"month": "November", "avgTemp": 10.8, "precipitation": 102, "dayLength": "9h 35m", "season": "Autumn"},
    {"month": "December", "avgTemp": 3.2, "precipitation": 105, "dayLength": "9h 15m", "season": "Winter"},
  ];

  List<Map<String, dynamic>> climateTriggers = [
    {
      "trigger": "Spring Onset",
      "condition": "3 consecutive days >10°C",
      "typicalDate": "March 15-25",
      "earlyDate": "March 8",
      "lateDate": "April 5",
      "trend": "Earlier by 5 days",
      "color": successColor,
    },
    {
      "trigger": "Last Frost",
      "condition": "Temperature drops below 0°C",
      "typicalDate": "April 10-20",
      "earlyDate": "March 28",
      "lateDate": "May 2",
      "trend": "Earlier by 8 days",
      "color": infoColor,
    },
    {
      "trigger": "Summer Peak",
      "condition": "Hottest temperatures of year",
      "typicalDate": "July 15-25",
      "earlyDate": "July 8",
      "lateDate": "August 5",
      "trend": "2 days later",
      "color": dangerColor,
    },
    {
      "trigger": "Autumn Colors",
      "condition": "50% leaf color change",
      "typicalDate": "October 5-15",
      "earlyDate": "September 25",
      "lateDate": "October 25",
      "trend": "Later by 3 days",
      "color": warningColor,
    },
    {
      "trigger": "First Frost",
      "condition": "First temperature below 0°C",
      "typicalDate": "October 25 - Nov 5",
      "earlyDate": "October 15",
      "lateDate": "November 18",
      "trend": "Later by 6 days",
      "color": infoColor,
    },
    {
      "trigger": "Winter Solstice",
      "condition": "Shortest day of year",
      "typicalDate": "December 21",
      "earlyDate": "December 21",
      "lateDate": "December 22",
      "trend": "Stable",
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Patterns"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_view_month),
            onPressed: () {
              si("Calendar view opened");
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
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.autorenew,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Seasonal Weather Patterns",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Cyclical weather patterns and seasonal transitions for $selectedLocation",
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

            Text(
              "Four Seasons Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...seasonalData.map((season) {
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (season["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            season["icon"] as IconData,
                            color: season["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${season["season"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "${season["months"]} (${season["startDate"]} - ${season["endDate"]})",
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
                    SizedBox(height: spSm),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 120,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (season["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Average Temp",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(season["avgTemp"] as double).toStringAsFixed(1)}°C",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "H: ${(season["avgHigh"] as double).toStringAsFixed(1)}° L: ${(season["avgLow"] as double).toStringAsFixed(1)}°",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (season["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Precipitation",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${season["precipitation"]}mm",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "${season["rainyDays"]} rainy days",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (season["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Sunshine",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${season["sunHours"]}h",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "${((season["sunHours"] as int) / 90).toStringAsFixed(1)}h/day",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (season["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${season["humidity"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "${(season["windSpeed"] as double).toStringAsFixed(1)} km/h wind",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    Text(
                      "Characteristics:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(season["characteristics"] as List<String>).map((char) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 6,
                              color: season["color"] as Color,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              char,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),

            Text(
              "Monthly Weather Pattern",
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Month",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Avg Temp",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Rain",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Daylight",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...monthlyPatterns.map((month) {
                    Color seasonColor = month["season"] == "Spring" ? successColor :
                                       month["season"] == "Summer" ? dangerColor :
                                       month["season"] == "Autumn" ? warningColor : infoColor;
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${month["month"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: seasonColor,
                            ),
                          ),
                          Text(
                            "${(month["avgTemp"] as double).toStringAsFixed(1)}°C",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${month["precipitation"]}mm",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${month["dayLength"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            Text(
              "Seasonal Transitions & Climate Triggers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...climateTriggers.map((trigger) {
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
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: trigger["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${trigger["trigger"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${trigger["trend"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: trigger["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${trigger["condition"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Typical: ${trigger["typicalDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " | Range: ${trigger["earlyDate"]} - ${trigger["lateDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
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
              );
            }).toList(),

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
                        Icons.info_outline,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Seasonal Pattern Changes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Spring is arriving earlier with warmer temperatures starting sooner",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Summer heat waves are becoming more intense and longer lasting",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Autumn leaf-changing seasons are extending later into the year",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Winter frost periods are shorter with milder temperature patterns",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
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

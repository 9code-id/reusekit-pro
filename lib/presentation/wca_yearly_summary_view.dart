import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaYearlySummaryView extends StatefulWidget {
  const WcaYearlySummaryView({super.key});

  @override
  State<WcaYearlySummaryView> createState() => _WcaYearlySummaryViewState();
}

class _WcaYearlySummaryViewState extends State<WcaYearlySummaryView> {
  String selectedYear = "2024";
  String selectedLocation = "New York";
  
  Map<String, dynamic> yearlySummary = {
    "year": "2024",
    "location": "New York",
    "avgTemperature": 16.2,
    "avgHigh": 21.5,
    "avgLow": 10.8,
    "highestTemp": 35.2,
    "highestTempDate": "2024-07-15",
    "lowestTemp": -8.5,
    "lowestTempDate": "2024-01-22",
    "totalPrecipitation": 1124,
    "avgHumidity": 62,
    "avgWindSpeed": 13.2,
    "avgUvIndex": 5.2,
    "totalSunHours": 2456,
    "rainyDays": 128,
    "snowyDays": 15,
    "stormyDays": 8,
    "clearDays": 214,
  };

  List<Map<String, dynamic>> seasonalData = [
    {
      "season": "Spring",
      "months": "Mar - May",
      "avgTemp": 16,
      "avgHigh": 21,
      "avgLow": 11,
      "precipitation": 315,
      "rainyDays": 36,
      "sunHours": 712,
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "season": "Summer",
      "months": "Jun - Aug",
      "avgTemp": 25,
      "avgHigh": 28,
      "avgLow": 20,
      "precipitation": 305,
      "rainyDays": 30,
      "sunHours": 864,
      "color": dangerColor,
      "icon": Icons.wb_sunny,
    },
    {
      "season": "Autumn",
      "months": "Sep - Nov",
      "avgTemp": 17,
      "avgHigh": 18,
      "avgLow": 10,
      "precipitation": 260,
      "rainyDays": 27,
      "sunHours": 629,
      "color": warningColor,
      "icon": Icons.park,
    },
    {
      "season": "Winter",
      "months": "Dec - Feb",
      "avgTemp": 4,
      "avgHigh": 4,
      "avgLow": -2,
      "precipitation": 244,
      "rainyDays": 35,
      "sunHours": 251,
      "color": infoColor,
      "icon": Icons.ac_unit,
    },
  ];

  List<Map<String, dynamic>> weatherRecords = [
    {
      "type": "Hottest Day",
      "value": "35.2°C",
      "date": "July 15, 2024",
      "icon": Icons.thermostat,
      "color": dangerColor,
    },
    {
      "type": "Coldest Day",
      "value": "-8.5°C",
      "date": "January 22, 2024",
      "icon": Icons.ac_unit,
      "color": infoColor,
    },
    {
      "type": "Wettest Day",
      "value": "64mm",
      "date": "April 3, 2024",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "type": "Windiest Day",
      "value": "82 km/h",
      "date": "November 12, 2024",
      "icon": Icons.air,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yearly Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Report downloaded successfully");
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
                    Icons.analytics,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weather Summary - $selectedYear",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Complete yearly weather analysis for $selectedLocation",
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
              "Annual Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Average Temperature",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(yearlySummary["avgTemperature"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "High: ${(yearlySummary["avgHigh"] as double).toStringAsFixed(1)}° | Low: ${(yearlySummary["avgLow"] as double).toStringAsFixed(1)}°",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Total Precipitation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${yearlySummary["totalPrecipitation"]}mm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${yearlySummary["rainyDays"]} rainy days",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Sunshine Hours",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${yearlySummary["totalSunHours"]}h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "≈ ${((yearlySummary["totalSunHours"] as int) / 365).toStringAsFixed(1)}h per day",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
                    children: [
                      Icon(
                        Icons.air,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Average Wind",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(yearlySummary["avgWindSpeed"] as double).toStringAsFixed(1)} km/h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${yearlySummary["avgHumidity"]}% humidity",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Weather Records",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 180,
              children: weatherRecords.map((record) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        record["icon"] as IconData,
                        color: record["color"] as Color,
                        size: 28,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${record["type"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${record["value"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: record["color"] as Color,
                        ),
                      ),
                      Text(
                        "${record["date"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Seasonal Breakdown",
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
                        Icon(
                          season["icon"] as IconData,
                          color: season["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
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
                                "${season["months"]}",
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
                                "Avg Temperature",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${season["avgTemp"]}°C",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "High: ${season["avgHigh"]}° | Low: ${season["avgLow"]}°",
                                textAlign: TextAlign.center,
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
                                  fontSize: 16,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                              Text(
                                "≈ ${((season["sunHours"] as int) / 90).toStringAsFixed(1)}h/day",
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
                  ],
                ),
              );
            }).toList(),

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
                        Icons.info_outline,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Summary Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• This year had ${yearlySummary["clearDays"]} clear days and ${yearlySummary["stormyDays"]} stormy days",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Total precipitation was ${(yearlySummary["totalPrecipitation"] as int) > 1000 ? "above" : "below"} average for this region",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Average UV index of ${(yearlySummary["avgUvIndex"] as double).toStringAsFixed(1)} indicates ${(yearlySummary["avgUvIndex"] as double) > 6 ? "high" : "moderate"} sun exposure",
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

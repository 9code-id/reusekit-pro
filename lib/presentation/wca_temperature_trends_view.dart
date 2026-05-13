import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTemperatureTrendsView extends StatefulWidget {
  const WcaTemperatureTrendsView({super.key});

  @override
  State<WcaTemperatureTrendsView> createState() => _WcaTemperatureTrendsViewState();
}

class _WcaTemperatureTrendsViewState extends State<WcaTemperatureTrendsView> {
  String selectedPeriod = "10 Years";
  String selectedLocation = "New York";
  
  Map<String, dynamic> trendSummary = {
    "period": "2014-2024",
    "avgTempChange": "+1.2°C",
    "trend": "Warming",
    "warmestYear": 2023,
    "coldestYear": 2015,
    "avgWarmingRate": "+0.12°C/year",
    "extremeTempIncrease": "+2.1°C",
  };

  List<Map<String, dynamic>> yearlyData = [
    {"year": 2014, "avgTemp": 11.8, "maxTemp": 34.2, "minTemp": -12.1},
    {"year": 2015, "avgTemp": 10.5, "maxTemp": 32.8, "minTemp": -15.3},
    {"year": 2016, "avgTemp": 12.1, "maxTemp": 35.1, "minTemp": -10.8},
    {"year": 2017, "avgTemp": 11.9, "maxTemp": 33.9, "minTemp": -11.5},
    {"year": 2018, "avgTemp": 12.4, "maxTemp": 34.8, "minTemp": -9.2},
    {"year": 2019, "avgTemp": 12.8, "maxTemp": 35.6, "minTemp": -8.9},
    {"year": 2020, "avgTemp": 13.1, "maxTemp": 36.2, "minTemp": -7.8},
    {"year": 2021, "avgTemp": 12.9, "maxTemp": 35.9, "minTemp": -8.1},
    {"year": 2022, "avgTemp": 13.3, "maxTemp": 37.1, "minTemp": -6.9},
    {"year": 2023, "avgTemp": 13.8, "maxTemp": 38.2, "minTemp": -5.2},
    {"year": 2024, "avgTemp": 13.5, "maxTemp": 37.8, "minTemp": -6.1},
  ];

  List<Map<String, dynamic>> seasonalTrends = [
    {
      "season": "Spring",
      "months": "Mar-May",
      "trend": "+1.5°C",
      "description": "Warming trend with earlier spring onset",
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "season": "Summer",
      "months": "Jun-Aug",
      "trend": "+2.1°C",
      "description": "Significant warming with more heat waves",
      "color": dangerColor,
      "icon": Icons.wb_sunny,
    },
    {
      "season": "Autumn",
      "months": "Sep-Nov",
      "trend": "+0.9°C",
      "description": "Moderate warming with extended growing season",
      "color": warningColor,
      "icon": Icons.park,
    },
    {
      "season": "Winter",
      "months": "Dec-Feb",
      "trend": "+0.8°C",
      "description": "Milder winters with less extreme cold",
      "color": infoColor,
      "icon": Icons.ac_unit,
    },
  ];

  List<Map<String, dynamic>> temperatureRecords = [
    {
      "type": "Hottest Day",
      "value": "38.2°C",
      "year": 2023,
      "trend": "+3.2°C vs 2014",
      "icon": Icons.whatshot,
      "color": dangerColor,
    },
    {
      "type": "Coldest Day",
      "value": "-5.2°C",
      "year": 2023,
      "trend": "+6.9°C vs 2015",
      "icon": Icons.ac_unit,
      "color": infoColor,
    },
    {
      "type": "Heat Wave Days",
      "value": "28 days",
      "year": 2023,
      "trend": "+15 days vs 2014",
      "icon": Icons.local_fire_department,
      "color": dangerColor,
    },
    {
      "type": "Frost Days",
      "value": "45 days",
      "year": 2024,
      "trend": "-18 days vs 2014",
      "icon": Icons.ac_unit,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Trends"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Temperature trends shared successfully");
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
                    Icons.trending_up,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Temperature Trends Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "10-year temperature data and climate change patterns for $selectedLocation",
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
              "Trend Summary (${trendSummary["period"]})",
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
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Average Change",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${trendSummary["avgTempChange"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${trendSummary["trend"]} Trend",
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
                        Icons.trending_up,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Warming Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${trendSummary["avgWarmingRate"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "per year",
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
                        Icons.whatshot,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Warmest Year",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${trendSummary["warmestYear"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Record High",
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
                        Icons.ac_unit,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Coldest Year",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${trendSummary["coldestYear"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Coldest Period",
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
              "Yearly Temperature Data",
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
                        "Year",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Avg Temp",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Max",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Min",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...yearlyData.map((data) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${data["year"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(data["avgTemp"] as double).toStringAsFixed(1)}°C",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(data["maxTemp"] as double).toStringAsFixed(1)}°",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${(data["minTemp"] as double).toStringAsFixed(1)}°",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
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
              "Seasonal Temperature Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...seasonalTrends.map((season) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${season["season"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${season["trend"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: season["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${season["months"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${season["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            Text(
              "Temperature Records & Changes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 180,
              children: temperatureRecords.map((record) {
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
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${record["value"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: record["color"] as Color,
                        ),
                      ),
                      Text(
                        "in ${record["year"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${record["trend"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: record["color"] as Color,
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
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Climate Change Impact",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Temperature has increased by ${trendSummary["avgTempChange"]} over the past 10 years",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Extreme temperatures are becoming ${trendSummary["extremeTempIncrease"]} higher",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Heat waves are becoming more frequent and intense",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Winter temperatures are rising faster than summer temperatures",
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWeatherStatisticsView extends StatefulWidget {
  const WcaWeatherStatisticsView({super.key});

  @override
  State<WcaWeatherStatisticsView> createState() => _WcaWeatherStatisticsViewState();
}

class _WcaWeatherStatisticsViewState extends State<WcaWeatherStatisticsView> {
  String selectedPeriod = "10 Years";
  String selectedLocation = "New York";
  String selectedCategory = "All Statistics";
  
  Map<String, dynamic> overallStats = {
    "totalObservations": 3652,
    "dataCompleteness": 99.2,
    "recordingPeriod": "2014-2024",
    "avgTemperature": 12.7,
    "avgPrecipitation": 1268,
    "avgHumidity": 62.4,
    "avgWindSpeed": 13.8,
  };

  List<Map<String, dynamic>> temperatureStats = [
    {
      "metric": "Average Temperature",
      "value": "12.7°C",
      "percentile25": "8.2°C",
      "percentile75": "17.8°C",
      "standardDev": "9.1°C",
      "color": primaryColor,
    },
    {
      "metric": "Maximum Temperature",
      "value": "38.2°C",
      "percentile25": "32.1°C",
      "percentile75": "35.9°C",
      "standardDev": "2.8°C",
      "color": dangerColor,
    },
    {
      "metric": "Minimum Temperature",
      "value": "-15.3°C",
      "percentile25": "-8.4°C",
      "percentile75": "-2.1°C",
      "standardDev": "4.2°C",
      "color": infoColor,
    },
    {
      "metric": "Daily Temperature Range",
      "value": "11.2°C",
      "percentile25": "7.8°C",
      "percentile75": "14.6°C",
      "standardDev": "3.1°C",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> precipitationStats = [
    {
      "metric": "Annual Precipitation",
      "value": "1268mm",
      "percentile25": "1089mm",
      "percentile75": "1421mm",
      "standardDev": "156mm",
      "color": primaryColor,
    },
    {
      "metric": "Wettest Day",
      "value": "127mm",
      "percentile25": "89mm",
      "percentile75": "115mm",
      "standardDev": "18mm",
      "color": infoColor,
    },
    {
      "metric": "Rainy Days Per Year",
      "value": "134 days",
      "percentile25": "118 days",
      "percentile75": "148 days",
      "standardDev": "16 days",
      "color": successColor,
    },
    {
      "metric": "Longest Dry Spell",
      "value": "28 days",
      "percentile25": "15 days",
      "percentile75": "23 days",
      "standardDev": "6 days",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> extremeStats = [
    {
      "category": "Heat Events",
      "totalEvents": 89,
      "avgPerYear": 8.9,
      "longestEvent": "12 days",
      "mostInYear": 18,
      "description": "Days above 32°C",
      "color": dangerColor,
      "icon": Icons.whatshot,
    },
    {
      "category": "Cold Events",
      "totalEvents": 156,
      "avgPerYear": 15.6,
      "longestEvent": "8 days",
      "mostInYear": 28,
      "description": "Days below -5°C",
      "color": infoColor,
      "icon": Icons.ac_unit,
    },
    {
      "category": "Heavy Rain",
      "totalEvents": 67,
      "avgPerYear": 6.7,
      "longestEvent": "3 days",
      "mostInYear": 12,
      "description": "Days above 25mm",
      "color": primaryColor,
      "icon": Icons.thunderstorm,
    },
    {
      "category": "Strong Wind",
      "totalEvents": 43,
      "avgPerYear": 4.3,
      "longestEvent": "2 days",
      "mostInYear": 8,
      "description": "Wind above 50 km/h",
      "color": successColor,
      "icon": Icons.air,
    },
  ];

  List<Map<String, dynamic>> frequencyStats = [
    {"condition": "Sunny Days", "frequency": 156, "percentage": 42.7, "color": warningColor},
    {"condition": "Partly Cloudy", "frequency": 89, "percentage": 24.4, "color": successColor},
    {"condition": "Cloudy Days", "frequency": 78, "percentage": 21.4, "color": disabledBoldColor},
    {"condition": "Rainy Days", "frequency": 134, "percentage": 36.7, "color": infoColor},
    {"condition": "Snowy Days", "frequency": 18, "percentage": 4.9, "color": infoColor},
    {"condition": "Foggy Days", "frequency": 24, "percentage": 6.6, "color": disabledBoldColor},
    {"condition": "Stormy Days", "frequency": 12, "percentage": 3.3, "color": dangerColor},
  ];

  List<Map<String, dynamic>> correlationStats = [
    {
      "variables": "Temperature vs Humidity",
      "correlation": -0.68,
      "strength": "Strong Negative",
      "description": "Higher temperatures generally reduce humidity",
      "color": dangerColor,
    },
    {
      "variables": "Pressure vs Rain",
      "correlation": -0.52,
      "strength": "Moderate Negative", 
      "description": "Lower pressure often precedes rainfall",
      "color": primaryColor,
    },
    {
      "variables": "Wind Speed vs Temperature",
      "correlation": 0.31,
      "strength": "Weak Positive",
      "description": "Slightly higher winds with warmer temperatures",
      "color": successColor,
    },
    {
      "variables": "Humidity vs Rain Probability",
      "correlation": 0.74,
      "strength": "Strong Positive",
      "description": "High humidity strongly indicates rain likelihood",
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Statistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Statistics report downloaded");
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
                          "Weather Statistics Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Comprehensive statistical analysis of weather data for $selectedLocation",
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
              "Overall Statistics Summary",
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
                        Icons.dataset,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Total Observations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${overallStats["totalObservations"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${overallStats["recordingPeriod"]}",
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
                        Icons.check_circle,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Data Completeness",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(overallStats["dataCompleteness"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Quality Score",
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
                        Icons.thermostat,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Avg Temperature",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(overallStats["avgTemperature"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Long-term Mean",
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
                        "Avg Precipitation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${overallStats["avgPrecipitation"]}mm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Annual Total",
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
              "Temperature Statistics",
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
                        "Metric",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "25th-75th",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Std Dev",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...temperatureStats.map((stat) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${stat["metric"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                          Text(
                            "${stat["percentile25"]}-${stat["percentile75"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${stat["standardDev"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
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
              "Precipitation Statistics",
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
                        "Metric",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "25th-75th",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Std Dev",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...precipitationStats.map((stat) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${stat["metric"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                          Text(
                            "${stat["percentile25"]}-${stat["percentile75"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${stat["standardDev"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
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
              "Extreme Weather Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 180,
              children: extremeStats.map((stat) {
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
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 28,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["category"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["totalEvents"]} events",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stat["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Avg: ${(stat["avgPerYear"] as double).toStringAsFixed(1)}/year",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Longest: ${stat["longestEvent"]}",
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

            Text(
              "Weather Frequency Analysis",
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
                children: frequencyStats.map((freq) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${freq["condition"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${freq["frequency"]} days (${(freq["percentage"] as double).toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: freq["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (freq["percentage"] as double) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: freq["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
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
              "Weather Correlations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...correlationStats.map((corr) {
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
                        color: corr["color"] as Color,
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
                                "${corr["variables"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(corr["correlation"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: corr["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${corr["strength"]} correlation",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: corr["color"] as Color,
                            ),
                          ),
                          Text(
                            "${corr["description"]}",
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
                        "Statistical Insights",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Temperature variance shows strong seasonal patterns with 9.1°C standard deviation",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Precipitation events follow irregular patterns with high variance (156mm std dev)",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Strong negative correlation (-0.68) between temperature and humidity",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Data completeness of ${(overallStats["dataCompleteness"] as double).toStringAsFixed(1)}% ensures statistical reliability",
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaClimateDataView extends StatefulWidget {
  const WcaClimateDataView({super.key});

  @override
  State<WcaClimateDataView> createState() => _WcaClimateDataViewState();
}

class _WcaClimateDataViewState extends State<WcaClimateDataView> {
  String selectedLocation = "New York";
  String selectedPeriod = "30 Years";
  
  Map<String, dynamic> climateNormals = {
    "period": "1991-2020",
    "location": "New York",
    "avgAnnualTemp": 12.9,
    "avgWinterTemp": 1.2,
    "avgSpringTemp": 11.8,
    "avgSummerTemp": 24.7,
    "avgAutumnTemp": 14.3,
    "avgAnnualPrecipitation": 1268,
    "avgSnowfall": 76,
    "avgFrostDays": 69,
    "avgSunshineHours": 2534,
    "extremeHigh": 42.2,
    "extremeHighDate": "July 9, 1936",
    "extremeLow": -26.1,
    "extremeLowDate": "February 9, 1934",
    "avgWindSpeed": 14.5,
    "prevailingWindDirection": "W",
  };

  List<Map<String, dynamic>> monthlyNormals = [
    {"month": "Jan", "avgHigh": 3, "avgLow": -4, "precipitation": 86, "snowfall": 18},
    {"month": "Feb", "avgHigh": 5, "avgLow": -3, "precipitation": 78, "snowfall": 16},
    {"month": "Mar", "avgHigh": 10, "avgLow": 1, "precipitation": 109, "snowfall": 8},
    {"month": "Apr", "avgHigh": 16, "avgLow": 6, "precipitation": 114, "snowfall": 1},
    {"month": "May", "avgHigh": 22, "avgLow": 12, "precipitation": 119, "snowfall": 0},
    {"month": "Jun", "avgHigh": 27, "avgLow": 17, "precipitation": 112, "snowfall": 0},
    {"month": "Jul", "avgHigh": 29, "avgLow": 20, "precipitation": 117, "snowfall": 0},
    {"month": "Aug", "avgHigh": 28, "avgLow": 19, "precipitation": 109, "snowfall": 0},
    {"month": "Sep", "avgHigh": 24, "avgLow": 15, "precipitation": 104, "snowfall": 0},
    {"month": "Oct", "avgHigh": 18, "avgLow": 9, "precipitation": 93, "snowfall": 1},
    {"month": "Nov", "avgHigh": 12, "avgLow": 4, "precipitation": 102, "snowfall": 4},
    {"month": "Dec", "avgHigh": 6, "avgLow": -1, "precipitation": 105, "snowfall": 13},
  ];

  List<Map<String, dynamic>> climateIndicators = [
    {
      "indicator": "Growing Season Length",
      "value": "201 days",
      "description": "Average days with temperature above 5°C",
      "icon": Icons.grass,
      "color": successColor,
    },
    {
      "indicator": "Heating Degree Days",
      "value": "4,912",
      "description": "Energy needed for heating buildings",
      "icon": Icons.heat_pump,
      "color": dangerColor,
    },
    {
      "indicator": "Cooling Degree Days",
      "value": "874",
      "description": "Energy needed for cooling buildings",
      "icon": Icons.ac_unit,
      "color": infoColor,
    },
    {
      "indicator": "Frost-Free Period",
      "value": "172 days",
      "description": "Days without frost (Apr-Oct)",
      "icon": Icons.eco,
      "color": primaryColor,
    },
    {
      "indicator": "Wet Days",
      "value": "123 days",
      "description": "Days with precipitation ≥1mm",
      "icon": Icons.water_drop,
      "color": infoColor,
    },
    {
      "indicator": "Thunderstorm Days",
      "value": "21 days",
      "description": "Days with thunder and lightning",
      "icon": Icons.flash_on,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> extremeEvents = [
    {
      "event": "Heat Waves",
      "frequency": "3-4 per year",
      "description": "3+ consecutive days above 32°C",
      "avgDuration": "4.2 days",
      "color": dangerColor,
    },
    {
      "event": "Cold Spells",
      "frequency": "2-3 per year",
      "description": "5+ consecutive days below -10°C",
      "avgDuration": "6.8 days",
      "color": infoColor,
    },
    {
      "event": "Heavy Rain",
      "frequency": "8-12 per year",
      "description": "Daily precipitation ≥25mm",
      "avgDuration": "1 day",
      "color": primaryColor,
    },
    {
      "event": "Blizzards",
      "frequency": "1-2 per year",
      "description": "Heavy snow with strong winds",
      "avgDuration": "1.5 days",
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Climate Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Climate data exported successfully");
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
                    Icons.public,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Climate Normals (${climateNormals["period"]})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "30-year average climate data for ${climateNormals["location"]}",
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
              "Annual Climate Summary",
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
                        "${(climateNormals["avgAnnualTemp"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 20,
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
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Annual Precipitation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${climateNormals["avgAnnualPrecipitation"]}mm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                        "Annual Snowfall",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${climateNormals["avgSnowfall"]}cm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                        "${climateNormals["avgSunshineHours"]}h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Seasonal Averages",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.eco,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Spring",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${(climateNormals["avgSpringTemp"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: dangerColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Summer",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${(climateNormals["avgSummerTemp"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.park,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Autumn",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${(climateNormals["avgAutumnTemp"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
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
                    children: [
                      Icon(
                        Icons.ac_unit,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Winter",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${(climateNormals["avgWinterTemp"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Monthly Climate Normals",
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "High/Low",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Rain",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Snow",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...monthlyNormals.map((month) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${month["month"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${month["avgHigh"]}°/${month["avgLow"]}°",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${month["precipitation"]}mm",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${month["snowfall"]}cm",
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
              "Climate Indicators",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 180,
              children: climateIndicators.map((indicator) {
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
                        indicator["icon"] as IconData,
                        color: indicator["color"] as Color,
                        size: 28,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${indicator["indicator"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${indicator["value"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: indicator["color"] as Color,
                        ),
                      ),
                      Text(
                        "${indicator["description"]}",
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
              "Extreme Weather Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...extremeEvents.map((event) {
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
                      height: 60,
                      decoration: BoxDecoration(
                        color: event["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["event"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${event["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Frequency: ${event["frequency"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Duration: ${event["avgDuration"]}",
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
                        "Climate Data Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• All-time record high: ${climateNormals["extremeHigh"]}°C on ${climateNormals["extremeHighDate"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• All-time record low: ${climateNormals["extremeLow"]}°C on ${climateNormals["extremeLowDate"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Prevailing wind direction: ${climateNormals["prevailingWindDirection"]} at ${(climateNormals["avgWindSpeed"] as double).toStringAsFixed(1)} km/h average",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Climate normals are updated every 10 years based on 30-year averages",
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

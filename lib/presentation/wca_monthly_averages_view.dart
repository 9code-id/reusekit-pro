import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaMonthlyAveragesView extends StatefulWidget {
  const WcaMonthlyAveragesView({super.key});

  @override
  State<WcaMonthlyAveragesView> createState() => _WcaMonthlyAveragesViewState();
}

class _WcaMonthlyAveragesViewState extends State<WcaMonthlyAveragesView> {
  String selectedYear = "2024";
  String selectedLocation = "New York";
  
  List<Map<String, dynamic>> monthlyAverages = [
    {
      "month": "January",
      "avgHigh": 3,
      "avgLow": -4,
      "precipitation": 78,
      "humidity": 62,
      "windSpeed": 15,
      "uvIndex": 2,
      "sunHours": 5,
      "rainyDays": 12,
    },
    {
      "month": "February", 
      "avgHigh": 5,
      "avgLow": -2,
      "precipitation": 65,
      "humidity": 59,
      "windSpeed": 14,
      "uvIndex": 3,
      "sunHours": 6,
      "rainyDays": 10,
    },
    {
      "month": "March",
      "avgHigh": 10,
      "avgLow": 2,
      "precipitation": 95,
      "humidity": 61,
      "windSpeed": 16,
      "uvIndex": 4,
      "sunHours": 7,
      "rainyDays": 13,
    },
    {
      "month": "April",
      "avgHigh": 16,
      "avgLow": 7,
      "precipitation": 105,
      "humidity": 58,
      "windSpeed": 15,
      "uvIndex": 6,
      "sunHours": 8,
      "rainyDays": 11,
    },
    {
      "month": "May",
      "avgHigh": 22,
      "avgLow": 13,
      "precipitation": 115,
      "humidity": 61,
      "windSpeed": 13,
      "uvIndex": 7,
      "sunHours": 9,
      "rainyDays": 12,
    },
    {
      "month": "June",
      "avgHigh": 27,
      "avgLow": 18,
      "precipitation": 100,
      "humidity": 64,
      "windSpeed": 12,
      "uvIndex": 8,
      "sunHours": 10,
      "rainyDays": 10,
    },
    {
      "month": "July",
      "avgHigh": 29,
      "avgLow": 21,
      "precipitation": 110,
      "humidity": 66,
      "windSpeed": 11,
      "uvIndex": 9,
      "sunHours": 10,
      "rainyDays": 11,
    },
    {
      "month": "August",
      "avgHigh": 28,
      "avgLow": 20,
      "precipitation": 95,
      "humidity": 65,
      "windSpeed": 10,
      "uvIndex": 8,
      "sunHours": 9,
      "rainyDays": 9,
    },
    {
      "month": "September",
      "avgHigh": 24,
      "avgLow": 16,
      "precipitation": 85,
      "humidity": 62,
      "windSpeed": 12,
      "uvIndex": 6,
      "sunHours": 8,
      "rainyDays": 8,
    },
    {
      "month": "October",
      "avgHigh": 18,
      "avgLow": 10,
      "precipitation": 90,
      "humidity": 61,
      "windSpeed": 13,
      "uvIndex": 4,
      "sunHours": 7,
      "rainyDays": 9,
    },
    {
      "month": "November",
      "avgHigh": 11,
      "avgLow": 4,
      "precipitation": 85,
      "humidity": 63,
      "windSpeed": 14,
      "uvIndex": 3,
      "sunHours": 6,
      "rainyDays": 10,
    },
    {
      "month": "December",
      "avgHigh": 5,
      "avgLow": -1,
      "precipitation": 80,
      "humidity": 64,
      "windSpeed": 15,
      "uvIndex": 2,
      "sunHours": 5,
      "rainyDays": 11,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Averages"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              si("Year filter opened");
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
                    Icons.calendar_view_month,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Monthly Weather Averages - $selectedYear",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Average weather conditions for $selectedLocation by month",
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
              "Temperature Overview",
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "High / Low",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Rain",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...monthlyAverages.map((month) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${month["month"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${month["avgHigh"]}° / ${month["avgLow"]}°",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${month["precipitation"]}mm",
                            style: TextStyle(
                              fontSize: 14,
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
              "Detailed Monthly Data",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...monthlyAverages.map((month) {
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
                    Text(
                      "${month["month"]} $selectedYear",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.thermostat,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Avg High",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["avgHigh"]}°C",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.ac_unit,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Avg Low",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["avgLow"]}°C",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Precipitation",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["precipitation"]}mm",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.opacity,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["humidity"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.air,
                                color: warningColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Wind Speed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["windSpeed"]} km/h",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "UV Index",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["uvIndex"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                color: warningColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Sun Hours",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["sunHours"]}h",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.grain,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Rainy Days",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${month["rainyDays"]} days",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
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
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Monthly averages are calculated from 30+ years of historical weather data to provide reliable climate information.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPrecipitationTrendsView extends StatefulWidget {
  const WcaPrecipitationTrendsView({super.key});

  @override
  State<WcaPrecipitationTrendsView> createState() => _WcaPrecipitationTrendsViewState();
}

class _WcaPrecipitationTrendsViewState extends State<WcaPrecipitationTrendsView> {
  String selectedPeriod = "10 Years";
  String selectedLocation = "New York";
  
  Map<String, dynamic> precipitationTrends = {
    "period": "2014-2024",
    "avgAnnualChange": "+8.5%",
    "trend": "Increasing",
    "wettestYear": 2023,
    "driestYear": 2016,
    "heaviestDayfall": "127mm",
    "longestDrySpell": "28 days",
  };

  List<Map<String, dynamic>> yearlyPrecipitation = [
    {"year": 2014, "total": 1156, "rainyDays": 118, "heaviestDay": 78, "drySpell": 21},
    {"year": 2015, "total": 1203, "rainyDays": 125, "heaviestDay": 89, "drySpell": 19},
    {"year": 2016, "total": 987, "rainyDays": 98, "heaviestDay": 65, "drySpell": 28},
    {"year": 2017, "total": 1145, "rainyDays": 112, "heaviestDay": 92, "drySpell": 23},
    {"year": 2018, "total": 1267, "rainyDays": 134, "heaviestDay": 98, "drySpell": 18},
    {"year": 2019, "total": 1298, "rainyDays": 139, "heaviestDay": 105, "drySpell": 16},
    {"year": 2020, "total": 1189, "rainyDays": 121, "heaviestDay": 83, "drySpell": 22},
    {"year": 2021, "total": 1334, "rainyDays": 142, "heaviestDay": 112, "drySpell": 15},
    {"year": 2022, "total": 1387, "rainyDays": 148, "heaviestDay": 119, "drySpell": 17},
    {"year": 2023, "total": 1445, "rainyDays": 156, "heaviestDay": 127, "drySpell": 14},
    {"year": 2024, "total": 1398, "rainyDays": 151, "heaviestDay": 115, "drySpell": 16},
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "change": "+12%", "trend": "Wetter", "color": infoColor},
    {"month": "Feb", "change": "+8%", "trend": "Wetter", "color": infoColor},
    {"month": "Mar", "change": "+15%", "trend": "Much Wetter", "color": primaryColor},
    {"month": "Apr", "change": "+18%", "trend": "Much Wetter", "color": primaryColor},
    {"month": "May", "change": "+6%", "trend": "Slightly Wetter", "color": successColor},
    {"month": "Jun", "change": "-2%", "trend": "Similar", "color": disabledBoldColor},
    {"month": "Jul", "change": "+22%", "trend": "Much Wetter", "color": primaryColor},
    {"month": "Aug", "change": "+9%", "trend": "Wetter", "color": infoColor},
    {"month": "Sep", "change": "+11%", "trend": "Wetter", "color": infoColor},
    {"month": "Oct", "change": "+4%", "trend": "Slightly Wetter", "color": successColor},
    {"month": "Nov", "change": "+7%", "trend": "Wetter", "color": infoColor},
    {"month": "Dec", "change": "+13%", "trend": "Much Wetter", "color": primaryColor},
  ];

  List<Map<String, dynamic>> precipitationTypes = [
    {
      "type": "Light Rain",
      "range": "0.1-2.5mm",
      "frequency": "78 days/year",
      "trend": "+5%",
      "color": successColor,
      "icon": Icons.grain,
    },
    {
      "type": "Moderate Rain",
      "range": "2.5-10mm",
      "frequency": "52 days/year",
      "trend": "+12%",
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "type": "Heavy Rain",
      "range": "10-50mm",
      "frequency": "18 days/year",
      "trend": "+25%",
      "color": warningColor,
      "icon": Icons.thunderstorm,
    },
    {
      "type": "Very Heavy Rain",
      "range": ">50mm",
      "frequency": "3 days/year",
      "trend": "+67%",
      "color": dangerColor,
      "icon": Icons.flood,
    },
  ];

  List<Map<String, dynamic>> seasonalChanges = [
    {
      "season": "Spring",
      "months": "Mar-May",
      "change": "+13.2%",
      "impact": "Extended wet season, flood risk increased",
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "season": "Summer",
      "months": "Jun-Aug",
      "change": "+9.8%",
      "impact": "More intense thunderstorms and downpours",
      "color": dangerColor,
      "icon": Icons.wb_sunny,
    },
    {
      "season": "Autumn",
      "months": "Sep-Nov",
      "change": "+7.4%",
      "impact": "Longer rainy periods, delayed harvest",
      "color": warningColor,
      "icon": Icons.park,
    },
    {
      "season": "Winter",
      "months": "Dec-Feb",
      "change": "+11.1%",
      "impact": "More rain than snow, ice storm risk",
      "color": infoColor,
      "icon": Icons.ac_unit,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precipitation Trends"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Precipitation data downloaded");
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
                    Icons.water_drop,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Precipitation Trends Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "10-year rainfall patterns and precipitation changes for $selectedLocation",
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
              "Precipitation Summary (${precipitationTrends["period"]})",
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
                        Icons.trending_up,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Annual Change",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${precipitationTrends["avgAnnualChange"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${precipitationTrends["trend"]}",
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
                        Icons.flood,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Wettest Year",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${precipitationTrends["wettestYear"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                        Icons.wb_sunny,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Driest Year",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${precipitationTrends["driestYear"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Lowest Rainfall",
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
                        Icons.thunderstorm,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Heaviest Day",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${precipitationTrends["heaviestDayfall"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Single Day",
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
              "Annual Precipitation Data",
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
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Rainy Days",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Heaviest",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Dry Spell",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  ...yearlyPrecipitation.map((data) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${data["year"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${data["total"]}mm",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${data["rainyDays"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${data["heaviestDay"]}mm",
                            style: TextStyle(
                              fontSize: 11,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${data["drySpell"]} days",
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
              "Monthly Precipitation Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: monthlyTrends.map((month) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${month["month"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${month["change"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: month["color"] as Color,
                        ),
                      ),
                      Text(
                        "${month["trend"]}",
                        textAlign: TextAlign.center,
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
              "Precipitation Types & Intensity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...precipitationTypes.map((type) {
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
                        color: (type["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        type["icon"] as IconData,
                        color: type["color"] as Color,
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
                                "${type["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${type["trend"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: type["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${type["range"]} per day",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Frequency: ${type["frequency"]}",
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

            Text(
              "Seasonal Precipitation Changes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...seasonalChanges.map((season) {
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${season["season"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${season["change"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${season["impact"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

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
                        "Precipitation Trend Insights",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Annual precipitation has increased by ${precipitationTrends["avgAnnualChange"]} over the past decade",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Heavy rainfall events (>10mm/day) are becoming more frequent",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Spring and summer precipitation increases pose flood risks",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "• Longest dry spell recorded: ${precipitationTrends["longestDrySpell"]} in 2016",
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

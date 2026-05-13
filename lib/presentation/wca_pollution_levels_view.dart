import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPollutionLevelsView extends StatefulWidget {
  const WcaPollutionLevelsView({super.key});

  @override
  State<WcaPollutionLevelsView> createState() => _WcaPollutionLevelsViewState();
}

class _WcaPollutionLevelsViewState extends State<WcaPollutionLevelsView> {
  int selectedLocationIndex = 0;
  String selectedTimeRange = "24h";

  List<Map<String, dynamic>> locations = [
    {
      "name": "Downtown",
      "aqi": 85,
      "level": "Moderate",
      "color": warningColor,
      "pm25": 35.2,
      "pm10": 68.1,
      "no2": 42.8,
      "o3": 78.3,
      "co": 1.2,
      "so2": 15.4,
    },
    {
      "name": "Industrial Area",
      "aqi": 156,
      "level": "Unhealthy",
      "color": dangerColor,
      "pm25": 65.8,
      "pm10": 95.3,
      "no2": 58.7,
      "o3": 42.1,
      "co": 2.8,
      "so2": 32.6,
    },
    {
      "name": "Residential",
      "aqi": 42,
      "level": "Good",
      "color": successColor,
      "pm25": 18.3,
      "pm10": 28.9,
      "no2": 25.4,
      "o3": 55.2,
      "co": 0.8,
      "so2": 8.1,
    },
    {
      "name": "Coastal",
      "aqi": 28,
      "level": "Good",
      "color": successColor,
      "pm25": 12.1,
      "pm10": 22.4,
      "no2": 18.6,
      "o3": 48.7,
      "co": 0.5,
      "so2": 5.3,
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"time": "00:00", "aqi": 78, "level": "Moderate"},
    {"time": "01:00", "aqi": 82, "level": "Moderate"},
    {"time": "02:00", "aqi": 75, "level": "Moderate"},
    {"time": "03:00", "aqi": 69, "level": "Moderate"},
    {"time": "04:00", "aqi": 73, "level": "Moderate"},
    {"time": "05:00", "aqi": 85, "level": "Moderate"},
    {"time": "06:00", "aqi": 92, "level": "Moderate"},
    {"time": "07:00", "aqi": 105, "level": "Unhealthy for Sensitive"},
    {"time": "08:00", "aqi": 118, "level": "Unhealthy for Sensitive"},
    {"time": "09:00", "aqi": 125, "level": "Unhealthy for Sensitive"},
    {"time": "10:00", "aqi": 132, "level": "Unhealthy for Sensitive"},
    {"time": "11:00", "aqi": 128, "level": "Unhealthy for Sensitive"},
    {"time": "12:00", "aqi": 135, "level": "Unhealthy for Sensitive"},
    {"time": "13:00", "aqi": 142, "level": "Unhealthy for Sensitive"},
    {"time": "14:00", "aqi": 138, "level": "Unhealthy for Sensitive"},
    {"time": "15:00", "aqi": 145, "level": "Unhealthy for Sensitive"},
    {"time": "16:00", "aqi": 152, "level": "Unhealthy"},
    {"time": "17:00", "aqi": 148, "level": "Unhealthy for Sensitive"},
    {"time": "18:00", "aqi": 155, "level": "Unhealthy"},
    {"time": "19:00", "aqi": 162, "level": "Unhealthy"},
    {"time": "20:00", "aqi": 158, "level": "Unhealthy"},
    {"time": "21:00", "aqi": 148, "level": "Unhealthy for Sensitive"},
    {"time": "22:00", "aqi": 135, "level": "Unhealthy for Sensitive"},
    {"time": "23:00", "aqi": 125, "level": "Unhealthy for Sensitive"},
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "24 Hours", "value": "24h"},
    {"label": "3 Days", "value": "3d"},
    {"label": "7 Days", "value": "7d"},
    {"label": "30 Days", "value": "30d"},
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = locations[selectedLocationIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Air Quality Index"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Location Selector
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select Location",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: List.generate(locations.length, (index) {
                      final location = locations[index];
                      final isSelected = index == selectedLocationIndex;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedLocationIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${location["name"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Current AQI Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "${currentLocation["name"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (currentLocation["color"] as Color).withAlpha(20),
                      border: Border.all(
                        color: currentLocation["color"] as Color,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentLocation["aqi"]}",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: currentLocation["color"] as Color,
                          ),
                        ),
                        Text(
                          "AQI",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${currentLocation["level"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: currentLocation["color"] as Color,
                    ),
                  ),
                  Text(
                    "Last updated: ${DateTime.now().dMMMykkss}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Pollutant Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Pollutant Levels",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      _buildPollutantRow("PM2.5", "${currentLocation["pm25"]}", "µg/m³"),
                      _buildPollutantRow("PM10", "${currentLocation["pm10"]}", "µg/m³"),
                      _buildPollutantRow("NO₂", "${currentLocation["no2"]}", "µg/m³"),
                      _buildPollutantRow("O₃", "${currentLocation["o3"]}", "µg/m³"),
                      _buildPollutantRow("CO", "${currentLocation["co"]}", "mg/m³"),
                      _buildPollutantRow("SO₂", "${currentLocation["so2"]}", "µg/m³"),
                    ],
                  ),
                ],
              ),
            ),

            // Time Range Selector
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Historical Data",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Time Range",
                    items: timeRangeOptions,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Hourly Chart
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "24-Hour Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(hourlyData.length, (index) {
                          final data = hourlyData[index];
                          final aqi = data["aqi"] as int;
                          final height = (aqi / 200.0) * 150;
                          
                          Color barColor = successColor;
                          if (aqi > 150) {
                            barColor = dangerColor;
                          } else if (aqi > 100) {
                            barColor = warningColor;
                          } else if (aqi > 50) {
                            barColor = infoColor;
                          }

                          return Container(
                            width: 40,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "$aqi",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 24,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: barColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Health Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Health Recommendations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildRecommendationItem(
                    Icons.masks,
                    "Wear a mask when outdoors",
                    "Recommended for sensitive individuals",
                  ),
                  _buildRecommendationItem(
                    Icons.home,
                    "Limit outdoor activities",
                    "Especially for children and elderly",
                  ),
                  _buildRecommendationItem(
                    Icons.air,
                    "Use air purifiers indoors",
                    "Keep windows closed during peak hours",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollutantRow(String name, String value, String unit) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaDetailedCurrentView extends StatefulWidget {
  const WcaDetailedCurrentView({super.key});

  @override
  State<WcaDetailedCurrentView> createState() => _WcaDetailedCurrentViewState();
}

class _WcaDetailedCurrentViewState extends State<WcaDetailedCurrentView> {
  bool isRefreshing = false;
  String selectedLocation = "New York, NY";
  
  Map<String, dynamic> currentWeather = {
    "temperature": 24,
    "feels_like": 27,
    "condition": "Partly Cloudy",
    "humidity": 65,
    "pressure": 1013,
    "visibility": 10,
    "uv_index": 6,
    "wind_speed": 15,
    "wind_direction": "NW",
    "dew_point": 18,
    "air_quality": 85,
    "last_updated": "2 minutes ago"
  };

  List<Map<String, dynamic>> hourlyData = [
    {"time": "12:00", "temp": 24, "condition": "sunny", "humidity": 65},
    {"time": "13:00", "temp": 26, "condition": "partly_cloudy", "humidity": 62},
    {"time": "14:00", "temp": 28, "condition": "cloudy", "humidity": 58},
    {"time": "15:00", "temp": 27, "condition": "partly_cloudy", "humidity": 60},
    {"time": "16:00", "temp": 25, "condition": "sunny", "humidity": 63},
  ];

  List<Map<String, dynamic>> weatherMetrics = [
    {"title": "Pressure", "value": "1013 hPa", "trend": "stable", "icon": Icons.speed},
    {"title": "Visibility", "value": "10 km", "trend": "good", "icon": Icons.visibility},
    {"title": "Dew Point", "value": "18°C", "trend": "moderate", "icon": Icons.water_drop},
    {"title": "Air Quality", "value": "Good (85)", "trend": "good", "icon": Icons.air},
  ];

  void _refreshWeather() async {
    isRefreshing = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    isRefreshing = false;
    setState(() {});
    ss("Weather data updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Weather"),
        actions: [
          IconButton(
            icon: Icon(isRefreshing ? Icons.hourglass_empty : Icons.refresh),
            onPressed: isRefreshing ? null : _refreshWeather,
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              si("Location selector");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Location and Time
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedLocation,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Last updated: ${currentWeather["last_updated"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Live",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Weather Info
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, secondaryColor],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentWeather["temperature"]}°C",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Feels like ${currentWeather["feels_like"]}°C",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            size: 64,
                            color: Colors.yellow.shade200,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${currentWeather["condition"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickStat("Humidity", "${currentWeather["humidity"]}%", Icons.water_drop),
                      _buildQuickStat("Wind", "${currentWeather["wind_speed"]} km/h", Icons.air),
                      _buildQuickStat("UV Index", "${currentWeather["uv_index"]}", Icons.wb_sunny),
                    ],
                  ),
                ],
              ),
            ),

            // Hourly Forecast
            Text(
              "Hourly Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: hourlyData.map((hour) {
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "${hour["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        _getWeatherIcon("${hour["condition"]}"),
                        color: primaryColor,
                        size: 24,
                      ),
                      Text(
                        "${hour["temp"]}°",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${hour["humidity"]}%",
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

            // Detailed Metrics
            Text(
              "Weather Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 150,
              children: weatherMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            metric["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTrendColor("${metric["trend"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["trend"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getTrendColor("${metric["trend"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Sun & Moon Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Sun & Moon",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.wb_sunny, color: Colors.orange, size: 20),
                            SizedBox(width: spXs),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sunrise",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "06:45 AM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.nights_stay, color: Colors.indigo, size: 20),
                            SizedBox(width: spXs),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sunset",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "07:30 PM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Refresh Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isRefreshing ? "Refreshing..." : "Refresh Weather Data",
                icon: isRefreshing ? Icons.hourglass_empty : Icons.refresh,
                size: bs.md,
                onPressed: isRefreshing ? null : _refreshWeather,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case "sunny":
        return Icons.wb_sunny;
      case "partly_cloudy":
        return Icons.wb_cloudy;
      case "cloudy":
        return Icons.cloud;
      case "rainy":
        return Icons.grain;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "good":
        return successColor;
      case "stable":
        return infoColor;
      case "moderate":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}

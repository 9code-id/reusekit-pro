import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWeatherDashboardView extends StatefulWidget {
  const AmaWeatherDashboardView({super.key});

  @override
  State<AmaWeatherDashboardView> createState() => _AmaWeatherDashboardViewState();
}

class _AmaWeatherDashboardViewState extends State<AmaWeatherDashboardView> {
  Map<String, dynamic> currentWeather = {
    "temperature": 78,
    "humidity": 65,
    "windSpeed": 12,
    "windDirection": "NW",
    "pressure": 30.15,
    "uvIndex": 6,
    "visibility": 10,
    "dewPoint": 62,
    "condition": "Partly Cloudy",
    "icon": "partly_cloudy",
    "lastUpdated": "2024-06-15 14:30",
    "feelsLike": 82,
    "cloudCover": 40,
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "15:00", "temp": 79, "condition": "Sunny", "humidity": 62, "windSpeed": 10, "precipitation": 0},
    {"time": "16:00", "temp": 81, "condition": "Sunny", "humidity": 60, "windSpeed": 8, "precipitation": 0},
    {"time": "17:00", "temp": 80, "condition": "Partly Cloudy", "humidity": 63, "windSpeed": 9, "precipitation": 5},
    {"time": "18:00", "temp": 77, "condition": "Partly Cloudy", "humidity": 68, "windSpeed": 11, "precipitation": 10},
    {"time": "19:00", "temp": 75, "condition": "Cloudy", "humidity": 72, "windSpeed": 13, "precipitation": 20},
    {"time": "20:00", "temp": 73, "condition": "Light Rain", "humidity": 78, "windSpeed": 15, "precipitation": 40},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Today", "high": 82, "low": 65, "condition": "Partly Cloudy", "precipitation": 20, "humidity": 65},
    {"day": "Tomorrow", "high": 85, "low": 68, "condition": "Sunny", "precipitation": 5, "humidity": 58},
    {"day": "Monday", "high": 83, "low": 66, "condition": "Partly Cloudy", "precipitation": 15, "humidity": 62},
    {"day": "Tuesday", "high": 79, "low": 63, "condition": "Rainy", "precipitation": 75, "humidity": 82},
    {"day": "Wednesday", "high": 76, "low": 60, "condition": "Cloudy", "precipitation": 35, "humidity": 75},
    {"day": "Thursday", "high": 81, "low": 64, "condition": "Sunny", "precipitation": 10, "humidity": 60},
    {"day": "Friday", "high": 84, "low": 67, "condition": "Partly Cloudy", "precipitation": 25, "humidity": 64},
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "Frost Warning",
      "severity": "High",
      "message": "Frost expected tonight. Protect sensitive crops.",
      "startTime": "2024-06-16 02:00",
      "endTime": "2024-06-16 08:00",
      "isActive": true,
    },
    {
      "type": "Heavy Rain",
      "severity": "Medium",
      "message": "Heavy rainfall expected Tuesday. Prepare drainage.",
      "startTime": "2024-06-18 14:00",
      "endTime": "2024-06-19 06:00",
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> farmingConditions = [
    {
      "activity": "Planting",
      "status": "Good",
      "description": "Soil moisture and temperature ideal for planting",
      "recommendation": "Proceed with planned planting activities",
      "icon": Icons.eco,
      "color": "good",
    },
    {
      "activity": "Spraying",
      "status": "Poor",
      "description": "High wind speeds not suitable for spraying",
      "recommendation": "Wait for calmer conditions tomorrow",
      "icon": Icons.agriculture,
      "color": "poor",
    },
    {
      "activity": "Harvesting",
      "status": "Excellent",
      "description": "Perfect conditions for harvesting operations",
      "recommendation": "Optimal time for harvest activities",
      "icon": Icons.grass,
      "color": "excellent",
    },
    {
      "activity": "Irrigation",
      "status": "Fair",
      "description": "Moderate humidity, check soil moisture levels",
      "recommendation": "Monitor fields, may need irrigation by evening",
      "icon": Icons.water_drop,
      "color": "fair",
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // navigateTo('weather-locations')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('weather-settings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Farm Location • Greenfield Valley",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentWeather["lastUpdated"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentWeather["temperature"]}°F",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${currentWeather["condition"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Feels like ${currentWeather["feelsLike"]}°F",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Weather Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildWeatherMetric("Humidity", "${currentWeather["humidity"]}%", Icons.opacity, infoColor),
                _buildWeatherMetric("Wind", "${currentWeather["windSpeed"]} mph ${currentWeather["windDirection"]}", Icons.air, warningColor),
                _buildWeatherMetric("UV Index", "${currentWeather["uvIndex"]}", Icons.wb_sunny, dangerColor),
                _buildWeatherMetric("Pressure", "${currentWeather["pressure"]} in", Icons.speed, successColor),
              ],
            ),

            SizedBox(height: spLg),

            // Weather Alerts
            if (weatherAlerts.any((alert) => alert["isActive"])) ...[
              Text(
                "Weather Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              ...weatherAlerts.where((alert) => alert["isActive"]).map((alert) {
                Color alertColor = dangerColor;
                if ("${alert["severity"]}" == "Medium") alertColor = warningColor;
                if ("${alert["severity"]}" == "Low") alertColor = infoColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: alertColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: alertColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: alertColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${alert["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: alertColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${alert["message"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: alertColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),
            ],

            // Farming Conditions
            Text(
              "Farming Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: farmingConditions.map((condition) {
                Color statusColor = successColor;
                if ("${condition["color"]}" == "poor") statusColor = dangerColor;
                if ("${condition["color"]}" == "fair") statusColor = warningColor;
                if ("${condition["color"]}" == "excellent") statusColor = primaryColor;

                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              condition["icon"] as IconData,
                              size: 20,
                              color: statusColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${condition["activity"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${condition["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${condition["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${condition["recommendation"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Hourly Forecast
            Text(
              "24-Hour Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            QHorizontalScroll(
              children: hourlyForecast.map((hour) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${hour["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Icon(
                        _getWeatherIcon("${hour["condition"]}"),
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${hour["temp"]}°",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${hour["precipitation"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Weekly Forecast
            Text(
              "7-Day Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: weeklyForecast.map((day) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Icon(
                          _getWeatherIcon("${day["condition"]}"),
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${day["condition"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${day["precipitation"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${day["high"]}°/${day["low"]}°",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'partly cloudy':
        return Icons.wb_cloudy;
      case 'cloudy':
        return Icons.cloud;
      case 'rainy':
      case 'light rain':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }
}

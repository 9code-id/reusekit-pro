import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaWeatherView extends StatefulWidget {
  const NmaWeatherView({super.key});

  @override
  State<NmaWeatherView> createState() => _NmaWeatherViewState();
}

class _NmaWeatherViewState extends State<NmaWeatherView> {
  String selectedLocation = "current";
  bool celsius = true;
  bool isLoading = false;

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Current Location", "value": "current"},
    {"label": "New York, NY", "value": "newyork"},
    {"label": "Los Angeles, CA", "value": "losangeles"},
    {"label": "Chicago, IL", "value": "chicago"},
    {"label": "Houston, TX", "value": "houston"},
    {"label": "Miami, FL", "value": "miami"},
  ];

  Map<String, dynamic> currentWeather = {
    "location": "New York, NY",
    "temperature": 24,
    "condition": "Partly Cloudy",
    "icon": "⛅",
    "humidity": 65,
    "windSpeed": 12,
    "windDirection": "NW",
    "pressure": 1013,
    "visibility": 16,
    "uvIndex": 6,
    "feelsLike": 27,
    "lastUpdated": "2025-06-16T15:30:00Z",
    "sunrise": "05:25",
    "sunset": "20:15",
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "15:00", "temp": 24, "condition": "⛅", "precipitation": 10},
    {"time": "16:00", "temp": 26, "condition": "☀️", "precipitation": 5},
    {"time": "17:00", "temp": 25, "condition": "☀️", "precipitation": 0},
    {"time": "18:00", "temp": 23, "condition": "🌤️", "precipitation": 15},
    {"time": "19:00", "temp": 21, "condition": "🌧️", "precipitation": 70},
    {"time": "20:00", "temp": 19, "condition": "🌧️", "precipitation": 85},
    {"time": "21:00", "temp": 18, "condition": "🌧️", "precipitation": 60},
    {"time": "22:00", "temp": 17, "condition": "🌤️", "precipitation": 20},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {
      "day": "Today",
      "date": "Jun 16",
      "high": 26,
      "low": 18,
      "condition": "Partly Cloudy",
      "icon": "⛅",
      "precipitation": 40,
      "humidity": 65,
    },
    {
      "day": "Tomorrow",
      "date": "Jun 17",
      "high": 28,
      "low": 20,
      "condition": "Sunny",
      "icon": "☀️",
      "precipitation": 10,
      "humidity": 55,
    },
    {
      "day": "Wednesday",
      "date": "Jun 18",
      "high": 23,
      "low": 16,
      "condition": "Rainy",
      "icon": "🌧️",
      "precipitation": 80,
      "humidity": 85,
    },
    {
      "day": "Thursday",
      "date": "Jun 19",
      "high": 25,
      "low": 17,
      "condition": "Cloudy",
      "icon": "☁️",
      "precipitation": 30,
      "humidity": 70,
    },
    {
      "day": "Friday",
      "date": "Jun 20",
      "high": 27,
      "low": 19,
      "condition": "Partly Cloudy",
      "icon": "⛅",
      "precipitation": 20,
      "humidity": 60,
    },
    {
      "day": "Saturday",
      "date": "Jun 21",
      "high": 29,
      "low": 21,
      "condition": "Sunny",
      "icon": "☀️",
      "precipitation": 5,
      "humidity": 50,
    },
    {
      "day": "Sunday",
      "date": "Jun 22",
      "high": 31,
      "low": 23,
      "condition": "Hot",
      "icon": "🌤️",
      "precipitation": 0,
      "humidity": 45,
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "id": 1,
      "type": "warning",
      "title": "Thunderstorm Warning",
      "description": "Severe thunderstorms expected this evening with heavy rain and strong winds.",
      "severity": "high",
      "startTime": "2025-06-16T18:00:00Z",
      "endTime": "2025-06-16T23:00:00Z",
    },
    {
      "id": 2,
      "type": "advisory",
      "title": "High UV Index",
      "description": "UV index will reach dangerous levels tomorrow. Take sun protection measures.",
      "severity": "medium",
      "startTime": "2025-06-17T10:00:00Z",
      "endTime": "2025-06-17T16:00:00Z",
    },
  ];

  int convertTemp(int temp) {
    return celsius ? temp : ((temp * 9 / 5) + 32).round();
  }

  String getTempUnit() {
    return celsius ? "°C" : "°F";
  }

  Color getUVIndexColor(int uvIndex) {
    if (uvIndex <= 2) return successColor;
    if (uvIndex <= 5) return warningColor;
    if (uvIndex <= 7) return infoColor;
    if (uvIndex <= 10) return dangerColor;
    return Colors.purple;
  }

  String getUVIndexLevel(int uvIndex) {
    if (uvIndex <= 2) return "Low";
    if (uvIndex <= 5) return "Moderate";
    if (uvIndex <= 7) return "High";
    if (uvIndex <= 10) return "Very High";
    return "Extreme";
  }

  Widget _buildCurrentWeatherCard() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "${currentWeather["location"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "Updated ${DateTime.parse(currentWeather["lastUpdated"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "${currentWeather["icon"]}",
                  style: TextStyle(fontSize: 64),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${convertTemp(currentWeather["temperature"])}${getTempUnit()}",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${currentWeather["condition"]}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "Feels like ${convertTemp(currentWeather["feelsLike"])}${getTempUnit()}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentWeather["humidity"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Humidity",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentWeather["windSpeed"]} km/h",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Wind ${currentWeather["windDirection"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.compress,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentWeather["pressure"]} hPa",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pressure",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "UV ${currentWeather["uvIndex"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${getUVIndexLevel(currentWeather["uvIndex"])}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sunrise ${currentWeather["sunrise"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.brightness_3,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sunset ${currentWeather["sunset"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Hourly Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          QHorizontalScroll(
            children: hourlyForecast.map((hour) {
              return Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Text(
                      "${hour["condition"]}",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${convertTemp(hour["temp"])}${getTempUnit()}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 12,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${hour["precipitation"]}%",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildDailyForecast() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "7-Day Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...dailyForecast.map((day) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${day["day"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${day["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${day["icon"]}",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${day["condition"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop,
                        size: 14,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${day["precipitation"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${convertTemp(day["low"])}°/${convertTemp(day["high"])}°",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildWeatherAlerts() {
    if (weatherAlerts.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...weatherAlerts.map((alert) {
            Color alertColor = alert["severity"] == "high" ? dangerColor : 
                             alert["severity"] == "medium" ? warningColor : infoColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: alertColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: alertColor.withAlpha(50)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    alert["type"] == "warning" ? Icons.warning : Icons.info,
                    color: alertColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${alert["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: alertColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["description"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: alertColor.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${DateTime.parse(alert["startTime"]).dMMMy} - ${DateTime.parse(alert["endTime"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: alertColor.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Detailed Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${currentWeather["visibility"]} km",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Visibility",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: getUVIndexColor(currentWeather["uvIndex"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: getUVIndexColor(currentWeather["uvIndex"]),
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${currentWeather["uvIndex"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: getUVIndexColor(currentWeather["uvIndex"]),
                      ),
                    ),
                    Text(
                      "${getUVIndexLevel(currentWeather["uvIndex"])} UV",
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
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          GestureDetector(
            onTap: () {
              celsius = !celsius;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                celsius ? "°C" : "°F",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isLoading = true;
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          isLoading = false;
          setState(() {});
          ss("Weather data refreshed");
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QDropdownField(
                label: "Location",
                items: locationOptions,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                  ss("Location changed to $label");
                },
              ),
              SizedBox(height: spMd),
              if (isLoading)
                Container(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else ...[
                _buildWeatherAlerts(),
                _buildCurrentWeatherCard(),
                _buildHourlyForecast(),
                _buildDailyForecast(),
                _buildDetailedMetrics(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

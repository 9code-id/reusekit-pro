import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaLocationDetailsView extends StatefulWidget {
  const WcaLocationDetailsView({super.key});

  @override
  State<WcaLocationDetailsView> createState() => _WcaLocationDetailsViewState();
}

class _WcaLocationDetailsViewState extends State<WcaLocationDetailsView> {
  int selectedTab = 0;
  bool isFavorite = true;
  bool enableAlerts = true;

  Map<String, dynamic> locationDetails = {
    "name": "New York",
    "fullName": "New York, New York, United States",
    "type": "City",
    "country": "United States",
    "state": "New York",
    "latitude": 40.7128,
    "longitude": -74.0060,
    "elevation": 10,
    "population": 8398748,
    "timezone": "UTC-5",
    "area": 783.8,
    "density": 10725,
    "founded": "1624",
    "language": "English",
    "currency": "USD",
    "isCapital": false,
    "timeZoneOffset": -5,
  };

  Map<String, dynamic> currentWeather = {
    "temperature": 22,
    "condition": "Sunny",
    "description": "Clear sky with bright sunshine",
    "humidity": 65,
    "windSpeed": 8,
    "windDirection": "NW",
    "pressure": 1013,
    "visibility": 16,
    "uvIndex": 7,
    "dewPoint": 15,
    "feelsLike": 24,
    "cloudCover": 10,
    "sunrise": "06:24",
    "sunset": "19:47",
    "moonPhase": "Waxing Crescent",
    "airQuality": "Good",
    "lastUpdated": "2025-06-16T14:30:00Z",
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "15:00", "temp": 23, "condition": "Sunny", "icon": "sunny"},
    {"time": "16:00", "temp": 24, "condition": "Sunny", "icon": "sunny"},
    {"time": "17:00", "temp": 23, "condition": "Partly Cloudy", "icon": "partly_cloudy"},
    {"time": "18:00", "temp": 22, "condition": "Partly Cloudy", "icon": "partly_cloudy"},
    {"time": "19:00", "temp": 20, "condition": "Cloudy", "icon": "cloudy"},
    {"time": "20:00", "temp": 19, "condition": "Cloudy", "icon": "cloudy"},
    {"time": "21:00", "temp": 18, "condition": "Clear", "icon": "clear"},
    {"time": "22:00", "temp": 17, "condition": "Clear", "icon": "clear"},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {
      "date": "Today",
      "day": "Monday",
      "high": 24,
      "low": 16,
      "condition": "Sunny",
      "icon": "sunny",
      "precipitation": 0,
      "humidity": 65,
      "wind": 8,
    },
    {
      "date": "Tomorrow",
      "day": "Tuesday",
      "high": 26,
      "low": 18,
      "condition": "Partly Cloudy",
      "icon": "partly_cloudy",
      "precipitation": 10,
      "humidity": 70,
      "wind": 12,
    },
    {
      "date": "Jun 18",
      "day": "Wednesday",
      "high": 23,
      "low": 15,
      "condition": "Rainy",
      "icon": "rainy",
      "precipitation": 80,
      "humidity": 85,
      "wind": 15,
    },
    {
      "date": "Jun 19",
      "day": "Thursday",
      "high": 21,
      "low": 14,
      "condition": "Thunderstorm",
      "icon": "storm",
      "precipitation": 90,
      "humidity": 88,
      "wind": 20,
    },
    {
      "date": "Jun 20",
      "day": "Friday",
      "high": 25,
      "low": 17,
      "condition": "Sunny",
      "icon": "sunny",
      "precipitation": 5,
      "humidity": 60,
      "wind": 10,
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "UV Warning",
      "level": "High",
      "description": "UV index will reach dangerous levels between 11 AM and 4 PM",
      "severity": "moderate",
      "startTime": "11:00",
      "endTime": "16:00",
      "actions": ["Wear sunscreen", "Limit outdoor activities", "Seek shade"],
    },
    {
      "type": "Air Quality",
      "level": "Moderate",
      "description": "Air quality is acceptable for most people",
      "severity": "low",
      "startTime": "All day",
      "endTime": "All day",
      "actions": ["Monitor symptoms if sensitive"],
    },
  ];

  Map<String, dynamic> historicalData = {
    "averageTemp": {
      "june": 21,
      "annual": 13,
      "summer": 24,
      "winter": 2,
    },
    "precipitation": {
      "june": 112,
      "annual": 1268,
      "wettest": "July",
      "driest": "February",
    },
    "extremes": {
      "highestTemp": 42,
      "lowestTemp": -26,
      "highestDate": "July 9, 1936",
      "lowestDate": "February 9, 1934",
    },
  };

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    setState(() {});
    if (isFavorite) {
      ss("Added to favorites");
    } else {
      ss("Removed from favorites");
    }
  }

  void _shareLocation() {
    ss("Location details shared");
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Icons.wb_sunny;
      case "partly cloudy":
        return Icons.wb_cloudy;
      case "cloudy":
        return Icons.cloud;
      case "rainy":
        return Icons.grain;
      case "thunderstorm":
      case "storm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getWeatherColor(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return warningColor;
      case "partly cloudy":
        return infoColor;
      case "cloudy":
        return disabledBoldColor;
      case "rainy":
        return primaryColor;
      case "thunderstorm":
      case "storm":
        return dangerColor;
      case "snow":
        return Colors.lightBlue;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertColor(String severity) {
    switch (severity.toLowerCase()) {
      case "high":
      case "severe":
        return dangerColor;
      case "moderate":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${locationDetails["name"]}"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareLocation,
          ),
        ],
      ),
      body: QTabBar(
        selectedIndex: selectedTab,
        withoutAppBar: true,
        tabs: [
          Tab(text: "Overview", icon: Icon(Icons.info)),
          Tab(text: "Forecast", icon: Icon(Icons.schedule)),
          Tab(text: "Alerts", icon: Icon(Icons.warning)),
          Tab(text: "Historical", icon: Icon(Icons.history)),
        ],
        tabChildren: [
          _buildOverviewTab(),
          _buildForecastTab(),
          _buildAlertsTab(),
          _buildHistoricalTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Location Info
          Container(
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
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Location Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${locationDetails["fullName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem("Type", "${locationDetails["type"]}"),
                    ),
                    Expanded(
                      child: _buildInfoItem("Population", "${((locationDetails["population"] as int) / 1000000).toStringAsFixed(1)}M"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem("Coordinates", "${locationDetails["latitude"]}, ${locationDetails["longitude"]}"),
                    ),
                    Expanded(
                      child: _buildInfoItem("Elevation", "${locationDetails["elevation"]}m"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem("Timezone", "${locationDetails["timezone"]}"),
                    ),
                    Expanded(
                      child: _buildInfoItem("Founded", "${locationDetails["founded"]}"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Current Weather
          Container(
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
                    Icon(_getWeatherIcon("${currentWeather["condition"]}"), 
                         color: _getWeatherColor("${currentWeather["condition"]}")),
                    SizedBox(width: spSm),
                    Text(
                      "Current Weather",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Updated: ${currentWeather["lastUpdated"]}".split('T')[1].split('.')[0],
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${currentWeather["temperature"]}°C",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _getWeatherColor("${currentWeather["condition"]}"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentWeather["condition"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${currentWeather["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildWeatherDetail("Feels like", "${currentWeather["feelsLike"]}°C", Icons.device_thermostat),
                    ),
                    Expanded(
                      child: _buildWeatherDetail("Humidity", "${currentWeather["humidity"]}%", Icons.water_drop),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildWeatherDetail("Wind", "${currentWeather["windSpeed"]} km/h ${currentWeather["windDirection"]}", Icons.air),
                    ),
                    Expanded(
                      child: _buildWeatherDetail("Pressure", "${currentWeather["pressure"]} mb", Icons.speed),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildWeatherDetail("Visibility", "${currentWeather["visibility"]} km", Icons.visibility),
                    ),
                    Expanded(
                      child: _buildWeatherDetail("UV Index", "${currentWeather["uvIndex"]}", Icons.wb_sunny),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Sun & Moon
          Container(
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
                    Icon(Icons.brightness_6, color: warningColor),
                    SizedBox(width: spSm),
                    Text(
                      "Sun & Moon",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildWeatherDetail("Sunrise", "${currentWeather["sunrise"]}", Icons.wb_sunny),
                    ),
                    Expanded(
                      child: _buildWeatherDetail("Sunset", "${currentWeather["sunset"]}", Icons.brightness_3),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildWeatherDetail("Moon Phase", "${currentWeather["moonPhase"]}", Icons.nightlight),
                    ),
                    Expanded(
                      child: _buildWeatherDetail("Air Quality", "${currentWeather["airQuality"]}", Icons.air),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Hourly Forecast
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.schedule, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: hourlyForecast.map((hour) {
                    return Container(
                      width: 80,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
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
                          SizedBox(height: spXs),
                          Icon(
                            _getWeatherIcon("${hour["condition"]}"),
                            color: _getWeatherColor("${hour["condition"]}"),
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${hour["temp"]}°",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // 5-Day Forecast
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.calendar_today, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "5-Day Forecast",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...dailyForecast.map((day) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${day["date"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          _getWeatherIcon("${day["condition"]}"),
                          color: _getWeatherColor("${day["condition"]}"),
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${day["condition"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${day["high"]}°/${day["low"]}°",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Alert Settings
          Container(
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
                    Icon(Icons.settings, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Alert Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable Weather Alerts",
                      "value": true,
                      "checked": enableAlerts,
                    }
                  ],
                  value: [
                    if (enableAlerts)
                      {
                        "label": "Enable Weather Alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableAlerts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Active Alerts
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.warning, color: warningColor),
                    SizedBox(width: spSm),
                    Text(
                      "Active Alerts (${weatherAlerts.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (weatherAlerts.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 48,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No Active Alerts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Weather conditions are normal",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...weatherAlerts.map((alert) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getAlertColor("${alert["severity"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getAlertColor("${alert["severity"]}").withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: _getAlertColor("${alert["severity"]}"),
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${alert["type"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getAlertColor("${alert["severity"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${alert["level"]}",
                                  style: TextStyle(
                                    color: _getAlertColor("${alert["severity"]}"),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${alert["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${alert["startTime"]} - ${alert["endTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ((alert["actions"] as List).isNotEmpty) ...[
                            Text(
                              "Recommended Actions:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            ...(alert["actions"] as List).map((action) {
                              return Row(
                                children: [
                                  Text("• ", style: TextStyle(color: disabledBoldColor)),
                                  Text(
                                    "$action",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoricalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Temperature Averages
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.device_thermostat, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Temperature Averages",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoricalCard(
                        "June Average",
                        "${historicalData["averageTemp"]["june"]}°C",
                        Icons.calendar_today,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildHistoricalCard(
                        "Annual Average",
                        "${historicalData["averageTemp"]["annual"]}°C",
                        Icons.public,
                        infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoricalCard(
                        "Summer Average",
                        "${historicalData["averageTemp"]["summer"]}°C",
                        Icons.wb_sunny,
                        warningColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildHistoricalCard(
                        "Winter Average",
                        "${historicalData["averageTemp"]["winter"]}°C",
                        Icons.ac_unit,
                        Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Precipitation Data
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.grain, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Precipitation Data",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoricalCard(
                        "June Average",
                        "${historicalData["precipitation"]["june"]}mm",
                        Icons.calendar_today,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildHistoricalCard(
                        "Annual Total",
                        "${historicalData["precipitation"]["annual"]}mm",
                        Icons.public,
                        infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildHistoricalCard(
                        "Wettest Month",
                        "${historicalData["precipitation"]["wettest"]}",
                        Icons.water_drop,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildHistoricalCard(
                        "Driest Month",
                        "${historicalData["precipitation"]["driest"]}",
                        Icons.wb_sunny,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Temperature Extremes
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.thermostat, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Temperature Records",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.keyboard_arrow_up, color: dangerColor),
                          SizedBox(width: spSm),
                          Text(
                            "Highest Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${historicalData["extremes"]["highestTemp"]}°C",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${historicalData["extremes"]["highestDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: Colors.lightBlue.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.keyboard_arrow_down, color: Colors.lightBlue),
                          SizedBox(width: spSm),
                          Text(
                            "Lowest Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${historicalData["extremes"]["lowestTemp"]}°C",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        "${historicalData["extremes"]["lowestDate"]}",
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoricalCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}

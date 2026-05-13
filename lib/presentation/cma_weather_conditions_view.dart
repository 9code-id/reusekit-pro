import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaWeatherConditionsView extends StatefulWidget {
  const CmaWeatherConditionsView({super.key});

  @override
  State<CmaWeatherConditionsView> createState() => _CmaWeatherConditionsViewState();
}

class _CmaWeatherConditionsViewState extends State<CmaWeatherConditionsView> {
  Map<String, dynamic> currentWeather = {
    "location": "San Francisco, CA",
    "temperature": 18,
    "condition": "Partly Cloudy",
    "description": "Light clouds with good visibility",
    "humidity": 72,
    "windSpeed": 8.5,
    "windDirection": "NW",
    "visibility": 10.2,
    "pressure": 1013.2,
    "uvIndex": 4,
    "feelsLike": 16,
    "icon": "partly_cloudy",
    "lastUpdated": "2024-12-19T09:00:00Z",
    "drivingConditions": "Good",
    "roadWarning": "Watch for fog patches in low areas"
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {
      "time": "10:00",
      "temperature": 19,
      "condition": "Partly Cloudy",
      "icon": "partly_cloudy",
      "precipitation": 0,
      "windSpeed": 9.2,
      "drivingCondition": "Good"
    },
    {
      "time": "11:00",
      "temperature": 21,
      "condition": "Sunny",
      "icon": "sunny",
      "precipitation": 0,
      "windSpeed": 7.8,
      "drivingCondition": "Excellent"
    },
    {
      "time": "12:00",
      "temperature": 23,
      "condition": "Sunny",
      "icon": "sunny",
      "precipitation": 0,
      "windSpeed": 6.5,
      "drivingCondition": "Excellent"
    },
    {
      "time": "13:00",
      "temperature": 24,
      "condition": "Partly Cloudy",
      "icon": "partly_cloudy",
      "precipitation": 5,
      "windSpeed": 8.1,
      "drivingCondition": "Good"
    },
    {
      "time": "14:00",
      "temperature": 22,
      "condition": "Light Rain",
      "icon": "rain",
      "precipitation": 25,
      "windSpeed": 12.3,
      "drivingCondition": "Caution"
    },
    {
      "time": "15:00",
      "temperature": 20,
      "condition": "Rain",
      "icon": "rain",
      "precipitation": 60,
      "windSpeed": 15.7,
      "drivingCondition": "Poor"
    }
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {
      "day": "Today",
      "date": "Dec 19",
      "highTemp": 24,
      "lowTemp": 15,
      "condition": "Partly Cloudy",
      "icon": "partly_cloudy",
      "precipitation": 20,
      "drivingRating": "Good"
    },
    {
      "day": "Tomorrow",
      "date": "Dec 20",
      "highTemp": 26,
      "lowTemp": 17,
      "condition": "Sunny",
      "icon": "sunny",
      "precipitation": 0,
      "drivingRating": "Excellent"
    },
    {
      "day": "Saturday",
      "date": "Dec 21",
      "highTemp": 22,
      "lowTemp": 14,
      "condition": "Cloudy",
      "icon": "cloudy",
      "precipitation": 10,
      "drivingRating": "Good"
    },
    {
      "day": "Sunday",
      "date": "Dec 22",
      "highTemp": 19,
      "lowTemp": 12,
      "condition": "Rain",
      "icon": "rain",
      "precipitation": 80,
      "drivingRating": "Poor"
    },
    {
      "day": "Monday",
      "date": "Dec 23",
      "highTemp": 21,
      "lowTemp": 13,
      "condition": "Light Rain",
      "icon": "light_rain",
      "precipitation": 40,
      "drivingRating": "Caution"
    }
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "id": "WA001",
      "title": "Dense Fog Advisory",
      "description": "Dense fog expected during morning hours. Visibility may be reduced to less than 0.25 miles.",
      "severity": "Medium",
      "startTime": "2024-12-20T05:00:00Z",
      "endTime": "2024-12-20T09:00:00Z",
      "affectedAreas": ["Golden Gate Bridge", "Bay Bridge", "Highway 1"],
      "drivingImpact": "Severe visibility reduction. Use fog lights and drive slowly."
    },
    {
      "id": "WA002",
      "title": "High Wind Warning",
      "description": "Strong winds expected this afternoon. Gusts up to 45 mph possible.",
      "severity": "High",
      "startTime": "2024-12-19T14:00:00Z",
      "endTime": "2024-12-19T20:00:00Z",
      "affectedAreas": ["Bay Area Bridges", "Highway 101", "Coastal Routes"],
      "drivingImpact": "Difficult driving conditions for high-profile vehicles. Secure loose items."
    }
  ];

  Color _getDrivingConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'caution':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getWeatherIcon(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'partly_cloudy':
        return Icons.wb_cloudy;
      case 'cloudy':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'light_rain':
        return Icons.grain;
      case 'snow':
        return Icons.ac_unit;
      case 'fog':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Weather data refreshed");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Weather
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
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${currentWeather["location"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last updated: ${DateTime.parse("${currentWeather["lastUpdated"]}").dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  _getWeatherIcon("${currentWeather["icon"]}"),
                                  color: warningColor,
                                  size: 64,
                                ),
                                SizedBox(width: spMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${currentWeather["temperature"]}°C",
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Feels like ${currentWeather["feelsLike"]}°C",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${currentWeather["condition"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentWeather["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getDrivingConditionColor("${currentWeather["drivingConditions"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.drive_eta,
                                color: _getDrivingConditionColor("${currentWeather["drivingConditions"]}"),
                                size: 32,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Driving",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentWeather["drivingConditions"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getDrivingConditionColor("${currentWeather["drivingConditions"]}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (currentWeather["roadWarning"] != null) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${currentWeather["roadWarning"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],
                ],
              ),
            ),

            // Weather Details
            Container(
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
                    "Weather Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildWeatherDetail(
                          "Humidity",
                          "${currentWeather["humidity"]}%",
                          Icons.water_drop,
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildWeatherDetail(
                          "Wind",
                          "${(currentWeather["windSpeed"] as double).toStringAsFixed(1)} km/h ${currentWeather["windDirection"]}",
                          Icons.air,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildWeatherDetail(
                          "Visibility",
                          "${(currentWeather["visibility"] as double).toStringAsFixed(1)} km",
                          Icons.visibility,
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildWeatherDetail(
                          "UV Index",
                          "${currentWeather["uvIndex"]}/10",
                          Icons.wb_sunny,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hourly Forecast
            Container(
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
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: hourlyForecast.map((forecast) {
                        return Container(
                          width: 80,
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${forecast["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Icon(
                                _getWeatherIcon("${forecast["icon"]}"),
                                color: warningColor,
                                size: 24,
                              ),
                              Text(
                                "${forecast["temperature"]}°",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDrivingConditionColor("${forecast["drivingCondition"]}").withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${forecast["drivingCondition"]}",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: _getDrivingConditionColor("${forecast["drivingCondition"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: spMd),
                ],
              ),
            ),

            // Weather Alerts
            if (weatherAlerts.isNotEmpty) ...[
              Container(
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Weather Alerts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: weatherAlerts.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: disabledOutlineBorderColor,
                      ),
                      itemBuilder: (context, index) {
                        final alert = weatherAlerts[index];
                        final severityColor = _getSeverityColor("${alert["severity"]}");
                        final startTime = DateTime.parse("${alert["startTime"]}");
                        final endTime = DateTime.parse("${alert["endTime"]}");
                        
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${alert["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: severityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${alert["severity"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: severityColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${alert["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${startTime.dMMMy} - ${endTime.dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                                  border: Border.all(color: dangerColor.withAlpha(50)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.drive_eta,
                                          color: dangerColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Driving Impact",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${alert["drivingImpact"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (alert["affectedAreas"] as List).map<Widget>((area) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "$area",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Weekly Forecast
            Container(
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: weeklyForecast.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final forecast = weeklyForecast[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${forecast["day"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${forecast["date"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(
                                    _getWeatherIcon("${forecast["icon"]}"),
                                    color: warningColor,
                                    size: 32,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${forecast["condition"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${forecast["highTemp"]}°/${forecast["lowTemp"]}°",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDrivingConditionColor("${forecast["drivingRating"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${forecast["drivingRating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getDrivingConditionColor("${forecast["drivingRating"]}"),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

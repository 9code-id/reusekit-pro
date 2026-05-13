import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaOutdoorActivitiesView extends StatefulWidget {
  const WcaOutdoorActivitiesView({super.key});

  @override
  State<WcaOutdoorActivitiesView> createState() => _WcaOutdoorActivitiesViewState();
}

class _WcaOutdoorActivitiesViewState extends State<WcaOutdoorActivitiesView> {
  String selectedActivity = "Hiking";
  String selectedLocation = "Mountain Trail";

  List<Map<String, dynamic>> activities = [
    {"label": "Hiking", "value": "Hiking"},
    {"label": "Cycling", "value": "Cycling"},
    {"label": "Running", "value": "Running"},
    {"label": "Camping", "value": "Camping"},
    {"label": "Fishing", "value": "Fishing"},
    {"label": "Photography", "value": "Photography"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Mountain Trail", "value": "Mountain Trail"},
    {"label": "City Park", "value": "City Park"},
    {"label": "Beach Front", "value": "Beach Front"},
    {"label": "Forest Path", "value": "Forest Path"},
  ];

  Map<String, dynamic> currentConditions = {
    "temperature": 24,
    "feelsLike": 27,
    "humidity": 62,
    "windSpeed": 8,
    "uvIndex": 7,
    "visibility": 15,
    "precipitation": 10,
    "overallRating": "Excellent",
    "recommendation": "Perfect conditions for outdoor activities"
  };

  List<Map<String, dynamic>> activityForecasts = [
    {
      "activity": "Hiking",
      "rating": "Excellent",
      "score": 9.2,
      "conditions": [
        {"factor": "Temperature", "value": "24°C", "status": "Ideal"},
        {"factor": "Wind", "value": "8 km/h", "status": "Light"},
        {"factor": "UV Index", "value": "7/10", "status": "High"},
        {"factor": "Precipitation", "value": "10%", "status": "Low"}
      ],
      "recommendations": [
        "Bring sunscreen and hat",
        "Perfect temperature for long hikes",
        "Light wind makes for comfortable conditions"
      ]
    },
    {
      "activity": "Cycling",
      "rating": "Good",
      "score": 8.5,
      "conditions": [
        {"factor": "Wind Direction", "value": "Tailwind", "status": "Favorable"},
        {"factor": "Temperature", "value": "24°C", "status": "Ideal"},
        {"factor": "Road Conditions", "value": "Dry", "status": "Good"},
        {"factor": "Visibility", "value": "15 km", "status": "Excellent"}
      ],
      "recommendations": [
        "Great day for long rides",
        "Tailwind will assist your journey",
        "Stay hydrated in warm conditions"
      ]
    },
    {
      "activity": "Photography",
      "rating": "Fair",
      "score": 6.8,
      "conditions": [
        {"factor": "Light Quality", "value": "Moderate", "status": "Fair"},
        {"factor": "Cloud Cover", "value": "60%", "status": "Overcast"},
        {"factor": "Visibility", "value": "15 km", "status": "Good"},
        {"factor": "Wind", "value": "8 km/h", "status": "Stable"}
      ],
      "recommendations": [
        "Diffused lighting good for portraits",
        "Overcast conditions reduce harsh shadows",
        "Consider landscape photography"
      ]
    }
  ];

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "Now", "temp": 24, "condition": "Partly Cloudy", "rating": "Excellent"},
    {"time": "15:00", "temp": 26, "condition": "Sunny", "rating": "Excellent"},
    {"time": "16:00", "temp": 27, "condition": "Sunny", "rating": "Very Good"},
    {"time": "17:00", "temp": 25, "condition": "Partly Cloudy", "rating": "Excellent"},
    {"time": "18:00", "temp": 23, "condition": "Partly Cloudy", "rating": "Excellent"},
    {"time": "19:00", "temp": 21, "condition": "Clear", "rating": "Good"},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedActivityData = activityForecasts.firstWhere(
      (activity) => activity["activity"] == selectedActivity,
      orElse: () => activityForecasts[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Outdoor Activities"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              si("Location updated");
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
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.outdoor_grill,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Outdoor Activity Forecast",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Optimal conditions for outdoor adventures",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Activity",
                    items: activities,
                    value: selectedActivity,
                    onChanged: (value, label) {
                      selectedActivity = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locations,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getRatingColor(selectedActivityData["rating"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getRatingColor(selectedActivityData["rating"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getActivityIcon(selectedActivity),
                        color: _getRatingColor(selectedActivityData["rating"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "$selectedActivity Conditions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${selectedActivityData["rating"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(selectedActivityData["rating"]),
                    ),
                  ),
                  Text(
                    "Score: ${selectedActivityData["score"]}/10",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Current Weather",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                      Row(
                        children: [
                          Icon(
                            Icons.thermostat,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["temperature"]}°C",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Feels like ${currentConditions["feelsLike"]}°C",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "UV Index",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["uvIndex"]}/10",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        _getUVDescription(currentConditions["uvIndex"]),
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.air,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Wind Speed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["windSpeed"]} km/h",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        _getWindDescription(currentConditions["windSpeed"]),
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Humidity",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${currentConditions["humidity"]}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        _getHumidityDescription(currentConditions["humidity"]),
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Activity-Specific Conditions",
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
                spacing: spSm,
                children: (selectedActivityData["conditions"] as List).map<Widget>((condition) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${condition["factor"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${condition["value"]}",
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(condition["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${condition["status"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            Text(
              "Hourly Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: hourlyForecast.map((hour) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getRatingColor(hour["rating"]).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${hour["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${hour["temp"]}°C",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${hour["condition"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXxs),
                        decoration: BoxDecoration(
                          color: _getRatingColor(hour["rating"]),
                          borderRadius: BorderRadius.circular(radiusXxs),
                        ),
                        child: Text(
                          "${hour["rating"]}",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

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
                        Icons.lightbulb,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "$selectedActivity Recommendations",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (selectedActivityData["recommendations"] as List).map<Widget>((recommendation) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "• ",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                recommendation,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
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
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(String rating) {
    switch (rating) {
      case "Excellent":
        return successColor;
      case "Very Good":
        return infoColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ideal":
      case "Excellent":
      case "Good":
      case "Favorable":
        return successColor;
      case "Fair":
      case "Moderate":
        return warningColor;
      case "Poor":
      case "High":
        return dangerColor;
      case "Low":
      case "Light":
      case "Stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String activity) {
    switch (activity) {
      case "Hiking":
        return Icons.hiking;
      case "Cycling":
        return Icons.directions_bike;
      case "Running":
        return Icons.directions_run;
      case "Camping":
        return Icons.outdoor_grill;
      case "Fishing":
        return Icons.set_meal;
      case "Photography":
        return Icons.camera_alt;
      default:
        return Icons.outdoor_grill;
    }
  }

  String _getUVDescription(int uvIndex) {
    if (uvIndex <= 2) return "Low";
    if (uvIndex <= 5) return "Moderate";
    if (uvIndex <= 7) return "High";
    if (uvIndex <= 10) return "Very High";
    return "Extreme";
  }

  String _getWindDescription(int windSpeed) {
    if (windSpeed <= 5) return "Calm";
    if (windSpeed <= 15) return "Light breeze";
    if (windSpeed <= 25) return "Moderate breeze";
    return "Strong breeze";
  }

  String _getHumidityDescription(int humidity) {
    if (humidity <= 30) return "Dry";
    if (humidity <= 60) return "Comfortable";
    if (humidity <= 80) return "Humid";
    return "Very humid";
  }
}

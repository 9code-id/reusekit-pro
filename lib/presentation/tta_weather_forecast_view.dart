import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaWeatherForecastView extends StatefulWidget {
  const TtaWeatherForecastView({super.key});

  @override
  State<TtaWeatherForecastView> createState() => _TtaWeatherForecastViewState();
}

class _TtaWeatherForecastViewState extends State<TtaWeatherForecastView> {
  String selectedLocation = "Rome, Italy";
  String selectedTab = "Daily";

  List<Map<String, dynamic>> savedLocations = [
    {"name": "Rome, Italy", "isSelected": true},
    {"name": "Florence, Italy", "isSelected": false},
    {"name": "Venice, Italy", "isSelected": false},
    {"name": "Milan, Italy", "isSelected": false},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {
      "date": DateTime.now(),
      "dayName": "Today",
      "condition": "Partly Cloudy",
      "icon": Icons.cloud,
      "maxTemp": 26,
      "minTemp": 18,
      "humidity": 65,
      "windSpeed": 12,
      "rainChance": 20,
      "uvIndex": 6,
      "sunrise": "06:32",
      "sunset": "19:45",
      "description": "Partly cloudy with occasional sunny spells",
    },
    {
      "date": DateTime.now().add(Duration(days: 1)),
      "dayName": "Tomorrow",
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "maxTemp": 29,
      "minTemp": 20,
      "humidity": 58,
      "windSpeed": 8,
      "rainChance": 5,
      "uvIndex": 8,
      "sunrise": "06:33",
      "sunset": "19:44",
      "description": "Clear skies and sunshine throughout the day",
    },
    {
      "date": DateTime.now().add(Duration(days: 2)),
      "dayName": "Wednesday",
      "condition": "Rain",
      "icon": Icons.grain,
      "maxTemp": 22,
      "minTemp": 16,
      "humidity": 85,
      "windSpeed": 15,
      "rainChance": 90,
      "uvIndex": 3,
      "sunrise": "06:34",
      "sunset": "19:43",
      "description": "Heavy rain expected, pack an umbrella",
    },
    {
      "date": DateTime.now().add(Duration(days: 3)),
      "dayName": "Thursday",
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "maxTemp": 24,
      "minTemp": 17,
      "humidity": 72,
      "windSpeed": 10,
      "rainChance": 35,
      "uvIndex": 4,
      "sunrise": "06:35",
      "sunset": "19:42",
      "description": "Overcast skies with possible light showers",
    },
    {
      "date": DateTime.now().add(Duration(days: 4)),
      "dayName": "Friday",
      "condition": "Partly Cloudy",
      "icon": Icons.cloud,
      "maxTemp": 27,
      "minTemp": 19,
      "humidity": 68,
      "windSpeed": 9,
      "rainChance": 15,
      "uvIndex": 7,
      "sunrise": "06:36",
      "sunset": "19:41",
      "description": "Mix of clouds and sun, pleasant weather",
    },
    {
      "date": DateTime.now().add(Duration(days: 5)),
      "dayName": "Saturday",
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "maxTemp": 30,
      "minTemp": 21,
      "humidity": 55,
      "windSpeed": 7,
      "rainChance": 0,
      "uvIndex": 9,
      "sunrise": "06:37",
      "sunset": "19:40",
      "description": "Perfect sunny day, ideal for outdoor activities",
    },
    {
      "date": DateTime.now().add(Duration(days: 6)),
      "dayName": "Sunday",
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "maxTemp": 31,
      "minTemp": 22,
      "humidity": 52,
      "windSpeed": 6,
      "rainChance": 0,
      "uvIndex": 9,
      "sunrise": "06:38",
      "sunset": "19:39",
      "description": "Another beautiful sunny day with warm temperatures",
    },
  ];

  List<Map<String, dynamic>> weeklyAnalysis = [
    {
      "title": "Temperature Trend",
      "icon": Icons.thermostat,
      "value": "Rising",
      "description": "Temperatures will gradually increase from 26°C to 31°C",
      "color": warningColor,
    },
    {
      "title": "Rain Outlook",
      "icon": Icons.water_drop,
      "value": "Light",
      "description": "Rain expected only on Wednesday, mostly dry week",
      "color": infoColor,
    },
    {
      "title": "UV Index",
      "icon": Icons.wb_sunny,
      "value": "High",
      "description": "UV levels will be high to very high, sun protection recommended",
      "color": dangerColor,
    },
    {
      "title": "Wind Conditions",
      "icon": Icons.air,
      "value": "Light",
      "description": "Generally light winds, ranging from 6-15 km/h",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> travelRecommendations = [
    {
      "day": "Today",
      "activity": "City Walking Tour",
      "suitability": "Good",
      "reason": "Partly cloudy, comfortable for walking",
    },
    {
      "day": "Tomorrow",
      "activity": "Outdoor Sightseeing",
      "suitability": "Excellent",
      "reason": "Perfect sunny weather",
    },
    {
      "day": "Wednesday",
      "activity": "Museum Visits",
      "suitability": "Perfect",
      "reason": "Indoor activities ideal due to rain",
    },
    {
      "day": "Thursday",
      "activity": "Shopping",
      "suitability": "Good",
      "reason": "Overcast but dry for most of the day",
    },
    {
      "day": "Friday",
      "activity": "Photography Tour",
      "suitability": "Good",
      "reason": "Nice lighting with mix of clouds and sun",
    },
    {
      "day": "Weekend",
      "activity": "Beach Day / Outdoor Activities",
      "suitability": "Excellent",
      "reason": "Perfect sunny weather both days",
    },
  ];

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
        return Icons.wb_sunny;
      case "cloudy":
      case "partly cloudy":
        return Icons.cloud;
      case "rain":
      case "light rain":
        return Icons.grain;
      case "storm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getUVIndexColor(int uvIndex) {
    if (uvIndex <= 2) return successColor;
    if (uvIndex <= 5) return warningColor;
    if (uvIndex <= 7) return dangerColor;
    return Color(0xFF8B0000); // Dark red for very high
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Weather forecast shared");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Selector
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: savedLocations.map((location) {
                bool isSelected = location["name"] == selectedLocation;
                return GestureDetector(
                  onTap: () {
                    selectedLocation = location["name"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${location["name"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab Selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: ["Daily", "Weekly"].map((tab) {
                bool isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: selectedTab == "Daily"
                ? _buildDailyForecast()
                : _buildWeeklyAnalysis(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecast() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 7-Day Forecast
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: dailyForecast.length,
            itemBuilder: (context, index) {
              final day = dailyForecast[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  leading: Icon(
                    _getWeatherIcon("${day["condition"]}"),
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${day["dayName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              (day["date"] as DateTime).dMMMy,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${day["condition"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${day["maxTemp"]}°",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${day["minTemp"]}°",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${day["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Weather Details Grid
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 200,
                            children: [
                              _buildDetailCard(
                                Icons.water_drop,
                                "Humidity",
                                "${day["humidity"]}%",
                                infoColor,
                              ),
                              _buildDetailCard(
                                Icons.air,
                                "Wind Speed",
                                "${day["windSpeed"]} km/h",
                                primaryColor,
                              ),
                              _buildDetailCard(
                                Icons.grain,
                                "Rain Chance",
                                "${day["rainChance"]}%",
                                day["rainChance"] > 50 ? dangerColor : successColor,
                              ),
                              _buildDetailCard(
                                Icons.wb_sunny,
                                "UV Index",
                                "${day["uvIndex"]}",
                                _getUVIndexColor(day["uvIndex"] as int),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Sun Times
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wb_sunny,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Sunrise: ${day["sunrise"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.brightness_3,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Sunset: ${day["sunset"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: spMd),

          // Travel Recommendations
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "Travel Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: travelRecommendations.length,
            itemBuilder: (context, index) {
              final rec = travelRecommendations[index];
              Color suitabilityColor = rec["suitability"] == "Excellent" 
                  ? successColor 
                  : rec["suitability"] == "Perfect"
                      ? primaryColor
                      : rec["suitability"] == "Good"
                          ? warningColor
                          : disabledBoldColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      child: Text(
                        "${rec["day"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${rec["activity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${rec["reason"]}",
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
                        color: suitabilityColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${rec["suitability"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: suitabilityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildWeeklyAnalysis() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Weather Analysis",
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
            children: weeklyAnalysis.map((analysis) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (analysis["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            analysis["icon"] as IconData,
                            size: 24,
                            color: analysis["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${analysis["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${analysis["value"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: analysis["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${analysis["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spLg),

          // Temperature Graph Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temperature Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Temperature Chart",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "26°C → 31°C over 7 days",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Weekly Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.summarize,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Weekly Summary",
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
                  "This week offers excellent travel weather with mostly sunny conditions. "
                  "Wednesday will see rain, making it perfect for indoor activities. "
                  "The weekend promises beautiful sunny weather ideal for outdoor exploration. "
                  "Pack light layers and don't forget sun protection for the sunny days.",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

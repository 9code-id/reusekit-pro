import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaWeatherView extends StatefulWidget {
  const TtaWeatherView({super.key});

  @override
  State<TtaWeatherView> createState() => _TtaWeatherViewState();
}

class _TtaWeatherViewState extends State<TtaWeatherView> {
  String selectedLocation = "Rome, Italy";
  bool isLoading = false;

  List<Map<String, dynamic>> savedLocations = [
    {"name": "Rome, Italy", "isSelected": true},
    {"name": "Florence, Italy", "isSelected": false},
    {"name": "Venice, Italy", "isSelected": false},
    {"name": "Milan, Italy", "isSelected": false},
    {"name": "Naples, Italy", "isSelected": false},
  ];

  Map<String, dynamic> currentWeather = {
    "location": "Rome, Italy",
    "temperature": 24,
    "condition": "Partly Cloudy",
    "icon": Icons.cloud,
    "humidity": 65,
    "windSpeed": 12,
    "windDirection": "NW",
    "visibility": 10,
    "uvIndex": 6,
    "pressure": 1013,
    "sunrise": "06:32",
    "sunset": "19:45",
    "feelsLike": 26,
    "lastUpdated": "2 minutes ago",
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "Now", "temp": 24, "icon": Icons.cloud, "condition": "Cloudy", "rain": 10},
    {"time": "14:00", "temp": 26, "icon": Icons.wb_sunny, "condition": "Sunny", "rain": 0},
    {"time": "15:00", "temp": 28, "icon": Icons.wb_sunny, "condition": "Sunny", "rain": 0},
    {"time": "16:00", "temp": 27, "icon": Icons.cloud, "condition": "Cloudy", "rain": 5},
    {"time": "17:00", "temp": 25, "icon": Icons.cloud, "condition": "Cloudy", "rain": 15},
    {"time": "18:00", "temp": 23, "icon": Icons.grain, "condition": "Light Rain", "rain": 80},
    {"time": "19:00", "temp": 21, "icon": Icons.grain, "condition": "Rain", "rain": 90},
    {"time": "20:00", "temp": 20, "icon": Icons.cloud, "condition": "Cloudy", "rain": 30},
  ];

  List<Map<String, dynamic>> travelTips = [
    {
      "icon": Icons.umbrella,
      "title": "Pack an Umbrella",
      "description": "Light rain expected this evening",
      "color": infoColor,
    },
    {
      "icon": Icons.wb_sunny,
      "title": "Wear Sunscreen",
      "description": "UV Index is moderate to high today",
      "color": warningColor,
    },
    {
      "icon": Icons.local_drink,
      "title": "Stay Hydrated",
      "description": "Warm temperatures throughout the day",
      "color": successColor,
    },
    {
      "icon": Icons.layers,
      "title": "Dress in Layers",
      "description": "Temperature varies 8°C during the day",
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> activitySuggestions = [
    {
      "activity": "Visit Vatican Museums",
      "suitability": "Perfect",
      "reason": "Indoor activity, perfect for any weather",
      "icon": Icons.museum,
      "color": successColor,
    },
    {
      "activity": "Colosseum Tour",
      "suitability": "Good",
      "reason": "Partly cloudy, comfortable for walking",
      "icon": Icons.location_city,
      "color": successColor,
    },
    {
      "activity": "Outdoor Dining",
      "suitability": "Fair",
      "reason": "Rain expected in the evening",
      "icon": Icons.restaurant,
      "color": warningColor,
    },
    {
      "activity": "Beach Trip",
      "suitability": "Not Recommended",
      "reason": "Cloudy conditions and possible rain",
      "icon": Icons.beach_access,
      "color": dangerColor,
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

  Color _getSuitabilityColor(String suitability) {
    switch (suitability.toLowerCase()) {
      case "perfect":
        return successColor;
      case "good":
        return successColor;
      case "fair":
        return warningColor;
      case "not recommended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_location),
            onPressed: () {
              //navigateTo('AddLocationView')
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  // Current Weather Card
                  Container(
                    margin: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor,
                          primaryColor.withAlpha(204),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${currentWeather["location"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Updated ${currentWeather["lastUpdated"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withAlpha(179),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                _getWeatherIcon("${currentWeather["condition"]}"),
                                size: 48,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${currentWeather["temperature"]}°",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Padding(
                                padding: EdgeInsets.only(bottom: spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${currentWeather["condition"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Feels like ${currentWeather["feelsLike"]}°",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withAlpha(179),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Weather Details
                          Row(
                            children: [
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.water_drop,
                                  "Humidity",
                                  "${currentWeather["humidity"]}%",
                                ),
                              ),
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.air,
                                  "Wind",
                                  "${currentWeather["windSpeed"]} km/h ${currentWeather["windDirection"]}",
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.visibility,
                                  "Visibility",
                                  "${currentWeather["visibility"]} km",
                                ),
                              ),
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.wb_sunny,
                                  "UV Index",
                                  "${currentWeather["uvIndex"]}",
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.compress,
                                  "Pressure",
                                  "${currentWeather["pressure"]} hPa",
                                ),
                              ),
                              Expanded(
                                child: _buildWeatherDetail(
                                  Icons.schedule,
                                  "Sun",
                                  "${currentWeather["sunrise"]} - ${currentWeather["sunset"]}",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Hourly Forecast
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: hourlyForecast.map((hour) {
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(left: spMd),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
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
                                size: 24,
                                color: primaryColor,
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
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 12,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${hour["rain"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Travel Tips
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "Travel Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    minItemWidth: 200,
                    children: travelTips.map((tip) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (tip["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                tip["icon"] as IconData,
                                size: 24,
                                color: tip["color"] as Color,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${tip["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${tip["description"]}",
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
                  ),

                  SizedBox(height: spMd),

                  // Activity Suggestions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "Activity Suggestions",
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
                    itemCount: activitySuggestions.length,
                    itemBuilder: (context, index) {
                      final activity = activitySuggestions[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (activity["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                activity["icon"] as IconData,
                                size: 24,
                                color: activity["color"] as Color,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${activity["activity"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getSuitabilityColor("${activity["suitability"]}").withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${activity["suitability"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: _getSuitabilityColor("${activity["suitability"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${activity["reason"]}",
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
                    },
                  ),

                  SizedBox(height: spMd),

                  // Extended Forecast Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View 7-Day Forecast",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('TtaWeatherForecastView')
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: spMd),
                ],
              ),
            ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white.withAlpha(179),
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withAlpha(179),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather10View extends StatefulWidget {
  @override
  State<GrlWeather10View> createState() => _GrlWeather10ViewState();
}

class _GrlWeather10ViewState extends State<GrlWeather10View> {
  int selectedIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> savedLocations = [
    {
      "name": "Singapore",
      "country": "Singapore",
      "temp": 32,
      "condition": "Humid",
      "icon": Icons.wb_cloudy,
      "humidity": 85,
      "windSpeed": 8,
      "isCurrentLocation": true,
      "gradient": [Colors.teal.shade300, Colors.teal.shade600],
    },
    {
      "name": "Bangkok",
      "country": "Thailand", 
      "temp": 35,
      "condition": "Hot",
      "icon": Icons.wb_sunny,
      "humidity": 72,
      "windSpeed": 12,
      "isCurrentLocation": false,
      "gradient": [Colors.orange.shade300, Colors.orange.shade600],
    },
    {
      "name": "Kuala Lumpur",
      "country": "Malaysia",
      "temp": 30,
      "condition": "Rainy",
      "icon": Icons.grain,
      "humidity": 88,
      "windSpeed": 15,
      "isCurrentLocation": false,
      "gradient": [Colors.blue.shade300, Colors.blue.shade600],
    },
    {
      "name": "Jakarta",
      "country": "Indonesia",
      "temp": 33,
      "condition": "Cloudy",
      "icon": Icons.wb_cloudy,
      "humidity": 78,
      "windSpeed": 10,
      "isCurrentLocation": false,
      "gradient": [Colors.grey.shade400, Colors.grey.shade600],
    },
  ];

  Map<String, dynamic> currentWeatherDetails = {
    "hourlyForecast": [
      {"time": "Now", "temp": 32, "icon": Icons.wb_cloudy, "precipitation": 60},
      {"time": "2 PM", "temp": 33, "icon": Icons.grain, "precipitation": 80},
      {"time": "3 PM", "temp": 31, "icon": Icons.grain, "precipitation": 90},
      {"time": "4 PM", "temp": 30, "icon": Icons.wb_cloudy, "precipitation": 70},
      {"time": "5 PM", "temp": 29, "icon": Icons.wb_cloudy, "precipitation": 50},
      {"time": "6 PM", "temp": 28, "icon": Icons.nightlight_round, "precipitation": 30},
    ],
    "weeklyForecast": [
      {"day": "Today", "high": 33, "low": 26, "icon": Icons.grain, "precipitation": 85},
      {"day": "Tomorrow", "high": 31, "low": 25, "icon": Icons.wb_cloudy, "precipitation": 60},
      {"day": "Wednesday", "high": 34, "low": 27, "icon": Icons.wb_sunny, "precipitation": 20},
      {"day": "Thursday", "high": 32, "low": 26, "icon": Icons.grain, "precipitation": 75},
      {"day": "Friday", "high": 30, "low": 24, "icon": Icons.grain, "precipitation": 90},
      {"day": "Saturday", "high": 33, "low": 27, "icon": Icons.wb_cloudy, "precipitation": 40},
      {"day": "Sunday", "high": 35, "low": 28, "icon": Icons.wb_sunny, "precipitation": 10},
    ],
    "weatherMetrics": {
      "feelsLike": 38,
      "uvIndex": 8,
      "visibility": 6,
      "pressure": 1008,
      "dewPoint": 27,
      "airQuality": 78,
      "aqiStatus": "Moderate",
      "sunrise": "6:55 AM",
      "sunset": "7:12 PM",
    }
  };

  List<Map<String, dynamic>> weatherNews = [
    {
      "title": "Monsoon Season Alert",
      "description": "Heavy rainfall expected across Southeast Asia this week",
      "time": "2 hours ago",
      "icon": Icons.article,
      "color": Colors.blue,
    },
    {
      "title": "Heat Wave Warning",
      "description": "Temperatures reaching 38°C in urban areas",
      "time": "5 hours ago", 
      "icon": Icons.warning,
      "color": Colors.orange,
    },
    {
      "title": "Air Quality Update",
      "description": "Haze levels improving after recent rains",
      "time": "1 day ago",
      "icon": Icons.eco,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Weather App",
      selectedIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: "Locations",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.radar),
          label: "Radar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: "News",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildLocationsTab(),
        _buildRadarTab(),
        _buildNewsTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  Widget _buildHomeTab() {
    final currentLocation = savedLocations.firstWhere((loc) => loc["isCurrentLocation"] == true);
    
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCurrentLocationCard(currentLocation),
          _buildTodayHighlights(),
          _buildHourlyForecast(),
          _buildWeeklyPreview(),
          _buildWeatherInsights(),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationCard(Map<String, dynamic> location) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: location["gradient"] as List<Color>,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: spMd,
            right: spMd,
            child: SafeArea(
              child: Row(
                children: [
                  Column(
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
                            "${location["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${location["country"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  location["icon"] as IconData,
                  size: 120,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "${location["temp"]}°",
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${location["condition"]}",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withAlpha(240),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Feels like ${currentWeatherDetails["weatherMetrics"]["feelsLike"]}°",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickStat("Humidity", "${location["humidity"]}%", Icons.water_drop),
                  _buildQuickStat("Wind", "${location["windSpeed"]} km/h", Icons.air),
                  _buildQuickStat("UV Index", "${currentWeatherDetails["weatherMetrics"]["uvIndex"]}", Icons.wb_sunny),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withAlpha(200),
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayHighlights() {
    final metrics = currentWeatherDetails["weatherMetrics"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Highlights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildHighlightCard("Air Quality", "AQI ${metrics["airQuality"]}", "${metrics["aqiStatus"]}", Icons.eco, _getAQIColor(metrics["airQuality"])),
              _buildHighlightCard("UV Index", "${metrics["uvIndex"]}", "Very High", Icons.wb_sunny, Colors.orange),
              _buildHighlightCard("Visibility", "${metrics["visibility"]} km", "Poor", Icons.visibility, Colors.purple),
              _buildHighlightCard("Pressure", "${metrics["pressure"]} hPa", "Low", Icons.speed, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Color _getAQIColor(int aqi) {
    if (aqi <= 50) return successColor;
    if (aqi <= 100) return warningColor;
    return dangerColor;
  }

  Widget _buildHighlightCard(String title, String value, String status, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
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
              color: primaryColor,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    final hourlyData = currentWeatherDetails["hourlyForecast"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Forecast",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final hour = hourlyData[index];
                final isNow = hour["time"] == "Now";
                
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isNow ? primaryColor.withAlpha(30) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isNow ? primaryColor : disabledOutlineBorderColor,
                      width: isNow ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${hour["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
                          color: isNow ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Icon(
                        hour["icon"] as IconData,
                        color: primaryColor,
                        size: 28,
                      ),
                      Text(
                        "${hour["temp"]}°",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: infoColor,
                            size: 10,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${hour["precipitation"]}%",
                            style: TextStyle(
                              fontSize: 9,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyPreview() {
    final weeklyData = currentWeatherDetails["weeklyForecast"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "7-Day Forecast",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...weeklyData.take(4).map((day) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
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
                    day["icon"] as IconData,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: infoColor,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${day["precipitation"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${day["low"]}°",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 40,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [infoColor, primaryColor],
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${day["high"]}°",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildWeatherInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(30), Colors.white],
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Today's Tips",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Carry an umbrella - 85% chance of rain this afternoon\n• Stay hydrated - High humidity levels expected\n• Indoor activities recommended from 12-4 PM due to poor air quality",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for a city...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: disabledBoldColor),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Saved Locations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...savedLocations.map((location) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: location["gradient"] as List<Color>,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${location["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (location["isCurrentLocation"]) ...[
                              SizedBox(width: spXs),
                              Icon(
                                Icons.my_location,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "${location["country"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${location["condition"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.white.withAlpha(200),
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${location["humidity"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.air,
                              color: Colors.white.withAlpha(200),
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${location["windSpeed"]} km/h",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        location["icon"] as IconData,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${location["temp"]}°",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRadarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Radar",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.radar,
                  size: 80,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Live Radar Map",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Southeast Asia Region",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Radar Controls",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildRadarControl("Precipitation", Icons.grain, Colors.blue, true),
              _buildRadarControl("Temperature", Icons.thermostat, Colors.red, false),
              _buildRadarControl("Wind Speed", Icons.air, Colors.green, false),
              _buildRadarControl("Cloud Cover", Icons.cloud, Colors.grey, false),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Radar Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildRadarInfo("Last Updated", "2 minutes ago"),
                _buildRadarInfo("Coverage Area", "1000km radius"),
                _buildRadarInfo("Resolution", "1km precision"),
                _buildRadarInfo("Update Frequency", "Every 6 minutes"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarControl(String title, IconData icon, Color color, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle radar layer
        });
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isActive ? color.withAlpha(30) : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isActive ? color : disabledOutlineBorderColor,
            width: isActive ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(width: spXs),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? color : primaryColor,
                ),
              ),
            ),
            if (isActive)
              Icon(
                Icons.check_circle,
                color: color,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather News & Updates",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...weatherNews.map((news) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (news["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      news["icon"] as IconData,
                      color: news["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${news["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${news["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${news["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(30), Colors.white],
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stay Updated",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Enable notifications to get real-time weather alerts and updates",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Enable",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile & Settings",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.person,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weather User",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Singapore, Singapore",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          _buildSettingsSection("Preferences", [
            {"title": "Temperature Unit", "value": "Celsius (°C)", "icon": Icons.thermostat},
            {"title": "Wind Speed Unit", "value": "km/h", "icon": Icons.air},
            {"title": "Time Format", "value": "24 Hour", "icon": Icons.schedule},
            {"title": "Language", "value": "English", "icon": Icons.language},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("Notifications", [
            {"title": "Weather Alerts", "value": "Enabled", "icon": Icons.notifications},
            {"title": "Daily Forecast", "value": "8:00 AM", "icon": Icons.today},
            {"title": "Severe Weather", "value": "Enabled", "icon": Icons.warning},
            {"title": "Rain Notifications", "value": "30 min before", "icon": Icons.grain},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("Privacy & Data", [
            {"title": "Location Services", "value": "Enabled", "icon": Icons.location_on},
            {"title": "Data Usage", "value": "Optimized", "icon": Icons.data_usage},
            {"title": "Privacy Policy", "value": "", "icon": Icons.privacy_tip},
            {"title": "Terms of Service", "value": "", "icon": Icons.description},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("About", [
            {"title": "App Version", "value": "3.2.1", "icon": Icons.info},
            {"title": "Data Provider", "value": "Global Weather Service", "icon": Icons.cloud},
            {"title": "Rate App", "value": "", "icon": Icons.star},
            {"title": "Share App", "value": "", "icon": Icons.share},
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isLast ? Colors.transparent : disabledOutlineBorderColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (item["value"].toString().isNotEmpty) ...[
                      Text(
                        "${item["value"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                    ],
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

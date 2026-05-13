import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather4View extends StatefulWidget {
  @override
  State<GrlWeather4View> createState() => _GrlWeather4ViewState();
}

class _GrlWeather4ViewState extends State<GrlWeather4View> {
  int selectedLocationIndex = 0;
  
  List<Map<String, dynamic>> locations = [
    {
      "name": "New York",
      "country": "United States",
      "temp": 22,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "humidity": 65,
      "windSpeed": 12,
      "uvIndex": 6,
      "pressure": 1013,
      "visibility": 10,
      "airQuality": "Good",
      "hourlyForecast": [
        {"time": "12 PM", "temp": 22, "icon": Icons.wb_sunny},
        {"time": "1 PM", "temp": 24, "icon": Icons.wb_sunny},
        {"time": "2 PM", "temp": 26, "icon": Icons.wb_cloudy},
        {"time": "3 PM", "temp": 25, "icon": Icons.wb_cloudy},
        {"time": "4 PM", "temp": 23, "icon": Icons.grain},
      ],
      "weeklyForecast": [
        {"day": "Today", "highTemp": 26, "lowTemp": 18, "icon": Icons.wb_sunny},
        {"day": "Tomorrow", "highTemp": 24, "lowTemp": 16, "icon": Icons.wb_cloudy},
        {"day": "Wednesday", "highTemp": 28, "lowTemp": 20, "icon": Icons.wb_sunny},
        {"day": "Thursday", "highTemp": 22, "lowTemp": 14, "icon": Icons.grain},
        {"day": "Friday", "highTemp": 25, "lowTemp": 17, "icon": Icons.wb_cloudy},
      ]
    },
    {
      "name": "London",
      "country": "United Kingdom",
      "temp": 15,
      "condition": "Cloudy",
      "icon": Icons.wb_cloudy,
      "humidity": 78,
      "windSpeed": 8,
      "uvIndex": 3,
      "pressure": 1008,
      "visibility": 8,
      "airQuality": "Moderate",
      "hourlyForecast": [
        {"time": "12 PM", "temp": 15, "icon": Icons.wb_cloudy},
        {"time": "1 PM", "temp": 16, "icon": Icons.wb_cloudy},
        {"time": "2 PM", "temp": 17, "icon": Icons.grain},
        {"time": "3 PM", "temp": 16, "icon": Icons.grain},
        {"time": "4 PM", "temp": 14, "icon": Icons.grain},
      ],
      "weeklyForecast": [
        {"day": "Today", "highTemp": 17, "lowTemp": 12, "icon": Icons.wb_cloudy},
        {"day": "Tomorrow", "highTemp": 19, "lowTemp": 14, "icon": Icons.grain},
        {"day": "Wednesday", "highTemp": 16, "lowTemp": 11, "icon": Icons.grain},
        {"day": "Thursday", "highTemp": 18, "lowTemp": 13, "icon": Icons.wb_cloudy},
        {"day": "Friday", "highTemp": 20, "lowTemp": 15, "icon": Icons.wb_sunny},
      ]
    },
    {
      "name": "Tokyo",
      "country": "Japan",
      "temp": 28,
      "condition": "Hot",
      "icon": Icons.wb_sunny,
      "humidity": 72,
      "windSpeed": 5,
      "uvIndex": 8,
      "pressure": 1020,
      "visibility": 12,
      "airQuality": "Good",
      "hourlyForecast": [
        {"time": "12 PM", "temp": 28, "icon": Icons.wb_sunny},
        {"time": "1 PM", "temp": 30, "icon": Icons.wb_sunny},
        {"time": "2 PM", "temp": 32, "icon": Icons.wb_sunny},
        {"time": "3 PM", "temp": 31, "icon": Icons.wb_cloudy},
        {"time": "4 PM", "temp": 29, "icon": Icons.wb_cloudy},
      ],
      "weeklyForecast": [
        {"day": "Today", "highTemp": 32, "lowTemp": 24, "icon": Icons.wb_sunny},
        {"day": "Tomorrow", "highTemp": 30, "lowTemp": 22, "icon": Icons.wb_sunny},
        {"day": "Wednesday", "highTemp": 29, "lowTemp": 21, "icon": Icons.wb_cloudy},
        {"day": "Thursday", "highTemp": 27, "lowTemp": 19, "icon": Icons.grain},
        {"day": "Friday", "highTemp": 26, "lowTemp": 18, "icon": Icons.grain},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = locations[selectedLocationIndex];
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLocationHeader(),
            _buildCurrentWeather(),
            _buildDetailsGrid(),
            _buildHourlyForecast(),
            _buildWeeklyForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(200),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: GestureDetector(
                    onTap: _showLocationSelector,
                    child: Row(
                      children: [
                        Text(
                          "${locations[selectedLocationIndex]["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
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
            SizedBox(height: spXs),
            Row(
              children: [
                Text(
                  "${locations[selectedLocationIndex]["country"]}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather() {
    final location = locations[selectedLocationIndex];
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor.withAlpha(200),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(
            location["icon"] as IconData,
            size: 80,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "${location["temp"]}°",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Text(
            "${location["condition"]}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withAlpha(230),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Feels like ${(location["temp"] as int) + 2}°",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid() {
    final location = locations[selectedLocationIndex];
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildDetailCard("Humidity", "${location["humidity"]}%", Icons.water_drop),
              _buildDetailCard("Wind Speed", "${location["windSpeed"]} km/h", Icons.air),
              _buildDetailCard("UV Index", "${location["uvIndex"]}", Icons.wb_sunny),
              _buildDetailCard("Pressure", "${location["pressure"]} hPa", Icons.speed),
              _buildDetailCard("Visibility", "${location["visibility"]} km", Icons.visibility),
              _buildDetailCard("Air Quality", "${location["airQuality"]}", Icons.eco),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    final hourlyData = locations[selectedLocationIndex]["hourlyForecast"] as List;
    
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
          QHorizontalScroll(
            children: hourlyData.map((hour) {
              return Container(
                width: 80,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "${hour["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Icon(
                      hour["icon"] as IconData,
                      color: primaryColor,
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
    );
  }

  Widget _buildWeeklyForecast() {
    final weeklyData = locations[selectedLocationIndex]["weeklyForecast"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7-Day Forecast",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...weeklyData.map((day) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Text(
                      "${day["day"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Icon(
                    day["icon"] as IconData,
                    color: primaryColor,
                    size: 20,
                  ),
                  Spacer(),
                  Text(
                    "${day["lowTemp"]}°",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [disabledColor, primaryColor],
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${day["highTemp"]}°",
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
        ],
      ),
    );
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Select Location",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...locations.asMap().entries.map((entry) {
                final index = entry.key;
                final location = entry.value;
                final isSelected = index == selectedLocationIndex;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLocationIndex = index;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(30) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${location["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : primaryColor,
                                ),
                              ),
                              Text(
                                "${location["country"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${location["temp"]}°",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather2View extends StatefulWidget {
  @override
  State<GrlWeather2View> createState() => _GrlWeather2ViewState();
}

class _GrlWeather2ViewState extends State<GrlWeather2View> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> locations = [
    {
      "city": "London",
      "country": "UK",
      "temp": 18,
      "condition": "Rainy",
      "icon": Icons.grain,
      "time": "6:30 PM"
    },
    {
      "city": "Tokyo",
      "country": "Japan",
      "temp": 28,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "time": "2:30 AM"
    },
    {
      "city": "Sydney",
      "country": "Australia",
      "temp": 22,
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "time": "4:30 AM"
    },
    {
      "city": "New York",
      "country": "USA",
      "temp": 25,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "time": "1:30 PM"
    },
  ];

  Map<String, dynamic> selectedLocation = {
    "city": "London",
    "country": "UK",
    "temp": 18,
    "condition": "Rainy",
    "humidity": 78,
    "windSpeed": 15,
    "pressure": 1008,
    "visibility": 8,
    "icon": Icons.grain,
  };

  List<Map<String, dynamic>> todayHourly = [
    {"time": "Now", "temp": 18, "icon": Icons.grain, "precipitation": 65},
    {"time": "7 PM", "temp": 17, "icon": Icons.grain, "precipitation": 70},
    {"time": "8 PM", "temp": 16, "icon": Icons.grain, "precipitation": 80},
    {"time": "9 PM", "temp": 15, "icon": Icons.cloud, "precipitation": 45},
    {"time": "10 PM", "temp": 14, "icon": Icons.cloud, "precipitation": 30},
    {"time": "11 PM", "temp": 13, "icon": Icons.wb_cloudy, "precipitation": 20},
    {"time": "12 AM", "temp": 12, "icon": Icons.wb_cloudy, "precipitation": 15},
    {"time": "1 AM", "temp": 11, "icon": Icons.wb_cloudy, "precipitation": 10},
  ];

  List<Map<String, dynamic>> weeklyData = [
    {
      "day": "Today",
      "date": "Feb 15",
      "high": 18,
      "low": 12,
      "condition": "Rainy",
      "icon": Icons.grain,
      "precipitation": 75
    },
    {
      "day": "Tomorrow",
      "date": "Feb 16",
      "high": 20,
      "low": 14,
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "precipitation": 40
    },
    {
      "day": "Saturday",
      "date": "Feb 17",
      "high": 22,
      "low": 16,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "precipitation": 25
    },
    {
      "day": "Sunday",
      "date": "Feb 18",
      "high": 24,
      "low": 18,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "precipitation": 5
    },
    {
      "day": "Monday",
      "date": "Feb 19",
      "high": 26,
      "low": 19,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "precipitation": 0
    },
  ];

  List<Map<String, dynamic>> weatherMaps = [
    {
      "title": "Temperature",
      "description": "Current temperature distribution",
      "icon": Icons.thermostat,
      "color": Colors.red
    },
    {
      "title": "Precipitation",
      "description": "Rainfall and snow patterns",
      "icon": Icons.grain,
      "color": Colors.blue
    },
    {
      "title": "Wind Speed",
      "description": "Wind patterns and direction",
      "icon": Icons.air,
      "color": Colors.grey
    },
    {
      "title": "Cloud Cover",
      "description": "Satellite cloud imagery",
      "icon": Icons.cloud,
      "color": Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Weather Pro",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Current", icon: Icon(Icons.wb_sunny)),
        Tab(text: "Forecast", icon: Icon(Icons.calendar_today)),
        Tab(text: "Maps", icon: Icon(Icons.map)),
      ],
      tabChildren: [
        _buildCurrentTab(),
        _buildForecastTab(),
        _buildMapsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildCurrentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Selector
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Locations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                QHorizontalScroll(
                  children: locations.map((location) {
                    bool isSelected = location["city"] == selectedLocation["city"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedLocation = location;
                        setState(() {});
                      },
                      child: Container(
                        width: 140,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(50) : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${location["city"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${location["country"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  location["icon"] as IconData,
                                  color: _getWeatherIconColor(location["icon"] as IconData),
                                  size: 24,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${location["temp"]}°C",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${location["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${location["condition"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Current Weather Details
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getWeatherGradientColor(selectedLocation["icon"] as IconData),
                  _getWeatherGradientColor(selectedLocation["icon"] as IconData).withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedLocation["city"]}, ${selectedLocation["country"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Friday, 3:30 PM",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        selectedLocation["icon"] as IconData,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${selectedLocation["temp"]}°C",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${selectedLocation["condition"]}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Feels like ${(selectedLocation["temp"] as int) + 2}°C",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Weather Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildWeatherMetric("Humidity", "${selectedLocation["humidity"]}%", Icons.water_drop, Colors.blue),
              _buildWeatherMetric("Wind Speed", "${selectedLocation["windSpeed"]} km/h", Icons.air, Colors.grey),
              _buildWeatherMetric("Pressure", "${selectedLocation["pressure"]} hPa", Icons.speed, Colors.orange),
              _buildWeatherMetric("Visibility", "${selectedLocation["visibility"]} km", Icons.visibility, Colors.green),
            ],
          ),

          // Today's Hourly
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Hourly Forecast",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QHorizontalScroll(
                  children: todayHourly.map((hour) {
                    return Container(
                      width: 70,
                      padding: EdgeInsets.symmetric(vertical: spMd, horizontal: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Text(
                            "${hour["time"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            hour["icon"] as IconData,
                            color: _getWeatherIconColor(hour["icon"] as IconData),
                            size: 24,
                          ),
                          Text(
                            "${hour["temp"]}°",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if ((hour["precipitation"] as int) > 0)
                            Text(
                              "${hour["precipitation"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
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
    );
  }

  Widget _buildForecastTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedLocation["city"]}, ${selectedLocation["country"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "5-Day Weather Forecast",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Weekly Forecast
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Extended Forecast",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: weeklyData.map((forecast) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${forecast["day"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${forecast["date"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowXs],
                            ),
                            child: Icon(
                              forecast["icon"] as IconData,
                              color: _getWeatherIconColor(forecast["icon"] as IconData),
                              size: 28,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${forecast["condition"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((forecast["precipitation"] as int) > 0)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.water_drop,
                                        size: 12,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${forecast["precipitation"]}% chance of rain",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${forecast["high"]}°",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${forecast["low"]}°",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Weather Tips
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: infoColor,
                  size: 24,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weather Tip",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Rain expected tomorrow. Don't forget your umbrella!",
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

  Widget _buildMapsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Types
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: weatherMaps.map((map) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: (map["color"] as Color).withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        map["icon"] as IconData,
                        color: map["color"] as Color,
                        size: 40,
                      ),
                    ),
                    Text(
                      "${map["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${map["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Map",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Map Preview Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 48,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Interactive Weather Map",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Select a map type above to view detailed weather patterns",
                  textAlign: TextAlign.center,
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
  }

  Widget _buildWeatherMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getWeatherIconColor(IconData icon) {
    if (icon == Icons.wb_sunny) return Colors.orange;
    if (icon == Icons.wb_cloudy) return Colors.blue;
    if (icon == Icons.cloud) return Colors.grey;
    if (icon == Icons.grain) return Colors.blue;
    if (icon == Icons.flash_on) return Colors.purple;
    return Colors.grey;
  }

  Color _getWeatherGradientColor(IconData icon) {
    if (icon == Icons.wb_sunny) return Colors.orange;
    if (icon == Icons.wb_cloudy) return Colors.blue;
    if (icon == Icons.cloud) return Colors.grey;
    if (icon == Icons.grain) return Colors.indigo;
    if (icon == Icons.flash_on) return Colors.purple;
    return primaryColor;
  }
}

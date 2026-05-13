import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaDestinationWeatherView extends StatefulWidget {
  const WcaDestinationWeatherView({super.key});

  @override
  State<WcaDestinationWeatherView> createState() => _WcaDestinationWeatherViewState();
}

class _WcaDestinationWeatherViewState extends State<WcaDestinationWeatherView> {
  String selectedDestination = "Paris, France";
  String searchQuery = "";
  
  List<Map<String, dynamic>> topDestinations = [
    {
      "name": "Paris, France",
      "temperature": 68,
      "condition": "Partly Cloudy",
      "humidity": 65,
      "windSpeed": 8,
      "precipitation": 20,
      "uvIndex": 6,
      "visibility": 10,
      "pressure": 1013,
      "season": "Spring",
      "timezone": "GMT+2",
      "sunrise": "06:30",
      "sunset": "20:15",
      "image": "https://picsum.photos/400/250?random=1&keyword=paris",
      "icon": Icons.wb_cloudy,
      "rating": 4.8,
    },
    {
      "name": "Tokyo, Japan",
      "temperature": 72,
      "condition": "Sunny",
      "humidity": 55,
      "windSpeed": 5,
      "precipitation": 10,
      "uvIndex": 8,
      "visibility": 12,
      "pressure": 1020,
      "season": "Spring",
      "timezone": "GMT+9",
      "sunrise": "05:45",
      "sunset": "18:30",
      "image": "https://picsum.photos/400/250?random=2&keyword=tokyo",
      "icon": Icons.wb_sunny,
      "rating": 4.9,
    },
    {
      "name": "London, UK",
      "temperature": 63,
      "condition": "Light Rain",
      "humidity": 75,
      "windSpeed": 12,
      "precipitation": 60,
      "uvIndex": 3,
      "visibility": 8,
      "pressure": 1008,
      "season": "Spring",
      "timezone": "GMT+1",
      "sunrise": "06:15",
      "sunset": "19:45",
      "image": "https://picsum.photos/400/250?random=3&keyword=london",
      "icon": Icons.grain,
      "rating": 4.5,
    },
    {
      "name": "New York, USA",
      "temperature": 75,
      "condition": "Clear",
      "humidity": 50,
      "windSpeed": 10,
      "precipitation": 5,
      "uvIndex": 7,
      "visibility": 15,
      "pressure": 1015,
      "season": "Spring",
      "timezone": "GMT-4",
      "sunrise": "06:00",
      "sunset": "19:30",
      "image": "https://picsum.photos/400/250?random=4&keyword=newyork",
      "icon": Icons.wb_sunny,
      "rating": 4.7,
    },
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "high": 72, "low": 58, "condition": "Sunny", "precipitation": 0, "icon": Icons.wb_sunny},
    {"day": "Tue", "high": 69, "low": 55, "condition": "Cloudy", "precipitation": 20, "icon": Icons.wb_cloudy},
    {"day": "Wed", "high": 66, "low": 52, "condition": "Rain", "precipitation": 80, "icon": Icons.grain},
    {"day": "Thu", "high": 70, "low": 56, "condition": "Partly Cloudy", "precipitation": 10, "icon": Icons.wb_cloudy},
    {"day": "Fri", "high": 74, "low": 60, "condition": "Sunny", "precipitation": 0, "icon": Icons.wb_sunny},
    {"day": "Sat", "high": 76, "low": 62, "condition": "Clear", "precipitation": 0, "icon": Icons.wb_sunny},
    {"day": "Sun", "high": 73, "low": 59, "condition": "Partly Cloudy", "precipitation": 15, "icon": Icons.wb_cloudy},
  ];

  @override
  Widget build(BuildContext context) {
    var selectedDestData = topDestinations.firstWhere(
      (dest) => dest["name"] == selectedDestination,
      orElse: () => topDestinations[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Destination Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              si("Add destination to favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Share destination weather");
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Destinations",
                    value: searchQuery,
                    hint: "Enter city, country, or region",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    si("Searching for destination weather");
                  },
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    Image.network(
                      "${selectedDestData["image"]}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(150),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${selectedDestData["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      selectedDestData["icon"] as IconData,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${selectedDestData["temperature"]}°F - ${selectedDestData["condition"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${selectedDestData["rating"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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
              ),
            ),

            Text(
              "Current Weather Details",
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
                _buildWeatherCard("Temperature", "${selectedDestData["temperature"]}°F", Icons.thermostat, primaryColor),
                _buildWeatherCard("Humidity", "${selectedDestData["humidity"]}%", Icons.water_drop, infoColor),
                _buildWeatherCard("Wind Speed", "${selectedDestData["windSpeed"]} mph", Icons.air, successColor),
                _buildWeatherCard("Rain Chance", "${selectedDestData["precipitation"]}%", Icons.umbrella, warningColor),
                _buildWeatherCard("UV Index", "${selectedDestData["uvIndex"]}/10", Icons.wb_sunny, dangerColor),
                _buildWeatherCard("Visibility", "${selectedDestData["visibility"]} km", Icons.visibility, infoColor),
              ],
            ),

            Text(
              "7-Day Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: weeklyForecast.map((day) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Icon(
                        day["icon"] as IconData,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${day["high"]}°",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${day["low"]}°",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${day["precipitation"]}%",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...topDestinations.map((destination) {
              return GestureDetector(
                onTap: () {
                  selectedDestination = destination["name"];
                  setState(() {});
                  ss("Selected ${destination["name"]}");
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: selectedDestination == destination["name"] ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: selectedDestination == destination["name"]
                        ? Border.all(color: primaryColor)
                        : null,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${destination["image"]}",
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${destination["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  destination["icon"] as IconData,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${destination["temperature"]}°F - ${destination["condition"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Timezone: ${destination["timezone"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${destination["rating"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sun Times (${selectedDestData["timezone"]})",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Sunrise: ${selectedDestData["sunrise"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Sunset: ${selectedDestData["sunset"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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

            QButton(
              label: "Get Weather Alerts",
              size: bs.md,
              onPressed: () {
                si("Setting up weather alerts for ${selectedDestData["name"]}");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

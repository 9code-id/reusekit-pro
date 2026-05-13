import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather8View extends StatefulWidget {
  @override
  State<GrlWeather8View> createState() => _GrlWeather8ViewState();
}

class _GrlWeather8ViewState extends State<GrlWeather8View> {
  String selectedCity = "Paris";
  String selectedUnit = "°C";
  int selectedForecastDays = 7;
  
  Map<String, dynamic> weatherData = {
    "location": "Paris, France",
    "currentTemp": 23,
    "condition": "Partly Cloudy",
    "icon": Icons.wb_cloudy,
    "feelsLike": 25,
    "humidity": 65,
    "windSpeed": 15,
    "windDirection": "NW",
    "pressure": 1018,
    "uvIndex": 5,
    "visibility": 10,
    "dewPoint": 17,
    "sunrise": "6:42 AM",
    "sunset": "8:15 PM",
    "airQuality": {
      "aqi": 42,
      "status": "Good",
      "pm25": 15,
      "pm10": 22,
      "o3": 48,
      "no2": 18,
    },
    "alerts": [
      {
        "type": "Heat Advisory",
        "severity": "Medium",
        "description": "High temperatures expected this weekend",
        "color": Colors.orange,
        "icon": Icons.warning_amber,
      }
    ]
  };

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "Now", "temp": 23, "icon": Icons.wb_cloudy, "rain": 20, "wind": 15},
    {"time": "2 PM", "temp": 25, "icon": Icons.wb_sunny, "rain": 5, "wind": 12},
    {"time": "3 PM", "temp": 27, "icon": Icons.wb_sunny, "rain": 0, "wind": 10},
    {"time": "4 PM", "temp": 26, "icon": Icons.wb_cloudy, "rain": 15, "wind": 14},
    {"time": "5 PM", "temp": 24, "icon": Icons.grain, "rain": 65, "wind": 18},
    {"time": "6 PM", "temp": 22, "icon": Icons.grain, "rain": 75, "wind": 20},
    {"time": "7 PM", "temp": 21, "icon": Icons.wb_cloudy, "rain": 40, "wind": 16},
    {"time": "8 PM", "temp": 20, "icon": Icons.nightlight_round, "rain": 10, "wind": 12},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {"day": "Today", "date": "Jun 22", "high": 27, "low": 18, "icon": Icons.wb_cloudy, "rain": 40, "humidity": 65, "wind": 15},
    {"day": "Tomorrow", "date": "Jun 23", "high": 30, "low": 20, "icon": Icons.wb_sunny, "rain": 10, "humidity": 58, "wind": 12},
    {"day": "Wednesday", "date": "Jun 24", "high": 32, "low": 22, "icon": Icons.wb_sunny, "rain": 5, "humidity": 52, "wind": 8},
    {"day": "Thursday", "date": "Jun 25", "high": 24, "low": 16, "icon": Icons.grain, "rain": 80, "humidity": 78, "wind": 22},
    {"day": "Friday", "date": "Jun 26", "high": 26, "low": 18, "icon": Icons.wb_cloudy, "rain": 25, "humidity": 68, "wind": 14},
    {"day": "Saturday", "date": "Jun 27", "high": 29, "low": 21, "icon": Icons.wb_sunny, "rain": 0, "humidity": 55, "wind": 10},
    {"day": "Sunday", "date": "Jun 28", "high": 31, "low": 23, "icon": Icons.wb_sunny, "rain": 5, "humidity": 50, "wind": 9},
  ];

  List<Map<String, dynamic>> cities = [
    {"name": "Paris", "country": "France", "temp": 23, "condition": "Partly Cloudy"},
    {"name": "London", "country": "United Kingdom", "temp": 19, "condition": "Rainy"},
    {"name": "Rome", "country": "Italy", "temp": 28, "condition": "Sunny"},
    {"name": "Berlin", "country": "Germany", "temp": 21, "condition": "Cloudy"},
    {"name": "Madrid", "country": "Spain", "temp": 31, "condition": "Hot"},
  ];

  String searchQuery = "";
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMainWeatherCard(),
                  _buildQuickActions(),
                  _buildHourlyForecast(),
                  _buildDailyForecast(),
                  _buildWeatherDetails(),
                  _buildAirQuality(),
                  _buildWeatherAlerts(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(220),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (!showSearch) ...[
              Row(
                children: [
                  GestureDetector(
                    onTap: _showLocationPicker,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${weatherData["location"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showSearch = true;
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
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
                ],
              ),
            ] else ...[
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showSearch = false;
                        searchQuery = "";
                      });
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white.withAlpha(200),
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Search for a city...",
                                hintStyle: TextStyle(color: Colors.white.withAlpha(200)),
                                border: InputBorder.none,
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
                ],
              ),
            ],
            if (showSearch && searchQuery.isNotEmpty) ...[
              SizedBox(height: spSm),
              _buildSearchResults(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final filteredCities = cities.where((city) =>
        city["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        city["country"].toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: ListView.builder(
        itemCount: filteredCities.length,
        itemBuilder: (context, index) {
          final city = filteredCities[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCity = city["name"];
                showSearch = false;
                searchQuery = "";
              });
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white.withAlpha(200),
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${city["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${city["country"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${city["temp"]}°",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainWeatherCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor.withAlpha(220),
            primaryColor.withAlpha(150),
            primaryColor.withAlpha(80),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(
            weatherData["icon"] as IconData,
            size: 120,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "${weatherData["currentTemp"]}$selectedUnit",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          Text(
            "${weatherData["condition"]}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white.withAlpha(240),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Feels like ${weatherData["feelsLike"]}$selectedUnit",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherStat("Humidity", "${weatherData["humidity"]}%", Icons.water_drop),
              _buildWeatherStat("Wind", "${weatherData["windSpeed"]} km/h", Icons.air),
              _buildWeatherStat("UV Index", "${weatherData["uvIndex"]}", Icons.wb_sunny),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value, IconData icon) {
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

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionButton("Radar", Icons.radar, () {}),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildQuickActionButton("Maps", Icons.map, () {}),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildQuickActionButton("Alerts", Icons.notifications, () {}),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildQuickActionButton("Settings", Icons.settings, () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyForecast() {
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
              itemCount: hourlyForecast.length,
              itemBuilder: (context, index) {
                final hour = hourlyForecast[index];
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
                        size: 24,
                      ),
                      Text(
                        "${hour["temp"]}°",
                        style: TextStyle(
                          fontSize: 16,
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecast() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "$selectedForecastDays-Day Forecast",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _showForecastOptions,
                child: Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...dailyForecast.take(selectedForecastDays).map((day) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${day["day"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                              "${day["rain"]}%",
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
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      SizedBox(width: 104),
                      _buildDayDetailItem("Humidity", "${day["humidity"]}%", Icons.water_drop),
                      SizedBox(width: spMd),
                      _buildDayDetailItem("Wind", "${day["wind"]} km/h", Icons.air),
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

  Widget _buildDayDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 12,
        ),
        SizedBox(width: 4),
        Text(
          "$label $value",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetails() {
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
              _buildDetailCard("Pressure", "${weatherData["pressure"]} hPa", Icons.speed, Colors.blue),
              _buildDetailCard("Visibility", "${weatherData["visibility"]} km", Icons.visibility, Colors.purple),
              _buildDetailCard("Dew Point", "${weatherData["dewPoint"]}°C", Icons.water_drop, Colors.cyan),
              _buildDetailCard("Wind Direction", "${weatherData["windDirection"]}", Icons.navigation, Colors.green),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSunCard("Sunrise", "${weatherData["sunrise"]}", Icons.wb_sunny, Colors.orange),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSunCard("Sunset", "${weatherData["sunset"]}", Icons.nightlight_round, Colors.indigo),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
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
                color: color,
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
          SizedBox(height: spSm),
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

  Widget _buildSunCard(String title, String time, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirQuality() {
    final airQuality = weatherData["airQuality"];
    Color aqiColor = successColor;
    if (airQuality["aqi"] > 100) aqiColor = warningColor;
    if (airQuality["aqi"] > 150) aqiColor = dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Air Quality",
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: aqiColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.eco,
                        color: aqiColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${airQuality["status"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: aqiColor,
                            ),
                          ),
                          Text(
                            "AQI ${airQuality["aqi"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    _buildAirQualityItem("PM2.5", "${airQuality["pm25"]}", "μg/m³"),
                    _buildAirQualityItem("PM10", "${airQuality["pm10"]}", "μg/m³"),
                    _buildAirQualityItem("O₃", "${airQuality["o3"]}", "μg/m³"),
                    _buildAirQualityItem("NO₂", "${airQuality["no2"]}", "μg/m³"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirQualityItem(String name, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: spXs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 2),
            Text(
              unit,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherAlerts() {
    final alerts = weatherData["alerts"] as List;
    if (alerts.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
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
          SizedBox(height: spSm),
          ...alerts.map((alert) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: alert["color"] as Color,
                  ),
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    alert["icon"] as IconData,
                    color: alert["color"] as Color,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${alert["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${alert["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (alert["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${alert["severity"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: alert["color"] as Color,
                      ),
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

  void _showLocationPicker() {
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
              ...cities.map((city) {
                final isSelected = city["name"] == selectedCity;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCity = city["name"];
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
                                "${city["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${city["country"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${city["temp"]}°",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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

  void _showForecastOptions() {
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
                "Forecast Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...[3, 5, 7, 10].map((days) {
                final isSelected = days == selectedForecastDays;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedForecastDays = days;
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
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$days-Day Forecast",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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

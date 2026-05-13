import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather5View extends StatefulWidget {
  @override
  State<GrlWeather5View> createState() => _GrlWeather5ViewState();
}

class _GrlWeather5ViewState extends State<GrlWeather5View> {
  int currentTab = 0;
  String selectedLocation = "San Francisco";
  
  List<Map<String, dynamic>> locations = [
    {
      "name": "San Francisco",
      "temp": 18,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "color": Colors.blue,
    },
    {
      "name": "Los Angeles",
      "temp": 25,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "color": Colors.orange,
    },
    {
      "name": "Seattle",
      "temp": 12,
      "condition": "Rainy",
      "icon": Icons.grain,
      "color": Colors.grey,
    },
    {
      "name": "Miami",
      "temp": 30,
      "condition": "Hot",
      "icon": Icons.wb_sunny,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> todayWeather = [
    {"time": "6 AM", "temp": 15, "icon": Icons.nightlight_round, "condition": "Clear"},
    {"time": "9 AM", "temp": 17, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"time": "12 PM", "temp": 20, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"time": "3 PM", "temp": 18, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"time": "6 PM", "temp": 16, "icon": Icons.grain, "condition": "Light Rain"},
    {"time": "9 PM", "temp": 14, "icon": Icons.nightlight_round, "condition": "Clear"},
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "date": "22", "highTemp": 20, "lowTemp": 14, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"day": "Tue", "date": "23", "highTemp": 18, "lowTemp": 12, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"day": "Wed", "date": "24", "highTemp": 22, "lowTemp": 16, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"day": "Thu", "date": "25", "highTemp": 16, "lowTemp": 10, "icon": Icons.grain, "condition": "Rainy"},
    {"day": "Fri", "date": "26", "highTemp": 19, "lowTemp": 13, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"day": "Sat", "date": "27", "highTemp": 24, "lowTemp": 18, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"day": "Sun", "date": "28", "highTemp": 21, "lowTemp": 15, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
  ];

  List<Map<String, dynamic>> weatherDetails = [
    {"title": "UV Index", "value": "6", "unit": "High", "icon": Icons.wb_sunny, "color": Colors.orange},
    {"title": "Wind", "value": "15", "unit": "km/h", "icon": Icons.air, "color": Colors.blue},
    {"title": "Humidity", "value": "68", "unit": "%", "icon": Icons.water_drop, "color": Colors.cyan},
    {"title": "Pressure", "value": "1013", "unit": "hPa", "icon": Icons.speed, "color": Colors.green},
    {"title": "Visibility", "value": "10", "unit": "km", "icon": Icons.visibility, "color": Colors.purple},
    {"title": "Feels Like", "value": "20", "unit": "°C", "icon": Icons.thermostat, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Weather Forecast",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Weekly", icon: Icon(Icons.calendar_month)),
        Tab(text: "Details", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildWeeklyTab(),
        _buildDetailsTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationSelector(),
          SizedBox(height: spLg),
          _buildCurrentWeatherCard(),
          SizedBox(height: spMd),
          _buildHourlyForecastSection(),
          SizedBox(height: spMd),
          _buildQuickStatsGrid(),
        ],
      ),
    );
  }

  Widget _buildWeeklyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7-Day Forecast",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...weeklyForecast.map((forecast) => _buildWeeklyForecastCard(forecast)).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Details",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: weatherDetails.map((detail) => _buildDetailCard(detail)).toList(),
          ),
          SizedBox(height: spMd),
          _buildAirQualityCard(),
          SizedBox(height: spMd),
          _buildSunriseSunsetCard(),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedLocation,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Current Location",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showLocationOptions,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    final currentLocation = locations.firstWhere((loc) => loc["name"] == selectedLocation);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            currentLocation["color"] as Color,
            (currentLocation["color"] as Color).withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Icon(
            currentLocation["icon"] as IconData,
            size: 80,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "${currentLocation["temp"]}°",
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Text(
            "${currentLocation["condition"]}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withAlpha(230),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherStat("High", "${(currentLocation["temp"] as int) + 3}°"),
              _buildWeatherStat("Low", "${(currentLocation["temp"] as int) - 5}°"),
              _buildWeatherStat("Humidity", "68%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
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

  Widget _buildHourlyForecastSection() {
    return Column(
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
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todayWeather.length,
            itemBuilder: (context, index) {
              final weather = todayWeather[index];
              return Container(
                width: 80,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${weather["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      weather["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                    Text(
                      "${weather["temp"]}°",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${weather["condition"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Stats",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 140,
          children: [
            _buildQuickStatCard("Wind Speed", "15 km/h", Icons.air, Colors.blue),
            _buildQuickStatCard("UV Index", "6 High", Icons.wb_sunny, Colors.orange),
            _buildQuickStatCard("Pressure", "1013 hPa", Icons.speed, Colors.green),
            _buildQuickStatCard("Visibility", "10 km", Icons.visibility, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStatCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyForecastCard(Map<String, dynamic> forecast) {
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
            width: 50,
            child: Column(
              children: [
                Text(
                  "${forecast["day"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${forecast["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            forecast["icon"] as IconData,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${forecast["condition"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "${forecast["lowTemp"]}°",
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
                    colors: [disabledColor, primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${forecast["highTemp"]}°",
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
  }

  Widget _buildDetailCard(Map<String, dynamic> detail) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (detail["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  detail["icon"] as IconData,
                  color: detail["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${detail["title"]}",
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${detail["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${detail["unit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAirQualityCard() {
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
                Icons.eco,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Air Quality",
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
              Text(
                "Good",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "AQI 45",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Air quality is good. Perfect for outdoor activities.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunriseSunsetCard() {
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
          Text(
            "Sun & Moon",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color: Colors.orange,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Sunrise",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "6:42 AM",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.nightlight_round,
                          color: Colors.indigo,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Sunset",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "7:28 PM",
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
        ],
      ),
    );
  }

  void _showLocationOptions() {
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
              ...locations.map((location) {
                final isSelected = location["name"] == selectedLocation;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLocation = location["name"];
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
                          location["icon"] as IconData,
                          color: location["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${location["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${location["temp"]}°",
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
}

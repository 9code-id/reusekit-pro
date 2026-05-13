import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather7View extends StatefulWidget {
  @override
  State<GrlWeather7View> createState() => _GrlWeather7ViewState();
}

class _GrlWeather7ViewState extends State<GrlWeather7View> {
  int currentIndex = 0;
  
  List<Map<String, dynamic>> weatherData = [
    {
      "location": "San Francisco",
      "country": "USA",
      "temp": 22,
      "condition": "Foggy",
      "icon": Icons.foggy,
      "color": Colors.grey,
      "gradient": [Colors.grey.shade400, Colors.grey.shade600],
    },
    {
      "location": "New York",
      "country": "USA", 
      "temp": 28,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "color": Colors.orange,
      "gradient": [Colors.orange.shade300, Colors.orange.shade600],
    },
    {
      "location": "London",
      "country": "UK",
      "temp": 15,
      "condition": "Rainy",
      "icon": Icons.grain,
      "color": Colors.blue,
      "gradient": [Colors.blue.shade300, Colors.blue.shade600],
    },
    {
      "location": "Tokyo",
      "country": "Japan",
      "temp": 31,
      "condition": "Hot",
      "icon": Icons.wb_sunny,
      "color": Colors.red,
      "gradient": [Colors.red.shade300, Colors.red.shade600],
    },
    {
      "location": "Sydney",
      "country": "Australia",
      "temp": 19,
      "condition": "Cloudy",
      "icon": Icons.wb_cloudy,
      "color": Colors.blueGrey,
      "gradient": [Colors.blueGrey.shade300, Colors.blueGrey.shade600],
    },
  ];

  List<Map<String, dynamic>> weeklyForecast = [
    {"day": "Mon", "high": 25, "low": 18, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"day": "Tue", "high": 23, "low": 16, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"day": "Wed", "high": 20, "low": 14, "icon": Icons.grain, "condition": "Rainy"},
    {"day": "Thu", "high": 22, "low": 15, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"day": "Fri", "high": 26, "low": 19, "icon": Icons.wb_sunny, "condition": "Sunny"},
    {"day": "Sat", "high": 24, "low": 17, "icon": Icons.wb_cloudy, "condition": "Cloudy"},
    {"day": "Sun", "high": 21, "low": 14, "icon": Icons.grain, "condition": "Rainy"},
  ];

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "12 PM", "temp": 22, "icon": Icons.foggy},
    {"time": "1 PM", "temp": 23, "icon": Icons.wb_cloudy},
    {"time": "2 PM", "temp": 25, "icon": Icons.wb_sunny},
    {"time": "3 PM", "temp": 24, "icon": Icons.wb_cloudy},
    {"time": "4 PM", "temp": 22, "icon": Icons.foggy},
    {"time": "5 PM", "temp": 21, "icon": Icons.foggy},
  ];

  Map<String, dynamic> currentDetails = {
    "feelsLike": 24,
    "humidity": 78,
    "windSpeed": 12,
    "pressure": 1016,
    "uvIndex": 4,
    "visibility": 8,
    "dewPoint": 18,
    "airQuality": "Good",
    "sunrise": "6:35 AM",
    "sunset": "7:45 PM",
  };

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Weather",
      selectedIndex: currentIndex,
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
          icon: Icon(Icons.map),
          label: "Radar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildLocationsTab(),
        _buildRadarTab(),
        _buildSettingsTab(),
      ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  Widget _buildHomeTab() {
    final currentWeather = weatherData[0];
    
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMainWeatherCard(currentWeather),
          _buildHourlyForecastSection(),
          _buildWeeklyForecastSection(),
          _buildWeatherDetailsGrid(),
          _buildAdditionalInfo(),
        ],
      ),
    );
  }

  Widget _buildMainWeatherCard(Map<String, dynamic> weather) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: weather["gradient"] as List<Color>,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "${weather["location"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${weather["country"]}",
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  weather["icon"] as IconData,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "${weather["temp"]}°",
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${weather["condition"]}",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Feels like ${currentDetails["feelsLike"]}°",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherQuickStat("Humidity", "${currentDetails["humidity"]}%"),
                _buildWeatherQuickStat("Wind", "${currentDetails["windSpeed"]} km/h"),
                _buildWeatherQuickStat("Pressure", "${currentDetails["pressure"]} hPa"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherQuickStat(String label, String value) {
    return Column(
      children: [
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

  Widget _buildHourlyForecastSection() {
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
            children: hourlyForecast.map((hour) {
              return Container(
                width: 70,
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

  Widget _buildWeeklyForecastSection() {
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
          ...weeklyForecast.map((day) {
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
                    width: 40,
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${day["condition"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
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
                        colors: [disabledColor, primaryColor],
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid() {
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
            minItemWidth: 140,
            children: [
              _buildDetailCard("UV Index", "${currentDetails["uvIndex"]}", "Moderate", Icons.wb_sunny, Colors.orange),
              _buildDetailCard("Visibility", "${currentDetails["visibility"]}", "km", Icons.visibility, Colors.purple),
              _buildDetailCard("Dew Point", "${currentDetails["dewPoint"]}", "°C", Icons.water_drop, Colors.cyan),
              _buildDetailCard("Air Quality", "${currentDetails["airQuality"]}", "", Icons.eco, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, String unit, IconData icon, Color color) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (unit.isNotEmpty) ...[
                SizedBox(width: spXs),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSunInfoCard("Sunrise", "${currentDetails["sunrise"]}", Icons.wb_sunny, Colors.orange),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSunInfoCard("Sunset", "${currentDetails["sunset"]}", Icons.nightlight_round, Colors.indigo),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSunInfoCard(String title, String time, IconData icon, Color color) {
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
            size: 24,
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

  Widget _buildLocationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "My Locations",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...weatherData.map((location) {
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
                        Text(
                          "${location["location"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        location["icon"] as IconData,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${location["temp"]}°",
                        style: TextStyle(
                          fontSize: 24,
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
                  Icons.map,
                  size: 60,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Weather Radar Map",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Interactive radar coming soon",
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
              Expanded(
                child: _buildRadarControl("Precipitation", Icons.grain, infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildRadarControl("Temperature", Icons.thermostat, Colors.red),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildRadarControl("Wind Speed", Icons.air, Colors.blue),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildRadarControl("Cloud Cover", Icons.cloud, Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadarControl(String title, IconData icon, Color color) {
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
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSettingsSection("Units", [
            {"title": "Temperature", "value": "Celsius (°C)", "icon": Icons.thermostat},
            {"title": "Wind Speed", "value": "km/h", "icon": Icons.air},
            {"title": "Pressure", "value": "hPa", "icon": Icons.speed},
            {"title": "Distance", "value": "Kilometers", "icon": Icons.straighten},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("Notifications", [
            {"title": "Weather Alerts", "value": "Enabled", "icon": Icons.notifications},
            {"title": "Daily Forecast", "value": "8:00 AM", "icon": Icons.schedule},
            {"title": "Severe Weather", "value": "Enabled", "icon": Icons.warning},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("Appearance", [
            {"title": "Theme", "value": "System Default", "icon": Icons.palette},
            {"title": "Background", "value": "Dynamic", "icon": Icons.wallpaper},
            {"title": "Animations", "value": "Enabled", "icon": Icons.animation},
          ]),
          SizedBox(height: spMd),
          _buildSettingsSection("About", [
            {"title": "Version", "value": "2.1.0", "icon": Icons.info},
            {"title": "Data Source", "value": "OpenWeather", "icon": Icons.cloud},
            {"title": "Privacy Policy", "value": "", "icon": Icons.privacy_tip},
            {"title": "Terms of Service", "value": "", "icon": Icons.description},
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

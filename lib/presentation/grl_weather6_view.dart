import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather6View extends StatefulWidget {
  @override
  State<GrlWeather6View> createState() => _GrlWeather6ViewState();
}

class _GrlWeather6ViewState extends State<GrlWeather6View> {
  String currentLocation = "New York";
  String selectedTimeRange = "Today";
  
  Map<String, dynamic> currentWeather = {
    "temp": 24,
    "condition": "Partly Cloudy",
    "icon": Icons.wb_cloudy,
    "humidity": 62,
    "windSpeed": 18,
    "pressure": 1015,
    "uvIndex": 7,
    "visibility": 12,
    "feelsLike": 26,
    "dewPoint": 16,
    "cloudCover": 45,
    "moonPhase": "Waxing Crescent",
  };

  List<Map<String, dynamic>> hourlyData = [
    {"time": "Now", "temp": 24, "icon": Icons.wb_cloudy, "precipitation": 10},
    {"time": "1 PM", "temp": 26, "icon": Icons.wb_sunny, "precipitation": 0},
    {"time": "2 PM", "temp": 28, "icon": Icons.wb_sunny, "precipitation": 5},
    {"time": "3 PM", "temp": 27, "icon": Icons.wb_cloudy, "precipitation": 15},
    {"time": "4 PM", "temp": 25, "icon": Icons.grain, "precipitation": 70},
    {"time": "5 PM", "temp": 23, "icon": Icons.grain, "precipitation": 85},
    {"time": "6 PM", "temp": 22, "icon": Icons.wb_cloudy, "precipitation": 30},
    {"time": "7 PM", "temp": 20, "icon": Icons.nightlight_round, "precipitation": 5},
  ];

  List<Map<String, dynamic>> dailyForecast = [
    {"day": "Today", "date": "Jun 22", "high": 28, "low": 18, "icon": Icons.wb_cloudy, "precipitation": 40, "description": "Partly cloudy with afternoon showers"},
    {"day": "Tomorrow", "date": "Jun 23", "high": 31, "low": 21, "icon": Icons.wb_sunny, "precipitation": 10, "description": "Mostly sunny and warm"},
    {"day": "Thursday", "date": "Jun 24", "high": 26, "low": 16, "icon": Icons.grain, "precipitation": 80, "description": "Heavy rain expected"},
    {"day": "Friday", "date": "Jun 25", "high": 24, "low": 14, "icon": Icons.wb_cloudy, "precipitation": 20, "description": "Cloudy with light winds"},
    {"day": "Saturday", "date": "Jun 26", "high": 29, "low": 19, "icon": Icons.wb_sunny, "precipitation": 5, "description": "Clear and sunny"},
    {"day": "Sunday", "date": "Jun 27", "high": 32, "low": 22, "icon": Icons.wb_sunny, "precipitation": 0, "description": "Hot and sunny"},
    {"day": "Monday", "date": "Jun 28", "high": 27, "low": 17, "icon": Icons.wb_cloudy, "precipitation": 30, "description": "Partly cloudy"},
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "Heat Advisory",
      "severity": "Moderate",
      "icon": Icons.warning,
      "color": Colors.orange,
      "message": "High temperatures expected this weekend. Stay hydrated and avoid prolonged sun exposure.",
      "validUntil": "Jun 28, 6:00 PM"
    },
    {
      "type": "Rain Warning",
      "severity": "Low",
      "icon": Icons.info,
      "color": Colors.blue,
      "message": "Scattered showers possible Thursday afternoon. Carry an umbrella.",
      "validUntil": "Jun 24, 11:59 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCurrentWeatherSection(),
            _buildTimeRangeSelector(),
            if (selectedTimeRange == "Today") _buildHourlySection(),
            if (selectedTimeRange == "7 Days") _buildDailySection(),
            _buildDetailedMetrics(),
            _buildWeatherAlerts(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
                      currentLocation,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Updated just now",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor.withAlpha(200),
            primaryColor.withAlpha(100),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(
            currentWeather["icon"] as IconData,
            size: 100,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "${currentWeather["temp"]}°",
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          Text(
            "${currentWeather["condition"]}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withAlpha(230),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCurrentWeatherStat("Feels like", "${currentWeather["feelsLike"]}°"),
              _buildCurrentWeatherStat("Humidity", "${currentWeather["humidity"]}%"),
              _buildCurrentWeatherStat("Wind", "${currentWeather["windSpeed"]} km/h"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherStat(String label, String value) {
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

  Widget _buildTimeRangeSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Expanded(
            child: QCategoryPicker(
              items: [
                {"label": "Today", "value": "Today"},
                {"label": "7 Days", "value": "7 Days"},
              ],
              value: selectedTimeRange,
              onChanged: (index, label, value, item) {
                setState(() {
                  selectedTimeRange = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlySection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
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
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final hour = hourlyData[index];
                final isNow = hour["time"] == "Now";
                
                return Container(
                  width: 90,
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
                            size: 12,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${hour["precipitation"]}%",
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

  Widget _buildDailySection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
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
          ...dailyForecast.map((day) => _buildDailyForecastCard(day)).toList(),
        ],
      ),
    );
  }

  Widget _buildDailyForecastCard(Map<String, dynamic> day) {
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
                width: 70,
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
              SizedBox(width: spSm),
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
                      size: 14,
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
                    width: 50,
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
              SizedBox(width: 94),
              Expanded(
                child: Text(
                  "${day["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Metrics",
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
              _buildMetricCard("UV Index", "${currentWeather["uvIndex"]}", "High", Icons.wb_sunny, Colors.orange),
              _buildMetricCard("Pressure", "${currentWeather["pressure"]}", "hPa", Icons.speed, Colors.blue),
              _buildMetricCard("Visibility", "${currentWeather["visibility"]}", "km", Icons.visibility, Colors.purple),
              _buildMetricCard("Dew Point", "${currentWeather["dewPoint"]}", "°C", Icons.water_drop, Colors.cyan),
              _buildMetricCard("Cloud Cover", "${currentWeather["cloudCover"]}", "%", Icons.cloud, Colors.grey),
              _buildMetricCard("Moon Phase", "${currentWeather["moonPhase"]}", "", Icons.nightlight_round, Colors.indigo),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String unit, IconData icon, Color color) {
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
          SizedBox(height: spSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
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

  Widget _buildWeatherAlerts() {
    if (weatherAlerts.isEmpty) return SizedBox.shrink();
    
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
          ...weatherAlerts.map((alert) => _buildAlertCard(alert)).toList(),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                alert["icon"] as IconData,
                color: alert["color"] as Color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${alert["type"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
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
          SizedBox(height: spXs),
          Text(
            "${alert["message"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Valid until: ${alert["validUntil"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

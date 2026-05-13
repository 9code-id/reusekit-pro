import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHomeView extends StatefulWidget {
  const WcaHomeView({super.key});

  @override
  State<WcaHomeView> createState() => _WcaHomeViewState();
}

class _WcaHomeViewState extends State<WcaHomeView> {
  String selectedLocation = "New York, NY";
  bool isLoading = false;

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Current Weather",
      "subtitle": "Real-time conditions",
      "icon": Icons.wb_sunny,
      "color": Colors.orange,
    },
    {
      "title": "Hourly Forecast",
      "subtitle": "Next 24 hours",
      "icon": Icons.schedule,
      "color": Colors.blue,
    },
    {
      "title": "Daily Forecast",
      "subtitle": "7-day outlook",
      "icon": Icons.calendar_today,
      "color": Colors.green,
    },
    {
      "title": "Weather Maps",
      "subtitle": "Radar & satellite",
      "icon": Icons.map,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> savedLocations = [
    {
      "name": "New York, NY",
      "temperature": 22,
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "isCurrentLocation": true,
    },
    {
      "name": "Los Angeles, CA",
      "temperature": 28,
      "condition": "Clear",
      "icon": Icons.wb_sunny,
      "isCurrentLocation": false,
    },
    {
      "name": "Chicago, IL",
      "temperature": 18,
      "condition": "Cloudy",
      "icon": Icons.cloud,
      "isCurrentLocation": false,
    },
    {
      "name": "Miami, FL",
      "temperature": 32,
      "condition": "Partly Cloudy",
      "icon": Icons.wb_cloudy,
      "isCurrentLocation": false,
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "Severe Weather",
      "message": "Thunderstorm warning for your area",
      "urgency": "High",
      "icon": Icons.flash_on,
      "color": Colors.red,
      "time": "2 hours ago",
    },
    {
      "type": "Rain Alert",
      "message": "Light rain expected in 30 minutes",
      "urgency": "Medium",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "time": "15 minutes ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Central"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {
              si("Weather notifications");
            },
          ),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Weather settings");
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isLoading = true;
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          isLoading = false;
          setState(() {});
          ss("Weather data refreshed");
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor.withAlpha(180),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            selectedLocation,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            si("Change location");
                          },
                          child: Icon(
                            Icons.edit_location,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "22°C",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Sunny",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "Feels like 25°C",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(180),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            Icons.wb_sunny,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildWeatherDetail("Humidity", "65%", Icons.water_drop),
                        ),
                        Expanded(
                          child: _buildWeatherDetail("Wind", "12 km/h", Icons.air),
                        ),
                        Expanded(
                          child: _buildWeatherDetail("UV Index", "8", Icons.wb_sunny_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (weatherAlerts.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Weather Alerts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spSm,
                        children: weatherAlerts.map((alert) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (alert["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: (alert["color"] as Color).withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  alert["icon"],
                                  color: alert["color"],
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
                                          color: alert["color"],
                                        ),
                                      ),
                                      Text(
                                        "${alert["message"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${alert["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.flash_on,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: quickActions.map((action) {
                        return GestureDetector(
                          onTap: () {
                            si("Navigate to ${action["title"]}");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (action["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: (action["color"] as Color).withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  action["icon"],
                                  size: 32,
                                  color: action["color"],
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${action["title"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${action["subtitle"]}",
                                  textAlign: TextAlign.center,
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Saved Locations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            si("Manage locations");
                          },
                          child: Text(
                            "Manage",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: spSm,
                      children: savedLocations.map((location) {
                        return GestureDetector(
                          onTap: () {
                            selectedLocation = location["name"];
                            setState(() {});
                            si("Selected ${location["name"]}");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: location["isCurrentLocation"] ? primaryColor.withAlpha(20) : Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: location["isCurrentLocation"] ? primaryColor : disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  location["icon"],
                                  color: location["isCurrentLocation"] ? primaryColor : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${location["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (location["isCurrentLocation"]) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.my_location,
                                              size: 12,
                                              color: primaryColor,
                                            ),
                                          ],
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
                                Text(
                                  "${location["temperature"]}°C",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white.withAlpha(180),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(160),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

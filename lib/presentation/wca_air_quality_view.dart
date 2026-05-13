import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAirQualityView extends StatefulWidget {
  const WcaAirQualityView({super.key});

  @override
  State<WcaAirQualityView> createState() => _WcaAirQualityViewState();
}

class _WcaAirQualityViewState extends State<WcaAirQualityView> {
  int selectedLocationIndex = 0;
  String selectedPeriod = "today";
  bool showHealthTips = true;
  bool enableNotifications = true;

  List<Map<String, dynamic>> locations = [
    {
      "name": "New York City",
      "aqi": 85,
      "status": "Moderate",
      "color": Colors.orange,
      "pm25": 35.2,
      "pm10": 42.8,
      "o3": 0.068,
      "no2": 0.032,
      "so2": 0.015,
      "co": 0.8,
    },
    {
      "name": "Los Angeles",
      "aqi": 125,
      "status": "Unhealthy for Sensitive Groups",
      "color": Colors.red,
      "pm25": 55.8,
      "pm10": 68.2,
      "o3": 0.095,
      "no2": 0.048,
      "so2": 0.022,
      "co": 1.2,
    },
    {
      "name": "Denver",
      "aqi": 45,
      "status": "Good",
      "color": Colors.green,
      "pm25": 12.5,
      "pm10": 18.9,
      "o3": 0.042,
      "no2": 0.018,
      "so2": 0.008,
      "co": 0.4,
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"hour": "9 AM", "aqi": 78, "status": "Moderate"},
    {"hour": "10 AM", "aqi": 82, "status": "Moderate"},
    {"hour": "11 AM", "aqi": 85, "status": "Moderate"},
    {"hour": "12 PM", "aqi": 89, "status": "Moderate"},
    {"hour": "1 PM", "aqi": 95, "status": "Moderate"},
    {"hour": "2 PM", "aqi": 92, "status": "Moderate"},
    {"hour": "3 PM", "aqi": 88, "status": "Moderate"},
    {"hour": "4 PM", "aqi": 86, "status": "Moderate"},
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "icon": Icons.masks,
      "title": "Wear a Mask",
      "description": "Consider wearing an N95 mask when outdoors during moderate to unhealthy air quality days.",
    },
    {
      "icon": Icons.home,
      "title": "Stay Indoors",
      "description": "Limit outdoor activities, especially for sensitive individuals like children and elderly.",
    },
    {
      "icon": Icons.air,
      "title": "Air Purifier",
      "description": "Use an air purifier indoors to maintain clean air quality in your living space.",
    },
    {
      "icon": Icons.directions_run,
      "title": "Exercise Timing",
      "description": "Schedule outdoor exercise during early morning hours when air quality is typically better.",
    },
  ];

  List<Map<String, dynamic>> pollutantInfo = [
    {
      "name": "PM2.5",
      "description": "Fine Particulate Matter",
      "unit": "μg/m³",
      "healthRisk": "High",
      "sources": "Vehicle emissions, industrial processes, wildfires",
    },
    {
      "name": "PM10",
      "description": "Coarse Particulate Matter",
      "unit": "μg/m³",
      "healthRisk": "Moderate",
      "sources": "Dust, pollen, construction activities",
    },
    {
      "name": "O₃",
      "description": "Ground-level Ozone",
      "unit": "ppm",
      "healthRisk": "Moderate",
      "sources": "Vehicle emissions, industrial processes",
    },
    {
      "name": "NO₂",
      "description": "Nitrogen Dioxide",
      "unit": "ppm",
      "healthRisk": "Low",
      "sources": "Vehicle emissions, power plants",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = locations[selectedLocationIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Air Quality"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotificationSettings();
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showPollutantInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Location Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select Location",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: List.generate(locations.length, (index) {
                      final location = locations[index];
                      final isSelected = index == selectedLocationIndex;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedLocationIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          width: 160,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(25) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${location["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "AQI: ${location["aqi"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: location["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${location["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Current AQI Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (currentLocation["color"] as Color).withAlpha(25),
                    (currentLocation["color"] as Color).withAlpha(10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: currentLocation["color"] as Color),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "${currentLocation["name"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (currentLocation["color"] as Color).withAlpha(25),
                      border: Border.all(
                        color: currentLocation["color"] as Color,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentLocation["aqi"]}",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: currentLocation["color"] as Color,
                          ),
                        ),
                        Text(
                          "AQI",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: currentLocation["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${currentLocation["status"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentLocation["color"] as Color,
                    ),
                  ),
                  Text(
                    "Last updated: 2 minutes ago",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Pollutant Breakdown
            Text(
              "Pollutant Levels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildPollutantItem("PM2.5", "${(currentLocation["pm25"] as double).toStringAsFixed(1)} μg/m³", currentLocation["pm25"] as double, 35.0),
                  _buildPollutantItem("PM10", "${(currentLocation["pm10"] as double).toStringAsFixed(1)} μg/m³", currentLocation["pm10"] as double, 50.0),
                  _buildPollutantItem("O₃", "${(currentLocation["o3"] as double).toStringAsFixed(3)} ppm", (currentLocation["o3"] as double) * 1000, 70.0),
                  _buildPollutantItem("NO₂", "${(currentLocation["no2"] as double).toStringAsFixed(3)} ppm", (currentLocation["no2"] as double) * 1000, 50.0),
                  _buildPollutantItem("SO₂", "${(currentLocation["so2"] as double).toStringAsFixed(3)} ppm", (currentLocation["so2"] as double) * 1000, 20.0),
                  _buildPollutantItem("CO", "${(currentLocation["co"] as double).toStringAsFixed(1)} ppm", currentLocation["co"] as double, 9.0),
                ],
              ),
            ),

            // Hourly Forecast
            Text(
              "24-Hour Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: List.generate(hourlyData.length, (index) {
                  final data = hourlyData[index];
                  final aqi = data["aqi"] as int;
                  final color = _getAQIColor(aqi);
                  
                  return Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spXs,
                      children: [
                        Text(
                          "${data["hour"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withAlpha(25),
                            border: Border.all(color: color, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              "$aqi",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${data["status"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Health Tips
            if (showHealthTips) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Health Recommendations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20),
                    onPressed: () {
                      showHealthTips = false;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: healthTips.map((tip) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: infoColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              tip["icon"] as IconData,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${tip["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
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
              ),
            ],

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Share Report",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      ss("Air quality report shared successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Set Alert",
                    icon: Icons.notifications_active,
                    size: bs.md,
                    onPressed: () {
                      _showAlertSettings();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollutantItem(String name, String value, double level, double maxLevel) {
    final percentage = (level / maxLevel).clamp(0.0, 1.0);
    final color = percentage < 0.5 ? Colors.green : percentage < 0.8 ? Colors.orange : Colors.red;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Color _getAQIColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notification Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text("Air Quality Alerts"),
              subtitle: Text("Get notified when AQI exceeds unhealthy levels"),
              value: enableNotifications,
              onChanged: (value) {
                enableNotifications = value;
                setState(() {});
              },
            ),
            SwitchListTile(
              title: Text("Daily Summary"),
              subtitle: Text("Receive daily air quality reports"),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Notification settings updated");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showPollutantInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pollutant Information"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pollutantInfo.length,
            itemBuilder: (context, index) {
              final info = pollutantInfo[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${info["name"]} - ${info["description"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text("Unit: ${info["unit"]}"),
                      Text("Health Risk: ${info["healthRisk"]}"),
                      Text("Sources: ${info["sources"]}"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showAlertSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Air Quality Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Get notified when AQI exceeds:"),
            SizedBox(height: spSm),
            DropdownButton<int>(
              value: 100,
              items: [50, 100, 150, 200].map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text("AQI $value"),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Air quality alert set successfully");
            },
            child: Text("Set Alert"),
          ),
        ],
      ),
    );
  }
}

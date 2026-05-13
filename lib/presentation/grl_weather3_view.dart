import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWeather3View extends StatefulWidget {
  @override
  State<GrlWeather3View> createState() => _GrlWeather3ViewState();
}

class _GrlWeather3ViewState extends State<GrlWeather3View> {
  Map<String, dynamic> currentWeather = {
    "location": "San Francisco",
    "temperature": 22,
    "condition": "Sunny",
    "humidity": 45,
    "windSpeed": 8,
    "pressure": 1018,
    "uvIndex": 7,
    "sunrise": "6:42 AM",
    "sunset": "7:28 PM",
    "icon": Icons.wb_sunny,
  };

  List<Map<String, dynamic>> airQualityData = [
    {
      "parameter": "PM2.5",
      "value": 12,
      "unit": "μg/m³",
      "status": "Good",
      "color": Colors.green,
      "description": "Air quality is satisfactory"
    },
    {
      "parameter": "PM10",
      "value": 25,
      "unit": "μg/m³",
      "status": "Good",
      "color": Colors.green,
      "description": "Poses little risk"
    },
    {
      "parameter": "O3",
      "value": 45,
      "unit": "ppb",
      "status": "Moderate",
      "color": Colors.orange,
      "description": "Sensitive people should limit outdoor activities"
    },
    {
      "parameter": "NO2",
      "value": 18,
      "unit": "ppb",
      "status": "Good",
      "color": Colors.green,
      "description": "Air quality is acceptable"
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "type": "UV Warning",
      "severity": "High",
      "message": "Very high UV levels expected today. Use sunscreen and limit outdoor exposure.",
      "icon": Icons.wb_sunny,
      "color": Colors.orange,
      "validUntil": "6:00 PM"
    },
    {
      "type": "Heat Advisory",
      "severity": "Moderate",
      "message": "Temperatures may reach 28°C today. Stay hydrated and avoid prolonged sun exposure.",
      "icon": Icons.thermostat,
      "color": Colors.red,
      "validUntil": "8:00 PM"
    },
  ];

  List<Map<String, dynamic>> weatherTrends = [
    {
      "period": "Morning",
      "time": "6:00 - 12:00",
      "temp": "18° - 24°",
      "condition": "Clear",
      "icon": Icons.wb_sunny,
      "recommendation": "Perfect for outdoor activities"
    },
    {
      "period": "Afternoon",
      "time": "12:00 - 18:00",
      "temp": "24° - 28°",
      "condition": "Sunny",
      "icon": Icons.wb_sunny,
      "recommendation": "Stay hydrated, use sunscreen"
    },
    {
      "period": "Evening",
      "time": "18:00 - 24:00",
      "temp": "22° - 18°",
      "condition": "Clear",
      "icon": Icons.wb_twilight,
      "recommendation": "Great for evening walks"
    },
    {
      "period": "Night",
      "time": "00:00 - 6:00",
      "temp": "16° - 14°",
      "condition": "Clear",
      "icon": Icons.brightness_2,
      "recommendation": "Cool and comfortable"
    },
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "title": "Hydration Alert",
      "description": "Drink plenty of water due to warm weather and low humidity",
      "icon": Icons.local_drink,
      "priority": "High"
    },
    {
      "title": "Sun Protection",
      "description": "UV index is high. Wear sunscreen and protective clothing",
      "icon": Icons.shield,
      "priority": "High"
    },
    {
      "title": "Air Quality",
      "description": "Good air quality for outdoor exercise and activities",
      "icon": Icons.air,
      "priority": "Low"
    },
    {
      "title": "Pollen Alert",
      "description": "Moderate pollen levels. Consider taking antihistamines",
      "icon": Icons.grass,
      "priority": "Medium"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Health"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.withAlpha(200)],
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
                            "${currentWeather["location"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Today, ${DateTime.now().toString().split(' ')[0]}",
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
                          currentWeather["icon"] as IconData,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${currentWeather["temperature"]}°C",
                        style: TextStyle(
                          fontSize: 48,
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
                            "${currentWeather["condition"]}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${currentWeather["sunrise"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(180),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.brightness_2,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${currentWeather["sunset"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(180),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Weather Alerts
            if (weatherAlerts.isNotEmpty)
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
                          Icons.warning,
                          color: Colors.orange,
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
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (alert["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: (alert["color"] as Color).withAlpha(100)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (alert["color"] as Color).withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  alert["icon"] as IconData,
                                  color: alert["color"] as Color,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${alert["type"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: alert["color"] as Color,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: (alert["color"] as Color).withAlpha(50),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${alert["severity"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
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
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Valid until ${alert["validUntil"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
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
                  ],
                ),
              ),

            // Air Quality Index
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
                        Icons.air,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Air Quality Index",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Good",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: airQualityData.map((data) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (data["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${data["parameter"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: (data["color"] as Color).withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${data["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: data["color"] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${data["value"]} ${data["unit"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${data["description"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
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

            // Daily Weather Pattern
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
                        Icons.trending_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Today's Weather Pattern",
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
                    children: weatherTrends.map((trend) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getTrendColor(trend["period"] as String).withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                trend["icon"] as IconData,
                                color: _getTrendColor(trend["period"] as String),
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${trend["period"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${trend["temp"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${trend["time"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${trend["condition"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${trend["recommendation"]}",
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
                  ),
                ],
              ),
            ),

            // Health Tips
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
                        Icons.health_and_safety,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Health & Safety Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: healthTips.map((tip) {
                      Color priorityColor = _getPriorityColor(tip["priority"] as String);
                      
                      return Container(
                        width: 200,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    tip["icon"] as IconData,
                                    color: priorityColor,
                                    size: 20,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${tip["priority"]}",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: priorityColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                height: 1.3,
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Set Alerts",
                    icon: Icons.notifications_active,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Forecast",
                    icon: Icons.calendar_today,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTrendColor(String period) {
    switch (period.toLowerCase()) {
      case 'morning':
        return Colors.blue;
      case 'afternoon':
        return Colors.orange;
      case 'evening':
        return Colors.purple;
      case 'night':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return infoColor;
    }
  }
}

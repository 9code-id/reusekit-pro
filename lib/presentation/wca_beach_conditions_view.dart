import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaBeachConditionsView extends StatefulWidget {
  const WcaBeachConditionsView({super.key});

  @override
  State<WcaBeachConditionsView> createState() => _WcaBeachConditionsViewState();
}

class _WcaBeachConditionsViewState extends State<WcaBeachConditionsView> {
  String selectedBeach = "Santa Monica Beach";
  String selectedActivity = "Swimming";
  int selectedTimeframe = 24;

  List<Map<String, dynamic>> beaches = [
    {"label": "Santa Monica Beach", "value": "Santa Monica Beach"},
    {"label": "Malibu Beach", "value": "Malibu Beach"},
    {"label": "Venice Beach", "value": "Venice Beach"},
    {"label": "Manhattan Beach", "value": "Manhattan Beach"},
    {"label": "Huntington Beach", "value": "Huntington Beach"},
  ];

  List<Map<String, dynamic>> activities = [
    {"label": "Swimming", "value": "Swimming"},
    {"label": "Surfing", "value": "Surfing"},
    {"label": "Beach Walking", "value": "Beach Walking"},
    {"label": "Sunbathing", "value": "Sunbathing"},
    {"label": "Volleyball", "value": "Volleyball"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Next 12 Hours", "value": 12},
    {"label": "Next 24 Hours", "value": 24},
    {"label": "Next 3 Days", "value": 72},
    {"label": "This Week", "value": 168},
  ];

  List<Map<String, dynamic>> currentConditions = [
    {
      "title": "Water Temperature",
      "value": "72",
      "unit": "°F",
      "status": "Perfect",
      "description": "Ideal for swimming",
      "color": successColor,
      "icon": Icons.thermostat,
    },
    {
      "title": "Air Temperature",
      "value": "78",
      "unit": "°F",
      "status": "Warm",
      "description": "Great beach weather",
      "color": successColor,
      "icon": Icons.wb_sunny,
    },
    {
      "title": "Wave Height",
      "value": "2-3",
      "unit": "ft",
      "status": "Moderate",
      "description": "Good for beginners",
      "color": infoColor,
      "icon": Icons.waves,
    },
    {
      "title": "UV Index",
      "value": "8",
      "unit": "High",
      "status": "Caution",
      "description": "Use sunscreen",
      "color": warningColor,
      "icon": Icons.wb_sunny_outlined,
    },
  ];

  List<Map<String, dynamic>> hourlyConditions = [
    {
      "time": "9:00 AM",
      "airTemp": 75,
      "waterTemp": 71,
      "waveHeight": "2-3 ft",
      "windSpeed": "8 mph",
      "uvIndex": 6,
      "crowdLevel": "Light",
      "rating": "Excellent",
      "color": successColor,
    },
    {
      "time": "12:00 PM",
      "airTemp": 80,
      "waterTemp": 72,
      "waveHeight": "3-4 ft",
      "windSpeed": "12 mph",
      "uvIndex": 9,
      "crowdLevel": "Moderate",
      "rating": "Good",
      "color": successColor,
    },
    {
      "time": "3:00 PM",
      "airTemp": 82,
      "waterTemp": 73,
      "waveHeight": "3-5 ft",
      "windSpeed": "15 mph",
      "uvIndex": 8,
      "crowdLevel": "Heavy",
      "rating": "Fair",
      "color": warningColor,
    },
    {
      "time": "6:00 PM",
      "airTemp": 78,
      "waterTemp": 72,
      "waveHeight": "2-4 ft",
      "windSpeed": "10 mph",
      "uvIndex": 4,
      "crowdLevel": "Moderate",
      "rating": "Good",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> beachAlerts = [
    {
      "type": "Beach Advisory",
      "title": "High Surf Warning",
      "message": "Dangerous surf conditions expected. Strong rip currents possible.",
      "severity": "High",
      "validUntil": "June 17, 8:00 PM",
      "affectedActivities": ["Swimming", "Surfing"],
      "color": dangerColor,
      "icon": Icons.warning,
    },
    {
      "type": "Water Quality",
      "title": "Water Quality Notice",
      "message": "Slightly elevated bacteria levels detected after recent rain.",
      "severity": "Medium",
      "validUntil": "June 18, 12:00 PM",
      "affectedActivities": ["Swimming"],
      "color": warningColor,
      "icon": Icons.water_drop,
    },
  ];

  List<Map<String, dynamic>> safetyRecommendations = [
    {
      "category": "Swim Safety",
      "recommendations": [
        "Always swim near lifeguard stations",
        "Be aware of rip current warnings",
        "Never swim alone",
        "Check water temperature before entering"
      ],
      "icon": Icons.pool,
      "color": primaryColor,
    },
    {
      "category": "Sun Protection",
      "recommendations": [
        "Apply SPF 30+ sunscreen every 2 hours",
        "Seek shade during peak UV hours (10 AM - 4 PM)",
        "Wear protective clothing and hats",
        "Stay hydrated with plenty of water"
      ],
      "icon": Icons.wb_sunny,
      "color": warningColor,
    },
    {
      "category": "Weather Awareness",
      "recommendations": [
        "Monitor weather conditions regularly",
        "Seek shelter during thunderstorms",
        "Be prepared for sudden weather changes",
        "Check wind conditions for beach activities"
      ],
      "icon": Icons.cloud,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> amenities = [
    {
      "amenity": "Lifeguards",
      "status": "On Duty",
      "hours": "9:00 AM - 6:00 PM",
      "notes": "Full coverage during peak hours",
      "icon": Icons.security,
      "available": true,
    },
    {
      "amenity": "Restrooms",
      "status": "Open",
      "hours": "24 Hours",
      "notes": "Recently cleaned",
      "icon": Icons.wc,
      "available": true,
    },
    {
      "amenity": "Parking",
      "status": "Available",
      "hours": "24 Hours",
      "notes": "75% capacity - \$8/hour",
      "icon": Icons.local_parking,
      "available": true,
    },
    {
      "amenity": "Food Vendors",
      "status": "Open",
      "hours": "8:00 AM - 8:00 PM",
      "notes": "Multiple options available",
      "icon": Icons.restaurant,
      "available": true,
    },
    {
      "amenity": "Equipment Rental",
      "status": "Closed",
      "hours": "Closed Mondays",
      "notes": "Reopens Tuesday 9:00 AM",
      "icon": Icons.sports,
      "available": false,
    },
  ];

  List<Map<String, dynamic>> activityRatings = [
    {
      "activity": "Swimming",
      "rating": 8.5,
      "conditions": "Excellent water temperature, moderate waves",
      "bestTime": "Morning hours (9-11 AM)",
      "color": successColor,
      "icon": Icons.pool,
    },
    {
      "activity": "Surfing",
      "rating": 7.2,
      "conditions": "Consistent waves, light offshore winds",
      "bestTime": "Early morning (6-9 AM)",
      "color": successColor,
      "icon": Icons.surfing,
    },
    {
      "activity": "Beach Walking",
      "rating": 9.1,
      "conditions": "Perfect weather, low tide exposes more beach",
      "bestTime": "Sunrise or sunset",
      "color": successColor,
      "icon": Icons.directions_walk,
    },
    {
      "activity": "Sunbathing",
      "rating": 8.8,
      "conditions": "Warm air, light breeze, good UV levels",
      "bestTime": "Mid-morning (10 AM - 12 PM)",
      "color": successColor,
      "icon": Icons.wb_sunny,
    },
    {
      "activity": "Volleyball",
      "rating": 6.8,
      "conditions": "Light winds, but sand may be hot",
      "bestTime": "Evening (4-6 PM)",
      "color": warningColor,
      "icon": Icons.sports_volleyball,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beach Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              si("Beach webcam view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Beach map view opened");
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
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor.withAlpha(20),
                    infoColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.beach_access,
                    color: successColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Beach Conditions Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Real-time beach conditions, safety alerts, and activity recommendations",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Beach Location",
                    items: beaches,
                    value: selectedBeach,
                    onChanged: (value, label) {
                      selectedBeach = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Activity",
                    items: activities,
                    value: selectedActivity,
                    onChanged: (value, label) {
                      selectedActivity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            if (beachAlerts.isNotEmpty) ...[
              Text(
                "Beach Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: beachAlerts.map((alert) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: alert["color"].withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: alert["color"].withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              alert["icon"],
                              color: alert["color"],
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${alert["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: alert["color"],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: alert["color"].withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${alert["severity"]}",
                                style: TextStyle(
                                  color: alert["color"],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "Affected: ${(alert["affectedActivities"] as List).join(", ")}",
                              style: TextStyle(
                                color: alert["color"],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Valid until: ${alert["validUntil"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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

            Text(
              "Current Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: currentConditions.map((condition) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            condition["icon"],
                            color: condition["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: condition["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${condition["status"]}",
                              style: TextStyle(
                                color: condition["color"],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${condition["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${condition["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${condition["description"]}",
                        style: TextStyle(
                          color: condition["color"],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Today's Hourly Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: hourlyConditions.map((hour) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: hour["color"],
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${hour["time"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: hour["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${hour["rating"]}",
                              style: TextStyle(
                                color: hour["color"],
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Air: ${hour["airTemp"]}°F",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Water: ${hour["waterTemp"]}°F",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Waves: ${hour["waveHeight"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Wind: ${hour["windSpeed"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "UV: ${hour["uvIndex"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Crowd: ${hour["crowdLevel"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Activity Ratings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: activityRatings.map((rating) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        rating["icon"],
                        color: rating["color"],
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${rating["activity"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: rating["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${rating["rating"]}/10",
                                    style: TextStyle(
                                      color: rating["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${rating["conditions"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Best Time: ${rating["bestTime"]}",
                              style: TextStyle(
                                color: rating["color"],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
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

            Text(
              "Beach Amenities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: amenities.map((amenity) {
                Color statusColor = amenity["available"] ? successColor : disabledBoldColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        amenity["icon"],
                        color: statusColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${amenity["amenity"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${amenity["status"]}",
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Hours: ${amenity["hours"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            if (amenity["notes"].isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Text(
                                "${amenity["notes"]}",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Safety Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: safetyRecommendations.map((safety) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            safety["icon"],
                            color: safety["color"],
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${safety["category"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: safety["color"],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Column(
                        spacing: spXs,
                        children: (safety["recommendations"] as List<String>).map((rec) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• ",
                                style: TextStyle(
                                  color: safety["color"],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  rec,
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

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
                        Icons.schedule,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Updates",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Beach conditions updated every 30 minutes from local weather stations and lifeguard reports.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Last update: Today at 2:30 PM",
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
      ),
    );
  }
}

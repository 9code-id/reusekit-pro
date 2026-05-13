import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSmartFeaturesView extends StatefulWidget {
  const CmaSmartFeaturesView({super.key});

  @override
  State<CmaSmartFeaturesView> createState() => _CmaSmartFeaturesViewState();
}

class _CmaSmartFeaturesViewState extends State<CmaSmartFeaturesView> {
  String selectedVehicle = "VH001";
  bool adaptiveCruise = true;
  bool laneAssist = true;
  bool blindSpotMonitor = true;
  bool parkingAssist = false;
  bool collisionWarning = true;
  bool driverAlert = true;
  bool autoEmergencyBraking = true;
  bool trafficSignRecognition = false;
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "label": "Honda Civic - ABC123",
      "value": "VH001",
    },
    {
      "id": "VH002", 
      "label": "Toyota Camry - XYZ789",
      "value": "VH002",
    },
    {
      "id": "VH003",
      "label": "BMW X5 - DEF456", 
      "value": "VH003",
    }
  ];

  List<Map<String, dynamic>> smartFeatures = [
    {
      "name": "Adaptive Cruise Control",
      "description": "Automatically adjusts speed based on traffic",
      "icon": Icons.speed,
      "status": "Active",
      "enabled": true,
      "category": "Safety"
    },
    {
      "name": "Lane Keep Assist",
      "description": "Helps keep vehicle centered in lane",
      "icon": Icons.assistant_direction,
      "status": "Active", 
      "enabled": true,
      "category": "Safety"
    },
    {
      "name": "Blind Spot Monitor",
      "description": "Warns of vehicles in blind spots",
      "icon": Icons.visibility,
      "status": "Active",
      "enabled": true,
      "category": "Safety"
    },
    {
      "name": "Parking Assist",
      "description": "Automated parallel parking assistance",
      "icon": Icons.local_parking,
      "status": "Inactive",
      "enabled": false,
      "category": "Convenience"
    },
    {
      "name": "Collision Warning",
      "description": "Forward collision detection and warning",
      "icon": Icons.warning,
      "status": "Active",
      "enabled": true,
      "category": "Safety"
    },
    {
      "name": "Driver Drowsiness Alert",
      "description": "Monitors driver attention and alertness",
      "icon": Icons.psychology,
      "status": "Active",
      "enabled": true,
      "category": "Safety"
    }
  ];

  List<Map<String, dynamic>> featureAlerts = [
    {
      "timestamp": "2024-06-19 14:45",
      "feature": "Collision Warning",
      "message": "Potential collision detected - 2.5 seconds",
      "severity": "High",
      "action": "Braking applied"
    },
    {
      "timestamp": "2024-06-19 13:20",
      "feature": "Lane Keep Assist", 
      "message": "Lane departure corrected",
      "severity": "Medium",
      "action": "Steering adjusted"
    },
    {
      "timestamp": "2024-06-19 12:10",
      "feature": "Blind Spot Monitor",
      "message": "Vehicle detected in left blind spot",
      "severity": "Medium",
      "action": "Warning displayed"
    },
    {
      "timestamp": "2024-06-19 10:30",
      "feature": "Driver Alert",
      "message": "Driver drowsiness detected",
      "severity": "High", 
      "action": "Audio alert played"
    }
  ];

  List<Map<String, dynamic>> featureStats = [
    {
      "feature": "Collision Warnings",
      "count": 12,
      "trend": "down",
      "change": -3
    },
    {
      "feature": "Lane Corrections",
      "count": 45,
      "trend": "up",
      "change": 8
    },
    {
      "feature": "Blind Spot Alerts",
      "count": 28,
      "trend": "down",
      "change": -5
    },
    {
      "feature": "Emergency Braking",
      "count": 2,
      "trend": "stable",
      "change": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Features"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Vehicle Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Vehicle Selection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Select Vehicle",
                    items: vehicles,
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Feature Overview Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dashboard, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Feature Statistics",
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
                    minItemWidth: 200,
                    children: featureStats.map((stat) {
                      Color trendColor = successColor;
                      IconData trendIcon = Icons.trending_flat;
                      
                      if (stat["trend"] == "up") {
                        trendColor = warningColor;
                        trendIcon = Icons.trending_up;
                      } else if (stat["trend"] == "down") {
                        trendColor = successColor;
                        trendIcon = Icons.trending_down;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: trendColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${stat["count"]}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      trendIcon,
                                      color: trendColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${stat["change"] > 0 ? '+' : ''}${stat["change"]}",
                                      style: TextStyle(
                                        color: trendColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${stat["feature"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "This week",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 10,
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

            // Smart Features Control
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.smart_toy, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Smart Features Control",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...smartFeatures.map((feature) {
                    Color statusColor = feature["enabled"] ? successColor : disabledBoldColor;
                    Color categoryColor = feature["category"] == "Safety" ? dangerColor : infoColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              feature["icon"] as IconData,
                              color: statusColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${feature["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: categoryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${feature["category"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${feature["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Status: ${feature["status"]}",
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Toggle feature status
                                        feature["enabled"] = !feature["enabled"];
                                        feature["status"] = feature["enabled"] ? "Active" : "Inactive";
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: feature["enabled"] ? successColor : disabledBoldColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: AnimatedAlign(
                                          duration: Duration(milliseconds: 200),
                                          alignment: feature["enabled"] ? Alignment.centerRight : Alignment.centerLeft,
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Recent Feature Alerts
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications_active, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...featureAlerts.take(4).map((alert) {
                    Color severityColor = successColor;
                    if (alert["severity"] == "Medium") severityColor = warningColor;
                    if (alert["severity"] == "High") severityColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: severityColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${alert["feature"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: severityColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${alert["severity"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${alert["message"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${alert["timestamp"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "Action: ${alert["action"]}",
                                style: TextStyle(
                                  color: severityColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
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
            ),

            // Feature Categories
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Feature Categories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.security,
                                color: dangerColor,
                                size: 32,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Safety Features",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "5 Active",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.car_rental,
                                color: infoColor,
                                size: 32,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Convenience",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "1 Active",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Calibrate Sensors",
                    icon: Icons.tune,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Feature Report",
                    icon: Icons.assessment,
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
}

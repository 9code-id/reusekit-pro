import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaGpsNavigationView extends StatefulWidget {
  const LtaGpsNavigationView({super.key});

  @override
  State<LtaGpsNavigationView> createState() => _LtaGpsNavigationViewState();
}

class _LtaGpsNavigationViewState extends State<LtaGpsNavigationView> {
  bool isNavigating = true;
  bool voiceGuidance = true;
  bool showTraffic = true;
  String currentInstruction = "Turn right onto Main Street in 200 meters";
  String nextInstruction = "Continue straight for 1.2 km";
  double currentSpeed = 35.0;
  double speedLimit = 40.0;
  String estimatedArrival = "2:45 PM";
  String remainingTime = "18 min";
  double remainingDistance = 4.2;

  Map<String, dynamic> currentRoute = {
    "name": "Downtown Route A",
    "currentStep": 3,
    "totalSteps": 6,
    "nextStop": "City Mall",
    "nextStopAddress": "456 Commerce Blvd",
    "packages": 2,
    "priority": "High",
  };

  List<Map<String, dynamic>> navigationSteps = [
    {
      "step": 1,
      "instruction": "Head north on Oak Street",
      "distance": "0.3 km",
      "completed": true,
      "icon": Icons.straight,
    },
    {
      "step": 2,
      "instruction": "Turn left onto Broadway",
      "distance": "1.2 km",
      "completed": true,
      "icon": Icons.turn_left,
    },
    {
      "step": 3,
      "instruction": "Turn right onto Main Street",
      "distance": "0.8 km",
      "completed": false,
      "current": true,
      "icon": Icons.turn_right,
    },
    {
      "step": 4,
      "instruction": "Continue straight on Commerce Blvd",
      "distance": "2.1 km",
      "completed": false,
      "icon": Icons.straight,
    },
    {
      "step": 5,
      "instruction": "Turn left into City Mall parking",
      "distance": "0.2 km",
      "completed": false,
      "icon": Icons.turn_left,
    },
    {
      "step": 6,
      "instruction": "Arrive at destination",
      "distance": "0.1 km",
      "completed": false,
      "icon": Icons.location_on,
    },
  ];

  List<Map<String, dynamic>> nearbyAlerts = [
    {
      "type": "Traffic",
      "message": "Heavy traffic ahead on Commerce Blvd",
      "distance": "1.5 km",
      "severity": "High",
      "icon": Icons.traffic,
      "color": "danger",
    },
    {
      "type": "Construction",
      "message": "Road work on 5th Avenue",
      "distance": "2.8 km",
      "severity": "Medium",
      "icon": Icons.construction,
      "color": "warning",
    },
    {
      "type": "Speed Camera",
      "message": "Speed camera in 500m",
      "distance": "0.5 km",
      "severity": "Low",
      "icon": Icons.speed,
      "color": "info",
    },
  ];

  List<Map<String, dynamic>> deliveryHistory = [
    {
      "stop": "ABC Corporation",
      "address": "123 Business St",
      "time": "10:30 AM",
      "packages": 3,
      "status": "Delivered",
      "duration": "8 min",
    },
    {
      "stop": "Downtown Office",
      "address": "789 Oak Ave",
      "time": "11:45 AM",
      "packages": 2,
      "status": "Delivered",
      "duration": "5 min",
    },
  ];

  Color getAlertColor(String colorType) {
    switch (colorType) {
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getSpeedColor() {
    if (currentSpeed > speedLimit) {
      return dangerColor;
    } else if (currentSpeed > speedLimit * 0.9) {
      return warningColor;
    } else {
      return successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To: ${currentRoute["nextStop"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${currentRoute["nextStopAddress"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Settings
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Map Placeholder (Simulated GPS View)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Stack(
                        children: [
                          // Map background simulation
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              image: DecorationImage(
                                image: NetworkImage("https://picsum.photos/400/200?random=1&keyword=map"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          // Current location indicator
                          Positioned(
                            bottom: 80,
                            left: 180,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Icon(
                                Icons.navigation,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),

                          // Destination marker
                          Positioned(
                            top: 40,
                            right: 60,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),

                          // Map controls
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Traffic toggle
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                showTraffic = !showTraffic;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: showTraffic ? dangerColor : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  Icons.traffic,
                                  color: showTraffic ? Colors.white : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Navigation Instructions
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
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.turn_right,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentInstruction,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Then: $nextInstruction",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  voiceGuidance = !voiceGuidance;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: voiceGuidance ? successColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    voiceGuidance ? Icons.volume_up : Icons.volume_off,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Trip Information
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  remainingTime,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "ETA $estimatedArrival",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.straighten,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${remainingDistance.toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Remaining",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.speed,
                                  color: getSpeedColor(),
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${currentSpeed.toStringAsFixed(0)} km/h",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: getSpeedColor(),
                                  ),
                                ),
                                Text(
                                  "Limit ${speedLimit.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Traffic & Alerts
                    if (nearbyAlerts.isNotEmpty) ...[
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
                            Text(
                              "Traffic & Alerts",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            ...nearbyAlerts.map((alert) {
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                margin: EdgeInsets.only(bottom: spXs),
                                decoration: BoxDecoration(
                                  color: getAlertColor("${alert["color"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: getAlertColor("${alert["color"]}").withAlpha(50),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      alert["icon"] as IconData,
                                      color: getAlertColor("${alert["color"]}"),
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${alert["message"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: getAlertColor("${alert["color"]}"),
                                            ),
                                          ),
                                          Text(
                                            "In ${alert["distance"]}",
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
                            }),
                          ],
                        ),
                      ),
                    ],

                    // Current Delivery Info
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
                          Text(
                            "Current Delivery",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.inventory_2,
                                  color: successColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${currentRoute["nextStop"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${currentRoute["packages"]} packages • ${currentRoute["priority"]} priority",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Details",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('LtaDeliveryDetailsView')
                                },
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
                            label: "Emergency Stop",
                            size: bs.md,
                            onPressed: () {
                              // Emergency stop
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Re-route",
                            size: bs.md,
                            onPressed: () {
                              //navigateTo('LtaRoutePlanningView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Call Support",
                            size: bs.md,
                            onPressed: () {
                              // Call support
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

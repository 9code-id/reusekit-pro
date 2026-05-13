import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRoutePlanningView extends StatefulWidget {
  const LtaRoutePlanningView({super.key});

  @override
  State<LtaRoutePlanningView> createState() => _LtaRoutePlanningViewState();
}

class _LtaRoutePlanningViewState extends State<LtaRoutePlanningView> {
  String selectedRouteType = "Fastest";
  String selectedVehicle = "van";
  bool avoidTolls = false;
  bool avoidHighways = false;
  String preferredDepartureTime = "Now";
  
  List<Map<String, dynamic>> routeTypes = [
    {"label": "Fastest Route", "value": "Fastest"},
    {"label": "Shortest Route", "value": "Shortest"},
    {"label": "Most Economical", "value": "Economical"},
    {"label": "Avoid Traffic", "value": "Traffic"},
  ];

  List<Map<String, dynamic>> vehicles = [
    {"label": "Van", "value": "van", "icon": Icons.local_shipping},
    {"label": "Truck", "value": "truck", "icon": Icons.fire_truck},
    {"label": "Motorcycle", "value": "motorcycle", "icon": Icons.two_wheeler},
    {"label": "Car", "value": "car", "icon": Icons.directions_car},
  ];

  List<Map<String, dynamic>> departureOptions = [
    {"label": "Leave Now", "value": "Now"},
    {"label": "Leave at Specific Time", "value": "Specific"},
    {"label": "Arrive by Specific Time", "value": "ArriveBy"},
  ];

  Map<String, dynamic> routeAnalysis = {
    "totalDistance": 24.5,
    "estimatedTime": "45 min",
    "fuelCost": 12.50,
    "tollCost": 8.00,
    "totalCost": 20.50,
    "trafficLevel": "Moderate",
    "waypoints": 3,
  };

  List<Map<String, dynamic>> routeOptions = [
    {
      "id": 1,
      "name": "Fastest Route",
      "distance": "24.5 km",
      "duration": "45 min",
      "cost": 20.50,
      "traffic": "Moderate",
      "highlights": ["Via Highway 101", "2 toll stations"],
      "avoids": [],
      "selected": true,
    },
    {
      "id": 2,
      "name": "Shortest Route",
      "distance": "21.3 km",
      "duration": "52 min",
      "cost": 18.75,
      "traffic": "Heavy",
      "highlights": ["City streets", "No tolls"],
      "avoids": ["Highways"],
      "selected": false,
    },
    {
      "id": 3,
      "name": "Economical Route",
      "distance": "26.8 km",
      "duration": "58 min",
      "cost": 15.25,
      "traffic": "Light",
      "highlights": ["Scenic route", "Less fuel consumption"],
      "avoids": ["Tolls", "Heavy traffic"],
      "selected": false,
    },
  ];

  List<Map<String, dynamic>> routeSteps = [
    {
      "step": 1,
      "instruction": "Head north on Main St toward Oak Ave",
      "distance": "0.3 km",
      "duration": "2 min",
      "icon": Icons.straight,
    },
    {
      "step": 2,
      "instruction": "Turn right onto Highway 101 N",
      "distance": "15.2 km",
      "duration": "18 min",
      "icon": Icons.turn_right,
    },
    {
      "step": 3,
      "instruction": "Take exit 15 toward Business District",
      "distance": "0.8 km",
      "duration": "3 min",
      "icon": Icons.exit_to_app,
    },
    {
      "step": 4,
      "instruction": "Continue on Commerce Blvd",
      "distance": "5.2 km",
      "duration": "12 min",
      "icon": Icons.straight,
    },
    {
      "step": 5,
      "instruction": "Turn left onto Delivery St",
      "distance": "0.4 km",
      "duration": "2 min",
      "icon": Icons.turn_left,
    },
    {
      "step": 6,
      "instruction": "Arrive at destination on the right",
      "distance": "0.1 km",
      "duration": "1 min",
      "icon": Icons.location_on,
    },
  ];

  String selectedRouteId = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('LtaMapView')
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save route
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Route Preferences
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
                    "Route Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Route Type",
                    items: routeTypes,
                    value: selectedRouteType,
                    onChanged: (value, label) {
                      selectedRouteType = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Vehicle Type",
                    items: vehicles,
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Departure Time",
                    items: departureOptions,
                    value: preferredDepartureTime,
                    onChanged: (value, label) {
                      preferredDepartureTime = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Route Restrictions
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
                    "Route Restrictions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Avoid Toll Roads",
                        "value": true,
                        "checked": avoidTolls,
                      }
                    ],
                    value: [
                      if (avoidTolls)
                        {"label": "Avoid Toll Roads", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      avoidTolls = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Avoid Highways",
                        "value": true,
                        "checked": avoidHighways,
                      }
                    ],
                    value: [
                      if (avoidHighways)
                        {"label": "Avoid Highways", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      avoidHighways = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Route Analysis Summary
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
                    "Route Analysis",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.straighten,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${routeAnalysis["totalDistance"]} km",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${routeAnalysis["estimatedTime"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${(routeAnalysis["totalCost"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Cost",
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
                ],
              ),
            ),

            // Route Options
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
                    "Available Routes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...routeOptions.map((route) {
                    bool isSelected = selectedRouteId == "${route["id"]}";
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(20) 
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected 
                              ? primaryColor 
                              : disabledOutlineBorderColor,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selectedRouteId = "${route["id"]}";
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${route["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${route["distance"]} • ${route["duration"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$${(route["cost"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              if ((route["highlights"] as List).isNotEmpty) ...[
                                Wrap(
                                  spacing: spXs,
                                  children: (route["highlights"] as List<String>).map((highlight) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        highlight,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                              if ((route["avoids"] as List).isNotEmpty) ...[
                                Text(
                                  "Avoids: ${(route["avoids"] as List<String>).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Route Steps
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
                    "Turn-by-Turn Directions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...routeSteps.map((step) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${step["step"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            step["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["instruction"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${step["distance"]} • ${step["duration"]}",
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Optimize Route",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('LtaRouteOptimizationView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Start Navigation",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('LtaGpsNavigationView')
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
}

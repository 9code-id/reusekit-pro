import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRouteOptimizerView extends StatefulWidget {
  const CmaRouteOptimizerView({super.key});

  @override
  State<CmaRouteOptimizerView> createState() => _CmaRouteOptimizerViewState();
}

class _CmaRouteOptimizerViewState extends State<CmaRouteOptimizerView> {
  List<Map<String, dynamic>> waypoints = [
    {
      "id": "wp1",
      "name": "Home",
      "address": "123 Oak Street, San Francisco, CA",
      "type": "Home",
      "priority": "High",
      "estimatedTime": 0,
      "isOptional": false
    },
    {
      "id": "wp2", 
      "name": "Gas Station",
      "address": "456 Market Street, San Francisco, CA",
      "type": "Fuel",
      "priority": "Medium",
      "estimatedTime": 10,
      "isOptional": true
    },
    {
      "id": "wp3",
      "name": "Grocery Store",
      "address": "789 Mission Street, San Francisco, CA", 
      "type": "Shopping",
      "priority": "High",
      "estimatedTime": 30,
      "isOptional": false
    },
    {
      "id": "wp4",
      "name": "Bank",
      "address": "321 Financial District, San Francisco, CA",
      "type": "Banking",
      "priority": "Medium",
      "estimatedTime": 15,
      "isOptional": true
    },
    {
      "id": "wp5",
      "name": "Office",
      "address": "555 Business Center, San Francisco, CA",
      "type": "Work",
      "priority": "High",
      "estimatedTime": 480,
      "isOptional": false
    }
  ];

  List<Map<String, dynamic>> optimizedRoutes = [
    {
      "id": "route1",
      "name": "Time Optimized",
      "totalDistance": 18.5,
      "totalTime": "1h 45m",
      "fuelCost": 12.50,
      "tollCost": 8.75,
      "efficiency": "Best Time",
      "description": "Fastest route with minimal delays",
      "sequence": ["wp1", "wp3", "wp2", "wp4", "wp5"],
      "savings": "25 minutes saved"
    },
    {
      "id": "route2",
      "name": "Fuel Efficient",
      "totalDistance": 15.2,
      "totalTime": "2h 5m", 
      "fuelCost": 9.80,
      "tollCost": 3.25,
      "efficiency": "Best Fuel",
      "description": "Most fuel-efficient route",
      "sequence": ["wp1", "wp2", "wp3", "wp4", "wp5"],
      "savings": "\$6.20 fuel savings"
    },
    {
      "id": "route3",
      "name": "Balanced",
      "totalDistance": 16.8,
      "totalTime": "1h 58m",
      "fuelCost": 11.20,
      "tollCost": 5.50,
      "efficiency": "Balanced",
      "description": "Good balance of time and cost",
      "sequence": ["wp1", "wp4", "wp3", "wp2", "wp5"],
      "savings": "10% overall savings"
    }
  ];

  List<Map<String, dynamic>> optimizationOptions = [
    {"label": "Minimize Travel Time", "value": "time"},
    {"label": "Minimize Fuel Cost", "value": "fuel"},
    {"label": "Minimize Distance", "value": "distance"},
    {"label": "Balanced Optimization", "value": "balanced"}
  ];

  String selectedOptimization = "balanced";
  String selectedRoute = "route3";
  bool includeTrafficData = true;
  bool avoidTolls = false;
  bool considerBusinessHours = true;

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return successColor;
      case 'work':
        return primaryColor;
      case 'shopping':
        return warningColor;
      case 'fuel':
        return infoColor;
      case 'banking':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.work;
      case 'shopping':
        return Icons.shopping_cart;
      case 'fuel':
        return Icons.local_gas_station;
      case 'banking':
        return Icons.account_balance;
      default:
        return Icons.place;
    }
  }

  void _optimizeRoute() {
    ss("Route optimized successfully based on selected preferences");
    // Trigger route optimization algorithm
  }

  void _addWaypoint() {
    // Navigate to add waypoint screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Optimizer"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_location),
            onPressed: _addWaypoint,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Optimization Settings
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.tune,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Optimization Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Optimization Priority",
                    items: optimizationOptions,
                    value: selectedOptimization,
                    onChanged: (value, label) {
                      selectedOptimization = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Include real-time traffic data",
                        "value": "traffic",
                        "checked": includeTrafficData,
                      },
                      {
                        "label": "Avoid toll roads",
                        "value": "tolls",
                        "checked": avoidTolls,
                      },
                      {
                        "label": "Consider business hours",
                        "value": "business",
                        "checked": considerBusinessHours,
                      }
                    ],
                    value: [
                      if (includeTrafficData) {"label": "Include real-time traffic data", "value": "traffic", "checked": true},
                      if (avoidTolls) {"label": "Avoid toll roads", "value": "tolls", "checked": true},
                      if (considerBusinessHours) {"label": "Consider business hours", "value": "business", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        includeTrafficData = values.any((v) => v["value"] == "traffic");
                        avoidTolls = values.any((v) => v["value"] == "tolls");
                        considerBusinessHours = values.any((v) => v["value"] == "business");
                      });
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Optimize Route",
                      icon: Icons.route,
                      size: bs.md,
                      onPressed: _optimizeRoute,
                    ),
                  ),
                ],
              ),
            ),

            // Waypoints List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Waypoints",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${waypoints.length} stops",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: waypoints.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final waypoint = waypoints[index];
                      final priorityColor = _getPriorityColor("${waypoint["priority"]}");
                      final typeColor = _getTypeColor("${waypoint["type"]}");
                      final typeIcon = _getTypeIcon("${waypoint["type"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                typeIcon,
                                color: typeColor,
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
                                      Expanded(
                                        child: Text(
                                          "${waypoint["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${waypoint["priority"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: priorityColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${waypoint["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: typeColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${waypoint["type"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: typeColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      if ((waypoint["estimatedTime"] as int) > 0) ...[
                                        Icon(
                                          Icons.schedule,
                                          color: disabledBoldColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${waypoint["estimatedTime"]}min",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                      if (waypoint["isOptional"] as bool) ...[
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "Optional",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: warningColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.drag_handle,
                                color: disabledBoldColor,
                              ),
                              onPressed: () {
                                // Handle reordering
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Optimized Routes
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.alt_route,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Optimized Routes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: optimizedRoutes.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final route = optimizedRoutes[index];
                      final isSelected = selectedRoute == route["id"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedRoute = "${route["id"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "${route["id"]}",
                                    groupValue: selectedRoute,
                                    onChanged: (value) {
                                      selectedRoute = value!;
                                      setState(() {});
                                    },
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${route["name"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
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
                                                color: successColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Text(
                                                "${route["savings"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: successColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${route["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                              
                              // Route Statistics
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.straighten,
                                            color: infoColor,
                                            size: 20,
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "${(route["totalDistance"] as double).toStringAsFixed(1)} mi",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
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
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            color: warningColor,
                                            size: 20,
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "${route["totalTime"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                              fontSize: 12,
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
                                        color: successColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            color: successColor,
                                            size: 20,
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "\$${((route["fuelCost"] as double) + (route["tollCost"] as double)).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                          Text(
                                            "Cost",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),

                              // Efficiency Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.eco,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${route["efficiency"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Start Optimized Route Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Optimized Route",
                icon: Icons.play_arrow,
                size: bs.md,
                onPressed: () {
                  ss("Starting optimized route navigation");
                  // Navigate to active route
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDeliveryRouteView extends StatefulWidget {
  const DlaDeliveryRouteView({super.key});

  @override
  State<DlaDeliveryRouteView> createState() => _DlaDeliveryRouteViewState();
}

class _DlaDeliveryRouteViewState extends State<DlaDeliveryRouteView> {
  String selectedRoute = "optimal";
  
  List<Map<String, dynamic>> routeOptions = [
    {
      "id": "optimal",
      "name": "Optimal Route",
      "distance": 15.2,
      "duration": "45 min",
      "fuel_cost": 8.50,
      "stops": 5,
      "color": successColor,
      "description": "Best balance of time and distance"
    },
    {
      "id": "fastest",
      "name": "Fastest Route",
      "distance": 18.7,
      "duration": "38 min",
      "fuel_cost": 11.20,
      "stops": 4,
      "color": infoColor,
      "description": "Shortest time to complete all deliveries"
    },
    {
      "id": "shortest",
      "name": "Shortest Route",
      "distance": 12.8,
      "duration": "52 min",
      "fuel_cost": 7.20,
      "stops": 6,
      "color": warningColor,
      "description": "Minimum distance traveled"
    }
  ];

  List<Map<String, dynamic>> deliveryStops = [
    {
      "id": "STOP-001",
      "customer": "John Smith",
      "address": "123 Main St, Downtown",
      "time_window": "9:00 - 11:00 AM",
      "package_count": 2,
      "estimated_time": 15,
      "status": "pending",
      "priority": "high"
    },
    {
      "id": "STOP-002",
      "customer": "Sarah Johnson",
      "address": "456 Oak Ave, Midtown",
      "time_window": "10:00 AM - 12:00 PM",
      "package_count": 1,
      "estimated_time": 10,
      "status": "pending",
      "priority": "normal"
    },
    {
      "id": "STOP-003",
      "customer": "Mike Davis",
      "address": "789 Pine Rd, Uptown",
      "time_window": "1:00 - 3:00 PM",
      "package_count": 3,
      "estimated_time": 20,
      "status": "pending",
      "priority": "normal"
    },
    {
      "id": "STOP-004",
      "customer": "Lisa Wilson",
      "address": "321 Elm St, Westside",
      "time_window": "2:00 - 4:00 PM",
      "package_count": 1,
      "estimated_time": 8,
      "status": "pending",
      "priority": "low"
    },
    {
      "id": "STOP-005",
      "customer": "Robert Brown",
      "address": "654 Cedar Blvd, Eastside",
      "time_window": "3:00 - 5:00 PM",
      "package_count": 2,
      "estimated_time": 12,
      "status": "pending",
      "priority": "high"
    }
  ];

  Map<String, dynamic> routeStats = {
    "total_distance": 15.2,
    "total_time": "45 min",
    "fuel_cost": 8.50,
    "estimated_completion": "4:30 PM",
    "stops_remaining": 5,
    "packages_remaining": 9
  };

  String getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return 'danger';
      case 'normal':
        return 'primary';
      case 'low':
        return 'warning';
      default:
        return 'primary';
    }
  }

  Color getPriorityColorValue(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'normal':
        return primaryColor;
      case 'low':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Route"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Route refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Opening route settings");
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
            // Route Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Route Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...List.generate(routeOptions.length, (index) {
                    final route = routeOptions[index];
                    final isSelected = selectedRoute == route["id"];
                    return GestureDetector(
                      onTap: () {
                        selectedRoute = route["id"];
                        setState(() {});
                        ss("Selected ${route["name"]}");
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? (route["color"] as Color).withAlpha(20) : disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isSelected ? Border.all(color: route["color"] as Color, width: 2) : null,
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: route["color"] as Color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${route["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check_circle, color: route["color"] as Color, size: 20),
                              ],
                            ),
                            Text(
                              "${route["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spMd,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.straighten, color: disabledBoldColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(route["distance"] as num).toStringAsFixed(1)} km",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${route["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.local_gas_station, color: disabledBoldColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${(route["fuel_cost"] as num).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Route Statistics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Route Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.straighten, color: infoColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "${(routeStats["total_distance"] as num).toStringAsFixed(1)} km",
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
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.access_time, color: successColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "${routeStats["total_time"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.local_gas_station, color: warningColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(routeStats["fuel_cost"] as num).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Fuel Cost",
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
                ],
              ),
            ),

            // Map Placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, color: primaryColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Route Map View",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Interactive map with delivery stops",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Stops
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Delivery Stops",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${deliveryStops.length} stops",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(deliveryStops.length, (index) {
                    final stop = deliveryStops[index];
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${stop["customer"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${stop["address"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getPriorityColorValue("${stop["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${stop["priority"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: getPriorityColorValue("${stop["priority"]}"),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: spMd,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${stop["time_window"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.inventory, color: disabledBoldColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${stop["package_count"]} packages",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer, color: disabledBoldColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${stop["estimated_time"]} min",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Route",
                    icon: Icons.play_arrow,
                    size: bs.md,
                    onPressed: () {
                      ss("Starting delivery route");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Optimize",
                    icon: Icons.route,
                    size: bs.md,
                    onPressed: () {
                      ss("Optimizing route");
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

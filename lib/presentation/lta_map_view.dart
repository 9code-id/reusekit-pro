import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaMapView extends StatefulWidget {
  const LtaMapView({super.key});

  @override
  State<LtaMapView> createState() => _LtaMapViewState();
}

class _LtaMapViewState extends State<LtaMapView> {
  String selectedLayer = "Traffic";
  String viewMode = "Standard";
  bool showDrivers = true;
  bool showRoutes = true;
  bool showDeliveries = true;
  bool showTraffic = true;

  List<Map<String, dynamic>> mapLayers = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Satellite", "value": "Satellite"},
    {"label": "Traffic", "value": "Traffic"},
    {"label": "Terrain", "value": "Terrain"},
  ];

  List<Map<String, dynamic>> activeDrivers = [
    {
      "id": 1,
      "name": "John Smith",
      "vehicle": "Van #001",
      "lat": 40.7128,
      "lng": -74.0060,
      "status": "En Route",
      "speed": 35,
      "nextStop": "City Mall",
      "packages": 3,
      "eta": "2:30 PM",
    },
    {
      "id": 2,
      "name": "Sarah Johnson", 
      "vehicle": "Truck #205",
      "lat": 40.7589,
      "lng": -73.9851,
      "status": "Delivering",
      "speed": 0,
      "nextStop": "Maple Heights",
      "packages": 5,
      "eta": "1:45 PM",
    },
    {
      "id": 3,
      "name": "Mike Chen",
      "vehicle": "Van #112", 
      "lat": 40.7282,
      "lng": -73.7949,
      "status": "Delayed",
      "speed": 15,
      "nextStop": "Business District",
      "packages": 2,
      "eta": "3:15 PM",
    },
  ];

  List<Map<String, dynamic>> deliveryPoints = [
    {
      "id": 1,
      "name": "ABC Corporation",
      "address": "123 Business St",
      "lat": 40.7484,
      "lng": -73.9857,
      "status": "Completed",
      "packages": 3,
      "time": "10:30 AM",
      "priority": "High",
    },
    {
      "id": 2,
      "name": "City Mall",
      "address": "456 Commerce Blvd",
      "lat": 40.7505,
      "lng": -73.9934,
      "status": "Pending",
      "packages": 2,
      "time": "2:30 PM",
      "priority": "Medium",
    },
    {
      "id": 3,
      "name": "Residential Complex",
      "address": "789 Oak Avenue",
      "lat": 40.7318,
      "lng": -73.9918,
      "status": "In Progress",
      "packages": 4,
      "time": "1:45 PM",
      "priority": "Low",
    },
  ];

  List<Map<String, dynamic>> trafficIncidents = [
    {
      "id": 1,
      "type": "Heavy Traffic",
      "location": "Highway 101 & Main St",
      "lat": 40.7400,
      "lng": -73.9900,
      "severity": "High",
      "description": "Construction work causing delays",
      "estimated_delay": "15-20 minutes",
    },
    {
      "id": 2,
      "type": "Accident",
      "location": "Broadway & 5th Ave",
      "lat": 40.7200,
      "lng": -74.0100,
      "severity": "Medium",
      "description": "Minor fender bender, one lane blocked",
      "estimated_delay": "5-10 minutes",
    },
  ];

  Color getDriverStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "en route":
        return successColor;
      case "delivering":
        return infoColor;
      case "delayed":
        return dangerColor;
      case "idle":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getDeliveryStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "in progress":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getDeliveryStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Icons.check_circle;
      case "in progress":
        return Icons.local_shipping;
      case "pending":
        return Icons.schedule;
      case "failed":
        return Icons.error;
      default:
        return Icons.location_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () {
              // Show layer options
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Controls
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Map View",
                        items: mapLayers,
                        value: viewMode,
                        onChanged: (value, label) {
                          viewMode = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // Refresh map
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: showDrivers,
                            onChanged: (value) {
                              showDrivers = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text("Drivers", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: showRoutes,
                            onChanged: (value) {
                              showRoutes = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text("Routes", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: showDeliveries,
                            onChanged: (value) {
                              showDeliveries = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text("Deliveries", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: showTraffic,
                            onChanged: (value) {
                              showTraffic = value ?? false;
                              setState(() {});
                            },
                          ),
                          Text("Traffic", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Map Area
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Map background
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/400/300?random=1&keyword=city"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Driver markers
                  if (showDrivers) ...[
                    ...activeDrivers.map((driver) {
                      return Positioned(
                        top: 100 + (driver["id"] as int) * 40.0,
                        left: 150 + (driver["id"] as int) * 60.0,
                        child: GestureDetector(
                          onTap: () {
                            // Show driver details
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("${driver["name"]}"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Vehicle: ${driver["vehicle"]}"),
                                    Text("Status: ${driver["status"]}"),
                                    Text("Speed: ${driver["speed"]} km/h"),
                                    Text("Next Stop: ${driver["nextStop"]}"),
                                    Text("Packages: ${driver["packages"]}"),
                                    Text("ETA: ${driver["eta"]}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: getDriverStatusColor("${driver["status"]}"),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.local_shipping,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],

                  // Delivery point markers
                  if (showDeliveries) ...[
                    ...deliveryPoints.map((delivery) {
                      return Positioned(
                        top: 80 + (delivery["id"] as int) * 50.0,
                        right: 100 + (delivery["id"] as int) * 40.0,
                        child: GestureDetector(
                          onTap: () {
                            // Show delivery details
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("${delivery["name"]}"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address: ${delivery["address"]}"),
                                    Text("Status: ${delivery["status"]}"),
                                    Text("Packages: ${delivery["packages"]}"),
                                    Text("Time: ${delivery["time"]}"),
                                    Text("Priority: ${delivery["priority"]}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: getDeliveryStatusColor("${delivery["status"]}"),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              getDeliveryStatusIcon("${delivery["status"]}"),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],

                  // Traffic incident markers
                  if (showTraffic) ...[
                    ...trafficIncidents.map((incident) {
                      return Positioned(
                        top: 120,
                        left: 200 + (incident["id"] as int) * 80.0,
                        child: GestureDetector(
                          onTap: () {
                            // Show incident details
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("${incident["type"]}"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Location: ${incident["location"]}"),
                                    Text("Severity: ${incident["severity"]}"),
                                    Text("Description: ${incident["description"]}"),
                                    Text("Delay: ${incident["estimated_delay"]}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],

                  // Map zoom controls
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(Icons.add, size: 20),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(Icons.remove, size: 20),
                        ),
                      ],
                    ),
                  ),

                  // Current location button
                  Positioned(
                    bottom: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Panel
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Status tabs
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Active Drivers (${activeDrivers.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spXs),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Deliveries (${deliveryPoints.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spXs),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Incidents (${trafficIncidents.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Driver list
                  Expanded(
                    child: ListView.builder(
                      itemCount: activeDrivers.length,
                      itemBuilder: (context, index) {
                        final driver = activeDrivers[index];
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: getDriverStatusColor("${driver["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${driver["name"]} • ${driver["vehicle"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${driver["status"]} • ${driver["speed"]} km/h • Next: ${driver["nextStop"]}",
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
                                  //navigateTo('LtaDriverTrackingView', arguments: driver)
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

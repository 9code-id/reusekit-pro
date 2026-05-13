import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaMapView extends StatefulWidget {
  const DlaMapView({super.key});

  @override
  State<DlaMapView> createState() => _DlaMapViewState();
}

class _DlaMapViewState extends State<DlaMapView> {
  String selectedMapType = "normal";
  String selectedLayer = "traffic";
  bool showTraffic = true;
  bool showDeliveries = true;
  bool showRoutes = true;
  bool showDrivers = true;
  String searchQuery = "";

  List<Map<String, dynamic>> mapTypes = [
    {"label": "Normal", "value": "normal", "icon": Icons.map},
    {"label": "Satellite", "value": "satellite", "icon": Icons.satellite},
    {"label": "Terrain", "value": "terrain", "icon": Icons.terrain},
    {"label": "Hybrid", "value": "hybrid", "icon": Icons.layers},
  ];

  List<Map<String, dynamic>> mapLayers = [
    {"label": "Traffic", "value": "traffic", "color": Colors.red},
    {"label": "Weather", "value": "weather", "color": Colors.blue},
    {"label": "Construction", "value": "construction", "color": Colors.orange},
    {"label": "Incidents", "value": "incidents", "color": Colors.purple},
  ];

  List<Map<String, dynamic>> deliveryPoints = [
    {
      "id": "DEL001",
      "customer": "John Smith",
      "address": "123 Oak Street",
      "status": "pending",
      "priority": "high",
      "eta": "10:30 AM",
      "packages": 2,
      "lat": 37.7749,
      "lng": -122.4194,
    },
    {
      "id": "DEL002",
      "customer": "Sarah Wilson",
      "address": "456 Pine Avenue",
      "status": "in_transit",
      "priority": "medium",
      "eta": "11:15 AM",
      "packages": 1,
      "lat": 37.7849,
      "lng": -122.4094,
    },
    {
      "id": "DEL003",
      "customer": "Mike Johnson",
      "address": "789 Elm Road",
      "status": "delivered",
      "priority": "low",
      "eta": "09:45 AM",
      "packages": 3,
      "lat": 37.7649,
      "lng": -122.4294,
    },
  ];

  List<Map<String, dynamic>> drivers = [
    {
      "id": "DRV001",
      "name": "Alex Rodriguez",
      "vehicle": "VAN-001",
      "status": "active",
      "deliveries": 5,
      "lat": 37.7749,
      "lng": -122.4194,
    },
    {
      "id": "DRV002",
      "name": "Emma Davis",
      "vehicle": "TRK-002",
      "status": "break",
      "deliveries": 3,
      "lat": 37.7849,
      "lng": -122.4094,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map View"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () => _showSearchDialog(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.layers,
            size: bs.sm,
            onPressed: () => _showLayersDialog(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Stack(
        children: [
          // Map Container
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/800/600?random=100&keyword=map"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Delivery Points
                if (showDeliveries) ..._buildDeliveryMarkers(),
                
                // Driver Markers
                if (showDrivers) ..._buildDriverMarkers(),
                
                // Routes
                if (showRoutes) ..._buildRouteLines(),
              ],
            ),
          ),
          
          // Top Control Panel
          Positioned(
            top: spMd,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Map Type Selector
                  Row(
                    children: [
                      Text(
                        "Map Type:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QHorizontalScroll(
                          children: List.generate(mapTypes.length, (index) {
                            final type = mapTypes[index];
                            final isSelected = selectedMapType == type["value"];
                            return GestureDetector(
                              onTap: () {
                                selectedMapType = type["value"];
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      type["icon"],
                                      size: 16,
                                      color: isSelected ? Colors.white : disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${type["label"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.white : disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Toggle Controls
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildToggleChip("Traffic", showTraffic, Colors.red, () {
                              showTraffic = !showTraffic;
                              setState(() {});
                            }),
                            SizedBox(width: spXs),
                            _buildToggleChip("Deliveries", showDeliveries, primaryColor, () {
                              showDeliveries = !showDeliveries;
                              setState(() {});
                            }),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildToggleChip("Routes", showRoutes, successColor, () {
                            showRoutes = !showRoutes;
                            setState(() {});
                          }),
                          SizedBox(width: spXs),
                          _buildToggleChip("Drivers", showDrivers, warningColor, () {
                            showDrivers = !showDrivers;
                            setState(() {});
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Statistics Panel
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Active Deliveries",
                          "${deliveryPoints.where((d) => d["status"] != "delivered").length}",
                          Icons.local_shipping,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Drivers Online",
                          "${drivers.where((d) => d["status"] == "active").length}",
                          Icons.person,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Completed",
                          "${deliveryPoints.where((d) => d["status"] == "delivered").length}",
                          Icons.check_circle,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Center Map",
                          icon: Icons.my_location,
                          size: bs.sm,
                          onPressed: () => _centerMap(),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Refresh",
                          icon: Icons.refresh,
                          size: bs.sm,
                          onPressed: () => _refreshMap(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Zoom Controls
          Positioned(
            right: spMd,
            top: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _zoomIn(),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          child: Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 40,
                        color: disabledColor,
                      ),
                      GestureDetector(
                        onTap: () => _zoomOut(),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          child: Icon(
                            Icons.remove,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleChip(String label, bool isActive, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isActive ? color : Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDeliveryMarkers() {
    return deliveryPoints.map((delivery) {
      Color statusColor = delivery["status"] == "delivered" 
          ? successColor 
          : delivery["status"] == "in_transit" 
              ? warningColor 
              : primaryColor;
              
      return Positioned(
        left: ((delivery["lng"] as double) + 122.4194) * 1000,
        top: (37.7749 - (delivery["lat"] as double)) * 2000 + 200,
        child: GestureDetector(
          onTap: () => _showDeliveryDetails(delivery),
          child: Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${delivery["id"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildDriverMarkers() {
    return drivers.map((driver) {
      Color statusColor = driver["status"] == "active" ? successColor : warningColor;
      
      return Positioned(
        left: ((driver["lng"] as double) + 122.4194) * 1000,
        top: (37.7749 - (driver["lat"] as double)) * 2000 + 200,
        child: GestureDetector(
          onTap: () => _showDriverDetails(driver),
          child: Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXl),
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildRouteLines() {
    return [
      Positioned(
        left: 100,
        top: 200,
        child: Container(
          width: 200,
          height: 2,
          color: primaryColor.withAlpha(150),
        ),
      ),
      Positioned(
        left: 150,
        top: 300,
        child: Container(
          width: 150,
          height: 2,
          color: successColor.withAlpha(150),
        ),
      ),
    ];
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Location"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Search",
              value: searchQuery,
              hint: "Enter address or delivery ID",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              back();
              _performSearch();
            },
          ),
        ],
      ),
    );
  }

  void _showLayersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Map Layers"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mapLayers.map((layer) {
            return CheckboxListTile(
              title: Text("${layer["label"]}"),
              value: selectedLayer == layer["value"],
              activeColor: primaryColor,
              onChanged: (value) {
                if (value == true) {
                  selectedLayer = layer["value"];
                  setState(() {});
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showDeliveryDetails(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${delivery["id"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${delivery["customer"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Text("${delivery["address"]}"),
            SizedBox(height: spSm),
            Row(
              children: [
                Text("Status: "),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${delivery["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text("ETA: ${delivery["eta"]}"),
            Text("Packages: ${delivery["packages"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          QButton(
            label: "Navigate",
            size: bs.sm,
            onPressed: () {
              back();
              // Navigate to delivery
            },
          ),
        ],
      ),
    );
  }

  void _showDriverDetails(Map<String, dynamic> driver) {
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
            Text("Deliveries: ${driver["deliveries"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          QButton(
            label: "Contact",
            size: bs.sm,
            onPressed: () {
              back();
              // Contact driver
            },
          ),
        ],
      ),
    );
  }

  void _centerMap() {
    // Center map logic
  }

  void _refreshMap() {
    // Refresh map data
  }

  void _zoomIn() {
    // Zoom in logic
  }

  void _zoomOut() {
    // Zoom out logic
  }

  void _performSearch() {
    // Search logic
  }
}

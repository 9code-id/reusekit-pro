import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDriverTrackingView extends StatefulWidget {
  const RfsDriverTrackingView({super.key});

  @override
  State<RfsDriverTrackingView> createState() => _RfsDriverTrackingViewState();
}

class _RfsDriverTrackingViewState extends State<RfsDriverTrackingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedZone = "all";
  bool showOnlineOnly = false;

  List<Map<String, dynamic>> drivers = [
    {
      "id": "DRV-001",
      "name": "Mike Johnson",
      "phone": "+1-555-0001",
      "email": "mike@delivery.com",
      "vehicle_type": "car",
      "vehicle_plate": "ABC-123",
      "status": "delivering",
      "online": true,
      "location": {"lat": 40.7128, "lng": -74.0060, "address": "123 Main St, Downtown"},
      "zone": "Downtown Core",
      "current_order": "ORD-2024-001",
      "delivery_count_today": 8,
      "total_distance": 45.2,
      "rating": 4.8,
      "last_update": "2024-06-19T14:25:00",
      "speed": 25,
      "battery_level": 85,
      "estimated_arrival": "14:35",
      "route_progress": 75
    },
    {
      "id": "DRV-002", 
      "name": "Lisa Chen",
      "phone": "+1-555-0002",
      "email": "lisa@delivery.com",
      "vehicle_type": "motorcycle",
      "vehicle_plate": "XYZ-789",
      "status": "available",
      "online": true,
      "location": {"lat": 40.7589, "lng": -73.9851, "address": "456 Oak Ave, Midtown"},
      "zone": "Residential North",
      "current_order": null,
      "delivery_count_today": 12,
      "total_distance": 67.8,
      "rating": 4.9,
      "last_update": "2024-06-19T14:20:00",
      "speed": 0,
      "battery_level": 92,
      "estimated_arrival": null,
      "route_progress": 0
    },
    {
      "id": "DRV-003",
      "name": "Tom Rodriguez",
      "phone": "+1-555-0003", 
      "email": "tom@delivery.com",
      "vehicle_type": "bicycle",
      "vehicle_plate": "BIK-456",
      "status": "returning",
      "online": true,
      "location": {"lat": 40.7356, "lng": -74.0514, "address": "789 Pine St, Westside"},
      "zone": "Suburban West",
      "current_order": null,
      "delivery_count_today": 6,
      "total_distance": 28.5,
      "rating": 4.6,
      "last_update": "2024-06-19T14:18:00",
      "speed": 15,
      "battery_level": 68,
      "estimated_arrival": "14:40",
      "route_progress": 45
    },
    {
      "id": "DRV-004",
      "name": "Sarah Wilson",
      "phone": "+1-555-0004",
      "email": "sarah@delivery.com",
      "vehicle_type": "car",
      "vehicle_plate": "DEF-456",
      "status": "offline",
      "online": false,
      "location": {"lat": 40.7156, "lng": -73.9625, "address": "321 Elm St, Eastside"},
      "zone": "Industrial East",
      "current_order": null,
      "delivery_count_today": 0,
      "total_distance": 0.0,
      "rating": 4.7,
      "last_update": "2024-06-19T12:00:00",
      "speed": 0,
      "battery_level": 45,
      "estimated_arrival": null,
      "route_progress": 0
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Drivers", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "Delivering", "value": "delivering"},
    {"label": "Returning", "value": "returning"},
    {"label": "On Break", "value": "on_break"},
    {"label": "Offline", "value": "offline"}
  ];

  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All Zones", "value": "all"},
    {"label": "Downtown Core", "value": "Downtown Core"},
    {"label": "Residential North", "value": "Residential North"},
    {"label": "Suburban West", "value": "Suburban West"},
    {"label": "Industrial East", "value": "Industrial East"}
  ];

  List<Map<String, dynamic>> get filteredDrivers {
    return drivers.where((driver) {
      bool matchesSearch = driver["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          driver["vehicle_plate"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          driver["zone"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || driver["status"] == selectedStatus;
      bool matchesZone = selectedZone == "all" || driver["zone"] == selectedZone;
      bool matchesOnline = !showOnlineOnly || driver["online"] == true;
      
      return matchesSearch && matchesStatus && matchesZone && matchesOnline;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available": return successColor;
      case "delivering": return primaryColor;
      case "returning": return warningColor;
      case "on_break": return infoColor;
      case "offline": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getVehicleIcon(String vehicleType) {
    switch (vehicleType) {
      case "car": return Icons.directions_car;
      case "motorcycle": return Icons.motorcycle;
      case "bicycle": return Icons.pedal_bike;
      case "van": return Icons.local_shipping;
      default: return Icons.delivery_dining;
    }
  }

  void _updateDriverStatus(Map<String, dynamic> driver, String newStatus) {
    driver["status"] = newStatus;
    driver["last_update"] = DateTime.now().toIso8601String();
    setState(() {});
    ss("Driver ${driver["name"]} status updated to $newStatus");
  }

  void _sendMessageToDriver(Map<String, dynamic> driver) {
    ss("Message sent to ${driver["name"]}");
  }

  void _callDriver(Map<String, dynamic> driver) {
    ss("Calling ${driver["name"]}...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Driver locations refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => _showMapView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Search drivers",
                    value: searchQuery,
                    hint: "Enter driver name, vehicle plate, or zone",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Zone",
                          items: zoneOptions,
                          value: selectedZone,
                          onChanged: (value, label) {
                            selectedZone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    label: "Show online drivers only",
                    items: [
                      {
                        "label": "Online Only",
                        "value": true,
                        "checked": showOnlineOnly,
                      }
                    ],
                    value: showOnlineOnly ? [{"label": "Online Only", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      showOnlineOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.online_prediction, color: successColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${drivers.where((d) => d["online"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Online",
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.local_shipping, color: primaryColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${drivers.where((d) => d["status"] == "delivering").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Delivering",
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: warningColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${drivers.where((d) => d["status"] == "available").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Available",
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.route, color: infoColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${(drivers.map((d) => d["total_distance"] as double).reduce((a, b) => a + b)).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total KM",
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

            // Drivers List
            Text(
              "Active Drivers (${filteredDrivers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredDrivers.map((driver) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(driver["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getStatusColor(driver["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                _getVehicleIcon(driver["vehicle_type"]),
                                color: _getStatusColor(driver["status"]),
                                size: 28,
                              ),
                            ),
                            if (driver["online"])
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                          ],
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
                                  "${driver["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 16),
                                    Text(
                                      "${driver["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${driver["vehicle_type"]} • ${driver["vehicle_plate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${driver["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(driver["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${driver["status"]}".replaceAll('_', ' ').toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Location Information
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Zone: ${driver["zone"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "${driver["location"]["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (driver["speed"] > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${driver["speed"]} km/h",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Current Order Info
                  if (driver["current_order"] != null) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.receipt, color: primaryColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order: ${driver["current_order"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (driver["estimated_arrival"] != null)
                                  Text(
                                    "ETA: ${driver["estimated_arrival"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (driver["route_progress"] > 0)
                            Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Stack(
                                children: [
                                  FractionallySizedBox(
                                    widthFactor: (driver["route_progress"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${driver["route_progress"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                  ],
                  
                  // Driver Statistics
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${driver["delivery_count_today"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Deliveries Today",
                                style: TextStyle(
                                  fontSize: 10,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${(driver["total_distance"] as double).toStringAsFixed(1)} km",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Distance Today",
                                style: TextStyle(
                                  fontSize: 10,
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    driver["battery_level"] > 20 ? Icons.battery_std : Icons.battery_alert,
                                    color: driver["battery_level"] > 20 ? infoColor : dangerColor,
                                    size: 16,
                                  ),
                                  Text(
                                    " ${driver["battery_level"]}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: driver["battery_level"] > 20 ? infoColor : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Battery",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Text(
                        "Last update: ${DateTime.parse(driver["last_update"]).dMMMykkss}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (driver["online"])
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Driver",
                          size: bs.sm,
                          onPressed: () => _callDriver(driver),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () => _sendMessageToDriver(driver),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.location_on,
                        size: bs.sm,
                        onPressed: () => _showDriverLocation(driver),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () => _showDriverActions(driver),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showMapView() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Driver Map View"),
        content: Container(
          width: 350,
          height: 300,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map, color: primaryColor, size: 80),
              SizedBox(height: spMd),
              Text(
                "Real-time Driver Locations",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Tracking ${drivers.where((d) => d["online"]).length} active drivers",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Wrap(
                spacing: spSm,
                children: drivers.where((d) => d["online"]).map((driver) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor(driver["status"]).withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getVehicleIcon(driver["vehicle_type"]),
                        color: _getStatusColor(driver["status"]),
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${driver["name"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(driver["status"]),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showDriverLocation(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${driver["name"]} Location"),
        content: Container(
          width: 300,
          height: 250,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: primaryColor, size: 64),
              SizedBox(height: spMd),
              Text(
                "${driver["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(driver["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${driver["status"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(driver["status"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "${driver["location"]["address"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Updated: ${DateTime.parse(driver["last_update"]).dMMMykkss}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Get Directions",
            onPressed: () {
              Navigator.pop(context);
              ss("Opening directions to ${driver["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _showDriverActions(Map<String, dynamic> driver) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit_location, color: primaryColor),
              title: Text("Update Status"),
              onTap: () {
                Navigator.pop(context);
                _showStatusUpdateDialog(driver);
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: successColor),
              title: Text("Assign Order"),
              onTap: () {
                Navigator.pop(context);
                ss("Opening order assignment for ${driver["name"]}");
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: warningColor),
              title: Text("View History"),
              onTap: () {
                Navigator.pop(context);
                _showDriverHistory(driver);
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics, color: infoColor),
              title: Text("View Analytics"),
              onTap: () {
                Navigator.pop(context);
                _showDriverAnalytics(driver);
              },
            ),
            if (driver["online"])
              ListTile(
                leading: Icon(Icons.pause, color: warningColor),
                title: Text("Set Offline"),
                onTap: () {
                  Navigator.pop(context);
                  driver["online"] = false;
                  _updateDriverStatus(driver, "offline");
                },
              )
            else
              ListTile(
                leading: Icon(Icons.play_arrow, color: successColor),
                title: Text("Set Online"),
                onTap: () {
                  Navigator.pop(context);
                  driver["online"] = true;
                  _updateDriverStatus(driver, "available");
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateDialog(Map<String, dynamic> driver) {
    String selectedStatus = driver["status"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update ${driver["name"]} Status"),
        content: QDropdownField(
          label: "Status",
          items: [
            {"label": "Available", "value": "available"},
            {"label": "Delivering", "value": "delivering"},
            {"label": "Returning", "value": "returning"},
            {"label": "On Break", "value": "on_break"},
            {"label": "Offline", "value": "offline"},
          ],
          value: selectedStatus,
          onChanged: (value, label) {
            selectedStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Status",
            onPressed: () {
              Navigator.pop(context);
              _updateDriverStatus(driver, selectedStatus);
            },
          ),
        ],
      ),
    );
  }

  void _showDriverHistory(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${driver["name"]} History"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text("Deliveries: ${driver["delivery_count_today"]}"),
                    Text("Distance: ${(driver["total_distance"] as double).toStringAsFixed(1)} km"),
                    Text("Rating: ${driver["rating"]} ⭐"),
                    Text("Zone: ${driver["zone"]}"),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text("Last Update: ${DateTime.parse(driver["last_update"]).dMMMykkss}"),
                    Text("Vehicle: ${driver["vehicle_type"]} (${driver["vehicle_plate"]})"),
                    Text("Battery: ${driver["battery_level"]}%"),
                    if (driver["current_order"] != null)
                      Text("Current Order: ${driver["current_order"]}"),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showDriverAnalytics(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${driver["name"]} Analytics"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Performance Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${driver["delivery_count_today"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text("Deliveries"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${driver["rating"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text("Rating"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(driver["total_distance"] as double).toStringAsFixed(1)} km",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text("Distance"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${driver["battery_level"]}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: driver["battery_level"] > 20 ? infoColor : dangerColor,
                                ),
                              ),
                              Text("Battery"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

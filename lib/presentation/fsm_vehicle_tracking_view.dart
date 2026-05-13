import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmVehicleTrackingView extends StatefulWidget {
  const FsmVehicleTrackingView({super.key});

  @override
  State<FsmVehicleTrackingView> createState() => _FsmVehicleTrackingViewState();
}

class _FsmVehicleTrackingViewState extends State<FsmVehicleTrackingView> {
  String selectedVehicle = "All";
  String selectedStatus = "All";
  bool showMaintenanceAlerts = true;
  bool showFuelAlerts = true;
  String trackingMode = "Real-time";

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VEH-001",
      "plate": "FSM-001",
      "make": "Ford",
      "model": "Transit",
      "year": 2022,
      "type": "Van",
      "status": "Active",
      "assignedTo": "John Smith",
      "currentLat": 37.7749,
      "currentLng": -122.4194,
      "lastUpdate": "2024-01-15 14:30:25",
      "speed": 35,
      "heading": 45,
      "fuel": 75,
      "mileage": 45250,
      "dailyMiles": 125,
      "engineHours": 2850,
      "maintenanceDue": "2024-02-15",
      "nextService": "Oil Change",
      "batteryVoltage": 12.6,
      "engineTemp": 195,
      "alerts": ["Low Fuel Warning"],
    },
    {
      "id": "VEH-002",
      "plate": "FSM-002",
      "make": "Chevrolet",
      "model": "Express",
      "year": 2021,
      "type": "Van",
      "status": "Active",
      "assignedTo": "Mike Johnson",
      "currentLat": 37.7849,
      "currentLng": -122.4094,
      "lastUpdate": "2024-01-15 14:28:10",
      "speed": 0,
      "heading": 0,
      "fuel": 60,
      "mileage": 52100,
      "dailyMiles": 89,
      "engineHours": 3150,
      "maintenanceDue": "2024-01-25",
      "nextService": "Brake Inspection",
      "batteryVoltage": 12.4,
      "engineTemp": 185,
      "alerts": ["Maintenance Due"],
    },
    {
      "id": "VEH-003",
      "plate": "FSM-003",
      "make": "Ram",
      "model": "ProMaster",
      "year": 2023,
      "type": "Van",
      "status": "Active",
      "assignedTo": "Sarah Wilson",
      "currentLat": 37.7649,
      "currentLng": -122.4294,
      "lastUpdate": "2024-01-15 14:32:15",
      "speed": 28,
      "heading": 180,
      "fuel": 40,
      "mileage": 38750,
      "dailyMiles": 156,
      "engineHours": 2450,
      "maintenanceDue": "2024-03-10",
      "nextService": "Tire Rotation",
      "batteryVoltage": 12.8,
      "engineTemp": 190,
      "alerts": ["Low Fuel Warning", "High Mileage Today"],
    },
    {
      "id": "VEH-004",
      "plate": "FSM-004",
      "make": "Isuzu",
      "model": "NPR",
      "year": 2020,
      "type": "Truck",
      "status": "Maintenance",
      "assignedTo": "David Brown",
      "currentLat": 37.7549,
      "currentLng": -122.4394,
      "lastUpdate": "2024-01-15 08:45:30",
      "speed": 0,
      "heading": 0,
      "fuel": 85,
      "mileage": 78500,
      "dailyMiles": 0,
      "engineHours": 4250,
      "maintenanceDue": "2024-01-15",
      "nextService": "Transmission Service",
      "batteryVoltage": 12.2,
      "engineTemp": 0,
      "alerts": ["In Maintenance", "Engine Not Running"],
    },
  ];

  List<Map<String, dynamic>> maintenanceAlerts = [
    {
      "vehicleId": "VEH-002",
      "plate": "FSM-002",
      "type": "Brake Inspection",
      "priority": "High",
      "dueDate": "2024-01-25",
      "mileage": 52100,
      "description": "Brake inspection due at 50,000 miles",
      "estimatedCost": 150.00,
    },
    {
      "vehicleId": "VEH-004",
      "plate": "FSM-004",
      "type": "Transmission Service",
      "priority": "Critical",
      "dueDate": "2024-01-15",
      "mileage": 78500,
      "description": "Transmission service overdue",
      "estimatedCost": 450.00,
    },
    {
      "vehicleId": "VEH-001",
      "plate": "FSM-001",
      "type": "Oil Change",
      "priority": "Medium",
      "dueDate": "2024-02-15",
      "mileage": 45250,
      "description": "Regular oil change due",
      "estimatedCost": 75.00,
    },
  ];

  List<Map<String, dynamic>> fuelAlerts = [
    {
      "vehicleId": "VEH-001",
      "plate": "FSM-001",
      "fuelLevel": 75,
      "alertType": "Low Fuel",
      "location": "Market St, San Francisco",
      "nearestStation": "Shell - 0.5 miles",
      "estimatedRange": 45,
    },
    {
      "vehicleId": "VEH-003",
      "plate": "FSM-003",
      "fuelLevel": 40,
      "alertType": "Low Fuel",
      "location": "Mission District",
      "nearestStation": "Chevron - 0.3 miles",
      "estimatedRange": 25,
    },
  ];

  List<Map<String, dynamic>> vehicleHistory = [
    {
      "timestamp": "2024-01-15 14:30:25",
      "vehicle": "FSM-001",
      "event": "Speed Alert",
      "details": "Speed exceeded 45 mph in 35 mph zone",
      "location": "Market St",
      "severity": "Medium",
    },
    {
      "timestamp": "2024-01-15 14:25:10",
      "vehicle": "FSM-002",
      "event": "Maintenance Alert",
      "details": "Brake inspection due in 10 days",
      "location": "Office",
      "severity": "High",
    },
    {
      "timestamp": "2024-01-15 14:20:45",
      "vehicle": "FSM-003",
      "event": "Fuel Alert",
      "details": "Fuel level below 45%",
      "location": "Mission District",
      "severity": "Medium",
    },
    {
      "timestamp": "2024-01-15 14:15:30",
      "vehicle": "FSM-004",
      "event": "Engine Off",
      "details": "Vehicle parked at maintenance facility",
      "location": "Service Center",
      "severity": "Low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new vehicle
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Vehicle settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildVehicleOverview(),
            _buildTrackingFilters(),
            _buildVehicleList(),
            _buildMaintenanceAlerts(),
            _buildFuelAlerts(),
            _buildVehicleHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleOverview() {
    int activeVehicles = vehicles.where((v) => v["status"] == "Active").length;
    int maintenanceVehicles = vehicles.where((v) => v["status"] == "Maintenance").length;
    double avgFuel = vehicles.fold(0.0, (sum, v) => sum + (v["fuel"] as num)) / vehicles.length;
    int totalAlerts = vehicles.fold(0, (sum, v) => sum + (v["alerts"] as List).length);

    return Container(
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
            "Fleet Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(child: _buildOverviewCard("Active", "$activeVehicles", successColor, Icons.check_circle)),
              SizedBox(width: spSm),
              Expanded(child: _buildOverviewCard("Maintenance", "$maintenanceVehicles", warningColor, Icons.build)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildOverviewCard("Avg Fuel", "${avgFuel.toStringAsFixed(0)}%", infoColor, Icons.local_gas_station)),
              SizedBox(width: spSm),
              Expanded(child: _buildOverviewCard("Alerts", "$totalAlerts", dangerColor, Icons.warning)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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
        ],
      ),
    );
  }

  Widget _buildTrackingFilters() {
    return Container(
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
            "Tracking Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle",
                  items: [
                    {"label": "All Vehicles", "value": "All"},
                    ...vehicles.map((v) => {
                      "label": "${v["plate"]} - ${v["make"]} ${v["model"]}",
                      "value": v["id"],
                    }),
                  ],
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "All"},
                    {"label": "Active", "value": "Active"},
                    {"label": "Maintenance", "value": "Maintenance"},
                    {"label": "Offline", "value": "Offline"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Maintenance Alerts",
                      "value": true,
                      "checked": showMaintenanceAlerts,
                    }
                  ],
                  value: [
                    if (showMaintenanceAlerts)
                      {
                        "label": "Maintenance Alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      showMaintenanceAlerts = values.isNotEmpty;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Fuel Alerts",
                      "value": true,
                      "checked": showFuelAlerts,
                    }
                  ],
                  value: [
                    if (showFuelAlerts)
                      {
                        "label": "Fuel Alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      showFuelAlerts = values.isNotEmpty;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList() {
    List<Map<String, dynamic>> filteredVehicles = vehicles;
    
    if (selectedVehicle != "All") {
      filteredVehicles = vehicles.where((v) => v["id"] == selectedVehicle).toList();
    }
    
    if (selectedStatus != "All") {
      filteredVehicles = filteredVehicles.where((v) => v["status"] == selectedStatus).toList();
    }

    return Container(
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
            "Vehicle Fleet",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...filteredVehicles.map((vehicle) => _buildVehicleItem(vehicle)),
        ],
      ),
    );
  }

  Widget _buildVehicleItem(Map<String, dynamic> vehicle) {
    Color statusColor;
    IconData statusIcon;
    
    switch (vehicle["status"]) {
      case "Active":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Maintenance":
        statusColor = warningColor;
        statusIcon = Icons.build;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.pause_circle;
    }

    Color fuelColor = vehicle["fuel"] > 25 ? successColor : dangerColor;
    List<String> alerts = List<String>.from(vehicle["alerts"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  vehicle["type"] == "Van" ? Icons.airport_shuttle : Icons.local_shipping,
                  color: statusColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle["plate"]} - ${vehicle["make"]} ${vehicle["model"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Assigned to: ${vehicle["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last update: ${vehicle["lastUpdate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${vehicle["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (vehicle["speed"] > 0) ...[
                    Text(
                      "${vehicle["speed"]} mph",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_gas_station, size: 16, color: fuelColor),
                              SizedBox(width: spXs),
                              Text(
                                "Fuel: ${vehicle["fuel"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: fuelColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.speed, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "Mileage: ${vehicle["mileage"]}",
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
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.today, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "Today: ${vehicle["dailyMiles"]} mi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "Engine: ${vehicle["engineHours"]}h",
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
                  ],
                ),
                if (alerts.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: alerts.map((alert) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        alert,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewVehicleDetails(vehicle),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Track Location",
                  size: bs.sm,
                  onPressed: () => _trackVehicle(vehicle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAlerts() {
    if (!showMaintenanceAlerts) return SizedBox();

    return Container(
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
            "Maintenance Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...maintenanceAlerts.map((alert) => _buildMaintenanceAlert(alert)),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAlert(Map<String, dynamic> alert) {
    Color priorityColor;
    switch (alert["priority"]) {
      case "Critical":
        priorityColor = dangerColor;
        break;
      case "High":
        priorityColor = warningColor;
        break;
      default:
        priorityColor = infoColor;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(51)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.build,
            color: priorityColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["plate"]} - ${alert["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Due: ${alert["dueDate"]} • Est. Cost: \$${((alert["estimatedCost"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${alert["priority"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelAlerts() {
    if (!showFuelAlerts) return SizedBox();

    return Container(
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
            "Fuel Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...fuelAlerts.map((alert) => _buildFuelAlert(alert)),
        ],
      ),
    );
  }

  Widget _buildFuelAlert(Map<String, dynamic> alert) {
    Color fuelColor = alert["fuelLevel"] > 25 ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: fuelColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: fuelColor.withAlpha(51)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_gas_station,
            color: fuelColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["plate"]} - ${alert["alertType"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Current location: ${alert["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Nearest station: ${alert["nearestStation"]} • Range: ${alert["estimatedRange"]} miles",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${alert["fuelLevel"]}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: fuelColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleHistory() {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...vehicleHistory.take(4).map((event) => _buildHistoryItem(event)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> event) {
    Color severityColor;
    IconData eventIcon;
    
    switch (event["severity"]) {
      case "High":
        severityColor = dangerColor;
        eventIcon = Icons.warning;
        break;
      case "Medium":
        severityColor = warningColor;
        eventIcon = Icons.info;
        break;
      default:
        severityColor = infoColor;
        eventIcon = Icons.circle;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            eventIcon,
            color: severityColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["event"]} - ${event["vehicle"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${event["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${event["location"]} • ${event["timestamp"].substring(11, 16)}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: severityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${event["severity"]}",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _viewVehicleDetails(Map<String, dynamic> vehicle) {
    // Navigate to vehicle details
  }

  void _trackVehicle(Map<String, dynamic> vehicle) {
    ss("Tracking ${vehicle["plate"]} on map");
  }
}

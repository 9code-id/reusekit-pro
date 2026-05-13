import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRoutePlanningView extends StatefulWidget {
  const FsmRoutePlanningView({super.key});

  @override
  State<FsmRoutePlanningView> createState() => _FsmRoutePlanningViewState();
}

class _FsmRoutePlanningViewState extends State<FsmRoutePlanningView> {
  List<Map<String, dynamic>> routes = [
    {
      "id": "1",
      "technician": "John Smith",
      "date": DateTime.now(),
      "totalDistance": 45.2,
      "estimatedTime": 6.5,
      "fuelCost": 32.50,
      "efficiency": 92,
      "status": "Active",
      "stops": [
        {
          "id": "1",
          "location": "TechCorp Building",
          "address": "123 Business St, Downtown",
          "jobTitle": "HVAC Maintenance",
          "estimatedDuration": 2.5,
          "priority": "High",
          "distance": 8.5,
          "arrivalTime": "09:00",
          "status": "Completed"
        },
        {
          "id": "2", 
          "location": "Green Office Complex",
          "address": "456 Commerce Ave, Midtown",
          "jobTitle": "Electrical Inspection",
          "estimatedDuration": 1.5,
          "priority": "Medium",
          "distance": 12.3,
          "arrivalTime": "11:45",
          "status": "In Progress"
        },
        {
          "id": "3",
          "location": "Manufacturing Plant",
          "address": "789 Industrial Blvd, East Side",
          "jobTitle": "Emergency Repair",
          "estimatedDuration": 3.0,
          "priority": "Critical",
          "distance": 18.2,
          "arrivalTime": "14:00",
          "status": "Scheduled"
        },
        {
          "id": "4",
          "location": "Retail Center",
          "address": "321 Shopping Mall Dr, West End",
          "jobTitle": "System Upgrade",
          "estimatedDuration": 2.0,
          "priority": "Medium",
          "distance": 6.2,
          "arrivalTime": "17:30",
          "status": "Scheduled"
        }
      ]
    },
    {
      "id": "2",
      "technician": "Sarah Johnson",
      "date": DateTime.now(),
      "totalDistance": 38.7,
      "estimatedTime": 5.8,
      "fuelCost": 28.40,
      "efficiency": 88,
      "status": "Planned",
      "stops": [
        {
          "id": "1",
          "location": "Hospital Complex",
          "address": "111 Medical Center Dr",
          "jobTitle": "Critical System Check",
          "estimatedDuration": 4.0,
          "priority": "Critical",
          "distance": 15.5,
          "arrivalTime": "08:00",
          "status": "Scheduled"
        },
        {
          "id": "2",
          "location": "School District Office",
          "address": "222 Education Way",
          "jobTitle": "Safety Inspection",
          "estimatedDuration": 2.5,
          "priority": "High",
          "distance": 11.8,
          "arrivalTime": "13:00",
          "status": "Scheduled"
        },
        {
          "id": "3",
          "location": "Community Center",
          "address": "333 Community Blvd",
          "jobTitle": "Maintenance Work",
          "estimatedDuration": 1.5,
          "priority": "Low",
          "distance": 11.4,
          "arrivalTime": "16:00",
          "status": "Scheduled"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> optimizationOptions = [
    {"label": "Shortest Distance", "value": "distance", "description": "Minimize total travel distance"},
    {"label": "Fastest Route", "value": "time", "description": "Minimize total travel time"},
    {"label": "Priority Based", "value": "priority", "description": "High priority jobs first"},
    {"label": "Fuel Efficient", "value": "fuel", "description": "Minimize fuel consumption"},
  ];

  String selectedOptimization = "distance";
  bool showRouteForm = false;
  Map<String, dynamic>? selectedRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              selectedRoute = null;
              showRouteForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildRouteSummary(),
            _buildOptimizationControls(),
            _buildRoutesList(),
            if (showRouteForm) _buildRouteForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteSummary() {
    double totalDistance = routes.fold(0.0, (sum, route) => sum + (route["totalDistance"] as double));
    double totalTime = routes.fold(0.0, (sum, route) => sum + (route["estimatedTime"] as double));
    double totalFuelCost = routes.fold(0.0, (sum, route) => sum + (route["fuelCost"] as double));
    double avgEfficiency = routes.fold(0.0, (sum, route) => sum + (route["efficiency"] as int)) / routes.length;

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
            "Today's Route Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              _buildSummaryCard("Total Distance", "${totalDistance.toStringAsFixed(1)} km", successColor),
              _buildSummaryCard("Estimated Time", "${totalTime.toStringAsFixed(1)} hrs", infoColor),
              _buildSummaryCard("Fuel Cost", "\$${totalFuelCost.toStringAsFixed(2)}", warningColor),
              _buildSummaryCard("Avg Efficiency", "${avgEfficiency.toStringAsFixed(0)}%", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizationControls() {
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
            children: [
              Icon(Icons.tune, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Route Optimization",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Optimization Method",
            items: optimizationOptions,
            value: selectedOptimization,
            onChanged: (value, label) {
              selectedOptimization = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Optimize All Routes",
                  size: bs.sm,
                  onPressed: () {
                    ss("Routes optimized successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Auto-Assign Jobs",
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Jobs auto-assigned to technicians");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesList() {
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
            "Active Routes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: routes.map((route) => _buildRouteCard(route)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    Color statusColor = route["status"] == "Active" ? successColor :
                       route["status"] == "Planned" ? warningColor : disabledBoldColor;

    List<Map<String, dynamic>> stops = route["stops"] as List<Map<String, dynamic>>;
    int completedStops = stops.where((stop) => stop["status"] == "Completed").length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Text(
                  "${route["technician"]}".substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${route["technician"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stops.length} stops • $completedStops completed",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${route["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Text(
                    "${route["efficiency"]}% efficiency",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Route Stats
          Row(
            children: [
              _buildRouteStatItem(Icons.straighten, "${route["totalDistance"]} km"),
              _buildRouteStatItem(Icons.access_time, "${route["estimatedTime"]}h"),
              _buildRouteStatItem(Icons.local_gas_station, "\$${(route["fuelCost"] as double).toStringAsFixed(2)}"),
            ],
          ),
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Text(
                    "Progress: $completedStops/${stops.length} stops",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${((completedStops / stops.length) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: completedStops / stops.length,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ],
          ),
          // Route Stops
          ExpansionTile(
            title: Text(
              "Route Details",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Column(
                spacing: spSm,
                children: stops.map((stop) => _buildStopCard(stop)).toList(),
              ),
            ],
          ),
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Map",
                  size: bs.sm,
                  onPressed: () {
                    ss("Opening route map");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Optimize",
                  color: warningColor,
                  size: bs.sm,
                  onPressed: () {
                    selectedRoute = route;
                    showRouteForm = true;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteStatItem(IconData icon, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopCard(Map<String, dynamic> stop) {
    Color statusColor = stop["status"] == "Completed" ? successColor :
                       stop["status"] == "In Progress" ? infoColor : warningColor;

    Color priorityColor = stop["priority"] == "Critical" ? dangerColor :
                         stop["priority"] == "High" ? warningColor :
                         stop["priority"] == "Medium" ? infoColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${stop["id"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "${stop["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stop["jobTitle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${stop["address"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 2,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${stop["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Text(
                    "${stop["arrivalTime"]}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 36), // Align with content above
              Icon(Icons.timer, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${stop["estimatedDuration"]}h",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.straighten, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${stop["distance"]}km",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${stop["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteForm() {
    bool isEditing = selectedRoute != null;

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
            children: [
              Text(
                isEditing ? "Optimize Route" : "Create New Route",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showRouteForm = false;
                  selectedRoute = null;
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          if (!isEditing) ...[
            QDropdownField(
              label: "Select Technician",
              items: [
                {"label": "John Smith", "value": "John Smith"},
                {"label": "Sarah Johnson", "value": "Sarah Johnson"},
                {"label": "Mike Davis", "value": "Mike Davis"},
                {"label": "Emma Wilson", "value": "Emma Wilson"},
              ],
              value: "",
              onChanged: (value, label) {},
            ),
            QDatePicker(
              label: "Route Date",
              value: DateTime.now(),
              onChanged: (value) {},
            ),
          ],
          QDropdownField(
            label: "Optimization Method",
            items: optimizationOptions,
            value: selectedOptimization,
            onChanged: (value, label) {
              selectedOptimization = value;
              setState(() {});
            },
          ),
          if (isEditing) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Current Route: ${selectedRoute!["technician"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Distance: ${selectedRoute!["totalDistance"]}km • Time: ${selectedRoute!["estimatedTime"]}h",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Fuel Cost: \$${(selectedRoute!["fuelCost"] as double).toStringAsFixed(2)} • Efficiency: ${selectedRoute!["efficiency"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          QMemoField(
            label: "Optimization Notes",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showRouteForm = false;
                    selectedRoute = null;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: isEditing ? "Optimize Route" : "Create Route",
                  size: bs.sm,
                  onPressed: () {
                    ss(isEditing ? "Route optimized successfully" : "Route created successfully");
                    showRouteForm = false;
                    selectedRoute = null;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaUnloadingView extends StatefulWidget {
  const DlaUnloadingView({super.key});

  @override
  State<DlaUnloadingView> createState() => _DlaUnloadingViewState();
}

class _DlaUnloadingViewState extends State<DlaUnloadingView> {
  String selectedDock = "dock_1";
  String selectedVehicle = "";
  String selectedShipment = "";
  bool isProcessing = false;
  
  final List<Map<String, dynamic>> dockOptions = [
    {"label": "Dock 1 - Receiving Bay A", "value": "dock_1"},
    {"label": "Dock 2 - Receiving Bay B", "value": "dock_2"},
    {"label": "Dock 3 - Receiving Bay C", "value": "dock_3"},
    {"label": "Dock 4 - Cold Storage", "value": "dock_4"},
  ];

  final List<Map<String, dynamic>> incomingVehicles = [
    {"label": "DLA-005 - B 7890 MNO (Truck - From Bandung)", "value": "DLA-005"},
    {"label": "DLA-006 - B 2468 PQR (Van - From Surabaya)", "value": "DLA-006"},
    {"label": "DLA-007 - B 1357 STU (Truck - From Medan)", "value": "DLA-007"},
  ];

  final List<Map<String, dynamic>> shipmentOptions = [
    {"label": "SHP-2024-001 - Electronics Return", "value": "SHP-2024-001"},
    {"label": "SHP-2024-002 - New Inventory Delivery", "value": "SHP-2024-002"},
    {"label": "SHP-2024-003 - Supplier Restock", "value": "SHP-2024-003"},
  ];

  final List<Map<String, dynamic>> activeUnloadingOperations = [
    {
      "id": "UNLOAD-001",
      "shipmentId": "SHP-2024-001",
      "vehicleId": "DLA-005",
      "dock": "Dock 1 - Receiving Bay A",
      "arrivalTime": "2024-01-15 09:30",
      "startTime": "2024-01-15 09:45",
      "estimatedCompletion": "2024-01-15 11:15",
      "progress": 40,
      "totalItems": 20,
      "unloadedItems": 8,
      "supervisor": "John Smith",
      "status": "in_progress",
      "priority": "medium",
      "origin": "Bandung Hub",
      "shipmentType": "return",
    },
    {
      "id": "UNLOAD-002",
      "shipmentId": "SHP-2024-002",
      "vehicleId": "DLA-006",
      "dock": "Dock 2 - Receiving Bay B",
      "arrivalTime": "2024-01-15 08:15",
      "startTime": "2024-01-15 08:30",
      "estimatedCompletion": "2024-01-15 10:00",
      "progress": 85,
      "totalItems": 35,
      "unloadedItems": 30,
      "supervisor": "Sarah Johnson",
      "status": "almost_complete",
      "priority": "high",
      "origin": "Surabaya Center",
      "shipmentType": "delivery",
    },
    {
      "id": "UNLOAD-003",
      "shipmentId": "SHP-2024-003",
      "vehicleId": "DLA-007",
      "dock": "Dock 4 - Cold Storage",
      "arrivalTime": "2024-01-15 10:00",
      "startTime": "2024-01-15 10:15",
      "estimatedCompletion": "2024-01-15 12:30",
      "progress": 15,
      "totalItems": 50,
      "unloadedItems": 8,
      "supervisor": "Mike Wilson",
      "status": "in_progress",
      "priority": "high",
      "origin": "Medan Branch",
      "shipmentType": "restock",
    },
  ];

  final List<Map<String, dynamic>> expectedArrivals = [
    {
      "vehicleId": "DLA-008",
      "shipmentId": "SHP-2024-004",
      "origin": "Yogyakarta",
      "estimatedArrival": "11:30",
      "items": 25,
      "shipmentType": "delivery",
      "priority": "medium",
      "driver": "Tom Anderson",
      "contact": "+62 812 3456 7890",
    },
    {
      "vehicleId": "DLA-009",
      "shipmentId": "SHP-2024-005",
      "origin": "Semarang",
      "estimatedArrival": "13:45",
      "items": 40,
      "shipmentType": "return",
      "priority": "low",
      "driver": "Lisa Chen",
      "contact": "+62 813 5678 9012",
    },
    {
      "vehicleId": "DLA-010",
      "shipmentId": "SHP-2024-006",
      "origin": "Bali",
      "estimatedArrival": "15:20",
      "items": 18,
      "shipmentType": "restock",
      "priority": "high",
      "driver": "David Kim",
      "contact": "+62 814 7890 1234",
    },
  ];

  final List<Map<String, dynamic>> completedUnloadings = [
    {
      "id": "UNLOAD-COMP-001",
      "shipmentId": "SHP-2024-007",
      "vehicleId": "DLA-011",
      "completedTime": "08:45",
      "items": 30,
      "duration": "1h 15m",
      "supervisor": "Anna Davis",
      "origin": "Malang",
    },
    {
      "id": "UNLOAD-COMP-002",
      "shipmentId": "SHP-2024-008",
      "vehicleId": "DLA-012",
      "completedTime": "07:30",
      "items": 15,
      "duration": "45m",
      "supervisor": "Robert Wang",
      "origin": "Solo",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "in_progress":
        return infoColor;
      case "almost_complete":
        return warningColor;
      case "completed":
        return successColor;
      case "delayed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getShipmentTypeColor(String type) {
    switch (type) {
      case "delivery":
        return successColor;
      case "return":
        return warningColor;
      case "restock":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getShipmentTypeIcon(String type) {
    switch (type) {
      case "delivery":
        return Icons.local_shipping;
      case "return":
        return Icons.keyboard_return;
      case "restock":
        return Icons.inventory;
      default:
        return Icons.local_shipping;
    }
  }

  Widget _buildUnloadingDashboard() {
    int activeOperations = activeUnloadingOperations.length;
    int completedToday = completedUnloadings.length + 6; // Plus earlier completions
    int expectedArrivalsCount = expectedArrivals.length;
    double averageUnloadingTime = 1.8; // hours

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
            "Unloading Operations Dashboard",
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
                      Icon(Icons.unarchive, color: infoColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "$activeOperations",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Active",
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
                      Icon(Icons.check_circle, color: successColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "$completedToday",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
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
                      Icon(Icons.schedule, color: warningColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "$expectedArrivalsCount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Expected",
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
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.timer, color: primaryColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "${averageUnloadingTime}h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Avg Time",
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
    );
  }

  Widget _buildNewUnloadingForm() {
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
            "Start New Unloading Operation",
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
                child: QDropdownField(
                  label: "Receiving Dock",
                  items: dockOptions,
                  value: selectedDock,
                  onChanged: (value, label) {
                    selectedDock = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Incoming Vehicle",
                  items: incomingVehicles,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Shipment to Unload",
            items: shipmentOptions,
            value: selectedShipment,
            onChanged: (value, label) {
              selectedShipment = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: isProcessing ? "Starting Unloading..." : "Start Unloading Operation",
              size: bs.md,
              onPressed: () async {
                if (selectedVehicle.isEmpty || selectedShipment.isEmpty) {
                  se("Please select both vehicle and shipment");
                  return;
                }
                
                isProcessing = true;
                setState(() {});
                
                await Future.delayed(Duration(seconds: 2));
                
                isProcessing = false;
                setState(() {});
                
                ss("Unloading operation started successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOperations() {
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
            "Active Unloading Operations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activeUnloadingOperations.map((operation) {
            Color statusColor = _getStatusColor(operation["status"]);
            Color priorityColor = _getPriorityColor(operation["priority"]);
            Color typeColor = _getShipmentTypeColor(operation["shipmentType"]);
            double progressValue = (operation["progress"] as int) / 100;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: statusColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getShipmentTypeIcon(operation["shipmentType"]),
                        color: typeColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${operation["id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                          "${operation["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${operation["shipmentType"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: typeColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "From: ${operation["origin"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Shipment: ${operation["shipmentId"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Vehicle: ${operation["vehicleId"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${operation["dock"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.person, color: disabledBoldColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${operation["supervisor"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress: ${operation["unloadedItems"]}/${operation["totalItems"]} items",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${operation["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progressValue,
                            child: Container(
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Arrived: ${operation["arrivalTime"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "ETA: ${operation["estimatedCompletion"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Update Progress",
                          size: bs.sm,
                          onPressed: () {
                            si("Update progress for ${operation["id"]}");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            si("View details for ${operation["id"]}");
                          },
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
    );
  }

  Widget _buildExpectedArrivals() {
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
            "Expected Arrivals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...expectedArrivals.map((arrival) {
            Color priorityColor = _getPriorityColor(arrival["priority"]);
            Color typeColor = _getShipmentTypeColor(arrival["shipmentType"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: priorityColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: priorityColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getShipmentTypeIcon(arrival["shipmentType"]),
                        color: typeColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${arrival["vehicleId"]} - ${arrival["shipmentId"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                          "${arrival["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${arrival["shipmentType"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: typeColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "From: ${arrival["origin"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "ETA: ${arrival["estimatedArrival"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${arrival["items"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: disabledBoldColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${arrival["driver"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.phone, color: disabledBoldColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${arrival["contact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildCompletedUnloadings() {
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
                "Today's Completed Unloadings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  si("View all completed unloadings");
                },
              ),
            ],
          ),
          ...completedUnloadings.map((completed) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 18),
                      SizedBox(width: spXs),
                      Text(
                        "${completed["id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Completed: ${completed["completedTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${completed["shipmentId"]} - ${completed["vehicleId"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "From: ${completed["origin"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${completed["items"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Duration: ${completed["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "By: ${completed["supervisor"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unloading Operations"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              si("Scan unloading barcode");
            },
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refresh unloading status");
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
            _buildUnloadingDashboard(),
            _buildNewUnloadingForm(),
            _buildActiveOperations(),
            Row(
              spacing: spMd,
              children: [
                Expanded(child: _buildExpectedArrivals()),
                Expanded(child: _buildCompletedUnloadings()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

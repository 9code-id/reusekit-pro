import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaLoadingView extends StatefulWidget {
  const DlaLoadingView({super.key});

  @override
  State<DlaLoadingView> createState() => _DlaLoadingViewState();
}

class _DlaLoadingViewState extends State<DlaLoadingView> {
  String selectedDock = "dock_1";
  String selectedVehicle = "";
  String selectedOrder = "";
  bool isLoading = false;
  
  final List<Map<String, dynamic>> dockOptions = [
    {"label": "Dock 1 - Bay A", "value": "dock_1"},
    {"label": "Dock 2 - Bay B", "value": "dock_2"},
    {"label": "Dock 3 - Bay C", "value": "dock_3"},
    {"label": "Dock 4 - Bay D", "value": "dock_4"},
  ];

  final List<Map<String, dynamic>> vehicleOptions = [
    {"label": "DLA-001 - B 1234 ABC (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 - B 5678 DEF (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-004 - B 3456 JKL (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> orderOptions = [
    {"label": "ORD-2024-001 - Electronics Shipment", "value": "ORD-2024-001"},
    {"label": "ORD-2024-002 - Clothing Items", "value": "ORD-2024-002"},
    {"label": "ORD-2024-003 - Food Products", "value": "ORD-2024-003"},
    {"label": "ORD-2024-004 - Book Collection", "value": "ORD-2024-004"},
  ];

  final List<Map<String, dynamic>> currentLoadingOperations = [
    {
      "id": "LOAD-001",
      "orderId": "ORD-2024-001",
      "vehicleId": "DLA-001",
      "dock": "Dock 1 - Bay A",
      "startTime": "2024-01-15 08:00",
      "estimatedCompletion": "2024-01-15 10:30",
      "progress": 65,
      "items": 15,
      "loadedItems": 10,
      "supervisor": "John Smith",
      "status": "in_progress",
      "priority": "high",
    },
    {
      "id": "LOAD-002",
      "orderId": "ORD-2024-002",
      "vehicleId": "DLA-002",
      "dock": "Dock 2 - Bay B",
      "startTime": "2024-01-15 09:15",
      "estimatedCompletion": "2024-01-15 11:45",
      "progress": 30,
      "items": 25,
      "loadedItems": 8,
      "supervisor": "Sarah Johnson",
      "status": "in_progress",
      "priority": "medium",
    },
    {
      "id": "LOAD-003",
      "orderId": "ORD-2024-003",
      "vehicleId": "DLA-004",
      "dock": "Dock 3 - Bay C",
      "startTime": "2024-01-15 07:30",
      "estimatedCompletion": "2024-01-15 09:00",
      "progress": 95,
      "items": 12,
      "loadedItems": 11,
      "supervisor": "Mike Wilson",
      "status": "almost_complete",
      "priority": "high",
    },
  ];

  final List<Map<String, dynamic>> pendingLoadings = [
    {
      "orderId": "ORD-2024-005",
      "destination": "Jakarta → Bandung",
      "items": 18,
      "weight": "2,500 kg",
      "priority": "medium",
      "scheduledTime": "10:00",
      "vehicleType": "truck",
    },
    {
      "orderId": "ORD-2024-006",
      "destination": "Jakarta → Surabaya",
      "items": 22,
      "weight": "3,200 kg",
      "priority": "high",
      "scheduledTime": "11:30",
      "vehicleType": "van",
    },
    {
      "orderId": "ORD-2024-007",
      "destination": "Jakarta → Medan",
      "items": 8,
      "weight": "800 kg",
      "priority": "low",
      "scheduledTime": "14:00",
      "vehicleType": "motorcycle",
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

  IconData _getVehicleIcon(String vehicleType) {
    switch (vehicleType) {
      case "truck":
        return Icons.local_shipping;
      case "van":
        return Icons.fire_truck;
      case "motorcycle":
        return Icons.two_wheeler;
      default:
        return Icons.local_shipping;
    }
  }

  Widget _buildLoadingDashboard() {
    int totalOperations = currentLoadingOperations.length;
    int completedToday = 8;
    int pendingOperations = pendingLoadings.length;
    double averageLoadingTime = 2.5; // hours

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
            "Loading Operations Dashboard",
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
                      Icon(Icons.play_circle, color: infoColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "$totalOperations",
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
                      Icon(Icons.pending, color: warningColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "$pendingOperations",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
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
                      Icon(Icons.schedule, color: primaryColor, size: 28),
                      SizedBox(height: spXs),
                      Text(
                        "${averageLoadingTime}h",
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

  Widget _buildNewLoadingForm() {
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
            "Start New Loading Operation",
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
                  label: "Loading Dock",
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
                  label: "Vehicle",
                  items: vehicleOptions,
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
            label: "Order to Load",
            items: orderOptions,
            value: selectedOrder,
            onChanged: (value, label) {
              selectedOrder = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: isLoading ? "Starting Loading..." : "Start Loading Operation",
              size: bs.md,
              onPressed: () async {
                if (selectedVehicle.isEmpty || selectedOrder.isEmpty) {
                  se("Please select both vehicle and order");
                  return;
                }
                
                isLoading = true;
                setState(() {});
                
                await Future.delayed(Duration(seconds: 2));
                
                isLoading = false;
                setState(() {});
                
                ss("Loading operation started successfully");
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
            "Active Loading Operations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...currentLoadingOperations.map((operation) {
            Color statusColor = _getStatusColor(operation["status"]);
            Color priorityColor = _getPriorityColor(operation["priority"]);
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
                      Icon(Icons.local_shipping, color: statusColor, size: 20),
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
                      Text(
                        "Order: ${operation["orderId"]}",
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
                              "Progress: ${operation["loadedItems"]}/${operation["items"]} items",
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
                        "Started: ${operation["startTime"]}",
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

  Widget _buildPendingQueue() {
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
            "Pending Loading Queue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...pendingLoadings.map((pending) {
            Color priorityColor = _getPriorityColor(pending["priority"]);
            
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
                        _getVehicleIcon(pending["vehicleType"]),
                        color: priorityColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${pending["orderId"]}",
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
                          "${pending["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${pending["destination"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${pending["items"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${pending["weight"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Scheduled: ${pending["scheduledTime"]}",
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
        title: Text("Loading Operations"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              si("Scan loading barcode");
            },
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refresh loading status");
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
            _buildLoadingDashboard(),
            _buildNewLoadingForm(),
            _buildActiveOperations(),
            _buildPendingQueue(),
          ],
        ),
      ),
    );
  }
}

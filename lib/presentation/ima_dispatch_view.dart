import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaDispatchView extends StatefulWidget {
  const ImaDispatchView({super.key});

  @override
  State<ImaDispatchView> createState() => _ImaDispatchViewState();
}

class _ImaDispatchViewState extends State<ImaDispatchView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedVehicle = "All";
  String selectedDriver = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Loading", "value": "Loading"},
    {"label": "Dispatched", "value": "Dispatched"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> vehicleItems = [
    {"label": "All Vehicles", "value": "All"},
    {"label": "Truck-001", "value": "Truck-001"},
    {"label": "Truck-002", "value": "Truck-002"},
    {"label": "Van-001", "value": "Van-001"},
    {"label": "Van-002", "value": "Van-002"},
    {"label": "Bike-001", "value": "Bike-001"},
  ];

  List<Map<String, dynamic>> driverItems = [
    {"label": "All Drivers", "value": "All"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Lisa Davis", "value": "Lisa Davis"},
  ];

  List<Map<String, dynamic>> dispatches = [
    {
      "id": "DSP-2024-001",
      "date": "2024-06-19",
      "status": "In Transit",
      "vehicle": "Truck-001",
      "driver": "John Smith",
      "route": "Route A - Downtown",
      "totalShipments": 8,
      "deliveredShipments": 3,
      "estimatedCompletion": "2024-06-19 18:00",
      "actualDeparture": "2024-06-19 08:00",
      "currentLocation": "Main Street",
      "totalDistance": 45.2,
      "remainingDistance": 22.1,
      "fuelCost": 85.50,
      "shipments": [
        {
          "id": "SH-2024-001",
          "customer": "ABC Electronics",
          "address": "123 Main St",
          "status": "Delivered",
          "deliveryTime": "09:30",
          "items": 4
        },
        {
          "id": "SH-2024-002",
          "customer": "Tech Solutions",
          "address": "456 Oak Ave",
          "status": "Delivered",
          "deliveryTime": "10:45",
          "items": 6
        },
        {
          "id": "SH-2024-003",
          "customer": "Office Supplies",
          "address": "789 Pine St",
          "status": "Delivered",
          "deliveryTime": "12:15",
          "items": 3
        },
        {
          "id": "SH-2024-004",
          "customer": "Home Appliances",
          "address": "321 Elm St",
          "status": "Pending",
          "deliveryTime": null,
          "items": 5
        },
        {
          "id": "SH-2024-005",
          "customer": "Fashion Store",
          "address": "654 Cedar Ave",
          "status": "Pending",
          "deliveryTime": null,
          "items": 2
        },
      ]
    },
    {
      "id": "DSP-2024-002",
      "date": "2024-06-19",
      "status": "Loading",
      "vehicle": "Van-001",
      "driver": "Sarah Wilson",
      "route": "Route B - Suburbs",
      "totalShipments": 12,
      "deliveredShipments": 0,
      "estimatedCompletion": "2024-06-19 16:00",
      "actualDeparture": null,
      "currentLocation": "Warehouse",
      "totalDistance": 38.7,
      "remainingDistance": 38.7,
      "fuelCost": 65.25,
      "shipments": [
        {
          "id": "SH-2024-006",
          "customer": "Pet Store",
          "address": "111 First Ave",
          "status": "Loading",
          "deliveryTime": null,
          "items": 8
        },
        {
          "id": "SH-2024-007",
          "customer": "Bookstore",
          "address": "222 Second St",
          "status": "Loading",
          "deliveryTime": null,
          "items": 15
        },
      ]
    },
    {
      "id": "DSP-2024-003",
      "date": "2024-06-18",
      "status": "Delivered",
      "vehicle": "Truck-002",
      "driver": "Mike Johnson",
      "route": "Route C - Industrial",
      "totalShipments": 6,
      "deliveredShipments": 6,
      "estimatedCompletion": "2024-06-18 17:00",
      "actualDeparture": "2024-06-18 09:00",
      "actualCompletion": "2024-06-18 16:30",
      "currentLocation": "Warehouse",
      "totalDistance": 52.8,
      "remainingDistance": 0,
      "fuelCost": 95.75,
      "shipments": [
        {
          "id": "SH-2024-008",
          "customer": "Manufacturing Co",
          "address": "555 Industrial Blvd",
          "status": "Delivered",
          "deliveryTime": "11:00",
          "items": 12
        },
        {
          "id": "SH-2024-009",
          "customer": "Construction Ltd",
          "address": "777 Builder St",
          "status": "Delivered",
          "deliveryTime": "14:30",
          "items": 8
        },
      ]
    },
    {
      "id": "DSP-2024-004",
      "date": "2024-06-20",
      "status": "Scheduled",
      "vehicle": "Van-002",
      "driver": "David Brown",
      "route": "Route D - Residential",
      "totalShipments": 10,
      "deliveredShipments": 0,
      "estimatedCompletion": "2024-06-20 15:00",
      "actualDeparture": null,
      "currentLocation": null,
      "totalDistance": 32.4,
      "remainingDistance": 32.4,
      "fuelCost": 58.90,
      "shipments": [
        {
          "id": "SH-2024-010",
          "customer": "Family Store",
          "address": "999 Family Dr",
          "status": "Scheduled",
          "deliveryTime": null,
          "items": 4
        },
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredDispatches {
    return dispatches.where((dispatch) {
      final matchesSearch = dispatch["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          dispatch["driver"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          dispatch["vehicle"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          dispatch["route"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || dispatch["status"] == selectedStatus;
      final matchesVehicle = selectedVehicle == "All" || dispatch["vehicle"] == selectedVehicle;
      final matchesDriver = selectedDriver == "All" || dispatch["driver"] == selectedDriver;
      
      return matchesSearch && matchesStatus && matchesVehicle && matchesDriver;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "In Transit":
        return primaryColor;
      case "Dispatched":
        return infoColor;
      case "Loading":
        return warningColor;
      case "Scheduled":
        return disabledBoldColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _startDispatch(Map<String, dynamic> dispatch) {
    dispatch["status"] = "Dispatched";
    dispatch["actualDeparture"] = DateTime.now().toString();
    setState(() {});
    ss("Dispatch started for ${dispatch["id"]}");
  }

  void _completeDispatch(Map<String, dynamic> dispatch) async {
    bool isConfirmed = await confirm("Complete dispatch for ${dispatch["id"]}?");
    if (isConfirmed) {
      dispatch["status"] = "Delivered";
      dispatch["actualCompletion"] = DateTime.now().toString();
      dispatch["deliveredShipments"] = dispatch["totalShipments"];
      setState(() {});
      ss("Dispatch completed for ${dispatch["id"]}");
    }
  }

  void _viewDispatchDetails(Map<String, dynamic> dispatch) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Dispatch Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${dispatch["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Date: ${dispatch["date"]}"),
              Text("Status: ${dispatch["status"]}"),
              Text("Vehicle: ${dispatch["vehicle"]}"),
              Text("Driver: ${dispatch["driver"]}"),
              Text("Route: ${dispatch["route"]}"),
              Text("Progress: ${dispatch["deliveredShipments"]}/${dispatch["totalShipments"]} shipments"),
              Text("Distance: ${dispatch["totalDistance"]} km"),
              Text("Fuel Cost: \$${(dispatch["fuelCost"] as double).currency}"),
              if (dispatch["currentLocation"] != null)
                Text("Current Location: ${dispatch["currentLocation"]}"),
              SizedBox(height: spSm),
              Text("Shipments:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((dispatch["shipments"] as List).map((shipment) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${shipment["customer"]} - ${shipment["status"]}"),
              ))),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _trackDispatch(Map<String, dynamic> dispatch) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Live Tracking"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Dispatch ID: ${dispatch["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Current Location",
                          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text("${dispatch["currentLocation"] ?? "Not available"}"),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${dispatch["deliveredShipments"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Delivered",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                          Icon(Icons.pending, color: warningColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${(dispatch["totalShipments"] as int) - (dispatch["deliveredShipments"] as int)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Pending",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              LinearProgressIndicator(
                value: (dispatch["deliveredShipments"] as int) / (dispatch["totalShipments"] as int),
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              SizedBox(height: spXs),
              Text(
                "Progress: ${((dispatch["deliveredShipments"] as int) / (dispatch["totalShipments"] as int) * 100).toInt()}%",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDispatchCard(Map<String, dynamic> dispatch) {
    double progressPercentage = (dispatch["deliveredShipments"] as int) / (dispatch["totalShipments"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dispatch["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${dispatch["route"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(dispatch["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${dispatch["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(dispatch["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dispatch["vehicle"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dispatch["driver"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dispatch["date"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.route, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dispatch["totalDistance"]} km",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          if (dispatch["currentLocation"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: primaryColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${dispatch["currentLocation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress: ${dispatch["deliveredShipments"]}/${dispatch["totalShipments"]} shipments",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progressPercentage,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressPercentage == 1.0 ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(dispatch["fuelCost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Fuel Cost",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _viewDispatchDetails(dispatch),
                ),
              ),
              SizedBox(width: spSm),
              if (dispatch["status"] == "In Transit" || dispatch["status"] == "Dispatched")
                QButton(
                  label: "Track",
                  size: bs.sm,
                  onPressed: () => _trackDispatch(dispatch),
                )
              else if (dispatch["status"] == "Loading")
                QButton(
                  label: "Dispatch",
                  size: bs.sm,
                  onPressed: () => _startDispatch(dispatch),
                )
              else if (dispatch["status"] == "In Transit")
                QButton(
                  label: "Complete",
                  size: bs.sm,
                  onPressed: () => _completeDispatch(dispatch),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalDispatches = dispatches.length;
    int scheduled = dispatches.where((d) => d["status"] == "Scheduled").length;
    int inTransit = dispatches.where((d) => d["status"] == "In Transit" || d["status"] == "Dispatched").length;
    int completed = dispatches.where((d) => d["status"] == "Delivered").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_shipping, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalDispatches",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Dispatches",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$scheduled",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Scheduled",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.flight_takeoff, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$inTransit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "In Transit",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$completed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Dispatches",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...dispatches.take(3).map((dispatch) => _buildDispatchCard(dispatch)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeDispatches = dispatches.where((d) => 
        d["status"] != "Delivered" && d["status"] != "Cancelled").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search dispatches...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusItems,
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
                  label: "Filter by Vehicle",
                  items: vehicleItems,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activeDispatches.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active dispatches found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredDispatches.where((d) => d["status"] != "Delivered" && d["status"] != "Cancelled").map((dispatch) => _buildDispatchCard(dispatch)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> completedDispatches = dispatches.where((d) => 
        d["status"] == "Delivered").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search completed dispatches...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (completedDispatches.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No completed dispatches found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...completedDispatches.map((dispatch) => _buildDispatchCard(dispatch)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dispatch",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.local_shipping)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTab(),
        _buildHistoryTab(),
      ],
    );
  }
}

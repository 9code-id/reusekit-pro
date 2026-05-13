import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleTrackingView extends StatefulWidget {
  const LtaVehicleTrackingView({super.key});

  @override
  State<LtaVehicleTrackingView> createState() => _LtaVehicleTrackingViewState();
}

class _LtaVehicleTrackingViewState extends State<LtaVehicleTrackingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "type": "Truck",
      "model": "Ford Transit",
      "plate": "B 1234 ABC",
      "driver": "John Smith",
      "status": "active",
      "location": "Jakarta Selatan",
      "speed": 45,
      "fuel": 78,
      "lastUpdate": "2 mins ago",
      "route": "Jakarta - Bandung",
      "latitude": -6.2088,
      "longitude": 106.8456,
      "battery": 95,
      "temperature": 25,
      "odometer": 15420,
    },
    {
      "id": "VH002", 
      "type": "Van",
      "model": "Toyota Hiace",
      "plate": "B 5678 DEF",
      "driver": "Mike Johnson",
      "status": "inactive",
      "location": "Jakarta Utara",
      "speed": 0,
      "fuel": 45,
      "lastUpdate": "15 mins ago",
      "route": "Jakarta - Surabaya",
      "latitude": -6.1744,
      "longitude": 106.8294,
      "battery": 88,
      "temperature": 28,
      "odometer": 22150,
    },
    {
      "id": "VH003",
      "type": "Motorcycle",
      "model": "Honda Beat",
      "plate": "B 9012 GHI",
      "driver": "Sarah Wilson",
      "status": "active",
      "location": "Jakarta Barat",
      "speed": 35,
      "fuel": 92,
      "lastUpdate": "1 min ago",
      "route": "Jakarta - Tangerang",
      "latitude": -6.1754,
      "longitude": 106.7650,
      "battery": 100,
      "temperature": 24,
      "odometer": 8750,
    },
    {
      "id": "VH004",
      "type": "Truck",
      "model": "Mitsubishi Canter",
      "plate": "B 3456 JKL",
      "driver": "David Brown",
      "status": "maintenance",
      "location": "Workshop A",
      "speed": 0,
      "fuel": 20,
      "lastUpdate": "2 hours ago",
      "route": "In Maintenance",
      "latitude": -6.2297,
      "longitude": 106.8200,
      "battery": 65,
      "temperature": 30,
      "odometer": 45280,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    return vehicles.where((vehicle) {
      bool matchesSearch = vehicle["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["model"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["plate"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["driver"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || vehicle["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return warningColor;
      case "maintenance":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to map view
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: QTextField(
                          label: "Search vehicles...",
                          value: searchQuery,
                          hint: "Search by ID, model, plate, or driver",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
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
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${vehicles.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Vehicles",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${vehicles.where((v) => v["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.build,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${vehicles.where((v) => v["status"] == "maintenance").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Maintenance",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Vehicle List Section
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicle List (${filteredVehicles.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...filteredVehicles.map((vehicle) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getStatusColor(vehicle["status"]),
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  vehicle["type"] == "Truck" ? Icons.local_shipping :
                                  vehicle["type"] == "Van" ? Icons.airport_shuttle :
                                  Icons.motorcycle,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${vehicle["id"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(vehicle["status"]),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${vehicle["status"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${vehicle["model"]} - ${vehicle["plate"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Driver: ${vehicle["driver"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.location_on,
                                size: bs.sm,
                                onPressed: () {
                                  // Show location on map
                                },
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Expanded(
                                            child: Text(
                                              "${vehicle["location"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.speed,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${vehicle["speed"]} km/h",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.local_gas_station,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${vehicle["fuel"]}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Updated: ${vehicle["lastUpdate"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Route: ${vehicle["route"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

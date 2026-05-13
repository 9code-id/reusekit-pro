import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleListView extends StatefulWidget {
  const LtaVehicleListView({super.key});

  @override
  State<LtaVehicleListView> createState() => _LtaVehicleListViewState();
}

class _LtaVehicleListViewState extends State<LtaVehicleListView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  String sortBy = "id";
  bool sortAscending = true;

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "type": "Truck",
      "model": "Ford Transit",
      "year": 2020,
      "plate": "B 1234 ABC",
      "status": "active",
      "driver": "John Smith",
      "driverId": "DR001",
      "location": "Jakarta Selatan",
      "mileage": 15420,
      "fuelLevel": 78,
      "lastMaintenance": "2024-05-15",
      "nextMaintenance": "2024-07-15",
      "monthlyDistance": 2800,
      "fuelEfficiency": 12.5,
      "acquisitionDate": "2020-03-15",
      "lastUpdate": "2 mins ago",
      "insurance": "Active",
      "registrationExpiry": "2025-03-15",
    },
    {
      "id": "VH002",
      "type": "Van",
      "model": "Toyota Hiace",
      "year": 2019,
      "plate": "B 5678 DEF",
      "status": "maintenance",
      "driver": "Mike Johnson",
      "driverId": "DR002",
      "location": "Workshop A",
      "mileage": 22150,
      "fuelLevel": 45,
      "lastMaintenance": "2024-06-01",
      "nextMaintenance": "2024-08-01",
      "monthlyDistance": 3200,
      "fuelEfficiency": 10.8,
      "acquisitionDate": "2019-07-20",
      "lastUpdate": "15 mins ago",
      "insurance": "Active",
      "registrationExpiry": "2024-07-20",
    },
    {
      "id": "VH003",
      "type": "Motorcycle",
      "model": "Honda Beat",
      "year": 2021,
      "plate": "B 9012 GHI",
      "status": "active",
      "driver": "Sarah Wilson",
      "driverId": "DR003",
      "location": "Jakarta Barat",
      "mileage": 8750,
      "fuelLevel": 92,
      "lastMaintenance": "2024-05-20",
      "nextMaintenance": "2024-07-20",
      "monthlyDistance": 1500,
      "fuelEfficiency": 45.2,
      "acquisitionDate": "2021-01-10",
      "lastUpdate": "1 min ago",
      "insurance": "Active",
      "registrationExpiry": "2026-01-10",
    },
    {
      "id": "VH004",
      "type": "Truck",
      "model": "Mitsubishi Canter",
      "year": 2018,
      "plate": "B 3456 JKL",
      "status": "out_of_service",
      "driver": "David Brown",
      "driverId": "DR004",
      "location": "Parking Lot B",
      "mileage": 45280,
      "fuelLevel": 20,
      "lastMaintenance": "2024-04-10",
      "nextMaintenance": "2024-08-10",
      "monthlyDistance": 0,
      "fuelEfficiency": 8.2,
      "acquisitionDate": "2018-11-05",
      "lastUpdate": "2 hours ago",
      "insurance": "Expired",
      "registrationExpiry": "2024-11-05",
    },
    {
      "id": "VH005",
      "type": "Van",
      "model": "Suzuki Carry",
      "year": 2022,
      "plate": "B 7890 MNO",
      "status": "active",
      "driver": "Lisa Chen",
      "driverId": "DR005",
      "location": "Jakarta Timur",
      "mileage": 5200,
      "fuelLevel": 85,
      "lastMaintenance": "2024-06-05",
      "nextMaintenance": "2024-09-05",
      "monthlyDistance": 2200,
      "fuelEfficiency": 14.3,
      "acquisitionDate": "2022-02-28",
      "lastUpdate": "5 mins ago",
      "insurance": "Active",
      "registrationExpiry": "2027-02-28",
    },
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "Truck", "value": "Truck"},
    {"label": "Van", "value": "Van"},
    {"label": "Motorcycle", "value": "Motorcycle"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Out of Service", "value": "out_of_service"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Vehicle ID", "value": "id"},
    {"label": "Model", "value": "model"},
    {"label": "Year", "value": "year"},
    {"label": "Mileage", "value": "mileage"},
    {"label": "Fuel Level", "value": "fuelLevel"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedVehicles {
    List<Map<String, dynamic>> filtered = vehicles.where((vehicle) {
      bool matchesSearch = vehicle["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["model"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["plate"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vehicle["driver"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "All" || vehicle["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || vehicle["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();

    // Sort the filtered list
    filtered.sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];
      
      int comparison;
      if (aValue is String && bValue is String) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is num && bValue is num) {
        comparison = aValue.compareTo(bValue);
      } else {
        comparison = aValue.toString().compareTo(bValue.toString());
      }
      
      return sortAscending ? comparison : -comparison;
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "maintenance":
        return warningColor;
      case "out_of_service":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getVehicleIcon(String type) {
    switch (type) {
      case "Truck":
        return Icons.local_shipping;
      case "Van":
        return Icons.airport_shuttle;
      case "Motorcycle":
        return Icons.motorcycle;
      default:
        return Icons.directions_car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add vehicle view
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export vehicle list
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
                  // Search Bar
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
                  
                  // Filter Row 1
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Vehicle Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
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

                  // Sort Options
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                        size: bs.sm,
                        onPressed: () {
                          sortAscending = !sortAscending;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${filteredAndSortedVehicles.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Found",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: primaryColor.withAlpha(50),
                  ),
                  Column(
                    children: [
                      Text(
                        "${filteredAndSortedVehicles.where((v) => v["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: primaryColor.withAlpha(50),
                  ),
                  Column(
                    children: [
                      Text(
                        "${filteredAndSortedVehicles.where((v) => v["status"] == "maintenance").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Maintenance",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Vehicle List
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Vehicles (${filteredAndSortedVehicles.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last updated: ${DateTime.now().toString().substring(11, 16)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredAndSortedVehicles.map((vehicle) {
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
                          // Vehicle Header
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
                                  _getVehicleIcon(vehicle["type"]),
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
                                            "${vehicle["status"]}".toUpperCase().replaceAll("_", " "),
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
                                      "${vehicle["model"]} (${vehicle["year"]}) - ${vehicle["plate"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Driver: ${vehicle["driver"]} (${vehicle["driverId"]})",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show vehicle actions
                                },
                              ),
                            ],
                          ),

                          // Vehicle Details Grid
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 200,
                            children: [
                              _buildDetailCard(
                                "Location",
                                "${vehicle["location"]}",
                                Icons.location_on,
                                disabledBoldColor,
                              ),
                              _buildDetailCard(
                                "Mileage",
                                "${((vehicle["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                                Icons.speed,
                                primaryColor,
                              ),
                              _buildDetailCard(
                                "Fuel Level",
                                "${vehicle["fuelLevel"]}%",
                                Icons.local_gas_station,
                                vehicle["fuelLevel"] > 50 ? successColor : 
                                vehicle["fuelLevel"] > 25 ? warningColor : dangerColor,
                              ),
                              _buildDetailCard(
                                "Efficiency",
                                "${vehicle["fuelEfficiency"]} km/l",
                                Icons.eco,
                                infoColor,
                              ),
                            ],
                          ),

                          // Additional Info
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Last Maintenance: ${vehicle["lastMaintenance"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Next: ${vehicle["nextMaintenance"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Insurance: ${vehicle["insurance"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: vehicle["insurance"] == "Active" ? successColor : dangerColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Registration expires: ${vehicle["registrationExpiry"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Last updated: ${vehicle["lastUpdate"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Monthly: ${((vehicle["monthlyDistance"] as int) / 1000).toStringAsFixed(1)}K km",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
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

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

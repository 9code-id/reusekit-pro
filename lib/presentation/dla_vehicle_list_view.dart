import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaVehicleListView extends StatefulWidget {
  const DlaVehicleListView({super.key});

  @override
  State<DlaVehicleListView> createState() => _DlaVehicleListViewState();
}

class _DlaVehicleListViewState extends State<DlaVehicleListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Inactive", "value": "inactive"},
  ];

  final List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Truck", "value": "truck"},
    {"label": "Van", "value": "van"},
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Car", "value": "car"},
  ];

  final List<Map<String, dynamic>> vehicles = [
    {
      "id": "DLA-001",
      "licensePlate": "B 1234 ABC",
      "type": "truck",
      "manufacturer": "Toyota",
      "model": "Hiace",
      "year": 2022,
      "driver": "John Smith",
      "status": "active",
      "location": "Jakarta Warehouse",
      "fuelLevel": 85,
      "mileage": 15420,
      "lastMaintenance": "2024-01-10",
      "nextMaintenance": "2024-02-10",
    },
    {
      "id": "DLA-002",
      "licensePlate": "B 5678 DEF",
      "type": "van",
      "manufacturer": "Isuzu",
      "model": "Elf",
      "year": 2021,
      "driver": "Sarah Johnson",
      "status": "in_transit",
      "location": "En Route to Bandung",
      "fuelLevel": 60,
      "mileage": 28750,
      "lastMaintenance": "2024-01-05",
      "nextMaintenance": "2024-02-05",
    },
    {
      "id": "DLA-003",
      "licensePlate": "B 9012 GHI",
      "type": "motorcycle",
      "manufacturer": "Honda",
      "model": "Beat",
      "year": 2023,
      "driver": "Mike Wilson",
      "status": "maintenance",
      "location": "Service Center",
      "fuelLevel": 30,
      "mileage": 8500,
      "lastMaintenance": "2024-01-12",
      "nextMaintenance": "2024-02-12",
    },
    {
      "id": "DLA-004",
      "licensePlate": "B 3456 JKL",
      "type": "car",
      "manufacturer": "Toyota",
      "model": "Avanza",
      "year": 2020,
      "driver": "Lisa Brown",
      "status": "active",
      "location": "Surabaya Hub",
      "fuelLevel": 75,
      "mileage": 45600,
      "lastMaintenance": "2024-01-08",
      "nextMaintenance": "2024-02-08",
    },
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    return vehicles.where((vehicle) {
      bool matchesSearch = vehicle["licensePlate"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          vehicle["driver"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          vehicle["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || vehicle["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || vehicle["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "in_transit":
        return infoColor;
      case "maintenance":
        return warningColor;
      case "inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "in_transit":
        return "In Transit";
      case "maintenance":
        return "Maintenance";
      case "inactive":
        return "Inactive";
      default:
        return "Unknown";
    }
  }

  IconData _getVehicleIcon(String type) {
    switch (type) {
      case "truck":
        return Icons.local_shipping;
      case "van":
        return Icons.fire_truck;
      case "motorcycle":
        return Icons.two_wheeler;
      case "car":
        return Icons.directions_car;
      default:
        return Icons.local_shipping;
    }
  }

  Widget _buildFleetSummary() {
    int totalVehicles = vehicles.length;
    int activeVehicles = vehicles.where((v) => v["status"] == "active").length;
    int inTransitVehicles = vehicles.where((v) => v["status"] == "in_transit").length;
    int maintenanceVehicles = vehicles.where((v) => v["status"] == "maintenance").length;

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
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalVehicles",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
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
                      Text(
                        "$activeVehicles",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$inTransitVehicles",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Transit",
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
                      Text(
                        "$maintenanceVehicles",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Maintenance",
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

  Widget _buildFilterSection() {
    return Container(
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
                  label: "Search",
                  value: searchQuery,
                  hint: "Search by license plate, driver, or ID",
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
                onPressed: () {
                  si("Searching for: $searchQuery");
                },
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Type Filter",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    Color statusColor = _getStatusColor(vehicle["status"]);
    Color fuelColor = (vehicle["fuelLevel"] as int) < 30 ? dangerColor : 
                     (vehicle["fuelLevel"] as int) < 60 ? warningColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Icon(
                _getVehicleIcon(vehicle["type"]),
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle["id"]} - ${vehicle["licensePlate"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vehicle["manufacturer"]} ${vehicle["model"]} (${vehicle["year"]})",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(vehicle["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${vehicle["driver"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${vehicle["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            spacing: spLg,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_gas_station, color: fuelColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${vehicle["fuelLevel"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fuelColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Fuel",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.speed, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${((vehicle["mileage"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Mileage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.build, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${vehicle["nextMaintenance"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Next Service",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Track",
                  size: bs.sm,
                  onPressed: () {
                    si("Tracking vehicle ${vehicle["id"]}");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Details",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Vehicle details for ${vehicle["id"]}");
                  },
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options for ${vehicle["id"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Fleet"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Add new vehicle");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFleetSummary(),
            _buildFilterSection(),
            if (filteredVehicles.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No vehicles found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredVehicles.map((vehicle) => _buildVehicleCard(vehicle)).toList(),
          ],
        ),
      ),
    );
  }
}

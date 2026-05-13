import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFleetManagementView extends StatefulWidget {
  const CmaFleetManagementView({super.key});

  @override
  State<CmaFleetManagementView> createState() => _CmaFleetManagementViewState();
}

class _CmaFleetManagementViewState extends State<CmaFleetManagementView> {
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "plateNumber": "CA-1234-AB",
      "make": "Toyota",
      "model": "Camry",
      "year": 2022,
      "type": "Sedan",
      "status": "Active",
      "location": "Downtown Office",
      "fuelLevel": 85,
      "mileage": 45230,
      "lastService": "2024-11-15T00:00:00Z",
      "nextService": "2024-12-30T00:00:00Z",
      "driver": "John Smith",
      "driverId": "DR001",
      "isAssigned": true,
      "color": "Silver",
      "insurance": "Active",
      "insuranceExpiry": "2025-06-15T00:00:00Z"
    },
    {
      "id": "VH002",
      "plateNumber": "CA-5678-CD",
      "make": "Honda",
      "model": "Civic",
      "year": 2021,
      "type": "Sedan",
      "status": "In Use",
      "location": "Route to Client Site",
      "fuelLevel": 42,
      "mileage": 38750,
      "lastService": "2024-10-20T00:00:00Z",
      "nextService": "2024-12-20T00:00:00Z",
      "driver": "Sarah Johnson",
      "driverId": "DR002",
      "isAssigned": true,
      "color": "Blue",
      "insurance": "Active",
      "insuranceExpiry": "2025-03-22T00:00:00Z"
    },
    {
      "id": "VH003",
      "plateNumber": "CA-9012-EF",
      "make": "Ford",
      "model": "Transit",
      "year": 2023,
      "type": "Van",
      "status": "Maintenance",
      "location": "Service Center",
      "fuelLevel": 0,
      "mileage": 12500,
      "lastService": "2024-12-15T00:00:00Z",
      "nextService": "2025-03-15T00:00:00Z",
      "driver": null,
      "driverId": null,
      "isAssigned": false,
      "color": "White",
      "insurance": "Active",
      "insuranceExpiry": "2025-08-10T00:00:00Z"
    },
    {
      "id": "VH004",
      "plateNumber": "CA-3456-GH",
      "make": "Chevrolet",
      "model": "Silverado",
      "year": 2020,
      "type": "Truck",
      "status": "Available",
      "location": "Fleet Parking",
      "fuelLevel": 67,
      "mileage": 67890,
      "lastService": "2024-09-30T00:00:00Z",
      "nextService": "2024-12-25T00:00:00Z",
      "driver": null,
      "driverId": null,
      "isAssigned": false,
      "color": "Black",
      "insurance": "Expiring Soon",
      "insuranceExpiry": "2024-12-30T00:00:00Z"
    },
    {
      "id": "VH005",
      "plateNumber": "CA-7890-IJ",
      "make": "Tesla",
      "model": "Model 3",
      "year": 2023,
      "type": "Electric",
      "status": "Active",
      "location": "Charging Station",
      "fuelLevel": 92,
      "mileage": 8450,
      "lastService": "2024-11-01T00:00:00Z",
      "nextService": "2025-02-01T00:00:00Z",
      "driver": "Mike Wilson",
      "driverId": "DR003",
      "isAssigned": true,
      "color": "Red",
      "insurance": "Active",
      "insuranceExpiry": "2025-11-01T00:00:00Z"
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "In Use", "value": "in use"},
    {"label": "Available", "value": "available"},
    {"label": "Maintenance", "value": "maintenance"}
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Sedan", "value": "sedan"},
    {"label": "Van", "value": "van"},
    {"label": "Truck", "value": "truck"},
    {"label": "Electric", "value": "electric"}
  ];

  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredVehicles {
    return vehicles.where((vehicle) {
      bool matchesStatus = selectedStatus == "all" || 
          (vehicle["status"] as String).toLowerCase() == selectedStatus.toLowerCase();
      bool matchesType = selectedType == "all" ||
          (vehicle["type"] as String).toLowerCase() == selectedType.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          (vehicle["plateNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vehicle["make"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vehicle["model"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  int get activeVehicles => vehicles.where((v) => (v["status"] as String).toLowerCase() == "active" || (v["status"] as String).toLowerCase() == "in use").length;
  int get availableVehicles => vehicles.where((v) => (v["status"] as String).toLowerCase() == "available").length;
  int get maintenanceVehicles => vehicles.where((v) => (v["status"] as String).toLowerCase() == "maintenance").length;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'in use':
        return infoColor;
      case 'available':
        return primaryColor;
      case 'maintenance':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFuelLevelColor(int fuelLevel) {
    if (fuelLevel > 50) return successColor;
    if (fuelLevel > 20) return warningColor;
    return dangerColor;
  }

  Color _getInsuranceColor(String insurance) {
    switch (insurance.toLowerCase()) {
      case 'active':
        return successColor;
      case 'expiring soon':
        return warningColor;
      case 'expired':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getVehicleIcon(String type) {
    switch (type.toLowerCase()) {
      case 'sedan':
        return Icons.directions_car;
      case 'van':
        return Icons.airport_shuttle;
      case 'truck':
        return Icons.local_shipping;
      case 'electric':
        return Icons.electric_car;
      default:
        return Icons.directions_car;
    }
  }

  void _addVehicle() {
    // Navigate to add vehicle screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fleet Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addVehicle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Fleet Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$activeVehicles",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$availableVehicles",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Maintenance",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$maintenanceVehicles",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search by plate, make, or model",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters,
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
                          label: "Type",
                          items: typeFilters,
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
            ),

            // Vehicle List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.garage,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Fleet Vehicles",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredVehicles.length} vehicles",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredVehicles.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final vehicle = filteredVehicles[index];
                      final statusColor = _getStatusColor("${vehicle["status"]}");
                      final fuelColor = _getFuelLevelColor(vehicle["fuelLevel"] as int);
                      final insuranceColor = _getInsuranceColor("${vehicle["insurance"]}");
                      final vehicleIcon = _getVehicleIcon("${vehicle["type"]}");
                      final nextService = DateTime.parse("${vehicle["nextService"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    vehicleIcon,
                                    color: statusColor,
                                    size: 28,
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
                                            "${vehicle["plateNumber"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "${vehicle["status"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${vehicle["type"]} • ${vehicle["color"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),

                            // Vehicle Stats
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spSm,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.local_gas_station,
                                              color: fuelColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Fuel: ${vehicle["fuelLevel"]}%",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: fuelColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.speed,
                                              color: disabledBoldColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(vehicle["mileage"] as int).toString().currency} mi",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: infoColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Expanded(
                                              child: Text(
                                                "${vehicle["location"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: infoColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (vehicle["driver"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: successColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Driver: ${vehicle["driver"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),

                            // Service and Insurance Info
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.build,
                                              color: warningColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Next Service",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          nextService.dMMMy,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: warningColor,
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
                                      color: insuranceColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.security,
                                              color: insuranceColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Insurance",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${vehicle["insurance"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: insuranceColor,
                                          ),
                                        ),
                                      ],
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
                                    label: "View Details",
                                    icon: Icons.info,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to vehicle details
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (!(vehicle["isAssigned"] as bool)) ...[
                                  Expanded(
                                    child: QButton(
                                      label: "Assign Driver",
                                      icon: Icons.person_add,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to driver assignment
                                      },
                                    ),
                                  ),
                                ] else ...[
                                  Expanded(
                                    child: QButton(
                                      label: "Track Location",
                                      icon: Icons.gps_fixed,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to vehicle tracking
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

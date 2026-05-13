import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDriverManagementView extends StatefulWidget {
  const CmaDriverManagementView({super.key});

  @override
  State<CmaDriverManagementView> createState() => _CmaDriverManagementViewState();
}

class _CmaDriverManagementViewState extends State<CmaDriverManagementView> {
  List<Map<String, dynamic>> drivers = [
    {
      "id": "DR001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1 (555) 123-4567",
      "licenseNumber": "DL123456789",
      "licenseClass": "Class C",
      "licenseExpiry": "2025-08-15T00:00:00Z",
      "status": "Active",
      "hireDate": "2023-03-15T00:00:00Z",
      "assignedVehicle": "CA-1234-AB",
      "vehicleId": "VH001",
      "totalMiles": 45230,
      "totalTrips": 342,
      "rating": 4.8,
      "safetyScore": 95,
      "fuelEfficiency": 87,
      "onTimePercentage": 92,
      "currentLocation": "Downtown Office",
      "isOnDuty": true,
      "shift": "Day Shift",
      "emergencyContact": "Jane Smith - +1 (555) 987-6543"
    },
    {
      "id": "DR002",
      "name": "Sarah Johnson", 
      "email": "sarah.johnson@company.com",
      "phone": "+1 (555) 234-5678",
      "licenseNumber": "DL987654321",
      "licenseClass": "Class C",
      "licenseExpiry": "2024-12-30T00:00:00Z",
      "status": "Active",
      "hireDate": "2022-11-20T00:00:00Z",
      "assignedVehicle": "CA-5678-CD",
      "vehicleId": "VH002",
      "totalMiles": 38750,
      "totalTrips": 289,
      "rating": 4.6,
      "safetyScore": 88,
      "fuelEfficiency": 82,
      "onTimePercentage": 89,
      "currentLocation": "Route to Client Site",
      "isOnDuty": true,
      "shift": "Day Shift",
      "emergencyContact": "Bob Johnson - +1 (555) 876-5432"
    },
    {
      "id": "DR003",
      "name": "Mike Wilson",
      "email": "mike.wilson@company.com",
      "phone": "+1 (555) 345-6789",
      "licenseNumber": "DL456789123",
      "licenseClass": "Class C",
      "licenseExpiry": "2026-05-22T00:00:00Z",
      "status": "Active",
      "hireDate": "2024-01-10T00:00:00Z",
      "assignedVehicle": "CA-7890-IJ",
      "vehicleId": "VH005",
      "totalMiles": 8450,
      "totalTrips": 67,
      "rating": 4.9,
      "safetyScore": 98,
      "fuelEfficiency": 91,
      "onTimePercentage": 96,
      "currentLocation": "Charging Station",
      "isOnDuty": true,
      "shift": "Day Shift",
      "emergencyContact": "Lisa Wilson - +1 (555) 765-4321"
    },
    {
      "id": "DR004",
      "name": "David Brown",
      "email": "david.brown@company.com",
      "phone": "+1 (555) 456-7890",
      "licenseNumber": "DL789123456",
      "licenseClass": "Class B",
      "licenseExpiry": "2025-03-10T00:00:00Z",
      "status": "On Leave",
      "hireDate": "2021-07-05T00:00:00Z",
      "assignedVehicle": null,
      "vehicleId": null,
      "totalMiles": 67890,
      "totalTrips": 523,
      "rating": 4.4,
      "safetyScore": 85,
      "fuelEfficiency": 79,
      "onTimePercentage": 87,
      "currentLocation": "Off Duty",
      "isOnDuty": false,
      "shift": "Night Shift",
      "emergencyContact": "Maria Brown - +1 (555) 654-3210"
    },
    {
      "id": "DR005",
      "name": "Emily Davis",
      "email": "emily.davis@company.com",
      "phone": "+1 (555) 567-8901",
      "licenseNumber": "DL321654987",
      "licenseClass": "Class C",
      "licenseExpiry": "2024-12-25T00:00:00Z",
      "status": "Training",
      "hireDate": "2024-12-01T00:00:00Z",
      "assignedVehicle": null,
      "vehicleId": null,
      "totalMiles": 245,
      "totalTrips": 8,
      "rating": 4.2,
      "safetyScore": 92,
      "fuelEfficiency": 85,
      "onTimePercentage": 94,
      "currentLocation": "Training Center",
      "isOnDuty": false,
      "shift": "Day Shift",
      "emergencyContact": "Robert Davis - +1 (555) 543-2109"
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "On Leave", "value": "on leave"},
    {"label": "Training", "value": "training"}
  ];

  List<Map<String, dynamic>> shiftFilters = [
    {"label": "All Shifts", "value": "all"},
    {"label": "Day Shift", "value": "day shift"},
    {"label": "Night Shift", "value": "night shift"}
  ];

  String selectedStatus = "all";
  String selectedShift = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredDrivers {
    return drivers.where((driver) {
      bool matchesStatus = selectedStatus == "all" || 
          (driver["status"] as String).toLowerCase() == selectedStatus.toLowerCase();
      bool matchesShift = selectedShift == "all" ||
          (driver["shift"] as String).toLowerCase() == selectedShift.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          (driver["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (driver["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (driver["licenseNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesShift && matchesSearch;
    }).toList();
  }

  int get activeDrivers => drivers.where((d) => (d["status"] as String).toLowerCase() == "active").length;
  int get onDutyDrivers => drivers.where((d) => d["isOnDuty"] as bool).length;
  double get averageRating => drivers.fold(0.0, (sum, d) => sum + (d["rating"] as double)) / drivers.length;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'on leave':
        return warningColor;
      case 'training':
        return infoColor;
      case 'inactive':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return successColor;
    if (rating >= 4.0) return infoColor;
    if (rating >= 3.5) return warningColor;
    return dangerColor;
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return infoColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  void _addDriver() {
    // Navigate to add driver screen
  }

  bool _isLicenseExpiringSoon(String expiryDate) {
    final expiry = DateTime.parse(expiryDate);
    final now = DateTime.now();
    final difference = expiry.difference(now).inDays;
    return difference <= 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _addDriver,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Driver Overview Cards
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
                              Icons.person,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Drivers",
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
                          "$activeDrivers",
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
                              Icons.work,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "On Duty",
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
                          "$onDutyDrivers",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
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
                              Icons.star,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Avg Rating",
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
                          "${averageRating.toStringAsFixed(1)}",
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
                          label: "Search by name, email, or license",
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
                          label: "Shift",
                          items: shiftFilters,
                          value: selectedShift,
                          onChanged: (value, label) {
                            selectedShift = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Driver List
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
                          Icons.people,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Drivers",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredDrivers.length} drivers",
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
                    itemCount: filteredDrivers.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final driver = filteredDrivers[index];
                      final statusColor = _getStatusColor("${driver["status"]}");
                      final ratingColor = _getRatingColor(driver["rating"] as double);
                      final safetyColor = _getScoreColor(driver["safetyScore"] as int);
                      final licenseExpiry = DateTime.parse("${driver["licenseExpiry"]}");
                      final isLicenseExpiringSoon = _isLicenseExpiringSoon("${driver["licenseExpiry"]}");
                      
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
                                    Icons.person,
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
                                            "${driver["name"]}",
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
                                              "${driver["status"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                          if (driver["isOnDuty"] as bool) ...[
                                            SizedBox(width: spSm),
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${driver["email"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${driver["phone"]} • ${driver["shift"]}",
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

                            // Driver Stats
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
                                              Icons.star,
                                              color: ratingColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(driver["rating"] as double).toStringAsFixed(1)} rating",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: ratingColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.security,
                                              color: safetyColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${driver["safetyScore"]}% safety",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: safetyColor,
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
                                              Icons.route,
                                              color: disabledBoldColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(driver["totalTrips"] as int).toString().currency} trips",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
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
                                              "${(driver["totalMiles"] as int).toString().currency} mi",
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
                                  if (driver["assignedVehicle"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.directions_car,
                                          color: infoColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Assigned: ${driver["assignedVehicle"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: infoColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${driver["currentLocation"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),

                            // License Information
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isLicenseExpiringSoon 
                                    ? warningColor.withAlpha(10)
                                    : successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: isLicenseExpiringSoon 
                                    ? Border.all(color: warningColor.withAlpha(50))
                                    : null,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        color: isLicenseExpiringSoon ? warningColor : successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "License: ${driver["licenseNumber"]} (${driver["licenseClass"]})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isLicenseExpiringSoon ? warningColor : successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Expires: ${licenseExpiry.dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      if (isLicenseExpiringSoon) ...[
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "Expiring Soon",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: warningColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),

                            // Performance Metrics
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${driver["onTimePercentage"]}%",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: infoColor,
                                          ),
                                        ),
                                        Text(
                                          "On Time",
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
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${driver["fuelEfficiency"]}%",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "Fuel Efficient",
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

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Profile",
                                    icon: Icons.person,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to driver profile
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (driver["assignedVehicle"] == null) ...[
                                  Expanded(
                                    child: QButton(
                                      label: "Assign Vehicle",
                                      icon: Icons.car_rental,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to vehicle assignment
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
                                        // Navigate to driver tracking
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

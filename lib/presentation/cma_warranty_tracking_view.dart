import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaWarrantyTrackingView extends StatefulWidget {
  const CmaWarrantyTrackingView({super.key});

  @override
  State<CmaWarrantyTrackingView> createState() => _CmaWarrantyTrackingViewState();
}

class _CmaWarrantyTrackingViewState extends State<CmaWarrantyTrackingView> {
  String selectedVehicle = "All Vehicles";
  String warrantyStatusFilter = "All Status";
  String warrantyTypeFilter = "All Types";

  List<Map<String, dynamic>> warranties = [
    {
      "id": 1,
      "vehicle": "Honda Civic",
      "warrantyType": "Vehicle Warranty",
      "component": "Engine",
      "description": "5-Year Powertrain Warranty",
      "startDate": "2020-03-15",
      "endDate": "2025-03-15",
      "daysRemaining": 268,
      "mileageLimit": 100000,
      "currentMileage": 45678,
      "mileageRemaining": 54322,
      "provider": "Honda Canada",
      "warrantyNumber": "HCV2020001234",
      "contactInfo": "1-800-HONDA-01",
      "coverage": "Engine, Transmission, Drivetrain",
      "status": "Active",
      "claimsUsed": 0,
      "maxClaims": 3,
    },
    {
      "id": 2,
      "vehicle": "Honda Civic",
      "warrantyType": "Extended Warranty",
      "component": "Brakes",
      "description": "Brake Component Extended Warranty",
      "startDate": "2025-06-08",
      "endDate": "2026-06-08",
      "daysRemaining": 354,
      "mileageLimit": 20000,
      "currentMileage": 45678,
      "mileageRemaining": 20000,
      "provider": "City Auto Repair",
      "warrantyNumber": "BRK2025001",
      "contactInfo": "(613) 555-0123",
      "coverage": "Brake Pads, Rotors, Calipers",
      "status": "Active",
      "claimsUsed": 0,
      "maxClaims": 2,
    },
    {
      "id": 3,
      "vehicle": "Toyota Camry",
      "warrantyType": "Vehicle Warranty",
      "component": "Comprehensive",
      "description": "3-Year Basic Warranty",
      "startDate": "2019-08-20",
      "endDate": "2022-08-20",
      "daysRemaining": 0,
      "mileageLimit": 60000,
      "currentMileage": 67890,
      "mileageRemaining": 0,
      "provider": "Toyota Canada",
      "warrantyNumber": "TYC2019005678",
      "contactInfo": "1-800-TOYOTA-2",
      "coverage": "All Components Except Wear Items",
      "status": "Expired",
      "claimsUsed": 1,
      "maxClaims": 5,
    },
    {
      "id": 4,
      "vehicle": "Honda Civic",
      "warrantyType": "Parts Warranty",
      "component": "Battery",
      "description": "Battery Replacement Warranty",
      "startDate": "2025-04-18",
      "endDate": "2026-04-18",
      "daysRemaining": 303,
      "mileageLimit": 50000,
      "currentMileage": 45678,
      "mileageRemaining": 50000,
      "provider": "Battery Plus",
      "warrantyNumber": "BAT2025789",
      "contactInfo": "(613) 555-0456",
      "coverage": "Battery Replacement and Installation",
      "status": "Active",
      "claimsUsed": 0,
      "maxClaims": 1,
    },
    {
      "id": 5,
      "vehicle": "Toyota Camry",
      "warrantyType": "Service Warranty",
      "component": "Oil Change",
      "description": "Oil Change Service Warranty",
      "startDate": "2025-06-01",
      "endDate": "2025-09-01",
      "daysRemaining": 74,
      "mileageLimit": 5000,
      "currentMileage": 67890,
      "mileageRemaining": 5000,
      "provider": "Quick Lube Express",
      "warrantyNumber": "OIL2025456",
      "contactInfo": "(613) 555-0789",
      "coverage": "Oil and Filter Quality Guarantee",
      "status": "Active",
      "claimsUsed": 0,
      "maxClaims": 1,
    },
    {
      "id": 6,
      "vehicle": "Honda Civic",
      "warrantyType": "Tire Warranty",
      "component": "Tires",
      "description": "Road Hazard Protection",
      "startDate": "2025-01-10",
      "endDate": "2025-07-10",
      "daysRemaining": 21,
      "mileageLimit": 15000,
      "currentMileage": 45678,
      "mileageRemaining": 15000,
      "provider": "Tire Pro",
      "warrantyNumber": "TIR2025123",
      "contactInfo": "(613) 555-0321",
      "coverage": "Road Hazard and Defect Protection",
      "status": "Expiring Soon",
      "claimsUsed": 0,
      "maxClaims": 4,
    },
  ];

  List<Map<String, dynamic>> get filteredWarranties {
    return warranties.where((warranty) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        warranty["vehicle"] == selectedVehicle;
      bool statusMatch = warrantyStatusFilter == "All Status" || 
        warranty["status"] == warrantyStatusFilter;
      bool typeMatch = warrantyTypeFilter == "All Types" || 
        warranty["warrantyType"] == warrantyTypeFilter;
      return vehicleMatch && statusMatch && typeMatch;
    }).toList();
  }

  int get activeWarranties {
    return filteredWarranties
      .where((warranty) => warranty["status"] == "Active")
      .length;
  }

  int get expiringWarranties {
    return filteredWarranties
      .where((warranty) => warranty["status"] == "Expiring Soon")
      .length;
  }

  int get expiredWarranties {
    return filteredWarranties
      .where((warranty) => warranty["status"] == "Expired")
      .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warranty Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add warranty
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: () {
              // View warranty alerts
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Warranties",
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
                        child: QDropdownField(
                          label: "Vehicle",
                          items: [
                            {"label": "All Vehicles", "value": "All Vehicles"},
                            {"label": "Honda Civic", "value": "Honda Civic"},
                            {"label": "Toyota Camry", "value": "Toyota Camry"},
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
                            {"label": "All Status", "value": "All Status"},
                            {"label": "Active", "value": "Active"},
                            {"label": "Expiring Soon", "value": "Expiring Soon"},
                            {"label": "Expired", "value": "Expired"},
                          ],
                          value: warrantyStatusFilter,
                          onChanged: (value, label) {
                            warrantyStatusFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Warranty Type",
                    items: [
                      {"label": "All Types", "value": "All Types"},
                      {"label": "Vehicle Warranty", "value": "Vehicle Warranty"},
                      {"label": "Extended Warranty", "value": "Extended Warranty"},
                      {"label": "Parts Warranty", "value": "Parts Warranty"},
                      {"label": "Service Warranty", "value": "Service Warranty"},
                      {"label": "Tire Warranty", "value": "Tire Warranty"},
                    ],
                    value: warrantyTypeFilter,
                    onChanged: (value, label) {
                      warrantyTypeFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Summary Cards
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Warranties",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$activeWarranties warranties",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Expiring Soon",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$expiringWarranties warranties",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Expired",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$expiredWarranties warranties",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Warranty List
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
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.security, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Warranty Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredWarranties.length} warranties",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredWarranties.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final warranty = filteredWarranties[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(warranty["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${warranty["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getStatusColor(warranty["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getWarrantyTypeColor(warranty["warrantyType"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${warranty["warrantyType"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getWarrantyTypeColor(warranty["warrantyType"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                if ((warranty["daysRemaining"] as int) > 0)
                                  Text(
                                    "${warranty["daysRemaining"]} days left",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (warranty["daysRemaining"] as int) < 30 
                                        ? dangerColor 
                                        : disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                            
                            Text(
                              "${warranty["description"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${warranty["component"]} • ${warranty["vehicle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${warranty["provider"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${warranty["warrantyNumber"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warranty["startDate"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Date",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warranty["endDate"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: (warranty["daysRemaining"] as int) < 30 
                                            ? dangerColor 
                                            : primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Claims Used",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warranty["claimsUsed"]}/${warranty["maxClaims"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: (warranty["claimsUsed"] as int) >= (warranty["maxClaims"] as int) 
                                            ? dangerColor 
                                            : successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            if ((warranty["mileageLimit"] as int) > 0)
                              Row(
                                children: [
                                  Icon(
                                    Icons.speed,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Mileage: ${(warranty["currentMileage"] as int).toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},'
                                    )} / ${(warranty["mileageLimit"] as int).toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},'
                                    )} km",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if ((warranty["mileageRemaining"] as int) > 0)
                                    Text(
                                      "${(warranty["mileageRemaining"] as int).toString().replaceAllMapped(
                                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                        (Match m) => '${m[1]},'
                                      )} km remaining",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: (warranty["mileageRemaining"] as int) < 10000 
                                          ? warningColor 
                                          : successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Coverage:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${warranty["coverage"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${warranty["contactInfo"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "File Claim",
                                  size: bs.sm,
                                  onPressed: () {
                                    // File warranty claim
                                  },
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add warranty
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getWarrantyTypeColor(String type) {
    switch (type) {
      case "Vehicle Warranty":
        return primaryColor;
      case "Extended Warranty":
        return infoColor;
      case "Parts Warranty":
        return successColor;
      case "Service Warranty":
        return warningColor;
      case "Tire Warranty":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
}

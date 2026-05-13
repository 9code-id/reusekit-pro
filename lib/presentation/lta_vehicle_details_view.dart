import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleDetailsView extends StatefulWidget {
  const LtaVehicleDetailsView({super.key});

  @override
  State<LtaVehicleDetailsView> createState() => _LtaVehicleDetailsViewState();
}

class _LtaVehicleDetailsViewState extends State<LtaVehicleDetailsView> {
  bool loading = true;
  int selectedTab = 0;

  Map<String, dynamic> vehicleData = {
    "id": "VH001",
    "plateNumber": "B 1234 ABC",
    "brand": "Toyota",
    "model": "Hiace",
    "year": 2022,
    "color": "White",
    "vehicleType": "Van",
    "capacity": "3000 kg",
    "fuelType": "Diesel",
    "engineCapacity": "2500 cc",
    "mileage": 45680,
    "status": "Active",
    "lastService": "2024-03-01T00:00:00Z",
    "nextService": "2024-06-01T00:00:00Z",
    "insurance": {
      "provider": "Asuransi Central Asia",
      "policyNumber": "INS-VH001-2024",
      "expiryDate": "2024-12-31T00:00:00Z",
      "coverage": "Comprehensive"
    },
    "license": {
      "number": "LIC-VH001",
      "expiryDate": "2025-03-15T00:00:00Z",
      "issuedBy": "Transport Authority"
    },
    "driver": {
      "name": "Ahmad Wijaya",
      "id": "DRV001",
      "phone": "+62 812-3456-7890"
    },
    "documents": [
      {"name": "Vehicle Registration", "status": "Valid", "expiry": "2025-03-15"},
      {"name": "Insurance Certificate", "status": "Valid", "expiry": "2024-12-31"},
      {"name": "Road Tax", "status": "Valid", "expiry": "2024-12-31"},
      {"name": "Emission Test", "status": "Valid", "expiry": "2024-09-15"}
    ]
  };

  List<Map<String, dynamic>> maintenanceHistory = [
    {
      "id": "MNT001",
      "date": "2024-03-01",
      "type": "Regular Service",
      "mileage": 45000,
      "cost": 850000,
      "garage": "Toyota Service Center",
      "items": ["Oil Change", "Filter Replacement", "Brake Check"],
      "status": "Completed"
    },
    {
      "id": "MNT002",
      "date": "2024-01-15",
      "type": "Tire Replacement",
      "mileage": 43500,
      "cost": 1200000,
      "garage": "Bridgestone Center",
      "items": ["4 New Tires", "Wheel Alignment"],
      "status": "Completed"
    },
    {
      "id": "MNT003",
      "date": "2023-12-10",
      "type": "Engine Service",
      "mileage": 42000,
      "cost": 1500000,
      "garage": "Toyota Service Center",
      "items": ["Engine Tune-up", "Spark Plug Replacement", "Oil Change"],
      "status": "Completed"
    }
  ];

  List<Map<String, dynamic>> fuelRecords = [
    {
      "id": "FUEL001",
      "date": "2024-03-15",
      "amount": 45.5,
      "cost": 682500,
      "pricePerLiter": 15000,
      "station": "Pertamina SPBU 123",
      "mileage": 45680,
      "fuelType": "Solar"
    },
    {
      "id": "FUEL002", 
      "date": "2024-03-12",
      "amount": 50.0,
      "cost": 750000,
      "pricePerLiter": 15000,
      "station": "Shell Station",
      "mileage": 45200,
      "fuelType": "Solar"
    },
    {
      "id": "FUEL003",
      "date": "2024-03-09",
      "amount": 42.3,
      "cost": 634500,
      "pricePerLiter": 15000,
      "station": "Pertamina SPBU 456",
      "mileage": 44850,
      "fuelType": "Solar"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadVehicleData();
  }

  void _loadVehicleData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'valid':
      case 'completed':
        return successColor;
      case 'inactive':
      case 'expired':
        return dangerColor;
      case 'maintenance':
      case 'pending':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildInfoCard(String title, String value, {IconData? icon, Color? valueColor}) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              if (icon != null) ...[
                Icon(icon, size: 16, color: primaryColor),
                SizedBox(width: spXs),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor ?? primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Vehicle Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.local_shipping,
                        size: 32,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vehicleData["plateNumber"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${vehicleData["brand"]} ${vehicleData["model"]} ${vehicleData["year"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${vehicleData["status"]}").withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${vehicleData["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor("${vehicleData["status"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        // Edit vehicle details
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildInfoCard(
                "Current Mileage",
                "${((vehicleData["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                icon: Icons.speed,
              ),
              _buildInfoCard(
                "Fuel Type",
                "${vehicleData["fuelType"]}",
                icon: Icons.local_gas_station,
              ),
              _buildInfoCard(
                "Capacity",
                "${vehicleData["capacity"]}",
                icon: Icons.fitness_center,
              ),
              _buildInfoCard(
                "Engine",
                "${vehicleData["engineCapacity"]}",
                icon: Icons.build,
              ),
            ],
          ),

          // Driver Information
          Container(
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
                    Icon(Icons.person, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Assigned Driver",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Change",
                      size: bs.sm,
                      onPressed: () {
                        // Change driver
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.person,
                        color: secondaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(vehicleData["driver"] as Map)["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "ID: ${(vehicleData["driver"] as Map)["id"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(vehicleData["driver"] as Map)["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        // Call driver
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Service Schedule
          Container(
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
                    Icon(Icons.build, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Service Schedule",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Service",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            DateTime.parse("${vehicleData["lastService"]}").dMMMy,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Service",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            DateTime.parse("${vehicleData["nextService"]}").dMMMy,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Service",
                    icon: Icons.schedule,
                    size: bs.sm,
                    onPressed: () {
                      // Schedule service
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Insurance Info
          Container(
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
                    Icon(Icons.security, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Insurance Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Provider",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(vehicleData["insurance"] as Map)["provider"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Policy Number",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(vehicleData["insurance"] as Map)["policyNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Coverage",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(vehicleData["insurance"] as Map)["coverage"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Expires",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          DateTime.parse("${(vehicleData["insurance"] as Map)["expiryDate"]}").dMMMy,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // License Info
          Container(
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
                    Icon(Icons.card_membership, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "License Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "License Number",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(vehicleData["license"] as Map)["number"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Issued By",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(vehicleData["license"] as Map)["issuedBy"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Expires",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          DateTime.parse("${(vehicleData["license"] as Map)["expiryDate"]}").dMMMy,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Documents List
          Container(
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
                    Icon(Icons.folder, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Vehicle Documents",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Document",
                      size: bs.sm,
                      onPressed: () {
                        // Add document
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  children: (vehicleData["documents"] as List).map((doc) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${doc["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Expires: ${doc["expiry"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${doc["status"]}").withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${doc["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: _getStatusColor("${doc["status"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {
                              // Download document
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Maintenance Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Maintenance Record",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // Add maintenance
              },
            ),
          ),

          // Maintenance History
          Column(
            children: maintenanceHistory.map((maintenance) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.build,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${maintenance["type"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                DateTime.parse("${maintenance["date"]}T00:00:00Z").dMMMy,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${maintenance["status"]}").withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${maintenance["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${maintenance["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Details
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: [
                        _buildInfoCard(
                          "Mileage",
                          "${((maintenance["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                          icon: Icons.speed,
                        ),
                        _buildInfoCard(
                          "Cost",
                          "Rp ${((maintenance["cost"] as int).toDouble()).currency}",
                          icon: Icons.attach_money,
                        ),
                        _buildInfoCard(
                          "Garage",
                          "${maintenance["garage"]}",
                          icon: Icons.store,
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Items
                    Text(
                      "Services Performed:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (maintenance["items"] as List).map((item) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: secondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$item",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Fuel Record Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Fuel Record",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // Add fuel record
              },
            ),
          ),

          // Fuel Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fuel Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    _buildInfoCard(
                      "Total Fuel",
                      "${fuelRecords.fold(0.0, (sum, record) => sum + (record["amount"] as double)).toStringAsFixed(1)}L",
                      icon: Icons.local_gas_station,
                    ),
                    _buildInfoCard(
                      "Total Cost",
                      "Rp ${((fuelRecords.fold(0, (sum, record) => sum + (record["cost"] as int))).toDouble()).currency}",
                      icon: Icons.attach_money,
                    ),
                    _buildInfoCard(
                      "Avg Price/L",
                      "Rp ${((fuelRecords.fold(0, (sum, record) => sum + (record["pricePerLiter"] as int)) / fuelRecords.length).toDouble()).currency}",
                      icon: Icons.trending_up,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Fuel Records
          Column(
            children: fuelRecords.map((fuel) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.local_gas_station,
                            color: warningColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${fuel["station"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                DateTime.parse("${fuel["date"]}T00:00:00Z").dMMMy,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Rp ${((fuel["cost"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 120,
                      children: [
                        _buildInfoCard(
                          "Amount",
                          "${(fuel["amount"] as double).toStringAsFixed(1)}L",
                          icon: Icons.local_gas_station,
                        ),
                        _buildInfoCard(
                          "Price/Liter",
                          "Rp ${((fuel["pricePerLiter"] as int).toDouble()).currency}",
                          icon: Icons.attach_money,
                        ),
                        _buildInfoCard(
                          "Mileage",
                          "${((fuel["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                          icon: Icons.speed,
                        ),
                        _buildInfoCard(
                          "Fuel Type",
                          "${fuel["fuelType"]}",
                          icon: Icons.oil_barrel,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Vehicle Details"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Vehicle Details",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
        Tab(text: "Maintenance", icon: Icon(Icons.build)),
        Tab(text: "Fuel", icon: Icon(Icons.local_gas_station)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDocumentsTab(),
        _buildMaintenanceTab(),
        _buildFuelTab(),
      ],
    );
  }
}

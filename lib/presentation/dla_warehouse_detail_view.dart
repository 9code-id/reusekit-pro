import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaWarehouseDetailView extends StatefulWidget {
  const DlaWarehouseDetailView({super.key});

  @override
  State<DlaWarehouseDetailView> createState() => _DlaWarehouseDetailViewState();
}

class _DlaWarehouseDetailViewState extends State<DlaWarehouseDetailView> {
  String selectedTab = "overview";
  
  final Map<String, dynamic> warehouse = {
    "id": "WH-001",
    "name": "Jakarta Main Warehouse",
    "code": "JKT-MAIN",
    "address": "Jl. Industri Raya No. 15, Jakarta Timur",
    "manager": "Budi Santoso",
    "phone": "+62 21 8765 4321",
    "email": "jakarta.main@dla.com",
    "totalArea": 15000,
    "usedArea": 12500,
    "availableArea": 2500,
    "totalCapacity": 50000,
    "currentStock": 42000,
    "operatingHours": "06:00 - 22:00",
    "established": "2019-03-15",
    "status": "active",
    "zones": [
      {
        "id": "A1",
        "name": "Electronics Zone",
        "capacity": 10000,
        "currentStock": 8500,
        "temperature": "20-25°C",
        "humidity": "45-55%",
      },
      {
        "id": "B1", 
        "name": "Textile Zone",
        "capacity": 15000,
        "currentStock": 12000,
        "temperature": "18-22°C",
        "humidity": "40-50%",
      },
      {
        "id": "C1",
        "name": "Food & Beverage",
        "capacity": 12000,
        "currentStock": 9500,
        "temperature": "2-8°C",
        "humidity": "80-90%",
      },
      {
        "id": "D1",
        "name": "Automotive Parts",
        "capacity": 13000,
        "currentStock": 12000,
        "temperature": "15-30°C",
        "humidity": "30-60%",
      },
    ],
    "equipment": [
      {"name": "Forklift", "count": 8, "status": "operational"},
      {"name": "Conveyor Belt", "count": 4, "status": "operational"},
      {"name": "Pallet Jack", "count": 15, "status": "operational"},
      {"name": "Scanner Gun", "count": 25, "status": "operational"},
    ],
    "recentActivities": [
      {
        "timestamp": "2024-01-15 14:30:00",
        "activity": "Stock Received",
        "description": "1,200 units of Electronics received",
        "user": "John Smith",
      },
      {
        "timestamp": "2024-01-15 13:45:00", 
        "activity": "Stock Dispatched",
        "description": "850 units shipped to Bandung",
        "user": "Sarah Johnson",
      },
      {
        "timestamp": "2024-01-15 12:20:00",
        "activity": "Inventory Check",
        "description": "Zone A1 inventory verification completed",
        "user": "Mike Wilson",
      },
    ],
  };

  final List<Map<String, dynamic>> performanceData = [
    {"month": "Jan", "inbound": 15000, "outbound": 12000, "accuracy": 98.5},
    {"month": "Feb", "inbound": 18000, "outbound": 16000, "accuracy": 97.8},
    {"month": "Mar", "inbound": 16500, "outbound": 14500, "accuracy": 98.9},
    {"month": "Apr", "inbound": 19200, "outbound": 17800, "accuracy": 99.2},
    {"month": "May", "inbound": 21000, "outbound": 19500, "accuracy": 98.7},
    {"month": "Jun", "inbound": 22500, "outbound": 21000, "accuracy": 99.1},
  ];

  Color _getZoneStatusColor(int currentStock, int capacity) {
    double utilization = currentStock / capacity;
    if (utilization > 0.9) return dangerColor;
    if (utilization > 0.7) return warningColor;
    return successColor;
  }

  Widget _buildWarehouseOverview() {
    double utilizationPercentage = ((warehouse["currentStock"] as int) / (warehouse["totalCapacity"] as int)) * 100;
    double areaUtilization = ((warehouse["usedArea"] as int) / (warehouse["totalArea"] as int)) * 100;

    return Column(
      spacing: spMd,
      children: [
        // Warehouse Stats
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(Icons.inventory, color: primaryColor, size: 32),
                    SizedBox(height: spXs),
                    Text(
                      "${warehouse["currentStock"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Current Stock",
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
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(Icons.dashboard, color: successColor, size: 32),
                    SizedBox(height: spXs),
                    Text(
                      "${utilizationPercentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Utilization",
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
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(Icons.square_foot, color: infoColor, size: 32),
                    SizedBox(height: spXs),
                    Text(
                      "${areaUtilization.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Area Used",
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

        // Warehouse Info Card
        Container(
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
                "Warehouse Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.person, color: disabledBoldColor, size: 18),
                  SizedBox(width: spXs),
                  Text(
                    "Manager: ${warehouse["manager"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone, color: disabledBoldColor, size: 18),
                  SizedBox(width: spXs),
                  Text(
                    "${warehouse["phone"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: disabledBoldColor, size: 18),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${warehouse["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time, color: disabledBoldColor, size: 18),
                  SizedBox(width: spXs),
                  Text(
                    "Operating Hours: ${warehouse["operatingHours"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Zone Status
        Container(
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
                "Zone Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(warehouse["zones"] as List).map((zone) {
                double utilization = (zone["currentStock"] as int) / (zone["capacity"] as int);
                Color statusColor = _getZoneStatusColor(zone["currentStock"], zone["capacity"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: statusColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${zone["id"]} - ${zone["name"]}",
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
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(utilization * 100).toStringAsFixed(1)}%",
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
                          Text(
                            "Stock: ${zone["currentStock"]} / ${zone["capacity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Temp: ${zone["temperature"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                          widthFactor: utilization,
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
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentStatus() {
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
            "Equipment Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(warehouse["equipment"] as List).map((equipment) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.precision_manufacturing, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${equipment["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Count: ${equipment["count"]} units",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${equipment["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
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
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(warehouse["recentActivities"] as List).map((activity) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["activity"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${activity["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${activity["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "By: ${activity["user"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
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
        title: Text("${warehouse["name"]}"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              si("Edit warehouse details");
            },
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("More warehouse options");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildWarehouseOverview(),
            Row(
              spacing: spMd,
              children: [
                Expanded(child: _buildEquipmentStatus()),
                Expanded(child: _buildRecentActivities()),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Manage Inventory",
                size: bs.md,
                onPressed: () {
                  si("Navigate to inventory management");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

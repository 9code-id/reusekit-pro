import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWarehouseMonitoringView extends StatefulWidget {
  const AmaWarehouseMonitoringView({super.key});

  @override
  State<AmaWarehouseMonitoringView> createState() => _AmaWarehouseMonitoringViewState();
}

class _AmaWarehouseMonitoringViewState extends State<AmaWarehouseMonitoringView> {
  String selectedWarehouse = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> warehouses = [
    {
      "id": "WH001",
      "name": "Main Warehouse",
      "location": "Central District",
      "capacity": 1000,
      "currentLoad": 750,
      "temperature": 22.5,
      "humidity": 65,
      "status": "Operational",
      "manager": "John Smith",
      "lastInspection": "2024-03-15",
      "alertCount": 2,
      "energyConsumption": 450,
      "sections": [
        {"name": "Seeds Storage", "capacity": 300, "used": 250, "temperature": 18.5, "humidity": 45},
        {"name": "Fertilizer Area", "capacity": 400, "used": 350, "temperature": 24.0, "humidity": 55},
        {"name": "Equipment Storage", "capacity": 300, "used": 150, "temperature": 25.0, "humidity": 70},
      ],
      "recentActivities": [
        {"type": "Stock In", "item": "Wheat Seeds", "quantity": "50 kg", "time": "10:30 AM"},
        {"type": "Stock Out", "item": "NPK Fertilizer", "quantity": "20 bags", "time": "9:15 AM"},
        {"type": "Temperature Alert", "description": "High temperature in Section B", "time": "8:45 AM"},
      ],
    },
    {
      "id": "WH002",
      "name": "Cold Storage",
      "location": "North Zone",
      "capacity": 500,
      "currentLoad": 320,
      "temperature": 4.2,
      "humidity": 85,
      "status": "Operational",
      "manager": "Sarah Johnson",
      "lastInspection": "2024-03-14",
      "alertCount": 0,
      "energyConsumption": 680,
      "sections": [
        {"name": "Vegetable Storage", "capacity": 200, "used": 150, "temperature": 2.5, "humidity": 90},
        {"name": "Fruit Storage", "capacity": 200, "used": 120, "temperature": 5.0, "humidity": 85},
        {"name": "Dairy Products", "capacity": 100, "used": 50, "temperature": 6.0, "humidity": 80},
      ],
      "recentActivities": [
        {"type": "Quality Check", "item": "Stored Apples", "description": "Quality maintained", "time": "11:00 AM"},
        {"type": "Stock In", "item": "Fresh Vegetables", "quantity": "100 kg", "time": "7:30 AM"},
      ],
    },
    {
      "id": "WH003",
      "name": "Equipment Warehouse",
      "location": "Industrial Area",
      "capacity": 800,
      "currentLoad": 600,
      "temperature": 28.5,
      "humidity": 45,
      "status": "Maintenance",
      "manager": "Mike Wilson",
      "lastInspection": "2024-03-10",
      "alertCount": 5,
      "energyConsumption": 320,
      "sections": [
        {"name": "Large Equipment", "capacity": 400, "used": 350, "temperature": 30.0, "humidity": 40},
        {"name": "Small Tools", "capacity": 200, "used": 150, "temperature": 26.0, "humidity": 50},
        {"name": "Spare Parts", "capacity": 200, "used": 100, "temperature": 29.0, "humidity": 45},
      ],
      "recentActivities": [
        {"type": "Maintenance", "item": "Ventilation System", "description": "Scheduled maintenance", "time": "2:00 PM"},
        {"type": "Alert", "description": "High humidity detected", "time": "1:30 PM"},
        {"type": "Stock Check", "item": "Irrigation Equipment", "description": "Inventory updated", "time": "12:15 PM"},
      ],
    },
  ];

  List<Map<String, dynamic>> warehouseOptions = [
    {"label": "All", "value": "All"},
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Cold Storage", "value": "Cold Storage"},
    {"label": "Equipment Warehouse", "value": "Equipment Warehouse"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Operational", "value": "Operational"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Offline", "value": "Offline"},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'operational':
        return successColor;
      case 'maintenance':
        return warningColor;
      case 'offline':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 10) return infoColor;
    if (temperature > 30) return dangerColor;
    if (temperature > 25) return warningColor;
    return successColor;
  }

  List<Map<String, dynamic>> get filteredWarehouses {
    return warehouses.where((warehouse) {
      bool matchesWarehouse = selectedWarehouse == "All" || "${warehouse["name"]}" == selectedWarehouse;
      bool matchesStatus = selectedStatus == "All" || "${warehouse["status"]}" == selectedStatus;
      
      return matchesWarehouse && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate summary stats
    double totalCapacity = filteredWarehouses.fold(0.0, (sum, warehouse) => sum + (warehouse["capacity"] as int));
    double totalUsed = filteredWarehouses.fold(0.0, (sum, warehouse) => sum + (warehouse["currentLoad"] as int));
    int totalAlerts = filteredWarehouses.fold(0, (sum, warehouse) => sum + (warehouse["alertCount"] as int));
    double totalEnergy = filteredWarehouses.fold(0.0, (sum, warehouse) => sum + (warehouse["energyConsumption"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Warehouse Monitoring"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // View all alerts
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Warehouse settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.warehouse,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Capacity",
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
                          "${((totalUsed / totalCapacity) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${totalUsed.toInt()} / ${totalCapacity.toInt()}",
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
                              Icons.warning,
                              color: totalAlerts > 0 ? warningColor : successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Alerts",
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
                          "$totalAlerts",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: totalAlerts > 0 ? warningColor : successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Energy Consumption Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.bolt,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Energy Consumption",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${totalEnergy.toInt()} kWh",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Monthly",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Warehouse",
                    items: warehouseOptions,
                    value: selectedWarehouse,
                    onChanged: (value, label) {
                      selectedWarehouse = value;
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

            // Warehouses List
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredWarehouses.length,
              separatorBuilder: (context, index) => SizedBox(height: spMd),
              itemBuilder: (context, index) {
                final warehouse = filteredWarehouses[index];
                final sections = warehouse["sections"] as List;
                final activities = warehouse["recentActivities"] as List;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Warehouse Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor("${warehouse["status"]}"),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${warehouse["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${warehouse["location"]} • ID: ${warehouse["id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${warehouse["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${warehouse["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${warehouse["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Capacity",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warehouse["currentLoad"]} / ${warehouse["capacity"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
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
                                        "Temperature",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warehouse["temperature"]}°C",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _getTemperatureColor(warehouse["temperature"] as double),
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
                                        "Humidity",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${warehouse["humidity"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Sections
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Storage Sections",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: sections.map<Widget>((section) {
                                double utilizationRate = ((section["used"] as int) / (section["capacity"] as int)) * 100;
                                return Container(
                                  margin: EdgeInsets.only(bottom: spSm),
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(5),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${section["name"]}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${utilizationRate.toInt()}% utilized",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${section["temperature"]}°C",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getTemperatureColor(section["temperature"] as double),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${section["humidity"]}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Recent Activities
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Activities",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: activities.take(3).map<Widget>((activity) {
                                IconData icon;
                                Color iconColor;
                                
                                switch ("${activity["type"]}".toLowerCase()) {
                                  case 'stock in':
                                    icon = Icons.arrow_downward;
                                    iconColor = successColor;
                                    break;
                                  case 'stock out':
                                    icon = Icons.arrow_upward;
                                    iconColor = infoColor;
                                    break;
                                  case 'alert':
                                  case 'temperature alert':
                                    icon = Icons.warning;
                                    iconColor = warningColor;
                                    break;
                                  case 'maintenance':
                                    icon = Icons.build;
                                    iconColor = primaryColor;
                                    break;
                                  default:
                                    icon = Icons.info;
                                    iconColor = disabledBoldColor;
                                }
                                
                                return Container(
                                  margin: EdgeInsets.only(bottom: spSm),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: iconColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          icon,
                                          color: iconColor,
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${activity["type"]}${activity["item"] != null ? " - ${activity["item"]}" : ""}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (activity["description"] != null)
                                              Text(
                                                "${activity["description"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            if (activity["quantity"] != null)
                                              Text(
                                                "${activity["quantity"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${activity["time"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // View warehouse details
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Monitor Live",
                                size: bs.sm,
                                onPressed: () {
                                  // Live monitoring
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

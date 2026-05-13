import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRepairCostsView extends StatefulWidget {
  const CmaRepairCostsView({super.key});

  @override
  State<CmaRepairCostsView> createState() => _CmaRepairCostsViewState();
}

class _CmaRepairCostsViewState extends State<CmaRepairCostsView> {
  String selectedVehicle = "All Vehicles";
  String dateFilter = "This Year";
  String repairTypeFilter = "All Types";

  List<Map<String, dynamic>> repairRecords = [
    {
      "id": 1,
      "date": "2025-06-15",
      "vehicle": "Honda Civic",
      "repairType": "Engine",
      "description": "Engine Oil Change & Filter Replacement",
      "cost": 89.99,
      "laborCost": 45.00,
      "partsCost": 44.99,
      "odometer": 45234,
      "shop": "Quick Lube Express",
      "warrantyPeriod": 90,
      "priority": "Routine",
      "status": "Completed",
      "nextService": "2025-09-15",
    },
    {
      "id": 2,
      "date": "2025-06-08",
      "vehicle": "Toyota Camry",
      "repairType": "Brakes",
      "description": "Front Brake Pad Replacement",
      "cost": 245.80,
      "laborCost": 120.00,
      "partsCost": 125.80,
      "odometer": 67456,
      "shop": "City Auto Repair",
      "warrantyPeriod": 180,
      "priority": "High",
      "status": "Completed",
      "nextService": "2026-06-08",
    },
    {
      "id": 3,
      "date": "2025-05-22",
      "vehicle": "Honda Civic",
      "repairType": "Tires",
      "description": "Tire Rotation & Alignment",
      "cost": 125.50,
      "laborCost": 85.00,
      "partsCost": 40.50,
      "odometer": 44891,
      "shop": "Tire Pro",
      "warrantyPeriod": 30,
      "priority": "Medium",
      "status": "Completed",
      "nextService": "2025-11-22",
    },
    {
      "id": 4,
      "date": "2025-05-10",
      "vehicle": "Toyota Camry",
      "repairType": "Transmission",
      "description": "Transmission Fluid Service",
      "cost": 156.75,
      "laborCost": 95.00,
      "partsCost": 61.75,
      "odometer": 67123,
      "shop": "Auto Care Center",
      "warrantyPeriod": 120,
      "priority": "High",
      "status": "Completed",
      "nextService": "2027-05-10",
    },
    {
      "id": 5,
      "date": "2025-04-18",
      "vehicle": "Honda Civic",
      "repairType": "Electrical",
      "description": "Battery Replacement",
      "cost": 189.99,
      "laborCost": 65.00,
      "partsCost": 124.99,
      "odometer": 44523,
      "shop": "Battery Plus",
      "warrantyPeriod": 365,
      "priority": "High",
      "status": "Completed",
      "nextService": "2029-04-18",
    },
    {
      "id": 6,
      "date": "2025-07-01",
      "vehicle": "Honda Civic",
      "repairType": "Air Conditioning",
      "description": "AC System Inspection & Recharge",
      "cost": 125.00,
      "laborCost": 75.00,
      "partsCost": 50.00,
      "odometer": 45800,
      "shop": "Cool Air Service",
      "warrantyPeriod": 60,
      "priority": "Medium",
      "status": "Scheduled",
      "nextService": "2026-07-01",
    },
  ];

  List<Map<String, dynamic>> get filteredRepairs {
    return repairRecords.where((repair) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        repair["vehicle"] == selectedVehicle;
      bool typeMatch = repairTypeFilter == "All Types" || 
        repair["repairType"] == repairTypeFilter;
      return vehicleMatch && typeMatch;
    }).toList();
  }

  double get totalRepairCosts {
    return filteredRepairs.fold(0.0, (sum, repair) => 
      sum + (repair["cost"] as double)
    );
  }

  double get averageRepairCost {
    if (filteredRepairs.isEmpty) return 0.0;
    return totalRepairCosts / filteredRepairs.length;
  }

  int get completedRepairs {
    return filteredRepairs
      .where((repair) => repair["status"] == "Completed")
      .length;
  }

  Map<String, double> get costsByType {
    Map<String, double> typeCosts = {};
    for (var repair in filteredRepairs) {
      String type = repair["repairType"];
      double cost = repair["cost"] as double;
      typeCosts[type] = (typeCosts[type] ?? 0.0) + cost;
    }
    return typeCosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair Costs"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add repair record
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // View repair schedule
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
                      Icon(Icons.tune, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Repairs",
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
                          label: "Repair Type",
                          items: [
                            {"label": "All Types", "value": "All Types"},
                            {"label": "Engine", "value": "Engine"},
                            {"label": "Brakes", "value": "Brakes"},
                            {"label": "Tires", "value": "Tires"},
                            {"label": "Transmission", "value": "Transmission"},
                            {"label": "Electrical", "value": "Electrical"},
                            {"label": "Air Conditioning", "value": "Air Conditioning"},
                          ],
                          value: repairTypeFilter,
                          onChanged: (value, label) {
                            repairTypeFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                            Icons.attach_money,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Repair Costs",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalRepairCosts.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
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
                            Icons.trending_up,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Repair Cost",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${averageRepairCost.toStringAsFixed(2)}",
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
                            Icons.build_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed Repairs",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedRepairs repairs",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Repair Cost Breakdown by Type
            Container(
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
                      Icon(Icons.pie_chart, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Costs by Repair Type",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...costsByType.entries.map((entry) {
                    double percentage = (entry.value / totalRepairCosts) * 100;
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getRepairTypeIcon(entry.key),
                                size: 16,
                                color: _getRepairTypeColor(entry.key),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${entry.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getRepairTypeColor(entry.key),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: disabledColor.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getRepairTypeColor(entry.key),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Repair Records List
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
                        Icon(Icons.list_alt, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Repair History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredRepairs.length} records",
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
                    itemCount: filteredRepairs.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final repair = filteredRepairs[index];
                      
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
                                    color: _getStatusColor(repair["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${repair["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getStatusColor(repair["status"]),
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
                                    color: _getPriorityColor(repair["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${repair["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getPriorityColor(repair["priority"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${repair["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${repair["description"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  _getRepairTypeIcon(repair["repairType"]),
                                  size: 14,
                                  color: _getRepairTypeColor(repair["repairType"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${repair["repairType"]} • ${repair["vehicle"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.build,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${repair["shop"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                                        "Odometer",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(repair["odometer"] as int).toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                        )} km",
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
                                        "Labor Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(repair["laborCost"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: warningColor,
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
                                        "Parts Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(repair["partsCost"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
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
                                        "Total Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(repair["cost"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            if (repair["warrantyPeriod"] != null)
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.security,
                                      size: 14,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Warranty: ${repair["warrantyPeriod"]} days",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (repair["nextService"] != null) ...[
                                      Spacer(),
                                      Text(
                                        "Next service: ${repair["nextService"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add repair record
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getRepairTypeColor(String type) {
    switch (type) {
      case "Engine":
        return dangerColor;
      case "Brakes":
        return warningColor;
      case "Tires":
        return infoColor;
      case "Transmission":
        return primaryColor;
      case "Electrical":
        return successColor;
      case "Air Conditioning":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRepairTypeIcon(String type) {
    switch (type) {
      case "Engine":
        return Icons.settings;
      case "Brakes":
        return Icons.disc_full;
      case "Tires":
        return Icons.tire_repair;
      case "Transmission":
        return Icons.settings_applications;
      case "Electrical":
        return Icons.electrical_services;
      case "Air Conditioning":
        return Icons.ac_unit;
      default:
        return Icons.build;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Scheduled":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Routine":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}

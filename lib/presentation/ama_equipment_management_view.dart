import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaEquipmentManagementView extends StatefulWidget {
  const AmaEquipmentManagementView({super.key});

  @override
  State<AmaEquipmentManagementView> createState() => _AmaEquipmentManagementViewState();
}

class _AmaEquipmentManagementViewState extends State<AmaEquipmentManagementView> {
  int selectedTab = 0;
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Tractors", "value": "tractors"},
    {"label": "Harvesting", "value": "harvesting"},
    {"label": "Planting", "value": "planting"},
    {"label": "Cultivation", "value": "cultivation"},
    {"label": "Irrigation", "value": "irrigation"},
    {"label": "Transportation", "value": "transportation"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Retired", "value": "retired"},
    {"label": "Rented", "value": "rented"},
  ];

  List<Map<String, dynamic>> equipmentList = [
    {
      "id": "EQ001",
      "name": "John Deere 7210R",
      "category": "tractors",
      "type": "Tractor",
      "model": "7210R",
      "brand": "John Deere",
      "year": 2020,
      "status": "active",
      "condition": "excellent",
      "purchaseDate": "2020-03-15",
      "purchasePrice": 185000.0,
      "currentValue": 145000.0,
      "hoursUsed": 1250,
      "maxHours": 8000,
      "lastMaintenance": "2024-06-15",
      "nextMaintenance": "2024-09-15",
      "fuelType": "Diesel",
      "location": "Main Farm",
      "operator": "Mike Johnson",
      "insurance": "Active",
      "warranty": "Expired",
      "notes": "Primary field tractor, excellent condition",
    },
    {
      "id": "EQ002",
      "name": "Case IH 8250",
      "category": "harvesting",
      "type": "Combine Harvester",
      "model": "8250",
      "brand": "Case IH",
      "year": 2018,
      "status": "active",
      "condition": "good",
      "purchaseDate": "2018-07-20",
      "purchasePrice": 420000.0,
      "currentValue": 285000.0,
      "hoursUsed": 680,
      "maxHours": 5000,
      "lastMaintenance": "2024-05-10",
      "nextMaintenance": "2024-08-10",
      "fuelType": "Diesel",
      "location": "North Field",
      "operator": "Sarah Wilson",
      "insurance": "Active",
      "warranty": "Active",
      "notes": "Primary harvester for corn and soybeans",
    },
    {
      "id": "EQ003",
      "name": "Kinze 3600 Planter",
      "category": "planting",
      "type": "Planter",
      "model": "3600",
      "brand": "Kinze",
      "year": 2019,
      "status": "maintenance",
      "condition": "good",
      "purchaseDate": "2019-02-10",
      "purchasePrice": 125000.0,
      "currentValue": 95000.0,
      "hoursUsed": 320,
      "maxHours": 3000,
      "lastMaintenance": "2024-08-01",
      "nextMaintenance": "2024-11-01",
      "fuelType": "None",
      "location": "Equipment Shed",
      "operator": "Tom Davis",
      "insurance": "Active",
      "warranty": "Active",
      "notes": "Currently undergoing seasonal maintenance",
    },
    {
      "id": "EQ004",
      "name": "Ford F-350",
      "category": "transportation",
      "type": "Pickup Truck",
      "model": "F-350",
      "brand": "Ford",
      "year": 2017,
      "status": "active",
      "condition": "fair",
      "purchaseDate": "2017-09-05",
      "purchasePrice": 45000.0,
      "currentValue": 25000.0,
      "hoursUsed": 0,
      "maxHours": 0,
      "lastMaintenance": "2024-07-20",
      "nextMaintenance": "2024-10-20",
      "fuelType": "Gasoline",
      "location": "Main Farm",
      "operator": "Multiple",
      "insurance": "Active",
      "warranty": "Expired",
      "notes": "General farm transportation and light hauling",
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "equipmentId": "EQ001",
      "equipmentName": "John Deere 7210R",
      "maintenanceType": "Oil Change",
      "dueDate": "2024-09-15",
      "priority": "medium",
      "estimatedCost": 250.0,
      "description": "Regular oil and filter change",
    },
    {
      "equipmentId": "EQ002",
      "equipmentName": "Case IH 8250",
      "maintenanceType": "Annual Inspection",
      "dueDate": "2024-08-10",
      "priority": "high",
      "estimatedCost": 1500.0,
      "description": "Complete annual inspection and service",
    },
    {
      "equipmentId": "EQ003",
      "equipmentName": "Kinze 3600 Planter",
      "maintenanceType": "Seasonal Overhaul",
      "dueDate": "2024-08-30",
      "priority": "high",
      "estimatedCost": 3500.0,
      "description": "Complete overhaul before planting season",
    },
  ];

  List<Map<String, dynamic>> utilizationData = [
    {
      "month": "January",
      "hours": 45,
      "fuelCost": 1200.0,
      "maintenanceCost": 850.0,
    },
    {
      "month": "February",
      "hours": 38,
      "fuelCost": 980.0,
      "maintenanceCost": 450.0,
    },
    {
      "month": "March",
      "hours": 78,
      "fuelCost": 2100.0,
      "maintenanceCost": 1200.0,
    },
    {
      "month": "April",
      "hours": 142,
      "fuelCost": 3800.0,
      "maintenanceCost": 750.0,
    },
    {
      "month": "May",
      "hours": 165,
      "fuelCost": 4200.0,
      "maintenanceCost": 1800.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Equipment Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Maintenance", icon: Icon(Icons.build)),
        Tab(text: "Utilization", icon: Icon(Icons.trending_up)),
        Tab(text: "Add Equipment", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildInventoryTab(),
        _buildMaintenanceTab(),
        _buildUtilizationTab(),
        _buildAddEquipmentTab(),
      ],
    );
  }

  Widget _buildInventoryTab() {
    List<Map<String, dynamic>> filteredEquipment = equipmentList.where((equipment) {
      bool categoryMatch = selectedCategory == "all" || equipment["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "all" || equipment["status"] == selectedStatus;
      bool searchMatch = searchQuery.isEmpty || 
          equipment["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          equipment["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && statusMatch && searchMatch;
    }).toList();

    double totalValue = equipmentList.fold(0.0, (sum, eq) => sum + (eq["currentValue"] as double));
    int activeCount = equipmentList.where((eq) => eq["status"] == "active").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Total Equipment",
                  "${equipmentList.length}",
                  primaryColor,
                  Icons.agriculture,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Active Units",
                  "$activeCount",
                  successColor,
                  Icons.check_circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Total Value",
                  "\$${(totalValue / 1000).toStringAsFixed(0)}K",
                  infoColor,
                  Icons.monetization_on,
                ),
              ),
            ],
          ),

          // Filters
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
                        label: "Search Equipment",
                        value: searchQuery,
                        hint: "Search by name, brand...",
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
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
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
              ],
            ),
          ),

          // Equipment List
          ...filteredEquipment.map((equipment) {
            Color statusColor = _getStatusColor(equipment["status"]);
            Color conditionColor = _getConditionColor(equipment["condition"]);
            double usagePercentage = equipment["maxHours"] > 0 
                ? (equipment["hoursUsed"] as int) / (equipment["maxHours"] as int) * 100 
                : 0;

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: statusColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${equipment["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${equipment["brand"]} ${equipment["model"]} (${equipment["year"]})",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${equipment["status"]}".toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: conditionColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${equipment["condition"]}".toUpperCase(),
                              style: TextStyle(
                                color: conditionColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Equipment Details
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Current Value:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(equipment["currentValue"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        if (equipment["maxHours"] > 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hours Used:", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "${equipment["hoursUsed"]}/${equipment["maxHours"]} (${usagePercentage.toStringAsFixed(1)}%)",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          // Usage Bar
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: usagePercentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: usagePercentage < 50 ? successColor : 
                                         usagePercentage < 80 ? warningColor : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Location:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${equipment["location"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Operator:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${equipment["operator"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Next Maintenance:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${equipment["nextMaintenance"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _isMaintenanceDue(equipment["nextMaintenance"]) ? dangerColor : successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Equipment Actions
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            _showEquipmentDetails(equipment);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule Service",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to service scheduling
                          },
                        ),
                      ),
                    ],
                  ),

                  if (equipment["notes"].isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${equipment["notes"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                              ),
                            ),
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
    );
  }

  Widget _buildMaintenanceTab() {
    // Sort maintenance by priority and due date
    List<Map<String, dynamic>> sortedMaintenance = List.from(maintenanceSchedule);
    sortedMaintenance.sort((a, b) {
      int priorityCompare = _getPriorityValue(b["priority"]).compareTo(_getPriorityValue(a["priority"]));
      if (priorityCompare != 0) return priorityCompare;
      return DateTime.parse(a["dueDate"]).compareTo(DateTime.parse(b["dueDate"]));
    });

    double totalMaintenanceCost = maintenanceSchedule.fold(0.0, (sum, m) => sum + (m["estimatedCost"] as double));
    int overdueTasks = maintenanceSchedule.where((m) => _isMaintenanceDue(m["dueDate"])).length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Maintenance Summary
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Scheduled Tasks",
                  "${maintenanceSchedule.length}",
                  primaryColor,
                  Icons.schedule,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Overdue Tasks",
                  "$overdueTasks",
                  dangerColor,
                  Icons.warning,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Est. Cost",
                  "\$${(totalMaintenanceCost / 1000).toStringAsFixed(1)}K",
                  warningColor,
                  Icons.attach_money,
                ),
              ),
            ],
          ),

          // Quick Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Maintenance",
                        icon: Icons.add,
                        onPressed: () {
                          // Navigate to maintenance scheduling
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Maintenance Log",
                        icon: Icons.history,
                        onPressed: () {
                          // Navigate to maintenance log
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Maintenance Schedule
          ...sortedMaintenance.map((maintenance) {
            Color priorityColor = _getPriorityColor(maintenance["priority"]);
            bool isOverdue = _isMaintenanceDue(maintenance["dueDate"]);

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: isOverdue ? dangerColor : priorityColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${maintenance["equipmentName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${maintenance["maintenanceType"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          if (isOverdue)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "OVERDUE",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${maintenance["priority"]}".toUpperCase(),
                              style: TextStyle(
                                color: priorityColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "${maintenance["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Due Date:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${maintenance["dueDate"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isOverdue ? dangerColor : primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Estimated Cost:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(maintenance["estimatedCost"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Equipment ID:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${maintenance["equipmentId"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Complete Task",
                          size: bs.sm,
                          onPressed: () {
                            ss("Maintenance task marked as completed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reschedule",
                          size: bs.sm,
                          onPressed: () {
                            // Open reschedule dialog
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUtilizationTab() {
    double totalHours = utilizationData.fold(0.0, (sum, data) => sum + (data["hours"] as int));
    double totalFuelCost = utilizationData.fold(0.0, (sum, data) => sum + (data["fuelCost"] as double));
    double totalMaintenanceCost = utilizationData.fold(0.0, (sum, data) => sum + (data["maintenanceCost"] as double));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Utilization Summary
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Total Hours",
                  "${totalHours.toStringAsFixed(0)}",
                  primaryColor,
                  Icons.access_time,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Fuel Cost",
                  "\$${(totalFuelCost / 1000).toStringAsFixed(1)}K",
                  warningColor,
                  Icons.local_gas_station,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Maintenance Cost",
                  "\$${(totalMaintenanceCost / 1000).toStringAsFixed(1)}K",
                  dangerColor,
                  Icons.build,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Avg Hours/Month",
                  "${(totalHours / utilizationData.length).toStringAsFixed(0)}",
                  infoColor,
                  Icons.trending_up,
                ),
              ),
            ],
          ),

          // Monthly Utilization Chart
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
                  "Monthly Utilization",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                // Chart placeholder
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "Utilization chart will be displayed here",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Monthly Breakdown
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
                  "Monthly Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...utilizationData.map((data) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${data["month"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${data["hours"]} hours",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fuel Cost:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(data["fuelCost"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Maintenance:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(data["maintenanceCost"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
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
    );
  }

  Widget _buildAddEquipmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Add new equipment to your inventory. Fill in all the required information to keep track of your farming assets.",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Quick Add Options
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
                  "Quick Add",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Tractor",
                        icon: Icons.agriculture,
                        onPressed: () {
                          // Navigate to tractor form
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Add Harvester",
                        icon: Icons.grass,
                        onPressed: () {
                          // Navigate to harvester form
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Planter",
                        icon: Icons.eco,
                        onPressed: () {
                          // Navigate to planter form
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Custom Equipment",
                        icon: Icons.build,
                        onPressed: () {
                          // Navigate to custom form
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Equipment Form Placeholder
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
                  "Add Equipment Form",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Equipment registration form will be implemented here with fields for equipment details, purchase information, maintenance schedules, and documentation upload.",
                    style: TextStyle(color: infoColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "maintenance":
        return warningColor;
      case "retired":
        return dangerColor;
      case "rented":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "fair":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getPriorityValue(String priority) {
    switch (priority) {
      case "high":
        return 3;
      case "medium":
        return 2;
      case "low":
        return 1;
      default:
        return 0;
    }
  }

  bool _isMaintenanceDue(String dueDateStr) {
    try {
      DateTime dueDate = DateTime.parse(dueDateStr);
      DateTime now = DateTime.now();
      return dueDate.isBefore(now);
    } catch (e) {
      return false;
    }
  }

  void _showEquipmentDetails(Map<String, dynamic> equipment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${equipment["name"]}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("Brand: ${equipment["brand"]}"),
                Text("Model: ${equipment["model"]}"),
                Text("Year: ${equipment["year"]}"),
                Text("Status: ${equipment["status"]}"),
                Text("Condition: ${equipment["condition"]}"),
                Text("Purchase Date: ${equipment["purchaseDate"]}"),
                Text("Purchase Price: \$${(equipment["purchasePrice"] as double).toStringAsFixed(0)}"),
                Text("Current Value: \$${(equipment["currentValue"] as double).toStringAsFixed(0)}"),
                if (equipment["maxHours"] > 0)
                  Text("Hours: ${equipment["hoursUsed"]}/${equipment["maxHours"]}"),
                Text("Location: ${equipment["location"]}"),
                Text("Operator: ${equipment["operator"]}"),
                Text("Insurance: ${equipment["insurance"]}"),
                Text("Warranty: ${equipment["warranty"]}"),
                if (equipment["notes"].isNotEmpty)
                  Text("Notes: ${equipment["notes"]}"),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

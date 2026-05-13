import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEquipmentManagementView extends StatefulWidget {
  const FsmEquipmentManagementView({super.key});

  @override
  State<FsmEquipmentManagementView> createState() => _FsmEquipmentManagementViewState();
}

class _FsmEquipmentManagementViewState extends State<FsmEquipmentManagementView> {
  String searchQuery = "";
  String selectedLocation = "All Locations";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  int currentTab = 0;

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Service Center A", "value": "Service Center A"},
    {"label": "Service Center B", "value": "Service Center B"},
    {"label": "Mobile Unit 1", "value": "Mobile Unit 1"},
    {"label": "Mobile Unit 2", "value": "Mobile Unit 2"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Power Tools", "value": "Power Tools"},
    {"label": "Diagnostic Equipment", "value": "Diagnostic Equipment"},
    {"label": "Safety Equipment", "value": "Safety Equipment"},
    {"label": "Vehicles", "value": "Vehicles"},
    {"label": "Testing Equipment", "value": "Testing Equipment"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Retired", "value": "Retired"},
    {"label": "Repair", "value": "Repair"},
  ];

  List<Map<String, dynamic>> equipment = [
    {
      "id": "EQ001",
      "name": "Digital Multimeter Pro",
      "category": "Diagnostic Equipment",
      "location": "Service Center A",
      "status": "Active",
      "condition": "Excellent",
      "serialNumber": "DMM-2024-001",
      "purchaseDate": DateTime(2024, 1, 15),
      "warrantyExpiry": DateTime(2025, 1, 15),
      "lastMaintenance": DateTime(2024, 11, 10),
      "nextMaintenance": DateTime(2025, 2, 10),
      "assignedTo": "John Smith",
      "value": 1250.00,
      "supplier": "TechTools Inc",
      "model": "DM-X500",
      "utilizationRate": 85,
    },
    {
      "id": "EQ002",
      "name": "Cordless Drill Kit",
      "category": "Power Tools",
      "location": "Mobile Unit 1",
      "status": "Active",
      "condition": "Good",
      "serialNumber": "CDK-2023-045",
      "purchaseDate": DateTime(2023, 8, 20),
      "warrantyExpiry": DateTime(2024, 8, 20),
      "lastMaintenance": DateTime(2024, 9, 15),
      "nextMaintenance": DateTime(2024, 12, 15),
      "assignedTo": "Mike Johnson",
      "value": 450.00,
      "supplier": "PowerTech Solutions",
      "model": "PT-CD18V",
      "utilizationRate": 92,
    },
    {
      "id": "EQ003",
      "name": "Safety Harness Set",
      "category": "Safety Equipment",
      "location": "Main Warehouse",
      "status": "Maintenance",
      "condition": "Fair",
      "serialNumber": "SHS-2022-089",
      "purchaseDate": DateTime(2022, 11, 5),
      "warrantyExpiry": DateTime(2023, 11, 5),
      "lastMaintenance": DateTime(2024, 11, 20),
      "nextMaintenance": DateTime(2025, 5, 20),
      "assignedTo": "Unassigned",
      "value": 180.00,
      "supplier": "SafeWork Pro",
      "model": "SW-HS200",
      "utilizationRate": 45,
    },
    {
      "id": "EQ004",
      "name": "Oscilloscope Advanced",
      "category": "Testing Equipment",
      "location": "Service Center B",
      "status": "Active",
      "condition": "Excellent",
      "serialNumber": "OSC-2024-012",
      "purchaseDate": DateTime(2024, 3, 10),
      "warrantyExpiry": DateTime(2027, 3, 10),
      "lastMaintenance": DateTime(2024, 10, 5),
      "nextMaintenance": DateTime(2025, 1, 5),
      "assignedTo": "Sarah Wilson",
      "value": 3200.00,
      "supplier": "ElectroTest Corp",
      "model": "ET-OSC2000",
      "utilizationRate": 78,
    },
    {
      "id": "EQ005",
      "name": "Service Van Ford Transit",
      "category": "Vehicles",
      "location": "Mobile Unit 2",
      "status": "Repair",
      "condition": "Poor",
      "serialNumber": "VAN-2021-003",
      "purchaseDate": DateTime(2021, 6, 18),
      "warrantyExpiry": DateTime(2024, 6, 18),
      "lastMaintenance": DateTime(2024, 11, 18),
      "nextMaintenance": DateTime(2024, 12, 28),
      "assignedTo": "Tom Brown",
      "value": 28500.00,
      "supplier": "Fleet Solutions Ltd",
      "model": "Transit-350",
      "utilizationRate": 68,
    },
    {
      "id": "EQ006",
      "name": "Thermal Imaging Camera",
      "category": "Diagnostic Equipment",
      "location": "Service Center A",
      "status": "Active",
      "condition": "Good",
      "serialNumber": "TIC-2023-067",
      "purchaseDate": DateTime(2023, 12, 8),
      "warrantyExpiry": DateTime(2025, 12, 8),
      "lastMaintenance": DateTime(2024, 8, 22),
      "nextMaintenance": DateTime(2024, 12, 22),
      "assignedTo": "Alex Chen",
      "value": 2100.00,
      "supplier": "ThermalTech Pro",
      "model": "TT-IC300",
      "utilizationRate": 82,
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "equipmentId": "EQ001",
      "equipmentName": "Digital Multimeter Pro",
      "type": "Preventive",
      "dueDate": DateTime(2025, 2, 10),
      "priority": "Medium",
      "estimatedHours": 2,
      "technician": "Maintenance Team A",
      "status": "Scheduled",
    },
    {
      "equipmentId": "EQ002",
      "equipmentName": "Cordless Drill Kit",
      "type": "Preventive",
      "dueDate": DateTime(2024, 12, 15),
      "priority": "Low",
      "estimatedHours": 1,
      "technician": "Maintenance Team B",
      "status": "Scheduled",
    },
    {
      "equipmentId": "EQ005",
      "equipmentName": "Service Van Ford Transit",
      "type": "Corrective",
      "dueDate": DateTime(2024, 12, 28),
      "priority": "High",
      "estimatedHours": 8,
      "technician": "Vehicle Service Team",
      "status": "In Progress",
    },
    {
      "equipmentId": "EQ006",
      "equipmentName": "Thermal Imaging Camera",
      "type": "Calibration",
      "dueDate": DateTime(2024, 12, 22),
      "priority": "High",
      "estimatedHours": 3,
      "technician": "Calibration Specialist",
      "status": "Scheduled",
    },
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((item) {
      bool matchesSearch = item["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["serialNumber"].toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesLocation = selectedLocation == "All Locations" || item["location"] == selectedLocation;
      bool matchesCategory = selectedCategory == "All Categories" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All Status" || item["status"] == selectedStatus;

      return matchesSearch && matchesLocation && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Maintenance":
        return warningColor;
      case "Repair":
        return dangerColor;
      case "Retired":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalEquipment = equipment.length;
    int activeEquipment = equipment.where((e) => e["status"] == "Active").length;
    int maintenanceEquipment = equipment.where((e) => e["status"] == "Maintenance").length;
    int repairEquipment = equipment.where((e) => e["status"] == "Repair").length;
    double totalValue = equipment.fold(0.0, (sum, item) => sum + (item["value"] as double));
    double avgUtilization = equipment.fold(0.0, (sum, item) => sum + (item["utilizationRate"] as int)) / equipment.length;

    return QTabBar(
      title: "Equipment Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Equipment", icon: Icon(Icons.build)),
        Tab(text: "Maintenance", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        // Equipment Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.inventory,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Equipment",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${totalEquipment}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$${totalValue.currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
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
                              "Active Equipment",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${activeEquipment}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${((activeEquipment / totalEquipment) * 100).toStringAsFixed(1)}% of total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "In Maintenance",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${maintenanceEquipment + repairEquipment}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "${maintenanceEquipment} scheduled, ${repairEquipment} repair",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Avg Utilization",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${avgUtilization.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Across all equipment",
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

              // Search and Filters
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
                    QTextField(
                      label: "Search Equipment",
                      hint: "Search by name, ID, or serial number",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Location",
                            items: locations,
                            value: selectedLocation,
                            onChanged: (value, label) {
                              selectedLocation = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categories,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Equipment List
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
                    Row(
                      children: [
                        Text(
                          "Equipment List",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Equipment",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: filteredEquipment.map((item) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getStatusColor("${item["status"]}"),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "${item["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "ID: ${item["id"]} | Serial: ${item["serialNumber"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${item["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${item["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor("${item["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "Category: ${item["category"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Location: ${item["location"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Assigned to: ${item["assignedTo"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs / 2,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                        decoration: BoxDecoration(
                                          color: _getConditionColor("${item["condition"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${item["condition"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getConditionColor("${item["condition"]}"),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Value: \$${(item["value"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Utilization: ${item["utilizationRate"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Next Maintenance: ${(item["nextMaintenance"] as DateTime).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    spacing: spXs,
                                    children: [
                                      QButton(
                                        icon: Icons.edit,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      QButton(
                                        icon: Icons.qr_code,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
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
              ),
            ],
          ),
        ),

        // Maintenance Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Maintenance Overview Cards
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Scheduled",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${maintenanceSchedule.where((m) => m["status"] == "Scheduled").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Upcoming tasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${maintenanceSchedule.where((m) => m["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active maintenance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${maintenanceSchedule.where((m) => (m["dueDate"] as DateTime).isBefore(DateTime.now())).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Needs attention",
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

              // Maintenance Schedule
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
                    Row(
                      children: [
                        Text(
                          "Maintenance Schedule",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Schedule",
                          icon: Icons.add_task,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: maintenanceSchedule.map((task) {
                        bool isOverdue = (task["dueDate"] as DateTime).isBefore(DateTime.now());
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: isOverdue ? dangerColor : _getPriorityColor("${task["priority"]}"),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "${task["equipmentName"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${task["type"]} Maintenance | ${task["equipmentId"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${task["priority"]} Priority",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getPriorityColor("${task["priority"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "Due: ${(task["dueDate"] as DateTime).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isOverdue ? dangerColor : disabledBoldColor,
                                            fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "Technician: ${task["technician"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Estimated: ${task["estimatedHours"]}h",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs / 2,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                        decoration: BoxDecoration(
                                          color: task["status"] == "In Progress" 
                                              ? warningColor.withAlpha(20)
                                              : infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${task["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: task["status"] == "In Progress" ? warningColor : infoColor,
                                          ),
                                        ),
                                      ),
                                      if (isOverdue)
                                        Text(
                                          "OVERDUE",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Row(
                                    spacing: spXs,
                                    children: [
                                      QButton(
                                        icon: Icons.edit,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      QButton(
                                        icon: Icons.play_arrow,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

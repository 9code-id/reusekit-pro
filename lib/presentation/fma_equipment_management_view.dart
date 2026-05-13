import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaEquipmentManagementView extends StatefulWidget {
  const FmaEquipmentManagementView({super.key});

  @override
  State<FmaEquipmentManagementView> createState() => _FmaEquipmentManagementViewState();
}

class _FmaEquipmentManagementViewState extends State<FmaEquipmentManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";

  List<Map<String, dynamic>> equipment = [
    {
      "id": "EQ001",
      "name": "Commercial Refrigerator Unit A",
      "category": "Refrigeration",
      "model": "Frigidaire PRO-48",
      "serialNumber": "FR2024001",
      "purchaseDate": "2023-01-15",
      "warrantyExpiry": "2026-01-15",
      "status": "Operational",
      "condition": "Excellent",
      "location": "Main Kitchen",
      "supplier": "Kitchen Equipment Corp",
      "cost": 4500.0,
      "energyRating": "A++",
      "lastMaintenance": "2024-05-20",
      "nextMaintenance": "2024-07-20",
      "maintenanceInterval": 60,
      "repairHistory": [
        {"date": "2024-03-10", "issue": "Thermostat calibration", "cost": 150.0},
        {"date": "2023-11-15", "issue": "Compressor service", "cost": 320.0},
      ],
    },
    {
      "id": "EQ002",
      "name": "Industrial Dishwasher",
      "category": "Cleaning",
      "model": "Hobart CXi-2",
      "serialNumber": "HB2024002",
      "purchaseDate": "2023-03-20",
      "warrantyExpiry": "2028-03-20",
      "status": "Operational",
      "condition": "Good",
      "location": "Dishwashing Area",
      "supplier": "Restaurant Supply Co",
      "cost": 8900.0,
      "energyRating": "B+",
      "lastMaintenance": "2024-06-01",
      "nextMaintenance": "2024-08-01",
      "maintenanceInterval": 30,
      "repairHistory": [
        {"date": "2024-04-25", "issue": "Water filter replacement", "cost": 85.0},
        {"date": "2024-01-18", "issue": "Heating element repair", "cost": 275.0},
      ],
    },
    {
      "id": "EQ003",
      "name": "Gas Range Oven",
      "category": "Cooking",
      "model": "Vulcan V4B36B",
      "serialNumber": "VL2024003",
      "purchaseDate": "2022-08-10",
      "warrantyExpiry": "2025-08-10",
      "status": "Needs Maintenance",
      "condition": "Fair",
      "location": "Cooking Line",
      "supplier": "Commercial Kitchen Pro",
      "cost": 3200.0,
      "energyRating": "B",
      "lastMaintenance": "2024-04-15",
      "nextMaintenance": "2024-06-15",
      "maintenanceInterval": 45,
      "repairHistory": [
        {"date": "2024-04-15", "issue": "Gas line inspection", "cost": 180.0},
        {"date": "2024-02-20", "issue": "Igniter replacement", "cost": 220.0},
        {"date": "2023-12-05", "issue": "Thermostat repair", "cost": 165.0},
      ],
    },
    {
      "id": "EQ004",
      "name": "Walk-in Freezer Unit",
      "category": "Refrigeration",
      "model": "Kolpak KF7-1020",
      "serialNumber": "KP2024004",
      "purchaseDate": "2023-05-12",
      "warrantyExpiry": "2028-05-12",
      "status": "Out of Service",
      "condition": "Poor",
      "location": "Storage Area",
      "supplier": "Cold Storage Solutions",
      "cost": 12500.0,
      "energyRating": "A+",
      "lastMaintenance": "2024-05-30",
      "nextMaintenance": "2024-06-30",
      "maintenanceInterval": 90,
      "repairHistory": [
        {"date": "2024-05-30", "issue": "Compressor failure", "cost": 850.0},
        {"date": "2024-03-12", "issue": "Door seal replacement", "cost": 125.0},
      ],
    },
    {
      "id": "EQ005",
      "name": "Ventilation Hood System",
      "category": "Ventilation",
      "model": "CaptiveAire SND-PSP-14",
      "serialNumber": "CA2024005",
      "purchaseDate": "2023-02-28",
      "warrantyExpiry": "2026-02-28",
      "status": "Operational",
      "condition": "Excellent",
      "location": "Above Cooking Line",
      "supplier": "Air Systems Inc",
      "cost": 6750.0,
      "energyRating": "A",
      "lastMaintenance": "2024-06-10",
      "nextMaintenance": "2024-09-10",
      "maintenanceInterval": 90,
      "repairHistory": [
        {"date": "2024-01-22", "issue": "Filter cleaning service", "cost": 95.0},
      ],
    },
  ];

  List<Map<String, dynamic>> maintenanceAlerts = [
    {
      "equipmentId": "EQ003",
      "equipmentName": "Gas Range Oven",
      "alertType": "Overdue Maintenance",
      "priority": "High",
      "daysOverdue": 5,
      "description": "Regular maintenance is 5 days overdue",
    },
    {
      "equipmentId": "EQ004",
      "equipmentName": "Walk-in Freezer Unit",
      "alertType": "Equipment Failure",
      "priority": "Critical",
      "daysOverdue": 0,
      "description": "Compressor failure requires immediate attention",
    },
    {
      "equipmentId": "EQ002",
      "equipmentName": "Industrial Dishwasher",
      "alertType": "Upcoming Maintenance",
      "priority": "Medium",
      "daysOverdue": -7,
      "description": "Maintenance due in 7 days",
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": ""},
    {"label": "Refrigeration", "value": "Refrigeration"},
    {"label": "Cooking", "value": "Cooking"},
    {"label": "Cleaning", "value": "Cleaning"},
    {"label": "Ventilation", "value": "Ventilation"},
    {"label": "Storage", "value": "Storage"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Operational", "value": "Operational"},
    {"label": "Needs Maintenance", "value": "Needs Maintenance"},
    {"label": "Out of Service", "value": "Out of Service"},
    {"label": "Under Repair", "value": "Under Repair"},
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((eq) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${eq["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${eq["model"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${eq["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || eq["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || eq["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Operational":
        return successColor;
      case "Needs Maintenance":
        return warningColor;
      case "Out of Service":
        return dangerColor;
      case "Under Repair":
        return infoColor;
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

  Color _getAlertColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    int totalEquipment = equipment.length;
    int operationalCount = equipment.where((e) => e["status"] == "Operational").length;
    int maintenanceCount = equipment.where((e) => e["status"] == "Needs Maintenance").length;
    int outOfServiceCount = equipment.where((e) => e["status"] == "Out of Service").length;

    return SingleChildScrollView(
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
                        Icon(Icons.precision_manufacturing, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Total Equipment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalEquipment",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Units",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Operational",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$operationalCount",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Running",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Maintenance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$maintenanceCount",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Needs Service",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Out of Service",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$outOfServiceCount",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Down",
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

          // Maintenance Alerts
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
                    Icon(Icons.notifications, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Maintenance Alerts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...maintenanceAlerts.map((alert) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getAlertColor("${alert["priority"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: _getAlertColor("${alert["priority"]}").withAlpha(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getAlertColor("${alert["priority"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          alert["alertType"] == "Equipment Failure" 
                              ? Icons.error 
                              : Icons.schedule,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${alert["equipmentName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${alert["alertType"]} - ${alert["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getAlertColor("${alert["priority"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["priority"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          // Recent Equipment Activity
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
                    Icon(Icons.history, color: infoColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...equipment.take(3).map((eq) {
                  var lastRepair = (eq["repairHistory"] as List).isNotEmpty 
                      ? (eq["repairHistory"] as List).first 
                      : null;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.build,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${eq["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (lastRepair != null)
                                Text(
                                  "${lastRepair["date"]} - ${lastRepair["issue"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (lastRepair != null)
                          Text(
                            "\$${(lastRepair["cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search equipment...",
                  value: searchQuery,
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
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
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
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Equipment List
          ...filteredEquipment.map((eq) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor("${eq["status"]}"),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getStatusColor("${eq["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.precision_manufacturing,
                        color: _getStatusColor("${eq["status"]}"),
                        size: 30,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${eq["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${eq["model"]} - ${eq["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Location: ${eq["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${eq["status"]}"),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${eq["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getConditionColor("${eq["condition"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getConditionColor("${eq["condition"]}"),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${eq["condition"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getConditionColor("${eq["condition"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                            "Serial Number",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${eq["serialNumber"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
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
                            "Purchase Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "\$${(eq["cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                            "Purchase Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${eq["purchaseDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
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
                            "Warranty Expiry",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${eq["warrantyExpiry"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                            "Last Maintenance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${eq["lastMaintenance"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
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
                            "Next Maintenance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${eq["nextMaintenance"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Maintenance",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.history,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Equipment Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Equipment", icon: Icon(Icons.precision_manufacturing)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEquipmentTab(),
      ],
    );
  }
}

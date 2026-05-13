import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsKitchenOperationsView extends StatefulWidget {
  const RfsKitchenOperationsView({super.key});

  @override
  State<RfsKitchenOperationsView> createState() => _RfsKitchenOperationsViewState();
}

class _RfsKitchenOperationsViewState extends State<RfsKitchenOperationsView> {
  int selectedTab = 0;
  String selectedStation = "All";
  String selectedShift = "Current";
  
  List<Map<String, dynamic>> stationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Grill", "value": "Grill"},
    {"label": "Fryer", "value": "Fryer"},
    {"label": "Cold Prep", "value": "Cold Prep"},
    {"label": "Hot Prep", "value": "Hot Prep"},
    {"label": "Oven", "value": "Oven"},
    {"label": "Expedite", "value": "Expedite"},
  ];

  List<Map<String, dynamic>> shiftOptions = [
    {"label": "Current", "value": "Current"},
    {"label": "Morning", "value": "Morning"},
    {"label": "Afternoon", "value": "Afternoon"},
    {"label": "Evening", "value": "Evening"},
  ];

  Map<String, List<Map<String, dynamic>>> operationsData = {
    "stations": [
      {
        "name": "Grill Station",
        "status": "Active",
        "currentOrders": 4,
        "staffAssigned": ["Chef Martinez", "Line Cook Johnson"],
        "equipment": [
          {"name": "Main Grill", "status": "Operational", "temperature": "425°F"},
          {"name": "Side Grill", "status": "Operational", "temperature": "380°F"},
          {"name": "Salamander", "status": "Operational", "temperature": "500°F"},
        ],
        "activeItems": [
          {"item": "Ribeye Steak", "quantity": 2, "timeRemaining": "8 min"},
          {"item": "Chicken Breast", "quantity": 1, "timeRemaining": "12 min"},
          {"item": "Salmon Fillet", "quantity": 3, "timeRemaining": "6 min"},
        ],
        "efficiency": 92,
        "averageTime": 18,
        "completedToday": 45,
      },
      {
        "name": "Fryer Station",
        "status": "Active",
        "currentOrders": 2,
        "staffAssigned": ["Cook Williams"],
        "equipment": [
          {"name": "Deep Fryer 1", "status": "Operational", "temperature": "350°F"},
          {"name": "Deep Fryer 2", "status": "Maintenance", "temperature": "N/A"},
        ],
        "activeItems": [
          {"item": "Fish and Chips", "quantity": 2, "timeRemaining": "4 min"},
          {"item": "Chicken Wings", "quantity": 1, "timeRemaining": "7 min"},
        ],
        "efficiency": 87,
        "averageTime": 12,
        "completedToday": 28,
      },
      {
        "name": "Cold Prep Station",
        "status": "Active",
        "currentOrders": 6,
        "staffAssigned": ["Prep Cook Davis", "Line Cook Brown"],
        "equipment": [
          {"name": "Prep Cooler", "status": "Operational", "temperature": "38°F"},
          {"name": "Salad Station", "status": "Operational", "temperature": "40°F"},
        ],
        "activeItems": [
          {"item": "Caesar Salad", "quantity": 3, "timeRemaining": "2 min"},
          {"item": "Appetizer Plate", "quantity": 2, "timeRemaining": "5 min"},
          {"item": "Fresh Rolls", "quantity": 4, "timeRemaining": "1 min"},
        ],
        "efficiency": 95,
        "averageTime": 6,
        "completedToday": 67,
      },
      {
        "name": "Hot Prep Station",
        "status": "Active",
        "currentOrders": 3,
        "staffAssigned": ["Sous Chef Thompson"],
        "equipment": [
          {"name": "Steam Table", "status": "Operational", "temperature": "165°F"},
          {"name": "Sauté Station", "status": "Operational", "temperature": "Hot"},
          {"name": "Soup Warmer", "status": "Operational", "temperature": "140°F"},
        ],
        "activeItems": [
          {"item": "Mashed Potatoes", "quantity": 2, "timeRemaining": "3 min"},
          {"item": "Vegetable Medley", "quantity": 1, "timeRemaining": "4 min"},
          {"item": "Soup of Day", "quantity": 2, "timeRemaining": "Ready"},
        ],
        "efficiency": 89,
        "averageTime": 10,
        "completedToday": 34,
      },
    ],
    "staff": [
      {
        "name": "Chef Martinez",
        "role": "Head Chef",
        "station": "Grill",
        "shift": "Afternoon",
        "status": "On Duty",
        "hoursWorked": 6.5,
        "ordersCompleted": 23,
        "efficiency": 94,
        "specialties": ["Steaks", "Grilled Items", "Quality Control"],
        "certifications": ["Food Safety", "Grill Master"],
      },
      {
        "name": "Sous Chef Thompson",
        "role": "Sous Chef",
        "station": "Hot Prep",
        "shift": "Afternoon",
        "status": "On Duty",
        "hoursWorked": 7.0,
        "ordersCompleted": 18,
        "efficiency": 91,
        "specialties": ["Sauces", "Sides", "Supervision"],
        "certifications": ["Food Safety", "Management"],
      },
      {
        "name": "Line Cook Johnson",
        "role": "Line Cook",
        "station": "Grill",
        "shift": "Afternoon",
        "status": "On Break",
        "hoursWorked": 5.5,
        "ordersCompleted": 15,
        "efficiency": 88,
        "specialties": ["Grill", "Prep Work"],
        "certifications": ["Food Safety"],
      },
      {
        "name": "Cook Williams",
        "role": "Cook",
        "station": "Fryer",
        "shift": "Afternoon",
        "status": "On Duty",
        "hoursWorked": 6.0,
        "ordersCompleted": 20,
        "efficiency": 85,
        "specialties": ["Fried Items", "Prep"],
        "certifications": ["Food Safety"],
      },
      {
        "name": "Prep Cook Davis",
        "role": "Prep Cook",
        "station": "Cold Prep",
        "shift": "Morning",
        "status": "Off Duty",
        "hoursWorked": 8.0,
        "ordersCompleted": 35,
        "efficiency": 96,
        "specialties": ["Salads", "Cold Apps", "Prep"],
        "certifications": ["Food Safety", "Allergen Training"],
      },
    ],
    "metrics": [
      {
        "metric": "Orders per Hour",
        "current": 15,
        "target": 18,
        "trend": "up",
        "percentage": 83,
      },
      {
        "metric": "Average Cook Time",
        "current": 12,
        "target": 10,
        "trend": "down",
        "percentage": 75,
      },
      {
        "metric": "Kitchen Efficiency",
        "current": 91,
        "target": 95,
        "trend": "up",
        "percentage": 91,
      },
      {
        "metric": "Food Cost %",
        "current": 28,
        "target": 25,
        "trend": "down",
        "percentage": 72,
      },
      {
        "metric": "Staff Utilization",
        "current": 87,
        "target": 90,
        "trend": "up",
        "percentage": 87,
      },
      {
        "metric": "Waste Percentage",
        "current": 4.5,
        "target": 3.0,
        "trend": "down",
        "percentage": 60,
      },
    ],
    "inventory": [
      {
        "item": "Ribeye Steaks",
        "current": 12,
        "minimum": 8,
        "status": "Good",
        "unit": "pieces",
        "lastRestocked": "2024-06-19 08:00:00",
        "supplier": "Premium Meats Co.",
      },
      {
        "item": "Fresh Salmon",
        "current": 6,
        "minimum": 10,
        "status": "Low",
        "unit": "portions",
        "lastRestocked": "2024-06-18 14:00:00",
        "supplier": "Ocean Fresh",
      },
      {
        "item": "Chicken Breast",
        "current": 25,
        "minimum": 15,
        "status": "Good",
        "unit": "pieces",
        "lastRestocked": "2024-06-19 09:30:00",
        "supplier": "Farm Fresh Poultry",
      },
      {
        "item": "Mixed Vegetables",
        "current": 8,
        "minimum": 12,
        "status": "Low",
        "unit": "kg",
        "lastRestocked": "2024-06-19 07:00:00",
        "supplier": "Garden Fresh Produce",
      },
      {
        "item": "Flour",
        "current": 45,
        "minimum": 20,
        "status": "Good",
        "unit": "kg",
        "lastRestocked": "2024-06-18 10:00:00",
        "supplier": "Baker's Supply",
      },
    ],
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case "Operational":
      case "Active": 
      case "On Duty":
      case "Good": return successColor;
      case "Maintenance":
      case "Low": return warningColor;
      case "Offline":
      case "Critical": return dangerColor;
      case "On Break":
      case "Off Duty": return disabledBoldColor;
      default: return disabledColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up": return successColor;
      case "down": return dangerColor;
      case "stable": return warningColor;
      default: return disabledColor;
    }
  }

  Widget _buildStationsTab() {
    List<Map<String, dynamic>> stations = operationsData["stations"]!;
    if (selectedStation != "All") {
      stations = stations.where((s) => s["name"].toString().contains(selectedStation)).toList();
    }
    
    return Column(
      spacing: spSm,
      children: stations.map((station) => Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border(
            left: BorderSide(
              width: 4,
              color: _getStatusColor("${station["status"]}"),
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
                  child: Text(
                    "${station["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${station["status"]}"),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${station["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Performance Metrics
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${station["currentOrders"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Active Orders",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${station["efficiency"]}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Efficiency",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${station["averageTime"]}m",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Time",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${station["completedToday"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Staff Assigned
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
                    "Staff Assigned:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  ...((station["staffAssigned"] as List).map((staff) => Text(
                    "• $staff",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ))),
                ],
              ),
            ),

            // Equipment Status
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Equipment Status:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  ...((station["equipment"] as List).map((equip) => Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _getStatusColor("${equip["status"]}"),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${equip["name"]} - ${equip["temperature"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ))),
                ],
              ),
            ),

            // Active Items
            if ((station["activeItems"] as List).isNotEmpty)
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Items:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                    ...((station["activeItems"] as List).map((item) => Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["quantity"]}x ${item["item"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ),
                        Text(
                          "${item["timeRemaining"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ))),
                  ],
                ),
              ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildStaffTab() {
    List<Map<String, dynamic>> staff = operationsData["staff"]!;
    if (selectedShift != "Current") {
      staff = staff.where((s) => s["shift"] == selectedShift).toList();
    }
    
    return Column(
      spacing: spSm,
      children: staff.map((member) => Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border(
            left: BorderSide(
              width: 4,
              color: _getStatusColor("${member["status"]}"),
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
                  child: Text(
                    "${member["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${member["status"]}"),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${member["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Text(
              "${member["role"]} - ${member["station"]} Station",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),

            // Performance Stats
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${member["hoursWorked"]}h",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Hours",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${member["ordersCompleted"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${member["efficiency"]}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Efficiency",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Specialties
            if ((member["specialties"] as List).isNotEmpty)
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Specialties:",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    Text(
                      (member["specialties"] as List).join(", "),
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Certifications
            if ((member["certifications"] as List).isNotEmpty)
              Wrap(
                spacing: spXs,
                children: (member["certifications"] as List).map((cert) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: infoColor, width: 1),
                  ),
                  child: Text(
                    "$cert",
                    style: TextStyle(
                      fontSize: 9,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildMetricsTab() {
    List<Map<String, dynamic>> metrics = operationsData["metrics"]!;
    
    return Column(
      spacing: spSm,
      children: [
        // Key Performance Indicators
        ResponsiveGridView(
          minItemWidth: 150,
          children: metrics.map((metric) => Container(
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
                    Expanded(
                      child: Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Icon(
                      metric["trend"] == "up" ? Icons.trending_up : 
                      metric["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                      size: 16,
                      color: _getTrendColor("${metric["trend"]}"),
                    ),
                  ],
                ),
                
                Text(
                  "${metric["current"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  "Target: ${metric["target"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                
                // Progress Bar
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (metric["percentage"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: (metric["percentage"] as int) >= 80 ? successColor : 
                               (metric["percentage"] as int) >= 60 ? warningColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInventoryTab() {
    List<Map<String, dynamic>> inventory = operationsData["inventory"]!;
    
    return Column(
      spacing: spSm,
      children: inventory.map((item) => Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
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
                  child: Text(
                    "${item["item"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${item["status"]}"),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${item["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
                    children: [
                      Text(
                        "Current: ${item["current"]} ${item["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Minimum: ${item["minimum"]} ${item["unit"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${((item["current"] as int) / (item["minimum"] as int) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${item["status"]}"),
                      ),
                    ),
                    Text(
                      "of minimum",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Supplier: ${item["supplier"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Last Restocked: ${DateTime.parse("${item["lastRestocked"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Kitchen Operations",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Stations", icon: Icon(Icons.kitchen)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
        Tab(text: "Metrics", icon: Icon(Icons.analytics)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        // Stations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              QDropdownField(
                label: "Filter by Station",
                items: stationOptions,
                value: selectedStation,
                onChanged: (value, label) {
                  selectedStation = value;
                  setState(() {});
                },
              ),
              _buildStationsTab(),
            ],
          ),
        ),

        // Staff Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              QDropdownField(
                label: "Filter by Shift",
                items: shiftOptions,
                value: selectedShift,
                onChanged: (value, label) {
                  selectedShift = value;
                  setState(() {});
                },
              ),
              _buildStaffTab(),
            ],
          ),
        ),

        // Metrics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildMetricsTab(),
        ),

        // Inventory Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildInventoryTab(),
        ),
      ],
    );
  }
}

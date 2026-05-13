import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderQueueView extends StatefulWidget {
  const RfsOrderQueueView({super.key});

  @override
  State<RfsOrderQueueView> createState() => _RfsOrderQueueViewState();
}

class _RfsOrderQueueViewState extends State<RfsOrderQueueView> {
  String selectedStation = "All";
  String selectedPriority = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> stationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Grill", "value": "Grill"},
    {"label": "Fryer", "value": "Fryer"},
    {"label": "Cold Prep", "value": "Cold Prep"},
    {"label": "Hot Prep", "value": "Hot Prep"},
    {"label": "Oven", "value": "Oven"},
    {"label": "Expedite", "value": "Expedite"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "High", "value": "High"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Waiting", "value": "Waiting"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Ready", "value": "Ready"},
    {"label": "On Hold", "value": "On Hold"},
  ];

  List<Map<String, dynamic>> queueItems = [
    {
      "id": "QUEUE001",
      "orderId": "ORDER-2024-001",
      "tableNumber": 15,
      "customerName": "Sarah Johnson",
      "itemName": "Grilled Chicken Breast",
      "station": "Grill",
      "priority": "High",
      "status": "Waiting",
      "orderTime": "2024-06-19 14:30:00",
      "estimatedCookTime": 15,
      "queuePosition": 2,
      "specialInstructions": "No seasoning, customer allergic to pepper",
      "dependencies": [],
      "assignedCook": "",
      "startTime": "",
      "estimatedCompletion": "",
      "ingredients": ["Chicken breast", "Olive oil", "Salt"],
      "allergens": ["None"],
      "temperature": "165°F internal",
    },
    {
      "id": "QUEUE002",
      "orderId": "ORDER-2024-002",
      "tableNumber": 8,
      "customerName": "Mike Chen",
      "itemName": "Fish and Chips",
      "station": "Fryer",
      "priority": "Normal",
      "status": "In Progress",
      "orderTime": "2024-06-19 14:25:00",
      "estimatedCookTime": 12,
      "queuePosition": 1,
      "specialInstructions": "Extra crispy, malt vinegar on side",
      "dependencies": [],
      "assignedCook": "Cook Johnson",
      "startTime": "2024-06-19 14:40:00",
      "estimatedCompletion": "2024-06-19 14:52:00",
      "ingredients": ["Fresh cod", "Potato", "Flour", "Oil"],
      "allergens": ["Gluten", "Fish"],
      "temperature": "350°F oil temperature",
    },
    {
      "id": "QUEUE003",
      "orderId": "ORDER-2024-003",
      "tableNumber": 22,
      "customerName": "Emma Wilson",
      "itemName": "Caesar Salad",
      "station": "Cold Prep",
      "priority": "Normal",
      "status": "Ready",
      "orderTime": "2024-06-19 14:20:00",
      "estimatedCookTime": 5,
      "queuePosition": 0,
      "specialInstructions": "Dressing on side, extra croutons",
      "dependencies": [],
      "assignedCook": "Prep Cook Davis",
      "startTime": "2024-06-19 14:35:00",
      "estimatedCompletion": "2024-06-19 14:40:00",
      "ingredients": ["Romaine lettuce", "Caesar dressing", "Croutons", "Parmesan"],
      "allergens": ["Dairy", "Gluten"],
      "temperature": "Cold service",
    },
    {
      "id": "QUEUE004",
      "orderId": "ORDER-2024-004",
      "tableNumber": 5,
      "customerName": "David Brown",
      "itemName": "Ribeye Steak",
      "station": "Grill",
      "priority": "Urgent",
      "status": "Waiting",
      "orderTime": "2024-06-19 14:35:00",
      "estimatedCookTime": 18,
      "queuePosition": 1,
      "specialInstructions": "Medium rare, compound butter on top",
      "dependencies": ["Mashed potatoes", "Grilled asparagus"],
      "assignedCook": "",
      "startTime": "",
      "estimatedCompletion": "",
      "ingredients": ["Ribeye steak", "Compound butter", "Salt", "Pepper"],
      "allergens": ["Dairy"],
      "temperature": "130-135°F internal",
    },
    {
      "id": "QUEUE005",
      "orderId": "ORDER-2024-005",
      "tableNumber": 12,
      "customerName": "Lisa Garcia",
      "itemName": "Vegetable Stir Fry",
      "station": "Hot Prep",
      "priority": "Normal",
      "status": "On Hold",
      "orderTime": "2024-06-19 14:28:00",
      "estimatedCookTime": 10,
      "queuePosition": 3,
      "specialInstructions": "Vegan preparation, no fish sauce",
      "dependencies": [],
      "assignedCook": "Line Cook Williams",
      "startTime": "",
      "estimatedCompletion": "",
      "ingredients": ["Mixed vegetables", "Soy sauce", "Garlic", "Ginger"],
      "allergens": ["Soy"],
      "temperature": "High heat wok",
    },
    {
      "id": "QUEUE006",
      "orderId": "ORDER-2024-001",
      "tableNumber": 15,
      "customerName": "Sarah Johnson",
      "itemName": "Chocolate Lava Cake",
      "station": "Oven",
      "priority": "Low",
      "status": "Waiting",
      "orderTime": "2024-06-19 14:30:00",
      "estimatedCookTime": 25,
      "queuePosition": 4,
      "specialInstructions": "Serve with vanilla ice cream",
      "dependencies": ["Main course completion"],
      "assignedCook": "",
      "startTime": "",
      "estimatedCompletion": "",
      "ingredients": ["Dark chocolate", "Butter", "Eggs", "Sugar", "Flour"],
      "allergens": ["Dairy", "Eggs", "Gluten"],
      "temperature": "375°F oven",
    },
  ];

  List<Map<String, dynamic>> get filteredQueue {
    return queueItems.where((item) {
      bool matchesStation = selectedStation == "All" || item["station"] == selectedStation;
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      
      return matchesStation && matchesPriority && matchesStatus;
    }).toList()..sort((a, b) {
      // Sort by priority first, then by queue position
      int priorityOrder(String priority) {
        switch (priority) {
          case "Urgent": return 0;
          case "High": return 1;
          case "Normal": return 2;
          case "Low": return 3;
          default: return 4;
        }
      }
      
      int priorityCompare = priorityOrder("${a["priority"]}").compareTo(priorityOrder("${b["priority"]}"));
      if (priorityCompare != 0) return priorityCompare;
      
      return (a["queuePosition"] as int).compareTo(b["queuePosition"] as int);
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Waiting": return warningColor;
      case "In Progress": return infoColor;
      case "Ready": return successColor;
      case "On Hold": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent": return dangerColor;
      case "High": return dangerColor;
      case "Normal": return primaryColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Icon _getStationIcon(String station) {
    switch (station) {
      case "Grill": return Icon(Icons.outdoor_grill, color: dangerColor);
      case "Fryer": return Icon(Icons.water_drop, color: warningColor);
      case "Cold Prep": return Icon(Icons.ac_unit, color: infoColor);
      case "Hot Prep": return Icon(Icons.local_fire_department, color: dangerColor);
      case "Oven": return Icon(Icons.kitchen, color: warningColor);
      case "Expedite": return Icon(Icons.dining, color: successColor);
      default: return Icon(Icons.restaurant, color: primaryColor);
    }
  }

  String _getEstimatedWaitTime(int queuePosition, int cookTime) {
    int estimatedWait = (queuePosition * 5) + cookTime; // 5 min average per position + cook time
    return "${estimatedWait} min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Queue"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              // Refresh queue
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Station",
                    items: stationOptions,
                    value: selectedStation,
                    onChanged: (value, label) {
                      selectedStation = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
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

            // Queue Statistics
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
                    "Queue Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${filteredQueue.where((q) => q["status"] == "Waiting").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Waiting",
                              style: TextStyle(
                                fontSize: 12,
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
                              "${filteredQueue.where((q) => q["status"] == "In Progress").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Cooking",
                              style: TextStyle(
                                fontSize: 12,
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
                              "${filteredQueue.where((q) => q["status"] == "Ready").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Ready",
                              style: TextStyle(
                                fontSize: 12,
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
                              "${filteredQueue.where((q) => q["priority"] == "Urgent" || q["priority"] == "High").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Priority",
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
                ],
              ),
            ),

            // Queue Items
            ...filteredQueue.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor("${item["priority"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${item["priority"]}"),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        _getStationIcon("${item["station"]}"),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["itemName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${item["orderId"]} - Table ${item["tableNumber"]}",
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
                            color: _getPriorityColor("${item["priority"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
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

                    Text(
                      "Customer: ${item["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),

                    // Special Instructions
                    if ("${item["specialInstructions"]}".isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${item["specialInstructions"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Dependencies
                    if ((item["dependencies"] as List).isNotEmpty)
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
                              "Dependencies:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            ...((item["dependencies"] as List).map((dep) => Text(
                              "• $dep",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                              ),
                            ))),
                          ],
                        ),
                      ),

                    // Timing Information
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Cook time: ${item["estimatedCookTime"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.hourglass_top,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Est. wait: ${_getEstimatedWaitTime(item["queuePosition"] as int, item["estimatedCookTime"] as int)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Assignment Info
                    if ("${item["assignedCook"]}".isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Assigned to: ${item["assignedCook"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                    // Allergen Warning
                    if ((item["allergens"] as List).where((a) => a != "None").isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Allergens: ${(item["allergens"] as List).where((a) => a != "None").join(", ")}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Action Buttons
                    Row(
                      spacing: spXs,
                      children: [
                        if (item["status"] == "Waiting")
                          Expanded(
                            child: QButton(
                              label: "Start Cooking",
                              size: bs.sm,
                              onPressed: () {
                                // Start cooking item
                              },
                            ),
                          ),
                        if (item["status"] == "In Progress")
                          Expanded(
                            child: QButton(
                              label: "Mark Ready",
                              size: bs.sm,
                              onPressed: () {
                                // Mark item as ready
                              },
                            ),
                          ),
                        if (item["status"] == "Ready")
                          Expanded(
                            child: QButton(
                              label: "Served",
                              size: bs.sm,
                              onPressed: () {
                                // Mark as served
                              },
                            ),
                          ),
                        QButton(
                          icon: Icons.arrow_upward,
                          size: bs.sm,
                          onPressed: () {
                            // Move up in queue
                          },
                        ),
                        QButton(
                          icon: Icons.person_add,
                          size: bs.sm,
                          onPressed: () {
                            // Assign cook
                          },
                        ),
                        QButton(
                          icon: Icons.pause,
                          size: bs.sm,
                          onPressed: () {
                            // Put on hold
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredQueue.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.queue,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No items in queue",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Order queue items will appear here",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaOrderQueueView extends StatefulWidget {
  const FmaOrderQueueView({super.key});

  @override
  State<FmaOrderQueueView> createState() => _FmaOrderQueueViewState();
}

class _FmaOrderQueueViewState extends State<FmaOrderQueueView> {
  String selectedFilter = "All";
  String selectedStation = "All";
  
  List<Map<String, dynamic>> queueOrders = [
    {
      "id": "ORD001",
      "customerName": "John Smith",
      "items": [
        {"name": "Beef Burger Deluxe", "quantity": 2, "cookTime": 8},
        {"name": "French Fries", "quantity": 1, "cookTime": 5},
      ],
      "totalItems": 3,
      "status": "In Preparation",
      "priority": "Normal",
      "orderTime": "2024-12-19 12:30",
      "estimatedCompletion": "2024-12-19 12:45",
      "assignedStaff": "Chef Mike",
      "station": "Grill",
      "orderType": "Delivery",
      "preparationTime": 15,
      "elapsedTime": 8,
      "specialInstructions": "Extra cheese, no onions",
    },
    {
      "id": "ORD002",
      "customerName": "Sarah Johnson",
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "cookTime": 12},
        {"name": "Caesar Salad", "quantity": 1, "cookTime": 3},
      ],
      "totalItems": 2,
      "status": "Ready for Pickup",
      "priority": "High",
      "orderTime": "2024-12-19 12:00",
      "estimatedCompletion": "2024-12-19 12:15",
      "assignedStaff": "Chef Anna",
      "station": "Pizza",
      "orderType": "Pickup",
      "preparationTime": 15,
      "elapsedTime": 15,
      "specialInstructions": "",
    },
    {
      "id": "ORD003",
      "customerName": "Mike Wilson",
      "items": [
        {"name": "Grilled Chicken Salad", "quantity": 1, "cookTime": 6},
        {"name": "Fresh Orange Juice", "quantity": 2, "cookTime": 2},
      ],
      "totalItems": 3,
      "status": "Pending",
      "priority": "Urgent",
      "orderTime": "2024-12-19 12:45",
      "estimatedCompletion": "2024-12-19 13:00", 
      "assignedStaff": "",
      "station": "Cold Station",
      "orderType": "Dine In",
      "preparationTime": 8,
      "elapsedTime": 0,
      "specialInstructions": "Dressing on the side",
    },
    {
      "id": "ORD004",
      "customerName": "Emily Davis",
      "items": [
        {"name": "Beef Steak", "quantity": 1, "cookTime": 15},
        {"name": "Mashed Potatoes", "quantity": 1, "cookTime": 8},
      ],
      "totalItems": 2,
      "status": "In Preparation",
      "priority": "Normal",
      "orderTime": "2024-12-19 12:20",
      "estimatedCompletion": "2024-12-19 12:40",
      "assignedStaff": "Chef Bob",
      "station": "Grill",
      "orderType": "Dine In",
      "preparationTime": 20,
      "elapsedTime": 12,
      "specialInstructions": "Medium rare steak",
    },
    {
      "id": "ORD005",
      "customerName": "David Brown",
      "items": [
        {"name": "Fish Tacos", "quantity": 3, "cookTime": 10},
        {"name": "Guacamole", "quantity": 1, "cookTime": 5},
      ],
      "totalItems": 4,
      "status": "Out for Delivery",
      "priority": "Normal",
      "orderTime": "2024-12-19 11:45",
      "estimatedCompletion": "2024-12-19 12:00",
      "assignedStaff": "Driver Tom",
      "station": "Hot Station",
      "orderType": "Delivery",
      "preparationTime": 15,
      "elapsedTime": 15,
      "specialInstructions": "Extra spicy",
    },
  ];

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Orders", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Preparation", "value": "In Preparation"},
    {"label": "Ready for Pickup", "value": "Ready for Pickup"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
  ];

  List<Map<String, dynamic>> stationItems = [
    {"label": "All Stations", "value": "All"},
    {"label": "Grill", "value": "Grill"},
    {"label": "Pizza", "value": "Pizza"},
    {"label": "Cold Station", "value": "Cold Station"},
    {"label": "Hot Station", "value": "Hot Station"},
    {"label": "Beverage", "value": "Beverage"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    var filtered = queueOrders.where((order) {
      bool matchesFilter = selectedFilter == "All" || order["status"] == selectedFilter;
      bool matchesStation = selectedStation == "All" || order["station"] == selectedStation;
      return matchesFilter && matchesStation;
    }).toList();

    // Sort by priority and time
    filtered.sort((a, b) {
      // First sort by priority
      int priorityA = _getPriorityValue(a["priority"]);
      int priorityB = _getPriorityValue(b["priority"]);
      if (priorityA != priorityB) {
        return priorityB.compareTo(priorityA); // Higher priority first
      }
      
      // Then by order time
      return DateTime.parse(a["orderTime"]).compareTo(DateTime.parse(b["orderTime"]));
    });

    return filtered;
  }

  int _getPriorityValue(String priority) {
    switch (priority) {
      case "Urgent": return 3;
      case "High": return 2;
      case "Normal": return 1;
      default: return 0;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "In Preparation": return infoColor;
      case "Ready for Pickup": return primaryColor;
      case "Out for Delivery": return successColor;
      case "Completed": return successColor;
      default: return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent": return dangerColor;
      case "High": return warningColor;
      case "Normal": return successColor;
      default: return disabledBoldColor;
    }
  }

  String getOrderTypeIcon(String orderType) {
    switch (orderType) {
      case "Delivery": return "🚚";
      case "Pickup": return "🏃";
      case "Dine In": return "🍽️";
      default: return "📦";
    }
  }

  double getProgressPercentage(Map<String, dynamic> order) {
    int elapsedTime = order["elapsedTime"];
    int totalTime = order["preparationTime"];
    if (totalTime == 0) return 0;
    return (elapsedTime / totalTime).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitchen Queue"),
        actions: [
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () {
              // navigateTo(FmaKitchenTimerView());
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status Filter",
                      items: filterItems,
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Station",
                      items: stationItems,
                      value: selectedStation,
                      onChanged: (value, label) {
                        selectedStation = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
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
                    "Queue Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${queueOrders.where((o) => o["status"] == "Pending").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
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
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${queueOrders.where((o) => o["status"] == "In Preparation").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Cooking",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${queueOrders.where((o) => o["status"] == "Ready for Pickup").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Ready",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${queueOrders.where((o) => o["priority"] == "Urgent").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Urgent",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Queue
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
                      Icon(Icons.queue, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Kitchen Queue (${filteredOrders.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Sorted by priority & time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredOrders.map((order) {
                    String status = order["status"];
                    String priority = order["priority"];
                    String station = order["station"];
                    Color statusColor = getStatusColor(status);
                    Color priorityColor = getPriorityColor(priority);
                    List<dynamic> items = order["items"] as List<dynamic>;
                    double progress = getProgressPercentage(order);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: priority == "Urgent" 
                            ? dangerColor.withAlpha(100)
                            : statusColor.withAlpha(50),
                          width: priority == "Urgent" ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Order Header
                          Container(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                // Priority Indicator
                                Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: priorityColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "#${order["id"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${getOrderTypeIcon(order["orderType"])}",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: priorityColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              priority,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: priorityColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              status,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: statusColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${order["customerName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.restaurant, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "$station",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Icon(Icons.schedule, size: 12, color: warningColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${order["elapsedTime"]}/${order["preparationTime"]} min",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: warningColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${order["totalItems"]} items",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "ETA: ${TimeOfDay.fromDateTime(DateTime.parse(order["estimatedCompletion"])).kkmm}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (order["assignedStaff"].toString().isNotEmpty)
                                      Text(
                                        "${order["assignedStaff"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Progress Bar
                          if (status == "In Preparation")
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: spSm),
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: progress > 0.8 ? successColor : infoColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          
                          // Order Items
                          Container(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Items:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: items.map((item) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${item["quantity"]}x ${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                if (order["specialInstructions"].toString().isNotEmpty)
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.note, color: warningColor, size: 12),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${order["specialInstructions"]}",
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
                              ],
                            ),
                          ),
                          
                          // Action Buttons
                          Container(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                Text(
                                  "Ordered: ${TimeOfDay.fromDateTime(DateTime.parse(order["orderTime"])).kkmm}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (status == "Pending")
                                  GestureDetector(
                                    onTap: () {
                                      order["status"] = "In Preparation";
                                      order["elapsedTime"] = 0;
                                      ss("Order started cooking");
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.play_arrow, color: infoColor, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            "Start",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: infoColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (status == "In Preparation")
                                  GestureDetector(
                                    onTap: () {
                                      order["status"] = order["orderType"] == "Pickup" 
                                          ? "Ready for Pickup"
                                          : "Out for Delivery";
                                      ss("Order completed");
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check, color: successColor, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            "Complete",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () {
                                    // navigateTo(FmaOrderDetailsView(orderId: order["id"]));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.visibility,
                                      color: primaryColor,
                                      size: 16,
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
            ),
          ],
        ),
      ),
    );
  }
}

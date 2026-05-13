import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderTimingView extends StatefulWidget {
  const RfsOrderTimingView({super.key});

  @override
  State<RfsOrderTimingView> createState() => _RfsOrderTimingViewState();
}

class _RfsOrderTimingViewState extends State<RfsOrderTimingView> {
  String selectedView = "Timeline";
  String selectedFilter = "Active";
  
  List<Map<String, dynamic>> viewOptions = [
    {"label": "Timeline", "value": "Timeline"},
    {"label": "Kitchen View", "value": "Kitchen View"},
    {"label": "Service View", "value": "Service View"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Delayed", "value": "Delayed"},
    {"label": "On Time", "value": "On Time"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORDER-2024-001",
      "tableNumber": 15,
      "customerName": "Sarah Johnson",
      "orderTime": "2024-06-19 14:30:00",
      "promisedTime": "2024-06-19 15:00:00",
      "estimatedCompletion": "2024-06-19 15:05:00",
      "actualCompletion": "",
      "status": "In Kitchen",
      "priority": "High",
      "totalItems": 3,
      "completedItems": 1,
      "items": [
        {
          "name": "Caesar Salad",
          "station": "Cold Prep",
          "estimatedTime": 8,
          "actualTime": 7,
          "status": "Completed",
          "startTime": "2024-06-19 14:32:00",
          "completionTime": "2024-06-19 14:39:00",
        },
        {
          "name": "Grilled Chicken",
          "station": "Grill",
          "estimatedTime": 15,
          "actualTime": 0,
          "status": "Cooking",
          "startTime": "2024-06-19 14:35:00",
          "completionTime": "",
        },
        {
          "name": "Garlic Bread",
          "station": "Oven",
          "estimatedTime": 5,
          "actualTime": 0,
          "status": "Queued",
          "startTime": "",
          "completionTime": "",
        },
      ],
      "delays": [],
      "notes": "Customer has dietary restrictions",
    },
    {
      "id": "ORDER-2024-002",
      "tableNumber": 8,
      "customerName": "Mike Chen",
      "orderTime": "2024-06-19 14:25:00",
      "promisedTime": "2024-06-19 14:55:00",
      "estimatedCompletion": "2024-06-19 15:10:00",
      "actualCompletion": "",
      "status": "Delayed",
      "priority": "Medium",
      "totalItems": 4,
      "completedItems": 2,
      "items": [
        {
          "name": "Soup of the Day",
          "station": "Hot Prep",
          "estimatedTime": 5,
          "actualTime": 5,
          "status": "Completed",
          "startTime": "2024-06-19 14:27:00",
          "completionTime": "2024-06-19 14:32:00",
        },
        {
          "name": "Ribeye Steak",
          "station": "Grill",
          "estimatedTime": 20,
          "actualTime": 25,
          "status": "Completed",
          "startTime": "2024-06-19 14:30:00",
          "completionTime": "2024-06-19 14:55:00",
        },
        {
          "name": "Mashed Potatoes",
          "station": "Hot Prep",
          "estimatedTime": 8,
          "actualTime": 0,
          "status": "Cooking",
          "startTime": "2024-06-19 14:50:00",
          "completionTime": "",
        },
        {
          "name": "Steamed Vegetables",
          "station": "Hot Prep",
          "estimatedTime": 6,
          "actualTime": 0,
          "status": "Queued",
          "startTime": "",
          "completionTime": "",
        },
      ],
      "delays": [
        {
          "reason": "Grill overcrowded",
          "duration": 5,
          "timestamp": "2024-06-19 14:45:00",
        }
      ],
      "notes": "VIP customer",
    },
    {
      "id": "ORDER-2024-003",
      "tableNumber": 22,
      "customerName": "Emma Wilson",
      "orderTime": "2024-06-19 14:20:00",
      "promisedTime": "2024-06-19 14:45:00",
      "estimatedCompletion": "2024-06-19 14:43:00",
      "actualCompletion": "2024-06-19 14:43:00",
      "status": "Completed",
      "priority": "Low",
      "totalItems": 2,
      "completedItems": 2,
      "items": [
        {
          "name": "Fish and Chips",
          "station": "Fryer",
          "estimatedTime": 12,
          "actualTime": 11,
          "status": "Completed",
          "startTime": "2024-06-19 14:22:00",
          "completionTime": "2024-06-19 14:33:00",
        },
        {
          "name": "Coleslaw",
          "station": "Cold Prep",
          "estimatedTime": 3,
          "actualTime": 3,
          "status": "Completed",
          "startTime": "2024-06-19 14:40:00",
          "completionTime": "2024-06-19 14:43:00",
        },
      ],
      "delays": [],
      "notes": "",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      switch (selectedFilter) {
        case "Active":
          return order["status"] != "Completed";
        case "Delayed":
          return order["status"] == "Delayed";
        case "On Time":
          return order["status"] != "Completed" && order["status"] != "Delayed";
        case "Completed":
          return order["status"] == "Completed";
        default:
          return true;
      }
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Queued": return warningColor;
      case "Cooking": return infoColor;
      case "In Kitchen": return primaryColor;
      case "Completed": return successColor;
      case "Delayed": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  int _calculateDelay(String promisedTime, String estimatedCompletion) {
    if (estimatedCompletion.isEmpty) return 0;
    
    DateTime promised = DateTime.parse(promisedTime);
    DateTime estimated = DateTime.parse(estimatedCompletion);
    
    return estimated.difference(promised).inMinutes;
  }

  double _getProgressPercentage(int completed, int total) {
    if (total == 0) return 0.0;
    return completed / total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Timing"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              // Refresh timing data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // View and Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "View Type",
                    items: viewOptions,
                    value: selectedView,
                    onChanged: (value, label) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Dashboard
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
                    "Kitchen Performance",
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
                              "${orders.where((o) => o["status"] != "Completed").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Active Orders",
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
                              "${orders.where((o) => o["status"] == "Delayed").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Delayed",
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
                              "${(orders.where((o) => o["status"] == "Completed").length / orders.length * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "On Time Rate",
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

            // Orders List
            ...filteredOrders.map((order) {
              int delay = _calculateDelay("${order["promisedTime"]}", "${order["estimatedCompletion"]}");
              double progress = _getProgressPercentage(
                order["completedItems"] as int, 
                order["totalItems"] as int
              );

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
                      color: _getStatusColor("${order["status"]}"),
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
                            "${order["id"]} - Table ${order["tableNumber"]}",
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
                            color: _getPriorityColor("${order["priority"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["priority"]}",
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
                            color: _getStatusColor("${order["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["status"]}",
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
                      "Customer: ${order["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress: ${order["completedItems"]}/${order["totalItems"]} items",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(progress * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: progress == 1.0 ? successColor : infoColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Timing Information
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Ordered: ${DateTime.parse("${order["orderTime"]}").dMMMy}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Promised: ${DateTime.parse("${order["promisedTime"]}").dMMMy}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          if ("${order["estimatedCompletion"]}".isNotEmpty && order["status"] != "Completed")
                            Row(
                              children: [
                                Icon(Icons.psychology, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Estimated: ${DateTime.parse("${order["estimatedCompletion"]}").dMMMy}",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                                if (delay > 0) ...[
                                  Spacer(),
                                  Text(
                                    "+${delay} min delay",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          if ("${order["actualCompletion"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.check_circle, size: 14, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Completed: ${DateTime.parse("${order["actualCompletion"]}").dMMMy}",
                                  style: TextStyle(fontSize: 12, color: successColor),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Items Timeline
                    if (selectedView == "Timeline") ...[
                      Text(
                        "Items Timeline:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      ...((order["items"] as List).map((item) => Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${item["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: _getStatusColor("${item["status"]}"),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${item["status"]}"),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["name"]} (${item["station"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["status"]} • Est: ${item["estimatedTime"]} min",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if ("${item["completionTime"]}".isNotEmpty)
                              Text(
                                "✓ ${item["actualTime"]} min",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ))),
                    ],

                    // Delays
                    if ((order["delays"] as List).isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delays:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                            ...((order["delays"] as List).map((delay) => Text(
                              "• ${delay["reason"]} (+${delay["duration"]} min)",
                              style: TextStyle(
                                fontSize: 11,
                                color: dangerColor,
                              ),
                            ))),
                          ],
                        ),
                      ),
                    ],

                    if (order["status"] != "Completed")
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Update Status",
                              size: bs.sm,
                              onPressed: () {
                                // Update order status
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.schedule,
                            size: bs.sm,
                            onPressed: () {
                              // Adjust timing
                            },
                          ),
                          QButton(
                            icon: Icons.priority_high,
                            size: bs.sm,
                            onPressed: () {
                              // Change priority
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),

            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No orders found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Order timing information will appear here",
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

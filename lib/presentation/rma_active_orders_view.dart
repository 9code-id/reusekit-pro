import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaActiveOrdersView extends StatefulWidget {
  const RmaActiveOrdersView({super.key});

  @override
  State<RmaActiveOrdersView> createState() => _RmaActiveOrdersViewState();
}

class _RmaActiveOrdersViewState extends State<RmaActiveOrdersView> {
  String selectedFilter = "all";
  bool soundAlerts = true;
  bool autoRefresh = true;
  
  List<Map<String, dynamic>> activeOrders = [
    {
      "id": "ORD001",
      "customerName": "John Smith",
      "type": "dine_in",
      "table": "Table 12",
      "status": "preparing",
      "items": [
        {"name": "Classic Burger", "quantity": 2, "notes": "No onions", "ready": false},
        {"name": "French Fries", "quantity": 2, "notes": "", "ready": true},
        {"name": "Soft Drink", "quantity": 2, "notes": "Coke", "ready": true}
      ],
      "orderTime": "2025-06-17T12:15:00Z",
      "estimatedTime": 20,
      "elapsedTime": 12,
      "priority": "normal",
      "kitchenNotes": "Rush order",
      "waitStaff": "Alice"
    },
    {
      "id": "ORD002",
      "customerName": "Sarah Johnson",
      "type": "takeout",
      "table": "",
      "status": "ready",
      "items": [
        {"name": "Caesar Salad", "quantity": 1, "notes": "Extra dressing", "ready": true},
        {"name": "Grilled Chicken", "quantity": 1, "notes": "Well done", "ready": true}
      ],
      "orderTime": "2025-06-17T12:30:00Z",
      "estimatedTime": 15,
      "elapsedTime": 18,
      "priority": "normal",
      "kitchenNotes": "",
      "waitStaff": "Bob"
    },
    {
      "id": "ORD003",
      "customerName": "Mike Wilson",
      "type": "delivery",
      "table": "",
      "status": "out_for_delivery",
      "address": "123 Main St, Apt 4B",
      "items": [
        {"name": "Large Pizza", "quantity": 1, "notes": "Extra cheese", "ready": true},
        {"name": "Garlic Bread", "quantity": 1, "notes": "", "ready": true},
        {"name": "2L Soda", "quantity": 1, "notes": "Pepsi", "ready": true}
      ],
      "orderTime": "2025-06-17T11:45:00Z",
      "estimatedTime": 35,
      "elapsedTime": 45,
      "priority": "high",
      "kitchenNotes": "Delivery instructions: Leave at door",
      "waitStaff": "Charlie",
      "driver": "David"
    },
    {
      "id": "ORD004",
      "customerName": "Emily Davis",
      "type": "dine_in",
      "table": "Table 8",
      "status": "pending",
      "items": [
        {"name": "Ribeye Steak", "quantity": 1, "notes": "Medium rare", "ready": false},
        {"name": "Mashed Potatoes", "quantity": 1, "notes": "", "ready": false},
        {"name": "Wine", "quantity": 1, "notes": "Red wine", "ready": true}
      ],
      "orderTime": "2025-06-17T13:00:00Z",
      "estimatedTime": 25,
      "elapsedTime": 5,
      "priority": "urgent",
      "kitchenNotes": "Anniversary dinner - special presentation",
      "waitStaff": "Alice"
    },
    {
      "id": "ORD005",
      "customerName": "Lisa Garcia",
      "type": "takeout",
      "table": "",
      "status": "preparing",
      "items": [
        {"name": "Chicken Wings", "quantity": 12, "notes": "Buffalo sauce", "ready": false},
        {"name": "Blue Cheese Dip", "quantity": 1, "notes": "", "ready": true},
        {"name": "Celery Sticks", "quantity": 1, "notes": "", "ready": true}
      ],
      "orderTime": "2025-06-17T12:45:00Z",
      "estimatedTime": 18,
      "elapsedTime": 8,
      "priority": "normal",
      "kitchenNotes": "",
      "waitStaff": "Bob"
    },
    {
      "id": "ORD006",
      "customerName": "Tom Anderson",
      "type": "dine_in",
      "table": "Table 15",
      "status": "preparing",
      "items": [
        {"name": "Seafood Pasta", "quantity": 1, "notes": "No shellfish", "ready": false},
        {"name": "Garden Salad", "quantity": 1, "notes": "Italian dressing", "ready": true},
        {"name": "Bread Roll", "quantity": 2, "notes": "", "ready": true}
      ],
      "orderTime": "2025-06-17T12:52:00Z",
      "estimatedTime": 22,
      "elapsedTime": 3,
      "priority": "normal",
      "kitchenNotes": "Allergy alert: No shellfish",
      "waitStaff": "Charlie"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Urgent Priority", "value": "urgent"},
    {"label": "Overdue", "value": "overdue"},
  ];

  Widget _buildQuickStats() {
    final pendingCount = activeOrders.where((order) => order["status"] == "pending").length;
    final preparingCount = activeOrders.where((order) => order["status"] == "preparing").length;
    final readyCount = activeOrders.where((order) => order["status"] == "ready").length;
    final urgentCount = activeOrders.where((order) => order["priority"] == "urgent").length;
    
    return Container(
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
              Text(
                "Active Orders Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: autoRefresh ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh,
                      color: autoRefresh ? successColor : disabledBoldColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Auto Refresh",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: autoRefresh ? successColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard("Pending", "$pendingCount", Icons.hourglass_empty, warningColor),
              _buildStatCard("Preparing", "$preparingCount", Icons.kitchen, infoColor),
              _buildStatCard("Ready", "$readyCount", Icons.check_circle, successColor),
              _buildStatCard("Urgent", "$urgentCount", Icons.priority_high, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QDropdownField(
                  label: "Filter Orders",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  // Refresh orders
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Sound Alerts",
                      "value": true,
                      "checked": soundAlerts,
                    }
                  ],
                  value: [
                    if (soundAlerts)
                      {
                        "label": "Sound Alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    soundAlerts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto Refresh",
                      "value": true,
                      "checked": autoRefresh,
                    }
                  ],
                  value: [
                    if (autoRefresh)
                      {
                        "label": "Auto Refresh",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoRefresh = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = _getStatusColor(order["status"] as String);
    final priorityColor = _getPriorityColor(order["priority"] as String);
    final items = order["items"] as List;
    final isOverdue = (order["elapsedTime"] as int) > (order["estimatedTime"] as int);
    final completedItems = items.where((item) => item["ready"] as bool).length;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isOverdue ? dangerColor : statusColor,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${order["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        if (order["priority"] != "normal") ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${order["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: priorityColor,
                              ),
                            ),
                          ),
                        ],
                        if (isOverdue) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "OVERDUE",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getTypeIcon(order["type"] as String),
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${order["type"]}".replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (order["table"] != "")
                    Text(
                      "${order["table"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Items Progress: $completedItems/${items.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: (completedItems == items.length ? successColor : warningColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        completedItems == items.length ? "ALL READY" : "IN PROGRESS",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: completedItems == items.length ? successColor : warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...items.map((item) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: (item["ready"] as bool) ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (item["ready"] as bool) ? Icons.check_circle : Icons.hourglass_empty,
                        color: (item["ready"] as bool) ? successColor : warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${item["quantity"]}x",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (item["notes"] != "")
                        Text(
                          "(${item["notes"]})",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                )),
                if (order["kitchenNotes"] != "") ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.note,
                          color: infoColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${order["kitchenNotes"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time: ${order["elapsedTime"]}/${order["estimatedTime"]} min",
                    style: TextStyle(
                      fontSize: 12,
                      color: isOverdue ? dangerColor : disabledBoldColor,
                      fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Staff: ${order["waitStaff"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (order["driver"] != null)
                    Text(
                      "Driver: ${order["driver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RmaOrderDetailView')
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RmaEditOrderView')
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: _getActionIcon(order["status"] as String),
                    size: bs.sm,
                    onPressed: () {
                      _updateOrderStatus(order);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "preparing":
        return infoColor;
      case "ready":
        return successColor;
      case "out_for_delivery":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "dine_in":
        return Icons.restaurant;
      case "takeout":
        return Icons.takeout_dining;
      case "delivery":
        return Icons.delivery_dining;
      default:
        return Icons.receipt;
    }
  }

  IconData _getActionIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.kitchen;
      case "preparing":
        return Icons.check;
      case "ready":
        return Icons.local_shipping;
      case "out_for_delivery":
        return Icons.done_all;
      default:
        return Icons.check;
    }
  }

  void _updateOrderStatus(Map<String, dynamic> order) {
    setState(() {
      switch (order["status"]) {
        case "pending":
          order["status"] = "preparing";
          break;
        case "preparing":
          order["status"] = "ready";
          break;
        case "ready":
          if (order["type"] == "delivery") {
            order["status"] = "out_for_delivery";
          } else {
            // Remove from active orders
            activeOrders.remove(order);
          }
          break;
        case "out_for_delivery":
          // Remove from active orders
          activeOrders.remove(order);
          break;
      }
    });
  }

  List<Map<String, dynamic>> get filteredOrders {
    return activeOrders.where((order) {
      switch (selectedFilter) {
        case "pending":
          return order["status"] == "pending";
        case "preparing":
          return order["status"] == "preparing";
        case "ready":
          return order["status"] == "ready";
        case "out_for_delivery":
          return order["status"] == "out_for_delivery";
        case "urgent":
          return order["priority"] == "urgent";
        case "overdue":
          return (order["elapsedTime"] as int) > (order["estimatedTime"] as int);
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('RmaOrderAlertsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.kitchen),
            onPressed: () {
              //navigateTo('RmaKitchenDisplayView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickStats(),
            _buildControls(),
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
                  Text(
                    "Active Orders (${filteredOrders.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  if (filteredOrders.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 64,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No active orders",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "All orders are up to date!",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredOrders.map((order) => _buildOrderCard(order)).toList(),
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

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOrderManagementView extends StatefulWidget {
  const RmaOrderManagementView({super.key});

  @override
  State<RmaOrderManagementView> createState() => _RmaOrderManagementViewState();
}

class _RmaOrderManagementViewState extends State<RmaOrderManagementView> {
  String selectedStatus = "active";
  String selectedType = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "customerName": "John Smith",
      "customerPhone": "+1-555-0123",
      "type": "dine_in",
      "table": "Table 12",
      "status": "preparing",
      "items": [
        {"name": "Classic Burger", "quantity": 2, "price": 12.99, "notes": "No onions"},
        {"name": "French Fries", "quantity": 2, "price": 4.50, "notes": ""},
        {"name": "Soft Drink", "quantity": 2, "price": 2.50, "notes": "Coke"}
      ],
      "subtotal": 39.98,
      "tax": 3.20,
      "total": 43.18,
      "orderTime": "2025-06-17T12:15:00Z",
      "estimatedTime": 20,
      "actualTime": 0,
      "priority": "normal",
      "paymentStatus": "paid",
      "paymentMethod": "credit_card",
      "specialInstructions": "Table by the window if available"
    },
    {
      "id": "ORD002",
      "customerName": "Sarah Johnson",
      "customerPhone": "+1-555-0456",
      "type": "takeout",
      "table": "",
      "status": "ready",
      "items": [
        {"name": "Caesar Salad", "quantity": 1, "price": 11.25, "notes": "Extra dressing"},
        {"name": "Grilled Chicken", "quantity": 1, "price": 18.99, "notes": "Well done"}
      ],
      "subtotal": 30.24,
      "tax": 2.42,
      "total": 32.66,
      "orderTime": "2025-06-17T12:30:00Z",
      "estimatedTime": 15,
      "actualTime": 18,
      "priority": "normal",
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "specialInstructions": ""
    },
    {
      "id": "ORD003",
      "customerName": "Mike Wilson",
      "customerPhone": "+1-555-0789",
      "type": "delivery",
      "table": "",
      "status": "out_for_delivery",
      "address": "123 Main St, Apt 4B",
      "items": [
        {"name": "Large Pizza", "quantity": 1, "price": 24.99, "notes": "Extra cheese"},
        {"name": "Garlic Bread", "quantity": 1, "price": 5.99, "notes": ""},
        {"name": "2L Soda", "quantity": 1, "price": 3.99, "notes": "Pepsi"}
      ],
      "subtotal": 34.97,
      "tax": 2.80,
      "deliveryFee": 3.50,
      "total": 41.27,
      "orderTime": "2025-06-17T11:45:00Z",
      "estimatedTime": 35,
      "actualTime": 0,
      "priority": "high",
      "paymentStatus": "paid",
      "paymentMethod": "online",
      "specialInstructions": "Leave at door, ring doorbell"
    },
    {
      "id": "ORD004",
      "customerName": "Emily Davis",
      "customerPhone": "+1-555-0321",
      "type": "dine_in",
      "table": "Table 8",
      "status": "pending",
      "items": [
        {"name": "Ribeye Steak", "quantity": 1, "price": 28.99, "notes": "Medium rare"},
        {"name": "Mashed Potatoes", "quantity": 1, "price": 6.99, "notes": ""},
        {"name": "Wine", "quantity": 1, "price": 9.99, "notes": "Red wine"}
      ],
      "subtotal": 45.97,
      "tax": 3.68,
      "total": 49.65,
      "orderTime": "2025-06-17T13:00:00Z",
      "estimatedTime": 25,
      "actualTime": 0,
      "priority": "urgent",
      "paymentStatus": "pending",
      "paymentMethod": "credit_card",
      "specialInstructions": "Anniversary dinner - please add candle"
    },
    {
      "id": "ORD005",
      "customerName": "Robert Brown",
      "customerPhone": "+1-555-0654",
      "type": "takeout",
      "table": "",
      "status": "completed",
      "items": [
        {"name": "Fish & Chips", "quantity": 1, "price": 19.99, "notes": ""},
        {"name": "Coleslaw", "quantity": 1, "price": 3.99, "notes": ""},
        {"name": "Beer", "quantity": 1, "price": 5.99, "notes": "IPA"}
      ],
      "subtotal": 29.97,
      "tax": 2.40,
      "total": 32.37,
      "orderTime": "2025-06-17T11:30:00Z",
      "estimatedTime": 20,
      "actualTime": 22,
      "priority": "normal",
      "paymentStatus": "paid",
      "paymentMethod": "debit_card",
      "specialInstructions": ""
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active Orders", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Completed", "value": "completed"},
    {"label": "All Orders", "value": "all"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Dine In", "value": "dine_in"},
    {"label": "Takeout", "value": "takeout"},
    {"label": "Delivery", "value": "delivery"},
  ];

  Widget _buildOrdersOverview() {
    final activeOrders = orders.where((order) => 
      ["pending", "preparing", "ready", "out_for_delivery"].contains(order["status"])).length;
    final completedToday = orders.where((order) => order["status"] == "completed").length;
    final totalRevenue = orders.fold(0.0, (sum, order) => sum + (order["total"] as double));
    final avgOrderValue = totalRevenue / orders.length;
    
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
          Text(
            "Orders Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Active Orders",
                "$activeOrders",
                Icons.pending_actions,
                warningColor,
              ),
              _buildOverviewCard(
                "Completed Today",
                "$completedToday",
                Icons.check_circle,
                successColor,
              ),
              _buildOverviewCard(
                "Total Revenue",
                "\$${totalRevenue.toStringAsFixed(2)}",
                Icons.attach_money,
                primaryColor,
              ),
              _buildOverviewCard(
                "Avg Order Value",
                "\$${avgOrderValue.toStringAsFixed(2)}",
                Icons.trending_up,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
          QTextField(
            label: "Search orders...",
            value: searchQuery,
            hint: "Search by order ID, customer name, or phone",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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
    final orderTime = DateTime.parse(order["orderTime"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["customerName"]} • ${order["customerPhone"]}",
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
                children: [
                  Text(
                    "\$${((order["total"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    orderTime.kkmm,
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
                    Icon(
                      _getTypeIcon(order["type"] as String),
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${order["type"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (order["table"] != "") ...[
                      SizedBox(width: spSm),
                      Text(
                        "• ${order["table"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                    if (order["address"] != null && order["address"] != "") ...[
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "• ${order["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Items (${items.length}):",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
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
                      if (item["notes"] != "") ...[
                        Text(
                          "(${item["notes"]})",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                )),
                if (order["specialInstructions"] != "") ...[
                  SizedBox(height: spSm),
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
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${order["specialInstructions"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
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
                    "Est. Time: ${order["estimatedTime"]} min",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if ((order["actualTime"] as int) > 0)
                    Text(
                      "Actual: ${order["actualTime"]} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              Spacer(),
              if (order["status"] != "completed")
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
                      icon: _getNextActionIcon(order["status"] as String),
                      size: bs.sm,
                      onPressed: () {
                        _updateOrderStatus(order);
                      },
                    ),
                  ],
                )
              else
                QButton(
                  label: "View Receipt",
                  icon: Icons.receipt,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaOrderReceiptView')
                  },
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
      case "completed":
        return successColor;
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

  IconData _getNextActionIcon(String status) {
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
    // Update order status logic would go here
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
            order["status"] = "completed";
          }
          break;
        case "out_for_delivery":
          order["status"] = "completed";
          break;
      }
    });
  }

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      if (selectedStatus != "all") {
        if (selectedStatus == "active" && 
            !["pending", "preparing", "ready", "out_for_delivery"].contains(order["status"])) {
          return false;
        } else if (selectedStatus != "active" && order["status"] != selectedStatus) {
          return false;
        }
      }
      
      if (selectedType != "all" && order["type"] != selectedType) {
        return false;
      }
      
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return (order["id"] as String).toLowerCase().contains(query) ||
               (order["customerName"] as String).toLowerCase().contains(query) ||
               (order["customerPhone"] as String).toLowerCase().contains(query);
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('RmaCreateOrderView')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RmaOrderAnalyticsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOrdersOverview(),
            _buildFilters(),
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
                    "Orders (${filteredOrders.length})",
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
                            Icons.receipt_long,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No orders found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search criteria",
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

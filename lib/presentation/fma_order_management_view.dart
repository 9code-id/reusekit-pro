import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaOrderManagementView extends StatefulWidget {
  const FmaOrderManagementView({super.key});

  @override
  State<FmaOrderManagementView> createState() => _FmaOrderManagementViewState();
}

class _FmaOrderManagementViewState extends State<FmaOrderManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedDateFilter = "Today";
  
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "customerName": "John Smith",
      "customerPhone": "+1 234-567-8901",
      "items": [
        {"name": "Beef Burger Deluxe", "quantity": 2, "price": 15.99},
        {"name": "Fresh Orange Juice", "quantity": 1, "price": 4.99},
      ],
      "subtotal": 36.97,
      "tax": 2.96,
      "deliveryFee": 3.50,
      "discount": 5.00,
      "total": 38.43,
      "status": "In Preparation",
      "orderType": "Delivery",
      "paymentMethod": "Credit Card",
      "orderTime": "2024-12-19 12:30",
      "estimatedTime": "2024-12-19 13:15",
      "deliveryAddress": "123 Main St, New York, NY 10001",
      "specialInstructions": "Extra sauce on the side",
      "assignedStaff": "Chef Mike",
    },
    {
      "id": "ORD002",
      "customerName": "Sarah Johnson", 
      "customerPhone": "+1 234-567-8902",
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "price": 18.99},
        {"name": "Chocolate Cake Slice", "quantity": 2, "price": 6.99},
      ],
      "subtotal": 32.97,
      "tax": 2.64,
      "deliveryFee": 0.00,
      "discount": 0.00,
      "total": 35.61,
      "status": "Ready for Pickup",
      "orderType": "Pickup",
      "paymentMethod": "Cash",
      "orderTime": "2024-12-19 11:45",
      "estimatedTime": "2024-12-19 12:30",
      "deliveryAddress": "",
      "specialInstructions": "",
      "assignedStaff": "Chef Anna",
    },
    {
      "id": "ORD003",
      "customerName": "Mike Wilson",
      "customerPhone": "+1 234-567-8903", 
      "items": [
        {"name": "Grilled Chicken Salad", "quantity": 1, "price": 12.99},
      ],
      "subtotal": 12.99,
      "tax": 1.04,
      "deliveryFee": 3.50,
      "discount": 2.60,
      "total": 14.93,
      "status": "Out for Delivery",
      "orderType": "Delivery",
      "paymentMethod": "Mobile Payment",
      "orderTime": "2024-12-19 11:00",
      "estimatedTime": "2024-12-19 11:45",
      "deliveryAddress": "456 Oak Ave, Brooklyn, NY 11201",
      "specialInstructions": "Ring doorbell twice",
      "assignedStaff": "Driver Tom",
    },
    {
      "id": "ORD004",
      "customerName": "Emily Davis",
      "customerPhone": "+1 234-567-8904",
      "items": [
        {"name": "Beef Burger Deluxe", "quantity": 1, "price": 15.99},
        {"name": "Fresh Orange Juice", "quantity": 2, "price": 4.99},
      ],
      "subtotal": 25.97,
      "tax": 2.08,
      "deliveryFee": 0.00,
      "discount": 0.00,
      "total": 28.05,
      "status": "Completed",
      "orderType": "Dine In",
      "paymentMethod": "Credit Card",
      "orderTime": "2024-12-19 10:30",
      "estimatedTime": "2024-12-19 11:00",
      "deliveryAddress": "",
      "specialInstructions": "Table 12",
      "assignedStaff": "Waiter Lisa",
    },
    {
      "id": "ORD005",
      "customerName": "Robert Brown",
      "customerPhone": "+1 234-567-8905",
      "items": [
        {"name": "Margherita Pizza", "quantity": 2, "price": 18.99},
        {"name": "Chocolate Cake Slice", "quantity": 1, "price": 6.99},
      ],
      "subtotal": 44.97,
      "tax": 3.60,
      "deliveryFee": 3.50,
      "discount": 9.00,
      "total": 43.07,
      "status": "Cancelled",
      "orderType": "Delivery",
      "paymentMethod": "Credit Card",
      "orderTime": "2024-12-19 09:15",
      "estimatedTime": "2024-12-19 10:00",
      "deliveryAddress": "789 Pine St, Queens, NY 11354",
      "specialInstructions": "Leave at door",
      "assignedStaff": "",
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Orders", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Preparation", "value": "In Preparation"},
    {"label": "Ready for Pickup", "value": "Ready for Pickup"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> dateFilterItems = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSearch = order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          order["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          order["customerPhone"].toString().contains(searchQuery);
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      
      // Date filtering logic would be more complex in real app
      bool matchesDate = true; // Simplified for this example
      
      return matchesSearch && matchesStatus && matchesDate;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "In Preparation": return infoColor;
      case "Ready for Pickup": return primaryColor;
      case "Out for Delivery": return successColor;
      case "Completed": return successColor;
      case "Cancelled": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Pending": return Icons.schedule;
      case "In Preparation": return Icons.restaurant;
      case "Ready for Pickup": return Icons.check_circle;
      case "Out for Delivery": return Icons.delivery_dining;
      case "Completed": return Icons.done_all;
      case "Cancelled": return Icons.cancel;
      default: return Icons.help;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Orders refreshed");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                    label: "Search Orders",
                    value: searchQuery,
                    hint: "Search by order ID, customer name, or phone",
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
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Filter",
                          items: dateFilterItems,
                          value: selectedDateFilter,
                          onChanged: (value, label) {
                            selectedDateFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Statistics
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
                    "Today's Overview",
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${orders.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Orders",
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${orders.fold(0.0, (sum, order) => sum + (order["total"] as double)).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${orders.where((o) => o["status"] == "In Preparation").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "In Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
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

            // Orders List
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
                      Icon(Icons.receipt_long, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Orders (${filteredOrders.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredOrders.map((order) {
                    String status = order["status"];
                    Color statusColor = getStatusColor(status);
                    IconData statusIcon = getStatusIcon(status);
                    List<dynamic> items = order["items"] as List<dynamic>;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          // Order Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 18,
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
                                          style: TextStyle(fontSize: 16),
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
                                    Text(
                                      "${order["customerPhone"]}",
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
                                    "\$${(order["total"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "${order["paymentMethod"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Order Items
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Order Items:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                ...items.map((item) {
                                  return Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${item["quantity"]}x",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${item["name"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Order Details
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Ordered: ${DateTime.parse(order["orderTime"]).dMMMy} ${TimeOfDay.fromDateTime(DateTime.parse(order["orderTime"])).kkmm}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (order["estimatedTime"].toString().isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size: 12, color: warningColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "ETA: ${TimeOfDay.fromDateTime(DateTime.parse(order["estimatedTime"])).kkmm}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: warningColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (order["assignedStaff"].toString().isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 12, color: primaryColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${order["assignedStaff"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                spacing: spXs,
                                children: [
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
                                  if (status != "Completed" && status != "Cancelled")
                                    GestureDetector(
                                      onTap: () {
                                        _showStatusUpdateDialog(order);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.update,
                                          color: warningColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  if (status == "Pending")
                                    GestureDetector(
                                      onTap: () async {
                                        bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                                        if (isConfirmed) {
                                          order["status"] = "Cancelled";
                                          ss("Order cancelled successfully");
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.cancel,
                                          color: dangerColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
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
      ),
    );
  }

  void _showStatusUpdateDialog(Map<String, dynamic> order) {
    List<String> nextStatuses = [];
    String currentStatus = order["status"];
    
    switch (currentStatus) {
      case "Pending":
        nextStatuses = ["In Preparation"];
        break;
      case "In Preparation":
        nextStatuses = order["orderType"] == "Pickup" 
            ? ["Ready for Pickup"] 
            : ["Out for Delivery"];
        break;
      case "Ready for Pickup":
        nextStatuses = ["Completed"];
        break;
      case "Out for Delivery":
        nextStatuses = ["Completed"];
        break;
    }

    if (nextStatuses.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Order Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Current Status: $currentStatus"),
            SizedBox(height: spSm),
            Text("Select new status:"),
            ...nextStatuses.map((status) => ListTile(
              title: Text(status),
              onTap: () {
                order["status"] = status;
                ss("Order status updated to $status");
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderTrackingView extends StatefulWidget {
  const RfsOrderTrackingView({super.key});

  @override
  State<RfsOrderTrackingView> createState() => _RfsOrderTrackingViewState();
}

class _RfsOrderTrackingViewState extends State<RfsOrderTrackingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedTable = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Order Received", "value": "Order Received"},
    {"label": "Kitchen Confirmed", "value": "Kitchen Confirmed"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Ready for Service", "value": "Ready for Service"},
    {"label": "Served", "value": "Served"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> tableOptions = [
    {"label": "All", "value": "All"},
    {"label": "Table 1-10", "value": "1-10"},
    {"label": "Table 11-20", "value": "11-20"},
    {"label": "Table 21-30", "value": "21-30"},
    {"label": "Takeout", "value": "Takeout"},
    {"label": "Delivery", "value": "Delivery"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORDER-2024-001",
      "tableNumber": 15,
      "customerName": "Sarah Johnson",
      "orderType": "Dine In",
      "orderTime": "2024-06-19 14:30:00",
      "estimatedTime": "2024-06-19 15:00:00",
      "actualTime": "",
      "status": "Preparing",
      "currentStep": 2,
      "totalSteps": 5,
      "items": [
        {
          "name": "Caesar Salad",
          "quantity": 1,
          "status": "Completed",
          "station": "Cold Prep",
          "completedTime": "2024-06-19 14:38:00",
          "notes": "Extra croutons as requested",
        },
        {
          "name": "Grilled Chicken Breast",
          "quantity": 1,
          "status": "Cooking",
          "station": "Grill",
          "completedTime": "",
          "notes": "Medium doneness",
        },
        {
          "name": "Chocolate Dessert",
          "quantity": 1,
          "status": "Waiting",
          "station": "Oven",
          "completedTime": "",
          "notes": "To be started after main course",
        },
      ],
      "timeline": [
        {
          "step": "Order Received",
          "timestamp": "2024-06-19 14:30:00",
          "completed": true,
          "note": "Order placed via POS system",
        },
        {
          "step": "Kitchen Confirmed",
          "timestamp": "2024-06-19 14:31:00",
          "completed": true,
          "note": "Chef confirmed all items available",
        },
        {
          "step": "Preparing",
          "timestamp": "2024-06-19 14:32:00",
          "completed": false,
          "note": "Kitchen started preparation",
        },
        {
          "step": "Ready for Service",
          "timestamp": "",
          "completed": false,
          "note": "",
        },
        {
          "step": "Served",
          "timestamp": "",
          "completed": false,
          "note": "",
        },
      ],
      "specialRequests": ["No pepper on chicken", "Extra napkins"],
      "allergies": ["Gluten sensitivity"],
      "serverName": "Jennifer Smith",
      "totalAmount": 28.50,
      "paymentStatus": "Pending",
    },
    {
      "id": "ORDER-2024-002",
      "tableNumber": 8,
      "customerName": "Mike Chen",
      "orderType": "Dine In",
      "orderTime": "2024-06-19 14:25:00",
      "estimatedTime": "2024-06-19 14:55:00",
      "actualTime": "2024-06-19 15:10:00",
      "status": "Ready for Service",
      "currentStep": 4,
      "totalSteps": 5,
      "items": [
        {
          "name": "Soup of the Day",
          "quantity": 1,
          "status": "Completed",
          "station": "Hot Prep",
          "completedTime": "2024-06-19 14:32:00",
          "notes": "Tomato basil soup",
        },
        {
          "name": "Ribeye Steak",
          "quantity": 1,
          "status": "Completed",
          "station": "Grill",
          "completedTime": "2024-06-19 14:58:00",
          "notes": "Medium rare, compound butter",
        },
        {
          "name": "Garlic Mashed Potatoes",
          "quantity": 1,
          "status": "Completed",
          "station": "Hot Prep",
          "completedTime": "2024-06-19 15:05:00",
          "notes": "Extra garlic as requested",
        },
      ],
      "timeline": [
        {
          "step": "Order Received",
          "timestamp": "2024-06-19 14:25:00",
          "completed": true,
          "note": "Order placed by server",
        },
        {
          "step": "Kitchen Confirmed",
          "timestamp": "2024-06-19 14:26:00",
          "completed": true,
          "note": "All items confirmed available",
        },
        {
          "step": "Preparing",
          "timestamp": "2024-06-19 14:27:00",
          "completed": true,
          "note": "Started with soup preparation",
        },
        {
          "step": "Ready for Service",
          "timestamp": "2024-06-19 15:10:00",
          "completed": true,
          "note": "All items plated and ready",
        },
        {
          "step": "Served",
          "timestamp": "",
          "completed": false,
          "note": "",
        },
      ],
      "specialRequests": ["Extra garlic in potatoes", "Well-done steak"],
      "allergies": [],
      "serverName": "Carlos Rodriguez",
      "totalAmount": 45.75,
      "paymentStatus": "Pending",
    },
    {
      "id": "ORDER-2024-003",
      "tableNumber": 0,
      "customerName": "Emma Wilson",
      "orderType": "Takeout",
      "orderTime": "2024-06-19 14:20:00",
      "estimatedTime": "2024-06-19 14:45:00",
      "actualTime": "2024-06-19 14:43:00",
      "status": "Completed",
      "currentStep": 5,
      "totalSteps": 5,
      "items": [
        {
          "name": "Fish and Chips",
          "quantity": 2,
          "status": "Completed",
          "station": "Fryer",
          "completedTime": "2024-06-19 14:38:00",
          "notes": "Extra crispy, tartar sauce on side",
        },
        {
          "name": "Coleslaw",
          "quantity": 2,
          "status": "Completed",
          "station": "Cold Prep",
          "completedTime": "2024-06-19 14:40:00",
          "notes": "Fresh preparation",
        },
      ],
      "timeline": [
        {
          "step": "Order Received",
          "timestamp": "2024-06-19 14:20:00",
          "completed": true,
          "note": "Phone order taken",
        },
        {
          "step": "Kitchen Confirmed",
          "timestamp": "2024-06-19 14:21:00",
          "completed": true,
          "note": "Items confirmed, prep started",
        },
        {
          "step": "Preparing",
          "timestamp": "2024-06-19 14:22:00",
          "completed": true,
          "note": "Fish battered and fried",
        },
        {
          "step": "Ready for Service",
          "timestamp": "2024-06-19 14:40:00",
          "completed": true,
          "note": "Packaged for takeout",
        },
        {
          "step": "Served",
          "timestamp": "2024-06-19 14:43:00",
          "completed": true,
          "note": "Customer picked up order",
        },
      ],
      "specialRequests": ["Extra tartar sauce", "Lemon wedges"],
      "allergies": [],
      "serverName": "Takeout Counter",
      "totalAmount": 19.95,
      "paymentStatus": "Paid",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSearch = "${order["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      
      bool matchesTable = selectedTable == "All" || 
          (selectedTable == "Takeout" && order["orderType"] == "Takeout") ||
          (selectedTable == "Delivery" && order["orderType"] == "Delivery") ||
          (selectedTable == "1-10" && (order["tableNumber"] as int) >= 1 && (order["tableNumber"] as int) <= 10) ||
          (selectedTable == "11-20" && (order["tableNumber"] as int) >= 11 && (order["tableNumber"] as int) <= 20) ||
          (selectedTable == "21-30" && (order["tableNumber"] as int) >= 21 && (order["tableNumber"] as int) <= 30);
      
      return matchesSearch && matchesStatus && matchesTable;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Order Received": return infoColor;
      case "Kitchen Confirmed": return primaryColor;
      case "Preparing": return warningColor;
      case "Ready for Service": return successColor;
      case "Served": return successColor;
      case "Completed": return disabledBoldColor;
      default: return disabledColor;
    }
  }

  Color _getItemStatusColor(String status) {
    switch (status) {
      case "Waiting": return warningColor;
      case "Cooking": return infoColor;
      case "Completed": return successColor;
      default: return disabledColor;
    }
  }

  double _getProgressPercentage(int currentStep, int totalSteps) {
    return currentStep / totalSteps;
  }

  String _formatTableDisplay(int tableNumber, String orderType) {
    if (orderType == "Takeout") return "Takeout";
    if (orderType == "Delivery") return "Delivery";
    return "Table $tableNumber";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              // Refresh tracking data
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
            QTextField(
              label: "Search orders...",
              value: searchQuery,
              hint: "Search by customer name or order ID",
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
                    label: "Table Range",
                    items: tableOptions,
                    value: selectedTable,
                    onChanged: (value, label) {
                      selectedTable = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Cards
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredOrders.where((o) => o["status"] == "Preparing").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Preparing",
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
                          "${filteredOrders.where((o) => o["status"] == "Ready for Service").length}",
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
                          "${filteredOrders.where((o) => o["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Completed",
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
            ),

            // Orders List
            ...filteredOrders.map((order) {
              double progress = _getProgressPercentage(
                order["currentStep"] as int, 
                order["totalSteps"] as int
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
                            "${order["id"]} - ${_formatTableDisplay(order["tableNumber"] as int, "${order["orderType"]}")}",
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
                              "Progress: ${order["currentStep"]}/${order["totalSteps"]} steps",
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
                                color: _getStatusColor("${order["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Timeline
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
                            "Timeline:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...((order["timeline"] as List).map((step) => Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: step["completed"] ? successColor : disabledColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${step["step"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: step["completed"] ? primaryColor : disabledBoldColor,
                                    fontWeight: step["completed"] ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if ("${step["timestamp"]}".isNotEmpty)
                                Text(
                                  "${DateTime.parse("${step["timestamp"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                            ],
                          ))),
                        ],
                      ),
                    ),

                    // Items Status
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Items:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          ...((order["items"] as List).map((item) => Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getItemStatusColor("${item["status"]}"),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${item["quantity"]}x ${item["name"]} (${item["station"]})",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: _getItemStatusColor("${item["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ))),
                        ],
                      ),
                    ),

                    // Special Requests & Allergies
                    if ((order["specialRequests"] as List).isNotEmpty || (order["allergies"] as List).isNotEmpty)
                      Row(
                        children: [
                          if ((order["specialRequests"] as List).isNotEmpty)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Special Requests:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                    ...((order["specialRequests"] as List).map((req) => Text(
                                      "• $req",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: warningColor,
                                      ),
                                    ))),
                                  ],
                                ),
                              ),
                            ),
                          if ((order["allergies"] as List).isNotEmpty) ...[
                            SizedBox(width: spXs),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Allergies:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: dangerColor,
                                      ),
                                    ),
                                    ...((order["allergies"] as List).map((allergy) => Text(
                                      "• $allergy",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: dangerColor,
                                      ),
                                    ))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                    // Order Info
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Server: ${order["serverName"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total: \$${((order["totalAmount"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Timing Info
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Ordered: ${DateTime.parse("${order["orderTime"]}").dMMMy}",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Estimated: ${DateTime.parse("${order["estimatedTime"]}").dMMMy}",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          if ("${order["actualTime"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.check_circle, size: 12, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Completed: ${DateTime.parse("${order["actualTime"]}").dMMMy}",
                                  style: TextStyle(fontSize: 10, color: successColor),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

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
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () {
                              // View full details
                            },
                          ),
                          QButton(
                            icon: Icons.message,
                            size: bs.sm,
                            onPressed: () {
                              // Send message to kitchen/server
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
                      Icons.track_changes,
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
                      "Order tracking information will appear here",
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

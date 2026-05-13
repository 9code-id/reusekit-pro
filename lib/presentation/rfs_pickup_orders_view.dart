import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPickupOrdersView extends StatefulWidget {
  const RfsPickupOrdersView({super.key});

  @override
  State<RfsPickupOrdersView> createState() => _RfsPickupOrdersViewState();
}

class _RfsPickupOrdersViewState extends State<RfsPickupOrdersView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedTimeSlot = "all";
  int selectedTab = 0;

  List<Map<String, dynamic>> pickupOrders = [
    {
      "id": "po1",
      "orderId": "ORD-2024-P001",
      "customer": "John Smith",
      "phone": "+1 234 567 8900",
      "email": "john.smith@email.com",
      "pickupTime": "12:30 PM",
      "timeSlot": "12:00 - 13:00",
      "orderDate": "2024-01-15",
      "status": "ready",
      "estimatedTime": "12:30 PM",
      "items": [
        {"name": "Pizza Margherita", "quantity": 2, "price": 24.00},
        {"name": "Coca Cola", "quantity": 2, "price": 4.50},
      ],
      "totalAmount": 28.50,
      "notes": "Extra cheese on pizza",
      "paymentStatus": "paid",
      "paymentMethod": "credit_card",
      "preparationTime": 15,
      "priority": "normal",
    },
    {
      "id": "po2",
      "orderId": "ORD-2024-P002",
      "customer": "Sarah Davis",
      "phone": "+1 234 567 8901",
      "email": "sarah.davis@email.com",
      "pickupTime": "1:15 PM",
      "timeSlot": "13:00 - 14:00",
      "orderDate": "2024-01-15",
      "status": "preparing",
      "estimatedTime": "1:20 PM",
      "items": [
        {"name": "Burger Combo", "quantity": 1, "price": 18.50},
        {"name": "Fries", "quantity": 2, "price": 8.00},
        {"name": "Milkshake", "quantity": 1, "price": 6.25},
      ],
      "totalAmount": 32.75,
      "notes": "No onions on burger",
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "preparationTime": 20,
      "priority": "high",
    },
    {
      "id": "po3",
      "orderId": "ORD-2024-P003",
      "customer": "Robert Brown",
      "phone": "+1 234 567 8902",
      "email": "robert.brown@email.com",
      "pickupTime": "2:00 PM",
      "timeSlot": "14:00 - 15:00",
      "orderDate": "2024-01-15",
      "status": "completed",
      "estimatedTime": "1:55 PM",
      "items": [
        {"name": "Pasta Carbonara", "quantity": 1, "price": 22.00},
        {"name": "Garlic Bread", "quantity": 1, "price": 5.50},
      ],
      "totalAmount": 27.50,
      "notes": "",
      "paymentStatus": "paid",
      "paymentMethod": "digital_wallet",
      "preparationTime": 18,
      "priority": "normal",
    },
    {
      "id": "po4",
      "orderId": "ORD-2024-P004",
      "customer": "Emily Wilson",
      "phone": "+1 234 567 8903",
      "email": "emily.wilson@email.com",
      "pickupTime": "2:45 PM",
      "timeSlot": "14:00 - 15:00",
      "orderDate": "2024-01-15",
      "status": "pending",
      "estimatedTime": "2:50 PM",
      "items": [
        {"name": "Sushi Platter", "quantity": 1, "price": 45.00},
        {"name": "Miso Soup", "quantity": 2, "price": 8.00},
      ],
      "totalAmount": 53.00,
      "notes": "Vegetarian sushi only",
      "paymentStatus": "pending",
      "paymentMethod": "credit_card",
      "preparationTime": 25,
      "priority": "urgent",
    },
    {
      "id": "po5",
      "orderId": "ORD-2024-P005",
      "customer": "Michael Johnson",
      "phone": "+1 234 567 8904",
      "email": "michael.j@email.com",
      "pickupTime": "3:30 PM",
      "timeSlot": "15:00 - 16:00",
      "orderDate": "2024-01-15",
      "status": "overdue",
      "estimatedTime": "3:15 PM",
      "items": [
        {"name": "Chicken Wings", "quantity": 2, "price": 16.00},
        {"name": "Beer", "quantity": 3, "price": 12.00},
      ],
      "totalAmount": 28.00,
      "notes": "Extra spicy wings",
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "preparationTime": 12,
      "priority": "normal",
    },
  ];

  List<Map<String, dynamic>> pickupSlots = [
    {
      "timeSlot": "10:00 - 11:00",
      "capacity": 8,
      "booked": 3,
      "available": 5,
      "averageWait": 5,
    },
    {
      "timeSlot": "11:00 - 12:00",
      "capacity": 10,
      "booked": 7,
      "available": 3,
      "averageWait": 8,
    },
    {
      "timeSlot": "12:00 - 13:00",
      "capacity": 12,
      "booked": 10,
      "available": 2,
      "averageWait": 12,
    },
    {
      "timeSlot": "13:00 - 14:00",
      "capacity": 15,
      "booked": 11,
      "available": 4,
      "averageWait": 10,
    },
    {
      "timeSlot": "14:00 - 15:00",
      "capacity": 12,
      "booked": 9,
      "available": 3,
      "averageWait": 7,
    },
    {
      "timeSlot": "15:00 - 16:00",
      "capacity": 10,
      "booked": 5,
      "available": 5,
      "averageWait": 6,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> timeSlotItems = [
    {"label": "All Time Slots", "value": "all"},
    {"label": "10:00 - 11:00", "value": "10:00 - 11:00"},
    {"label": "11:00 - 12:00", "value": "11:00 - 12:00"},
    {"label": "12:00 - 13:00", "value": "12:00 - 13:00"},
    {"label": "13:00 - 14:00", "value": "13:00 - 14:00"},
    {"label": "14:00 - 15:00", "value": "14:00 - 15:00"},
    {"label": "15:00 - 16:00", "value": "15:00 - 16:00"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return pickupOrders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["phone"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || 
          order["status"] == selectedStatus;
      
      bool matchesTimeSlot = selectedTimeSlot == "all" ||
          order["timeSlot"] == selectedTimeSlot;
      
      return matchesSearch && matchesStatus && matchesTimeSlot;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "preparing":
        return infoColor;
      case "ready":
        return successColor;
      case "completed":
        return primaryColor;
      case "overdue":
        return dangerColor;
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
      case "normal":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildPickupOrderCard(Map<String, dynamic> order) {
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["orderId"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${order["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${order["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor("${order["priority"]}"),
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${order["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${order["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${order["status"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Pickup: ${order["pickupTime"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Est: ${order["estimatedTime"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["phone"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                order["paymentStatus"] == "paid" ? Icons.check_circle : Icons.pending,
                size: 16,
                color: order["paymentStatus"] == "paid" ? successColor : warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["paymentMethod"]}".replaceAll("_", " ").toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: order["paymentStatus"] == "paid" ? successColor : warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${(order["items"] as List).length})",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(order["items"] as List).map((item) => 
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item["quantity"]}x ${item["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((item["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Total: \$${((order["totalAmount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (order["notes"] != null && "${order["notes"]}".isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.note,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Notes",
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
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _showOrderDetails(order),
              ),
              SizedBox(width: spSm),
              if (order["status"] == "pending")
                QButton(
                  label: "Start Prep",
                  size: bs.sm,
                  onPressed: () => _startPreparation(order),
                ),
              if (order["status"] == "preparing")
                QButton(
                  label: "Mark Ready",
                  size: bs.sm,
                  onPressed: () => _markReady(order),
                ),
              if (order["status"] == "ready")
                QButton(
                  label: "Complete",
                  size: bs.sm,
                  onPressed: () => _completeOrder(order),
                ),
              Spacer(),
              QButton(
                icon: Icons.call,
                size: bs.sm,
                onPressed: () => _callCustomer(order),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard(Map<String, dynamic> slot) {
    double utilization = (slot["booked"] as int) / (slot["capacity"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: utilization >= 0.9 ? dangerColor : 
                 utilization >= 0.7 ? warningColor : successColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${slot["timeSlot"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Capacity: ${slot["booked"]}/${slot["capacity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Avg Wait: ${slot["averageWait"]} min",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: slot["available"] > 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Available: ${slot["available"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: slot["available"] > 0 ? successColor : dangerColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: utilization,
                  child: Container(
                    decoration: BoxDecoration(
                      color: utilization >= 0.9 ? dangerColor : 
                             utilization >= 0.7 ? warningColor : successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    int totalPending = pickupOrders.where((o) => o["status"] == "pending").length;
    int totalPreparing = pickupOrders.where((o) => o["status"] == "preparing").length;
    int totalReady = pickupOrders.where((o) => o["status"] == "ready").length;
    int totalOverdue = pickupOrders.where((o) => o["status"] == "overdue").length;
    double totalRevenue = pickupOrders
        .where((o) => o["status"] == "completed")
        .fold(0.0, (sum, order) => sum + (order["totalAmount"] as double));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "$totalPending",
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
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "$totalPreparing",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "$totalReady",
                      style: TextStyle(
                        fontSize: 24,
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
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "$totalOverdue",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Overdue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "\$${totalRevenue.currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Order: ${order["orderId"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spSm),
              Text("Customer: ${order["customer"]}"),
              Text("Phone: ${order["phone"]}"),
              Text("Email: ${order["email"]}"),
              SizedBox(height: spSm),
              Text("Pickup Time: ${order["pickupTime"]}"),
              Text("Time Slot: ${order["timeSlot"]}"),
              Text("Estimated: ${order["estimatedTime"]}"),
              SizedBox(height: spSm),
              Text("Status: ${order["status"]}"),
              Text("Priority: ${order["priority"]}"),
              Text("Payment: ${order["paymentStatus"]} (${order["paymentMethod"]})"),
              SizedBox(height: spSm),
              Text("Items:"),
              ...(order["items"] as List).map((item) => 
                Text("• ${item["quantity"]}x ${item["name"]} - \$${((item["price"] as double)).currency}", 
                     style: TextStyle(fontSize: 13))),
              SizedBox(height: spSm),
              Text("Total: \$${((order["totalAmount"] as double)).currency}"),
              if (order["notes"] != null && "${order["notes"]}".isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Notes: ${order["notes"]}"),
              ],
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _startPreparation(Map<String, dynamic> order) {
    order["status"] = "preparing";
    setState(() {});
    ss("Started preparation for ${order["orderId"]}");
  }

  void _markReady(Map<String, dynamic> order) {
    order["status"] = "ready";
    setState(() {});
    ss("Order ${order["orderId"]} is ready for pickup");
    // Send notification to customer
  }

  void _completeOrder(Map<String, dynamic> order) {
    order["status"] = "completed";
    setState(() {});
    ss("Order ${order["orderId"]} completed successfully");
  }

  void _callCustomer(Map<String, dynamic> order) {
    si("Calling ${order["customer"]} at ${order["phone"]}");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pickup Orders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.shopping_bag)),
        Tab(text: "Time Slots", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        // Orders Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(),
              SizedBox(height: spMd),
              QTextField(
                label: "Search orders...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Time Slot",
                      items: timeSlotItems,
                      value: selectedTimeSlot,
                      onChanged: (value, label) {
                        selectedTimeSlot = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Pickup Orders (${filteredOrders.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              if (filteredOrders.isEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "No orders found",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              else
                ...filteredOrders.map((order) => _buildPickupOrderCard(order)),
            ],
          ),
        ),
        
        // Time Slots Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pickup Time Slot Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...pickupSlots.map((slot) => _buildTimeSlotCard(slot)),
            ],
          ),
        ),
      ],
    );
  }
}

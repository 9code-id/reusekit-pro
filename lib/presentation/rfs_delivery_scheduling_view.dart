import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsDeliverySchedulingView extends StatefulWidget {
  const RfsDeliverySchedulingView({super.key});

  @override
  State<RfsDeliverySchedulingView> createState() => _RfsDeliverySchedulingViewState();
}

class _RfsDeliverySchedulingViewState extends State<RfsDeliverySchedulingView> {
  String searchQuery = "";
  String selectedTimeSlot = "all";
  String selectedDriver = "all";
  String selectedStatus = "all";
  int selectedTab = 0;

  List<Map<String, dynamic>> timeSlots = [
    {
      "id": "ts1",
      "time": "08:00 - 10:00",
      "capacity": 8,
      "booked": 6,
      "available": 2,
      "price": 0.0,
      "isActive": true,
    },
    {
      "id": "ts2", 
      "time": "10:00 - 12:00",
      "capacity": 10,
      "booked": 10,
      "available": 0,
      "price": 2.50,
      "isActive": true,
    },
    {
      "id": "ts3",
      "time": "12:00 - 14:00",
      "capacity": 12,
      "booked": 8,
      "available": 4,
      "price": 5.00,
      "isActive": true,
    },
    {
      "id": "ts4",
      "time": "14:00 - 16:00",
      "capacity": 10,
      "booked": 5,
      "available": 5,
      "price": 2.50,
      "isActive": true,
    },
    {
      "id": "ts5",
      "time": "16:00 - 18:00",
      "capacity": 15,
      "booked": 12,
      "available": 3,
      "price": 7.50,
      "isActive": true,
    },
    {
      "id": "ts6",
      "time": "18:00 - 20:00",
      "capacity": 20,
      "booked": 18,
      "available": 2,
      "price": 10.00,
      "isActive": true,
    },
    {
      "id": "ts7",
      "time": "20:00 - 22:00",
      "capacity": 12,
      "booked": 7,
      "available": 5,
      "price": 5.00,
      "isActive": true,
    },
  ];

  List<Map<String, dynamic>> scheduledDeliveries = [
    {
      "id": "sd1",
      "orderId": "ORD-2024-001",
      "customer": "John Smith",
      "address": "123 Main Street, Downtown",
      "phone": "+1 234 567 8900",
      "timeSlot": "10:00 - 12:00",
      "driver": "Mike Johnson",
      "deliveryFee": 5.00,
      "scheduledDate": "2024-01-15",
      "status": "scheduled",
      "priority": "normal",
      "items": ["Pizza Margherita", "Coca Cola"],
      "totalAmount": 28.50,
      "notes": "Ring doorbell twice",
    },
    {
      "id": "sd2",
      "orderId": "ORD-2024-002", 
      "customer": "Sarah Davis",
      "address": "456 Oak Avenue, Uptown",
      "phone": "+1 234 567 8901",
      "timeSlot": "12:00 - 14:00",
      "driver": "David Wilson",
      "deliveryFee": 7.50,
      "scheduledDate": "2024-01-15",
      "status": "in_progress",
      "priority": "high",
      "items": ["Burger Combo", "Fries", "Milkshake"],
      "totalAmount": 35.75,
      "notes": "Call when arrived",
    },
    {
      "id": "sd3",
      "orderId": "ORD-2024-003",
      "customer": "Robert Brown", 
      "address": "789 Pine Road, Suburb",
      "phone": "+1 234 567 8902",
      "timeSlot": "16:00 - 18:00",
      "driver": "Lisa Anderson",
      "deliveryFee": 10.00,
      "scheduledDate": "2024-01-15",
      "status": "completed",
      "priority": "normal",
      "items": ["Pasta Carbonara", "Garlic Bread"],
      "totalAmount": 42.25,
      "notes": "Apartment 5B",
    },
    {
      "id": "sd4",
      "orderId": "ORD-2024-004",
      "customer": "Emily Wilson",
      "address": "321 Elm Street, Central",
      "phone": "+1 234 567 8903",
      "timeSlot": "18:00 - 20:00",
      "driver": "James Taylor",
      "deliveryFee": 12.50,
      "scheduledDate": "2024-01-15",
      "status": "delayed",
      "priority": "urgent",
      "items": ["Sushi Platter", "Miso Soup"],
      "totalAmount": 65.00,
      "notes": "Use back entrance",
    },
  ];

  List<Map<String, dynamic>> drivers = [
    {
      "id": "d1",
      "name": "Mike Johnson",
      "vehicle": "Honda Civic",
      "phone": "+1 234 567 9000",
      "status": "available",
      "currentDeliveries": 2,
      "maxCapacity": 5,
      "rating": 4.8,
      "completedToday": 12,
      "efficiency": 95,
    },
    {
      "id": "d2",
      "name": "David Wilson", 
      "vehicle": "Toyota Corolla",
      "phone": "+1 234 567 9001",
      "status": "busy",
      "currentDeliveries": 4,
      "maxCapacity": 4,
      "rating": 4.6,
      "completedToday": 15,
      "efficiency": 88,
    },
    {
      "id": "d3",
      "name": "Lisa Anderson",
      "vehicle": "Ford Focus",
      "phone": "+1 234 567 9002", 
      "status": "available",
      "currentDeliveries": 1,
      "maxCapacity": 6,
      "rating": 4.9,
      "completedToday": 8,
      "efficiency": 92,
    },
    {
      "id": "d4",
      "name": "James Taylor",
      "vehicle": "Nissan Sentra",
      "phone": "+1 234 567 9003",
      "status": "offline",
      "currentDeliveries": 0,
      "maxCapacity": 5,
      "rating": 4.5,
      "completedToday": 0,
      "efficiency": 85,
    },
  ];

  List<Map<String, dynamic>> timeSlotItems = [
    {"label": "All Time Slots", "value": "all"},
    {"label": "08:00 - 10:00", "value": "08:00 - 10:00"},
    {"label": "10:00 - 12:00", "value": "10:00 - 12:00"},
    {"label": "12:00 - 14:00", "value": "12:00 - 14:00"},
    {"label": "14:00 - 16:00", "value": "14:00 - 16:00"},
    {"label": "16:00 - 18:00", "value": "16:00 - 18:00"},
    {"label": "18:00 - 20:00", "value": "18:00 - 20:00"},
    {"label": "20:00 - 22:00", "value": "20:00 - 22:00"},
  ];

  List<Map<String, dynamic>> driverItems = [
    {"label": "All Drivers", "value": "all"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "David Wilson", "value": "David Wilson"}, 
    {"label": "Lisa Anderson", "value": "Lisa Anderson"},
    {"label": "James Taylor", "value": "James Taylor"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Delayed", "value": "delayed"},
  ];

  List<Map<String, dynamic>> get filteredDeliveries {
    return scheduledDeliveries.where((delivery) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${delivery["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${delivery["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesTimeSlot = selectedTimeSlot == "all" || 
          delivery["timeSlot"] == selectedTimeSlot;
      
      bool matchesDriver = selectedDriver == "all" ||
          delivery["driver"] == selectedDriver;
      
      bool matchesStatus = selectedStatus == "all" ||
          delivery["status"] == selectedStatus;
      
      return matchesSearch && matchesTimeSlot && matchesDriver && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "completed":
        return successColor;
      case "delayed":
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
                  "${slot["time"]}",
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
                      Icons.local_shipping,
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
                      "Available: ${slot["available"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: slot["available"] > 0 ? successColor : dangerColor,
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: (slot["price"] as double) > 0 ? warningColor.withAlpha(20) : successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  (slot["price"] as double) > 0 ? "\$${((slot["price"] as double)).currency}" : "Free",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: (slot["price"] as double) > 0 ? warningColor : successColor,
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

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
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
            color: _getStatusColor("${delivery["status"]}"),
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
                      "${delivery["orderId"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["customer"]}",
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
                      color: _getPriorityColor("${delivery["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${delivery["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor("${delivery["priority"]}"),
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
                      color: _getStatusColor("${delivery["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${delivery["status"]}".toUpperCase().replaceAll("_", " "),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${delivery["status"]}"),
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
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["address"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
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
                "${delivery["timeSlot"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${delivery["driver"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
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
                      "Total: \$${((delivery["totalAmount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (delivery["notes"] != null && "${delivery["notes"]}".isNotEmpty)
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
                onPressed: () => _showDeliveryDetails(delivery),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Reschedule",
                size: bs.sm,
                onPressed: () => _showRescheduleDialog(delivery),
              ),
              Spacer(),
              if (delivery["status"] == "scheduled")
                QButton(
                  label: "Start",
                  size: bs.sm,
                  onPressed: () => _startDelivery(delivery),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
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
            color: driver["status"] == "available" ? successColor :
                   driver["status"] == "busy" ? warningColor : disabledBoldColor,
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
                      "${driver["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${driver["vehicle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: driver["status"] == "available" ? successColor.withAlpha(20) :
                         driver["status"] == "busy" ? warningColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${driver["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: driver["status"] == "available" ? successColor :
                           driver["status"] == "busy" ? warningColor : disabledBoldColor,
                  ),
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
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(driver["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Capacity: ${driver["currentDeliveries"]}/${driver["maxCapacity"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Today: ${driver["completedToday"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 16,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Efficiency: ${driver["efficiency"]}%",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                label: "Assign Order",
                size: bs.sm,
                onPressed: driver["status"] == "available" ? () => _showAssignOrderDialog(driver) : null,
              ),
              SizedBox(width: spSm),
              QButton(
                label: "View Schedule",
                size: bs.sm,
                onPressed: () => _showDriverSchedule(driver),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeliveryDetails(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Order: ${delivery["orderId"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spSm),
              Text("Customer: ${delivery["customer"]}"),
              Text("Phone: ${delivery["phone"]}"),
              Text("Address: ${delivery["address"]}"),
              SizedBox(height: spSm),
              Text("Time Slot: ${delivery["timeSlot"]}"),
              Text("Driver: ${delivery["driver"]}"),
              Text("Status: ${delivery["status"]}"),
              SizedBox(height: spSm),
              Text("Items:"),
              ...(delivery["items"] as List).map((item) => 
                Text("• $item", style: TextStyle(fontSize: 13))),
              SizedBox(height: spSm),
              Text("Total: \$${((delivery["totalAmount"] as double)).currency}"),
              Text("Delivery Fee: \$${((delivery["deliveryFee"] as double)).currency}"),
              if (delivery["notes"] != null && "${delivery["notes"]}".isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Notes: ${delivery["notes"]}"),
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

  void _showRescheduleDialog(Map<String, dynamic> delivery) {
    String newTimeSlot = "${delivery["timeSlot"]}";
    String newDriver = "${delivery["driver"]}";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reschedule Delivery"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "New Time Slot",
                items: timeSlotItems.where((item) => item["value"] != "all").toList(),
                value: newTimeSlot,
                onChanged: (value, label) {
                  newTimeSlot = value;
                  setDialogState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Assign Driver",
                items: driverItems.where((item) => item["value"] != "all").toList(),
                value: newDriver,
                onChanged: (value, label) {
                  newDriver = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Reschedule",
            size: bs.sm,
            onPressed: () {
              delivery["timeSlot"] = newTimeSlot;
              delivery["driver"] = newDriver;
              setState(() {});
              back();
              ss("Delivery rescheduled successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showAssignOrderDialog(Map<String, dynamic> driver) {
    List<Map<String, dynamic>> pendingOrders = scheduledDeliveries
        .where((delivery) => delivery["status"] == "scheduled")
        .toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Assign Order to ${driver["name"]}"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pendingOrders.length,
            itemBuilder: (context, index) {
              final order = pendingOrders[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["orderId"]} - ${order["customer"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Time: ${order["timeSlot"]}"),
                    Text("Total: \$${((order["totalAmount"] as double)).currency}"),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Assign",
                      size: bs.sm,
                      onPressed: () {
                        order["driver"] = driver["name"];
                        driver["currentDeliveries"] = (driver["currentDeliveries"] as int) + 1;
                        setState(() {});
                        back();
                        ss("Order assigned to ${driver["name"]}");
                      },
                    ),
                  ],
                ),
              );
            },
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

  void _showDriverSchedule(Map<String, dynamic> driver) {
    List<Map<String, dynamic>> driverDeliveries = scheduledDeliveries
        .where((delivery) => delivery["driver"] == driver["name"])
        .toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${driver["name"]}'s Schedule"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: driverDeliveries.isEmpty
              ? Center(
                  child: Text(
                    "No deliveries assigned",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                )
              : ListView.builder(
                  itemCount: driverDeliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = driverDeliveries[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${delivery["orderId"]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Customer: ${delivery["customer"]}"),
                          Text("Time: ${delivery["timeSlot"]}"),
                          Text(
                            "Status: ${delivery["status"]}".toUpperCase(),
                            style: TextStyle(
                              color: _getStatusColor("${delivery["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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

  void _startDelivery(Map<String, dynamic> delivery) {
    delivery["status"] = "in_progress";
    setState(() {});
    ss("Delivery started for ${delivery["orderId"]}");
  }

  Widget _buildSummaryCards() {
    int totalScheduled = scheduledDeliveries.where((d) => d["status"] == "scheduled").length;
    int totalInProgress = scheduledDeliveries.where((d) => d["status"] == "in_progress").length;
    int totalCompleted = scheduledDeliveries.where((d) => d["status"] == "completed").length;
    int totalDelayed = scheduledDeliveries.where((d) => d["status"] == "delayed").length;

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
                      "$totalScheduled",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Scheduled",
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
                      "$totalInProgress",
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
                      "$totalCompleted",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "$totalDelayed",
                      style: TextStyle(
                        fontSize: 24,
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
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery Scheduling",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Time Slots", icon: Icon(Icons.schedule)),
        Tab(text: "Deliveries", icon: Icon(Icons.local_shipping)),
        Tab(text: "Drivers", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        // Time Slots Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(),
              SizedBox(height: spMd),
              Text(
                "Time Slot Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...timeSlots.map((slot) => _buildTimeSlotCard(slot)),
            ],
          ),
        ),
        
        // Deliveries Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QTextField(
                label: "Search deliveries...",
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
                      label: "Time Slot",
                      items: timeSlotItems,
                      value: selectedTimeSlot,
                      onChanged: (value, label) {
                        selectedTimeSlot = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Driver",
                      items: driverItems,
                      value: selectedDriver,
                      onChanged: (value, label) {
                        selectedDriver = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: statusItems,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Text(
                "Scheduled Deliveries (${filteredDeliveries.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              if (filteredDeliveries.isEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "No deliveries found",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              else
                ...filteredDeliveries.map((delivery) => _buildDeliveryCard(delivery)),
            ],
          ),
        ),
        
        // Drivers Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Driver Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...drivers.map((driver) => _buildDriverCard(driver)),
            ],
          ),
        ),
      ],
    );
  }
}

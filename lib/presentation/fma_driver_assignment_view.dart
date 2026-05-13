import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDriverAssignmentView extends StatefulWidget {
  const FmaDriverAssignmentView({super.key});

  @override
  State<FmaDriverAssignmentView> createState() => _FmaDriverAssignmentViewState();
}

class _FmaDriverAssignmentViewState extends State<FmaDriverAssignmentView> {
  List<Map<String, dynamic>> drivers = [
    {
      "id": "D001",
      "name": "John Smith",
      "status": "Available",
      "vehicle": "Honda CRV",
      "license": "B1234567",
      "phone": "+1234567890",
      "rating": 4.8,
      "orders_completed": 145,
      "location": "Downtown",
      "zone": "Zone A",
      "image": "https://picsum.photos/80/80?random=1&keyword=man",
    },
    {
      "id": "D002",
      "name": "Sarah Johnson",
      "status": "On Delivery",
      "vehicle": "Toyota Camry",
      "license": "B2345678",
      "phone": "+1234567891",
      "rating": 4.9,
      "orders_completed": 203,
      "location": "Mall Area",
      "zone": "Zone B",
      "image": "https://picsum.photos/80/80?random=2&keyword=woman",
    },
    {
      "id": "D003",
      "name": "Mike Wilson",
      "status": "Break",
      "vehicle": "Ford Focus",
      "license": "B3456789",
      "phone": "+1234567892",
      "rating": 4.7,
      "orders_completed": 89,
      "location": "Shopping District",
      "zone": "Zone A",
      "image": "https://picsum.photos/80/80?random=3&keyword=man",
    },
    {
      "id": "D004",
      "name": "Emma Davis",
      "status": "Available",
      "vehicle": "Nissan Sentra",
      "license": "B4567890",
      "phone": "+1234567893",
      "rating": 4.6,
      "orders_completed": 167,
      "location": "Business Center",
      "zone": "Zone C",
      "image": "https://picsum.photos/80/80?random=4&keyword=woman",
    },
    {
      "id": "D005",
      "name": "David Brown",
      "status": "Offline",
      "vehicle": "Hyundai Elantra",
      "license": "B5678901",
      "phone": "+1234567894",
      "rating": 4.5,
      "orders_completed": 134,
      "location": "Residential Area",
      "zone": "Zone B",
      "image": "https://picsum.photos/80/80?random=5&keyword=man",
    },
  ];

  List<Map<String, dynamic>> pendingOrders = [
    {
      "id": "ORD001",
      "customer": "Alice Cooper",
      "address": "123 Main St, Downtown",
      "items": 3,
      "total": 45.90,
      "priority": "High",
      "pickup_time": "14:30",
      "delivery_time": "15:00",
      "distance": "2.5 km",
      "zone": "Zone A",
    },
    {
      "id": "ORD002",
      "customer": "Bob Johnson",
      "address": "456 Oak Ave, Mall Area",
      "items": 5,
      "total": 67.50,
      "priority": "Medium",
      "pickup_time": "15:00",
      "delivery_time": "15:45",
      "distance": "3.2 km",
      "zone": "Zone B",
    },
    {
      "id": "ORD003",
      "customer": "Carol Smith",
      "address": "789 Pine Rd, Business Center",
      "items": 2,
      "total": 28.75,
      "priority": "Low",
      "pickup_time": "15:30",
      "delivery_time": "16:15",
      "distance": "1.8 km",
      "zone": "Zone C",
    },
  ];

  String selectedZone = "All Zones";
  String selectedStatus = "All Status";
  String searchQuery = "";

  List<Map<String, dynamic>> zoneItems = [
    {"label": "All Zones", "value": "All Zones"},
    {"label": "Zone A", "value": "Zone A"},
    {"label": "Zone B", "value": "Zone B"},
    {"label": "Zone C", "value": "Zone C"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Available", "value": "Available"},
    {"label": "On Delivery", "value": "On Delivery"},
    {"label": "Break", "value": "Break"},
    {"label": "Offline", "value": "Offline"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "On Delivery":
        return primaryColor;
      case "Break":
        return warningColor;
      case "Offline":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredDrivers {
    return drivers.where((driver) {
      bool matchesZone = selectedZone == "All Zones" || driver["zone"] == selectedZone;
      bool matchesStatus = selectedStatus == "All Status" || driver["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (driver["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (driver["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesZone && matchesStatus && matchesSearch;
    }).toList();
  }

  void _assignDriver(String driverId, String orderId) {
    ss("Driver assigned successfully");
  }

  void _viewDriverDetails(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Driver Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${driver["image"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${driver["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ID: ${driver["id"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text("Vehicle: ${driver["vehicle"]}"),
            Text("License: ${driver["license"]}"),
            Text("Phone: ${driver["phone"]}"),
            Text("Location: ${driver["location"]}"),
            Text("Zone: ${driver["zone"]}"),
            Text("Rating: ${driver["rating"]} ⭐"),
            Text("Orders Completed: ${driver["orders_completed"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _assignOrder(String orderId, String driverId) {
    ss("Order ${orderId} assigned to driver ${driverId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Driver list refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Drivers",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${drivers.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${drivers.where((d) => d["status"] == "Available").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.local_shipping,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "On Delivery",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${drivers.where((d) => d["status"] == "On Delivery").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.pending_actions,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Pending Orders",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${pendingOrders.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Drivers",
                    value: searchQuery,
                    hint: "Search by name or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Zone",
                    items: zoneItems,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
            ),

            SizedBox(height: spLg),

            // Pending Orders Section
            Text(
              "Pending Orders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(pendingOrders.length, (index) {
                  final order = pendingOrders[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < pendingOrders.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${order["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${order["priority"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getPriorityColor("${order["priority"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${order["customer"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${order["address"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${order["items"]} items",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "\$${(order["total"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${order["distance"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Assign",
                          size: bs.sm,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Assign Driver"),
                                content: Text("Select a driver for order ${order["id"]}"),
                                actions: [
                                  QButton(
                                    label: "Cancel",
                                    size: bs.sm,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  QButton(
                                    label: "Assign",
                                    size: bs.sm,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _assignOrder("${order["id"]}", "D001");
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: spLg),

            // Drivers List
            Text(
              "Available Drivers (${filteredDrivers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(filteredDrivers.length, (index) {
                  final driver = filteredDrivers[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < filteredDrivers.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${driver["image"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${driver["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${driver["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${driver["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getStatusColor("${driver["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${driver["id"]} • ${driver["vehicle"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${driver["rating"]} ⭐",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${driver["orders_completed"]} orders",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${driver["zone"]}",
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
                        SizedBox(width: spSm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QButton(
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () => _viewDriverDetails(driver),
                            ),
                            SizedBox(width: spXs),
                            if (driver["status"] == "Available")
                              QButton(
                                label: "Assign",
                                size: bs.sm,
                                onPressed: () => _assignDriver("${driver["id"]}", "ORD001"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

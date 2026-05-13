import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDeliveryTrackingView extends StatefulWidget {
  const FmaDeliveryTrackingView({super.key});

  @override
  State<FmaDeliveryTrackingView> createState() => _FmaDeliveryTrackingViewState();
}

class _FmaDeliveryTrackingViewState extends State<FmaDeliveryTrackingView> {
  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL001",
      "order_id": "ORD001",
      "customer": "Alice Cooper",
      "address": "123 Main St, Downtown",
      "driver": "John Smith",
      "driver_phone": "+1234567890",
      "status": "In Transit",
      "priority": "High",
      "pickup_time": "14:30",
      "estimated_delivery": "15:00",
      "actual_delivery": null,
      "items": 3,
      "total": 45.90,
      "distance": "2.5 km",
      "progress": 65,
      "route_points": [
        {"lat": 37.7749, "lng": -122.4194, "title": "Restaurant", "completed": true},
        {"lat": 37.7849, "lng": -122.4094, "title": "Checkpoint 1", "completed": true},
        {"lat": 37.7949, "lng": -122.3994, "title": "Checkpoint 2", "completed": false},
        {"lat": 37.8049, "lng": -122.3894, "title": "Destination", "completed": false},
      ],
      "updates": [
        {"time": "14:30", "status": "Order picked up", "location": "Restaurant"},
        {"time": "14:45", "status": "En route to customer", "location": "Downtown"},
        {"time": "14:55", "status": "Approaching destination", "location": "Main St"},
      ],
    },
    {
      "id": "DEL002",
      "order_id": "ORD002",
      "customer": "Bob Johnson",
      "address": "456 Oak Ave, Mall Area",
      "driver": "Sarah Johnson",
      "driver_phone": "+1234567891",
      "status": "Delivered",
      "priority": "Medium",
      "pickup_time": "13:00",
      "estimated_delivery": "13:45",
      "actual_delivery": "13:42",
      "items": 5,
      "total": 67.50,
      "distance": "3.2 km",
      "progress": 100,
      "route_points": [
        {"lat": 37.7749, "lng": -122.4194, "title": "Restaurant", "completed": true},
        {"lat": 37.7849, "lng": -122.4094, "title": "Checkpoint 1", "completed": true},
        {"lat": 37.7949, "lng": -122.3994, "title": "Checkpoint 2", "completed": true},
        {"lat": 37.8049, "lng": -122.3894, "title": "Destination", "completed": true},
      ],
      "updates": [
        {"time": "13:00", "status": "Order picked up", "location": "Restaurant"},
        {"time": "13:20", "status": "En route to customer", "location": "Highway 101"},
        {"time": "13:40", "status": "Arrived at destination", "location": "Oak Ave"},
        {"time": "13:42", "status": "Order delivered", "location": "456 Oak Ave"},
      ],
    },
    {
      "id": "DEL003",
      "order_id": "ORD003",
      "customer": "Carol Smith",
      "address": "789 Pine Rd, Business Center",
      "driver": "Mike Wilson",
      "driver_phone": "+1234567892",
      "status": "Preparing",
      "priority": "Low",
      "pickup_time": "15:30",
      "estimated_delivery": "16:15",
      "actual_delivery": null,
      "items": 2,
      "total": 28.75,
      "distance": "1.8 km",
      "progress": 15,
      "route_points": [
        {"lat": 37.7749, "lng": -122.4194, "title": "Restaurant", "completed": false},
        {"lat": 37.7849, "lng": -122.4094, "title": "Checkpoint 1", "completed": false},
        {"lat": 37.7949, "lng": -122.3994, "title": "Destination", "completed": false},
      ],
      "updates": [
        {"time": "15:25", "status": "Order confirmed", "location": "Restaurant"},
        {"time": "15:28", "status": "Preparing order", "location": "Kitchen"},
      ],
    },
  ];

  String selectedStatus = "All Status";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Ready for Pickup", "value": "Ready for Pickup"},
    {"label": "Picked Up", "value": "Picked Up"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "In Transit":
        return primaryColor;
      case "Picked Up":
        return infoColor;
      case "Ready for Pickup":
        return warningColor;
      case "Preparing":
        return secondaryColor;
      case "Cancelled":
        return dangerColor;
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

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      bool matchesStatus = selectedStatus == "All Status" || delivery["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (delivery["customer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (delivery["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (delivery["order_id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesSearch;
    }).toList();
  }

  void _viewDeliveryDetails(Map<String, dynamic> delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Delivery Tracking - ${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${delivery["status"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: _getStatusColor("${delivery["status"]}").withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${delivery["customer"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${delivery["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${delivery["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${delivery["address"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text("Driver: ${delivery["driver"]}"),
                              Spacer(),
                              Text("${delivery["items"]} items"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Distance: ${delivery["distance"]}"),
                              Spacer(),
                              Text(
                                "\$${(delivery["total"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Progress Bar
                    Text(
                      "Delivery Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("${delivery["progress"]}% Complete"),
                              Spacer(),
                              Text(
                                "ETA: ${delivery["estimated_delivery"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (delivery["progress"] as int) / 100,
                            backgroundColor: disabledOutlineBorderColor,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Route Progress
                    Text(
                      "Route Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: List.generate((delivery["route_points"] as List).length, (index) {
                          final point = (delivery["route_points"] as List)[index];
                          final isCompleted = point["completed"] as bool;
                          final isLast = index == (delivery["route_points"] as List).length - 1;
                          
                          return Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isCompleted ? successColor : disabledOutlineBorderColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: isCompleted
                                        ? Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  if (!isLast)
                                    Container(
                                      width: 2,
                                      height: 30,
                                      color: isCompleted ? successColor : disabledOutlineBorderColor,
                                    ),
                                ],
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spXs),
                                  child: Text(
                                    "${point["title"]}",
                                    style: TextStyle(
                                      fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                                      color: isCompleted ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Status Updates
                    Text(
                      "Status Updates",
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
                        children: List.generate((delivery["updates"] as List).length, (index) {
                          final update = (delivery["updates"] as List)[index];
                          final isLast = index == (delivery["updates"] as List).length - 1;
                          
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: isLast ? Colors.transparent : disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${update["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${update["status"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${update["location"]}",
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
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Call Driver",
                            icon: Icons.phone,
                            size: bs.md,
                            onPressed: () {
                              ss("Calling ${delivery["driver"]}...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Send Message",
                            icon: Icons.message,
                            size: bs.md,
                            onPressed: () {
                              ss("Message sent to ${delivery["driver"]}");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshTracking() {
    ss("Tracking data refreshed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshTracking,
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
                            Icons.local_shipping,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Deliveries",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${deliveries.length}",
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
                            Icons.directions_run,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "In Transit",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${deliveries.where((d) => d["status"] == "In Transit").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                            "Delivered",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${deliveries.where((d) => d["status"] == "Delivered").length}",
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
                            Icons.schedule,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Preparing",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${deliveries.where((d) => d["status"] == "Preparing").length}",
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
                    label: "Search Deliveries",
                    value: searchQuery,
                    hint: "Search by customer, ID, or order",
                    onChanged: (value) {
                      searchQuery = value;
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

            // Deliveries List
            Text(
              "Active Deliveries (${filteredDeliveries.length})",
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
                children: List.generate(filteredDeliveries.length, (index) {
                  final delivery = filteredDeliveries[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < filteredDeliveries.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
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
                                        "${delivery["id"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${delivery["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${delivery["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStatusColor("${delivery["status"]}"),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${delivery["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${delivery["priority"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getPriorityColor("${delivery["priority"]}"),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${delivery["customer"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${delivery["address"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Driver: ${delivery["driver"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "ETA: ${delivery["estimated_delivery"]}",
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
                              label: "Track",
                              size: bs.sm,
                              onPressed: () => _viewDeliveryDetails(delivery),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        // Progress Bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress: ${delivery["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(delivery["total"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (delivery["progress"] as int) / 100,
                              backgroundColor: disabledOutlineBorderColor,
                              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor("${delivery["status"]}")),
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

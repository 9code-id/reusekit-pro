import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMap6View extends StatefulWidget {
  @override
  State<GrlMap6View> createState() => _GrlMap6ViewState();
}

class _GrlMap6ViewState extends State<GrlMap6View> {
  String selectedCategory = "all";
  bool loading = false;
  
  final List<Map<String, dynamic>> deliveryOrders = [
    {
      "id": "ORD001",
      "customerName": "John Smith",
      "address": "123 Main St, Downtown",
      "phone": "+1 555-0123",
      "orderTotal": 45.50,
      "status": "in_transit",
      "estimatedTime": "15 min",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "items": ["2x Pizza Margherita", "1x Coke", "1x Garlic Bread"],
      "distance": "0.8 km",
      "driverNotes": "Ring doorbell twice",
    },
    {
      "id": "ORD002",
      "customerName": "Sarah Johnson",
      "address": "456 Oak Ave, Mission",
      "phone": "+1 555-0456",
      "orderTotal": 32.75,
      "status": "pending",
      "estimatedTime": "25 min",
      "latitude": 37.7649,
      "longitude": -122.4094,
      "items": ["1x Burger Combo", "1x Fries", "1x Shake"],
      "distance": "1.2 km",
      "driverNotes": "Leave at door",
    },
    {
      "id": "ORD003",
      "customerName": "Mike Davis",
      "address": "789 Pine St, SOMA",
      "phone": "+1 555-0789",
      "orderTotal": 67.25,
      "status": "delivered",
      "estimatedTime": "Completed",
      "latitude": 37.7849,
      "longitude": -122.4294,
      "items": ["3x Sushi Rolls", "2x Miso Soup", "1x Green Tea"],
      "distance": "0.5 km",
      "driverNotes": "Customer paid tip in cash",
    },
    {
      "id": "ORD004",
      "customerName": "Emily Chen",
      "address": "321 Elm St, Castro",
      "phone": "+1 555-0321",
      "orderTotal": 28.90,
      "status": "preparing",
      "estimatedTime": "35 min",
      "latitude": 37.7549,
      "longitude": -122.4394,
      "items": ["1x Chicken Sandwich", "1x Salad", "1x Juice"],
      "distance": "2.1 km",
      "driverNotes": "Apartment 3B, use buzzer",
    },
  ];

  final List<Map<String, dynamic>> drivers = [
    {
      "id": 1,
      "name": "Alex Rodriguez",
      "phone": "+1 555-9001",
      "vehicle": "Honda Civic - ABC123",
      "status": "active",
      "currentOrder": "ORD001",
      "latitude": 37.7799,
      "longitude": -122.4144,
      "rating": 4.8,
      "completedToday": 12,
    },
    {
      "id": 2,
      "name": "Maria Santos",
      "phone": "+1 555-9002",
      "vehicle": "Toyota Prius - XYZ789",
      "status": "available",
      "currentOrder": null,
      "latitude": 37.7699,
      "longitude": -122.4244,
      "rating": 4.9,
      "completedToday": 8,
    },
    {
      "id": 3,
      "name": "David Kim",
      "phone": "+1 555-9003",
      "vehicle": "Ford Focus - DEF456",
      "status": "busy",
      "currentOrder": "ORD002",
      "latitude": 37.7599,
      "longitude": -122.4344,
      "rating": 4.7,
      "completedToday": 15,
    },
  ];

  Map<String, dynamic>? selectedOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ss("3 new delivery updates");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshData();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Delivery Status Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Status Overview
                Row(
                  children: [
                    _buildStatusCard("12", "Delivered", successColor),
                    SizedBox(width: spSm),
                    _buildStatusCard("3", "In Transit", primaryColor),
                    SizedBox(width: spSm),
                    _buildStatusCard("2", "Pending", warningColor),
                    SizedBox(width: spSm),
                    _buildStatusCard("1", "Preparing", infoColor),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Filter Buttons
                QHorizontalScroll(
                  children: [
                    _buildFilterChip("all", "All Orders", Icons.list_alt),
                    _buildFilterChip("pending", "Pending", Icons.schedule),
                    _buildFilterChip("preparing", "Preparing", Icons.restaurant),
                    _buildFilterChip("in_transit", "In Transit", Icons.local_shipping),
                    _buildFilterChip("delivered", "Delivered", Icons.check_circle),
                  ],
                ),
              ],
            ),
          ),
          
          // Delivery Map
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[50]!, Colors.green[50]!],
                ),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Center(
                    child: Text(
                      "Live Delivery Map",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  
                  // Delivery Markers
                  ...deliveryOrders.map((order) {
                    return Positioned(
                      left: ((order["longitude"] as double) + 122.4194) * 800,
                      top: (37.7749 - (order["latitude"] as double)) * 1500 + 120,
                      child: GestureDetector(
                        onTap: () {
                          _selectOrder(order);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getStatusColor("${order["status"]}"),
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              order["id"].toString().substring(3),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Driver Markers
                  ...drivers.map((driver) {
                    return Positioned(
                      left: ((driver["longitude"] as double) + 122.4194) * 800,
                      top: (37.7749 - (driver["latitude"] as double)) * 1500 + 120,
                      child: GestureDetector(
                        onTap: () {
                          _showDriverDetails(driver);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _getDriverStatusColor("${driver["status"]}"),
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Map Controls
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Column(
                      spacing: spSm,
                      children: [
                        _buildMapButton(Icons.add, () {
                          ss("Zoom in");
                        }),
                        _buildMapButton(Icons.remove, () {
                          ss("Zoom out");
                        }),
                        _buildMapButton(Icons.my_location, () {
                          ss("Center on restaurant");
                        }),
                      ],
                    ),
                  ),
                  
                  // Legend
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Legend",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          _buildLegendItem(primaryColor, "In Transit"),
                          _buildLegendItem(warningColor, "Pending"),
                          _buildLegendItem(successColor, "Delivered"),
                          _buildLegendItem(Colors.blue, "Drivers"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Order Details Panel
          if (selectedOrder != null)
            Container(
              height: 200,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                boxShadow: [shadowSm],
              ),
              child: _buildOrderDetails(selectedOrder!),
            ),
          
          // Order List
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Active Orders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${deliveryOrders.where((o) => o["status"] != "delivered").length} orders",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: deliveryOrders.length,
                      itemBuilder: (context, index) {
                        final order = deliveryOrders[index];
                        return _buildOrderCard(order);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label, IconData icon) {
    final isSelected = selectedCategory == value;
    return GestureDetector(
      onTap: () {
        selectedCategory = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: selectedOrder?["id"] == order["id"]
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          _selectOrder(order);
        },
        child: Row(
          children: [
            // Status Indicator
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: _getStatusColor("${order["status"]}"),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(width: spSm),
            
            // Order Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${order["id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${order["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusLabel("${order["status"]}"),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${order["customerName"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${order["address"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "\$${((order["orderTotal"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${order["estimatedTime"]}",
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
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails(Map<String, dynamic> order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Order ${order["id"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                selectedOrder = null;
                setState(() {});
              },
              child: Icon(
                Icons.close,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order["customerName"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${order["address"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Items: ${(order["items"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (order["driverNotes"] != null) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Notes: ${order["driverNotes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: spMd),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${((order["orderTotal"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${order["status"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _getStatusLabel("${order["status"]}"),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Call Customer",
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  ss("Calling ${order["customerName"]}");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Update Status",
                icon: Icons.update,
                size: bs.sm,
                onPressed: () {
                  _showStatusUpdateSheet(order);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "preparing":
        return infoColor;
      case "in_transit":
        return primaryColor;
      case "delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "preparing":
        return "Preparing";
      case "in_transit":
        return "In Transit";
      case "delivered":
        return "Delivered";
      default:
        return "Unknown";
    }
  }

  Color _getDriverStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "busy":
        return warningColor;
      case "available":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _selectOrder(Map<String, dynamic> order) {
    selectedOrder = order;
    setState(() {});
  }

  void _refreshData() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Delivery data updated");
    });
  }

  void _showDriverDetails(Map<String, dynamic> driver) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${driver["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text("Vehicle: ${driver["vehicle"]}"),
            Text("Rating: ${driver["rating"]} ⭐"),
            Text("Completed Today: ${driver["completedToday"]} orders"),
            if (driver["currentOrder"] != null)
              Text("Current Order: ${driver["currentOrder"]}"),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Call Driver",
                icon: Icons.phone,
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Calling ${driver["name"]}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateSheet(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update Order Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              title: Text("Mark as Preparing"),
              leading: Icon(Icons.restaurant, color: infoColor),
              onTap: () {
                back();
                ss("Order marked as preparing");
              },
            ),
            ListTile(
              title: Text("Mark as In Transit"),
              leading: Icon(Icons.local_shipping, color: primaryColor),
              onTap: () {
                back();
                ss("Order marked as in transit");
              },
            ),
            ListTile(
              title: Text("Mark as Delivered"),
              leading: Icon(Icons.check_circle, color: successColor),
              onTap: () {
                back();
                ss("Order marked as delivered");
              },
            ),
          ],
        ),
      ),
    );
  }
}

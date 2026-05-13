import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShipping8View extends StatefulWidget {
  @override
  State<GrlShipping8View> createState() => _GrlShipping8ViewState();
}

class _GrlShipping8ViewState extends State<GrlShipping8View> {
  String selectedFilter = 'active';
  String searchQuery = '';
  bool loading = false;

  List<Map<String, dynamic>> drivers = [
    {
      "id": "DR001",
      "name": "John Martinez",
      "phone": "+1 (555) 123-4567",
      "email": "john.martinez@shipping.com",
      "vehicleType": "Van",
      "vehicleNumber": "SH-001",
      "licenseNumber": "DL123456789",
      "status": "active",
      "currentLocation": "Downtown Hub",
      "rating": 4.8,
      "totalDeliveries": 1247,
      "onTimeDelivery": 96.5,
      "todayDeliveries": 12,
      "joinDate": DateTime(2023, 1, 15),
      "lastActive": DateTime.now().subtract(Duration(minutes: 5)),
      "earnings": {
        "today": 245.50,
        "week": 1567.80,
        "month": 6890.25,
      },
      "currentRoute": [
        {"address": "123 Oak St", "status": "delivered", "time": "09:30"},
        {"address": "456 Pine Ave", "status": "delivered", "time": "10:15"},
        {"address": "789 Elm Dr", "status": "in_progress", "time": "11:00"},
        {"address": "321 Maple Rd", "status": "pending", "time": "11:45"},
      ],
    },
    {
      "id": "DR002",
      "name": "Sarah Williams",
      "phone": "+1 (555) 234-5678",
      "email": "sarah.williams@shipping.com",
      "vehicleType": "Truck",
      "vehicleNumber": "SH-002",
      "licenseNumber": "DL987654321",
      "status": "on_delivery",
      "currentLocation": "Route 95, Mile 42",
      "rating": 4.9,
      "totalDeliveries": 2156,
      "onTimeDelivery": 98.2,
      "todayDeliveries": 8,
      "joinDate": DateTime(2022, 8, 3),
      "lastActive": DateTime.now().subtract(Duration(minutes: 2)),
      "earnings": {
        "today": 320.75,
        "week": 1890.40,
        "month": 7245.60,
      },
      "currentRoute": [
        {"address": "567 Cedar Ln", "status": "delivered", "time": "08:45"},
        {"address": "890 Birch St", "status": "delivered", "time": "09:30"},
        {"address": "234 Spruce Ct", "status": "in_progress", "time": "10:15"},
        {"address": "678 Fir Blvd", "status": "pending", "time": "11:30"},
        {"address": "345 Ash Way", "status": "pending", "time": "12:15"},
      ],
    },
    {
      "id": "DR003",
      "name": "Michael Chen",
      "phone": "+1 (555) 345-6789",
      "email": "michael.chen@shipping.com",
      "vehicleType": "Motorcycle",
      "vehicleNumber": "SH-003",
      "licenseNumber": "DL456789123",
      "status": "break",
      "currentLocation": "Central Station",
      "rating": 4.6,
      "totalDeliveries": 892,
      "onTimeDelivery": 94.8,
      "todayDeliveries": 15,
      "joinDate": DateTime(2023, 3, 20),
      "lastActive": DateTime.now().subtract(Duration(minutes: 15)),
      "earnings": {
        "today": 180.25,
        "week": 1245.60,
        "month": 5430.80,
      },
      "currentRoute": [
        {"address": "159 Willow Dr", "status": "delivered", "time": "08:00"},
        {"address": "753 Cherry Ave", "status": "delivered", "time": "08:30"},
        {"address": "951 Poplar St", "status": "delivered", "time": "09:15"},
      ],
    },
    {
      "id": "DR004",
      "name": "Emily Rodriguez",
      "phone": "+1 (555) 456-7890",
      "email": "emily.rodriguez@shipping.com",
      "vehicleType": "Van",
      "vehicleNumber": "SH-004",
      "licenseNumber": "DL789123456",
      "status": "offline",
      "currentLocation": "Home Base",
      "rating": 4.7,
      "totalDeliveries": 1678,
      "onTimeDelivery": 95.7,
      "todayDeliveries": 0,
      "joinDate": DateTime(2022, 11, 12),
      "lastActive": DateTime.now().subtract(Duration(hours: 18)),
      "earnings": {
        "today": 0.0,
        "week": 1423.90,
        "month": 6234.50,
      },
      "currentRoute": [],
    },
  ];

  List<Map<String, dynamic>> get filteredDrivers {
    return drivers.where((driver) {
      if (selectedFilter != 'all' && driver["status"] != selectedFilter) {
        return false;
      }
      if (searchQuery.isNotEmpty) {
        return driver["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               driver["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               driver["vehicleNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_road),
            onPressed: () {
              // navigateTo(AssignRouteView());
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // navigateTo(AddDriverView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${drivers.where((d) => d["status"] == "active" || d["status"] == "on_delivery").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active Drivers",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${drivers.map((d) => d["todayDeliveries"] as int).fold(0, (a, b) => a + b)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Today's Deliveries",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${(drivers.map((d) => (d["earnings"] as Map)["today"] as double).fold(0.0, (a, b) => a + b)).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Today's Earnings",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QTextField(
                          label: "Search drivers, ID, or vehicle",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: primaryColor),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: QHorizontalScroll(
              children: [
                'all', 'active', 'on_delivery', 'break', 'offline'
              ].map((filter) => Container(
                margin: EdgeInsets.only(right: spMd),
                child: GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: selectedFilter == filter ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      filter.toUpperCase().replaceAll('_', ' '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedFilter == filter ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Drivers List
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : filteredDrivers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: disabledBoldColor,
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "No drivers found",
                              style: TextStyle(
                                fontSize: fsH6,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: filteredDrivers.length,
                        itemBuilder: (context, index) {
                          final driver = filteredDrivers[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowMd],
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: _getStatusColor(driver["status"]),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Driver Header
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${(driver["name"] as String).split(' ').map((n) => n[0]).join('')}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                              fontSize: fsH6,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spMd),
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
                                              "ID: ${driver["id"]} • ${driver["vehicleType"]} ${driver["vehicleNumber"]}",
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
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(driver["status"]).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "${driver["status"]}".toUpperCase().replaceAll('_', ' '),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: _getStatusColor(driver["status"]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: spSm),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: warningColor,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${(driver["rating"] as double).toStringAsFixed(1)}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Driver Stats
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${driver["todayDeliveries"]}",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Text(
                                                "Today",
                                                style: TextStyle(
                                                  fontSize: 10,
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
                                            color: successColor.withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${(driver["onTimeDelivery"] as double).toStringAsFixed(1)}%",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: successColor,
                                                ),
                                              ),
                                              Text(
                                                "On Time",
                                                style: TextStyle(
                                                  fontSize: 10,
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
                                            color: warningColor.withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "\$${((driver["earnings"] as Map)["today"] as double).toStringAsFixed(0)}",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: warningColor,
                                                ),
                                              ),
                                              Text(
                                                "Earned",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Location and Last Active
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${driver["currentLocation"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        _getLastActiveText(driver["lastActive"]),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  // Current Route (if available)
                                  if ((driver["currentRoute"] as List).isNotEmpty) ...[
                                    SizedBox(height: spMd),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Route Progress",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
                                            ),
                                          ),
                                          SizedBox(height: spSm),
                                          ...(driver["currentRoute"] as List).take(3).map((stop) => 
                                            Padding(
                                              padding: EdgeInsets.only(bottom: spXs),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: _getRouteStatusColor(stop["status"]),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                  ),
                                                  SizedBox(width: spSm),
                                                  Expanded(
                                                    child: Text(
                                                      "${stop["address"]}",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: disabledBoldColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${stop["time"]}",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ).toList(),
                                          if ((driver["currentRoute"] as List).length > 3)
                                            Text(
                                              "+${(driver["currentRoute"] as List).length - 3} more stops",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: infoColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Contact",
                                          size: bs.sm,
                                          onPressed: () {
                                            _contactDriver(driver);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Track",
                                          size: bs.sm,
                                          onPressed: () {
                                            // navigateTo(TrackDriverView(driverId: driver["id"]));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.more_vert,
                                        size: bs.sm,
                                        onPressed: () {
                                          _showDriverOptions(driver);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddDriverView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'on_delivery':
        return infoColor;
      case 'break':
        return warningColor;
      case 'offline':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getRouteStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _getLastActiveText(DateTime lastActive) {
    final difference = DateTime.now().difference(lastActive);
    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  void _contactDriver(Map<String, dynamic> driver) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Contact ${driver["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.phone, color: primaryColor),
              title: Text("Call"),
              subtitle: Text("${driver["phone"]}"),
              onTap: () {
                back();
                ss("Calling ${driver["name"]}...");
              },
            ),
            ListTile(
              leading: Icon(Icons.message, color: primaryColor),
              title: Text("Send Message"),
              subtitle: Text("Send SMS or chat message"),
              onTap: () {
                back();
                // navigateTo(ChatView(driverId: driver["id"]));
              },
            ),
            ListTile(
              leading: Icon(Icons.email, color: primaryColor),
              title: Text("Email"),
              subtitle: Text("${driver["email"]}"),
              onTap: () {
                back();
                ss("Opening email app...");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDriverOptions(Map<String, dynamic> driver) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Driver Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Driver"),
              onTap: () {
                back();
                // navigateTo(EditDriverView(driver: driver));
              },
            ),
            ListTile(
              leading: Icon(Icons.route),
              title: Text("Assign Route"),
              onTap: () {
                back();
                // navigateTo(AssignRouteView(driverId: driver["id"]));
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("View History"),
              onTap: () {
                back();
                // navigateTo(DriverHistoryView(driverId: driver["id"]));
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: dangerColor),
              title: Text("Suspend Driver", style: TextStyle(color: dangerColor)),
              onTap: () async {
                back();
                bool isConfirmed = await confirm("Are you sure you want to suspend this driver?");
                if (isConfirmed) {
                  se("Driver suspended");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

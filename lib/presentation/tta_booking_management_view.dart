import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaBookingManagementView extends StatefulWidget {
  const TtaBookingManagementView({super.key});

  @override
  State<TtaBookingManagementView> createState() => _TtaBookingManagementViewState();
}

class _TtaBookingManagementViewState extends State<TtaBookingManagementView> {
  int currentTab = 0;

  List<Map<String, dynamic>> activeBookings = [
    {
      "id": "TRV001",
      "type": "Flight",
      "title": "New York to London",
      "airline": "British Airways",
      "flightNumber": "BA177",
      "date": "2024-06-25",
      "time": "08:30 AM",
      "status": "Confirmed",
      "price": 850.00,
      "image": "https://picsum.photos/60/60?random=1&keyword=airplane",
      "canModify": true,
      "canCancel": true,
      "modifiable": ["seat", "meal", "baggage"],
      "cancellationFee": 85.00,
      "refundAmount": 765.00,
      "deadline": "2024-06-20"
    },
    {
      "id": "HTL002",
      "type": "Hotel",
      "title": "Grand Hotel London",
      "location": "Westminster, London",
      "checkIn": "2024-06-25",
      "checkOut": "2024-06-30",
      "status": "Confirmed",
      "price": 1200.00,
      "image": "https://picsum.photos/60/60?random=2&keyword=hotel",
      "canModify": true,
      "canCancel": true,
      "modifiable": ["dates", "room", "guests"],
      "cancellationFee": 120.00,
      "refundAmount": 1080.00,
      "deadline": "2024-06-23"
    },
    {
      "id": "CAR003",
      "type": "Car Rental",
      "title": "BMW X3 Rental",
      "company": "Hertz",
      "pickUp": "2024-06-25",
      "dropOff": "2024-06-30",
      "status": "Confirmed",
      "price": 380.00,
      "image": "https://picsum.photos/60/60?random=3&keyword=car",
      "canModify": true,
      "canCancel": true,
      "modifiable": ["dates", "pickup_location", "vehicle"],
      "cancellationFee": 38.00,
      "refundAmount": 342.00,
      "deadline": "2024-06-22"
    },
    {
      "id": "ACT004",
      "type": "Activity",
      "title": "London Eye Experience",
      "operator": "London Eye Ltd",
      "date": "2024-06-27",
      "time": "02:00 PM",
      "status": "Confirmed",
      "price": 85.00,
      "image": "https://picsum.photos/60/60?random=4&keyword=londoneye",
      "canModify": false,
      "canCancel": true,
      "modifiable": [],
      "cancellationFee": 0.00,
      "refundAmount": 85.00,
      "deadline": "2024-06-26"
    },
  ];

  List<Map<String, dynamic>> pendingChanges = [
    {
      "id": "CHG001",
      "bookingId": "TRV001",
      "type": "Seat Change",
      "description": "Change seat from 12A to 15F",
      "status": "Pending Approval",
      "requestDate": "2024-06-15",
      "estimatedProcessing": "1-2 business days",
      "additionalCost": 25.00,
      "icon": Icons.airline_seat_recline_normal
    },
    {
      "id": "CHG002", 
      "bookingId": "HTL002",
      "type": "Date Change",
      "description": "Extend checkout from June 30 to July 2",
      "status": "Approved",
      "requestDate": "2024-06-14",
      "estimatedProcessing": "Completed",
      "additionalCost": 480.00,
      "icon": Icons.calendar_today
    },
    {
      "id": "CHG003",
      "bookingId": "CAR003",
      "type": "Vehicle Upgrade",
      "description": "Upgrade from BMW X3 to BMW X5",
      "status": "Rejected",
      "requestDate": "2024-06-13",
      "estimatedProcessing": "Completed",
      "additionalCost": 120.00,
      "rejectionReason": "Vehicle not available for selected dates",
      "icon": Icons.directions_car
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Check-in Online",
      "subtitle": "Available 24h before departure",
      "icon": Icons.flight_takeoff,
      "color": primaryColor
    },
    {
      "title": "Add Special Requests",
      "subtitle": "Meal preferences, accessibility",
      "icon": Icons.restaurant_menu,
      "color": successColor
    },
    {
      "title": "Travel Insurance",
      "subtitle": "Protect your trip",
      "icon": Icons.security,
      "color": warningColor
    },
    {
      "title": "Support Center",
      "subtitle": "24/7 customer support",
      "icon": Icons.support_agent,
      "color": infoColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Booking Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.bookmark)),
        Tab(text: "Changes", icon: Icon(Icons.edit)),
        Tab(text: "Quick Actions", icon: Icon(Icons.speed)),
      ],
      tabChildren: [
        _buildActiveBookingsTab(),
        _buildPendingChangesTab(),
        _buildQuickActionsTab(),
      ],
    );
  }

  Widget _buildActiveBookingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: primaryColor.withAlpha(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${activeBookings.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Active Bookings",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: successColor.withAlpha(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${activeBookings.fold(0.0, (sum, booking) => sum + (booking["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spLg),

          // Active Bookings List
          Text(
            "Manage Your Bookings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          Column(
            children: activeBookings.map((booking) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Booking Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getTypeColor(booking["type"] as String).withAlpha(20),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getTypeColor(booking["type"] as String),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getTypeIcon(booking["type"] as String),
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${booking["type"]} • ${booking["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${booking["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${booking["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Booking Details and Actions
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        children: [
                          // Basic Info
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(booking["date"] ?? booking["checkIn"] ?? booking["pickUp"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(booking["price"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Deadline",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(booking["deadline"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _isDeadlineNear(booking["deadline"] as String) 
                                            ? dangerColor 
                                            : disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spSm),

                          // Modification Options
                          if ((booking["modifiable"] as List).isNotEmpty) ...[
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Available Modifications:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Wrap(
                                    spacing: spXs,
                                    children: (booking["modifiable"] as List).map((mod) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${mod.toString().replaceAll('_', ' ').toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                          ],

                          // Action Buttons
                          Row(
                            children: [
                              if (booking["canModify"] as bool) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Modify",
                                    size: bs.sm,
                                    icon: Icons.edit,
                                    onPressed: () {
                                      _showModifyDialog(booking);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              if (booking["canCancel"] as bool) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Cancel",
                                    size: bs.sm,
                                    icon: Icons.cancel,
                                    color: dangerColor,
                                    onPressed: () {
                                      _showCancelDialog(booking);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              QButton(
                                label: "Details",
                                size: bs.sm,
                                icon: Icons.info,
                                color: infoColor,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingChangesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pending Changes (${pendingChanges.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          Column(
            children: pendingChanges.map((change) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: _getChangeStatusColor(change["status"] as String).withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getChangeStatusColor(change["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            change["icon"] as IconData,
                            color: _getChangeStatusColor(change["status"] as String),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${change["type"]} • ${change["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Booking ${change["bookingId"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
                            color: _getChangeStatusColor(change["status"] as String),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${change["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    Text(
                      "${change["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    SizedBox(height: spSm),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Requested: ${DateTime.parse(change["requestDate"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if ((change["additionalCost"] as double) > 0) ...[
                          Text(
                            "+\$${(change["additionalCost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: spXs),

                    Text(
                      "Processing: ${change["estimatedProcessing"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),

                    if (change["status"] == "Rejected") ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${change["rejectionReason"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    if (change["status"] == "Pending Approval") ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel Request",
                              size: bs.sm,
                              color: dangerColor,
                              onPressed: () async {
                                bool isConfirmed = await confirm("Are you sure you want to cancel this change request?");
                                if (isConfirmed) {
                                  pendingChanges.remove(change);
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "View Status",
                              size: bs.sm,
                              color: infoColor,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),

          if (pendingChanges.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Pending Changes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "All your booking modifications are up to date",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          Column(
            children: quickActions.map((action) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${action["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${action["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showModifyDialog(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modify Booking"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select what you'd like to modify:"),
            SizedBox(height: spSm),
            ...((booking["modifiable"] as List).map((option) {
              return ListTile(
                title: Text("${option.toString().replaceAll('_', ' ').toUpperCase()}"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to specific modification screen
                },
              );
            }).toList()),
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

  void _showCancelDialog(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Booking"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to cancel this booking?"),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Original Amount:"),
                      Spacer(),
                      Text("\$${(booking["price"] as double).currency}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Cancellation Fee:"),
                      Spacer(),
                      Text("-\$${(booking["cancellationFee"] as double).currency}"),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text("Refund Amount:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("\$${(booking["refundAmount"] as double).currency}", 
                           style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Keep Booking"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              bool isConfirmed = await confirm("Confirm cancellation? This action cannot be undone.");
              if (isConfirmed) {
                activeBookings.remove(booking);
                setState(() {});
                ss("Booking cancelled successfully");
              }
            },
            child: Text("Cancel Booking", style: TextStyle(color: dangerColor)),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Flight":
        return primaryColor;
      case "Hotel":
        return successColor;
      case "Car Rental":
        return warningColor;
      case "Activity":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Flight":
        return Icons.flight;
      case "Hotel":
        return Icons.hotel;
      case "Car Rental":
        return Icons.directions_car;
      case "Activity":
        return Icons.local_activity;
      default:
        return Icons.confirmation_number;
    }
  }

  Color _getChangeStatusColor(String status) {
    switch (status) {
      case "Pending Approval":
        return warningColor;
      case "Approved":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _isDeadlineNear(String deadline) {
    final deadlineDate = DateTime.parse(deadline);
    final now = DateTime.now();
    final difference = deadlineDate.difference(now).inDays;
    return difference <= 2;
  }
}

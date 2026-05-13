import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGroupBookingsView extends StatefulWidget {
  const HhaGroupBookingsView({super.key});

  @override
  State<HhaGroupBookingsView> createState() => _HhaGroupBookingsViewState();
}

class _HhaGroupBookingsViewState extends State<HhaGroupBookingsView> {
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> groupBookings = [
    {
      "id": "GB001",
      "groupName": "Corporate Annual Retreat",
      "company": "TechCorp Solutions",
      "contactPerson": "Sarah Johnson",
      "email": "sarah.johnson@techcorp.com",
      "phone": "+1-555-0123",
      "checkIn": "2024-07-15",
      "checkOut": "2024-07-18",
      "nights": 3,
      "totalGuests": 45,
      "rooms": 22,
      "roomTypes": {"Deluxe": 15, "Suite": 7},
      "totalAmount": 18750.0,
      "deposit": 5625.0,
      "status": "Confirmed",
      "specialRequests": ["Conference room setup", "Welcome reception", "Team building activities"],
      "bookingDate": "2024-05-20",
      "groupDiscount": 15,
    },
    {
      "id": "GB002", 
      "groupName": "Wedding Party",
      "company": "Johnson-Williams Wedding",
      "contactPerson": "Michael Johnson",
      "email": "m.johnson@email.com",
      "phone": "+1-555-0456",
      "checkIn": "2024-08-10",
      "checkOut": "2024-08-12",
      "nights": 2,
      "totalGuests": 28,
      "rooms": 14,
      "roomTypes": {"Bridal Suite": 1, "Deluxe": 10, "Standard": 3},
      "totalAmount": 12600.0,
      "deposit": 3780.0,
      "status": "Pending",
      "specialRequests": ["Bridal suite decoration", "Late checkout", "Wedding cake storage"],
      "bookingDate": "2024-06-01",
      "groupDiscount": 12,
    },
    {
      "id": "GB003",
      "groupName": "Medical Conference",
      "company": "International Medical Association",
      "contactPerson": "Dr. Emily Chen",
      "email": "e.chen@medassoc.org",
      "phone": "+1-555-0789",
      "checkIn": "2024-09-05",
      "checkOut": "2024-09-08",
      "nights": 3,
      "totalGuests": 120,
      "rooms": 60,
      "roomTypes": {"Standard": 45, "Deluxe": 15},
      "totalAmount": 32400.0,
      "deposit": 9720.0,
      "status": "Confirmed",
      "specialRequests": ["Conference facilities", "A/V equipment", "Coffee breaks"],
      "bookingDate": "2024-04-15",
      "groupDiscount": 20,
    },
    {
      "id": "GB004",
      "groupName": "Sports Team Tournament",
      "company": "Regional Basketball League",
      "contactPerson": "Coach Mike Davis",
      "email": "coach.davis@rbl.com",
      "phone": "+1-555-0321",
      "checkIn": "2024-06-20",
      "checkOut": "2024-06-23",
      "nights": 3,
      "totalGuests": 35,
      "rooms": 18,
      "roomTypes": {"Standard": 16, "Coach Suite": 2},
      "totalAmount": 8925.0,
      "deposit": 2677.5,
      "status": "Completed",
      "specialRequests": ["Early breakfast", "Equipment storage", "Team meeting room"],
      "bookingDate": "2024-03-10",
      "groupDiscount": 18,
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    return groupBookings.where((booking) {
      final matchesStatus = selectedStatus == "All" || booking["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty ||
          (booking["groupName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (booking["company"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking["id"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Completed":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Bookings"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateGroupBookingView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Summary
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Bookings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${groupBookings.length}",
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Guests",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${groupBookings.fold(0, (sum, booking) => sum + (booking["totalGuests"] as int))}",
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((groupBookings.fold(0.0, (sum, booking) => sum + (booking["totalAmount"] as double))) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search bookings...",
                    value: searchQuery,
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
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Confirmed", "value": "Confirmed"},
                      {"label": "Pending", "value": "Pending"},
                      {"label": "Completed", "value": "Completed"},
                      {"label": "Cancelled", "value": "Cancelled"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Bookings List
            ...filteredBookings.map((booking) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${booking["groupName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${booking["company"]}",
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
                              color: getStatusColor(booking["status"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${booking["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Booking ID and Date
                      Row(
                        children: [
                          Text(
                            "ID: ${booking["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Booked: ${booking["bookingDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Contact Info
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${booking["contactPerson"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${booking["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${booking["phone"]}",
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

                      // Stay Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Check-in",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["checkIn"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                                  "Check-out",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["checkOut"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                                  "Nights",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["nights"]}",
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

                      // Group Stats
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Guests",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["totalGuests"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                  "Rooms",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["rooms"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                  "Discount",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${booking["groupDiscount"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Financial Info
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((booking["totalAmount"] as double) / 1000).toStringAsFixed(1)}K",
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
                                    "Deposit Paid",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((booking["deposit"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Special Requests
                      if ((booking["specialRequests"] as List).isNotEmpty) ...[
                        Text(
                          "Special Requests:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        ...(booking["specialRequests"] as List<String>).map((request) {
                          return Padding(
                            padding: EdgeInsets.only(left: spSm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    request,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('GroupBookingDetailView', arguments: booking)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Edit",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('EditGroupBookingView', arguments: booking)
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

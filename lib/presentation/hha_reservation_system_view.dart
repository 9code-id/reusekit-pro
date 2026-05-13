import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaReservationSystemView extends StatefulWidget {
  const HhaReservationSystemView({super.key});

  @override
  State<HhaReservationSystemView> createState() => _HhaReservationSystemViewState();
}

class _HhaReservationSystemViewState extends State<HhaReservationSystemView> {
  int currentTab = 0;
  String selectedStatus = "all";
  String selectedRoomType = "all";
  String selectedDateRange = "today";
  String searchQuery = "";

  List<Map<String, dynamic>> reservations = [
    {
      "id": "RES001",
      "confirmationNumber": "HTL2024001",
      "guestName": "John Smith",
      "guestEmail": "john.smith@email.com",
      "guestPhone": "+1-555-0123",
      "roomNumber": "205",
      "roomType": "Deluxe",
      "floor": 2,
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-18",
      "nights": 3,
      "guests": 2,
      "status": "confirmed",
      "totalAmount": 450.0,
      "paidAmount": 450.0,
      "paymentStatus": "paid",
      "bookingDate": "2024-06-10",
      "specialRequests": "Late check-in after 10 PM",
      "source": "website",
      "loyaltyMember": true,
      "vip": false
    },
    {
      "id": "RES002",
      "confirmationNumber": "HTL2024002",
      "guestName": "Sarah Johnson",
      "guestEmail": "sarah.j@email.com",
      "guestPhone": "+1-555-0456",
      "roomNumber": "312",
      "roomType": "Suite",
      "floor": 3,
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-16",
      "nights": 1,
      "guests": 1,
      "status": "checked_in",
      "totalAmount": 280.0,
      "paidAmount": 280.0,
      "paymentStatus": "paid",
      "bookingDate": "2024-06-12",
      "specialRequests": "Room with city view",
      "source": "phone",
      "loyaltyMember": false,
      "vip": true
    },
    {
      "id": "RES003",
      "confirmationNumber": "HTL2024003",
      "guestName": "Michael Brown",
      "guestEmail": "m.brown@email.com",
      "guestPhone": "+1-555-0789",
      "roomNumber": "418",
      "roomType": "Executive",
      "floor": 4,
      "checkInDate": "2024-06-16",
      "checkOutDate": "2024-06-20",
      "nights": 4,
      "guests": 2,
      "status": "pending",
      "totalAmount": 720.0,
      "paidAmount": 360.0,
      "paymentStatus": "partial",
      "bookingDate": "2024-06-14",
      "specialRequests": "Extra towels and pillows",
      "source": "booking_com",
      "loyaltyMember": true,
      "vip": false
    },
    {
      "id": "RES004",
      "confirmationNumber": "HTL2024004",
      "guestName": "Emily Davis",
      "guestEmail": "emily.davis@email.com",
      "guestPhone": "+1-555-0321",
      "roomNumber": "523",
      "roomType": "Presidential",
      "floor": 5,
      "checkInDate": "2024-06-17",
      "checkOutDate": "2024-06-19",
      "nights": 2,
      "guests": 4,
      "status": "cancelled",
      "totalAmount": 800.0,
      "paidAmount": 0.0,
      "paymentStatus": "refunded",
      "bookingDate": "2024-06-08",
      "specialRequests": "Anniversary celebration setup",
      "source": "expedia",
      "loyaltyMember": false,
      "vip": true
    },
    {
      "id": "RES005",
      "confirmationNumber": "HTL2024005",
      "guestName": "David Wilson",
      "guestEmail": "d.wilson@email.com",
      "guestPhone": "+1-555-0654",
      "roomNumber": "101",
      "roomType": "Standard",
      "floor": 1,
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-17",
      "nights": 2,
      "guests": 1,
      "status": "checked_out",
      "totalAmount": 200.0,
      "paidAmount": 200.0,
      "paymentStatus": "paid",
      "bookingDate": "2024-06-13",
      "specialRequests": "",
      "source": "walk_in",
      "loyaltyMember": false,
      "vip": false
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Checked In", "value": "checked_in"},
    {"label": "Checked Out", "value": "checked_out"},
    {"label": "Pending", "value": "pending"},
    {"label": "Cancelled", "value": "cancelled"}
  ];

  List<Map<String, dynamic>> roomTypeOptions = [
    {"label": "All Room Types", "value": "all"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Deluxe", "value": "Deluxe"},
    {"label": "Suite", "value": "Suite"},
    {"label": "Executive", "value": "Executive"},
    {"label": "Presidential", "value": "Presidential"}
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "All Dates", "value": "all"}
  ];

  List<Map<String, dynamic>> get filteredReservations {
    return reservations.where((reservation) {
      bool matchesStatus = selectedStatus == "all" || reservation["status"] == selectedStatus;
      bool matchesRoomType = selectedRoomType == "all" || reservation["roomType"] == selectedRoomType;
      bool matchesSearch = searchQuery.isEmpty || 
          (reservation["guestName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (reservation["confirmationNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          reservation["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesRoomType && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'checked_in':
        return infoColor;
      case 'checked_out':
        return primaryColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPaymentStatusColor(String paymentStatus) {
    switch (paymentStatus) {
      case 'paid':
        return successColor;
      case 'partial':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'refunded':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reservation System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Reservations", icon: Icon(Icons.book)),
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Check-ins", icon: Icon(Icons.login)),
        Tab(text: "Check-outs", icon: Icon(Icons.logout)),
      ],
      tabChildren: [
        _buildAllReservationsTab(),
        _buildTodayTab(),
        _buildCheckInsTab(),
        _buildCheckOutsTab(),
      ],
    );
  }

  Widget _buildAllReservationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search guests, confirmation, or room...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          // Filter Options
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Room Type",
                items: roomTypeOptions,
                value: selectedRoomType,
                onChanged: (value, label) {
                  selectedRoomType = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Date Range",
                items: dateRangeOptions,
                value: selectedDateRange,
                onChanged: (value, label) {
                  selectedDateRange = value;
                  setState(() {});
                },
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Reservations",
                "${reservations.length}",
                Icons.book,
                primaryColor,
              ),
              _buildSummaryCard(
                "Confirmed",
                "${reservations.where((r) => r["status"] == "confirmed").length}",
                Icons.check_circle,
                successColor,
              ),
              _buildSummaryCard(
                "Checked In",
                "${reservations.where((r) => r["status"] == "checked_in").length}",
                Icons.login,
                infoColor,
              ),
              _buildSummaryCard(
                "Revenue",
                "\$${reservations.fold(0.0, (sum, item) => sum + (item["totalAmount"] as double)).toStringAsFixed(0)}",
                Icons.attach_money,
                successColor,
              ),
            ],
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
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
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "New Reservation",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          // Create new reservation
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Walk-in Check-in",
                        icon: Icons.person_add,
                        size: bs.sm,
                        onPressed: () {
                          // Walk-in check-in
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reservation List
          ...filteredReservations.map((reservation) => _buildReservationCard(reservation)),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    List<Map<String, dynamic>> todayReservations = reservations.where((reservation) => 
        reservation["checkInDate"] == "2024-06-15" || 
        reservation["checkOutDate"] == "2024-06-15"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Today's Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.today, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${todayReservations.length} reservations for today",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Check-in/Check-out Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.login, color: infoColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${todayReservations.where((r) => r["checkInDate"] == "2024-06-15").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Check-ins Today",
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.logout, color: warningColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${todayReservations.where((r) => r["checkOutDate"] == "2024-06-15").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Check-outs Today",
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

          // Today's Reservations
          ...todayReservations.map((reservation) => _buildTodayReservationCard(reservation)),
        ],
      ),
    );
  }

  Widget _buildCheckInsTab() {
    List<Map<String, dynamic>> checkInReservations = reservations.where((reservation) => 
        reservation["checkInDate"] == "2024-06-15" && reservation["status"] != "checked_in"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Check-in Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.login, color: infoColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expected Check-ins",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${checkInReservations.length} guests arriving today",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Check All",
                  size: bs.sm,
                  onPressed: () {
                    // Check in all guests
                  },
                ),
              ],
            ),
          ),

          // Check-in Reservations
          ...checkInReservations.map((reservation) => _buildCheckInCard(reservation)),
        ],
      ),
    );
  }

  Widget _buildCheckOutsTab() {
    List<Map<String, dynamic>> checkOutReservations = reservations.where((reservation) => 
        reservation["checkOutDate"] == "2024-06-15" && 
        (reservation["status"] == "checked_in" || reservation["status"] == "confirmed")
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Check-out Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.logout, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expected Check-outs",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${checkOutReservations.length} guests departing today",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Process All",
                  size: bs.sm,
                  onPressed: () {
                    // Process all check-outs
                  },
                ),
              ],
            ),
          ),

          // Check-out Reservations
          ...checkOutReservations.map((reservation) => _buildCheckOutCard(reservation)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> reservation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(reservation["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reservation["guestName"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(reservation["status"]),
                  ),
                ),
              ),
              if (reservation["vip"] as bool)
                Container(
                  margin: EdgeInsets.only(left: spXs),
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "VIP",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(reservation["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reservation["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(reservation["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Reservation Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room ${reservation["roomNumber"]} • ${reservation["roomType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Confirmation: ${reservation["confirmationNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${reservation["checkInDate"]} - ${reservation["checkOutDate"]} (${reservation["nights"]} nights)",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(reservation["totalAmount"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPaymentStatusColor(reservation["paymentStatus"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${reservation["paymentStatus"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPaymentStatusColor(reservation["paymentStatus"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Contact Information
          Row(
            children: [
              Icon(Icons.email, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${reservation["guestEmail"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.phone, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${reservation["guestPhone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Special Requests
          if (reservation["specialRequests"] != null && (reservation["specialRequests"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${reservation["specialRequests"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showReservationDetails(reservation);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit reservation
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Show more options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayReservationCard(Map<String, dynamic> reservation) {
    bool isCheckIn = reservation["checkInDate"] == "2024-06-15";
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: isCheckIn ? infoColor.withAlpha(60) : warningColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                isCheckIn ? Icons.login : Icons.logout,
                color: isCheckIn ? infoColor : warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${reservation["guestName"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: isCheckIn ? infoColor : warningColor,
                ),
              ),
              Spacer(),
              Text(
                isCheckIn ? "CHECK-IN" : "CHECK-OUT",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isCheckIn ? infoColor : warningColor,
                ),
              ),
            ],
          ),

          Text(
            "Room ${reservation["roomNumber"]} • ${reservation["roomType"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Text(
                  "${reservation["guests"]} guest${reservation["guests"] > 1 ? 's' : ''} • ${reservation["nights"]} night${reservation["nights"] > 1 ? 's' : ''}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(reservation["totalAmount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isCheckIn ? "Check In" : "Check Out",
                  size: bs.sm,
                  onPressed: () {
                    // Process check-in/check-out
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  // Contact guest
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInCard(Map<String, dynamic> reservation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: infoColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.login, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${reservation["guestName"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              if (reservation["vip"] as bool)
                Container(
                  margin: EdgeInsets.only(left: spXs),
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "VIP",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                "Room ${reservation["roomNumber"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${reservation["roomType"]} • ${reservation["nights"]} nights",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${reservation["guests"]} guest${reservation["guests"] > 1 ? 's' : ''}",
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
                    "\$${(reservation["totalAmount"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPaymentStatusColor(reservation["paymentStatus"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${reservation["paymentStatus"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPaymentStatusColor(reservation["paymentStatus"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (reservation["specialRequests"] != null && (reservation["specialRequests"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${reservation["specialRequests"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Check In Guest",
                  size: bs.sm,
                  onPressed: () {
                    // Process check-in
                    ss("Guest checked in successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  // Call guest
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckOutCard(Map<String, dynamic> reservation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.logout, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${reservation["guestName"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Text(
                "Room ${reservation["roomNumber"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Text(
            "${reservation["roomType"]} • Stayed ${reservation["nights"]} nights",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Row(
            children: [
              Text(
                "Total Bill: \$${(reservation["totalAmount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPaymentStatusColor(reservation["paymentStatus"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reservation["paymentStatus"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPaymentStatusColor(reservation["paymentStatus"]),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Process Check-out",
                  size: bs.sm,
                  onPressed: () {
                    // Process check-out
                    ss("Guest checked out successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.receipt,
                size: bs.sm,
                onPressed: () {
                  // Generate invoice
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReservationDetails(Map<String, dynamic> reservation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Reservation Details",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spSm,
                  children: [
                    _buildDetailRow("Guest Name", "${reservation["guestName"]}"),
                    _buildDetailRow("Confirmation", "${reservation["confirmationNumber"]}"),
                    _buildDetailRow("Room", "${reservation["roomNumber"]} - ${reservation["roomType"]}"),
                    _buildDetailRow("Check-in", "${reservation["checkInDate"]}"),
                    _buildDetailRow("Check-out", "${reservation["checkOutDate"]}"),
                    _buildDetailRow("Nights", "${reservation["nights"]}"),
                    _buildDetailRow("Guests", "${reservation["guests"]}"),
                    _buildDetailRow("Status", "${reservation["status"]}"),
                    _buildDetailRow("Total Amount", "\$${(reservation["totalAmount"] as double).toStringAsFixed(2)}"),
                    _buildDetailRow("Payment Status", "${reservation["paymentStatus"]}"),
                    _buildDetailRow("Email", "${reservation["guestEmail"]}"),
                    _buildDetailRow("Phone", "${reservation["guestPhone"]}"),
                    _buildDetailRow("Booking Source", "${reservation["source"]}"),
                    if (reservation["specialRequests"] != null && (reservation["specialRequests"] as String).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Special Requests",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reservation["specialRequests"]}",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaReservationView extends StatefulWidget {
  const RmaReservationView({super.key});

  @override
  State<RmaReservationView> createState() => _RmaReservationViewState();
}

class _RmaReservationViewState extends State<RmaReservationView> {
  String selectedStatus = "all";
  String dateFilter = "today";
  String searchQuery = "";
  bool showDetails = false;
  
  List<Map<String, dynamic>> reservations = [
    {
      "id": "RES-001",
      "customerName": "Sarah Johnson",
      "customerPhone": "+1-555-0123",
      "customerEmail": "sarah.johnson@email.com",
      "partySize": 4,
      "reservationDate": "2024-03-15",
      "reservationTime": "19:30",
      "tableNumber": "T-12",
      "status": "confirmed",
      "specialRequests": "Birthday celebration",
      "notes": "Vegetarian options needed",
      "createdAt": "2024-03-14 10:30:00",
      "staffAssigned": "Emma Wilson",
      "deposit": 50.00,
      "estimatedDuration": 120,
    },
    {
      "id": "RES-002",
      "customerName": "Michael Brown",
      "customerPhone": "+1-555-0456",
      "customerEmail": "michael.brown@email.com",
      "partySize": 2,
      "reservationDate": "2024-03-15",
      "reservationTime": "18:00",
      "tableNumber": "T-05",
      "status": "pending",
      "specialRequests": "Window seat",
      "notes": "Anniversary dinner",
      "createdAt": "2024-03-15 08:15:00",
      "staffAssigned": "John Smith",
      "deposit": 0.00,
      "estimatedDuration": 90,
    },
    {
      "id": "RES-003",
      "customerName": "Lisa Davis",
      "customerPhone": "+1-555-0789",
      "customerEmail": "lisa.davis@email.com",
      "partySize": 6,
      "reservationDate": "2024-03-15",
      "reservationTime": "20:00",
      "tableNumber": "T-18",
      "status": "confirmed",
      "specialRequests": "High chair for baby",
      "notes": "Family dinner",
      "createdAt": "2024-03-13 14:20:00",
      "staffAssigned": "Mike Wilson",
      "deposit": 75.00,
      "estimatedDuration": 150,
    },
    {
      "id": "RES-004",
      "customerName": "David Chen",
      "customerPhone": "+1-555-0321",
      "customerEmail": "david.chen@email.com",
      "partySize": 8,
      "reservationDate": "2024-03-16",
      "reservationTime": "19:00",
      "tableNumber": "T-22",
      "status": "cancelled",
      "specialRequests": "Private dining area",
      "notes": "Business meeting",
      "createdAt": "2024-03-12 16:45:00",
      "staffAssigned": "Sarah Davis",
      "deposit": 100.00,
      "estimatedDuration": 180,
    },
    {
      "id": "RES-005",
      "customerName": "Amy White",
      "customerPhone": "+1-555-0654",
      "customerEmail": "amy.white@email.com",
      "partySize": 3,
      "reservationDate": "2024-03-15",
      "reservationTime": "17:30",
      "tableNumber": "T-08",
      "status": "seated",
      "specialRequests": "Allergy-friendly menu",
      "notes": "Gluten-free requirements",
      "createdAt": "2024-03-15 09:30:00",
      "staffAssigned": "Emma Wilson",
      "deposit": 25.00,
      "estimatedDuration": 105,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Reservations", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Seated", "value": "seated"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
    {"label": "No Show", "value": "no_show"},
  ];

  List<Map<String, dynamic>> dateOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "week"},
    {"label": "Next Week", "value": "next_week"},
  ];

  Widget _buildReservationStats() {
    final totalReservations = reservations.length;
    final confirmedReservations = reservations.where((r) => r["status"] == "confirmed").length;
    final pendingReservations = reservations.where((r) => r["status"] == "pending").length;
    final totalGuests = reservations.map((r) => r["partySize"] as int).reduce((a, b) => a + b);
    
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
          Text(
            "Reservation Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Reservations",
                "$totalReservations",
                Icons.event,
                primaryColor,
              ),
              _buildStatCard(
                "Confirmed",
                "$confirmedReservations",
                Icons.check_circle,
                successColor,
              ),
              _buildStatCard(
                "Pending",
                "$pendingReservations",
                Icons.pending,
                warningColor,
              ),
              _buildStatCard(
                "Total Guests",
                "$totalGuests",
                Icons.people,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Reservations",
                  value: searchQuery,
                  hint: "Customer name, phone, or email",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
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
                  label: "Date Filter",
                  items: dateOptions,
                  value: dateFilter,
                  onChanged: (value, label) {
                    dateFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Details",
                      "value": true,
                      "checked": showDetails,
                    }
                  ],
                  value: [
                    if (showDetails)
                      {
                        "label": "Show Details",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> reservation) {
    final statusColor = reservation["status"] == "confirmed" ? successColor :
                       reservation["status"] == "pending" ? warningColor :
                       reservation["status"] == "seated" ? infoColor :
                       reservation["status"] == "cancelled" ? dangerColor :
                       disabledBoldColor;

    final statusIcon = reservation["status"] == "confirmed" ? Icons.check_circle :
                      reservation["status"] == "pending" ? Icons.pending :
                      reservation["status"] == "seated" ? Icons.event_seat :
                      reservation["status"] == "cancelled" ? Icons.cancel :
                      Icons.people;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                    Row(
                      children: [
                        Text(
                          "${reservation["customerName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, color: statusColor, size: 12),
                              SizedBox(width: spXs),
                              Text(
                                "${reservation["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.people, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${reservation["partySize"]} guests",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.table_restaurant, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${reservation["tableNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
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
                  Text(
                    "${reservation["reservationTime"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${reservation["reservationDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
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
                        Icon(Icons.phone, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${reservation["customerPhone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (reservation["specialRequests"] != null && reservation["specialRequests"] != "") ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.info, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${reservation["specialRequests"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if ((reservation["deposit"] as double) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.payment, color: successColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "\$${((reservation["deposit"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (showDetails) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Additional Details:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Staff: ${reservation["staffAssigned"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.email, color: infoColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${reservation["customerEmail"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.timer, color: primaryColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "Duration: ${reservation["estimatedDuration"]} min",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (reservation["notes"] != null && reservation["notes"] != "") ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, color: warningColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${reservation["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EditReservation')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.check,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ConfirmReservation')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CallCustomer')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CancelReservation')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredReservations {
    List<Map<String, dynamic>> filtered = List.from(reservations);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((reservation) {
        final name = "${reservation["customerName"]}".toLowerCase();
        final phone = "${reservation["customerPhone"]}".toLowerCase();
        final email = "${reservation["customerEmail"]}".toLowerCase();
        final query = searchQuery.toLowerCase();
        return name.contains(query) || phone.contains(query) || email.contains(query);
      }).toList();
    }
    
    // Apply status filter
    if (selectedStatus != "all") {
      filtered = filtered.where((reservation) => reservation["status"] == selectedStatus).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservations"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateReservation')
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //navigateTo('ReservationCalendar')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildReservationStats(),
            _buildFilters(),
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
                  Row(
                    children: [
                      Text(
                        "Reservations (${filteredReservations.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Reservation",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('CreateReservation')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredReservations.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No reservations found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredReservations.map((reservation) => _buildReservationCard(reservation)).toList(),
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

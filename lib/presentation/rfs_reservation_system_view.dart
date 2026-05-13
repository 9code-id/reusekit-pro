import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsReservationSystemView extends StatefulWidget {
  const RfsReservationSystemView({super.key});

  @override
  State<RfsReservationSystemView> createState() => _RfsReservationSystemViewState();
}

class _RfsReservationSystemViewState extends State<RfsReservationSystemView> {
  int currentTab = 0;
  String selectedDateFilter = "Today";
  String selectedStatusFilter = "All";

  List<Map<String, dynamic>> dateFilters = [
    {"label": "Today", "value": "Today"},
    {"label": "Tomorrow", "value": "Tomorrow"},
    {"label": "This Week", "value": "This Week"},
    {"label": "All Upcoming", "value": "All Upcoming"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Reservations", "value": "All"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Completed", "value": "Completed"},
    {"label": "No Show", "value": "No Show"},
  ];

  List<Map<String, dynamic>> reservations = [
    {
      "id": "RES001",
      "guestName": "John Smith",
      "phone": "+1 234-567-8901",
      "email": "john.smith@email.com",
      "partySize": 4,
      "date": "2025-06-19",
      "time": "7:30 PM",
      "status": "Confirmed",
      "tableNumber": "12",
      "specialRequests": "Window table preferred",
      "createdDate": "2025-06-18",
      "source": "Phone",
      "deposit": 50.0,
    },
    {
      "id": "RES002",
      "guestName": "Sarah Johnson",
      "phone": "+1 234-567-8902",
      "email": "sarah.j@email.com",
      "partySize": 2,
      "date": "2025-06-19",
      "time": "8:00 PM",
      "status": "Pending",
      "tableNumber": null,
      "specialRequests": "Anniversary dinner",
      "createdDate": "2025-06-19",
      "source": "Online",
      "deposit": 0.0,
    },
    {
      "id": "RES003",
      "guestName": "Michael Davis",
      "phone": "+1 234-567-8903",
      "email": "m.davis@email.com",
      "partySize": 8,
      "date": "2025-06-20",
      "time": "6:00 PM",
      "status": "Confirmed",
      "tableNumber": "VIP-1",
      "specialRequests": "Business dinner, quiet area",
      "createdDate": "2025-06-15",
      "source": "Phone",
      "deposit": 100.0,
    },
    {
      "id": "RES004",
      "guestName": "Emily Brown",
      "phone": "+1 234-567-8904",
      "email": "emily.brown@email.com",
      "partySize": 6,
      "date": "2025-06-19",
      "time": "7:00 PM",
      "status": "Cancelled",
      "tableNumber": null,
      "specialRequests": "Birthday celebration",
      "createdDate": "2025-06-17",
      "source": "Online",
      "deposit": 0.0,
    },
    {
      "id": "RES005",
      "guestName": "David Wilson",
      "phone": "+1 234-567-8905",
      "email": "david.w@email.com",
      "partySize": 3,
      "date": "2025-06-18",
      "time": "8:30 PM",
      "status": "Completed",
      "tableNumber": "8",
      "specialRequests": null,
      "createdDate": "2025-06-18",
      "source": "Walk-in",
      "deposit": 0.0,
    },
  ];

  List<Map<String, dynamic>> get filteredReservations {
    return reservations.where((reservation) {
      bool matchesDate = true;
      if (selectedDateFilter == "Today") {
        matchesDate = reservation["date"] == "2025-06-19";
      } else if (selectedDateFilter == "Tomorrow") {
        matchesDate = reservation["date"] == "2025-06-20";
      }
      
      bool matchesStatus = selectedStatusFilter == "All" || reservation["status"] == selectedStatusFilter;
      
      return matchesDate && matchesStatus;
    }).toList();
  }

  Map<String, int> get reservationStats {
    final today = reservations.where((r) => r["date"] == "2025-06-19").toList();
    return {
      "Total": today.length,
      "Confirmed": today.where((r) => r["status"] == "Confirmed").length,
      "Pending": today.where((r) => r["status"] == "Pending").length,
      "Cancelled": today.where((r) => r["status"] == "Cancelled").length,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      case "Completed":
        return infoColor;
      case "No Show":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Confirmed":
        return Icons.check_circle;
      case "Pending":
        return Icons.schedule;
      case "Cancelled":
        return Icons.cancel;
      case "Completed":
        return Icons.check;
      case "No Show":
        return Icons.person_off;
      default:
        return Icons.help;
    }
  }

  void _updateReservationStatus(Map<String, dynamic> reservation, String newStatus) async {
    bool isConfirmed = await confirm("Update reservation ${reservation["id"]} status to $newStatus?");
    if (isConfirmed) {
      setState(() {
        reservation["status"] = newStatus;
      });
      ss("Reservation ${reservation["id"]} updated to $newStatus");
    }
  }

  void _viewReservationDetails(Map<String, dynamic> reservation) {
    si("Viewing details for reservation ${reservation["id"]}");
  }

  void _editReservation(Map<String, dynamic> reservation) {
    si("Editing reservation ${reservation["id"]}");
  }

  void _deleteReservation(Map<String, dynamic> reservation) async {
    bool isConfirmed = await confirm("Delete reservation ${reservation["id"]}? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        reservations.remove(reservation);
      });
      ss("Reservation ${reservation["id"]} deleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reservation System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Reservations", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_today)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildReservationsTab(),
        _buildCalendarTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildReservationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: reservationStats.entries.map((entry) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "${entry.value}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Date Filter",
                  items: dateFilters,
                  value: selectedDateFilter,
                  onChanged: (value, label) {
                    selectedDateFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: statusFilters,
                  value: selectedStatusFilter,
                  onChanged: (value, label) {
                    selectedStatusFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Reservations List
          Text(
            "Reservations (${filteredReservations.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Column(
            spacing: spSm,
            children: filteredReservations.map((reservation) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(reservation["status"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Reservation Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(reservation["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon(reservation["status"]),
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${reservation["id"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${reservation["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(reservation["status"]),
                          ),
                        ),
                      ],
                    ),

                    // Guest Information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, size: 16, color: primaryColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${reservation["guestName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${reservation["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "Party of ${reservation["partySize"]}",
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
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${reservation["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${reservation["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (reservation["tableNumber"] != null)
                                Row(
                                  children: [
                                    Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Table ${reservation["tableNumber"]}",
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

                    // Special Requests
                    if (reservation["specialRequests"] != null) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note, size: 14, color: infoColor),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${reservation["specialRequests"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewReservationDetails(reservation),
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (reservation["status"] == "Pending") ...[
                          Expanded(
                            child: QButton(
                              label: "Confirm",
                              size: bs.sm,
                              onPressed: () => _updateReservationStatus(reservation, "Confirmed"),
                            ),
                          ),
                        ] else if (reservation["status"] == "Confirmed") ...[
                          Expanded(
                            child: QButton(
                              label: "Complete",
                              size: bs.sm,
                              onPressed: () => _updateReservationStatus(reservation, "Completed"),
                            ),
                          ),
                        ],
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () => _editReservation(reservation),
                        ),
                      ],
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

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "Calendar View",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive calendar for viewing and managing reservations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Total Reservations", "127", Icons.restaurant_menu, primaryColor),
              _buildAnalyticsCard("This Week", "48", Icons.date_range, successColor),
              _buildAnalyticsCard("Avg Party Size", "3.2", Icons.people, infoColor),
              _buildAnalyticsCard("Cancellation Rate", "8%", Icons.cancel, warningColor),
            ],
          ),

          // Charts Placeholder
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "Reservation Analytics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Charts and graphs showing reservation trends",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
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

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

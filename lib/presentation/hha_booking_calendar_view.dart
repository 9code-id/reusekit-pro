import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaBookingCalendarView extends StatefulWidget {
  const HhaBookingCalendarView({super.key});

  @override
  State<HhaBookingCalendarView> createState() => _HhaBookingCalendarViewState();
}

class _HhaBookingCalendarViewState extends State<HhaBookingCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "month";
  String selectedRoomType = "all";

  List<Map<String, dynamic>> bookings = [
    {
      "id": "BK001",
      "guestName": "John Smith",
      "roomNumber": "205",
      "roomType": "Deluxe",
      "checkInDate": DateTime(2024, 6, 15),
      "checkOutDate": DateTime(2024, 6, 18),
      "status": "confirmed",
      "color": Colors.blue,
      "nights": 3,
      "guests": 2
    },
    {
      "id": "BK002",
      "guestName": "Sarah Johnson",
      "roomNumber": "312",
      "roomType": "Suite",
      "checkInDate": DateTime(2024, 6, 16),
      "checkOutDate": DateTime(2024, 6, 17),
      "status": "checked_in",
      "color": Colors.green,
      "nights": 1,
      "guests": 1
    },
    {
      "id": "BK003",
      "guestName": "Michael Brown",
      "roomNumber": "418",
      "roomType": "Executive",
      "checkInDate": DateTime(2024, 6, 18),
      "checkOutDate": DateTime(2024, 6, 22),
      "status": "pending",
      "color": Colors.orange,
      "nights": 4,
      "guests": 2
    },
    {
      "id": "BK004",
      "guestName": "Emily Davis",
      "roomNumber": "523",
      "roomType": "Presidential",
      "checkInDate": DateTime(2024, 6, 20),
      "checkOutDate": DateTime(2024, 6, 22),
      "status": "confirmed",
      "color": Colors.purple,
      "nights": 2,
      "guests": 4
    }
  ];

  List<Map<String, dynamic>> rooms = [
    {"number": "101", "type": "Standard", "floor": 1, "status": "available"},
    {"number": "102", "type": "Standard", "floor": 1, "status": "occupied"},
    {"number": "205", "type": "Deluxe", "floor": 2, "status": "occupied"},
    {"number": "206", "type": "Deluxe", "floor": 2, "status": "maintenance"},
    {"number": "312", "type": "Suite", "floor": 3, "status": "occupied"},
    {"number": "313", "type": "Suite", "floor": 3, "status": "available"},
    {"number": "418", "type": "Executive", "floor": 4, "status": "reserved"},
    {"number": "419", "type": "Executive", "floor": 4, "status": "available"},
    {"number": "523", "type": "Presidential", "floor": 5, "status": "reserved"},
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Month View", "value": "month"},
    {"label": "Week View", "value": "week"},
    {"label": "Day View", "value": "day"}
  ];

  List<Map<String, dynamic>> roomTypeOptions = [
    {"label": "All Room Types", "value": "all"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Deluxe", "value": "Deluxe"},
    {"label": "Suite", "value": "Suite"},
    {"label": "Executive", "value": "Executive"},
    {"label": "Presidential", "value": "Presidential"}
  ];

  Color _getRoomStatusColor(String status) {
    switch (status) {
      case 'available':
        return successColor;
      case 'occupied':
        return infoColor;
      case 'reserved':
        return warningColor;
      case 'maintenance':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Calendar"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Add new booking
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Calendar Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "View",
                    items: viewOptions,
                    value: selectedView,
                    onChanged: (value, label) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Room Type",
                    items: roomTypeOptions,
                    value: selectedRoomType,
                    onChanged: (value, label) {
                      selectedRoomType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Today",
                  size: bs.sm,
                  onPressed: () {
                    selectedDate = DateTime.now();
                    setState(() {});
                  },
                ),
              ],
            ),

            // Calendar Navigation
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  QButton(
                    icon: Icons.chevron_left,
                    size: bs.sm,
                    onPressed: () {
                      if (selectedView == "month") {
                        selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
                      } else if (selectedView == "week") {
                        selectedDate = selectedDate.subtract(Duration(days: 7));
                      } else {
                        selectedDate = selectedDate.subtract(Duration(days: 1));
                      }
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Text(
                      _getCalendarTitle(),
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  QButton(
                    icon: Icons.chevron_right,
                    size: bs.sm,
                    onPressed: () {
                      if (selectedView == "month") {
                        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
                      } else if (selectedView == "week") {
                        selectedDate = selectedDate.add(Duration(days: 7));
                      } else {
                        selectedDate = selectedDate.add(Duration(days: 1));
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Calendar Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Total Rooms",
                  "${rooms.length}",
                  Icons.hotel,
                  primaryColor,
                ),
                _buildStatCard(
                  "Occupied",
                  "${rooms.where((r) => r["status"] == "occupied").length}",
                  Icons.person,
                  infoColor,
                ),
                _buildStatCard(
                  "Available",
                  "${rooms.where((r) => r["status"] == "available").length}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildStatCard(
                  "Occupancy Rate",
                  "${((rooms.where((r) => r["status"] == "occupied").length / rooms.length) * 100).toStringAsFixed(1)}%",
                  Icons.trending_up,
                  warningColor,
                ),
              ],
            ),

            // Calendar View
            if (selectedView == "month") _buildMonthView(),
            if (selectedView == "week") _buildWeekView(),
            if (selectedView == "day") _buildDayView(),

            // Room Status Legend
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
                    "Room Status Legend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: [
                      _buildLegendItem("Available", successColor),
                      _buildLegendItem("Occupied", infoColor),
                      _buildLegendItem("Reserved", warningColor),
                      _buildLegendItem("Maintenance", dangerColor),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Bookings
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
                        "Recent Bookings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // View all bookings
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...bookings.take(3).map((booking) => _buildRecentBookingItem(booking)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCalendarTitle() {
    if (selectedView == "month") {
      return "${_getMonthName(selectedDate.month)} ${selectedDate.year}";
    } else if (selectedView == "week") {
      DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      return "${startOfWeek.day} - ${endOfWeek.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}";
    } else {
      return "${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}";
    }
  }

  String _getMonthName(int month) {
    const months = [
      "", "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month];
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildMonthView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Days of week header
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
          
          // Calendar grid
          ...List.generate(5, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                int dayNumber = (weekIndex * 7) + dayIndex + 1;
                DateTime dayDate = DateTime(selectedDate.year, selectedDate.month, dayNumber);
                bool hasBooking = bookings.any((booking) => 
                  (booking["checkInDate"] as DateTime).isBefore(dayDate.add(Duration(days: 1))) &&
                  (booking["checkOutDate"] as DateTime).isAfter(dayDate)
                );
                
                return Expanded(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: hasBooking ? primaryColor.withAlpha(20) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: dayDate.day == DateTime.now().day && 
                             dayDate.month == DateTime.now().month &&
                             dayDate.year == DateTime.now().year
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$dayNumber",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: hasBooking ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        if (hasBooking)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Week days header
          Row(
            children: List.generate(7, (index) {
              DateTime weekDay = selectedDate.subtract(Duration(days: selectedDate.weekday - 1)).add(Duration(days: index));
              bool isToday = weekDay.day == DateTime.now().day && 
                           weekDay.month == DateTime.now().month &&
                           weekDay.year == DateTime.now().year;
              
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isToday ? primaryColor.withAlpha(20) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${weekDay.day}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isToday ? primaryColor : disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][index],
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          
          SizedBox(height: spSm),
          
          // Room timeline
          ...rooms.where((room) => selectedRoomType == "all" || room["type"] == selectedRoomType).map((room) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Room ${room["number"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getRoomStatusColor(room["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${room["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getRoomStatusColor(room["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: List.generate(7, (dayIndex) {
                        DateTime weekDay = selectedDate.subtract(Duration(days: selectedDate.weekday - 1)).add(Duration(days: dayIndex));
                        var roomBooking = bookings.where((booking) => 
                          booking["roomNumber"] == room["number"] &&
                          (booking["checkInDate"] as DateTime).isBefore(weekDay.add(Duration(days: 1))) &&
                          (booking["checkOutDate"] as DateTime).isAfter(weekDay)
                        ).firstOrNull;
                        
                        return Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: roomBooking != null ? (roomBooking["color"] as Color).withAlpha(200) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: roomBooking != null
                                ? Center(
                                    child: Text(
                                      "${roomBooking["guestName"]}".split(' ').first,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDayView() {
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
            "Rooms for ${selectedDate.day} ${_getMonthName(selectedDate.month)}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...rooms.where((room) => selectedRoomType == "all" || room["type"] == selectedRoomType).map((room) {
            var dayBooking = bookings.where((booking) => 
              booking["roomNumber"] == room["number"] &&
              (booking["checkInDate"] as DateTime).isBefore(selectedDate.add(Duration(days: 1))) &&
              (booking["checkOutDate"] as DateTime).isAfter(selectedDate)
            ).firstOrNull;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dayBooking != null ? (dayBooking["color"] as Color).withAlpha(20) : Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: dayBooking != null ? (dayBooking["color"] as Color) : disabledOutlineBorderColor,
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
                              "Room ${room["number"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getRoomStatusColor(room["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${room["type"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getRoomStatusColor(room["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (dayBooking != null) ...[
                          SizedBox(height: spXs),
                          Text(
                            "${dayBooking["guestName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${dayBooking["guests"]} guest${dayBooking["guests"] > 1 ? 's' : ''} • ${dayBooking["nights"]} night${dayBooking["nights"] > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ] else ...[
                          SizedBox(height: spXs),
                          Text(
                            "Available",
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (dayBooking != null)
                    QButton(
                      icon: Icons.info,
                      size: bs.sm,
                      onPressed: () {
                        // Show booking details
                      },
                    )
                  else
                    QButton(
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        // Add new booking
                      },
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentBookingItem(Map<String, dynamic> booking) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: booking["color"] as Color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${booking["guestName"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Room ${booking["roomNumber"]} • ${(booking["checkInDate"] as DateTime).day}/${(booking["checkInDate"] as DateTime).month} - ${(booking["checkOutDate"] as DateTime).day}/${(booking["checkOutDate"] as DateTime).month}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: (booking["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${booking["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: booking["color"] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

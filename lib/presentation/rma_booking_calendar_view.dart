import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaBookingCalendarView extends StatefulWidget {
  const RmaBookingCalendarView({super.key});

  @override
  State<RmaBookingCalendarView> createState() => _RmaBookingCalendarViewState();
}

class _RmaBookingCalendarViewState extends State<RmaBookingCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = "all";
  String viewMode = "day";
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "BOOK-001",
      "customerName": "John Smith",
      "partySize": 4,
      "time": "18:00",
      "duration": 120,
      "tableNumber": "T-12",
      "status": "confirmed",
      "date": "2024-03-15",
      "type": "reservation",
      "phone": "+1-555-0123",
      "specialRequests": "Birthday celebration",
    },
    {
      "id": "BOOK-002",
      "customerName": "Sarah Johnson",
      "partySize": 2,
      "time": "19:30",
      "duration": 90,
      "tableNumber": "T-05",
      "status": "pending",
      "date": "2024-03-15",
      "type": "reservation",
      "phone": "+1-555-0456",
      "specialRequests": "Window seat",
    },
    {
      "id": "BOOK-003",
      "customerName": "Mike Wilson",
      "partySize": 6,
      "time": "20:00",
      "duration": 150,
      "tableNumber": "T-18",
      "status": "confirmed",
      "date": "2024-03-15",
      "type": "reservation",
      "phone": "+1-555-0789",
      "specialRequests": "High chair needed",
    },
    {
      "id": "BOOK-004",
      "customerName": "Lisa Brown",
      "partySize": 8,
      "time": "17:00",
      "duration": 180,
      "tableNumber": "T-22",
      "status": "confirmed",
      "date": "2024-03-16",
      "type": "event",
      "phone": "+1-555-0321",
      "specialRequests": "Private dining",
    },
    {
      "id": "BOOK-005",
      "customerName": "David Chen",
      "partySize": 3,
      "time": "18:30",
      "duration": 105,
      "tableNumber": "T-08",
      "status": "seated",
      "date": "2024-03-15",
      "type": "reservation",
      "phone": "+1-555-0654",
      "specialRequests": "Gluten-free menu",
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"label": "All Times", "value": "all"},
    {"label": "Lunch (11:00-15:00)", "value": "lunch"},
    {"label": "Dinner (17:00-22:00)", "value": "dinner"},
    {"label": "Late Night (22:00-24:00)", "value": "late"},
  ];

  List<Map<String, dynamic>> viewModes = [
    {"label": "Day View", "value": "day"},
    {"label": "Week View", "value": "week"},
    {"label": "Month View", "value": "month"},
  ];

  Widget _buildCalendarHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              QButton(
                icon: Icons.chevron_left,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    if (viewMode == "day") {
                      selectedDate = selectedDate.subtract(Duration(days: 1));
                    } else if (viewMode == "week") {
                      selectedDate = selectedDate.subtract(Duration(days: 7));
                    } else {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
                    }
                  });
                },
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  _getHeaderTitle(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    if (viewMode == "day") {
                      selectedDate = selectedDate.add(Duration(days: 1));
                    } else if (viewMode == "week") {
                      selectedDate = selectedDate.add(Duration(days: 7));
                    } else {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "View Mode",
                  items: viewModes,
                  value: viewMode,
                  onChanged: (value, label) {
                    viewMode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Filter",
                  items: timeSlots,
                  value: selectedTimeSlot,
                  onChanged: (value, label) {
                    selectedTimeSlot = value;
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

  String _getHeaderTitle() {
    switch (viewMode) {
      case "day":
        return "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      case "week":
        final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        final weekEnd = weekStart.add(Duration(days: 6));
        return "${weekStart.day}/${weekStart.month} - ${weekEnd.day}/${weekEnd.month}/${weekEnd.year}";
      case "month":
        final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        return "${months[selectedDate.month - 1]} ${selectedDate.year}";
      default:
        return "";
    }
  }

  Widget _buildBookingStats() {
    final todayBookings = getBookingsForDate(selectedDate);
    final confirmedBookings = todayBookings.where((b) => b["status"] == "confirmed").length;
    final totalGuests = todayBookings.map((b) => b["partySize"] as int).fold(0, (a, b) => a + b);
    final occupancyRate = (confirmedBookings / 20 * 100).round(); // Assuming 20 tables
    
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
            "Today's Overview",
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
                "Total Bookings",
                "${todayBookings.length}",
                Icons.event,
                primaryColor,
              ),
              _buildStatCard(
                "Confirmed",
                "$confirmedBookings",
                Icons.check_circle,
                successColor,
              ),
              _buildStatCard(
                "Total Guests",
                "$totalGuests",
                Icons.people,
                infoColor,
              ),
              _buildStatCard(
                "Occupancy",
                "$occupancyRate%",
                Icons.trending_up,
                warningColor,
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

  Widget _buildTimeSlots() {
    final timeSlots = _generateTimeSlots();
    final dayBookings = getBookingsForDate(selectedDate);
    
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
            children: [
              Text(
                "Time Slots",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Booking",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreateBooking')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...timeSlots.map((timeSlot) {
            final slotBookings = dayBookings.where((booking) => 
              booking["time"] == timeSlot).toList();
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: slotBookings.isNotEmpty ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: slotBookings.isNotEmpty ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text(
                          timeSlot,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: slotBookings.isEmpty
                            ? Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              )
                            : Wrap(
                                spacing: spXs,
                                children: slotBookings.map((booking) => _buildBookingChip(booking)).toList(),
                              ),
                      ),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('CreateBookingAtTime')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBookingChip(Map<String, dynamic> booking) {
    final statusColor = booking["status"] == "confirmed" ? successColor :
                       booking["status"] == "pending" ? warningColor :
                       booking["status"] == "seated" ? infoColor :
                       dangerColor;

    return GestureDetector(
      onTap: () {
        //navigateTo('BookingDetails')
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: statusColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: statusColor.withAlpha(50)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              booking["type"] == "event" ? Icons.event : Icons.restaurant,
              color: statusColor,
              size: 12,
            ),
            SizedBox(width: spXs),
            Text(
              "${booking["customerName"]} (${booking["partySize"]})",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _generateTimeSlots() {
    List<String> slots = [];
    for (int hour = 11; hour <= 23; hour++) {
      slots.add("${hour.toString().padLeft(2, '0')}:00");
      slots.add("${hour.toString().padLeft(2, '0')}:30");
    }
    return slots;
  }

  List<Map<String, dynamic>> getBookingsForDate(DateTime date) {
    final dateString = "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    return bookings.where((booking) => booking["date"] == dateString).toList();
  }

  Widget _buildWeekView() {
    final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    
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
            "Week View",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: List.generate(7, (index) {
              final day = weekStart.add(Duration(days: index));
              final dayBookings = getBookingsForDate(day);
              final isToday = day.day == DateTime.now().day &&
                             day.month == DateTime.now().month &&
                             day.year == DateTime.now().year;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 6 ? spXs : 0),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isToday ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isToday ? primaryColor : Colors.grey.withAlpha(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${day.day}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isToday ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][day.weekday - 1],
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: dayBookings.isNotEmpty ? successColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${dayBookings.length}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              selectedDate = DateTime.now();
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('CalendarSettings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCalendarHeader(),
            _buildBookingStats(),
            if (viewMode == "week") _buildWeekView(),
            if (viewMode == "day") _buildTimeSlots(),
            if (viewMode == "month") _buildWeekView(), // Simplified month view
          ],
        ),
      ),
    );
  }
}

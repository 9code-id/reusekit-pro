import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar2View extends StatefulWidget {
  @override
  State<GrlCalendar2View> createState() => _GrlCalendar2ViewState();
}

class _GrlCalendar2ViewState extends State<GrlCalendar2View> {
  int selectedTabIndex = 0;
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> appointments = [
    {
      "id": 1,
      "title": "Doctor Appointment",
      "doctor": "Dr. Sarah Johnson",
      "time": "09:00 AM",
      "date": DateTime.now(),
      "type": "consultation",
      "location": "Room 201",
      "status": "confirmed",
    },
    {
      "id": 2,
      "title": "Dental Checkup",
      "doctor": "Dr. Mike Chen",
      "time": "02:30 PM",
      "date": DateTime.now().add(Duration(days: 1)),
      "type": "checkup",
      "location": "Dental Wing",
      "status": "pending",
    },
    {
      "id": 3,
      "title": "Lab Results Review",
      "doctor": "Dr. Emma Wilson",
      "time": "11:00 AM",
      "date": DateTime.now().add(Duration(days: 3)),
      "type": "followup",
      "location": "Lab Section",
      "status": "confirmed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildTabButton("Today", 0),
                _buildTabButton("Week", 1),
                _buildTabButton("Month", 2),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(BookAppointmentView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTabIndex = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: isSelected ? primaryColor : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildTodayView();
      case 1:
        return _buildWeekView();
      case 2:
        return _buildMonthView();
      default:
        return _buildTodayView();
    }
  }

  Widget _buildTodayView() {
    List<Map<String, dynamic>> todayAppointments = appointments.where((appointment) {
      DateTime appointmentDate = appointment["date"] as DateTime;
      DateTime today = DateTime.now();
      return appointmentDate.day == today.day &&
             appointmentDate.month == today.month &&
             appointmentDate.year == today.year;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateTime.now().day}",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${_getDayName(DateTime.now().weekday)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Appointments List
          if (todayAppointments.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 60,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No appointments today",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Enjoy your free day!",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          
          ...todayAppointments.map((appointment) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(appointment["status"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${appointment["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(appointment["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${appointment["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(appointment["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${appointment["doctor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${appointment["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${appointment["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Reschedule",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Week Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "This Week's Appointments",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Week Calendar
          ...List.generate(7, (index) {
            DateTime date = DateTime.now().add(Duration(days: index - DateTime.now().weekday + 1));
            List<Map<String, dynamic>> dayAppointments = appointments.where((appointment) {
              DateTime appointmentDate = appointment["date"] as DateTime;
              return appointmentDate.day == date.day &&
                     appointmentDate.month == date.month &&
                     appointmentDate.year == date.year;
            }).toList();

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${_getDayName(date.weekday).substring(0, 3)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: dayAppointments.isEmpty
                        ? Text(
                            "No appointments",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dayAppointments.map((appointment) => Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getStatusColor(appointment["status"]).withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${appointment["time"]} - ${appointment["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )).toList(),
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

  Widget _buildMonthView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Month Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Monthly Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${appointments.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 12,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${appointments.where((a) => a["status"] == "confirmed").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Confirmed",
                        style: TextStyle(
                          fontSize: 12,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${appointments.where((a) => a["status"] == "pending").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 12,
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
          
          // All Appointments
          ...appointments.map((appointment) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${appointment["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${(appointment["date"] as DateTime).day}/${(appointment["date"] as DateTime).month}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${appointment["doctor"]} • ${appointment["time"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  String _getDayName(int weekday) {
    const days = [
      '', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return days[weekday];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}

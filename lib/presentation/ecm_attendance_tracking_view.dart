import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAttendanceTrackingView extends StatefulWidget {
  const EcmAttendanceTrackingView({super.key});

  @override
  State<EcmAttendanceTrackingView> createState() => _EcmAttendanceTrackingViewState();
}

class _EcmAttendanceTrackingViewState extends State<EcmAttendanceTrackingView> {
  String selectedDay = "day1";
  String selectedSession = "all";
  String searchQuery = "";
  bool showOnlyPresent = false;
  
  Map<String, dynamic> attendanceData = {
    "overview": {
      "totalRegistered": 1456,
      "totalCheckedIn": 1247,
      "currentlyPresent": 834,
      "averageAttendance": 78.5,
      "noShows": 209
    },
    "dailyStats": [
      {
        "day": "Day 1",
        "date": "2024-12-15",
        "registered": 1456,
        "checkedIn": 1198,
        "peakAttendance": 987,
        "attendanceRate": 82.3
      },
      {
        "day": "Day 2",
        "date": "2024-12-16",
        "registered": 1456,
        "checkedIn": 1087,
        "peakAttendance": 923,
        "attendanceRate": 74.7
      },
      {
        "day": "Day 3",
        "date": "2024-12-17",
        "registered": 1456,
        "checkedIn": 934,
        "peakAttendance": 756,
        "attendanceRate": 64.1
      }
    ],
    "sessions": [
      {
        "id": 1,
        "title": "Opening Keynote - Digital Transformation",
        "time": "09:00 - 10:30",
        "room": "Main Hall",
        "capacity": 250,
        "registered": 234,
        "attended": 198,
        "attendanceRate": 84.6,
        "status": "completed"
      },
      {
        "id": 2,
        "title": "AI Marketing Strategies Workshop",
        "time": "11:00 - 12:00",
        "room": "Room A",
        "capacity": 100,
        "registered": 89,
        "attended": 76,
        "attendanceRate": 85.4,
        "status": "completed"
      },
      {
        "id": 3,
        "title": "Social Media Analytics Deep Dive",
        "time": "13:30 - 14:30",
        "room": "Room B",
        "capacity": 80,
        "registered": 67,
        "attended": 59,
        "attendanceRate": 88.1,
        "status": "completed"
      },
      {
        "id": 4,
        "title": "Future of E-commerce Panel",
        "time": "15:00 - 16:00",
        "room": "Main Hall",
        "capacity": 200,
        "registered": 156,
        "attended": 134,
        "attendanceRate": 85.9,
        "status": "live"
      },
      {
        "id": 5,
        "title": "Brand Building Workshop",
        "time": "16:30 - 17:30",
        "room": "Room A",
        "capacity": 80,
        "registered": 78,
        "attended": 0,
        "attendanceRate": 0.0,
        "status": "upcoming"
      }
    ],
    "attendees": [
      {
        "id": 1,
        "name": "Sarah Johnson",
        "email": "sarah.j@techcorp.com",
        "company": "TechCorp Inc.",
        "ticketType": "VIP",
        "checkInTime": "08:45",
        "currentLocation": "Main Hall",
        "sessionsAttended": 3,
        "status": "present"
      },
      {
        "id": 2,
        "name": "Mike Wilson",
        "email": "m.wilson@marketing.com",
        "company": "Marketing Solutions",
        "ticketType": "Regular",
        "checkInTime": "09:15",
        "currentLocation": "Room B",
        "sessionsAttended": 2,
        "status": "present"
      },
      {
        "id": 3,
        "name": "Lisa Chen",
        "email": "lisa@innovate.io",
        "company": "Innovation Labs",
        "ticketType": "Early Bird",
        "checkInTime": null,
        "currentLocation": null,
        "sessionsAttended": 0,
        "status": "no-show"
      },
      {
        "id": 4,
        "name": "John Smith",
        "email": "john.smith@digital.agency",
        "company": "Digital Agency Pro",
        "ticketType": "Regular",
        "checkInTime": "08:30",
        "currentLocation": "Networking Area",
        "sessionsAttended": 4,
        "status": "checked-out"
      },
      {
        "id": 5,
        "name": "Emma Rodriguez",
        "email": "emma@startup.com",
        "company": "Startup Ventures",
        "ticketType": "Student",
        "checkInTime": "09:00",
        "currentLocation": "Room A",
        "sessionsAttended": 1,
        "status": "present"
      }
    ]
  };
  
  List<Map<String, dynamic>> dayOptions = [
    {"label": "Day 1 (Dec 15)", "value": "day1"},
    {"label": "Day 2 (Dec 16)", "value": "day2"},
    {"label": "Day 3 (Dec 17)", "value": "day3"},
    {"label": "All Days", "value": "all"},
  ];
  
  List<Map<String, dynamic>> sessionOptions = [
    {"label": "All Sessions", "value": "all"},
    {"label": "Opening Keynote", "value": "1"},
    {"label": "AI Workshop", "value": "2"},
    {"label": "Analytics Session", "value": "3"},
    {"label": "E-commerce Panel", "value": "4"},
    {"label": "Brand Workshop", "value": "5"},
  ];

  @override
  Widget build(BuildContext context) {
    final overview = attendanceData["overview"] as Map<String, dynamic>;
    final filteredAttendees = _getFilteredAttendees();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Tracking"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: _scanQRCode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-time overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowLg],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Live Attendance",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "${overview["currentlyPresent"]}",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Currently Present",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${overview["totalCheckedIn"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Checked In",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${overview["noShows"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "No Shows",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${(overview["averageAttendance"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Avg Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Daily stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily Attendance Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...(attendanceData["dailyStats"] as List).map((day) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${day["day"]} - ${day["date"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getAttendanceRateColor((day["attendanceRate"] as double)),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${(day["attendanceRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 120,
                            children: [
                              _buildDayMetric("Registered", "${day["registered"]}"),
                              _buildDayMetric("Checked In", "${day["checkedIn"]}"),
                              _buildDayMetric("Peak", "${day["peakAttendance"]}"),
                            ],
                          ),
                          
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (day["attendanceRate"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _getAttendanceRateColor((day["attendanceRate"] as double)),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Session attendance
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session Attendance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...(attendanceData["sessions"] as List).map((session) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getSessionStatusColor("${session["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getSessionStatusColor("${session["status"]}").withAlpha(100),
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${session["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getSessionStatusColor("${session["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${session["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${session["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.room, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${session["room"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          if ((session["attended"] as int) > 0) ...[
                            Row(
                              children: [
                                Text(
                                  "${session["attended"]}/${session["registered"]} attended",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(session["attendanceRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getAttendanceRateColor((session["attendanceRate"] as double)),
                                  ),
                                ),
                              ],
                            ),
                            
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (session["attendanceRate"] as double) / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getAttendanceRateColor((session["attendanceRate"] as double)),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            Text(
                              "Session hasn't started yet",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Attendee tracking
            Text(
              "Attendee Tracking",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search attendees...",
                    value: searchQuery,
                    hint: "Name, company, or email",
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
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Day",
                    items: dayOptions,
                    value: selectedDay,
                    onChanged: (value, label) {
                      selectedDay = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Session",
                    items: sessionOptions,
                    value: selectedSession,
                    onChanged: (value, label) {
                      selectedSession = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Show only present attendees",
                  "value": true,
                  "checked": showOnlyPresent,
                }
              ],
              value: showOnlyPresent ? [{"label": "Show only present attendees", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyPresent = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            // Attendee list
            ...filteredAttendees.map((attendee) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${attendee["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${attendee["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${attendee["company"]}",
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
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${attendee["status"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${attendee["status"]}".toUpperCase().replaceAll("-", " "),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getTicketTypeColor("${attendee["ticketType"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${attendee["ticketType"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getTicketTypeColor("${attendee["ticketType"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    if (attendee["checkInTime"] != null) ...[
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: successColor),
                          SizedBox(width: 4),
                          Text(
                            "Checked in at ${attendee["checkInTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                          if (attendee["currentLocation"] != null) ...[
                            SizedBox(width: spSm),
                            Icon(Icons.location_on, size: 14, color: infoColor),
                            SizedBox(width: 4),
                            Text(
                              "${attendee["currentLocation"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                    
                    Row(
                      children: [
                        Text(
                          "Sessions attended: ${attendee["sessionsAttended"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if ("${attendee["status"]}" == "no-show") ...[
                          QButton(
                            label: "Mark Present",
                            size: bs.sm,
                            onPressed: () => _markPresent(attendee["id"] as int),
                          ),
                        ] else if ("${attendee["status"]}" == "present") ...[
                          QButton(
                            label: "Check Out",
                            size: bs.sm,
                            onPressed: () => _checkOut(attendee["id"] as int),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Quick actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Attendance",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: _exportAttendance,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Reminders",
                    icon: Icons.notifications,
                    size: bs.md,
                    onPressed: _sendReminders,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDayMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  List<Map<String, dynamic>> _getFilteredAttendees() {
    var filtered = (attendanceData["attendees"] as List).where((attendee) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        final searchLower = searchQuery.toLowerCase();
        if (!("${attendee["name"]}".toLowerCase().contains(searchLower) ||
            "${attendee["email"]}".toLowerCase().contains(searchLower) ||
            "${attendee["company"]}".toLowerCase().contains(searchLower))) {
          return false;
        }
      }
      
      // Status filter
      if (showOnlyPresent && "${attendee["status"]}" != "present") {
        return false;
      }
      
      return true;
    }).toList();
    
    return List<Map<String, dynamic>>.from(filtered);
  }
  
  Color _getAttendanceRateColor(double rate) {
    if (rate >= 80) return successColor;
    if (rate >= 60) return warningColor;
    return dangerColor;
  }
  
  Color _getSessionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'live':
        return dangerColor;
      case 'upcoming':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return successColor;
      case 'checked-out':
        return infoColor;
      case 'no-show':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getTicketTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'vip':
        return warningColor;
      case 'regular':
        return primaryColor;
      case 'early bird':
        return successColor;
      case 'student':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _scanQRCode() {
    ss("QR code scanner opened");
  }
  
  void _markPresent(int attendeeId) {
    ss("Attendee marked as present");
  }
  
  void _checkOut(int attendeeId) {
    ss("Attendee checked out");
  }
  
  void _exportAttendance() {
    ss("Attendance data exported successfully");
  }
  
  void _sendReminders() {
    ss("Reminder notifications sent to no-show attendees");
  }
}

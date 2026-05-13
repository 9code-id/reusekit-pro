import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaCheckInView extends StatefulWidget {
  const EmaCheckInView({super.key});

  @override
  State<EmaCheckInView> createState() => _EmaCheckInViewState();
}

class _EmaCheckInViewState extends State<EmaCheckInView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedEvent = "all";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Checked In", "value": "checked_in"},
    {"label": "Not Checked In", "value": "not_checked_in"},
    {"label": "No Show", "value": "no_show"},
  ];

  List<Map<String, dynamic>> eventOptions = [
    {"label": "All Events", "value": "all"},
    {"label": "Tech Conference 2024", "value": "tech_conf_2024"},
    {"label": "Marketing Summit", "value": "marketing_summit"},
    {"label": "Design Workshop", "value": "design_workshop"},
  ];

  List<Map<String, dynamic>> attendees = [
    {
      "id": "att_001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234 567 8900",
      "ticket_type": "VIP",
      "event": "Tech Conference 2024",
      "check_in_status": "checked_in",
      "check_in_time": "2024-06-19T09:15:00Z",
      "table_number": "Table 5",
      "special_requirements": "Vegetarian meal",
      "avatar": "https://picsum.photos/80/80?random=1",
    },
    {
      "id": "att_002", 
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 234 567 8901",
      "ticket_type": "Standard",
      "event": "Marketing Summit",
      "check_in_status": "not_checked_in",
      "check_in_time": null,
      "table_number": "Table 12",
      "special_requirements": null,
      "avatar": "https://picsum.photos/80/80?random=2",
    },
    {
      "id": "att_003",
      "name": "Michael Brown",
      "email": "michael.brown@email.com", 
      "phone": "+1 234 567 8902",
      "ticket_type": "Premium",
      "event": "Tech Conference 2024",
      "check_in_status": "no_show",
      "check_in_time": null,
      "table_number": "Table 8",
      "special_requirements": "Wheelchair accessible",
      "avatar": "https://picsum.photos/80/80?random=3",
    },
    {
      "id": "att_004",
      "name": "Emily Davis",
      "email": "emily.davis@email.com",
      "phone": "+1 234 567 8903", 
      "ticket_type": "Standard",
      "event": "Design Workshop",
      "check_in_status": "checked_in",
      "check_in_time": "2024-06-19T10:30:00Z",
      "table_number": "Table 3",
      "special_requirements": null,
      "avatar": "https://picsum.photos/80/80?random=4",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "attendee_name": "John Smith",
      "action": "Checked In",
      "time": "09:15 AM",
      "ticket_type": "VIP",
      "table": "Table 5",
    },
    {
      "attendee_name": "Emily Davis", 
      "action": "Checked In",
      "time": "10:30 AM",
      "ticket_type": "Standard",
      "table": "Table 3",
    },
    {
      "attendee_name": "David Wilson",
      "action": "Manual Check-in",
      "time": "11:45 AM",
      "ticket_type": "Premium", 
      "table": "Table 7",
    },
  ];

  Map<String, dynamic> checkInStats = {
    "total_registered": 150,
    "checked_in": 89,
    "not_checked_in": 45,
    "no_show": 16,
    "check_in_rate": 59.3,
  };

  List<Map<String, dynamic>> get filteredAttendees {
    return attendees.where((attendee) {
      bool matchesSearch = attendee["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          attendee["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || attendee["check_in_status"] == selectedStatus;
      bool matchesEvent = selectedEvent == "all" || attendee["event"] == selectedEvent;
      
      return matchesSearch && matchesStatus && matchesEvent;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "checked_in":
        return successColor;
      case "not_checked_in":
        return warningColor;
      case "no_show":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "checked_in":
        return "Checked In";
      case "not_checked_in":
        return "Not Checked In";
      case "no_show":
        return "No Show";
      default:
        return "Unknown";
    }
  }

  Future<void> _checkInAttendee(Map<String, dynamic> attendee) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    // Update attendee status
    int index = attendees.indexWhere((a) => a["id"] == attendee["id"]);
    if (index != -1) {
      attendees[index]["check_in_status"] = "checked_in";
      attendees[index]["check_in_time"] = DateTime.now().toIso8601String();
      
      // Update stats
      checkInStats["checked_in"] = (checkInStats["checked_in"] as int) + 1;
      checkInStats["not_checked_in"] = (checkInStats["not_checked_in"] as int) - 1;
      checkInStats["check_in_rate"] = ((checkInStats["checked_in"] as int) / (checkInStats["total_registered"] as int) * 100);
    }

    loading = false;
    setState(() {});
    
    ss("${attendee["name"]} checked in successfully");
  }

  Future<void> _markNoShow(Map<String, dynamic> attendee) async {
    bool isConfirmed = await confirm("Mark ${attendee["name"]} as No Show?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    // Update attendee status
    int index = attendees.indexWhere((a) => a["id"] == attendee["id"]);
    if (index != -1) {
      attendees[index]["check_in_status"] = "no_show";
      
      // Update stats
      checkInStats["no_show"] = (checkInStats["no_show"] as int) + 1;
      checkInStats["not_checked_in"] = (checkInStats["not_checked_in"] as int) - 1;
    }

    loading = false;
    setState(() {});
    
    sw("${attendee["name"]} marked as No Show");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Event Check-In",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Check-In", icon: Icon(Icons.how_to_reg)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildCheckInTab(),
        _buildStatisticsTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildCheckInTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Scan QR Code",
                  icon: Icons.qr_code_scanner,
                  onPressed: () {
                    // Navigate to QR scanner
                    si("QR Scanner opened");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Manual Check-In",
                  icon: Icons.person_add,
                  onPressed: () {
                    _showManualCheckInDialog();
                  },
                ),
              ),
            ],
          ),

          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search attendees...",
                  value: searchQuery,
                  hint: "Search by name or email",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter by Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Filter by Event",
                        items: eventOptions,
                        value: selectedEvent,
                        onChanged: (value, label) {
                          selectedEvent = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stats Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                _buildStatCard("Total", "${checkInStats["total_registered"]}", primaryColor),
                _buildStatCard("Checked In", "${checkInStats["checked_in"]}", successColor),
                _buildStatCard("Pending", "${checkInStats["not_checked_in"]}", warningColor),
                _buildStatCard("No Show", "${checkInStats["no_show"]}", dangerColor),
              ],
            ),
          ),

          // Attendees List
          Text(
            "Attendees (${filteredAttendees.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...filteredAttendees.map((attendee) => _buildAttendeeCard(attendee)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeCard(Map<String, dynamic> attendee) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(attendee["check_in_status"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${attendee["avatar"]}"),
              ),
              SizedBox(width: spSm),
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
                  color: _getStatusColor(attendee["check_in_status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(attendee["check_in_status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(attendee["check_in_status"]),
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Icon(Icons.confirmation_number, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${attendee["ticket_type"]} • ${attendee["table_number"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (attendee["check_in_time"] != null)
                Text(
                  "Checked in: ${DateTime.parse(attendee["check_in_time"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
            ],
          ),

          if (attendee["special_requirements"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Text(
                    "${attendee["special_requirements"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

          if (attendee["check_in_status"] == "not_checked_in")
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Check In",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () => _checkInAttendee(attendee),
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Mark No Show",
                    icon: Icons.close,
                    color: dangerColor,
                    size: bs.sm,
                    onPressed: () => _markNoShow(attendee),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Check-in Rate Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "Overall Check-in Rate",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${(checkInStats["check_in_rate"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${checkInStats["checked_in"]} of ${checkInStats["total_registered"]} attendees",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          // Detailed Stats
          Row(
            spacing: spSm,
            children: [
              _buildDetailedStatCard(
                "Checked In",
                "${checkInStats["checked_in"]}",
                successColor,
                Icons.check_circle,
              ),
              _buildDetailedStatCard(
                "Pending",
                "${checkInStats["not_checked_in"]}",
                warningColor,
                Icons.pending,
              ),
            ],
          ),

          Row(
            spacing: spSm,
            children: [
              _buildDetailedStatCard(
                "No Show",
                "${checkInStats["no_show"]}",
                dangerColor,
                Icons.cancel,
              ),
              _buildDetailedStatCard(
                "Total Registered",
                "${checkInStats["total_registered"]}",
                primaryColor,
                Icons.people,
              ),
            ],
          ),

          // Event Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildEventBreakdownItem("Tech Conference 2024", 85, 120),
                _buildEventBreakdownItem("Marketing Summit", 32, 45),
                _buildEventBreakdownItem("Design Workshop", 18, 25),
              ],
            ),
          ),

          // Hourly Check-in Pattern
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hourly Check-in Pattern",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildHourlyPattern("08:00 - 09:00", 15),
                _buildHourlyPattern("09:00 - 10:00", 35),
                _buildHourlyPattern("10:00 - 11:00", 28),
                _buildHourlyPattern("11:00 - 12:00", 11),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventBreakdownItem(String eventName, int checkedIn, int total) {
    double percentage = (checkedIn / total) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eventName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "$checkedIn/$total (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyPattern(String timeRange, int count) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              timeRange,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: count / 35, // Max value for scaling
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "$count",
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

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Activity Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                _buildActivitySummary("Today's Check-ins", "89", successColor),
                _buildActivitySummary("Last Hour", "12", primaryColor),
                _buildActivitySummary("Peak Time", "10-11 AM", infoColor),
              ],
            ),
          ),

          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...recentActivity.map((activity) => _buildActivityItem(activity)),

          // Load More Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Load More Activity",
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                si("Loading more activity...");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySummary(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.check_circle,
              color: successColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["attendee_name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["action"]} • ${activity["ticket_type"]} • ${activity["table"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showManualCheckInDialog() {
    String attendeeName = "";
    String attendeeEmail = "";
    String ticketNumber = "";
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              
              Text(
                "Manual Check-In",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Attendee Name",
                value: attendeeName,
                hint: "Enter full name",
                onChanged: (value) => attendeeName = value,
              ),
              
              QTextField(
                label: "Email Address",
                value: attendeeEmail,
                hint: "Enter email address",
                onChanged: (value) => attendeeEmail = value,
              ),
              
              QTextField(
                label: "Ticket Number",
                value: ticketNumber,
                hint: "Enter ticket number",
                onChanged: (value) => ticketNumber = value,
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      color: disabledBoldColor,
                      onPressed: () => back(),
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Check In",
                      onPressed: () {
                        if (attendeeName.isNotEmpty && attendeeEmail.isNotEmpty) {
                          back();
                          ss("Manual check-in completed for $attendeeName");
                        } else {
                          se("Please fill all required fields");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

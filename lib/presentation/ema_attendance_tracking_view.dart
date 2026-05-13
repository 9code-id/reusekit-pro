import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAttendanceTrackingView extends StatefulWidget {
  const EmaAttendanceTrackingView({super.key});

  @override
  State<EmaAttendanceTrackingView> createState() => _EmaAttendanceTrackingViewState();
}

class _EmaAttendanceTrackingViewState extends State<EmaAttendanceTrackingView> {
  String selectedEvent = "all";
  String searchQuery = "";
  String filterStatus = "all";

  List<Map<String, dynamic>> events = [
    {
      "id": "evt_001",
      "name": "Annual Company Meeting",
      "date": "2024-12-15",
      "time": "09:00",
      "location": "Main Conference Hall",
      "totalInvited": 120,
      "totalAttended": 98,
      "attendanceRate": 81.7,
      "status": "completed"
    },
    {
      "id": "evt_002", 
      "name": "Product Launch Event",
      "date": "2024-12-20",
      "time": "14:00",
      "location": "Grand Ballroom",
      "totalInvited": 250,
      "totalAttended": 0,
      "attendanceRate": 0.0,
      "status": "upcoming"
    },
    {
      "id": "evt_003",
      "name": "Team Building Workshop",
      "date": "2024-12-10",
      "time": "10:00", 
      "location": "Training Room A",
      "totalInvited": 45,
      "totalAttended": 42,
      "attendanceRate": 93.3,
      "status": "completed"
    }
  ];

  List<Map<String, dynamic>> attendees = [
    {
      "id": "att_001",
      "eventId": "evt_001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "department": "Marketing",
      "invitedAt": "2024-12-01T10:00:00Z",
      "checkedInAt": "2024-12-15T08:45:00Z",
      "status": "attended",
      "notes": "Arrived early"
    },
    {
      "id": "att_002",
      "eventId": "evt_001", 
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "department": "Sales",
      "invitedAt": "2024-12-01T10:00:00Z",
      "checkedInAt": null,
      "status": "no_show",
      "notes": "Did not attend"
    },
    {
      "id": "att_003",
      "eventId": "evt_001",
      "name": "Mike Wilson",
      "email": "mike.wilson@company.com", 
      "department": "Engineering",
      "invitedAt": "2024-12-01T10:00:00Z",
      "checkedInAt": "2024-12-15T09:15:00Z",
      "status": "attended",
      "notes": "Checked in on time"
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesSearch = searchQuery.isEmpty || 
          event["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredAttendees {
    return attendees.where((attendee) {
      bool matchesEvent = selectedEvent == "all" || attendee["eventId"] == selectedEvent;
      bool matchesStatus = filterStatus == "all" || attendee["status"] == filterStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          attendee["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesEvent && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "attended":
        return successColor;
      case "no_show":
        return dangerColor;
      case "pending":
        return warningColor;
      case "completed":
        return successColor;
      case "upcoming":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case "attended":
        return "Attended";
      case "no_show":
        return "No Show";
      case "pending":
        return "Pending";
      case "completed":
        return "Completed";
      case "upcoming":
        return "Upcoming";
      default:
        return "Unknown";
    }
  }

  void _showAttendeeDetails(Map<String, dynamic> attendee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${attendee["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: ${attendee["email"]}"),
            SizedBox(height: spXs),
            Text("Department: ${attendee["department"]}"),
            SizedBox(height: spXs),
            Text("Status: ${_formatStatus(attendee["status"])}"),
            if (attendee["checkedInAt"] != null) ...[
              SizedBox(height: spXs),
              Text("Checked In: ${DateTime.parse(attendee["checkedInAt"]).dMMMy} at ${DateTime.parse(attendee["checkedInAt"]).kkmm}"),
            ],
            if (attendee["notes"].toString().isNotEmpty) ...[
              SizedBox(height: spXs),
              Text("Notes: ${attendee["notes"]}"),
            ],
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                    Text(
                      "${event["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${event["location"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(event["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _formatStatus(event["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(event["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Invited",
                  "${event["totalInvited"]}",
                  Icons.people_outline,
                  infoColor,
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: _buildStatCard(
                  "Attended",
                  "${event["totalAttended"]}",
                  Icons.check_circle_outline,
                  successColor,
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: _buildStatCard(
                  "Rate",
                  "${(event["attendanceRate"] as num).toStringAsFixed(1)}%",
                  Icons.trending_up,
                  primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendeeItem(Map<String, dynamic> attendee) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: primaryColor.withAlpha(20),
            child: Text(
              "${attendee["name"]}".substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attendee["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "${attendee["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (attendee["checkedInAt"] != null) ...[
                  SizedBox(height: 2),
                  Text(
                    "Checked in: ${DateTime.parse(attendee["checkedInAt"]).kkmm}",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: _getStatusColor(attendee["status"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              _formatStatus(attendee["status"]),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _getStatusColor(attendee["status"]),
              ),
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () => _showAttendeeDetails(attendee),
            child: Icon(
              Icons.info_outline,
              size: 18,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Attendance Tracking",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Events", icon: Icon(Icons.event)),
        Tab(text: "Attendees", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        // Events Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search events...",
                      value: searchQuery,
                      hint: "Enter event name",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      ss("Add new event feature");
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Event Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "Total Events",
                      "${events.length}",
                      Icons.event_note,
                      primaryColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: _buildStatCard(
                      "Completed",
                      "${events.where((e) => e["status"] == "completed").length}",
                      Icons.check_circle,
                      successColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: _buildStatCard(
                      "Upcoming",
                      "${events.where((e) => e["status"] == "upcoming").length}",
                      Icons.schedule,
                      warningColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: _buildStatCard(
                      "Avg Rate",
                      "${(events.where((e) => e["status"] == "completed").map((e) => e["attendanceRate"] as num).fold(0.0, (a, b) => a + b) / events.where((e) => e["status"] == "completed").length).toStringAsFixed(1)}%",
                      Icons.analytics,
                      infoColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Recent Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...filteredEvents.map((event) => _buildEventCard(event)).toList(),
            ],
          ),
        ),
        // Attendees Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Event",
                      items: [
                        {"label": "All Events", "value": "all"},
                        ...events.map((e) => {"label": "${e["name"]}", "value": "${e["id"]}"}).toList(),
                      ],
                      value: selectedEvent,
                      onChanged: (value, label) {
                        selectedEvent = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Status",
                      items: [
                        {"label": "All Status", "value": "all"},
                        {"label": "Attended", "value": "attended"},
                        {"label": "No Show", "value": "no_show"},
                        {"label": "Pending", "value": "pending"},
                      ],
                      value: filterStatus,
                      onChanged: (value, label) {
                        filterStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Search attendees...",
                value: searchQuery,
                hint: "Enter attendee name",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attendees (${filteredAttendees.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    icon: Icons.file_download,
                    size: bs.sm,
                    onPressed: () {
                      ss("Export attendee list");
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              if (filteredAttendees.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No attendees found",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...filteredAttendees.map((attendee) => _buildAttendeeItem(attendee)).toList(),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaTherapySessionsView extends StatefulWidget {
  const HcaTherapySessionsView({super.key});

  @override
  State<HcaTherapySessionsView> createState() => _HcaTherapySessionsViewState();
}

class _HcaTherapySessionsViewState extends State<HcaTherapySessionsView> {
  int selectedFilter = 0;
  String searchQuery = "";
  String selectedTherapist = "";
  String selectedType = "";
  
  final List<String> filterOptions = [
    "All Sessions",
    "Upcoming",
    "Completed",
    "Cancelled"
  ];

  final List<Map<String, dynamic>> therapyTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Cognitive Behavioral Therapy (CBT)", "value": "cbt"},
    {"label": "Psychodynamic Therapy", "value": "psychodynamic"},
    {"label": "Group Therapy", "value": "group"},
    {"label": "Family Therapy", "value": "family"},
    {"label": "Couples Therapy", "value": "couples"},
    {"label": "EMDR", "value": "emdr"},
    {"label": "Mindfulness-Based Therapy", "value": "mindfulness"},
  ];

  final List<Map<String, dynamic>> therapists = [
    {"label": "All Therapists", "value": ""},
    {"label": "Dr. Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Dr. Michael Chen", "value": "michael_chen"},
    {"label": "Dr. Emily Rodriguez", "value": "emily_rodriguez"},
    {"label": "Dr. David Kim", "value": "david_kim"},
  ];

  final List<Map<String, dynamic>> therapySessions = [
    {
      "id": "1",
      "therapist": "Dr. Sarah Johnson",
      "type": "Cognitive Behavioral Therapy (CBT)",
      "date": "2024-01-15",
      "time": "10:00 AM",
      "duration": 60,
      "status": "upcoming",
      "notes": "Focus on anxiety management techniques",
      "rating": 0,
      "progress": "Excellent",
      "location": "Room 205",
      "cost": 150.0,
      "homework": "Practice breathing exercises daily"
    },
    {
      "id": "2",
      "therapist": "Dr. Michael Chen",
      "type": "Mindfulness-Based Therapy",
      "date": "2024-01-12",
      "time": "2:00 PM",
      "duration": 45,
      "status": "completed",
      "notes": "Worked on present-moment awareness",
      "rating": 5,
      "progress": "Good",
      "location": "Room 103",
      "cost": 120.0,
      "homework": "Meditation practice 10 minutes daily"
    },
    {
      "id": "3",
      "therapist": "Dr. Emily Rodriguez",
      "type": "Group Therapy",
      "date": "2024-01-18",
      "time": "6:00 PM",
      "duration": 90,
      "status": "upcoming",
      "notes": "Social anxiety support group",
      "rating": 0,
      "progress": "Fair",
      "location": "Group Room A",
      "cost": 80.0,
      "homework": "Journal daily interactions"
    }
  ];

  List<Map<String, dynamic>> get filteredSessions {
    List<Map<String, dynamic>> filtered = therapySessions;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((session) {
        return "${session["therapist"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${session["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${session["notes"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by status
    if (selectedFilter != 0) {
      String statusFilter = filterOptions[selectedFilter].toLowerCase();
      filtered = filtered.where((session) {
        return "${session["status"]}".toLowerCase() == statusFilter;
      }).toList();
    }

    // Filter by therapist
    if (selectedTherapist.isNotEmpty) {
      filtered = filtered.where((session) {
        return "${session["therapist"]}".toLowerCase().contains(selectedTherapist.toLowerCase());
      }).toList();
    }

    // Filter by type
    if (selectedType.isNotEmpty) {
      filtered = filtered.where((session) {
        return "${session["type"]}".toLowerCase().contains(selectedType.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return infoColor;
      case 'completed':
        return successColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getProgressColor(String progress) {
    switch (progress.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
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
            color: _getStatusColor("${session["status"]}"),
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
                    Text(
                      "${session["therapist"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${session["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
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
                  color: _getStatusColor("${session["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${session["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${session["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${session["date"]} at ${session["time"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${session["duration"]} min",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${session["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(session["cost"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if ("${session["notes"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session Notes",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${session["notes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if ("${session["status"]}" == "completed") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Text(
                  "Progress:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getProgressColor("${session["progress"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${session["progress"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getProgressColor("${session["progress"]}"),
                    ),
                  ),
                ),
                Spacer(),
                if ((session["rating"] as int) > 0) ...[
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (session["rating"] as int) ? Icons.star : Icons.star_border,
                        size: 16,
                        color: warningColor,
                      );
                    }),
                  ),
                ],
              ],
            ),
          ],
          if ("${session["homework"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.assignment,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Homework Assignment",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${session["homework"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "${session["status"]}" == "upcoming" ? "View Details" : "View Notes",
                  size: bs.sm,
                  onPressed: () {
                    si("Session details viewed");
                  },
                ),
              ),
              SizedBox(width: spSm),
              if ("${session["status"]}" == "upcoming") ...[
                QButton(
                  label: "Reschedule",
                  size: bs.sm,
                  onPressed: () {
                    si("Reschedule session");
                  },
                ),
              ] else if ("${session["status"]}" == "completed" && (session["rating"] as int) == 0) ...[
                QButton(
                  label: "Rate Session",
                  size: bs.sm,
                  onPressed: () {
                    si("Rate session");
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Therapy Sessions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Book new session");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    "Total Sessions",
                    "${therapySessions.length}",
                    primaryColor,
                    Icons.event,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "Completed",
                    "${therapySessions.where((s) => s["status"] == "completed").length}",
                    successColor,
                    Icons.check_circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "Upcoming",
                    "${therapySessions.where((s) => s["status"] == "upcoming").length}",
                    infoColor,
                    Icons.upcoming,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            QTextField(
              label: "Search sessions...",
              value: searchQuery,
              hint: "Search by therapist, type, or notes",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Therapist",
                    items: therapists,
                    value: selectedTherapist,
                    onChanged: (value, label) {
                      selectedTherapist = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: therapyTypes,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Filter Tabs
            QCategoryPicker(
              items: filterOptions.map((option) => {
                "label": option,
                "value": option,
              }).toList(),
              value: filterOptions[selectedFilter],
              onChanged: (index, label, value, item) {
                selectedFilter = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Sessions List
            Text(
              "Sessions (${filteredSessions.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            if (filteredSessions.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No sessions found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredSessions.map((session) => _buildSessionCard(session)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Book new therapy session");
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

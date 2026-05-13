import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaScheduleView extends StatefulWidget {
  const CmaScheduleView({super.key});

  @override
  State<CmaScheduleView> createState() => _CmaScheduleViewState();
}

class _CmaScheduleViewState extends State<CmaScheduleView> {
  int selectedTabIndex = 0;
  DateTime selectedDate = DateTime.now();
  String viewMode = "day"; // day, week
  
  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": "1",
      "title": "Team Standup Meeting",
      "type": "meeting",
      "startTime": "09:00",
      "endTime": "09:30",
      "date": "2024-12-22",
      "participants": ["John Smith", "Emily Davis", "Michael Johnson"],
      "location": "Conference Room A",
      "status": "confirmed",
      "priority": "medium",
      "description": "Daily team sync and progress updates",
    },
    {
      "id": "2",
      "title": "Client Presentation - Johnson Corp",
      "type": "presentation",
      "startTime": "10:00",
      "endTime": "12:00",
      "date": "2024-12-22",
      "participants": ["John Smith", "Emily Davis"],
      "location": "Client Office",
      "status": "confirmed",
      "priority": "high",
      "description": "Quarterly business review presentation",
    },
    {
      "id": "3",
      "title": "Lunch Break",
      "type": "break",
      "startTime": "12:00",
      "endTime": "13:00",
      "date": "2024-12-22",
      "participants": [],
      "location": "Office Cafeteria",
      "status": "blocked",
      "priority": "low",
      "description": "Personal time",
    },
    {
      "id": "4",
      "title": "Project Planning Session",
      "type": "planning",
      "startTime": "13:30",
      "endTime": "15:00",
      "date": "2024-12-22",
      "participants": ["Michael Johnson", "Sarah Wilson"],
      "location": "Meeting Room B",
      "status": "tentative",
      "priority": "high",
      "description": "Plan Q1 2025 project roadmap",
    },
    {
      "id": "5",
      "title": "Follow-up Calls",
      "type": "calls",
      "startTime": "15:30",
      "endTime": "16:30",
      "date": "2024-12-22",
      "participants": ["David Brown"],
      "location": "Office",
      "status": "confirmed",
      "priority": "medium",
      "description": "Client follow-up and status updates",
    },
    {
      "id": "6",
      "title": "Email Review & Admin",
      "type": "admin",
      "startTime": "16:30",
      "endTime": "17:30",
      "date": "2024-12-22",
      "participants": [],
      "location": "Office",
      "status": "blocked",
      "priority": "low",
      "description": "Review emails and administrative tasks",
    },
  ];

  List<String> timeSlots = [
    "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
    "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00"
  ];

  List<Map<String, dynamic>> get selectedDateSchedule {
    String dateStr = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    return scheduleItems.where((item) => item["date"] == dateStr).toList()
      ..sort((a, b) => (a["startTime"] as String).compareTo(b["startTime"] as String));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        actions: [
          QButton(
            icon: Icons.today,
            size: bs.sm,
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add schedule item
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildScheduleHeader(),
          _buildDateSelector(),
          _buildViewModeSelector(),
          Expanded(
            child: _buildScheduleView(),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleHeader() {
    int totalItems = selectedDateSchedule.length;
    int confirmedItems = selectedDateSchedule.where((item) => item["status"] == "confirmed").length;
    int tentativeItems = selectedDateSchedule.where((item) => item["status"] == "tentative").length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalItems, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Confirmed", confirmedItems, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Tentative", tentativeItems, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Row(
        children: [
          QButton(
            icon: Icons.chevron_left,
            size: bs.sm,
            onPressed: () {
              setState(() {
                selectedDate = selectedDate.subtract(Duration(days: 1));
              });
            },
          ),
          Expanded(
            child: Text(
              _getDateText(selectedDate),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          QButton(
            icon: Icons.chevron_right,
            size: bs.sm,
            onPressed: () {
              setState(() {
                selectedDate = selectedDate.add(Duration(days: 1));
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector() {
    List<Map<String, dynamic>> viewModes = [
      {"label": "Day View", "value": "day"},
      {"label": "Timeline", "value": "timeline"},
      {"label": "List View", "value": "list"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: QCategoryPicker(
        items: viewModes,
        value: viewMode,
        onChanged: (index, label, value, item) {
          setState(() {
            viewMode = value;
          });
        },
      ),
    );
  }

  Widget _buildScheduleView() {
    if (viewMode == "timeline") {
      return _buildTimelineView();
    } else if (viewMode == "list") {
      return _buildListView();
    } else {
      return _buildDayView();
    }
  }

  Widget _buildDayView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: selectedDateSchedule.map((item) => _buildScheduleCard(item)).toList(),
      ),
    );
  }

  Widget _buildTimelineView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: timeSlots.map((timeSlot) {
          Map<String, dynamic>? item = selectedDateSchedule.firstWhere(
            (item) => item["startTime"] == timeSlot,
            orElse: () => {},
          );
          
          return _buildTimelineSlot(timeSlot, item.isEmpty ? null : item);
        }).toList(),
      ),
    );
  }

  Widget _buildListView() {
    if (selectedDateSchedule.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.schedule,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No schedule items",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Your schedule is free for this day",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: selectedDateSchedule.length,
      itemBuilder: (context, index) {
        final item = selectedDateSchedule[index];
        return _buildScheduleCard(item);
      },
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> item) {
    Color typeColor = _getTypeColor(item["type"]);
    Color statusColor = _getStatusColor(item["status"]);
    
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
            color: typeColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${item["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${item["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${item["startTime"]} - ${item["endTime"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${item["location"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((item["participants"] as List).isNotEmpty)
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Participants: ${(item["participants"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: typeColor,
                  ),
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Navigate to edit schedule item
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showScheduleActions(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSlot(String timeSlot, Map<String, dynamic>? item) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 1),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              timeSlot,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: item != null
                ? Container(
                    height: 50,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: _getTypeColor(item["type"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: _getTypeColor(item["type"]),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getTypeColor(item["type"]),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${item["location"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: disabledColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Free",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "meeting":
        return primaryColor;
      case "presentation":
        return warningColor;
      case "planning":
        return infoColor;
      case "calls":
        return successColor;
      case "admin":
        return disabledBoldColor;
      case "break":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "tentative":
        return warningColor;
      case "blocked":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showScheduleActions(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: double.infinity,
              child: QButton(
                label: "Edit Schedule",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to edit
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reschedule",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to reschedule
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Cancel Item",
                size: bs.md,
                onPressed: () {
                  back();
                  _cancelScheduleItem(item["id"]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cancelScheduleItem(String itemId) {
    setState(() {
      scheduleItems.removeWhere((item) => item["id"] == itemId);
    });
    ss("Schedule item cancelled");
  }

  String _getDateText(DateTime date) {
    List<String> weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    
    return "${weekdays[date.weekday == 7 ? 0 : date.weekday]}, ${months[date.month - 1]} ${date.day}";
  }
}

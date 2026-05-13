import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaScheduleView extends StatefulWidget {
  const PmaScheduleView({super.key});

  @override
  State<PmaScheduleView> createState() => _PmaScheduleViewState();
}

class _PmaScheduleViewState extends State<PmaScheduleView> {
  String selectedFilter = "all";
  String selectedSort = "date";
  
  List<Map<String, dynamic>> schedules = [
    {
      "id": 1,
      "title": "Daily Standup Meeting",
      "project": "Mobile App Development",
      "startTime": "09:00",
      "endTime": "09:30",
      "date": "2025-06-19",
      "type": "meeting",
      "status": "scheduled",
      "location": "Conference Room A",
      "attendees": ["John Doe", "Jane Smith", "Mike Johnson"],
      "priority": "medium",
      "recurring": "daily"
    },
    {
      "id": 2,
      "title": "Code Review Session",
      "project": "E-commerce Platform",
      "startTime": "14:00",
      "endTime": "16:00",
      "date": "2025-06-19",
      "type": "review",
      "status": "in_progress",
      "location": "Dev Room",
      "attendees": ["Sarah Wilson", "Tom Brown", "Lisa Davis"],
      "priority": "high",
      "recurring": "none"
    },
    {
      "id": 3,
      "title": "Client Presentation",
      "project": "Marketing Dashboard",
      "startTime": "10:00",
      "endTime": "11:30",
      "date": "2025-06-20",
      "type": "presentation",
      "status": "scheduled",
      "location": "Main Hall",
      "attendees": ["Alex Turner", "Emma White", "David Lee"],
      "priority": "critical",
      "recurring": "none"
    },
    {
      "id": 4,
      "title": "Sprint Planning",
      "project": "CRM System",
      "startTime": "13:00",
      "endTime": "15:00",
      "date": "2025-06-20",
      "type": "planning",
      "status": "scheduled",
      "location": "Planning Room",
      "attendees": ["Chris Martin", "Amy Johnson", "Ryan Cooper"],
      "priority": "high",
      "recurring": "weekly"
    },
    {
      "id": 5,
      "title": "Design Review",
      "project": "Mobile App Development",
      "startTime": "11:00",
      "endTime": "12:00",
      "date": "2025-06-21",
      "type": "review",
      "status": "scheduled",
      "location": "Design Studio",
      "attendees": ["Kate Wilson", "Jack Brown"],
      "priority": "medium",
      "recurring": "none"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "date"},
    {"label": "Priority", "value": "priority"},
    {"label": "Project", "value": "project"},
    {"label": "Status", "value": "status"}
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredSchedules() {
    List<Map<String, dynamic>> filtered = schedules;
    DateTime now = DateTime.now();

    switch (selectedFilter) {
      case "today":
        filtered = schedules.where((schedule) {
          DateTime scheduleDate = DateTime.parse(schedule["date"]);
          return scheduleDate.year == now.year &&
                 scheduleDate.month == now.month &&
                 scheduleDate.day == now.day;
        }).toList();
        break;
      case "week":
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        filtered = schedules.where((schedule) {
          DateTime scheduleDate = DateTime.parse(schedule["date"]);
          return scheduleDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
                 scheduleDate.isBefore(endOfWeek.add(Duration(days: 1)));
        }).toList();
        break;
      case "scheduled":
      case "in_progress":
      case "completed":
        filtered = schedules.where((schedule) => schedule["status"] == selectedFilter).toList();
        break;
    }

    // Sort
    switch (selectedSort) {
      case "date":
        filtered.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));
        break;
      case "priority":
        Map<String, int> priorityOrder = {"critical": 0, "high": 1, "medium": 2, "low": 3};
        filtered.sort((a, b) => priorityOrder[a["priority"]]!.compareTo(priorityOrder[b["priority"]]!));
        break;
      case "project":
        filtered.sort((a, b) => a["project"].compareTo(b["project"]));
        break;
      case "status":
        filtered.sort((a, b) => a["status"].compareTo(b["status"]));
        break;
    }

    return filtered;
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Schedule Management",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort by",
                  items: sortOptions,
                  value: selectedSort,
                  onChanged: (value, label) {
                    selectedSort = value;
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

  Widget _buildScheduleStats() {
    List<Map<String, dynamic>> filtered = _getFilteredSchedules();
    int totalSchedules = filtered.length;
    int todaySchedules = schedules.where((s) {
      DateTime scheduleDate = DateTime.parse(s["date"]);
      DateTime now = DateTime.now();
      return scheduleDate.year == now.year &&
             scheduleDate.month == now.month &&
             scheduleDate.day == now.day;
    }).length;
    int inProgress = filtered.where((s) => s["status"] == "in_progress").length;
    int critical = filtered.where((s) => s["priority"] == "critical").length;

    return Container(
      margin: EdgeInsets.all(spSm),
      child: Row(
        children: [
          _buildStatCard("Total", totalSchedules, primaryColor, Icons.schedule),
          _buildStatCard("Today", todaySchedules, infoColor, Icons.today),
          _buildStatCard("Active", inProgress, warningColor, Icons.play_circle),
          _buildStatCard("Critical", critical, dangerColor, Icons.priority_high),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spMd),
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
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: spSm),
            Text(
              "$value",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              title,
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

  Widget _buildSchedulesList() {
    List<Map<String, dynamic>> filtered = _getFilteredSchedules();

    if (filtered.isEmpty) {
      return Container(
        margin: EdgeInsets.all(spSm),
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.schedule,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No schedules found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try adjusting your filters to see more results",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: filtered.map((schedule) => _buildScheduleItem(schedule)).toList(),
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> schedule) {
    DateTime scheduleDate = DateTime.parse(schedule["date"]);
    bool isToday = scheduleDate.year == DateTime.now().year &&
                   scheduleDate.month == DateTime.now().month &&
                   scheduleDate.day == DateTime.now().day;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
          left: BorderSide(color: _getPriorityColor(schedule["priority"]), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(schedule["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getScheduleIcon(schedule["type"]),
                  color: _getStatusColor(schedule["status"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${schedule["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${schedule["project"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(schedule["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${schedule["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor(schedule["priority"]),
                      ),
                    ),
                  ),
                  if (schedule["recurring"] != "none") ...[
                    SizedBox(height: spXs),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, size: 12, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${schedule["recurring"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${schedule["startTime"]} - ${schedule["endTime"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                isToday ? "Today" : "${scheduleDate.day}/${scheduleDate.month}/${scheduleDate.year}",
                style: TextStyle(
                  fontSize: 14,
                  color: isToday ? primaryColor : disabledBoldColor,
                  fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${schedule["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${(schedule["attendees"] as List).length} attendees",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getScheduleIcon(String type) {
    switch (type) {
      case "meeting":
        return Icons.group;
      case "review":
        return Icons.rate_review;
      case "planning":
        return Icons.schedule;
      case "presentation":
        return Icons.present_to_all;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildScheduleStats(),
            _buildSchedulesList(),
          ],
        ),
      ),
    );
  }
}

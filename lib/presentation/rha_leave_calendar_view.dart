import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaLeaveCalendarView extends StatefulWidget {
  const RhaLeaveCalendarView({super.key});

  @override
  State<RhaLeaveCalendarView> createState() => _RhaLeaveCalendarViewState();
}

class _RhaLeaveCalendarViewState extends State<RhaLeaveCalendarView> {
  int currentTab = 0;
  String selectedMonth = "July 2024";
  String selectedDepartment = "All";
  String selectedLeaveType = "All";
  bool showTeamOnly = false;

  List<Map<String, dynamic>> calendarEvents = [
    {
      "id": "CAL001",
      "employee": "Sarah Johnson",
      "department": "Engineering",
      "leaveType": "Annual Leave",
      "startDate": "2024-07-15",
      "endDate": "2024-07-19",
      "days": 5,
      "status": "Approved",
      "color": primaryColor
    },
    {
      "id": "CAL002",
      "employee": "Michael Chen",
      "department": "Marketing",
      "leaveType": "Sick Leave",
      "startDate": "2024-07-01",
      "endDate": "2024-07-03",
      "days": 3,
      "status": "Approved",
      "color": warningColor
    },
    {
      "id": "CAL003",
      "employee": "Emily Rodriguez",
      "department": "Design",
      "leaveType": "Personal Leave",
      "startDate": "2024-07-08",
      "endDate": "2024-07-08",
      "days": 1,
      "status": "Approved",
      "color": infoColor
    },
    {
      "id": "CAL004",
      "employee": "James Wilson",
      "department": "Sales",
      "leaveType": "Annual Leave",
      "startDate": "2024-07-22",
      "endDate": "2024-07-26",
      "days": 5,
      "status": "Pending",
      "color": primaryColor
    },
    {
      "id": "CAL005",
      "employee": "Lisa Wong",
      "department": "HR",
      "leaveType": "Maternity Leave",
      "startDate": "2024-07-30",
      "endDate": "2024-10-28",
      "days": 90,
      "status": "Approved",
      "color": successColor
    },
    {
      "id": "CAL006",
      "employee": "David Park",
      "department": "Marketing",
      "leaveType": "Annual Leave",
      "startDate": "2024-08-05",
      "endDate": "2024-08-09",
      "days": 5,
      "status": "Approved",
      "color": primaryColor
    },
    {
      "id": "CAL007",
      "employee": "Anna Kim",
      "department": "HR",
      "leaveType": "Personal Leave",
      "startDate": "2024-08-12",
      "endDate": "2024-08-12",
      "days": 1,
      "status": "Pending",
      "color": infoColor
    }
  ];

  List<Map<String, dynamic>> publicHolidays = [
    {
      "name": "Independence Day",
      "date": "2024-07-04",
      "type": "National Holiday"
    },
    {
      "name": "Labor Day",
      "date": "2024-09-02",
      "type": "National Holiday"
    },
    {
      "name": "Christmas Day",
      "date": "2024-12-25",
      "type": "National Holiday"
    }
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Design", "value": "Design"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"}
  ];

  List<Map<String, dynamic>> leaveTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Annual Leave", "value": "Annual Leave"},
    {"label": "Sick Leave", "value": "Sick Leave"},
    {"label": "Personal Leave", "value": "Personal Leave"},
    {"label": "Maternity/Paternity", "value": "Maternity/Paternity"}
  ];

  List<Map<String, dynamic>> monthItems = [
    {"label": "July 2024", "value": "July 2024"},
    {"label": "August 2024", "value": "August 2024"},
    {"label": "September 2024", "value": "September 2024"},
    {"label": "October 2024", "value": "October 2024"}
  ];

  Color _getLeaveTypeColor(String leaveType) {
    switch (leaveType) {
      case "Annual Leave":
        return primaryColor;
      case "Sick Leave":
        return warningColor;
      case "Personal Leave":
        return infoColor;
      case "Maternity/Paternity":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Calendar Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave Calendar",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        QButton(
                          icon: Icons.chevron_left,
                          size: bs.sm,
                          onPressed: () {
                            ss("Previous month");
                          },
                        ),
                        QButton(
                          icon: Icons.chevron_right,
                          size: bs.sm,
                          onPressed: () {
                            ss("Next month");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Month",
                        items: monthItems,
                        value: selectedMonth,
                        onChanged: (value, label) {
                          selectedMonth = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentItems,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Calendar Grid
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                // Week Days Header
                Row(
                  children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      .map((day) => Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              child: Text(
                                day,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),

                // Calendar Days
                ...List.generate(5, (weekIndex) => Row(
                      children: List.generate(7, (dayIndex) {
                        final dayNumber = weekIndex * 7 + dayIndex + 1;
                        final hasLeave = calendarEvents.any((event) {
                          final startDate = DateTime.parse("${event["startDate"]}");
                          final endDate = DateTime.parse("${event["endDate"]}");
                          final currentDate = DateTime(2024, 7, dayNumber);
                          return currentDate.isAfter(startDate.subtract(Duration(days: 1))) &&
                              currentDate.isBefore(endDate.add(Duration(days: 1)));
                        });

                        final dayEvents = calendarEvents.where((event) {
                          final startDate = DateTime.parse("${event["startDate"]}");
                          final endDate = DateTime.parse("${event["endDate"]}");
                          final currentDate = DateTime(2024, 7, dayNumber);
                          return currentDate.isAfter(startDate.subtract(Duration(days: 1))) &&
                              currentDate.isBefore(endDate.add(Duration(days: 1)));
                        }).toList();

                        return Expanded(
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: hasLeave ? primaryColor.withAlpha(10) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: hasLeave ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  child: Text(
                                    "$dayNumber",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      children: dayEvents.take(2).map((event) => Container(
                                        margin: EdgeInsets.only(bottom: 2),
                                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: event["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${event["employee"]}".split(" ")[0],
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )).toList(),
              ],
            ),
          ),

          // Leave Types Legend
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Leave Types",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: spMd,
                  runSpacing: spSm,
                  children: [
                    _buildLegendItem("Annual Leave", primaryColor),
                    _buildLegendItem("Sick Leave", warningColor),
                    _buildLegendItem("Personal Leave", infoColor),
                    _buildLegendItem("Maternity/Paternity", successColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    final upcomingLeaves = calendarEvents.where((event) {
      final startDate = DateTime.parse("${event["startDate"]}");
      return startDate.isAfter(DateTime.now());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.upcoming,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upcoming Leaves",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${upcomingLeaves.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.people,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "This Week",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${upcomingLeaves.where((leave) {
                                  final startDate = DateTime.parse("${leave["startDate"]}");
                                  final now = DateTime.now();
                                  final weekStart = now.subtract(Duration(days: now.weekday - 1));
                                  final weekEnd = weekStart.add(Duration(days: 6));
                                  return startDate.isAfter(weekStart.subtract(Duration(days: 1))) &&
                                      startDate.isBefore(weekEnd.add(Duration(days: 1)));
                                }).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "This Month",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${upcomingLeaves.where((leave) {
                                  final startDate = DateTime.parse("${leave["startDate"]}");
                                  final now = DateTime.now();
                                  return startDate.month == now.month && startDate.year == now.year;
                                }).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Leave Type",
                  items: leaveTypeItems,
                  value: selectedLeaveType,
                  onChanged: (value, label) {
                    selectedLeaveType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Upcoming Leaves List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Upcoming Leave Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...upcomingLeaves.map((leave) => Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: _getLeaveTypeColor("${leave["leaveType"]}").withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: _getLeaveTypeColor("${leave["leaveType"]}").withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Header
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: _getLeaveTypeColor("${leave["leaveType"]}").withAlpha(20),
                            child: Text(
                              "${leave["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getLeaveTypeColor("${leave["leaveType"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${leave["employee"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${leave["status"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${leave["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${leave["status"]}"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${leave["department"]}",
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

                      // Leave Details
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getLeaveTypeColor("${leave["leaveType"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${leave["leaveType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${leave["days"]} day${(leave["days"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getLeaveTypeColor("${leave["leaveType"]}"),
                            ),
                          ),
                        ],
                      ),

                      // Dates
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse("${leave["startDate"]}").dMMMy} - ${DateTime.parse("${leave["endDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Days until leave
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: infoColor),
                            SizedBox(width: spXs),
                            Text(
                              "Starts in ${DateTime.parse("${leave["startDate"]}").difference(DateTime.now()).inDays} days",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidaysTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Holiday Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Public Holiday",
              icon: Icons.add,
              onPressed: () {
                ss("Add public holiday clicked");
              },
            ),
          ),

          // Public Holidays
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Public Holidays 2024",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...publicHolidays.map((holiday) => Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.celebration,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${holiday["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${holiday["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${DateTime.parse("${holiday["date"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse("${holiday["date"]}").difference(DateTime.now()).inDays} days",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Holiday Impact
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Holiday Impact Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Long Weekends",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "3",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Expected higher leave requests",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Working Days",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "252",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Total working days in 2024",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
            shape: BoxShape.circle,
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Leave Calendar",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Calendar", icon: Icon(Icons.calendar_view_month)),
        Tab(text: "Upcoming", icon: Icon(Icons.upcoming)),
        Tab(text: "Holidays", icon: Icon(Icons.celebration)),
      ],
      tabChildren: [
        _buildCalendarTab(),
        _buildUpcomingTab(),
        _buildHolidaysTab(),
      ],
    );
  }
}

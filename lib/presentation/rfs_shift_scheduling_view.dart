import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsShiftSchedulingView extends StatefulWidget {
  const RfsShiftSchedulingView({super.key});

  @override
  State<RfsShiftSchedulingView> createState() => _RfsShiftSchedulingViewState();
}

class _RfsShiftSchedulingViewState extends State<RfsShiftSchedulingView> {
  int currentTab = 0;
  String selectedWeek = "Current Week";
  String selectedDepartment = "";
  
  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> timeSlots = ["Morning", "Afternoon", "Evening"];

  List<Map<String, dynamic>> weekOptions = [
    {"label": "Current Week", "value": "Current Week"},
    {"label": "Next Week", "value": "Next Week"},
    {"label": "Week of Nov 18", "value": "Week of Nov 18"},
    {"label": "Week of Nov 25", "value": "Week of Nov 25"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Kitchen", "value": "Kitchen"},
    {"label": "Front of House", "value": "Front of House"},
    {"label": "Bar", "value": "Bar"},
    {"label": "Management", "value": "Management"},
  ];

  List<Map<String, dynamic>> shifts = [
    {
      "id": "SH001",
      "employee_name": "John Smith",
      "employee_id": "EMP001",
      "position": "Head Chef",
      "department": "Kitchen",
      "day": "Mon",
      "start_time": "06:00",
      "end_time": "14:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "12:00-12:30",
    },
    {
      "id": "SH002",
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP002",
      "position": "Sous Chef",
      "department": "Kitchen",
      "day": "Mon",
      "start_time": "07:00",
      "end_time": "15:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "13:00-13:30",
    },
    {
      "id": "SH003",
      "employee_name": "Mike Wilson",
      "employee_id": "EMP003",
      "position": "Server",
      "department": "Front of House",
      "day": "Mon",
      "start_time": "11:00",
      "end_time": "19:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "15:00-15:30",
    },
    {
      "id": "SH004",
      "employee_name": "Emily Davis",
      "employee_id": "EMP004",
      "position": "Bartender",
      "department": "Bar",
      "day": "Mon",
      "start_time": "16:00",
      "end_time": "24:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "20:00-20:30",
    },
    {
      "id": "SH005",
      "employee_name": "John Smith",
      "employee_id": "EMP001",
      "position": "Head Chef",
      "department": "Kitchen",
      "day": "Tue",
      "start_time": "06:00",
      "end_time": "14:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "12:00-12:30",
    },
    {
      "id": "SH006",
      "employee_name": "Mike Wilson",
      "employee_id": "EMP003",
      "position": "Server",
      "department": "Front of House",
      "day": "Tue",
      "start_time": "17:00",
      "end_time": "23:00",
      "duration": 6,
      "status": "Requested Off",
      "break_time": "20:00-20:15",
    },
    {
      "id": "SH007",
      "employee_name": "Lisa Garcia",
      "employee_id": "EMP006",
      "position": "Manager",
      "department": "Management",
      "day": "Wed",
      "start_time": "09:00",
      "end_time": "17:00",
      "duration": 8,
      "status": "Scheduled",
      "break_time": "13:00-14:00",
    },
  ];

  List<Map<String, dynamic>> shiftRequests = [
    {
      "id": "REQ001",
      "employee_name": "Mike Wilson",
      "employee_id": "EMP003",
      "request_type": "Time Off",
      "date": "2024-11-22",
      "reason": "Family event",
      "status": "Pending",
      "submitted_date": "2024-11-10",
    },
    {
      "id": "REQ002",
      "employee_name": "Emily Davis",
      "employee_id": "EMP004",
      "request_type": "Shift Swap",
      "date": "2024-11-24",
      "reason": "Personal appointment",
      "status": "Approved",
      "submitted_date": "2024-11-08",
      "swap_with": "David Brown",
    },
    {
      "id": "REQ003",
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP002",
      "request_type": "Extra Shift",
      "date": "2024-11-25",
      "reason": "Additional hours needed",
      "status": "Pending",
      "submitted_date": "2024-11-12",
    },
  ];

  List<Map<String, dynamic>> get filteredShifts {
    return shifts.where((shift) {
      bool matchesDepartment = selectedDepartment.isEmpty || shift["department"] == selectedDepartment;
      return matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shift Scheduling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "Requests", icon: Icon(Icons.request_page)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildRequestsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildScheduleFilters(),
          _buildScheduleStats(),
          _buildWeeklySchedule(),
        ],
      ),
    );
  }

  Widget _buildScheduleFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Week",
            items: weekOptions,
            value: selectedWeek,
            onChanged: (value, label) {
              selectedWeek = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Department",
            items: departments,
            value: selectedDepartment,
            onChanged: (value, label) {
              selectedDepartment = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleStats() {
    int totalShifts = filteredShifts.length;
    int scheduledShifts = filteredShifts.where((s) => s["status"] == "Scheduled").length;
    double totalHours = filteredShifts.fold(0.0, (sum, shift) => sum + (shift["duration"] as int));
    int openShifts = filteredShifts.where((s) => s["status"] == "Open").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 160,
      children: [
        _buildStatCard("Total Shifts", "$totalShifts", Icons.schedule, primaryColor),
        _buildStatCard("Scheduled", "$scheduledShifts", Icons.check_circle, successColor),
        _buildStatCard("Total Hours", "${totalHours.toStringAsFixed(0)}", Icons.access_time, infoColor),
        _buildStatCard("Open Shifts", "$openShifts", Icons.warning, warningColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
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

  Widget _buildWeeklySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Weekly Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add Shift",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Header row
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    ...weekDays.map((day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              // Schedule grid
              ...timeSlots.map((timeSlot) => _buildTimeSlotRow(timeSlot)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotRow(String timeSlot) {
    String timeRange = timeSlot == "Morning" ? "6AM-2PM" 
                     : timeSlot == "Afternoon" ? "2PM-10PM" 
                     : "10PM-6AM";

    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledColor.withAlpha(30)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeSlot,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  timeRange,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          ...weekDays.map((day) => Expanded(
            child: _buildDayShifts(day, timeSlot),
          )),
        ],
      ),
    );
  }

  Widget _buildDayShifts(String day, String timeSlot) {
    List<Map<String, dynamic>> dayShifts = filteredShifts.where((shift) {
      String shiftDay = shift["day"] as String;
      String startTime = shift["start_time"] as String;
      int startHour = int.parse(startTime.split(":")[0]);
      
      bool matchesDay = shiftDay == day;
      bool matchesTimeSlot = (timeSlot == "Morning" && startHour >= 6 && startHour < 14) ||
                           (timeSlot == "Afternoon" && startHour >= 14 && startHour < 22) ||
                           (timeSlot == "Evening" && (startHour >= 22 || startHour < 6));
      
      return matchesDay && matchesTimeSlot;
    }).toList();

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: spXs),
      child: Column(
        children: dayShifts.take(2).map((shift) => _buildShiftChip(shift)).toList(),
      ),
    );
  }

  Widget _buildShiftChip(Map<String, dynamic> shift) {
    Color statusColor = shift["status"] == "Scheduled" 
        ? successColor 
        : shift["status"] == "Requested Off"
        ? warningColor
        : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${shift["employee_name"]}",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${shift["start_time"]}-${shift["end_time"]}",
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRequestsStats(),
          _buildRequestsList(),
        ],
      ),
    );
  }

  Widget _buildRequestsStats() {
    int pendingRequests = shiftRequests.where((r) => r["status"] == "Pending").length;
    int approvedRequests = shiftRequests.where((r) => r["status"] == "Approved").length;
    int deniedRequests = shiftRequests.where((r) => r["status"] == "Denied").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 140,
      children: [
        _buildStatCard("Pending", "$pendingRequests", Icons.pending, warningColor),
        _buildStatCard("Approved", "$approvedRequests", Icons.check_circle, successColor),
        _buildStatCard("Denied", "$deniedRequests", Icons.cancel, dangerColor),
        _buildStatCard("Total", "${shiftRequests.length}", Icons.list, primaryColor),
      ],
    );
  }

  Widget _buildRequestsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Shift Requests",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...shiftRequests.map((request) => _buildRequestCard(request)),
      ],
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color statusColor = request["status"] == "Pending" 
        ? warningColor 
        : request["status"] == "Approved"
        ? successColor
        : dangerColor;

    IconData requestIcon;
    switch (request["request_type"]) {
      case "Time Off":
        requestIcon = Icons.event_busy;
        break;
      case "Shift Swap":
        requestIcon = Icons.swap_horiz;
        break;
      case "Extra Shift":
        requestIcon = Icons.add_circle;
        break;
      default:
        requestIcon = Icons.help;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Icon(requestIcon, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${request["employee_name"]} - ${request["request_type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Date: ${request["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${request["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Reason: ${request["reason"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if (request["swap_with"] != null)
            Text(
              "Swap with: ${request["swap_with"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          Text(
            "Submitted: ${request["submitted_date"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
          if (request["status"] == "Pending") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Deny",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildShiftAnalytics(),
          _buildDepartmentWorkload(),
          _buildOvertimeAnalysis(),
        ],
      ),
    );
  }

  Widget _buildShiftAnalytics() {
    Map<String, int> shiftsByDay = {};
    for (String day in weekDays) {
      shiftsByDay[day] = shifts.where((s) => s["day"] == day).length;
    }

    return Container(
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
            "Shifts by Day",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...shiftsByDay.entries.map((entry) => 
            Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: entry.value / shifts.length * 7,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${entry.value}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentWorkload() {
    Map<String, double> departmentHours = {};
    for (var shift in shifts) {
      String dept = shift["department"] as String;
      int duration = shift["duration"] as int;
      departmentHours[dept] = (departmentHours[dept] ?? 0) + duration;
    }

    return Container(
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
            "Department Workload (Hours)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 140,
            children: departmentHours.entries.map((entry) => 
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${entry.value.toStringAsFixed(0)}h",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      entry.key,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOvertimeAnalysis() {
    int totalEmployees = Set.from(shifts.map((s) => s["employee_id"])).length;
    double avgHoursPerEmployee = shifts.fold(0.0, (sum, shift) => sum + (shift["duration"] as int)) / totalEmployees;
    int overtimeShifts = shifts.where((s) => (s["duration"] as int) > 8).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 160,
      children: [
        _buildAnalyticsCard("Avg Hours/Employee", "${avgHoursPerEmployee.toStringAsFixed(1)}", Icons.person, primaryColor),
        _buildAnalyticsCard("Overtime Shifts", "$overtimeShifts", Icons.warning, warningColor),
        _buildAnalyticsCard("Total Employees", "$totalEmployees", Icons.people, successColor),
        _buildAnalyticsCard("Coverage Rate", "92%", Icons.check_circle, infoColor),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
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
}

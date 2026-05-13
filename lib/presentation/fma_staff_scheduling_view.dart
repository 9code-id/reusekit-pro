import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaStaffSchedulingView extends StatefulWidget {
  const FmaStaffSchedulingView({super.key});

  @override
  State<FmaStaffSchedulingView> createState() => _FmaStaffSchedulingViewState();
}

class _FmaStaffSchedulingViewState extends State<FmaStaffSchedulingView> {
  int currentTab = 0;
  String selectedWeek = "current";
  String selectedDepartment = "All";
  String selectedShift = "All";

  List<Map<String, dynamic>> weekOptions = [
    {"label": "Current Week", "value": "current"},
    {"label": "Next Week", "value": "next"},
    {"label": "Previous Week", "value": "previous"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Service", "value": "service"},
    {"label": "Bar", "value": "bar"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> shiftOptions = [
    {"label": "All Shifts", "value": "All"},
    {"label": "Morning", "value": "morning"},
    {"label": "Afternoon", "value": "afternoon"},
    {"label": "Evening", "value": "evening"},
    {"label": "Night", "value": "night"},
  ];

  List<Map<String, dynamic>> staff = [
    {
      "id": "STAFF001",
      "name": "Alice Johnson",
      "position": "Head Chef",
      "department": "kitchen",
      "phone": "+1 234-567-8900",
      "email": "alice.johnson@restaurant.com",
      "hourly_rate": 28.50,
      "status": "active",
      "shifts_this_week": 5,
      "hours_this_week": 42.5,
      "availability": ["monday", "tuesday", "wednesday", "thursday", "friday"],
    },
    {
      "id": "STAFF002",
      "name": "Bob Smith",
      "position": "Server",
      "department": "service",
      "phone": "+1 234-567-8901",
      "email": "bob.smith@restaurant.com",
      "hourly_rate": 15.75,
      "status": "active",
      "shifts_this_week": 4,
      "hours_this_week": 32.0,
      "availability": ["wednesday", "thursday", "friday", "saturday", "sunday"],
    },
    {
      "id": "STAFF003",
      "name": "Carol Davis",
      "position": "Bartender",
      "department": "bar",
      "phone": "+1 234-567-8902",
      "email": "carol.davis@restaurant.com",
      "hourly_rate": 18.25,
      "status": "active",
      "shifts_this_week": 5,
      "hours_this_week": 40.0,
      "availability": ["monday", "tuesday", "friday", "saturday", "sunday"],
    },
    {
      "id": "STAFF004",
      "name": "David Wilson",
      "position": "Sous Chef",
      "department": "kitchen",
      "phone": "+1 234-567-8903",
      "email": "david.wilson@restaurant.com",
      "hourly_rate": 22.00,
      "status": "active",
      "shifts_this_week": 4,
      "hours_this_week": 38.5,
      "availability": ["tuesday", "wednesday", "thursday", "saturday", "sunday"],
    },
    {
      "id": "STAFF005",
      "name": "Emma Brown",
      "position": "Host",
      "department": "service",
      "phone": "+1 234-567-8904",
      "email": "emma.brown@restaurant.com",
      "hourly_rate": 14.50,
      "status": "part_time",
      "shifts_this_week": 3,
      "hours_this_week": 18.0,
      "availability": ["friday", "saturday", "sunday"],
    },
  ];

  List<Map<String, dynamic>> schedules = [
    {
      "id": "SCH001",
      "staff_id": "STAFF001",
      "staff_name": "Alice Johnson",
      "date": "2024-06-17",
      "day": "Monday",
      "shift": "morning",
      "start_time": "08:00",
      "end_time": "16:00",
      "hours": 8.0,
      "position": "Head Chef",
      "status": "scheduled",
    },
    {
      "id": "SCH002",
      "staff_id": "STAFF002",
      "staff_name": "Bob Smith",
      "date": "2024-06-17",
      "day": "Monday",
      "shift": "evening",
      "start_time": "17:00",
      "end_time": "23:00",
      "hours": 6.0,
      "position": "Server",
      "status": "scheduled",
    },
    {
      "id": "SCH003",
      "staff_id": "STAFF003",
      "staff_name": "Carol Davis",
      "date": "2024-06-17",
      "day": "Monday",
      "shift": "evening",
      "start_time": "18:00",
      "end_time": "02:00",
      "hours": 8.0,
      "position": "Bartender",
      "status": "scheduled",
    },
    {
      "id": "SCH004",
      "staff_id": "STAFF004",
      "staff_name": "David Wilson",
      "date": "2024-06-18",
      "day": "Tuesday",
      "shift": "afternoon",
      "start_time": "14:00",
      "end_time": "22:00",
      "hours": 8.0,
      "position": "Sous Chef",
      "status": "scheduled",
    },
    {
      "id": "SCH005",
      "staff_id": "STAFF005",
      "staff_name": "Emma Brown",
      "date": "2024-06-19",
      "day": "Wednesday",
      "shift": "evening",
      "start_time": "17:00",
      "end_time": "23:00",
      "hours": 6.0,
      "position": "Host",
      "status": "requested_off",
    },
  ];

  List<Map<String, dynamic>> timeOffRequests = [
    {
      "id": "TOR001",
      "staff_name": "Bob Smith",
      "staff_id": "STAFF002",
      "start_date": "2024-06-20",
      "end_date": "2024-06-22",
      "reason": "Family vacation",
      "type": "vacation",
      "status": "pending",
      "submitted_date": "2024-06-10",
    },
    {
      "id": "TOR002",
      "staff_name": "Carol Davis",
      "staff_id": "STAFF003",
      "start_date": "2024-06-25",
      "end_date": "2024-06-25",
      "reason": "Doctor appointment",
      "type": "personal",
      "status": "approved",
      "submitted_date": "2024-06-12",
    },
    {
      "id": "TOR003",
      "staff_name": "Emma Brown",
      "staff_id": "STAFF005",
      "start_date": "2024-06-19",
      "end_date": "2024-06-19",
      "reason": "Sick day",
      "type": "sick",
      "status": "approved",
      "submitted_date": "2024-06-19",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Staff Scheduling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
        Tab(text: "Time Off", icon: Icon(Icons.event_busy)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildStaffTab(),
        _buildTimeOffTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    List<Map<String, dynamic>> filteredSchedules = schedules.where((schedule) {
      bool matchesDepartment = selectedDepartment == "All" || 
          staff.firstWhere((s) => s["id"] == schedule["staff_id"])["department"] == selectedDepartment;
      bool matchesShift = selectedShift == "All" || schedule["shift"] == selectedShift;
      return matchesDepartment && matchesShift;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Schedule Filters
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
                QDropdownField(
                  label: "Week",
                  items: weekOptions,
                  value: selectedWeek,
                  onChanged: (value, label) {
                    selectedWeek = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentOptions,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Shift",
                        items: shiftOptions,
                        value: selectedShift,
                        onChanged: (value, label) {
                          selectedShift = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Schedule Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "This Week's Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${staff.fold(0.0, (sum, s) => sum + (s["hours_this_week"] as num).toDouble()).toInt()}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Hours",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${staff.where((s) => s["status"] == "active").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active Staff",
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
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Shift",
                        size: bs.md,
                        onPressed: () {
                          // Add new shift
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Auto Schedule",
                        size: bs.md,
                        onPressed: () {
                          // Auto schedule
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Schedule List
          ...filteredSchedules.map((schedule) {
            Color statusColor = _getScheduleStatusColor(schedule["status"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: statusColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${schedule["staff_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${schedule["position"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${schedule["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${schedule["day"]}, ${schedule["date"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shift",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${schedule["shift"]}".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${schedule["start_time"]} - ${schedule["end_time"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hours",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${schedule["hours"]} hrs",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            // Edit schedule
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Copy",
                          size: bs.sm,
                          onPressed: () {
                            // Copy schedule
                          },
                        ),
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

  Widget _buildStaffTab() {
    List<Map<String, dynamic>> filteredStaff = staff.where((member) {
      bool matchesDepartment = selectedDepartment == "All" || member["department"] == selectedDepartment;
      return matchesDepartment;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Staff Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Staff Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${staff.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Staff",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${((staff.fold(0.0, (sum, s) => sum + (s["hourly_rate"] as num).toDouble()) / staff.length)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg Hourly Rate",
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
              ],
            ),
          ),

          // Department Filter
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Filter by Department",
              items: departmentOptions,
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),
          ),

          // Add Staff Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Staff Member",
              size: bs.md,
              onPressed: () {
                // Add new staff member
              },
            ),
          ),

          // Staff List
          ...filteredStaff.map((member) {
            Color statusColor = member["status"] == "active" ? successColor : warningColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
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
                      CircleAvatar(
                        backgroundColor: statusColor.withAlpha(100),
                        child: Text(
                          member["name"].toString().split(" ").map((n) => n[0]).join(""),
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${member["position"]} • ${member["department"]}".replaceAll("_", " "),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${member["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hourly Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((member["hourly_rate"] as num).toDouble()).currency}/hr",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This Week",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${member["hours_this_week"]} hrs",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Contact: ${member["phone"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Available: ${(member["availability"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Profile",
                          size: bs.sm,
                          onPressed: () {
                            // View staff profile
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule",
                          size: bs.sm,
                          onPressed: () {
                            // Schedule staff member
                          },
                        ),
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

  Widget _buildTimeOffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Time Off Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Time Off Requests",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: warningColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${timeOffRequests.where((r) => r["status"] == "pending").length}",
                              style: TextStyle(
                                fontSize: 24,
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${timeOffRequests.where((r) => r["status"] == "approved").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Approved",
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
              ],
            ),
          ),

          // Time Off Requests List
          ...timeOffRequests.map((request) {
            Color statusColor = _getTimeOffStatusColor(request["status"]);
            Color typeColor = _getTimeOffTypeColor(request["type"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: statusColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${request["staff_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Submitted: ${request["submitted_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${request["type"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: typeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${request["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${request["start_date"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${request["end_date"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Reason: ${request["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  if (request["status"] == "pending")
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Approve",
                            size: bs.sm,
                            onPressed: () {
                              // Approve request
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Deny",
                            size: bs.sm,
                            onPressed: () {
                              // Deny request
                            },
                          ),
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

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Labor Cost Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Labor Cost Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$3,247.50",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total labor cost this week",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Department Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Department Labor Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Kitchen",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "45%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Service",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "35%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Bar",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "20%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Export Options
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Export Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Schedule Report (PDF)",
                    size: bs.md,
                    onPressed: () {
                      // Export schedule report
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Payroll Report (CSV)",
                    size: bs.md,
                    onPressed: () {
                      // Export payroll report
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getScheduleStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return successColor;
      case "requested_off":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getTimeOffStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "pending":
        return warningColor;
      case "denied":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getTimeOffTypeColor(String type) {
    switch (type) {
      case "vacation":
        return infoColor;
      case "sick":
        return dangerColor;
      case "personal":
        return warningColor;
      default:
        return primaryColor;
    }
  }
}

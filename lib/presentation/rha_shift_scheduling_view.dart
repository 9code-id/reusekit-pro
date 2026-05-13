import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaShiftSchedulingView extends StatefulWidget {
  const RhaShiftSchedulingView({super.key});

  @override
  State<RhaShiftSchedulingView> createState() => _RhaShiftSchedulingViewState();
}

class _RhaShiftSchedulingViewState extends State<RhaShiftSchedulingView> {
  int currentTab = 0;
  String selectedWeek = "current";
  String selectedDepartment = "all";
  String selectedLocation = "all";
  DateTime selectedDate = DateTime.now();
  bool showAvailableOnly = false;

  List<Map<String, dynamic>> shiftData = [
    {
      "id": "SH001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "date": "2024-12-16",
      "startTime": "09:00",
      "endTime": "17:00",
      "breakDuration": 60,
      "location": "Office A",
      "status": "scheduled",
      "type": "regular",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "skills": ["Flutter", "Backend", "UI/UX"],
    },
    {
      "id": "SH002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "date": "2024-12-16",
      "startTime": "10:00",
      "endTime": "18:00",
      "breakDuration": 60,
      "location": "Office B",
      "status": "confirmed",
      "type": "overtime",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "skills": ["Digital Marketing", "SEO", "Analytics"],
    },
    {
      "id": "SH003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "date": "2024-12-17",
      "startTime": "08:00",
      "endTime": "16:00",
      "breakDuration": 60,
      "location": "Remote",
      "status": "pending",
      "type": "flexible",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "skills": ["Figma", "Prototyping", "User Research"],
    }
  ];

  List<Map<String, dynamic>> availabilityData = [
    {
      "employeeId": "EMP001",
      "employee": "Sarah Johnson",
      "date": "2024-12-18",
      "timeSlots": [
        {"start": "09:00", "end": "12:00", "available": true},
        {"start": "13:00", "end": "17:00", "available": true},
        {"start": "18:00", "end": "20:00", "available": false},
      ]
    },
    {
      "employeeId": "EMP002",
      "employee": "Michael Chen",
      "date": "2024-12-18",
      "timeSlots": [
        {"start": "10:00", "end": "14:00", "available": true},
        {"start": "15:00", "end": "18:00", "available": false},
        {"start": "19:00", "end": "21:00", "available": true},
      ]
    }
  ];

  List<Map<String, dynamic>> weekOptions = [
    {"label": "Current Week", "value": "current"},
    {"label": "Next Week", "value": "next"},
    {"label": "Week of Dec 23", "value": "dec23"},
    {"label": "Week of Dec 30", "value": "dec30"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Design", "value": "design"},
    {"label": "Sales", "value": "sales"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
    {"label": "Office A", "value": "office_a"},
    {"label": "Office B", "value": "office_b"},
    {"label": "Remote", "value": "remote"},
    {"label": "Client Site", "value": "client_site"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shift Scheduling",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "Shifts", icon: Icon(Icons.schedule)),
        Tab(text: "Availability", icon: Icon(Icons.access_time)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCalendarTab(),
        _buildShiftsTab(),
        _buildAvailabilityTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Date Selection
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
                Text(
                  "Schedule Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Select Date",
                        value: selectedDate,
                        onChanged: (value) {
                          selectedDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      label: "Today",
                      size: bs.sm,
                      onPressed: () {
                        selectedDate = DateTime.now();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Shifts", "24", Icons.schedule, primaryColor),
              _buildStatCard("Confirmed", "18", Icons.check_circle, successColor),
              _buildStatCard("Pending", "4", Icons.pending, warningColor),
              _buildStatCard("Overtime Shifts", "6", Icons.more_time, infoColor),
            ],
          ),

          // Daily Schedule
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
                    Text(
                      "Schedule for ${selectedDate.dMMMy}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Shift",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () => _addNewShift(),
                    ),
                  ],
                ),
                
                // Time Slots
                ...List.generate(12, (index) {
                  int hour = 8 + index;
                  String timeSlot = "${hour.toString().padLeft(2, '0')}:00";
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Row(
                              children: [
                                if (index < 6) // Add some shifts for demo
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: spXs),
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(color: primaryColor.withAlpha(40)),
                                      ),
                                      child: Text(
                                        "S. Johnson - Engineering",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
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
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locationOptions,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show available employees only",
                            "value": true,
                            "checked": showAvailableOnly,
                          }
                        ],
                        value: [
                          if (showAvailableOnly)
                            {
                              "label": "Show available employees only",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          showAvailableOnly = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      label: "Auto Schedule",
                      icon: Icons.auto_awesome,
                      size: bs.sm,
                      onPressed: () => _autoSchedule(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Shifts List
          ...shiftData.map((shift) => _buildShiftCard(shift)),
        ],
      ),
    );
  }

  Widget _buildAvailabilityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Availability Management
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
                    Text(
                      "Employee Availability",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Set Availability",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () => _setAvailability(),
                    ),
                  ],
                ),
                
                // Date Selection for Availability
                QDatePicker(
                  label: "View availability for",
                  value: selectedDate,
                  onChanged: (value) {
                    selectedDate = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Availability Grid
          ...availabilityData.map((availability) => _buildAvailabilityCard(availability)),
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
          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Avg Shifts/Week", "42", "+5.2% vs last week", successColor),
              _buildAnalyticsCard("Overtime Hours", "28", "+12% vs last week", warningColor),
              _buildAnalyticsCard("Coverage Rate", "94%", "+2% vs last week", successColor),
              _buildAnalyticsCard("No-Shows", "2", "-3 vs last week", successColor),
            ],
          ),

          // Department Performance
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
                  "Department Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final departments = [
                    {"name": "Engineering", "coverage": 96, "shifts": 45, "color": primaryColor},
                    {"name": "Marketing", "coverage": 92, "shifts": 38, "color": successColor},
                    {"name": "Design", "coverage": 89, "shifts": 32, "color": warningColor},
                    {"name": "Sales", "coverage": 94, "shifts": 41, "color": infoColor},
                  ];
                  final dept = departments[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (dept["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.business,
                            color: dept["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dept["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${dept["shifts"]} shifts scheduled",
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
                              "${dept["coverage"]}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: dept["color"] as Color,
                              ),
                            ),
                            Text(
                              "Coverage",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Shift Type Distribution
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
                Text(
                  "Shift Type Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final shiftTypes = [
                    {"type": "Regular Shifts", "count": 156, "percentage": 65, "color": primaryColor},
                    {"type": "Overtime Shifts", "count": 48, "percentage": 20, "color": warningColor},
                    {"type": "Flexible Shifts", "count": 24, "percentage": 10, "color": infoColor},
                    {"type": "On-Call Shifts", "count": 12, "percentage": 5, "color": successColor},
                  ];
                  final shiftType = shiftTypes[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: shiftType["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${shiftType["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${shiftType["count"]} shifts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${shiftType["percentage"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: shiftType["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, Color changeColor) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> shift) {
    Color statusColor = shift["status"] == "confirmed" 
        ? successColor 
        : shift["status"] == "scheduled" 
            ? primaryColor 
            : warningColor;
            
    Color typeColor = shift["type"] == "overtime" 
        ? warningColor 
        : shift["type"] == "flexible" 
            ? infoColor 
            : primaryColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${shift["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${shift["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${shift["department"]} • ${shift["position"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${shift["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: typeColor,
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
                      "Date & Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${shift["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${shift["startTime"]} - ${shift["endTime"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                      "Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${shift["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${shift["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          // Skills
          if (shift["skills"] != null && (shift["skills"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (shift["skills"] as List).map((skill) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Text(
                  "$skill",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewShiftDetails(shift),
                ),
              ),
              if (shift["status"] == "scheduled") ...[
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _confirmShift(shift),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editShift(shift),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityCard(Map<String, dynamic> availability) {
    return Container(
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
              Text(
                "${availability["employee"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${availability["date"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Time Slots
          Column(
            spacing: spXs,
            children: (availability["timeSlots"] as List).map((slot) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (slot["available"] as bool) 
                    ? successColor.withAlpha(10) 
                    : dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: (slot["available"] as bool) 
                      ? successColor.withAlpha(40) 
                      : dangerColor.withAlpha(40),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    (slot["available"] as bool) ? Icons.check_circle : Icons.cancel,
                    color: (slot["available"] as bool) ? successColor : dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${slot["start"]} - ${slot["end"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: (slot["available"] as bool) ? successColor : dangerColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    (slot["available"] as bool) ? "Available" : "Unavailable",
                    style: TextStyle(
                      fontSize: 12,
                      color: (slot["available"] as bool) ? successColor : dangerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  void _addNewShift() {
    // Navigate to add new shift form
  }

  void _autoSchedule() {
    // Navigate to auto schedule functionality
  }

  void _setAvailability() {
    // Navigate to set availability form
  }

  void _viewShiftDetails(Map<String, dynamic> shift) {
    // Navigate to shift details view
  }

  void _confirmShift(Map<String, dynamic> shift) {
    shift["status"] = "confirmed";
    setState(() {});
    ss("Shift confirmed successfully");
  }

  void _editShift(Map<String, dynamic> shift) {
    // Navigate to edit shift form
  }
}

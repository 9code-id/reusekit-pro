import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaStaffScheduleView extends StatefulWidget {
  const RmaStaffScheduleView({super.key});

  @override
  State<RmaStaffScheduleView> createState() => _RmaStaffScheduleViewState();
}

class _RmaStaffScheduleViewState extends State<RmaStaffScheduleView> {
  int selectedWeek = 0;
  String selectedDepartment = "All";
  String selectedShift = "All";
  String searchQuery = "";
  bool showOnlyAvailable = false;
  bool showConflicts = false;

  // Mock schedule data
  List<Map<String, dynamic>> scheduleData = [
    {
      "id": "SCH001",
      "employee": {
        "id": "EMP001",
        "name": "Sarah Johnson",
        "department": "Kitchen",
        "position": "Head Chef",
        "image": "https://picsum.photos/100/100?random=1&keyword=chef",
        "availableShifts": ["Morning", "Evening"],
        "hourlyRate": 28.50,
      },
      "shifts": [
        {
          "day": "Monday",
          "shift": "Morning",
          "time": "06:00 - 14:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Head Chef",
          "conflicts": [],
        },
        {
          "day": "Tuesday",
          "shift": "Morning", 
          "time": "06:00 - 14:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Head Chef",
          "conflicts": [],
        },
        {
          "day": "Wednesday",
          "shift": "Evening",
          "time": "14:00 - 22:00",
          "hours": 8,
          "status": "Pending",
          "position": "Head Chef",
          "conflicts": ["Overtime"],
        },
      ],
      "totalHours": 24,
      "overtime": 0,
      "availability": "Available",
    },
    {
      "id": "SCH002",
      "employee": {
        "id": "EMP002",
        "name": "Mike Chen",
        "department": "Service",
        "position": "Server",
        "image": "https://picsum.photos/100/100?random=2&keyword=waiter",
        "availableShifts": ["Morning", "Evening", "Night"],
        "hourlyRate": 18.00,
      },
      "shifts": [
        {
          "day": "Monday",
          "shift": "Evening",
          "time": "14:00 - 22:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Server",
          "conflicts": [],
        },
        {
          "day": "Tuesday",
          "shift": "Evening",
          "time": "14:00 - 22:00", 
          "hours": 8,
          "status": "Confirmed",
          "position": "Server",
          "conflicts": [],
        },
        {
          "day": "Friday",
          "shift": "Night",
          "time": "22:00 - 06:00",
          "hours": 8,
          "status": "Requested",
          "position": "Server",
          "conflicts": ["Back-to-back"],
        },
      ],
      "totalHours": 24,
      "overtime": 0,
      "availability": "Limited",
    },
    {
      "id": "SCH003",
      "employee": {
        "id": "EMP003",
        "name": "Emma Wilson",
        "department": "Kitchen",
        "position": "Sous Chef",
        "image": "https://picsum.photos/100/100?random=3&keyword=cook",
        "availableShifts": ["Morning", "Evening"],
        "hourlyRate": 24.00,
      },
      "shifts": [
        {
          "day": "Monday",
          "shift": "Evening",
          "time": "14:00 - 22:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Sous Chef",
          "conflicts": [],
        },
        {
          "day": "Wednesday",
          "shift": "Morning",
          "time": "06:00 - 14:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Sous Chef",
          "conflicts": [],
        },
        {
          "day": "Thursday",
          "shift": "Evening",
          "time": "14:00 - 22:00",
          "hours": 8,
          "status": "Pending",
          "position": "Sous Chef",
          "conflicts": [],
        },
        {
          "day": "Friday",
          "shift": "Morning",
          "time": "06:00 - 14:00",
          "hours": 8,
          "status": "Confirmed",
          "position": "Sous Chef",
          "conflicts": [],
        },
      ],
      "totalHours": 32,
      "overtime": 8,
      "availability": "Available",
    },
  ];

  List<String> weekOptions = [
    "Current Week (Dec 16-22)",
    "Next Week (Dec 23-29)",
    "Week of Dec 30-Jan 5",
    "Week of Jan 6-12",
  ];

  List<String> departments = ["All", "Kitchen", "Service", "Management", "Cleaning"];
  List<String> shifts = ["All", "Morning", "Evening", "Night"];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  List<Map<String, dynamic>> get filteredSchedule {
    return scheduleData.where((schedule) {
      bool matchesDepartment = selectedDepartment == "All" || 
          (schedule["employee"]["department"] as String) == selectedDepartment;
      
      bool matchesSearch = searchQuery.isEmpty || 
          (schedule["employee"]["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesShift = selectedShift == "All" || 
          (schedule["shifts"] as List).any((shift) => 
              (shift["shift"] as String) == selectedShift);
      
      bool matchesAvailable = !showOnlyAvailable || 
          (schedule["availability"] as String) == "Available";
          
      bool matchesConflicts = !showConflicts || 
          (schedule["shifts"] as List).any((shift) => 
              (shift["conflicts"] as List).isNotEmpty);

      return matchesDepartment && matchesSearch && matchesShift && matchesAvailable && matchesConflicts;
    }).toList();
  }

  Color _getShiftColor(String shift) {
    switch (shift) {
      case "Morning":
        return warningColor;
      case "Evening":
        return primaryColor;
      case "Night":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Requested":
        return infoColor;
      case "Declined":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add schedule
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show menu options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Week Selection and Summary
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
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Select Week",
                          items: weekOptions.map((week) => {
                            "label": week,
                            "value": week,
                          }).toList(),
                          value: weekOptions[selectedWeek],
                          onChanged: (value, label) {
                            selectedWeek = weekOptions.indexOf(value);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Staff",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${scheduleData.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Scheduled",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${scheduleData.where((s) => (s["shifts"] as List).any((shift) => (shift["status"] as String) == "Confirmed")).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${scheduleData.where((s) => (s["shifts"] as List).any((shift) => (shift["status"] as String) == "Pending")).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
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
                  QTextField(
                    label: "Search Staff",
                    value: searchQuery,
                    hint: "Enter staff name...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departments.map((dept) => {
                            "label": dept,
                            "value": dept,
                          }).toList(),
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
                          items: shifts.map((shift) => {
                            "label": shift,
                            "value": shift,
                          }).toList(),
                          value: selectedShift,
                          onChanged: (value, label) {
                            selectedShift = value;
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
                              "label": "Available Only",
                              "value": true,
                              "checked": showOnlyAvailable,
                            }
                          ],
                          value: [
                            if (showOnlyAvailable)
                              {
                                "label": "Available Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              showOnlyAvailable = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Conflicts",
                              "value": true,
                              "checked": showConflicts,
                            }
                          ],
                          value: [
                            if (showConflicts)
                              {
                                "label": "Show Conflicts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              showConflicts = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Schedule Grid
            ...filteredSchedule.map((schedule) {
              final employee = schedule["employee"] as Map<String, dynamic>;
              final shifts = schedule["shifts"] as List;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Employee Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${employee["image"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${employee["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${employee["position"]} • ${employee["department"]}",
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
                            Text(
                              "${schedule["totalHours"]}h",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if ((schedule["overtime"] as int) > 0)
                              Text(
                                "+${schedule["overtime"]}h OT",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    // Weekly Schedule Grid
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          // Days Header
                          Row(
                            children: days.map((day) => Expanded(
                              child: Text(
                                day.substring(0, 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            )).toList(),
                          ),
                          
                          // Schedule Slots
                          Row(
                            children: days.map((day) {
                              final dayShift = shifts.cast<Map<String, dynamic>>()
                                  .where((shift) => (shift["day"] as String) == day)
                                  .toList();
                              
                              return Expanded(
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsets.symmetric(horizontal: 1),
                                  child: dayShift.isNotEmpty
                                      ? Column(
                                          spacing: 2,
                                          children: dayShift.map<Widget>((shift) => Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _getShiftColor(shift["shift"] as String),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                                border: (shift["conflicts"] as List).isNotEmpty
                                                    ? Border.all(color: dangerColor, width: 2)
                                                    : null,
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${shift["shift"]}".substring(0, 1),
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    decoration: BoxDecoration(
                                                      color: _getStatusColor(shift["status"] as String),
                                                      borderRadius: BorderRadius.circular(radiusXxs),
                                                    ),
                                                    child: Text(
                                                      "${shift["hours"]}h",
                                                      style: TextStyle(
                                                        fontSize: 6,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )).toList(),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: disabledColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Off",
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to schedule details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Edit Schedule",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to edit schedule
                            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new schedule
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

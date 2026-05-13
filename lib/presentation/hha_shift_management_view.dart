import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaShiftManagementView extends StatefulWidget {
  const HhaShiftManagementView({super.key});

  @override
  State<HhaShiftManagementView> createState() => _HhaShiftManagementViewState();
}

class _HhaShiftManagementViewState extends State<HhaShiftManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String departmentFilter = "all";
  String statusFilter = "all";
  String selectedDate = DateTime.now().toString().split(' ')[0];

  List<Map<String, dynamic>> shiftData = [
    {
      "id": "SH001",
      "title": "Morning Reception",
      "department": "front_desk",
      "startTime": "06:00",
      "endTime": "14:00",
      "date": "2024-01-15",
      "assignedStaff": ["John Smith", "Sarah Johnson"],
      "requiredStaff": 2,
      "status": "fully_staffed",
      "location": "Front Desk",
      "hourlyRate": 18.50,
      "totalHours": 8,
      "overtime": false,
      "notes": "Peak check-in period",
    },
    {
      "id": "SH002",
      "title": "Evening Housekeeping",
      "department": "housekeeping",
      "startTime": "16:00",
      "endTime": "00:00",
      "date": "2024-01-15",
      "assignedStaff": ["Maria Garcia"],
      "requiredStaff": 3,
      "status": "understaffed",
      "location": "All Floors",
      "hourlyRate": 16.00,
      "totalHours": 8,
      "overtime": false,
      "notes": "Need 2 more housekeepers",
    },
    {
      "id": "SH003",
      "title": "Night Security",
      "department": "security",
      "startTime": "22:00",
      "endTime": "06:00",
      "date": "2024-01-15",
      "assignedStaff": ["Mike Johnson", "David Wilson"],
      "requiredStaff": 2,
      "status": "fully_staffed",
      "location": "Lobby & Perimeter",
      "hourlyRate": 20.00,
      "totalHours": 8,
      "overtime": false,
      "notes": "Regular patrol schedule",
    },
    {
      "id": "SH004",
      "title": "Kitchen Prep",
      "department": "kitchen",
      "startTime": "05:00",
      "endTime": "13:00",
      "date": "2024-01-16",
      "assignedStaff": ["Chef Rodriguez", "Amy Thompson", "Kevin Lee"],
      "requiredStaff": 3,
      "status": "fully_staffed",
      "location": "Main Kitchen",
      "hourlyRate": 22.00,
      "totalHours": 8,
      "overtime": false,
      "notes": "Breakfast prep and service",
    },
    {
      "id": "SH005",
      "title": "Weekend Maintenance",
      "department": "maintenance",
      "startTime": "08:00",
      "endTime": "20:00",
      "date": "2024-01-16",
      "assignedStaff": [],
      "requiredStaff": 2,
      "status": "unassigned",
      "location": "Various",
      "hourlyRate": 25.00,
      "totalHours": 12,
      "overtime": true,
      "notes": "HVAC system maintenance",
    },
  ];

  List<Map<String, dynamic>> staffList = [
    {"id": "ST001", "name": "John Smith", "department": "front_desk", "available": true},
    {"id": "ST002", "name": "Sarah Johnson", "department": "front_desk", "available": false},
    {"id": "ST003", "name": "Maria Garcia", "department": "housekeeping", "available": true},
    {"id": "ST004", "name": "Mike Johnson", "department": "security", "available": false},
    {"id": "ST005", "name": "David Wilson", "department": "security", "available": true},
    {"id": "ST006", "name": "Chef Rodriguez", "department": "kitchen", "available": false},
    {"id": "ST007", "name": "Amy Thompson", "department": "kitchen", "available": true},
    {"id": "ST008", "name": "Kevin Lee", "department": "kitchen", "available": false},
    {"id": "ST009", "name": "Lisa Brown", "department": "housekeeping", "available": true},
    {"id": "ST010", "name": "Robert Davis", "department": "maintenance", "available": true},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Security", "value": "security"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Fully Staffed", "value": "fully_staffed"},
    {"label": "Understaffed", "value": "understaffed"},
    {"label": "Unassigned", "value": "unassigned"},
    {"label": "Overstaffed", "value": "overstaffed"},
  ];

  // New shift form fields
  String shiftTitle = "";
  String shiftDepartment = "front_desk";
  String startTime = "09:00";
  String endTime = "17:00";
  int requiredStaffCount = 1;
  double hourlyRate = 15.00;
  String shiftLocation = "";
  String shiftNotes = "";
  String selectedShiftId = "";
  List<String> selectedStaff = [];

  List<Map<String, dynamic>> timeItems = [
    {"label": "12:00 AM", "value": "00:00"},
    {"label": "01:00 AM", "value": "01:00"},
    {"label": "02:00 AM", "value": "02:00"},
    {"label": "03:00 AM", "value": "03:00"},
    {"label": "04:00 AM", "value": "04:00"},
    {"label": "05:00 AM", "value": "05:00"},
    {"label": "06:00 AM", "value": "06:00"},
    {"label": "07:00 AM", "value": "07:00"},
    {"label": "08:00 AM", "value": "08:00"},
    {"label": "09:00 AM", "value": "09:00"},
    {"label": "10:00 AM", "value": "10:00"},
    {"label": "11:00 AM", "value": "11:00"},
    {"label": "12:00 PM", "value": "12:00"},
    {"label": "01:00 PM", "value": "13:00"},
    {"label": "02:00 PM", "value": "14:00"},
    {"label": "03:00 PM", "value": "15:00"},
    {"label": "04:00 PM", "value": "16:00"},
    {"label": "05:00 PM", "value": "17:00"},
    {"label": "06:00 PM", "value": "18:00"},
    {"label": "07:00 PM", "value": "19:00"},
    {"label": "08:00 PM", "value": "20:00"},
    {"label": "09:00 PM", "value": "21:00"},
    {"label": "10:00 PM", "value": "22:00"},
    {"label": "11:00 PM", "value": "23:00"},
  ];

  List<Map<String, dynamic>> get filteredShifts {
    return shiftData.where((shift) {
      bool matchesSearch = shift["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shift["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shift["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = departmentFilter == "all" || shift["department"] == departmentFilter;
      bool matchesStatus = statusFilter == "all" || shift["status"] == statusFilter;
      bool matchesDate = shift["date"] == selectedDate;
      return matchesSearch && matchesDepartment && matchesStatus && matchesDate;
    }).toList();
  }

  int get totalShifts => filteredShifts.length;
  int get fullyStaffedShifts => filteredShifts.where((s) => s["status"] == "fully_staffed").length;
  int get understaffedShifts => filteredShifts.where((s) => s["status"] == "understaffed").length;
  int get unassignedShifts => filteredShifts.where((s) => s["status"] == "unassigned").length;

  double get totalLaborCost {
    return filteredShifts.fold(0.0, (sum, shift) {
      double cost = (shift["hourlyRate"] as double) * (shift["totalHours"] as int) * (shift["assignedStaff"] as List).length;
      if (shift["overtime"] as bool) {
        cost *= 1.5; // Overtime rate
      }
      return sum + cost;
    });
  }

  void _createShift() {
    if (shiftTitle.isNotEmpty && shiftLocation.isNotEmpty) {
      final newShift = {
        "id": "SH${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        "title": shiftTitle,
        "department": shiftDepartment,
        "startTime": startTime,
        "endTime": endTime,
        "date": selectedDate,
        "assignedStaff": <String>[],
        "requiredStaff": requiredStaffCount,
        "status": "unassigned",
        "location": shiftLocation,
        "hourlyRate": hourlyRate,
        "totalHours": _calculateHours(startTime, endTime),
        "overtime": _calculateHours(startTime, endTime) > 8,
        "notes": shiftNotes,
      };

      shiftData.add(newShift);
      
      // Reset form
      shiftTitle = "";
      shiftDepartment = "front_desk";
      startTime = "09:00";
      endTime = "17:00";
      requiredStaffCount = 1;
      hourlyRate = 15.00;
      shiftLocation = "";
      shiftNotes = "";
      
      setState(() {});
      ss("Shift created successfully");
    }
  }

  int _calculateHours(String start, String end) {
    final startHour = int.parse(start.split(':')[0]);
    final endHour = int.parse(end.split(':')[0]);
    if (endHour < startHour) {
      return (24 - startHour) + endHour;
    }
    return endHour - startHour;
  }

  void _assignStaffToShift() {
    if (selectedShiftId.isNotEmpty && selectedStaff.isNotEmpty) {
      final shiftIndex = shiftData.indexWhere((s) => s["id"] == selectedShiftId);
      if (shiftIndex != -1) {
        (shiftData[shiftIndex]["assignedStaff"] as List).addAll(selectedStaff);
        
        // Update status based on staffing
        final assigned = (shiftData[shiftIndex]["assignedStaff"] as List).length;
        final required = shiftData[shiftIndex]["requiredStaff"] as int;
        
        if (assigned == required) {
          shiftData[shiftIndex]["status"] = "fully_staffed";
        } else if (assigned < required) {
          shiftData[shiftIndex]["status"] = "understaffed";
        } else {
          shiftData[shiftIndex]["status"] = "overstaffed";
        }

        // Update staff availability
        for (String staffName in selectedStaff) {
          final staffIndex = staffList.indexWhere((s) => s["name"] == staffName);
          if (staffIndex != -1) {
            staffList[staffIndex]["available"] = false;
          }
        }

        selectedStaff.clear();
        setState(() {});
        ss("Staff assigned successfully");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shift Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Shifts Overview", icon: Icon(Icons.schedule)),
        Tab(text: "Create Shift", icon: Icon(Icons.add_circle)),
        Tab(text: "Staff Assignment", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildShiftsOverviewTab(),
        _buildCreateShiftTab(),
        _buildStaffAssignmentTab(),
      ],
    );
  }

  Widget _buildShiftsOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Total Shifts",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalShifts",
                        style: TextStyle(
                          fontSize: fsH4,
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
                        "Fully Staffed",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$fullyStaffedShifts",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Understaffed",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$understaffedShifts",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Labor Cost",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalLaborCost.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
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

          // Date Selection and Filters
          QDatePicker(
            label: "Select Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search shifts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: departmentFilter,
                  onChanged: (value, label) {
                    departmentFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: statusFilter,
                  onChanged: (value, label) {
                    statusFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Shifts List
          Text(
            "Shifts for ${DateTime.parse(selectedDate).toString().split(' ')[0]} (${filteredShifts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredShifts.length,
            itemBuilder: (context, index) {
              final shift = filteredShifts[index];
              Color statusColor = shift["status"] == "fully_staffed" ? successColor :
                  shift["status"] == "understaffed" ? warningColor :
                  shift["status"] == "unassigned" ? dangerColor :
                  shift["status"] == "overstaffed" ? infoColor : primaryColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${shift["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${shift["location"]} • ${shift["startTime"]} - ${shift["endTime"]}",
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
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${shift["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                              Text("Department: ${shift["department"]}".replaceAll('_', ' ').toUpperCase(), style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Text("Staff: ${(shift["assignedStaff"] as List).length}/${shift["requiredStaff"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Text("Rate: \$${(shift["hourlyRate"] as double).currency}/hr", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              if (shift["overtime"] as bool)
                                Text("OVERTIME", style: TextStyle(fontSize: 12, color: dangerColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${shift["totalHours"]}h",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${((shift["hourlyRate"] as double) * (shift["totalHours"] as int) * (shift["assignedStaff"] as List).length * ((shift["overtime"] as bool) ? 1.5 : 1.0)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    if ((shift["assignedStaff"] as List).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Assigned Staff:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          Wrap(
                            spacing: spXs,
                            children: (shift["assignedStaff"] as List).map((staff) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text("$staff", style: TextStyle(fontSize: 11, color: primaryColor)),
                            )).toList(),
                          ),
                        ],
                      ),

                    if (shift["notes"].toString().isNotEmpty)
                      Text(
                        "Notes: ${shift["notes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateShiftTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Create New Shift",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
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
              spacing: spMd,
              children: [
                Text(
                  "Shift Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QTextField(
                  label: "Shift Title",
                  value: shiftTitle,
                  onChanged: (value) {
                    shiftTitle = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Department",
                  items: departmentItems.where((item) => item["value"] != "all").toList(),
                  value: shiftDepartment,
                  onChanged: (value, label) {
                    shiftDepartment = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Location",
                  value: shiftLocation,
                  onChanged: (value) {
                    shiftLocation = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Start Time",
                        items: timeItems,
                        value: startTime,
                        onChanged: (value, label) {
                          startTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "End Time",
                        items: timeItems,
                        value: endTime,
                        onChanged: (value, label) {
                          endTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Required Staff",
                        value: requiredStaffCount.toString(),
                        onChanged: (value) {
                          requiredStaffCount = int.tryParse(value) ?? 1;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Hourly Rate (\$)",
                        value: hourlyRate.toString(),
                        onChanged: (value) {
                          hourlyRate = double.tryParse(value) ?? 15.00;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Notes (Optional)",
                  value: shiftNotes,
                  onChanged: (value) {
                    shiftNotes = value;
                    setState(() {});
                  },
                ),

                // Shift Summary
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Shift Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Duration:", style: TextStyle(fontWeight: FontWeight.w600))),
                          Text("${_calculateHours(startTime, endTime)} hours"),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Total Cost:", style: TextStyle(fontWeight: FontWeight.w600))),
                          Text("\$${(hourlyRate * _calculateHours(startTime, endTime) * requiredStaffCount).currency}"),
                        ],
                      ),
                      if (_calculateHours(startTime, endTime) > 8)
                        Row(
                          children: [
                            Expanded(child: Text("Overtime:", style: TextStyle(fontWeight: FontWeight.w600, color: dangerColor))),
                            Text("Yes (1.5x rate)", style: TextStyle(color: dangerColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Shift",
                    size: bs.md,
                    onPressed: _createShift,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffAssignmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Staff Assignment",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Assignment Form
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
                  "Assign Staff to Shift",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDropdownField(
                  label: "Select Shift",
                  items: shiftData.map((shift) => {
                    "label": "${shift["title"]} (${shift["startTime"]} - ${shift["endTime"]})",
                    "value": shift["id"],
                  }).toList(),
                  value: selectedShiftId.isNotEmpty ? selectedShiftId : shiftData.first["id"],
                  onChanged: (value, label) {
                    selectedShiftId = value;
                    setState(() {});
                  },
                ),

                Text(
                  "Available Staff",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: staffList.where((staff) => staff["available"] == true).length,
                  itemBuilder: (context, index) {
                    final availableStaff = staffList.where((staff) => staff["available"] == true).toList();
                    final staff = availableStaff[index];
                    final isSelected = selectedStaff.contains(staff["name"]);

                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedStaff.remove(staff["name"]);
                          } else {
                            selectedStaff.add(staff["name"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${staff["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : null,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${staff["department"]}".replaceAll('_', ' ').toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                if (selectedStaff.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Staff (${selectedStaff.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spXs,
                          children: selectedStaff.map((staff) => Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              staff,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Assign Staff",
                    size: bs.md,
                    onPressed: _assignStaffToShift,
                  ),
                ),
              ],
            ),
          ),

          // Currently Assigned Staff
          Text(
            "Currently Assigned Staff",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: staffList.where((staff) => staff["available"] == false).length,
            itemBuilder: (context, index) {
              final assignedStaff = staffList.where((staff) => staff["available"] == false).toList();
              final staff = assignedStaff[index];

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: warningColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(Icons.person, color: warningColor),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${staff["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${staff["department"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "ASSIGNED",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

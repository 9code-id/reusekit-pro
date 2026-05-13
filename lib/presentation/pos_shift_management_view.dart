import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosShiftManagementView extends StatefulWidget {
  const PosShiftManagementView({super.key});

  @override
  State<PosShiftManagementView> createState() => _PosShiftManagementViewState();
}

class _PosShiftManagementViewState extends State<PosShiftManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedStatus = "";
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> departmentFilterItems = [
    {"label": "All Departments", "value": ""},
    {"label": "Sales", "value": "sales"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Service", "value": "service"},
    {"label": "Management", "value": "management"},
  ];
  
  List<Map<String, dynamic>> statusFilterItems = [
    {"label": "All Status", "value": ""},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Missed", "value": "missed"},
  ];

  List<Map<String, dynamic>> shifts = [
    {
      "id": "1",
      "employee": "John Smith",
      "role": "Manager",
      "department": "Management",
      "date": "2024-01-15",
      "startTime": "06:00",
      "endTime": "14:00",
      "duration": "8 hours",
      "status": "completed",
      "actualStart": "06:05",
      "actualEnd": "14:15",
      "breakTime": "30 mins",
      "overtime": "15 mins",
      "image": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": "2",
      "employee": "Sarah Johnson",
      "role": "Cashier",
      "department": "Sales",
      "date": "2024-01-15",
      "startTime": "08:00",
      "endTime": "16:00",
      "duration": "8 hours",
      "status": "in_progress",
      "actualStart": "07:55",
      "actualEnd": "",
      "breakTime": "30 mins",
      "overtime": "",
      "image": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": "3",
      "employee": "Mike Chen",
      "role": "Chef",
      "department": "Kitchen",
      "date": "2024-01-15",
      "startTime": "10:00",
      "endTime": "18:00",
      "duration": "8 hours",
      "status": "scheduled",
      "actualStart": "",
      "actualEnd": "",
      "breakTime": "45 mins",
      "overtime": "",
      "image": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": "4",
      "employee": "Emma Wilson",
      "role": "Server",
      "department": "Service",
      "date": "2024-01-15",
      "startTime": "12:00",
      "endTime": "20:00",
      "duration": "8 hours",
      "status": "completed",
      "actualStart": "12:10",
      "actualEnd": "20:05",
      "breakTime": "30 mins",
      "overtime": "5 mins",
      "image": "https://picsum.photos/100/100?random=4",
    },
    {
      "id": "5",
      "employee": "David Brown",
      "role": "Barista",
      "department": "Service",
      "date": "2024-01-15",
      "startTime": "14:00",
      "endTime": "22:00",
      "duration": "8 hours",
      "status": "missed",
      "actualStart": "",
      "actualEnd": "",
      "breakTime": "30 mins",
      "overtime": "",
      "image": "https://picsum.photos/100/100?random=5",
    },
  ];

  List<Map<String, dynamic>> scheduleTemplates = [
    {
      "name": "Morning Shift",
      "startTime": "06:00",
      "endTime": "14:00",
      "duration": "8 hours",
      "breakTime": "30 mins",
      "employees": 8,
      "color": Colors.blue,
    },
    {
      "name": "Afternoon Shift",
      "startTime": "14:00",
      "endTime": "22:00",
      "duration": "8 hours",
      "breakTime": "45 mins",
      "employees": 12,
      "color": Colors.orange,
    },
    {
      "name": "Night Shift",
      "startTime": "22:00",
      "endTime": "06:00",
      "duration": "8 hours",
      "breakTime": "30 mins",
      "employees": 4,
      "color": Colors.purple,
    },
    {
      "name": "Part Time",
      "startTime": "10:00",
      "endTime": "14:00",
      "duration": "4 hours",
      "breakTime": "15 mins",
      "employees": 6,
      "color": Colors.green,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return primaryColor;
      case 'scheduled':
        return warningColor;
      case 'missed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In Progress';
      case 'scheduled':
        return 'Scheduled';
      case 'missed':
        return 'Missed';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredShifts {
    return shifts.where((shift) {
      bool matchesSearch = shift["employee"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shift["role"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = selectedDepartment.isEmpty || shift["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus.isEmpty || shift["status"] == selectedStatus;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  void _showShiftDetails(Map<String, dynamic> shift) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${shift["employee"]} - Shift Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${shift["image"]}"),
                  radius: 25,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${shift["employee"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${shift["role"]} - ${shift["department"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            _buildDetailRow("Date:", "${shift["date"]}"),
            _buildDetailRow("Scheduled:", "${shift["startTime"]} - ${shift["endTime"]}"),
            _buildDetailRow("Duration:", "${shift["duration"]}"),
            if (shift["actualStart"].toString().isNotEmpty)
              _buildDetailRow("Actual Start:", "${shift["actualStart"]}"),
            if (shift["actualEnd"].toString().isNotEmpty)
              _buildDetailRow("Actual End:", "${shift["actualEnd"]}"),
            _buildDetailRow("Break Time:", "${shift["breakTime"]}"),
            if (shift["overtime"].toString().isNotEmpty)
              _buildDetailRow("Overtime:", "${shift["overtime"]}"),
            _buildDetailRow("Status:", _getStatusText("${shift["status"]}"), _getStatusColor("${shift["status"]}")),
          ],
        ),
        actions: [
          QButton(
            label: "Edit Shift",
            size: bs.sm,
            onPressed: () {
              back();
              _editShift(shift);
            },
          ),
          QButton(
            label: "Close",
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, [Color? valueColor]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? primaryColor,
              fontWeight: valueColor != null ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  void _editShift(Map<String, dynamic> shift) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Shift"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Employee",
              value: "${shift["employee"]}",
              onChanged: (value) {},
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${shift["startTime"]}:00")),
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${shift["endTime"]}:00")),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            QDropdownField(
              label: "Status",
              items: [
                {"label": "Scheduled", "value": "scheduled"},
                {"label": "In Progress", "value": "in_progress"},
                {"label": "Completed", "value": "completed"},
                {"label": "Missed", "value": "missed"},
              ],
              value: "${shift["status"]}",
              onChanged: (value, label) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Shift updated successfully");
            },
          ),
          QButton(
            label: "Cancel",
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _createNewShift() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Shift"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Employee",
              items: [
                {"label": "John Smith", "value": "john"},
                {"label": "Sarah Johnson", "value": "sarah"},
                {"label": "Mike Chen", "value": "mike"},
                {"label": "Emma Wilson", "value": "emma"},
              ],
              value: "",
              onChanged: (value, label) {},
            ),
            QDatePicker(
              label: "Date",
              value: DateTime.now(),
              onChanged: (value) {},
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: TimeOfDay.now(),
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: TimeOfDay.now(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Create Shift",
            size: bs.sm,
            onPressed: () {
              back();
              ss("New shift created successfully");
            },
          ),
          QButton(
            label: "Cancel",
            color: disabledColor,
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayShifts() {
    return Column(
      spacing: spMd,
      children: [
        // Date Selector
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
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
              SizedBox(width: spSm),
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
        ),

        // Search and Filter
        Container(
          width: double.infinity,
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
                label: "Search Employees",
                value: searchQuery,
                hint: "Search by name or role",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Department",
                      items: departmentFilterItems,
                      value: selectedDepartment,
                      onChanged: (value, label) {
                        selectedDepartment = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusFilterItems,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Shifts List
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Today's Shifts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Add Shift",
                    size: bs.sm,
                    onPressed: _createNewShift,
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: filteredShifts.map((shift) => GestureDetector(
                  onTap: () => _showShiftDetails(shift),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor("${shift["status"]}"),
                        ),
                      ),
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage("${shift["image"]}"),
                          radius: 25,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${shift["employee"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${shift["status"]}").withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText("${shift["status"]}"),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${shift["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${shift["role"]} - ${shift["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${shift["startTime"]} - ${shift["endTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${shift["duration"]}",
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
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTemplates() {
    return Column(
      spacing: spMd,
      children: [
        // Schedule Templates Overview
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: scheduleTemplates.map((template) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (template["color"] as Color).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.schedule,
                    color: template["color"] as Color,
                    size: 30,
                  ),
                ),
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${template["startTime"]} - ${template["endTime"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: template["color"] as Color,
                  ),
                ),
                Text(
                  "${template["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${template["employees"]} employees",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Use Template",
                    size: bs.sm,
                    onPressed: () {
                      ss("Template applied successfully");
                    },
                  ),
                ),
              ],
            ),
          )).toList(),
        ),

        // Create New Template
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Template",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Template Name",
                value: "",
                onChanged: (value) {},
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTimePicker(
                      label: "Start Time",
                      value: TimeOfDay.now(),
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: QTimePicker(
                      label: "End Time",
                      value: TimeOfDay.now(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Break Duration (minutes)",
                value: "",
                onChanged: (value) {},
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Template",
                  size: bs.md,
                  onPressed: () {
                    ss("New template created successfully");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shift Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today's Shifts", icon: Icon(Icons.today)),
        Tab(text: "Templates", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildTodayShifts(),
        _buildScheduleTemplates(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}

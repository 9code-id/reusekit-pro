import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTimesheetView extends StatefulWidget {
  const AbaTimesheetView({super.key});

  @override
  State<AbaTimesheetView> createState() => _AbaTimesheetViewState();
}

class _AbaTimesheetViewState extends State<AbaTimesheetView> {
  String selectedEmployee = "All";
  String selectedDepartment = "All";
  String selectedWeek = "Current Week";
  String selectedStatus = "All";
  bool loading = false;

  List<Map<String, dynamic>> employeeItems = [
    {"label": "All", "value": "All"},
    {"label": "John Smith", "value": "EMP001"},
    {"label": "Sarah Johnson", "value": "EMP002"},
    {"label": "Mike Chen", "value": "EMP003"},
    {"label": "Lisa Wong", "value": "EMP004"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> weekItems = [
    {"label": "Current Week", "value": "Current Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "2 Weeks Ago", "value": "2 Weeks Ago"},
    {"label": "3 Weeks Ago", "value": "3 Weeks Ago"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Submitted", "value": "Submitted"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> timesheets = [
    {
      "id": "TS-2024-001",
      "employee_name": "John Smith",
      "employee_id": "EMP001",
      "department": "Engineering",
      "week_start": "2024-01-15",
      "week_end": "2024-01-21",
      "total_hours": 42.5,
      "regular_hours": 40.0,
      "overtime_hours": 2.5,
      "break_hours": 5.0,
      "status": "Approved",
      "submitted_date": "2024-01-22",
      "approved_by": "Sarah Johnson",
      "daily_hours": [8.5, 8.0, 8.0, 8.5, 9.5, 0.0, 0.0],
      "notes": "Worked overtime on Friday for project deadline",
    },
    {
      "id": "TS-2024-002",
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP002",
      "department": "Engineering",
      "week_start": "2024-01-15",
      "week_end": "2024-01-21",
      "total_hours": 40.0,
      "regular_hours": 40.0,
      "overtime_hours": 0.0,
      "break_hours": 5.0,
      "status": "Submitted",
      "submitted_date": "2024-01-22",
      "approved_by": null,
      "daily_hours": [8.0, 8.0, 8.0, 8.0, 8.0, 0.0, 0.0],
      "notes": "Regular work week",
    },
    {
      "id": "TS-2024-003",
      "employee_name": "Mike Chen",
      "employee_id": "EMP003",
      "department": "Sales",
      "week_start": "2024-01-15",
      "week_end": "2024-01-21",
      "total_hours": 45.0,
      "regular_hours": 40.0,
      "overtime_hours": 5.0,
      "break_hours": 5.0,
      "status": "Approved",
      "submitted_date": "2024-01-21",
      "approved_by": "David Brown",
      "daily_hours": [9.0, 9.0, 9.0, 9.0, 9.0, 0.0, 0.0],
      "notes": "Client meetings required extra hours",
    },
    {
      "id": "TS-2024-004",
      "employee_name": "Lisa Wong",
      "employee_id": "EMP004",
      "department": "HR",
      "week_start": "2024-01-15",
      "week_end": "2024-01-21",
      "total_hours": 38.5,
      "regular_hours": 38.5,
      "overtime_hours": 0.0,
      "break_hours": 4.5,
      "status": "Rejected",
      "submitted_date": "2024-01-22",
      "approved_by": "Jennifer Davis",
      "daily_hours": [7.5, 8.0, 8.0, 7.5, 7.5, 0.0, 0.0],
      "notes": "Incomplete project documentation hours",
    },
    {
      "id": "TS-2024-005",
      "employee_name": "David Brown",
      "employee_id": "EMP005",
      "department": "Marketing",
      "week_start": "2024-01-15",
      "week_end": "2024-01-21",
      "total_hours": 39.0,
      "regular_hours": 39.0,
      "overtime_hours": 0.0,
      "break_hours": 5.0,
      "status": "Draft",
      "submitted_date": null,
      "approved_by": null,
      "daily_hours": [8.0, 8.0, 7.5, 7.5, 8.0, 0.0, 0.0],
      "notes": "Working on campaign planning",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledBoldColor;
      case "Submitted":
        return warningColor;
      case "Approved":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildSummaryCard() {
    int totalSubmitted = timesheets.where((ts) => ts["status"] == "Submitted").length;
    int totalApproved = timesheets.where((ts) => ts["status"] == "Approved").length;
    double totalHours = timesheets.fold(0.0, (sum, ts) => sum + (ts["total_hours"] as double));
    double totalOT = timesheets.fold(0.0, (sum, ts) => sum + (ts["overtime_hours"] as double));
    
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
            "Timesheet Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Pending", "$totalSubmitted", warningColor),
              ),
              Expanded(
                child: _buildSummaryItem("Approved", "$totalApproved", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Total Hours", "${totalHours.toStringAsFixed(1)}", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Overtime", "${totalOT.toStringAsFixed(1)}", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
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
            "Filter Timesheets",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: employeeItems,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Week",
                  items: weekItems,
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
                  label: "Status",
                  items: statusItems,
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
    );
  }

  Widget _buildTimesheetCard(Map<String, dynamic> timesheet) {
    List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<double> dailyHours = (timesheet["daily_hours"] as List).cast<double>();
    
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
            color: _getStatusColor(timesheet["status"]),
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
                      "${timesheet["employee_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${timesheet["department"]} • ${timesheet["id"]}",
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
                  color: _getStatusColor(timesheet["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(timesheet["status"]).withAlpha(100),
                  ),
                ),
                child: Text(
                  "${timesheet["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(timesheet["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Week: ${timesheet["week_start"]} - ${timesheet["week_end"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(timesheet["total_hours"] as double).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 16,
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
                        "Regular",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(timesheet["regular_hours"] as double).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 16,
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
                        "Overtime",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(timesheet["overtime_hours"] as double).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: (timesheet["overtime_hours"] as double) > 0 ? warningColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Daily Hours Breakdown",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: weekDays.asMap().entries.map((entry) {
              int index = entry.key;
              String day = entry.value;
              double hours = dailyHours[index];
              bool isWeekend = index >= 5;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 6 ? spXs : 0),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: isWeekend ? disabledColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${hours.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: hours > 8 ? warningColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (timesheet["notes"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${timesheet["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              if (timesheet["submitted_date"] != null)
                Text(
                  "Submitted: ${timesheet["submitted_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              Spacer(),
              if (timesheet["approved_by"] != null)
                Text(
                  "By: ${timesheet["approved_by"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
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
              if (timesheet["status"] == "Submitted") ...[
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
                    label: "Reject",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ] else if (timesheet["status"] == "Draft") ...[
                Expanded(
                  child: QButton(
                    label: "Edit",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timesheet Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(),
                  SizedBox(height: spMd),
                  _buildFilterSection(),
                  SizedBox(height: spMd),
                  Text(
                    "Employee Timesheets",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...timesheets.map((timesheet) => _buildTimesheetCard(timesheet)).toList(),
                ],
              ),
            ),
    );
  }
}

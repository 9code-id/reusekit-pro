import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTimesheetManagementView extends StatefulWidget {
  const ComaTimesheetManagementView({Key? key}) : super(key: key);

  @override
  State<ComaTimesheetManagementView> createState() => _ComaTimesheetManagementViewState();
}

class _ComaTimesheetManagementViewState extends State<ComaTimesheetManagementView> {
  String selectedWeek = "current";
  String selectedProject = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> weekFilters = [
    {"label": "Current Week", "value": "current"},
    {"label": "Previous Week", "value": "previous"},
    {"label": "Jun 10-16, 2024", "value": "2024-06-10"},
    {"label": "Jun 3-9, 2024", "value": "2024-06-03"},
    {"label": "May 27-Jun 2, 2024", "value": "2024-05-27"},
  ];

  List<Map<String, dynamic>> projectFilters = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "metro_downtown"},
    {"label": "Riverside Office Park", "value": "riverside_office"},
    {"label": "Healthcare Facility", "value": "healthcare_facility"},
    {"label": "Residential Tower A", "value": "residential_tower"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Paid", "value": "paid"},
  ];

  List<Map<String, dynamic>> timesheets = [
    {
      "id": "TS-001",
      "employee_id": "EMP-001",
      "employee_name": "Michael Rodriguez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "week_ending": "2024-06-16",
      "status": "approved",
      "total_hours": 42.5,
      "regular_hours": 40.0,
      "overtime_hours": 2.5,
      "hourly_rate": 32.50,
      "overtime_rate": 48.75,
      "total_pay": 1421.88,
      "supervisor": "Sarah Johnson",
      "submitted_date": "2024-06-17",
      "approved_date": "2024-06-17",
      "approved_by": "Sarah Johnson",
      "daily_entries": [
        {"date": "2024-06-10", "hours": 8.0, "overtime": 0.0, "description": "Electrical installation - Building A Level 3"},
        {"date": "2024-06-11", "hours": 8.0, "overtime": 0.0, "description": "Outlet and switch installation"},
        {"date": "2024-06-12", "hours": 8.0, "overtime": 0.0, "description": "Panel wiring and testing"},
        {"date": "2024-06-13", "hours": 8.0, "overtime": 0.0, "description": "Final electrical inspections"},
        {"date": "2024-06-14", "hours": 8.0, "overtime": 0.0, "description": "Touch-up work and cleanup"},
        {"date": "2024-06-15", "hours": 2.0, "overtime": 1.5, "description": "Emergency repair - overtime"},
        {"date": "2024-06-16", "hours": 2.5, "overtime": 1.0, "description": "Weekend maintenance"},
      ],
      "expenses": [
        {"description": "Travel to site", "amount": 25.00, "category": "travel"},
        {"description": "Materials - wire nuts", "amount": 15.50, "category": "materials"},
      ],
      "notes": "Completed electrical work ahead of schedule. Emergency repair required on Friday evening.",
      "attachments": ["timesheet_week_24.pdf", "expense_receipts.pdf"],
    },
    {
      "id": "TS-002",
      "employee_id": "EMP-002",
      "employee_name": "Jennifer Park",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "week_ending": "2024-06-16",
      "status": "submitted",
      "total_hours": 40.0,
      "regular_hours": 40.0,
      "overtime_hours": 0.0,
      "hourly_rate": 28.75,
      "overtime_rate": 43.13,
      "total_pay": 1150.00,
      "supervisor": "David Wilson",
      "submitted_date": "2024-06-17",
      "approved_date": null,
      "approved_by": null,
      "daily_entries": [
        {"date": "2024-06-10", "hours": 8.0, "overtime": 0.0, "description": "Plumbing rough-in Conference Room B"},
        {"date": "2024-06-11", "hours": 8.0, "overtime": 0.0, "description": "Water line installation"},
        {"date": "2024-06-12", "hours": 8.0, "overtime": 0.0, "description": "Fixture installation and testing"},
        {"date": "2024-06-13", "hours": 8.0, "overtime": 0.0, "description": "Pressure testing systems"},
        {"date": "2024-06-14", "hours": 8.0, "overtime": 0.0, "description": "Final inspections and documentation"},
        {"date": "2024-06-15", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
        {"date": "2024-06-16", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
      ],
      "expenses": [
        {"description": "Plumbing supplies", "amount": 45.75, "category": "materials"},
        {"description": "Site parking", "amount": 10.00, "category": "parking"},
      ],
      "notes": "All plumbing work completed on schedule. System pressure tests passed.",
      "attachments": ["timesheet_week_24.pdf"],
    },
    {
      "id": "TS-003",
      "employee_id": "EMP-003",
      "employee_name": "Carlos Rivera",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility",
      "week_ending": "2024-06-16",
      "status": "draft",
      "total_hours": 36.0,
      "regular_hours": 36.0,
      "overtime_hours": 0.0,
      "hourly_rate": 30.00,
      "overtime_rate": 45.00,
      "total_pay": 1080.00,
      "supervisor": "James Wilson",
      "submitted_date": null,
      "approved_date": null,
      "approved_by": null,
      "daily_entries": [
        {"date": "2024-06-10", "hours": 8.0, "overtime": 0.0, "description": "HVAC ductwork installation - Patient Wing"},
        {"date": "2024-06-11", "hours": 8.0, "overtime": 0.0, "description": "Mechanical room equipment setup"},
        {"date": "2024-06-12", "hours": 8.0, "overtime": 0.0, "description": "Air handler installation"},
        {"date": "2024-06-13", "hours": 8.0, "overtime": 0.0, "description": "System balancing and testing"},
        {"date": "2024-06-14", "hours": 4.0, "overtime": 0.0, "description": "Documentation and cleanup"},
        {"date": "2024-06-15", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
        {"date": "2024-06-16", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
      ],
      "expenses": [
        {"description": "HVAC filters", "amount": 85.20, "category": "materials"},
      ],
      "notes": "HVAC installation progressing well. Need to complete system commissioning next week.",
      "attachments": [],
    },
    {
      "id": "TS-004",
      "employee_id": "EMP-004",
      "employee_name": "Robert Garcia",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "week_ending": "2024-06-16",
      "status": "paid",
      "total_hours": 44.0,
      "regular_hours": 40.0,
      "overtime_hours": 4.0,
      "hourly_rate": 26.25,
      "overtime_rate": 39.38,
      "total_pay": 1207.50,
      "supervisor": "Maria Gonzalez",
      "submitted_date": "2024-06-16",
      "approved_date": "2024-06-16",
      "approved_by": "Maria Gonzalez",
      "daily_entries": [
        {"date": "2024-06-10", "hours": 8.0, "overtime": 0.0, "description": "Kitchen cabinet installation - Unit 1205"},
        {"date": "2024-06-11", "hours": 8.0, "overtime": 0.0, "description": "Cabinet hardware and adjustments"},
        {"date": "2024-06-12", "hours": 8.0, "overtime": 0.0, "description": "Countertop installation prep"},
        {"date": "2024-06-13", "hours": 8.0, "overtime": 0.0, "description": "Final cabinet alignment"},
        {"date": "2024-06-14", "hours": 8.0, "overtime": 0.0, "description": "Quality check and touch-ups"},
        {"date": "2024-06-15", "hours": 2.0, "overtime": 2.0, "description": "Emergency repair - cabinet door"},
        {"date": "2024-06-16", "hours": 2.0, "overtime": 2.0, "description": "Weekend finish work"},
      ],
      "expenses": [
        {"description": "Cabinet hardware", "amount": 35.00, "category": "materials"},
        {"description": "Travel expenses", "amount": 20.00, "category": "travel"},
      ],
      "notes": "Kitchen cabinet installation completed with excellent quality. Client very satisfied.",
      "attachments": ["timesheet_week_24.pdf", "completion_photos.pdf"],
    },
    {
      "id": "TS-005",
      "employee_id": "EMP-005",
      "employee_name": "Antonio Martinez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "week_ending": "2024-06-16",
      "status": "rejected",
      "total_hours": 38.0,
      "regular_hours": 38.0,
      "overtime_hours": 0.0,
      "hourly_rate": 24.50,
      "overtime_rate": 36.75,
      "total_pay": 931.00,
      "supervisor": "Thomas Anderson",
      "submitted_date": "2024-06-16",
      "approved_date": null,
      "approved_by": null,
      "daily_entries": [
        {"date": "2024-06-10", "hours": 8.0, "overtime": 0.0, "description": "Foundation prep work"},
        {"date": "2024-06-11", "hours": 8.0, "overtime": 0.0, "description": "Concrete pouring - Foundation"},
        {"date": "2024-06-12", "hours": 8.0, "overtime": 0.0, "description": "Concrete finishing"},
        {"date": "2024-06-13", "hours": 6.0, "overtime": 0.0, "description": "Weather delay - partial day"},
        {"date": "2024-06-14", "hours": 8.0, "overtime": 0.0, "description": "Form removal and cleanup"},
        {"date": "2024-06-15", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
        {"date": "2024-06-16", "hours": 0.0, "overtime": 0.0, "description": "Day off"},
      ],
      "expenses": [
        {"description": "Concrete supplies", "amount": 125.00, "category": "materials"},
      ],
      "notes": "Foundation work completed. Weather delay on Wednesday affected schedule.",
      "attachments": ["timesheet_week_24.pdf"],
      "rejection_reason": "Missing supervisor signature on Wednesday entry. Please resubmit with proper approval.",
      "rejection_date": "2024-06-17",
      "rejected_by": "Thomas Anderson",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timesheet Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createNewTimesheet(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showTimesheetAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildTimesheetOverview(),
                  _buildFilters(),
                  _buildPayrollSummary(),
                  _buildTimesheetsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTimesheetOverview() {
    int totalTimesheets = timesheets.length;
    int submittedTimesheets = timesheets.where((ts) => ts["status"] == "submitted").length;
    int approvedTimesheets = timesheets.where((ts) => ts["status"] == "approved").length;
    int draftTimesheets = timesheets.where((ts) => ts["status"] == "draft").length;
    int rejectedTimesheets = timesheets.where((ts) => ts["status"] == "rejected").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.assignment, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Timesheet Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total", "$totalTimesheets", Icons.list, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Draft", "$draftTimesheets", Icons.edit, disabledBoldColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Submitted", "$submittedTimesheets", Icons.upload, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Approved", "$approvedTimesheets", Icons.check_circle, successColor),
            ],
          ),
          if (rejectedTimesheets > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: dangerColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Rejected Timesheets: $rejectedTimesheets",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search timesheets...",
                  value: searchQuery,
                  hint: "Search by employee name or project",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Week Period",
                  items: weekFilters,
                  value: selectedWeek,
                  onChanged: (value, label) {
                    selectedWeek = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectFilters,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
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

  Widget _buildPayrollSummary() {
    double totalHours = timesheets.fold(0.0, (sum, ts) => sum + (ts["total_hours"] as double));
    double regularHours = timesheets.fold(0.0, (sum, ts) => sum + (ts["regular_hours"] as double));
    double overtimeHours = timesheets.fold(0.0, (sum, ts) => sum + (ts["overtime_hours"] as double));
    double totalPay = timesheets.fold(0.0, (sum, ts) => sum + (ts["total_pay"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Payroll Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildPayrollCard("Total Hours", "${totalHours.toStringAsFixed(1)}", Icons.schedule, primaryColor),
              SizedBox(width: spSm),
              _buildPayrollCard("Regular", "${regularHours.toStringAsFixed(1)}", Icons.access_time, infoColor),
              SizedBox(width: spSm),
              _buildPayrollCard("Overtime", "${overtimeHours.toStringAsFixed(1)}", Icons.timer, warningColor),
              SizedBox(width: spSm),
              _buildPayrollCard("Total Pay", "\$${totalPay.currency}", Icons.monetization_on, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayrollCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimesheetsList() {
    List<Map<String, dynamic>> filteredTimesheets = _getFilteredTimesheets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Timesheets (${filteredTimesheets.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredTimesheets.map((timesheet) => _buildTimesheetCard(timesheet)),
      ],
    );
  }

  Widget _buildTimesheetCard(Map<String, dynamic> timesheet) {
    Color statusColor = _getStatusColor(timesheet["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
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
                      "${timesheet["employee_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${timesheet["id"]} - Week ending ${timesheet["week_ending"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${timesheet["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${timesheet["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Hours Summary",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Total: ${timesheet["total_hours"]} hrs",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Regular: ${timesheet["regular_hours"]} hrs",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Overtime: ${timesheet["overtime_hours"]} hrs",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Hourly Rate: \$${((timesheet["hourly_rate"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "OT Rate: \$${((timesheet["overtime_rate"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Total Pay: \$${((timesheet["total_pay"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if ((timesheet["daily_entries"] as List).isNotEmpty)
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: (timesheet["daily_entries"] as List).map((entry) => 
                  _buildDailyEntryCard(entry)).toList(),
              ),
            ),
          if ((timesheet["expenses"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Expenses:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  ...(timesheet["expenses"] as List).map((expense) => Text(
                    "${expense["description"]}: \$${((expense["amount"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  )),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Supervisor: ${timesheet["supervisor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (timesheet["submitted_date"] != null)
                Text(
                  "Submitted: ${timesheet["submitted_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          if (timesheet["approved_date"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Approved by ${timesheet["approved_by"]} on ${timesheet["approved_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          if (timesheet["status"] == "rejected" && timesheet["rejection_reason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Rejected by ${timesheet["rejected_by"]} on ${timesheet["rejection_date"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Reason: ${timesheet["rejection_reason"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          if (timesheet["notes"] != null && timesheet["notes"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${timesheet["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if ((timesheet["attachments"] as List).isNotEmpty)
                Text(
                  "Attachments: ${(timesheet["attachments"] as List).length}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewTimesheetDetails(timesheet["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editTimesheet(timesheet["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTimesheetOptions(timesheet),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyEntryCard(Map<String, dynamic> entry) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            "${entry["date"]}",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Hours: ${entry["hours"]}",
            style: TextStyle(
              fontSize: 10,
              color: primaryColor,
            ),
          ),
          if ((entry["overtime"] as double) > 0)
            Text(
              "OT: ${entry["overtime"]}",
              style: TextStyle(
                fontSize: 10,
                color: warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          Expanded(
            child: Text(
              "${entry["description"]}",
              style: TextStyle(
                fontSize: 9,
                color: disabledBoldColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredTimesheets() {
    List<Map<String, dynamic>> filtered = timesheets;

    if (selectedWeek != "current" && selectedWeek != "previous") {
      filtered = filtered.where((ts) => ts["week_ending"].toString().contains(selectedWeek)).toList();
    }

    if (selectedProject != "all") {
      filtered = filtered.where((ts) => 
          ts["project_name"].toString().toLowerCase().contains(selectedProject)).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((ts) => ts["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((ts) =>
          ts["employee_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          ts["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return disabledBoldColor;
      case 'submitted':
        return warningColor;
      case 'approved':
        return successColor;
      case 'rejected':
        return dangerColor;
      case 'paid':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createNewTimesheet() {
    ss("Create new timesheet");
  }

  void _showTimesheetAnalytics() {
    ss("Timesheet analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced timesheet filters");
  }

  void _showSortOptions() {
    ss("Timesheet sort options");
  }

  void _viewTimesheetDetails(String timesheetId) {
    ss("View timesheet details $timesheetId");
  }

  void _editTimesheet(String timesheetId) {
    ss("Edit timesheet $timesheetId");
  }

  void _showTimesheetOptions(Map<String, dynamic> timesheet) {
    ss("Timesheet options for ${timesheet["employee_name"]}");
  }
}

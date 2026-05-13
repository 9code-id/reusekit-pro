import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaLaborTrackingView extends StatefulWidget {
  const ComaLaborTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaLaborTrackingView> createState() => _ComaLaborTrackingViewState();
}

class _ComaLaborTrackingViewState extends State<ComaLaborTrackingView> {
  String selectedProject = "all";
  String selectedTrade = "all";
  String selectedShift = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> projectFilters = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "metro_downtown"},
    {"label": "Riverside Office Park", "value": "riverside_office"},
    {"label": "Healthcare Facility", "value": "healthcare_facility"},
    {"label": "Residential Tower A", "value": "residential_tower"},
  ];

  List<Map<String, dynamic>> tradeFilters = [
    {"label": "All Trades", "value": "all"},
    {"label": "General Labor", "value": "general"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Carpentry", "value": "carpentry"},
    {"label": "Concrete", "value": "concrete"},
    {"label": "Roofing", "value": "roofing"},
  ];

  List<Map<String, dynamic>> shiftFilters = [
    {"label": "All Shifts", "value": "all"},
    {"label": "Day Shift", "value": "day"},
    {"label": "Night Shift", "value": "night"},
    {"label": "Weekend", "value": "weekend"},
    {"label": "Overtime", "value": "overtime"},
  ];

  List<Map<String, dynamic>> laborRecords = [
    {
      "id": "LAB-001",
      "worker_id": "WRK-001",
      "worker_name": "Michael Rodriguez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "trade": "electrical",
      "date": "2024-06-17",
      "shift": "day",
      "clock_in": "07:00",
      "clock_out": "15:30",
      "break_start": "12:00",
      "break_end": "12:30",
      "hours_worked": 8.0,
      "overtime_hours": 0.5,
      "regular_hours": 7.5,
      "hourly_rate": 32.50,
      "overtime_rate": 48.75,
      "total_pay": 268.13,
      "location": "Building A - Level 3",
      "supervisor": "Sarah Johnson",
      "activity": "Installing electrical outlets",
      "equipment_used": ["Drill", "Wire strippers", "Multimeter"],
      "materials_used": ["GFCI outlets", "Electrical wire", "Wire nuts"],
      "productivity_score": 92,
      "quality_score": 95,
      "safety_incidents": 0,
      "weather_conditions": "Clear",
      "temperature": 72,
      "notes": "Completed outlet installation ahead of schedule",
      "approved_by": "Sarah Johnson",
      "approval_status": "approved",
      "submitted_at": "2024-06-17 16:00",
    },
    {
      "id": "LAB-002",
      "worker_id": "WRK-002",
      "worker_name": "Jennifer Park",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "trade": "plumbing",
      "date": "2024-06-17",
      "shift": "day",
      "clock_in": "06:30",
      "clock_out": "15:00",
      "break_start": "11:30",
      "break_end": "12:00",
      "hours_worked": 8.0,
      "overtime_hours": 0.0,
      "regular_hours": 8.0,
      "hourly_rate": 28.75,
      "overtime_rate": 43.13,
      "total_pay": 230.00,
      "location": "Conference Room B",
      "supervisor": "David Wilson",
      "activity": "Installing water lines",
      "equipment_used": ["Pipe cutter", "Torch", "Pipe threader"],
      "materials_used": ["Copper pipes", "Fittings", "Solder"],
      "productivity_score": 88,
      "quality_score": 93,
      "safety_incidents": 0,
      "weather_conditions": "Partly cloudy",
      "temperature": 68,
      "notes": "Water line installation completed successfully",
      "approved_by": "David Wilson",
      "approval_status": "approved",
      "submitted_at": "2024-06-17 15:30",
    },
    {
      "id": "LAB-003",
      "worker_id": "WRK-003",
      "worker_name": "Carlos Rivera",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility",
      "trade": "hvac",
      "date": "2024-06-17",
      "shift": "night",
      "clock_in": "22:00",
      "clock_out": "06:30",
      "break_start": "02:00",
      "break_end": "02:30",
      "hours_worked": 8.0,
      "overtime_hours": 0.5,
      "regular_hours": 7.5,
      "hourly_rate": 30.00,
      "overtime_rate": 45.00,
      "total_pay": 247.50,
      "location": "Patient Wing - Mechanical Room",
      "supervisor": "James Wilson",
      "activity": "HVAC ductwork installation",
      "equipment_used": ["Duct cutter", "Sheet metal tools", "Measuring tape"],
      "materials_used": ["Ductwork", "Insulation", "Fasteners"],
      "productivity_score": 85,
      "quality_score": 90,
      "safety_incidents": 0,
      "weather_conditions": "Clear",
      "temperature": 65,
      "notes": "Night shift ductwork installation progressing well",
      "approved_by": "James Wilson",
      "approval_status": "pending",
      "submitted_at": "2024-06-17 07:00",
    },
    {
      "id": "LAB-004",
      "worker_id": "WRK-004",
      "worker_name": "Robert Garcia",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "trade": "carpentry",
      "date": "2024-06-17",
      "shift": "day",
      "clock_in": "07:30",
      "clock_out": "16:00",
      "break_start": "12:30",
      "break_end": "13:00",
      "hours_worked": 8.0,
      "overtime_hours": 0.5,
      "regular_hours": 7.5,
      "hourly_rate": 26.25,
      "overtime_rate": 39.38,
      "total_pay": 216.56,
      "location": "Unit 1205 - Kitchen",
      "supervisor": "Maria Gonzalez",
      "activity": "Cabinet installation",
      "equipment_used": ["Circular saw", "Drill", "Level"],
      "materials_used": ["Kitchen cabinets", "Screws", "Hardware"],
      "productivity_score": 96,
      "quality_score": 98,
      "safety_incidents": 0,
      "weather_conditions": "Sunny",
      "temperature": 75,
      "notes": "Kitchen cabinet installation completed with excellent quality",
      "approved_by": "Maria Gonzalez",
      "approval_status": "approved",
      "submitted_at": "2024-06-17 16:30",
    },
    {
      "id": "LAB-005",
      "worker_id": "WRK-005",
      "worker_name": "Antonio Martinez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "trade": "concrete",
      "date": "2024-06-17",
      "shift": "day",
      "clock_in": "06:00",
      "clock_out": "14:30",
      "break_start": "10:00",
      "break_end": "10:15",
      "hours_worked": 8.25,
      "overtime_hours": 0.25,
      "regular_hours": 8.0,
      "hourly_rate": 24.50,
      "overtime_rate": 36.75,
      "total_pay": 205.19,
      "location": "Foundation Area",
      "supervisor": "Thomas Anderson",
      "activity": "Concrete pouring and finishing",
      "equipment_used": ["Concrete mixer", "Float", "Screed"],
      "materials_used": ["Concrete", "Rebar", "Forms"],
      "productivity_score": 82,
      "quality_score": 87,
      "safety_incidents": 0,
      "weather_conditions": "Overcast",
      "temperature": 70,
      "notes": "Foundation pour completed successfully, weather held up",
      "approved_by": "Thomas Anderson",
      "approval_status": "approved",
      "submitted_at": "2024-06-17 15:00",
    },
    {
      "id": "LAB-006",
      "worker_id": "WRK-006",
      "worker_name": "David Kim",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "trade": "general",
      "date": "2024-06-17",
      "shift": "overtime",
      "clock_in": "16:00",
      "clock_out": "20:00",
      "break_start": null,
      "break_end": null,
      "hours_worked": 4.0,
      "overtime_hours": 4.0,
      "regular_hours": 0.0,
      "hourly_rate": 22.00,
      "overtime_rate": 33.00,
      "total_pay": 132.00,
      "location": "Site cleanup area",
      "supervisor": "Emily Rodriguez",
      "activity": "Site cleanup and material organization",
      "equipment_used": ["Broom", "Shovel", "Wheelbarrow"],
      "materials_used": ["Trash bags", "Storage containers"],
      "productivity_score": 78,
      "quality_score": 85,
      "safety_incidents": 0,
      "weather_conditions": "Clear",
      "temperature": 68,
      "notes": "Overtime shift for site cleanup, area now organized",
      "approved_by": "Emily Rodriguez",
      "approval_status": "pending",
      "submitted_at": "2024-06-17 20:30",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labor Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addLaborRecord(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showLaborAnalytics(),
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
                  _buildLaborOverview(),
                  _buildFilters(),
                  _buildProductivityMetrics(),
                  _buildLaborRecordsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildLaborOverview() {
    int totalRecords = laborRecords.length;
    double totalHours = laborRecords.fold(0.0, (sum, record) => sum + (record["hours_worked"] as double));
    double totalOvertimeHours = laborRecords.fold(0.0, (sum, record) => sum + (record["overtime_hours"] as double));
    double totalPay = laborRecords.fold(0.0, (sum, record) => sum + (record["total_pay"] as double));
    int pendingApprovals = laborRecords.where((r) => r["approval_status"] == "pending").length;

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
                child: Icon(Icons.access_time, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Labor Tracking Overview",
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
              _buildOverviewCard("Records", "$totalRecords", Icons.list, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Hours", "${totalHours.toStringAsFixed(1)}", Icons.schedule, infoColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Overtime", "${totalOvertimeHours.toStringAsFixed(1)}", Icons.access_time, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "$pendingApprovals", Icons.pending, dangerColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: successColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Total Labor Cost: \$${totalPay.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
                  label: "Search labor records...",
                  value: searchQuery,
                  hint: "Search by worker name, activity, or location",
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
                  label: "Trade",
                  items: tradeFilters,
                  value: selectedTrade,
                  onChanged: (value, label) {
                    selectedTrade = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Shift",
                  items: shiftFilters,
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
    );
  }

  Widget _buildProductivityMetrics() {
    double avgProductivity = laborRecords.fold(0.0, (sum, r) => sum + (r["productivity_score"] as int)) / laborRecords.length;
    double avgQuality = laborRecords.fold(0.0, (sum, r) => sum + (r["quality_score"] as int)) / laborRecords.length;
    double avgHoursPerWorker = laborRecords.fold(0.0, (sum, r) => sum + (r["hours_worked"] as double)) / laborRecords.length;
    int safetyIncidents = laborRecords.fold(0, (sum, r) => sum + (r["safety_incidents"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Productivity & Quality Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: infoColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Productivity", "${avgProductivity.toInt()}%", Icons.trending_up, primaryColor),
              SizedBox(width: spSm),
              _buildMetricCard("Quality", "${avgQuality.toInt()}%", Icons.verified, successColor),
              SizedBox(width: spSm),
              _buildMetricCard("Avg Hours", "${avgHoursPerWorker.toStringAsFixed(1)}", Icons.schedule, infoColor),
              SizedBox(width: spSm),
              _buildMetricCard("Incidents", "$safetyIncidents", Icons.warning, safetyIncidents > 0 ? dangerColor : successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildLaborRecordsList() {
    List<Map<String, dynamic>> filteredRecords = _getFilteredRecords();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Labor Records (${filteredRecords.length})",
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
        ...filteredRecords.map((record) => _buildLaborRecordCard(record)),
      ],
    );
  }

  Widget _buildLaborRecordCard(Map<String, dynamic> record) {
    Color statusColor = _getApprovalColor(record["approval_status"]);
    Color shiftColor = _getShiftColor(record["shift"]);

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
                      "${record["worker_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${record["id"]} - ${record["date"]}",
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
                  "${record["approval_status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: shiftColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${record["shift"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: shiftColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${record["trade"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${record["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${record["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Activity: ${record["activity"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
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
                  "Time & Hours",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Clock In: ${record["clock_in"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Clock Out: ${record["clock_out"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (record["break_start"] != null)
                  Row(
                    children: [
                      Text(
                        "Break: ${record["break_start"]} - ${record["break_end"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text(
                      "Regular Hours: ${record["regular_hours"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Overtime: ${record["overtime_hours"]}",
                      style: TextStyle(
                        fontSize: 11,
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
                      "Hourly Rate: \$${((record["hourly_rate"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "OT Rate: \$${((record["overtime_rate"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Total Pay: \$${((record["total_pay"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if ((record["equipment_used"] as List).isNotEmpty || (record["materials_used"] as List).isNotEmpty)
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
                  if ((record["equipment_used"] as List).isNotEmpty)
                    Text(
                      "Equipment: ${(record["equipment_used"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                  if ((record["materials_used"] as List).isNotEmpty)
                    Text(
                      "Materials: ${(record["materials_used"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              _buildScoreIndicator("Productivity", record["productivity_score"], primaryColor),
              SizedBox(width: spSm),
              _buildScoreIndicator("Quality", record["quality_score"], successColor),
              SizedBox(width: spSm),
              _buildSafetyIndicator(record["safety_incidents"]),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Supervisor: ${record["supervisor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Weather: ${record["weather_conditions"]} ${record["temperature"]}°F",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (record["notes"] != null && record["notes"].toString().isNotEmpty)
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
                      "${record["notes"]}",
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
              Text(
                "Submitted: ${record["submitted_at"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewLaborDetails(record["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editLaborRecord(record["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showLaborRecordOptions(record),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(String label, int score, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (score as num) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$score%",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyIndicator(int incidents) {
    Color color = incidents == 0 ? successColor : dangerColor;
    
    return Expanded(
      child: Column(
        children: [
          Icon(incidents == 0 ? Icons.check_circle : Icons.warning, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            "$incidents",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Incidents",
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredRecords() {
    List<Map<String, dynamic>> filtered = laborRecords;

    if (selectedProject != "all") {
      filtered = filtered.where((record) => 
          record["project_name"].toString().toLowerCase().contains(selectedProject)).toList();
    }

    if (selectedTrade != "all") {
      filtered = filtered.where((record) => record["trade"] == selectedTrade).toList();
    }

    if (selectedShift != "all") {
      filtered = filtered.where((record) => record["shift"] == selectedShift).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) =>
          record["worker_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["activity"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getApprovalColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getShiftColor(String shift) {
    switch (shift.toLowerCase()) {
      case 'day':
        return infoColor;
      case 'night':
        return primaryColor;
      case 'weekend':
        return warningColor;
      case 'overtime':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addLaborRecord() {
    ss("Add new labor record");
  }

  void _showLaborAnalytics() {
    ss("Labor tracking analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced labor filters");
  }

  void _showSortOptions() {
    ss("Labor record sort options");
  }

  void _viewLaborDetails(String recordId) {
    ss("View labor record details $recordId");
  }

  void _editLaborRecord(String recordId) {
    ss("Edit labor record $recordId");
  }

  void _showLaborRecordOptions(Map<String, dynamic> record) {
    ss("Labor record options for ${record["worker_name"]}");
  }
}

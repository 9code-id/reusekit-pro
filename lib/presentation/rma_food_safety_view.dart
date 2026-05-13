import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaFoodSafetyView extends StatefulWidget {
  const RmaFoodSafetyView({Key? key}) : super(key: key);

  @override
  State<RmaFoodSafetyView> createState() => _RmaFoodSafetyViewState();
}

class _RmaFoodSafetyViewState extends State<RmaFoodSafetyView> {
  String selectedArea = "all";
  String selectedSeverity = "all";
  bool loading = false;

  List<Map<String, dynamic>> areaFilter = [
    {"label": "All Areas", "value": "all"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Storage", "value": "storage"},
    {"label": "Dining", "value": "dining"},
    {"label": "Prep Area", "value": "prep"},
  ];

  List<Map<String, dynamic>> severityFilter = [
    {"label": "All Levels", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "Major", "value": "major"},
    {"label": "Minor", "value": "minor"},
  ];

  List<Map<String, dynamic>> safetyIssues = [
    {
      "id": "FS001",
      "title": "Temperature Control Violation",
      "area": "Kitchen",
      "severity": "critical",
      "description": "Refrigerator temperature above 40°F (4°C) detected",
      "dateReported": "2025-06-15",
      "status": "pending",
      "reportedBy": "Sarah Johnson",
      "riskLevel": "High",
      "estimatedCost": 2500.0,
      "image": "https://picsum.photos/400/300?random=1&keyword=kitchen",
    },
    {
      "id": "FS002",
      "title": "Cross Contamination Risk",
      "area": "Prep Area",
      "severity": "major",
      "description": "Raw meat stored above ready-to-eat foods",
      "dateReported": "2025-06-14",
      "status": "in_progress",
      "reportedBy": "Michael Chen",
      "riskLevel": "Medium",
      "estimatedCost": 800.0,
      "image": "https://picsum.photos/400/300?random=2&keyword=food",
    },
    {
      "id": "FS003",
      "title": "Cleaning Chemical Storage",
      "area": "Storage",
      "severity": "major",
      "description": "Cleaning supplies stored near food items",
      "dateReported": "2025-06-13",
      "status": "resolved",
      "reportedBy": "Emma Rodriguez",
      "riskLevel": "Medium",
      "estimatedCost": 150.0,
      "image": "https://picsum.photos/400/300?random=3&keyword=storage",
    },
    {
      "id": "FS004",
      "title": "Equipment Sanitation",
      "area": "Kitchen",
      "severity": "minor",
      "description": "Food slicer requires deep cleaning",
      "dateReported": "2025-06-12",
      "status": "pending",
      "reportedBy": "David Thompson",
      "riskLevel": "Low",
      "estimatedCost": 75.0,
      "image": "https://picsum.photos/400/300?random=4&keyword=equipment",
    },
  ];

  List<Map<String, dynamic>> temperatureLogs = [
    {"time": "06:00", "freezer": -18, "fridge": 3, "hotHold": 65},
    {"time": "09:00", "freezer": -17, "fridge": 4, "hotHold": 68},
    {"time": "12:00", "freezer": -18, "fridge": 3, "hotHold": 67},
    {"time": "15:00", "freezer": -17, "fridge": 5, "hotHold": 66},
    {"time": "18:00", "freezer": -18, "fridge": 4, "hotHold": 69},
    {"time": "21:00", "freezer": -17, "fridge": 3, "hotHold": 65},
  ];

  List<Map<String, dynamic>> inspectionHistory = [
    {
      "date": "2025-06-10",
      "inspector": "Health Department",
      "score": 95,
      "violations": 2,
      "status": "passed",
    },
    {
      "date": "2025-05-15",
      "inspector": "Internal Audit",
      "score": 88,
      "violations": 5,
      "status": "passed",
    },
    {
      "date": "2025-04-20",
      "inspector": "Third Party",
      "score": 92,
      "violations": 3,
      "status": "passed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Safety Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () => _reportIssue(),
          ),
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () => _generateReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildSafetyOverview(),
            SizedBox(height: spLg),
            _buildTemperatureMonitoring(),
            SizedBox(height: spLg),
            _buildActiveIssues(),
            SizedBox(height: spLg),
            _buildInspectionHistory(),
            SizedBox(height: spLg),
            _buildQuickActions(),
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
        children: [
          Text(
            "Filter Issues",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Area",
                  items: areaFilter,
                  value: selectedArea,
                  onChanged: (value, label) {
                    selectedArea = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityFilter,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
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

  Widget _buildSafetyOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard(
          "Active Issues",
          "12",
          Icons.warning,
          dangerColor,
          "3 Critical",
        ),
        _buildOverviewCard(
          "Resolved Today",
          "8",
          Icons.check_circle,
          successColor,
          "95% completion rate",
        ),
        _buildOverviewCard(
          "Temperature Alerts",
          "2",
          Icons.thermostat,
          warningColor,
          "All within range",
        ),
        _buildOverviewCard(
          "Inspection Score",
          "95",
          Icons.star,
          primaryColor,
          "Last inspection",
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureMonitoring() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Temperature Monitoring",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewFullLogs(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildTempCard("Freezer", "-18°C", successColor, "Target: -18°C"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildTempCard("Refrigerator", "4°C", warningColor, "Target: 0-4°C"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildTempCard("Hot Hold", "67°C", successColor, "Target: >60°C"),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 120,
            child: Column(
              children: temperatureLogs.map((log) => _buildTempLogRow(log)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTempCard(String title, String temp, Color color, String target) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            temp,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            target,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTempLogRow(Map<String, dynamic> log) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              "${log["time"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildTempIndicator("F", log["freezer"], Colors.blue),
                SizedBox(width: spSm),
                _buildTempIndicator("R", log["fridge"], Colors.green),
                SizedBox(width: spSm),
                _buildTempIndicator("H", log["hotHold"], Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTempIndicator(String label, int temp, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 4),
        Text(
          "${temp}°",
          style: TextStyle(
            fontSize: 10,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Active Safety Issues",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _viewAllIssues(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...safetyIssues.where((issue) => issue["status"] != "resolved").map((issue) => _buildIssueCard(issue)).toList(),
      ],
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    Color severityColor = _getSeverityColor(issue["severity"]);
    Color statusColor = _getStatusColor(issue["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Image.network(
              "${issue["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${issue["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${issue["severity"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: severityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${issue["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: primaryColor),
                    SizedBox(width: 4),
                    Text(
                      "${issue["area"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${issue["reportedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((issue["estimatedCost"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "critical":
        return dangerColor;
      case "major":
        return warningColor;
      case "minor":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "resolved":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildInspectionHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Inspections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...inspectionHistory.map((inspection) => _buildInspectionRow(inspection)).toList(),
        ],
      ),
    );
  }

  Widget _buildInspectionRow(Map<String, dynamic> inspection) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${inspection["inspector"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${inspection["date"]}",
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
              Text(
                "Score: ${inspection["score"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (inspection["score"] as int) >= 90 ? successColor : warningColor,
                ),
              ),
              Text(
                "${inspection["violations"]} violations",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(width: spMd),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: inspection["status"] == "passed" ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${inspection["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: inspection["status"] == "passed" ? successColor : dangerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.report_problem, color: dangerColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Report Safety Issue",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Report new food safety violations or concerns",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Report Issue",
                  size: bs.sm,
                  onPressed: () => _reportIssue(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Schedule Inspection",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Schedule internal or external safety inspections",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule",
                  size: bs.sm,
                  onPressed: () => _scheduleInspection(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _reportIssue() {
    si("Opening safety issue report form");
  }

  void _generateReport() {
    ss("Food safety report generated successfully");
  }

  void _viewFullLogs() {
    si("Opening complete temperature logs");
  }

  void _viewAllIssues() {
    si("Opening all safety issues");
  }

  void _scheduleInspection() {
    si("Opening inspection scheduler");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaQualityControlView extends StatefulWidget {
  const ComaQualityControlView({Key? key}) : super(key: key);

  @override
  State<ComaQualityControlView> createState() => _ComaQualityControlViewState();
}

class _ComaQualityControlViewState extends State<ComaQualityControlView> {
  String selectedProject = "all";
  String selectedPhase = "all";
  String selectedInspector = "all";
  bool loading = false;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "PRJ-001"},
    {"label": "Riverside Office Park", "value": "PRJ-002"},
    {"label": "Healthcare Facility", "value": "PRJ-003"},
    {"label": "Residential Tower A", "value": "PRJ-004"},
  ];

  List<Map<String, dynamic>> phases = [
    {"label": "All Phases", "value": "all"},
    {"label": "Foundation", "value": "foundation"},
    {"label": "Structural", "value": "structural"},
    {"label": "MEP", "value": "mep"},
    {"label": "Finishing", "value": "finishing"},
  ];

  List<Map<String, dynamic>> inspectors = [
    {"label": "All Inspectors", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah"},
    {"label": "Michael Chen", "value": "michael"},
    {"label": "Emily Rodriguez", "value": "emily"},
    {"label": "David Wilson", "value": "david"},
  ];

  List<Map<String, dynamic>> qualityInspections = [
    {
      "id": "QC-2024-001",
      "inspection_number": "QC001",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "phase": "foundation",
      "inspection_type": "Concrete Pour",
      "location": "Building A - Foundation Level",
      "inspector": "Sarah Johnson",
      "inspection_date": "2024-06-15",
      "scheduled_date": "2024-06-15",
      "status": "passed",
      "overall_score": 92,
      "criteria_scores": {
        "material_quality": 95,
        "workmanship": 90,
        "safety_compliance": 88,
        "code_compliance": 95,
        "documentation": 92
      },
      "defects_found": 2,
      "critical_issues": 0,
      "minor_issues": 2,
      "corrective_actions": 1,
      "contractor": "Foundation Masters Inc",
      "supervisor": "Mike Rodriguez",
      "weather_conditions": "Clear, 75°F",
      "test_results": [
        {"test_name": "Concrete Slump", "result": "4 inches", "standard": "3-5 inches", "status": "pass"},
        {"test_name": "Compressive Strength", "result": "4200 PSI", "standard": "4000 PSI min", "status": "pass"},
        {"test_name": "Air Content", "result": "6.2%", "standard": "5-8%", "status": "pass"}
      ],
      "notes": "Excellent concrete quality, minor formwork alignment issues corrected",
      "photos": ["https://picsum.photos/300/200?random=1&keyword=concrete"],
      "next_inspection": "2024-06-18",
      "certificate_issued": true,
      "client_notification": true,
    },
    {
      "id": "QC-2024-002",
      "inspection_number": "QC002",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "phase": "structural",
      "inspection_type": "Steel Frame",
      "location": "Building B - Level 3",
      "inspector": "Michael Chen",
      "inspection_date": "2024-06-16",
      "scheduled_date": "2024-06-16",
      "status": "conditional_pass",
      "overall_score": 78,
      "criteria_scores": {
        "material_quality": 85,
        "workmanship": 75,
        "safety_compliance": 80,
        "code_compliance": 82,
        "documentation": 68
      },
      "defects_found": 5,
      "critical_issues": 1,
      "minor_issues": 4,
      "corrective_actions": 3,
      "contractor": "Steel Works Ltd",
      "supervisor": "Jennifer Park",
      "weather_conditions": "Cloudy, 68°F",
      "test_results": [
        {"test_name": "Weld Quality", "result": "Grade B", "standard": "Grade A-B", "status": "pass"},
        {"test_name": "Bolt Torque", "result": "425 ft-lbs", "standard": "400-450 ft-lbs", "status": "pass"},
        {"test_name": "Alignment Check", "result": "2mm deviation", "standard": "±5mm", "status": "pass"}
      ],
      "notes": "Documentation incomplete, some welds require touch-up",
      "photos": ["https://picsum.photos/300/200?random=2&keyword=steel"],
      "next_inspection": "2024-06-20",
      "certificate_issued": false,
      "client_notification": false,
    },
    {
      "id": "QC-2024-003",
      "inspection_number": "QC003",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "phase": "mep",
      "inspection_type": "Electrical Systems",
      "location": "Patient Wing - All Floors",
      "inspector": "Emily Rodriguez",
      "inspection_date": "2024-06-14",
      "scheduled_date": "2024-06-14",
      "status": "failed",
      "overall_score": 65,
      "criteria_scores": {
        "material_quality": 75,
        "workmanship": 60,
        "safety_compliance": 55,
        "code_compliance": 70,
        "documentation": 65
      },
      "defects_found": 8,
      "critical_issues": 3,
      "minor_issues": 5,
      "corrective_actions": 6,
      "contractor": "Power Systems Inc",
      "supervisor": "Thomas Anderson",
      "weather_conditions": "Indoor",
      "test_results": [
        {"test_name": "Insulation Resistance", "result": "15 MΩ", "standard": "20 MΩ min", "status": "fail"},
        {"test_name": "Ground Fault", "result": "Present", "standard": "None", "status": "fail"},
        {"test_name": "Voltage Drop", "result": "8%", "standard": "5% max", "status": "fail"}
      ],
      "notes": "Multiple code violations found, requires complete rework of circuits 12-15",
      "photos": ["https://picsum.photos/300/200?random=3&keyword=electrical"],
      "next_inspection": "2024-06-22",
      "certificate_issued": false,
      "client_notification": true,
    },
    {
      "id": "QC-2024-004",
      "inspection_number": "QC004",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "phase": "finishing",
      "inspection_type": "Interior Finishes",
      "location": "Units 1201-1210",
      "inspector": "David Wilson",
      "inspection_date": "2024-06-17",
      "scheduled_date": "2024-06-17",
      "status": "passed",
      "overall_score": 88,
      "criteria_scores": {
        "material_quality": 90,
        "workmanship": 85,
        "safety_compliance": 92,
        "code_compliance": 90,
        "documentation": 83
      },
      "defects_found": 3,
      "critical_issues": 0,
      "minor_issues": 3,
      "corrective_actions": 2,
      "contractor": "Premier Finishes Co",
      "supervisor": "Maria Gonzalez",
      "weather_conditions": "Indoor",
      "test_results": [
        {"test_name": "Paint Thickness", "result": "3.5 mils", "standard": "3-4 mils", "status": "pass"},
        {"test_name": "Tile Adhesion", "result": "Good", "standard": "Good-Excellent", "status": "pass"},
        {"test_name": "Floor Levelness", "result": "2mm/3m", "standard": "±3mm/3m", "status": "pass"}
      ],
      "notes": "High quality workmanship, minor touch-ups needed in bathroom tiles",
      "photos": ["https://picsum.photos/300/200?random=4&keyword=interior"],
      "next_inspection": "2024-06-20",
      "certificate_issued": true,
      "client_notification": false,
    },
    {
      "id": "QC-2024-005",
      "inspection_number": "QC005",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "phase": "mep",
      "inspection_type": "HVAC Installation",
      "location": "Mechanical Room - Basement",
      "inspector": "Sarah Johnson",
      "inspection_date": "2024-06-16",
      "scheduled_date": "2024-06-15",
      "status": "in_progress",
      "overall_score": null,
      "criteria_scores": {},
      "defects_found": null,
      "critical_issues": null,
      "minor_issues": null,
      "corrective_actions": null,
      "contractor": "Climate Control Experts",
      "supervisor": "Carlos Rivera",
      "weather_conditions": "Indoor",
      "test_results": [],
      "notes": "Inspection in progress, preliminary review shows good installation",
      "photos": ["https://picsum.photos/300/200?random=5&keyword=hvac"],
      "next_inspection": null,
      "certificate_issued": false,
      "client_notification": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Control"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _scheduleNewInspection(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showQualityAnalytics(),
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
                  _buildQualityOverview(),
                  _buildFilters(),
                  _buildQualityMetrics(),
                  _buildInspectionsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildQualityOverview() {
    int totalInspections = qualityInspections.length;
    int passedInspections = qualityInspections.where((i) => i["status"] == "passed").length;
    int failedInspections = qualityInspections.where((i) => i["status"] == "failed").length;
    double avgScore = qualityInspections
        .where((i) => i["overall_score"] != null)
        .fold(0.0, (sum, i) => sum + (i["overall_score"] as int)) / 
        qualityInspections.where((i) => i["overall_score"] != null).length;

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
                child: Icon(Icons.verified, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Quality Control Overview",
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
              _buildOverviewCard("Total Inspections", "$totalInspections", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Passed", "$passedInspections", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Failed", "$failedInspections", Icons.cancel, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Avg Score", "${avgScore.toInt()}%", Icons.star, warningColor),
            ],
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
          Text(
            "Filter Inspections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projects,
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
                  label: "Phase",
                  items: phases,
                  value: selectedPhase,
                  onChanged: (value, label) {
                    selectedPhase = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Inspector",
                  items: inspectors,
                  value: selectedInspector,
                  onChanged: (value, label) {
                    selectedInspector = value;
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

  Widget _buildQualityMetrics() {
    int criticalIssues = qualityInspections.fold(0, (sum, i) => sum + ((i["critical_issues"] as int?) ?? 0));
    int totalDefects = qualityInspections.fold(0, (sum, i) => sum + ((i["defects_found"] as int?) ?? 0));
    int certificatesIssued = qualityInspections.where((i) => i["certificate_issued"] == true).length;

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
            "Quality Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Critical Issues", "$criticalIssues", Icons.error, dangerColor),
              SizedBox(width: spSm),
              _buildMetricCard("Total Defects", "$totalDefects", Icons.warning, warningColor),
              SizedBox(width: spSm),
              _buildMetricCard("Certificates Issued", "$certificatesIssued", Icons.verified, successColor),
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

  Widget _buildInspectionsList() {
    List<Map<String, dynamic>> filteredInspections = _getFilteredInspections();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Quality Inspections (${filteredInspections.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.calendar_today,
              size: bs.sm,
              onPressed: () => _showInspectionSchedule(),
            ),
          ],
        ),
        ...filteredInspections.map((inspection) => _buildInspectionCard(inspection)),
      ],
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    Color statusColor = _getStatusColor(inspection["status"]);

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
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${inspection["id"]} - ${inspection["inspection_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${inspection["inspection_type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (inspection["overall_score"] != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Text(
                    "${inspection["overall_score"]}%",
                    style: TextStyle(
                      fontSize: 18,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${inspection["status"]}".toUpperCase(),
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
            "Project: ${inspection["project_name"]} | Phase: ${inspection["phase"]}",
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
                  "${inspection["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          if (inspection["criteria_scores"].isNotEmpty)
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
                    "Quality Criteria Scores",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...(inspection["criteria_scores"] as Map<String, dynamic>).entries.map((entry) => 
                    _buildCriteriaScore(entry.key, entry.value as int)
                  ),
                ],
              ),
            ),
          if ((inspection["test_results"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Test Results",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...(inspection["test_results"] as List).map((test) => _buildTestResult(test)),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Inspector: ${inspection["inspector"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Date: ${inspection["inspection_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Contractor: ${inspection["contractor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Supervisor: ${inspection["supervisor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (inspection["defects_found"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Defects: ${inspection["defects_found"]} | Critical: ${inspection["critical_issues"]} | Minor: ${inspection["minor_issues"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          if (inspection["notes"] != null && inspection["notes"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${inspection["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if (inspection["certificate_issued"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CERTIFICATE ISSUED",
                    style: TextStyle(
                      fontSize: 10,
                      color: successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (inspection["client_notification"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CLIENT NOTIFIED",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              if (inspection["next_inspection"] != null)
                Text(
                  "Next: ${inspection["next_inspection"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Weather: ${inspection["weather_conditions"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewInspectionDetails(inspection["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editInspection(inspection["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showInspectionOptions(inspection),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaScore(String criteria, int score) {
    Color scoreColor = score >= 90 ? successColor : score >= 75 ? warningColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              criteria.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "$score%",
            style: TextStyle(
              fontSize: 11,
              color: scoreColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResult(Map<String, dynamic> test) {
    Color resultColor = test["status"] == "pass" ? successColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: resultColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: resultColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${test["test_name"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: resultColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${test["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    color: resultColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Result: ${test["result"]} (Standard: ${test["standard"]})",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredInspections() {
    List<Map<String, dynamic>> filtered = qualityInspections;

    if (selectedProject != "all") {
      filtered = filtered.where((inspection) => inspection["project_id"] == selectedProject).toList();
    }

    if (selectedPhase != "all") {
      filtered = filtered.where((inspection) => inspection["phase"] == selectedPhase).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
        return successColor;
      case 'conditional_pass':
        return warningColor;
      case 'failed':
        return dangerColor;
      case 'in_progress':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _scheduleNewInspection() {
    ss("Schedule new quality inspection");
  }

  void _showQualityAnalytics() {
    ss("Quality control analytics");
  }

  void _showInspectionSchedule() {
    ss("Inspection schedule view");
  }

  void _viewInspectionDetails(String inspectionId) {
    ss("Viewing inspection details $inspectionId");
  }

  void _editInspection(String inspectionId) {
    ss("Editing inspection $inspectionId");
  }

  void _showInspectionOptions(Map<String, dynamic> inspection) {
    ss("Inspection options for ${inspection["id"]}");
  }
}

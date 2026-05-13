import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDefectTrackingView extends StatefulWidget {
  const ComaDefectTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaDefectTrackingView> createState() => _ComaDefectTrackingViewState();
}

class _ComaDefectTrackingViewState extends State<ComaDefectTrackingView> {
  String selectedSeverity = "all";
  String selectedStatus = "all";
  String selectedCategory = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> severityFilters = [
    {"label": "All Severity", "value": "all", "count": 32},
    {"label": "Critical", "value": "critical", "count": 4},
    {"label": "Major", "value": "major", "count": 12},
    {"label": "Minor", "value": "minor", "count": 16},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Verified", "value": "verified"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Structural", "value": "structural"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Finishing", "value": "finishing"},
    {"label": "Safety", "value": "safety"},
  ];

  List<Map<String, dynamic>> defects = [
    {
      "id": "DEF-2024-001",
      "defect_number": "001",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "location": "Building A - Level 3 - Room 305",
      "category": "electrical",
      "title": "Outlet Not Functioning",
      "description": "GFCI outlet in bathroom not providing power, breaker appears functional",
      "severity": "major",
      "status": "in_progress",
      "detected_by": "Sarah Johnson",
      "detection_date": "2024-06-15",
      "assigned_to": "Michael Chen",
      "assigned_date": "2024-06-15",
      "target_resolution": "2024-06-18",
      "actual_resolution": null,
      "verification_date": null,
      "root_cause": "Faulty GFCI outlet internal wiring",
      "corrective_action": "Replace GFCI outlet and test circuit integrity",
      "preventive_action": "Implement pre-installation testing for all GFCI outlets",
      "cost_impact": 125.0,
      "schedule_impact_hours": 2,
      "quality_impact": "medium",
      "safety_risk": "medium",
      "warranty_impact": true,
      "client_impact": "low",
      "contractor": "Power Systems Inc",
      "trade": "Electrical",
      "images": ["https://picsum.photos/300/200?random=1&keyword=electrical"],
      "documentation": ["Electrical test report", "Outlet replacement work order"],
      "related_defects": [],
      "comments": [
        {
          "author": "Michael Chen",
          "date": "2024-06-15",
          "comment": "Investigating root cause, outlet appears to be manufacturing defect"
        }
      ],
      "verified_by": null,
      "closure_notes": null,
    },
    {
      "id": "DEF-2024-002",
      "defect_number": "002",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "location": "Conference Room B - Ceiling",
      "category": "structural",
      "title": "Ceiling Tile Misalignment",
      "description": "Acoustic ceiling tiles not properly aligned, visible gaps and uneven spacing",
      "severity": "minor",
      "status": "resolved",
      "detected_by": "Emily Rodriguez",
      "detection_date": "2024-06-12",
      "assigned_to": "David Wilson",
      "assigned_date": "2024-06-12",
      "target_resolution": "2024-06-16",
      "actual_resolution": "2024-06-14",
      "verification_date": "2024-06-15",
      "root_cause": "Improper grid system installation during initial installation",
      "corrective_action": "Realign ceiling grid system and reinstall tiles",
      "preventive_action": "Implement quality check for grid alignment before tile installation",
      "cost_impact": 380.0,
      "schedule_impact_hours": 6,
      "quality_impact": "low",
      "safety_risk": "none",
      "warranty_impact": false,
      "client_impact": "medium",
      "contractor": "Interior Systems Co",
      "trade": "Ceiling",
      "images": ["https://picsum.photos/300/200?random=2&keyword=ceiling"],
      "documentation": ["Before/after photos", "Grid alignment measurements"],
      "related_defects": [],
      "comments": [
        {
          "author": "David Wilson",
          "date": "2024-06-14",
          "comment": "Grid realigned and tiles reinstalled. Quality much improved."
        }
      ],
      "verified_by": "Jennifer Park",
      "closure_notes": "Defect successfully resolved, ceiling appearance now meets standards",
    },
    {
      "id": "DEF-2024-003",
      "defect_number": "003",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "location": "Patient Wing - Room 312 - Bathroom",
      "category": "plumbing",
      "title": "Water Pressure Issues",
      "description": "Insufficient water pressure in patient bathroom, affects shower and sink functionality",
      "severity": "critical",
      "status": "open",
      "detected_by": "Thomas Anderson",
      "detection_date": "2024-06-16",
      "assigned_to": "Carlos Rivera",
      "assigned_date": "2024-06-16",
      "target_resolution": "2024-06-19",
      "actual_resolution": null,
      "verification_date": null,
      "root_cause": "Under investigation - possible pipe sizing or blockage issue",
      "corrective_action": "Pressure test system and identify restriction points",
      "preventive_action": "Comprehensive pressure testing before final inspection",
      "cost_impact": 750.0,
      "schedule_impact_hours": 12,
      "quality_impact": "critical",
      "safety_risk": "low",
      "warranty_impact": true,
      "client_impact": "high",
      "contractor": "Elite Plumbing Solutions",
      "trade": "Plumbing",
      "images": ["https://picsum.photos/300/200?random=3&keyword=plumbing"],
      "documentation": ["Pressure test results", "System diagrams"],
      "related_defects": ["DEF-2024-005"],
      "comments": [
        {
          "author": "Carlos Rivera",
          "date": "2024-06-16",
          "comment": "Initial investigation suggests pipe sizing may be inadequate"
        }
      ],
      "verified_by": null,
      "closure_notes": null,
    },
    {
      "id": "DEF-2024-004",
      "defect_number": "004",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "location": "Unit 1205 - Kitchen",
      "category": "finishing",
      "title": "Cabinet Door Scratches",
      "description": "Multiple scratches on cabinet door surfaces, likely from installation process",
      "severity": "minor",
      "status": "closed",
      "detected_by": "Maria Gonzalez",
      "detection_date": "2024-06-10",
      "assigned_to": "Robert Garcia",
      "assigned_date": "2024-06-10",
      "target_resolution": "2024-06-14",
      "actual_resolution": "2024-06-13",
      "verification_date": "2024-06-14",
      "root_cause": "Inadequate protection during installation",
      "corrective_action": "Sand and refinish affected door surfaces",
      "preventive_action": "Implement cabinet protection protocols during installation",
      "cost_impact": 95.0,
      "schedule_impact_hours": 3,
      "quality_impact": "low",
      "safety_risk": "none",
      "warranty_impact": false,
      "client_impact": "low",
      "contractor": "Master Woodworks",
      "trade": "Carpentry",
      "images": ["https://picsum.photos/300/200?random=4&keyword=cabinet"],
      "documentation": ["Refinishing work order", "Quality photos"],
      "related_defects": [],
      "comments": [
        {
          "author": "Robert Garcia",
          "date": "2024-06-13",
          "comment": "Refinishing complete, surfaces restored to original condition"
        }
      ],
      "verified_by": "Maria Gonzalez",
      "closure_notes": "Cabinet doors successfully refinished, client satisfied with results",
    },
    {
      "id": "DEF-2024-005",
      "defect_number": "005",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "location": "Patient Wing - Multiple Rooms",
      "category": "plumbing",
      "title": "Inconsistent Water Temperature",
      "description": "Water temperature fluctuations across multiple patient rooms, affecting comfort",
      "severity": "major",
      "status": "in_progress",
      "detected_by": "Jennifer Park",
      "detection_date": "2024-06-14",
      "assigned_to": "Carlos Rivera",
      "assigned_date": "2024-06-14",
      "target_resolution": "2024-06-20",
      "actual_resolution": null,
      "verification_date": null,
      "root_cause": "Hot water circulation system balancing issues",
      "corrective_action": "Rebalance hot water circulation and install mixing valves",
      "preventive_action": "System commissioning and balancing procedures",
      "cost_impact": 1250.0,
      "schedule_impact_hours": 16,
      "quality_impact": "high",
      "safety_risk": "medium",
      "warranty_impact": true,
      "client_impact": "high",
      "contractor": "Elite Plumbing Solutions",
      "trade": "Plumbing",
      "images": ["https://picsum.photos/300/200?random=5&keyword=plumbing"],
      "documentation": ["Temperature readings", "System balancing report"],
      "related_defects": ["DEF-2024-003"],
      "comments": [
        {
          "author": "Carlos Rivera",
          "date": "2024-06-15",
          "comment": "Installing additional mixing valves to regulate temperature"
        }
      ],
      "verified_by": null,
      "closure_notes": null,
    },
    {
      "id": "DEF-2024-006",
      "defect_number": "006",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "location": "Mechanical Room - HVAC Equipment",
      "category": "hvac",
      "title": "Vibration and Noise Issues",
      "description": "Excessive vibration and noise from HVAC equipment affecting nearby offices",
      "severity": "major",
      "status": "verified",
      "detected_by": "Antonio Martinez",
      "detection_date": "2024-06-11",
      "assigned_to": "James Wilson",
      "assigned_date": "2024-06-11",
      "target_resolution": "2024-06-17",
      "actual_resolution": "2024-06-16",
      "verification_date": "2024-06-17",
      "root_cause": "Insufficient vibration isolation mounting",
      "corrective_action": "Install additional vibration dampeners and isolation pads",
      "preventive_action": "Review vibration isolation specifications for all equipment",
      "cost_impact": 890.0,
      "schedule_impact_hours": 8,
      "quality_impact": "medium",
      "safety_risk": "low",
      "warranty_impact": false,
      "client_impact": "medium",
      "contractor": "Climate Control Experts",
      "trade": "HVAC",
      "images": ["https://picsum.photos/300/200?random=6&keyword=hvac"],
      "documentation": ["Vibration test results", "Isolation system specs"],
      "related_defects": [],
      "comments": [
        {
          "author": "James Wilson",
          "date": "2024-06-16",
          "comment": "Additional isolation installed, noise levels now within acceptable range"
        }
      ],
      "verified_by": "Sarah Johnson",
      "closure_notes": "Vibration and noise levels successfully reduced to acceptable standards",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Defect Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _reportNewDefect(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showDefectAnalytics(),
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
                  _buildDefectOverview(),
                  _buildFilters(),
                  _buildSeverityDistribution(),
                  _buildDefectsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildDefectOverview() {
    int totalDefects = defects.length;
    int openDefects = defects.where((d) => d["status"] == "open").length;
    int criticalDefects = defects.where((d) => d["severity"] == "critical").length;
    int resolvedDefects = defects.where((d) => d["status"] == "resolved" || d["status"] == "verified" || d["status"] == "closed").length;

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
                child: Icon(Icons.bug_report, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Defect Tracking Overview",
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
              _buildOverviewCard("Total Defects", "$totalDefects", Icons.list, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Open", "$openDefects", Icons.error, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Critical", "$criticalDefects", Icons.priority_high, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Resolved", "$resolvedDefects", Icons.check_circle, successColor),
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
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search defects...",
                  value: searchQuery,
                  hint: "Search by title, description, or location",
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
                  label: "Severity",
                  items: severityFilters,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
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
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryFilters,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
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

  Widget _buildSeverityDistribution() {
    int criticalDefects = defects.where((d) => d["severity"] == "critical").length;
    int majorDefects = defects.where((d) => d["severity"] == "major").length;
    int minorDefects = defects.where((d) => d["severity"] == "minor").length;
    double avgCost = defects.fold(0.0, (sum, d) => sum + (d["cost_impact"] as double)) / defects.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Defect Distribution & Impact",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
          Row(
            children: [
              _buildDistributionCard("Critical", "$criticalDefects", dangerColor),
              SizedBox(width: spSm),
              _buildDistributionCard("Major", "$majorDefects", warningColor),
              SizedBox(width: spSm),
              _buildDistributionCard("Minor", "$minorDefects", successColor),
              SizedBox(width: spSm),
              _buildDistributionCard("Avg Cost", "\$${avgCost.toInt()}", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionCard(String title, String value, Color color) {
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
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
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

  Widget _buildDefectsList() {
    List<Map<String, dynamic>> filteredDefects = _getFilteredDefects();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Defects (${filteredDefects.length})",
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
        ...filteredDefects.map((defect) => _buildDefectCard(defect)),
      ],
    );
  }

  Widget _buildDefectCard(Map<String, dynamic> defect) {
    Color statusColor = _getStatusColor(defect["status"]);
    Color severityColor = _getSeverityColor(defect["severity"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: severityColor,
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
                      "${defect["id"]} - #${defect["defect_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${defect["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                  "${defect["status"]}".toUpperCase(),
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
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${defect["severity"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
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
                  "${defect["category"]}".toUpperCase(),
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
            "Project: ${defect["project_name"]}",
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
                  "${defect["location"]}",
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
              "${defect["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          if ((defect["images"] as List).isNotEmpty)
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: (defect["images"] as List).map((imageUrl) => Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("$imageUrl"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
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
                  "Root Cause & Actions",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (defect["root_cause"] != null)
                  Text(
                    "Root Cause: ${defect["root_cause"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
                if (defect["corrective_action"] != null)
                  Text(
                    "Corrective Action: ${defect["corrective_action"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
                if (defect["preventive_action"] != null)
                  Text(
                    "Preventive Action: ${defect["preventive_action"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Detected by: ${defect["detected_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Date: ${defect["detection_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.assignment_ind, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Assigned to: ${defect["assigned_to"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Target: ${defect["target_resolution"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
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
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Cost Impact: \$${((defect["cost_impact"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Schedule: ${defect["schedule_impact_hours"]}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Quality Impact: ${defect["quality_impact"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getImpactColor(defect["quality_impact"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Safety Risk: ${defect["safety_risk"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getImpactColor(defect["safety_risk"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (defect["warranty_impact"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "WARRANTY IMPACT",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                "Contractor: ${defect["contractor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (defect["verified_by"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Verified by: ${defect["verified_by"]} on ${defect["verification_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (defect["closure_notes"] != null)
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
                      "Closure: ${defect["closure_notes"]}",
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
              Expanded(
                child: Text(
                  "Trade: ${defect["trade"]} | Client Impact: ${defect["client_impact"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewDefectDetails(defect["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _updateDefect(defect["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showDefectOptions(defect),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredDefects() {
    List<Map<String, dynamic>> filtered = defects;

    if (selectedSeverity != "all") {
      filtered = filtered.where((defect) => defect["severity"] == selectedSeverity).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((defect) => defect["status"] == selectedStatus).toList();
    }

    if (selectedCategory != "all") {
      filtered = filtered.where((defect) => defect["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((defect) =>
          defect["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          defect["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          defect["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'closed':
        return successColor;
      case 'verified':
        return infoColor;
      case 'resolved':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'open':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'major':
        return warningColor;
      case 'minor':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      case 'none':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _reportNewDefect() {
    ss("Report new defect");
  }

  void _showDefectAnalytics() {
    ss("Defect tracking analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced defect filters");
  }

  void _showSortOptions() {
    ss("Defect sort options");
  }

  void _viewDefectDetails(String defectId) {
    ss("Viewing defect details $defectId");
  }

  void _updateDefect(String defectId) {
    ss("Updating defect $defectId");
  }

  void _showDefectOptions(Map<String, dynamic> defect) {
    ss("Defect options for ${defect["id"]}");
  }
}

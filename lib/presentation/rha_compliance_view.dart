import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaComplianceView extends StatefulWidget {
  const RhaComplianceView({super.key});

  @override
  State<RhaComplianceView> createState() => _RhaComplianceViewState();
}

class _RhaComplianceViewState extends State<RhaComplianceView> {
  int currentTab = 0;
  String selectedRegulation = "All";
  String selectedDepartment = "All";
  String selectedRisk = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showCriticalOnly = false;

  List<Map<String, dynamic>> regulations = [
    {"label": "All Regulations", "value": "All"},
    {"label": "GDPR", "value": "GDPR"},
    {"label": "SOX", "value": "SOX"},
    {"label": "HIPAA", "value": "HIPAA"},
    {"label": "PCI DSS", "value": "PCI"},
    {"label": "ISO 27001", "value": "ISO27001"},
    {"label": "Employment Law", "value": "Employment"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All"},
    {"label": "Legal", "value": "Legal"},
    {"label": "HR", "value": "HR"},
    {"label": "IT Security", "value": "Security"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Operations", "value": "Operations"},
  ];

  List<Map<String, dynamic>> riskLevels = [
    {"label": "All Risk Levels", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusTypes = [
    {"label": "All Status", "value": "All"},
    {"label": "Compliant", "value": "Compliant"},
    {"label": "Non-Compliant", "value": "Non-Compliant"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Action Required", "value": "Action Required"},
  ];

  List<Map<String, dynamic>> complianceItems = [
    {
      "id": "COMP001",
      "title": "GDPR Data Protection Assessment",
      "regulation": "GDPR",
      "department": "Legal",
      "riskLevel": "High",
      "status": "Compliant",
      "dueDate": "2025-03-15",
      "lastReview": "2024-12-15",
      "nextReview": "2025-03-15",
      "owner": "Sarah Johnson",
      "description": "Quarterly assessment of data protection measures and privacy policies",
      "completionRate": 95,
      "findings": 2,
      "actionItems": 1,
      "evidence": ["Privacy Policy v2.1", "Data Audit Report", "Training Records"],
    },
    {
      "id": "COMP002",
      "title": "SOX Financial Controls Audit",
      "regulation": "SOX",
      "department": "Finance",
      "riskLevel": "Critical",
      "status": "Under Review",
      "dueDate": "2025-02-28",
      "lastReview": "2024-11-30",
      "nextReview": "2025-02-28",
      "owner": "Michael Brown",
      "description": "Annual review of financial reporting controls and procedures",
      "completionRate": 78,
      "findings": 5,
      "actionItems": 3,
      "evidence": ["Internal Controls Manual", "Audit Logs", "Segregation Matrix"],
    },
    {
      "id": "COMP003",
      "title": "Employee Background Verification",
      "regulation": "Employment",
      "department": "HR",
      "riskLevel": "Medium",
      "status": "Action Required",
      "dueDate": "2025-01-31",
      "lastReview": "2024-12-01",
      "nextReview": "2025-01-31",
      "owner": "Lisa Rodriguez",
      "description": "Verification of employee background checks and employment eligibility",
      "completionRate": 85,
      "findings": 8,
      "actionItems": 5,
      "evidence": ["Background Check Reports", "I-9 Forms", "Reference Letters"],
    },
    {
      "id": "COMP004",
      "title": "ISO 27001 Security Management",
      "regulation": "ISO27001",
      "department": "Security",
      "riskLevel": "High",
      "status": "Compliant",
      "dueDate": "2025-06-30",
      "lastReview": "2024-12-10",
      "nextReview": "2025-06-30",
      "owner": "David Chen",
      "description": "Information security management system review and certification",
      "completionRate": 92,
      "findings": 3,
      "actionItems": 2,
      "evidence": ["Security Policies", "Risk Assessments", "Incident Reports"],
    },
  ];

  List<Map<String, dynamic>> auditTrail = [
    {
      "id": "AT001",
      "timestamp": "2024-12-30 14:30:00",
      "user": "Sarah Johnson",
      "action": "Updated Compliance Status",
      "item": "GDPR Data Protection Assessment",
      "details": "Status changed from Under Review to Compliant",
      "impact": "Low",
      "category": "Status Update",
    },
    {
      "id": "AT002",
      "timestamp": "2024-12-29 16:45:00",
      "user": "Michael Brown",
      "action": "Added Action Item",
      "item": "SOX Financial Controls Audit",
      "details": "Added remediation plan for control weakness",
      "impact": "Medium",
      "category": "Action Item",
    },
    {
      "id": "AT003",
      "timestamp": "2024-12-28 11:20:00",
      "user": "Lisa Rodriguez",
      "action": "Submitted Evidence",
      "item": "Employee Background Verification",
      "details": "Uploaded updated background check reports",
      "impact": "Medium",
      "category": "Evidence",
    },
    {
      "id": "AT004",
      "timestamp": "2024-12-27 09:15:00",
      "user": "David Chen",
      "action": "Scheduled Review",
      "item": "ISO 27001 Security Management",
      "details": "Scheduled quarterly security review for Q1 2025",
      "impact": "Low",
      "category": "Scheduling",
    },
  ];

  List<Map<String, dynamic>> riskAssessments = [
    {
      "id": "RA001",
      "title": "Data Breach Risk Assessment",
      "category": "Information Security",
      "riskLevel": "Critical",
      "probability": "Medium",
      "impact": "High",
      "riskScore": 8.5,
      "owner": "David Chen",
      "lastAssessed": "2024-12-20",
      "nextAssessment": "2025-03-20",
      "mitigationStatus": "In Progress",
      "mitigationPlans": 3,
      "residualRisk": "Medium",
    },
    {
      "id": "RA002",
      "title": "Financial Fraud Risk",
      "category": "Financial Controls",
      "riskLevel": "High",
      "probability": "Low",
      "impact": "High",
      "riskScore": 7.2,
      "owner": "Michael Brown",
      "lastAssessed": "2024-12-15",
      "nextAssessment": "2025-06-15",
      "mitigationStatus": "Implemented",
      "mitigationPlans": 5,
      "residualRisk": "Low",
    },
    {
      "id": "RA003",
      "title": "Employment Law Violations",
      "category": "HR Compliance",
      "riskLevel": "Medium",
      "probability": "Medium",
      "impact": "Medium",
      "riskScore": 5.8,
      "owner": "Lisa Rodriguez",
      "lastAssessed": "2024-12-10",
      "nextAssessment": "2025-12-10",
      "mitigationStatus": "Planned",
      "mitigationPlans": 2,
      "residualRisk": "Medium",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Requirements", icon: Icon(Icons.checklist)),
        Tab(text: "Risk Assessment", icon: Icon(Icons.warning)),
        Tab(text: "Audit Trail", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildRequirementsTab(),
        _buildRiskAssessmentTab(),
        _buildAuditTrailTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceMetrics(),
          _buildComplianceStatus(),
          _buildQuickActions(),
          _buildUpcomingDeadlines(),
        ],
      ),
    );
  }

  Widget _buildComplianceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Compliance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard(
              "Compliance Score",
              "87.5%",
              "Overall compliance rate",
              Icons.check_circle,
              successColor,
              "+2.3% from last month",
            ),
            _buildMetricCard(
              "Active Requirements",
              "42",
              "Compliance items",
              Icons.checklist,
              primaryColor,
              "8 due this month",
            ),
            _buildMetricCard(
              "Critical Risks",
              "3",
              "High priority items",
              Icons.warning,
              dangerColor,
              "2 require immediate action",
            ),
            _buildMetricCard(
              "Audit Findings",
              "18",
              "Open findings",
              Icons.bug_report,
              warningColor,
              "5 resolved this week",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
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

  Widget _buildComplianceStatus() {
    List<Map<String, dynamic>> statusData = [
      {"status": "Compliant", "count": 25, "percentage": 59.5, "color": successColor},
      {"status": "Under Review", "count": 8, "percentage": 19.0, "color": infoColor},
      {"status": "Action Required", "count": 6, "percentage": 14.3, "color": warningColor},
      {"status": "Non-Compliant", "count": 3, "percentage": 7.1, "color": dangerColor},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Compliance Status Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: statusData.map((status) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: status["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${status["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${status["count"]} items",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (status["percentage"] as double) / 100,
                                  backgroundColor: disabledOutlineBorderColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    status["color"] as Color,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(status["percentage"] as double).toStringAsFixed(1)}%",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildActionCard(
              "New Requirement",
              "Add compliance requirement",
              Icons.add_task,
              primaryColor,
              () {
                //navigateTo('CreateComplianceItemView')
              },
            ),
            _buildActionCard(
              "Risk Assessment",
              "Conduct risk evaluation",
              Icons.assessment,
              warningColor,
              () {
                //navigateTo('CreateRiskAssessmentView')
              },
            ),
            _buildActionCard(
              "Generate Report",
              "Create compliance report",
              Icons.description,
              infoColor,
              () {
                //navigateTo('ComplianceReportsView')
              },
            ),
            _buildActionCard(
              "Training",
              "Schedule compliance training",
              Icons.school,
              successColor,
              () {
                //navigateTo('ComplianceTrainingView')
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingDeadlines() {
    List<Map<String, dynamic>> deadlines = complianceItems
        .where((item) => item["status"] != "Compliant")
        .toList()
      ..sort((a, b) => DateTime.parse(a["dueDate"]).compareTo(DateTime.parse(b["dueDate"])));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Upcoming Deadlines",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //navigateTo('ComplianceCalendarView')
              },
              child: Text(
                "View Calendar",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: deadlines.take(4).map((item) {
              DateTime dueDate = DateTime.parse(item["dueDate"]);
              int daysUntil = dueDate.difference(DateTime.now()).inDays;
              
              Color urgencyColor = daysUntil <= 7
                  ? dangerColor
                  : daysUntil <= 30
                      ? warningColor
                      : successColor;

              Color statusColor = item["status"] == "Action Required"
                  ? dangerColor
                  : item["status"] == "Under Review"
                      ? infoColor
                      : warningColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: urgencyColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${item["regulation"]} • ${item["department"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Due: ${item["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: urgencyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (daysUntil >= 0) ...[
                                Text(
                                  " • $daysUntil days remaining",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: urgencyColor,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  " • ${-daysUntil} days overdue",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.arrow_forward,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('ComplianceItemDetailsView')
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRequirementsFilters(),
          _buildRequirementsList(),
        ],
      ),
    );
  }

  Widget _buildRequirementsFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                child: QTextField(
                  label: "Search Requirements",
                  value: searchQuery,
                  hint: "Search by title, regulation, or owner",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreateComplianceItemView')
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Regulation",
                  items: regulations,
                  value: selectedRegulation,
                  onChanged: (value, label) {
                    selectedRegulation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departments,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Risk Level",
                  items: riskLevels,
                  value: selectedRisk,
                  onChanged: (value, label) {
                    selectedRisk = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusTypes,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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
                      "label": "Show Critical Only",
                      "value": true,
                      "checked": showCriticalOnly,
                    }
                  ],
                  value: [
                    if (showCriticalOnly)
                      {"label": "Show Critical Only", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showCriticalOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              Spacer(),
              Text(
                "${complianceItems.length} requirements found",
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
  }

  Widget _buildRequirementsList() {
    List<Map<String, dynamic>> filteredItems = complianceItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["regulation"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["owner"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesRegulation = selectedRegulation == "All" ||
          item["regulation"] == selectedRegulation;

      bool matchesDepartment = selectedDepartment == "All" ||
          item["department"] == selectedDepartment;

      bool matchesRisk = selectedRisk == "All" ||
          item["riskLevel"] == selectedRisk;

      bool matchesStatus = selectedStatus == "All" ||
          item["status"] == selectedStatus;

      bool matchesCritical = !showCriticalOnly ||
          item["riskLevel"] == "Critical";

      return matchesSearch && matchesRegulation && matchesDepartment && 
             matchesRisk && matchesStatus && matchesCritical;
    }).toList();

    return Column(
      children: filteredItems.map((item) {
        Color statusColor = item["status"] == "Compliant"
            ? successColor
            : item["status"] == "Under Review"
                ? infoColor
                : item["status"] == "Action Required"
                    ? warningColor
                    : dangerColor;

        Color riskColor = item["riskLevel"] == "Critical"
            ? dangerColor
            : item["riskLevel"] == "High"
                ? warningColor
                : item["riskLevel"] == "Medium"
                    ? infoColor
                    : successColor;

        DateTime dueDate = DateTime.parse(item["dueDate"]);
        int daysUntil = dueDate.difference(DateTime.now()).inDays;

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${item["title"]}",
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
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: riskColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["riskLevel"]} Risk",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: riskColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${item["regulation"]} • ${item["department"]} • Owner: ${item["owner"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ComplianceItemDetailsView')
                    },
                  ),
                ],
              ),
              Text(
                "${item["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Completion Progress",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${item["completionRate"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (item["completionRate"] as int) / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (item["completionRate"] as int) >= 90 ? successColor : 
                        (item["completionRate"] as int) >= 70 ? warningColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildComplianceInfoItem(
                    "Due Date",
                    "${item["dueDate"]}",
                    Icons.calendar_today,
                    daysUntil <= 30 ? dangerColor : primaryColor,
                  ),
                  _buildComplianceInfoItem(
                    "Last Review",
                    "${item["lastReview"]}",
                    Icons.history,
                    disabledBoldColor,
                  ),
                  _buildComplianceInfoItem(
                    "Findings",
                    "${item["findings"]}",
                    Icons.bug_report,
                    (item["findings"] as int) > 0 ? warningColor : successColor,
                  ),
                  _buildComplianceInfoItem(
                    "Action Items",
                    "${item["actionItems"]}",
                    Icons.assignment,
                    (item["actionItems"] as int) > 0 ? warningColor : successColor,
                  ),
                ],
              ),
              if ((item["evidence"] as List).isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Evidence:",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        (item["evidence"] as List).join(", "),
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComplianceInfoItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskAssessmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRiskMetrics(),
          _buildRiskAssessmentsList(),
        ],
      ),
    );
  }

  Widget _buildRiskMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Risk Assessment Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard(
              "Total Risks",
              "${riskAssessments.length}",
              "Identified risks",
              Icons.warning,
              primaryColor,
              "2 new this month",
            ),
            _buildMetricCard(
              "Critical Risks",
              "1",
              "Requiring immediate action",
              Icons.error,
              dangerColor,
              "Data breach risk",
            ),
            _buildMetricCard(
              "Average Risk Score",
              "7.2",
              "Out of 10",
              Icons.analytics,
              warningColor,
              "0.3 improvement from last quarter",
            ),
            _buildMetricCard(
              "Mitigated Risks",
              "67%",
              "With active mitigation",
              Icons.shield,
              successColor,
              "8 of 12 risks addressed",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRiskAssessmentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Risk Assessments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                //navigateTo('CreateRiskAssessmentView')
              },
            ),
          ],
        ),
        Column(
          children: riskAssessments.map((risk) {
            Color riskColor = risk["riskLevel"] == "Critical"
                ? dangerColor
                : risk["riskLevel"] == "High"
                    ? warningColor
                    : infoColor;

            Color mitigationColor = risk["mitigationStatus"] == "Implemented"
                ? successColor
                : risk["mitigationStatus"] == "In Progress"
                    ? warningColor
                    : infoColor;

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${risk["title"]}",
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
                                    color: riskColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${risk["riskLevel"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: riskColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${risk["category"]} • Owner: ${risk["owner"]}",
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
                            "${(risk["riskScore"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            "Risk Score",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: [
                      _buildRiskInfoItem(
                        "Probability",
                        "${risk["probability"]}",
                        Icons.trending_up,
                        infoColor,
                      ),
                      _buildRiskInfoItem(
                        "Impact",
                        "${risk["impact"]}",
                        Icons.error_outline,
                        warningColor,
                      ),
                      _buildRiskInfoItem(
                        "Mitigation Plans",
                        "${risk["mitigationPlans"]}",
                        Icons.shield,
                        mitigationColor,
                      ),
                      _buildRiskInfoItem(
                        "Residual Risk",
                        "${risk["residualRisk"]}",
                        Icons.assessment,
                        risk["residualRisk"] == "Low" ? successColor : 
                        risk["residualRisk"] == "Medium" ? warningColor : dangerColor,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: mitigationColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.security,
                          size: 16,
                          color: mitigationColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Mitigation Status: ${risk["mitigationStatus"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: mitigationColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Next Assessment: ${risk["nextAssessment"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('RiskAssessmentDetailsView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('EditRiskAssessmentView')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRiskInfoItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditTrailTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAuditFilters(),
          _buildAuditTrailList(),
        ],
      ),
    );
  }

  Widget _buildAuditFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                child: QTextField(
                  label: "Search Audit Log",
                  value: searchQuery,
                  hint: "Search by user, action, or item",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ExportAuditLogView')
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${auditTrail.length} audit entries",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Last 30 days",
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
  }

  Widget _buildAuditTrailList() {
    return Column(
      children: auditTrail.map((entry) {
        Color impactColor = entry["impact"] == "High"
            ? dangerColor
            : entry["impact"] == "Medium"
                ? warningColor
                : infoColor;

        Color categoryColor = entry["category"] == "Status Update"
            ? successColor
            : entry["category"] == "Action Item"
                ? warningColor
                : entry["category"] == "Evidence"
                    ? infoColor
                    : primaryColor;

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${entry["action"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: impactColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${entry["impact"]} Impact",
                            style: TextStyle(
                              fontSize: 10,
                              color: impactColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Item: ${entry["item"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${entry["details"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "By: ${entry["user"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          " • ${entry["timestamp"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${entry["category"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: categoryColor,
                              fontWeight: FontWeight.w600,
                            ),
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
      }).toList(),
    );
  }
}

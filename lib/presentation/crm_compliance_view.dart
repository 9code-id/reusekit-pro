import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmComplianceView extends StatefulWidget {
  const CrmComplianceView({Key? key}) : super(key: key);

  @override
  State<CrmComplianceView> createState() => _CrmComplianceViewState();
}

class _CrmComplianceViewState extends State<CrmComplianceView> {
  int currentTab = 0;
  bool loading = false;
  
  // Compliance Standards
  List<Map<String, dynamic>> complianceStandards = [
    {
      "id": "gdpr",
      "name": "GDPR",
      "description": "General Data Protection Regulation",
      "status": "compliant",
      "lastAudit": "2024-12-15",
      "nextAudit": "2025-06-15",
      "requirements": 47,
      "completed": 45,
      "critical": 2,
      "color": successColor,
    },
    {
      "id": "sox",
      "name": "SOX",
      "description": "Sarbanes-Oxley Act",
      "status": "partial",
      "lastAudit": "2024-11-20",
      "nextAudit": "2025-05-20",
      "requirements": 32,
      "completed": 28,
      "critical": 1,
      "color": warningColor,
    },
    {
      "id": "iso27001",
      "name": "ISO 27001",
      "description": "Information Security Management",
      "status": "non_compliant",
      "lastAudit": "2024-10-10",
      "nextAudit": "2025-04-10",
      "requirements": 114,
      "completed": 89,
      "critical": 8,
      "color": dangerColor,
    },
    {
      "id": "hipaa",
      "name": "HIPAA",
      "description": "Health Insurance Portability",
      "status": "compliant",
      "lastAudit": "2024-12-01",
      "nextAudit": "2025-06-01",
      "requirements": 28,
      "completed": 28,
      "critical": 0,
      "color": successColor,
    },
  ];

  // Audit History
  List<Map<String, dynamic>> auditHistory = [
    {
      "id": "audit_001",
      "standard": "GDPR",
      "date": "2024-12-15",
      "auditor": "Sarah Johnson",
      "type": "Internal",
      "status": "completed",
      "findings": 3,
      "critical": 1,
      "score": 92,
    },
    {
      "id": "audit_002",
      "standard": "SOX",
      "date": "2024-11-20",
      "auditor": "Michael Chen",
      "type": "External",
      "status": "completed",
      "findings": 7,
      "critical": 2,
      "score": 85,
    },
    {
      "id": "audit_003",
      "standard": "ISO 27001",
      "date": "2024-10-10",
      "auditor": "Lisa Anderson",
      "type": "External",
      "status": "completed",
      "findings": 12,
      "critical": 5,
      "score": 78,
    },
    {
      "id": "audit_004",
      "standard": "HIPAA",
      "date": "2024-12-01",
      "auditor": "David Wilson",
      "type": "Internal",
      "status": "completed",
      "findings": 1,
      "critical": 0,
      "score": 98,
    },
  ];

  // Issues & Remediation
  List<Map<String, dynamic>> complianceIssues = [
    {
      "id": "issue_001",
      "title": "Data Retention Policy Update Required",
      "standard": "GDPR",
      "severity": "high",
      "status": "open",
      "assignee": "Legal Team",
      "dueDate": "2025-01-15",
      "description": "Update data retention policies to align with latest GDPR guidelines",
      "progress": 60,
    },
    {
      "id": "issue_002",
      "title": "Access Control Documentation",
      "standard": "SOX",
      "severity": "medium",
      "status": "in_progress",
      "assignee": "IT Security",
      "dueDate": "2025-02-01",
      "description": "Document access control procedures for financial systems",
      "progress": 75,
    },
    {
      "id": "issue_003",
      "title": "Encryption Key Management",
      "standard": "ISO 27001",
      "severity": "critical",
      "status": "open",
      "assignee": "Security Team",
      "dueDate": "2025-01-30",
      "description": "Implement proper encryption key management system",
      "progress": 25,
    },
    {
      "id": "issue_004",
      "title": "Employee Training Program",
      "standard": "HIPAA",
      "severity": "medium",
      "status": "resolved",
      "assignee": "HR Department",
      "dueDate": "2024-12-31",
      "description": "Complete mandatory HIPAA training for all staff",
      "progress": 100,
    },
  ];

  String getStatusLabel(String status) {
    switch (status) {
      case 'compliant':
        return 'Compliant';
      case 'partial':
        return 'Partial Compliance';
      case 'non_compliant':
        return 'Non-Compliant';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'compliant':
        return successColor;
      case 'partial':
        return warningColor;
      case 'non_compliant':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String getSeverityLabel(String severity) {
    switch (severity) {
      case 'critical':
        return 'Critical';
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Unknown';
    }
  }

  Color getSeverityColor(String severity) {
    switch (severity) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compliance Summary
          Container(
            width: double.infinity,
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
                  "Compliance Overview",
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
                      child: _buildMetricCard(
                        "Compliant",
                        "${complianceStandards.where((s) => s["status"] == "compliant").length}",
                        successColor,
                        Icons.check_circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard(
                        "Partial",
                        "${complianceStandards.where((s) => s["status"] == "partial").length}",
                        warningColor,
                        Icons.warning,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard(
                        "Non-Compliant",
                        "${complianceStandards.where((s) => s["status"] == "non_compliant").length}",
                        dangerColor,
                        Icons.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Compliance Standards
          Container(
            width: double.infinity,
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
                  "Compliance Standards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...complianceStandards.map((standard) => _buildStandardCard(standard)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStandardCard(Map<String, dynamic> standard) {
    double progress = (standard["completed"] as int) / (standard["requirements"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: getStatusColor(standard["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  getStatusLabel(standard["status"]),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: getStatusColor(standard["status"]),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${standard["name"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${standard["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Requirements Progress",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: getStatusColor(standard["status"]),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${standard["completed"]}/${standard["requirements"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Critical Issues",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${standard["critical"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: (standard["critical"] as int) > 0 ? dangerColor : successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Next Audit",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(standard["nextAudit"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuditTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Audit Statistics
          Row(
            children: [
              Expanded(
                child: _buildAuditMetric(
                  "Total Audits",
                  "${auditHistory.length}",
                  primaryColor,
                  Icons.assessment,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAuditMetric(
                  "Avg Score",
                  "${(auditHistory.map((a) => a["score"] as int).reduce((a, b) => a + b) / auditHistory.length).toInt()}%",
                  successColor,
                  Icons.stars,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Audit History
          Container(
            width: double.infinity,
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
                  "Audit History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...auditHistory.map((audit) => _buildAuditCard(audit)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditMetric(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAuditCard(Map<String, dynamic> audit) {
    Color scoreColor = (audit["score"] as int) >= 90 ? successColor : 
                      (audit["score"] as int) >= 80 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: audit["type"] == "External" ? infoColor.withAlpha(20) : primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${audit["type"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: audit["type"] == "External" ? infoColor : primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: scoreColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${audit["score"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${audit["standard"]} Audit",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Auditor: ${audit["auditor"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(audit["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Findings",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${audit["findings"]} (${audit["critical"]} critical)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: (audit["critical"] as int) > 0 ? dangerColor : successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Issue Statistics
          Row(
            children: [
              Expanded(
                child: _buildIssueMetric(
                  "Open Issues",
                  "${complianceIssues.where((i) => i["status"] == "open").length}",
                  dangerColor,
                  Icons.error_outline,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildIssueMetric(
                  "In Progress",
                  "${complianceIssues.where((i) => i["status"] == "in_progress").length}",
                  warningColor,
                  Icons.pending,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Issues List
          Container(
            width: double.infinity,
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
                  "Compliance Issues",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...complianceIssues.map((issue) => _buildIssueCard(issue)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueMetric(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    Color severityColor = getSeverityColor(issue["severity"]);
    Color statusColor = issue["status"] == "resolved" ? successColor :
                       issue["status"] == "in_progress" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  getSeverityLabel(issue["severity"]),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: severityColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${issue["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${issue["standard"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${issue["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${issue["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Progress Bar
          if (issue["status"] != "resolved") ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${issue["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (issue["progress"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assignee",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${issue["assignee"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Due Date",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(issue["dueDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DateTime.parse(issue["dueDate"]).isBefore(DateTime.now()) 
                          ? dangerColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "CRM Compliance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Audits", icon: Icon(Icons.assessment)),
        Tab(text: "Issues", icon: Icon(Icons.error_outline)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAuditTab(),
        _buildIssuesTab(),
      ],
      onInit: (tabController) {
        // Optional: Handle tab controller initialization
      },
    );
  }
}

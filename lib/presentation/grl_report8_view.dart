import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport8View extends StatefulWidget {
  @override
  State<GrlReport8View> createState() => _GrlReport8ViewState();
}

class _GrlReport8ViewState extends State<GrlReport8View> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedCategory = "all";

  List<Map<String, dynamic>> qualityMetrics = [
    {
      "id": 1,
      "metric": "Overall Quality Score",
      "value": 94.8,
      "unit": "%",
      "target": 95.0,
      "trend": "up",
      "change": 1.2,
      "color": successColor,
      "icon": Icons.grade,
    },
    {
      "id": 2,
      "metric": "Defect Rate",
      "value": 2.1,
      "unit": "%",
      "target": 2.0,
      "trend": "down",
      "change": -0.3,
      "color": warningColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 3,
      "metric": "Customer Satisfaction",
      "value": 4.7,
      "unit": "/5",
      "target": 4.5,
      "trend": "up",
      "change": 0.2,
      "color": successColor,
      "icon": Icons.sentiment_very_satisfied,
    },
    {
      "id": 4,
      "metric": "First Pass Yield",
      "value": 97.3,
      "unit": "%",
      "target": 98.0,
      "trend": "stable",
      "change": 0.1,
      "color": infoColor,
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> inspectionData = [
    {
      "id": 1,
      "category": "Incoming Materials",
      "inspected": 2450,
      "passed": 2389,
      "failed": 61,
      "passRate": 97.5,
      "criticalIssues": 3,
      "status": "good",
    },
    {
      "id": 2,
      "category": "In-Process",
      "inspected": 15680,
      "passed": 15215,
      "failed": 465,
      "passRate": 97.0,
      "criticalIssues": 12,
      "status": "good",
    },
    {
      "id": 3,
      "category": "Final Products",
      "inspected": 8920,
      "passed": 8756,
      "failed": 164,
      "passRate": 98.2,
      "criticalIssues": 2,
      "status": "excellent",
    },
    {
      "id": 4,
      "category": "Customer Returns",
      "inspected": 125,
      "passed": 98,
      "failed": 27,
      "passRate": 78.4,
      "criticalIssues": 8,
      "status": "warning",
    },
  ];

  List<Map<String, dynamic>> issueData = [
    {
      "id": 1,
      "issue": "Dimensional Variance",
      "occurrences": 45,
      "severity": "medium",
      "resolved": 38,
      "pending": 7,
      "avgResolutionTime": 2.5,
      "cost": 8500,
    },
    {
      "id": 2,
      "issue": "Surface Defects",
      "occurrences": 32,
      "severity": "low",
      "resolved": 30,
      "pending": 2,
      "avgResolutionTime": 1.8,
      "cost": 4200,
    },
    {
      "id": 3,
      "issue": "Material Contamination",
      "occurrences": 18,
      "severity": "high",
      "resolved": 15,
      "pending": 3,
      "avgResolutionTime": 4.2,
      "cost": 12000,
    },
    {
      "id": 4,
      "issue": "Assembly Errors",
      "occurrences": 28,
      "severity": "medium",
      "resolved": 25,
      "pending": 3,
      "avgResolutionTime": 3.1,
      "cost": 6800,
    },
  ];

  List<Map<String, dynamic>> auditData = [
    {
      "id": 1,
      "audit": "ISO 9001 Compliance",
      "score": 92.5,
      "lastAudit": "2024-01-15",
      "nextAudit": "2024-07-15",
      "findings": 3,
      "status": "compliant",
      "certificationValid": true,
    },
    {
      "id": 2,
      "audit": "Internal Quality Review",
      "score": 88.7,
      "lastAudit": "2024-02-20",
      "nextAudit": "2024-05-20",
      "findings": 5,
      "status": "good",
      "certificationValid": true,
    },
    {
      "id": 3,
      "audit": "Customer Quality Audit",
      "score": 95.2,
      "lastAudit": "2024-01-30",
      "nextAudit": "2024-07-30",
      "findings": 2,
      "status": "excellent",
      "certificationValid": true,
    },
    {
      "id": 4,
      "audit": "Supplier Assessment",
      "score": 85.3,
      "lastAudit": "2024-02-10",
      "nextAudit": "2024-08-10",
      "findings": 7,
      "status": "warning",
      "certificationValid": true,
    },
  ];

  Widget _buildQualityMetricCard(Map<String, dynamic> metric) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${(metric["value"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (metric["trend"] == "up" ? successColor : 
                               metric["trend"] == "down" ? warningColor : infoColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up : 
                            metric["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                            size: 14,
                            color: metric["trend"] == "up" ? successColor : 
                                  metric["trend"] == "down" ? warningColor : infoColor,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: metric["trend"] == "up" ? successColor : 
                                    metric["trend"] == "down" ? warningColor : infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Target: ${(metric["target"] as num).toStringAsFixed(1)}${metric["unit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (metric["value"] as num) / (metric["target"] as num),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    Color statusColor = inspection["status"] == "excellent" 
        ? successColor 
        : inspection["status"] == "warning" 
            ? warningColor 
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${inspection["category"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
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
                  "${inspection["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
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
                      "Inspected",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(inspection["inspected"] as int)}",
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
                      "Pass Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(inspection["passRate"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Failed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(inspection["failed"] as int)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
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
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(inspection["criticalIssues"] as int)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (inspection["passRate"] as num) / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    Color severityColor = issue["severity"] == "high" 
        ? dangerColor 
        : issue["severity"] == "medium" 
            ? warningColor 
            : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Text(
                  "${issue["issue"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Occurrences",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(issue["occurrences"] as int)}",
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
                      "Resolved",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(issue["resolved"] as int)}",
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
                      "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(issue["pending"] as int)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
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
                      "Avg Resolution Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(issue["avgResolutionTime"] as num).toStringAsFixed(1)} days",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                      "Cost Impact",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((issue["cost"] as int).toDouble()).currency}",
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
        ],
      ),
    );
  }

  Widget _buildAuditCard(Map<String, dynamic> audit) {
    Color statusColor = audit["status"] == "excellent" 
        ? successColor 
        : audit["status"] == "warning" 
            ? warningColor 
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Text(
                  "${audit["audit"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
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
                  "${audit["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
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
                      "Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(audit["score"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
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
                      "Findings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(audit["findings"] as int)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
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
                      "Last Audit",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${audit["lastAudit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                      "Next Audit",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${audit["nextAudit"]}",
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
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.verified,
                color: audit["certificationValid"] ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                audit["certificationValid"] ? "Certification Valid" : "Certification Expired",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: audit["certificationValid"] ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (audit["score"] as num) / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quality Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: qualityMetrics.map((metric) {
              return _buildQualityMetricCard(metric);
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Inspection Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: inspectionData.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              return _buildInspectionCard(inspectionData[index]);
            },
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
          Text(
            "Quality Issues",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: issueData.map((issue) {
              return _buildIssueCard(issue);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quality Audits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: auditData.map((audit) {
              return _buildAuditCard(audit);
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Quality Control Report",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Issues", icon: Icon(Icons.bug_report)),
        Tab(text: "Audits", icon: Icon(Icons.verified)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildIssuesTab(),
        _buildAuditsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}

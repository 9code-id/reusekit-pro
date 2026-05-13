import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport9View extends StatefulWidget {
  @override
  State<GrlReport9View> createState() => _GrlReport9ViewState();
}

class _GrlReport9ViewState extends State<GrlReport9View> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedCategory = "all";

  List<Map<String, dynamic>> complianceMetrics = [
    {
      "id": 1,
      "metric": "Overall Compliance Score",
      "value": 94.2,
      "unit": "%",
      "target": 95.0,
      "trend": "up",
      "change": 1.8,
      "color": successColor,
      "icon": Icons.security,
    },
    {
      "id": 2,
      "metric": "Policy Adherence",
      "value": 91.7,
      "unit": "%",
      "target": 93.0,
      "trend": "up",
      "change": 2.3,
      "color": infoColor,
      "icon": Icons.policy,
    },
    {
      "id": 3,
      "metric": "Training Compliance",
      "value": 87.5,
      "unit": "%",
      "target": 90.0,
      "trend": "down",
      "change": -1.2,
      "color": warningColor,
      "icon": Icons.school,
    },
    {
      "id": 4,
      "metric": "Audit Pass Rate",
      "value": 96.8,
      "unit": "%",
      "target": 95.0,
      "trend": "up",
      "change": 1.5,
      "color": successColor,
      "icon": Icons.fact_check,
    },
  ];

  List<Map<String, dynamic>> regulatoryData = [
    {
      "id": 1,
      "regulation": "GDPR Compliance",
      "status": "compliant",
      "lastAudit": "2024-01-15",
      "nextReview": "2024-07-15",
      "violations": 0,
      "fines": 0,
      "riskLevel": "low",
    },
    {
      "id": 2,
      "regulation": "SOX Compliance",
      "status": "compliant",
      "lastAudit": "2024-02-01",
      "nextReview": "2024-08-01",
      "violations": 1,
      "fines": 0,
      "riskLevel": "medium",
    },
    {
      "id": 3,
      "regulation": "HIPAA Compliance",
      "status": "review",
      "lastAudit": "2024-01-30",
      "nextReview": "2024-07-30",
      "violations": 2,
      "fines": 5000,
      "riskLevel": "high",
    },
    {
      "id": 4,
      "regulation": "ISO 27001",
      "status": "compliant",
      "lastAudit": "2024-02-10",
      "nextReview": "2024-08-10",
      "violations": 0,
      "fines": 0,
      "riskLevel": "low",
    },
  ];

  List<Map<String, dynamic>> riskData = [
    {
      "id": 1,
      "risk": "Data Breach Risk",
      "level": "medium",
      "probability": 35,
      "impact": 85,
      "mitigation": "Enhanced encryption protocols",
      "owner": "IT Security Team",
      "dueDate": "2024-06-30",
      "status": "in_progress",
    },
    {
      "id": 2,
      "risk": "Regulatory Change Impact",
      "level": "high",
      "probability": 70,
      "impact": 60,
      "mitigation": "Policy update procedures",
      "owner": "Compliance Team",
      "dueDate": "2024-05-15",
      "status": "planned",
    },
    {
      "id": 3,
      "risk": "Vendor Non-Compliance",
      "level": "low",
      "probability": 25,
      "impact": 40,
      "mitigation": "Regular vendor assessments",
      "owner": "Procurement Team",
      "dueDate": "2024-07-31",
      "status": "completed",
    },
    {
      "id": 4,
      "risk": "Training Gap Risk",
      "level": "medium",
      "probability": 45,
      "impact": 50,
      "mitigation": "Mandatory training programs",
      "owner": "HR Department",
      "dueDate": "2024-06-15",
      "status": "in_progress",
    },
  ];

  List<Map<String, dynamic>> incidentData = [
    {
      "id": 1,
      "incident": "Privacy Policy Violation",
      "severity": "medium",
      "reportedDate": "2024-02-15",
      "resolvedDate": "2024-02-20",
      "status": "resolved",
      "cost": 2500,
      "department": "Marketing",
      "lessons": "Updated privacy training required",
    },
    {
      "id": 2,
      "incident": "Document Retention Issue",
      "severity": "low",
      "reportedDate": "2024-02-10",
      "resolvedDate": "2024-02-12",
      "status": "resolved",
      "cost": 800,
      "department": "Legal",
      "lessons": "Automated retention system needed",
    },
    {
      "id": 3,
      "incident": "Access Control Breach",
      "severity": "high",
      "reportedDate": "2024-02-18",
      "resolvedDate": "",
      "status": "investigating",
      "cost": 0,
      "department": "IT",
      "lessons": "Investigation ongoing",
    },
    {
      "id": 4,
      "incident": "Training Non-Compliance",
      "severity": "medium",
      "reportedDate": "2024-02-12",
      "resolvedDate": "2024-02-16",
      "status": "resolved",
      "cost": 1200,
      "department": "Operations",
      "lessons": "Mandatory training tracking needed",
    },
  ];

  Widget _buildComplianceMetricCard(Map<String, dynamic> metric) {
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
                        color: (metric["trend"] == "up" ? successColor : warningColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            size: 14,
                            color: metric["trend"] == "up" ? successColor : warningColor,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: metric["trend"] == "up" ? successColor : warningColor,
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

  Widget _buildRegulatoryCard(Map<String, dynamic> regulation) {
    Color statusColor = regulation["status"] == "compliant" 
        ? successColor 
        : regulation["status"] == "review" 
            ? warningColor 
            : dangerColor;

    Color riskColor = regulation["riskLevel"] == "low" 
        ? successColor 
        : regulation["riskLevel"] == "medium" 
            ? warningColor 
            : dangerColor;

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
                  "${regulation["regulation"]}",
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
                  "${regulation["status"]}".toUpperCase(),
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
                      "Last Audit",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${regulation["lastAudit"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Next Review",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${regulation["nextReview"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                      "Violations",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(regulation["violations"] as int)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: regulation["violations"] == 0 ? successColor : dangerColor,
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
                      "Fines",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      regulation["fines"] == 0 
                          ? "None" 
                          : "\$${((regulation["fines"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: regulation["fines"] == 0 ? successColor : dangerColor,
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
                Icons.warning,
                color: riskColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Risk Level: ${regulation["riskLevel"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: riskColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(Map<String, dynamic> risk) {
    Color levelColor = risk["level"] == "high" 
        ? dangerColor 
        : risk["level"] == "medium" 
            ? warningColor 
            : successColor;

    Color statusColor = risk["status"] == "completed" 
        ? successColor 
        : risk["status"] == "in_progress" 
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
                  "${risk["risk"]}",
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
                  color: levelColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${risk["level"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
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
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(risk["probability"] as int)}%",
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
                      "Impact",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(risk["impact"] as int)}%",
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
          Text(
            "Mitigation:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${risk["mitigation"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
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
                      "Owner",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${risk["owner"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
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
                  "${risk["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentCard(Map<String, dynamic> incident) {
    Color severityColor = incident["severity"] == "high" 
        ? dangerColor 
        : incident["severity"] == "medium" 
            ? warningColor 
            : successColor;

    Color statusColor = incident["status"] == "resolved" 
        ? successColor 
        : incident["status"] == "investigating" 
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
                  "${incident["incident"]}",
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
                  "${incident["severity"]}".toUpperCase(),
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
                      "Reported",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${incident["reportedDate"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Department",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${incident["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                      "Cost Impact",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      incident["cost"] == 0 
                          ? "TBD" 
                          : "\$${((incident["cost"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: incident["cost"] == 0 ? disabledBoldColor : dangerColor,
                      ),
                    ),
                  ],
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
                  "${incident["status"]}".toUpperCase(),
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
          Text(
            "Lessons Learned:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${incident["lessons"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
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
            "Compliance Overview",
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
            children: complianceMetrics.map((metric) {
              return _buildComplianceMetricCard(metric);
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Regulatory Status",
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
            itemCount: regulatoryData.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              return _buildRegulatoryCard(regulatoryData[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRisksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Risk Assessment",
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
            children: riskData.map((risk) {
              return _buildRiskCard(risk);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compliance Incidents",
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
            children: incidentData.map((incident) {
              return _buildIncidentCard(incident);
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Report",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Risks", icon: Icon(Icons.warning)),
        Tab(text: "Incidents", icon: Icon(Icons.report_problem)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRisksTab(),
        _buildIncidentsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}

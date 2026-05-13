import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxComplianceView extends StatefulWidget {
  const AbaTaxComplianceView({super.key});

  @override
  State<AbaTaxComplianceView> createState() => _AbaTaxComplianceViewState();
}

class _AbaTaxComplianceViewState extends State<AbaTaxComplianceView> {
  int currentTab = 0;
  String selectedYear = "2024";
  String selectedJurisdiction = "all";
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> jurisdictionOptions = [
    {"label": "All Jurisdictions", "value": "all"},
    {"label": "Federal", "value": "federal"},
    {"label": "State", "value": "state"},
    {"label": "Local", "value": "local"},
    {"label": "International", "value": "international"},
  ];

  List<Map<String, dynamic>> complianceOverview = [
    {
      "title": "Overall Compliance",
      "score": 95.0,
      "status": "excellent",
      "icon": Icons.verified,
      "color": successColor,
    },
    {
      "title": "Federal Compliance",
      "score": 98.0,
      "status": "excellent",
      "icon": Icons.account_balance,
      "color": successColor,
    },
    {
      "title": "State Compliance",
      "score": 87.0,
      "status": "good",
      "icon": Icons.location_city,
      "color": warningColor,
    },
    {
      "title": "Local Compliance",
      "score": 92.0,
      "status": "good",
      "icon": Icons.home_work,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> complianceChecks = [
    {
      "id": "CC001",
      "title": "Federal Tax Filing Schedule",
      "description": "Quarterly and annual federal tax filing compliance",
      "jurisdiction": "Federal",
      "requirements": [
        {"item": "Form 941 - Q1 2024", "status": "compliant", "dueDate": "2024-04-30"},
        {"item": "Form 940 - Annual 2023", "status": "compliant", "dueDate": "2024-01-31"},
        {"item": "Form 1120 - Corporate Return", "status": "pending", "dueDate": "2024-03-15"},
      ],
      "score": 85.0,
      "lastCheck": "2024-04-01",
      "nextCheck": "2024-07-01",
      "status": "good",
    },
    {
      "id": "CC002",
      "title": "Employee Tax Withholding",
      "description": "Proper withholding and remittance of employee taxes",
      "jurisdiction": "Federal",
      "requirements": [
        {"item": "Federal Income Tax Withholding", "status": "compliant", "dueDate": "Monthly"},
        {"item": "Social Security Withholding", "status": "compliant", "dueDate": "Monthly"},
        {"item": "Medicare Withholding", "status": "compliant", "dueDate": "Monthly"},
      ],
      "score": 100.0,
      "lastCheck": "2024-03-31",
      "nextCheck": "2024-04-30",
      "status": "excellent",
    },
    {
      "id": "CC003",
      "title": "State Tax Obligations",
      "description": "State income tax and other state-specific requirements",
      "jurisdiction": "State",
      "requirements": [
        {"item": "State Income Tax Filing", "status": "action_needed", "dueDate": "2024-04-20"},
        {"item": "Unemployment Insurance", "status": "compliant", "dueDate": "2024-04-30"},
        {"item": "Disability Insurance", "status": "compliant", "dueDate": "2024-04-30"},
      ],
      "score": 67.0,
      "lastCheck": "2024-03-28",
      "nextCheck": "2024-04-15",
      "status": "needs_attention",
    },
    {
      "id": "CC004",
      "title": "Local Tax Requirements",
      "description": "City and county tax obligations",
      "jurisdiction": "Local",
      "requirements": [
        {"item": "City Business Tax", "status": "compliant", "dueDate": "2024-12-31"},
        {"item": "County Property Tax", "status": "compliant", "dueDate": "2024-04-10"},
        {"item": "Local Payroll Tax", "status": "compliant", "dueDate": "Monthly"},
      ],
      "score": 95.0,
      "lastCheck": "2024-04-02",
      "nextCheck": "2024-05-01",
      "status": "excellent",
    },
  ];

  List<Map<String, dynamic>> complianceAlerts = [
    {
      "id": "CA001",
      "type": "urgent",
      "title": "State Tax Filing Overdue",
      "description": "State income tax filing is past due date. Immediate action required.",
      "dueDate": "2024-04-20",
      "daysOverdue": 3,
      "jurisdiction": "State",
      "impact": "High",
      "action": "File immediately to avoid penalties",
    },
    {
      "id": "CA002",
      "type": "warning",
      "title": "Quarterly Estimate Due Soon",
      "description": "Federal quarterly estimated tax payment due in 5 days.",
      "dueDate": "2024-04-15",
      "daysRemaining": 5,
      "jurisdiction": "Federal",
      "impact": "Medium",
      "action": "Prepare and schedule payment",
    },
    {
      "id": "CA003",
      "type": "info",
      "title": "Annual Form Update Available",
      "description": "New version of Form 1120 is available for 2024 tax year.",
      "jurisdiction": "Federal",
      "impact": "Low",
      "action": "Review and update forms as needed",
    },
  ];

  List<Map<String, dynamic>> upcomingDeadlines = [
    {
      "form": "Form 941",
      "description": "Quarterly Federal Tax Return - Q1 2024",
      "dueDate": "2024-04-30",
      "jurisdiction": "Federal",
      "priority": "high",
      "status": "in_progress",
    },
    {
      "form": "State Tax Return",
      "description": "Quarterly State Tax Filing - Q1 2024",
      "dueDate": "2024-05-01",
      "jurisdiction": "State",
      "priority": "high",
      "status": "not_started",
    },
    {
      "form": "Local Business License",
      "description": "Annual business license renewal",
      "dueDate": "2024-06-30",
      "jurisdiction": "Local",
      "priority": "medium",
      "status": "not_started",
    },
    {
      "form": "Workers' Compensation",
      "description": "Annual workers' compensation audit",
      "dueDate": "2024-07-15",
      "jurisdiction": "State",
      "priority": "medium",
      "status": "scheduled",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "needs_attention":
        return warningColor;
      case "critical":
        return dangerColor;
      case "compliant":
        return successColor;
      case "action_needed":
        return warningColor;
      case "non_compliant":
        return dangerColor;
      case "pending":
        return infoColor;
      case "urgent":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "excellent":
        return "Excellent";
      case "good":
        return "Good";
      case "needs_attention":
        return "Needs Attention";
      case "critical":
        return "Critical";
      case "compliant":
        return "Compliant";
      case "action_needed":
        return "Action Needed";
      case "non_compliant":
        return "Non-Compliant";
      case "pending":
        return "Pending";
      case "urgent":
        return "Urgent";
      case "warning":
        return "Warning";
      case "info":
        return "Info";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tax Compliance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Checks", icon: Icon(Icons.fact_check)),
        Tab(text: "Alerts", icon: Icon(Icons.warning)),
        Tab(text: "Deadlines", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildChecksTab(),
        _buildAlertsTab(),
        _buildDeadlinesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Year",
                    items: yearOptions,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Jurisdiction",
                    items: jurisdictionOptions,
                    value: selectedJurisdiction,
                    onChanged: (value, label) {
                      selectedJurisdiction = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Compliance Scores
          Text(
            "Compliance Scores",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: complianceOverview.map((overview) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (overview["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            overview["icon"] as IconData,
                            color: overview["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(overview["status"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(overview["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(overview["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${(overview["score"] as double).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: overview["color"] as Color,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            value: (overview["score"] as double) / 100,
                            backgroundColor: disabledOutlineBorderColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              overview["color"] as Color,
                            ),
                            strokeWidth: 6,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${overview["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Run Compliance Check",
                  icon: Icons.fact_check,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.summarize,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Compliance Checks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: complianceChecks.map((check) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(check["status"]),
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
                            spacing: 4,
                            children: [
                              Text(
                                "${check["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${check["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 4,
                          children: [
                            Text(
                              "${(check["score"] as double).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(check["status"]),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(check["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusLabel(check["status"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(check["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Jurisdiction: ${check["jurisdiction"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Requirements:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      children: (check["requirements"] as List).map<Widget>((req) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(req["status"]).withAlpha(13),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                req["status"] == "compliant" 
                                    ? Icons.check_circle
                                    : req["status"] == "action_needed"
                                        ? Icons.warning
                                        : Icons.schedule,
                                color: _getStatusColor(req["status"]),
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${req["item"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "Due: ${req["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Text(
                          "Last Check: ${check["lastCheck"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Next Check: ${check["nextCheck"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Compliance Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: complianceAlerts.map((alert) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(alert["type"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getStatusColor(alert["type"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            alert["type"] == "urgent" 
                                ? Icons.error
                                : alert["type"] == "warning"
                                    ? Icons.warning
                                    : Icons.info,
                            color: _getStatusColor(alert["type"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${alert["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(alert["type"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(alert["type"]).toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(alert["type"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${alert["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (alert["dueDate"] != null) ...[
                      Row(
                        children: [
                          Text(
                            "Due Date: ${alert["dueDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if (alert["daysOverdue"] != null) ...[
                            Text(
                              "${alert["daysOverdue"]} days overdue",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ] else if (alert["daysRemaining"] != null) ...[
                            Text(
                              "${alert["daysRemaining"]} days remaining",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                    if (alert["jurisdiction"] != null) ...[
                      Text(
                        "Jurisdiction: ${alert["jurisdiction"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                    if (alert["impact"] != null) ...[
                      Row(
                        children: [
                          Text(
                            "Impact: ${alert["impact"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (alert["action"] != null) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(13),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: infoColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${alert["action"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Take Action",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Deadlines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: upcomingDeadlines.map((deadline) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
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
                            spacing: 4,
                            children: [
                              Text(
                                "${deadline["form"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${deadline["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(deadline["priority"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${deadline["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(deadline["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${deadline["dueDate"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${deadline["jurisdiction"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(deadline["status"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${deadline["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(deadline["status"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Start Work",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

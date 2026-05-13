import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaComplianceView extends StatefulWidget {
  const LcaComplianceView({super.key});

  @override
  State<LcaComplianceView> createState() => _LcaComplianceViewState();
}

class _LcaComplianceViewState extends State<LcaComplianceView> {
  int currentTab = 0;
  String selectedFilter = "all";
  bool showOnlyPending = false;

  List<Map<String, dynamic>> complianceOverview = [
    {
      "title": "Overall Compliance",
      "score": 96.5,
      "status": "Excellent",
      "color": successColor,
      "icon": Icons.verified,
    },
    {
      "title": "Pending Reviews",
      "count": 8,
      "urgency": "Medium",
      "color": warningColor,
      "icon": Icons.pending_actions,
    },
    {
      "title": "Risk Level",
      "level": "Low",
      "percentage": 12,
      "color": primaryColor,
      "icon": Icons.shield,
    },
    {
      "title": "Last Audit",
      "date": "Mar 15, 2024",
      "result": "Passed",
      "color": infoColor,
      "icon": Icons.fact_check,
    },
  ];

  List<Map<String, dynamic>> complianceAreas = [
    {
      "area": "Client Confidentiality",
      "score": 98,
      "status": "Compliant",
      "lastReview": "2024-06-10",
      "nextReview": "2024-09-10",
      "requirements": 12,
      "completed": 12,
      "color": successColor,
    },
    {
      "area": "Data Protection (GDPR)",
      "score": 95,
      "status": "Compliant",
      "lastReview": "2024-06-05",
      "nextReview": "2024-12-05",
      "requirements": 15,
      "completed": 14,
      "color": successColor,
    },
    {
      "area": "Financial Regulations",
      "score": 92,
      "status": "Minor Issues",
      "lastReview": "2024-05-28",
      "nextReview": "2024-08-28",
      "requirements": 10,
      "completed": 9,
      "color": warningColor,
    },
    {
      "area": "Professional Ethics",
      "score": 99,
      "status": "Excellent",
      "lastReview": "2024-06-12",
      "nextReview": "2024-12-12",
      "requirements": 8,
      "completed": 8,
      "color": successColor,
    },
    {
      "area": "Document Retention",
      "score": 88,
      "status": "Needs Attention",
      "lastReview": "2024-05-20",
      "nextReview": "2024-07-20",
      "requirements": 6,
      "completed": 5,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> pendingTasks = [
    {
      "task": "Update Privacy Policy",
      "area": "Data Protection",
      "priority": "High",
      "dueDate": "2024-06-25",
      "assignee": "Sarah Johnson",
      "status": "In Progress",
    },
    {
      "task": "Client File Audit",
      "area": "Document Retention",
      "priority": "Medium",
      "dueDate": "2024-06-30",
      "assignee": "Michael Chen",
      "status": "Pending",
    },
    {
      "task": "Ethics Training Completion",
      "area": "Professional Ethics",
      "priority": "Low",
      "dueDate": "2024-07-15",
      "assignee": "Emily Rodriguez",
      "status": "Scheduled",
    },
    {
      "task": "Security Assessment",
      "area": "Data Protection",
      "priority": "High",
      "dueDate": "2024-06-28",
      "assignee": "David Kim",
      "status": "Not Started",
    },
  ];

  List<Map<String, dynamic>> complianceTrends = [
    {"month": "Jan", "score": 92},
    {"month": "Feb", "score": 94},
    {"month": "Mar", "score": 93},
    {"month": "Apr", "score": 95},
    {"month": "May", "score": 96},
    {"month": "Jun", "score": 97},
  ];

  List<Map<String, dynamic>> riskFactors = [
    {
      "factor": "Outdated Policies",
      "riskLevel": "Medium",
      "impact": "Moderate",
      "likelihood": "Low",
      "mitigation": "Scheduled for quarterly review",
    },
    {
      "factor": "Staff Training Gaps",
      "riskLevel": "Low",
      "impact": "Low",
      "likelihood": "Medium",
      "mitigation": "Ongoing training program implemented",
    },
    {
      "factor": "System Vulnerabilities",
      "riskLevel": "Medium",
      "impact": "High",
      "likelihood": "Low",
      "mitigation": "Regular security updates and monitoring",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Areas", "value": "all"},
    {"label": "Data Protection", "value": "data"},
    {"label": "Ethics", "value": "ethics"},
    {"label": "Financial", "value": "financial"},
    {"label": "Confidentiality", "value": "confidentiality"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Areas", icon: Icon(Icons.checklist)),
        Tab(text: "Tasks", icon: Icon(Icons.assignment)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAreasTab(),
        _buildTasksTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceOverview(),
          _buildComplianceScore(),
          _buildRecentActivity(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildAreasTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAreasFilter(),
          _buildComplianceAreas(),
          _buildAreaInsights(),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTasksHeader(),
          _buildTasksList(),
          _buildTaskActions(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceTrends(),
          _buildRiskAssessment(),
          _buildComplianceReports(),
        ],
      ),
    );
  }

  Widget _buildComplianceOverview() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: complianceOverview.map((item) {
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
                      color: (item["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      item["icon"] as IconData,
                      color: item["color"] as Color,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              if (item["score"] != null)
                Text(
                  "${(item["score"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              else if (item["count"] != null)
                Text(
                  "${item["count"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              else if (item["level"] != null)
                Text(
                  "${item["level"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              else if (item["date"] != null)
                Text(
                  "${item["date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              SizedBox(height: spXs),
              if (item["status"] != null)
                Text(
                  "${item["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: item["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else if (item["urgency"] != null)
                Text(
                  "${item["urgency"]} priority",
                  style: TextStyle(
                    fontSize: 12,
                    color: item["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else if (item["percentage"] != null)
                Text(
                  "${item["percentage"]}% risk exposure",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                )
              else if (item["result"] != null)
                Text(
                  "${item["result"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: item["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComplianceScore() {
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
          Text(
            "Compliance Score by Area",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: complianceAreas.take(5).map((area) {
                final height = ((area["score"] as int) / 100) * 150;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: area["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${area["area"]}".split(" ")[0],
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${area["score"]}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {
        "activity": "Privacy Policy Updated",
        "area": "Data Protection",
        "time": "2 hours ago",
        "user": "Sarah Johnson",
        "type": "update",
      },
      {
        "activity": "Compliance Audit Completed",
        "area": "Client Confidentiality",
        "time": "1 day ago",
        "user": "System",
        "type": "audit",
      },
      {
        "activity": "Risk Assessment Submitted",
        "area": "Financial Regulations",
        "time": "3 days ago",
        "user": "Michael Chen",
        "type": "assessment",
      },
    ];

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
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...activities.map((activity) {
            IconData activityIcon;
            Color iconColor;
            
            switch (activity["type"]) {
              case "update":
                activityIcon = Icons.update;
                iconColor = primaryColor;
                break;
              case "audit":
                activityIcon = Icons.fact_check;
                iconColor = successColor;
                break;
              case "assessment":
                activityIcon = Icons.assessment;
                iconColor = warningColor;
                break;
              default:
                activityIcon = Icons.info;
                iconColor = infoColor;
            }
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: iconColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      activityIcon,
                      color: iconColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["activity"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${activity["area"]} • ${activity["user"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${activity["time"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildActionButton("Schedule Audit", Icons.event, primaryColor),
              _buildActionButton("Generate Report", Icons.description, successColor),
              _buildActionButton("Review Policies", Icons.policy, warningColor),
              _buildActionButton("Risk Assessment", Icons.shield, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreasFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Filter by Area",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QSwitch(
              items: [
                {
                  "label": "Show only pending reviews",
                  "value": true,
                  "checked": showOnlyPending,
                }
              ],
              value: [
                if (showOnlyPending)
                  {
                    "label": "Show only pending reviews",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showOnlyPending = values.isNotEmpty;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceAreas() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Compliance Areas",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...complianceAreas.map((area) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledColor.withAlpha(30),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (area["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.security,
                          color: area["color"] as Color,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${area["area"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${area["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: area["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${area["score"]}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: area["color"] as Color,
                            ),
                          ),
                          Text(
                            "${area["completed"]}/${area["requirements"]} req",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: (area["score"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: area["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Last review: ${area["lastReview"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Next: ${area["nextReview"]}",
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
        ],
      ),
    );
  }

  Widget _buildAreaInsights() {
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
          Text(
            "Compliance Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildInsightItem(
            "Document Retention area requires immediate attention",
            Icons.warning,
            dangerColor,
          ),
          _buildInsightItem(
            "Professional Ethics maintaining excellent compliance",
            Icons.verified,
            successColor,
          ),
          _buildInsightItem(
            "3 areas due for quarterly review this month",
            Icons.schedule,
            warningColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String text, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.assignment,
              color: warningColor,
              size: 32,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Compliance Tasks",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${pendingTasks.length} tasks require attention",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: pendingTasks.map((task) {
          Color priorityColor = _getPriorityColor(task["priority"] as String);
          Color statusColor = _getStatusColor(task["status"] as String);
          
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor.withAlpha(30),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${task["task"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Area: ${task["area"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Assignee: ${task["assignee"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 12,
                      color: disabledColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${task["dueDate"]}",
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
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'pending':
        return warningColor;
      case 'not started':
        return dangerColor;
      case 'scheduled':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildTaskActions() {
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
          Text(
            "Task Management",
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
                child: QButton(
                  label: "Add New Task",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Tasks",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceTrends() {
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
          Text(
            "Compliance Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: complianceTrends.map((trend) {
                final maxScore = complianceTrends.map((t) => t["score"] as int).reduce((a, b) => a > b ? a : b);
                final height = ((trend["score"] as int) / maxScore) * 150;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trend["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${trend["score"]}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Overall Compliance Score",
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

  Widget _buildRiskAssessment() {
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
          Text(
            "Risk Assessment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...riskFactors.map((risk) {
            Color riskColor = _getRiskColor(risk["riskLevel"] as String);
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: riskColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: riskColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${risk["factor"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: riskColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${risk["riskLevel"]} Risk",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Impact: ${risk["impact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "•",
                        style: TextStyle(
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Likelihood: ${risk["likelihood"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Mitigation: ${risk["mitigation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildComplianceReports() {
    List<Map<String, dynamic>> reports = [
      {
        "title": "Monthly Compliance Report",
        "date": "June 2024",
        "status": "Generated",
        "type": "PDF",
      },
      {
        "title": "Quarterly Risk Assessment",
        "date": "Q2 2024",
        "status": "In Progress",
        "type": "PDF",
      },
      {
        "title": "Annual Compliance Audit",
        "date": "2024",
        "status": "Scheduled",
        "type": "PDF",
      },
    ];

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
          Text(
            "Compliance Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...reports.map((report) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledColor.withAlpha(30)),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${report["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${report["date"]} • ${report["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(report["status"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(report["status"] as String),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: spSm),
          QButton(
            label: "Generate New Report",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaEthicsComplianceView extends StatefulWidget {
  const LcaEthicsComplianceView({super.key});

  @override
  State<LcaEthicsComplianceView> createState() => _LcaEthicsComplianceViewState();
}

class _LcaEthicsComplianceViewState extends State<LcaEthicsComplianceView> {
  int currentTab = 0;
  String selectedCategory = "all";
  String selectedPeriod = "current";

  List<Map<String, dynamic>> ethicsOverview = [
    {
      "title": "Ethics Score",
      "score": 98.5,
      "status": "Excellent",
      "color": successColor,
      "icon": Icons.verified_user,
    },
    {
      "title": "Active Cases Review",
      "count": 12,
      "pending": 3,
      "color": primaryColor,
      "icon": Icons.gavel,
    },
    {
      "title": "Training Compliance",
      "percentage": 95,
      "total": 20,
      "completed": 19,
      "color": warningColor,
      "icon": Icons.school,
    },
    {
      "title": "Policy Updates",
      "lastUpdate": "May 2024",
      "nextReview": "Aug 2024",
      "color": infoColor,
      "icon": Icons.policy,
    },
  ];

  List<Map<String, dynamic>> ethicsPrinciples = [
    {
      "principle": "Client Confidentiality",
      "score": 99,
      "cases": 45,
      "violations": 0,
      "status": "Excellent",
      "color": successColor,
      "description": "Maintaining absolute confidentiality of client information",
    },
    {
      "principle": "Conflict of Interest",
      "score": 96,
      "cases": 32,
      "violations": 1,
      "status": "Good",
      "color": primaryColor,
      "description": "Proper identification and management of conflicts",
    },
    {
      "principle": "Professional Competence",
      "score": 98,
      "cases": 28,
      "violations": 0,
      "status": "Excellent",
      "color": successColor,
      "description": "Maintaining professional standards and competency",
    },
    {
      "principle": "Client Communication",
      "score": 94,
      "cases": 38,
      "violations": 2,
      "status": "Good",
      "color": warningColor,
      "description": "Clear, honest, and timely communication with clients",
    },
    {
      "principle": "Fee Arrangements",
      "score": 97,
      "cases": 41,
      "violations": 1,
      "status": "Excellent",
      "color": successColor,
      "description": "Transparent and reasonable fee structures",
    },
  ];

  List<Map<String, dynamic>> ethicsTraining = [
    {
      "program": "Annual Ethics Refresher",
      "status": "Completed",
      "completionDate": "2024-05-15",
      "expiryDate": "2025-05-15",
      "score": 95,
      "participants": 8,
    },
    {
      "program": "Conflict of Interest Workshop",
      "status": "In Progress",
      "completionDate": null,
      "expiryDate": "2024-08-30",
      "score": null,
      "participants": 6,
    },
    {
      "program": "Client Confidentiality Update",
      "status": "Scheduled",
      "completionDate": null,
      "expiryDate": "2024-07-20",
      "score": null,
      "participants": 8,
    },
  ];

  List<Map<String, dynamic>> ethicsViolations = [
    {
      "case": "Case #2024-045",
      "type": "Minor Communication Delay",
      "principle": "Client Communication",
      "severity": "Low",
      "date": "2024-06-10",
      "status": "Resolved",
      "resolution": "Additional training provided",
      "responsible": "Emily Rodriguez",
    },
    {
      "case": "Case #2024-032",
      "type": "Fee Disclosure Issue",
      "principle": "Fee Arrangements",
      "severity": "Medium",
      "date": "2024-05-28",
      "status": "Under Review",
      "resolution": "Policy clarification in progress",
      "responsible": "Michael Chen",
    },
  ];

  List<Map<String, dynamic>> ethicsPolicies = [
    {
      "policy": "Client Confidentiality Policy",
      "version": "v2.1",
      "lastUpdated": "2024-05-01",
      "nextReview": "2024-11-01",
      "status": "Current",
      "compliance": 100,
    },
    {
      "policy": "Conflict of Interest Guidelines",
      "version": "v1.8",
      "lastUpdated": "2024-04-15",
      "nextReview": "2024-10-15",
      "status": "Current",
      "compliance": 96,
    },
    {
      "policy": "Professional Conduct Standards",
      "version": "v3.0",
      "lastUpdated": "2024-03-20",
      "nextReview": "2024-09-20",
      "status": "Under Review",
      "compliance": 98,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Confidentiality", "value": "confidentiality"},
    {"label": "Conflicts", "value": "conflicts"},
    {"label": "Competence", "value": "competence"},
    {"label": "Communication", "value": "communication"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Period", "value": "current"},
    {"label": "Last Quarter", "value": "quarter"},
    {"label": "Last Year", "value": "year"},
    {"label": "All Time", "value": "all_time"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Ethics & Compliance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Principles", icon: Icon(Icons.verified_user)),
        Tab(text: "Training", icon: Icon(Icons.school)),
        Tab(text: "Violations", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPrinciplesTab(),
        _buildTrainingTab(),
        _buildViolationsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEthicsOverview(),
          _buildEthicsScore(),
          _buildRecentActivity(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildPrinciplesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPrinciplesFilter(),
          _buildEthicsPrinciples(),
          _buildPrinciplesInsights(),
        ],
      ),
    );
  }

  Widget _buildTrainingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTrainingOverview(),
          _buildTrainingPrograms(),
          _buildTrainingSchedule(),
        ],
      ),
    );
  }

  Widget _buildViolationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildViolationsOverview(),
          _buildViolationsList(),
          _buildPoliciesReview(),
        ],
      ),
    );
  }

  Widget _buildEthicsOverview() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: ethicsOverview.map((item) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${(item["score"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: item["color"] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              else if (item["count"] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["count"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["pending"]} pending review",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                )
              else if (item["percentage"] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["percentage"]}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["completed"]}/${item["total"]} completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                )
              else if (item["lastUpdate"] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["lastUpdate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Next: ${item["nextReview"]}",
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
    );
  }

  Widget _buildEthicsScore() {
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
            "Ethics Principles Performance",
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
              children: ethicsPrinciples.take(5).map((principle) {
                final height = ((principle["score"] as int) / 100) * 150;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: principle["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${principle["principle"]}".split(" ")[0],
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${principle["score"]}%",
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
        "activity": "Ethics training completed by Emily Rodriguez",
        "type": "training",
        "time": "2 hours ago",
        "icon": Icons.school,
        "color": successColor,
      },
      {
        "activity": "New conflict of interest case reviewed",
        "type": "review",
        "time": "1 day ago",
        "icon": Icons.gavel,
        "color": primaryColor,
      },
      {
        "activity": "Confidentiality policy updated",
        "type": "policy",
        "time": "3 days ago",
        "icon": Icons.policy,
        "color": warningColor,
      },
      {
        "activity": "Ethics violation case resolved",
        "type": "violation",
        "time": "1 week ago",
        "icon": Icons.check_circle,
        "color": infoColor,
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
            "Recent Ethics Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...activities.map((activity) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (activity["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      activity["icon"] as IconData,
                      color: activity["color"] as Color,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${activity["activity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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
              _buildActionCard("Schedule Training", Icons.schedule, primaryColor),
              _buildActionCard("Review Cases", Icons.gavel, successColor),
              _buildActionCard("Update Policies", Icons.policy, warningColor),
              _buildActionCard("Generate Report", Icons.assessment, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
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

  Widget _buildPrinciplesFilter() {
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
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEthicsPrinciples() {
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
              "Ethics Principles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...ethicsPrinciples.map((principle) {
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
                          color: (principle["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.verified_user,
                          color: principle["color"] as Color,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${principle["principle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${principle["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: principle["color"] as Color,
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
                            "${principle["score"]}%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: principle["color"] as Color,
                            ),
                          ),
                          Text(
                            "${principle["violations"]} violations",
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
                  Text(
                    "${principle["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
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
                            widthFactor: (principle["score"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: principle["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${principle["cases"]} cases reviewed",
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

  Widget _buildPrinciplesInsights() {
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
            "Ethics Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildInsightItem(
            "Client Confidentiality maintains perfect compliance record",
            Icons.verified,
            successColor,
          ),
          _buildInsightItem(
            "2 minor violations resolved this quarter",
            Icons.info,
            primaryColor,
          ),
          _buildInsightItem(
            "Training compliance at 95% - 1 staff member pending",
            Icons.school,
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

  Widget _buildTrainingOverview() {
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
            "Ethics Training Overview",
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
              _buildTrainingMetric("Programs Active", "3", Icons.play_circle, primaryColor),
              _buildTrainingMetric("Completion Rate", "95%", Icons.check_circle, successColor),
              _buildTrainingMetric("Staff Certified", "19/20", Icons.verified, warningColor),
              _buildTrainingMetric("Next Deadline", "Jul 20", Icons.schedule, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingPrograms() {
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
              "Training Programs",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...ethicsTraining.map((training) {
            Color statusColor = _getTrainingStatusColor(training["status"] as String);
            
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
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getTrainingIcon(training["status"] as String),
                          color: statusColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${training["program"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${training["participants"]} participants",
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${training["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (training["score"] != null)
                            Text(
                              "Score: ${training["score"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      if (training["completionDate"] != null)
                        Text(
                          "Completed: ${training["completionDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      Spacer(),
                      Text(
                        "Due: ${training["expiryDate"]}",
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

  Color _getTrainingStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'scheduled':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrainingIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'in progress':
        return Icons.play_circle;
      case 'scheduled':
        return Icons.schedule;
      case 'overdue':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Widget _buildTrainingSchedule() {
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
            "Training Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Training",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Client Confidentiality Update - July 20, 2024",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "All staff members required to attend",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Schedule New Training",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildViolationsOverview() {
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
            "Ethics Violations Overview",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Cases",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${ethicsViolations.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "this year",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Resolved",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "cases",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Under Review",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "cases",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViolationsList() {
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
              "Ethics Violations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...ethicsViolations.map((violation) {
            Color severityColor = _getSeverityColor(violation["severity"] as String);
            Color statusColor = _getViolationStatusColor(violation["status"] as String);
            
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
                          color: severityColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${violation["severity"]}",
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
                          "${violation["case"]}",
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
                          "${violation["status"]}",
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
                  Text(
                    "${violation["type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Principle: ${violation["principle"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Date: ${violation["date"]}",
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
                        "Staff: ${violation["responsible"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  if (violation["resolution"] != null) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Resolution: ${violation["resolution"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
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

  Color _getViolationStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return successColor;
      case 'under review':
        return warningColor;
      case 'investigating':
        return primaryColor;
      case 'closed':
        return disabledBoldColor;
      default:
        return dangerColor;
    }
  }

  Widget _buildPoliciesReview() {
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
            "Ethics Policies Review",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...ethicsPolicies.map((policy) {
            Color statusColor = _getPolicyStatusColor(policy["status"] as String);
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledColor.withAlpha(30)),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${policy["policy"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${policy["version"]} • Updated: ${policy["lastUpdated"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${policy["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${policy["compliance"]}% compliant",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Next review: ${policy["nextReview"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: (policy["compliance"] as int) / 100,
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
            );
          }).toList(),
          SizedBox(height: spSm),
          QButton(
            label: "Review Policies",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Color _getPolicyStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'current':
        return successColor;
      case 'under review':
        return warningColor;
      case 'outdated':
        return dangerColor;
      case 'draft':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}

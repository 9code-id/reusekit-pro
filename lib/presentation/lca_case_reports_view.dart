import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseReportsView extends StatefulWidget {
  const LcaCaseReportsView({super.key});

  @override
  State<LcaCaseReportsView> createState() => _LcaCaseReportsViewState();
}

class _LcaCaseReportsViewState extends State<LcaCaseReportsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCaseType = "";
  String selectedStatus = "";
  String selectedPeriod = "This Month";
  String selectedReportType = "Summary";

  List<Map<String, dynamic>> caseReports = [
    {
      "id": "CR001",
      "title": "Personal Injury Cases Summary",
      "caseType": "Personal Injury",
      "totalCases": 45,
      "activeCases": 32,
      "closedCases": 13,
      "success_rate": 78.5,
      "avgSettlement": 125000.0,
      "generated_date": DateTime.now().subtract(Duration(hours: 2)),
      "status": "Completed",
      "format": "PDF",
      "size": "2.1 MB"
    },
    {
      "id": "CR002", 
      "title": "Criminal Defense Quarterly Report",
      "caseType": "Criminal Defense",
      "totalCases": 28,
      "activeCases": 19,
      "closedCases": 9,
      "success_rate": 82.1,
      "avgSettlement": 0.0,
      "generated_date": DateTime.now().subtract(Duration(days: 1)),
      "status": "Completed",
      "format": "Excel",
      "size": "1.8 MB"
    },
    {
      "id": "CR003",
      "title": "Corporate Law Cases Analysis",
      "caseType": "Corporate Law",
      "totalCases": 18,
      "activeCases": 15,
      "closedCases": 3,
      "success_rate": 95.2,
      "avgSettlement": 340000.0,
      "generated_date": DateTime.now().subtract(Duration(hours: 6)),
      "status": "Processing",
      "format": "PDF", 
      "size": "3.2 MB"
    },
    {
      "id": "CR004",
      "title": "Family Law Monthly Overview",
      "caseType": "Family Law",
      "totalCases": 67,
      "activeCases": 41,
      "closedCases": 26,
      "success_rate": 71.3,
      "avgSettlement": 0.0,
      "generated_date": DateTime.now().subtract(Duration(hours: 1)),
      "status": "Completed",
      "format": "Word",
      "size": "1.5 MB"
    },
    {
      "id": "CR005",
      "title": "Real Estate Transactions Report",
      "caseType": "Real Estate",
      "totalCases": 34,
      "activeCases": 22,
      "closedCases": 12,
      "success_rate": 88.9,
      "avgSettlement": 0.0,
      "generated_date": DateTime.now().subtract(Duration(days: 2)),
      "status": "Completed",
      "format": "PDF",
      "size": "2.7 MB"
    },
  ];

  List<Map<String, dynamic>> caseStatistics = [
    {
      "title": "Total Cases",
      "value": 192,
      "change": 12.5,
      "icon": Icons.cases,
      "color": primaryColor
    },
    {
      "title": "Active Cases",
      "value": 129,
      "change": 8.3,
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "Closed Cases",
      "value": 63,
      "change": 15.2,
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Average Success Rate",
      "value": 83.2,
      "change": 5.1,
      "icon": Icons.trending_up,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> caseTypeItems = [
    {"label": "All Types", "value": ""},
    {"label": "Personal Injury", "value": "Personal Injury"},
    {"label": "Criminal Defense", "value": "Criminal Defense"},
    {"label": "Corporate Law", "value": "Corporate Law"},
    {"label": "Family Law", "value": "Family Law"},
    {"label": "Real Estate", "value": "Real Estate"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Completed", "value": "Completed"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> reportTypeItems = [
    {"label": "Summary", "value": "Summary"},
    {"label": "Detailed", "value": "Detailed"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Comparison", "value": "Comparison"},
  ];

  List<Map<String, dynamic>> get filteredReports {
    return caseReports.where((report) {
      bool matchesSearch = searchQuery.isEmpty ||
          report["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          report["id"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedCaseType.isEmpty || report["caseType"] == selectedCaseType;
      bool matchesStatus = selectedStatus.isEmpty || report["status"] == selectedStatus;
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Case Reports",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReportsTab(),
        _buildAnalyticsTab(),
        _buildTemplatesTab(),
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
          Text(
            "Case Reporting Dashboard",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: caseStatistics.map((stat) {
              return Container(
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (stat["change"] as double) > 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(stat["change"] as double) > 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (stat["change"] as double) > 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      stat["title"] == "Average Success Rate" 
                          ? "${(stat["value"] as num).toStringAsFixed(1)}%"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Container(
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
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Generate Report",
                        icon: Icons.add_chart,
                        size: bs.sm,
                        onPressed: () => _showGenerateReportDialog(),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _showExportDialog(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
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
                Text(
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...caseReports.take(3).map((report) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.description,
                            color: primaryColor,
                            size: 16,
                          ),
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
                                "${(report["generated_date"] as DateTime).dMMMy}",
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
                            color: report["status"] == "Completed" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: report["status"] == "Completed" ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search reports...",
                  value: searchQuery,
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
                onPressed: () => _showFilterDialog(),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Case Type",
                  items: caseTypeItems,
                  value: selectedCaseType,
                  onChanged: (value, label) {
                    selectedCaseType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          ...filteredReports.map((report) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
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
                          spacing: spXs,
                          children: [
                            Text(
                              "${report["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Report ID: ${report["id"]} • ${report["caseType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: report["status"] == "Completed" 
                              ? successColor.withAlpha(20)
                              : report["status"] == "Processing"
                                  ? warningColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${report["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: report["status"] == "Completed" 
                                ? successColor
                                : report["status"] == "Processing"
                                    ? warningColor
                                    : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${report["totalCases"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Cases",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${report["activeCases"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${(report["success_rate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Success Rate",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Generated: ${(report["generated_date"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${report["format"]} • ${report["size"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Report",
                          size: bs.sm,
                          onPressed: () => _viewReport(report),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _downloadReport(report),
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () => _shareReport(report),
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Case Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
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
                Text(
                  "Case Distribution by Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Chart: Case type distribution pie chart would be displayed here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
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
                Text(
                  "Success Rate Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Chart: Success rate trend line chart would be displayed here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
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
                Text(
                  "Monthly Case Volume",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Chart: Monthly case volume bar chart would be displayed here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Personal Injury Summary",
        "description": "Standard template for personal injury case reports",
        "category": "Personal Injury",
        "lastModified": DateTime.now().subtract(Duration(days: 3)),
        "usage": 45,
      },
      {
        "name": "Criminal Defense Analysis",
        "description": "Detailed analysis template for criminal defense cases",
        "category": "Criminal Defense", 
        "lastModified": DateTime.now().subtract(Duration(days: 7)),
        "usage": 28,
      },
      {
        "name": "Corporate Legal Review",
        "description": "Comprehensive review template for corporate legal matters",
        "category": "Corporate Law",
        "lastModified": DateTime.now().subtract(Duration(days: 5)),
        "usage": 18,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Report Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Create Template",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _showCreateTemplateDialog(),
              ),
            ],
          ),

          ...templates.map((template) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
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
                          spacing: spXs,
                          children: [
                            Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${template["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${template["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Modified: ${(template["lastModified"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.analytics, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Used ${template["usage"]} times",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Use Template",
                          size: bs.sm,
                          onPressed: () => _useTemplate(template),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () => _editTemplate(template),
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.copy,
                        size: bs.sm,
                        onPressed: () => _duplicateTemplate(template),
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

  void _showGenerateReportDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Text(
              "Generate New Report",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Report Type",
              items: reportTypeItems,
              value: selectedReportType,
              onChanged: (value, label) {
                selectedReportType = value;
              },
            ),
            QDropdownField(
              label: "Period",
              items: periodItems,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
              },
            ),
            QDropdownField(
              label: "Case Type",
              items: caseTypeItems,
              value: selectedCaseType,
              onChanged: (value, label) {
                selectedCaseType = value;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Report generation started");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExportDialog() {
    si("Export functionality would be implemented here");
  }

  void _showFilterDialog() {
    si("Advanced filter options would be shown here");
  }

  void _viewReport(Map<String, dynamic> report) {
    si("Opening report: ${report["title"]}");
  }

  void _downloadReport(Map<String, dynamic> report) {
    ss("Downloading report: ${report["title"]}");
  }

  void _shareReport(Map<String, dynamic> report) {
    si("Sharing report: ${report["title"]}");
  }

  void _showCreateTemplateDialog() {
    si("Create template dialog would be shown here");
  }

  void _useTemplate(Map<String, dynamic> template) {
    si("Using template: ${template["name"]}");
  }

  void _editTemplate(Map<String, dynamic> template) {
    si("Editing template: ${template["name"]}");
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    ss("Template duplicated: ${template["name"]}");
  }
}

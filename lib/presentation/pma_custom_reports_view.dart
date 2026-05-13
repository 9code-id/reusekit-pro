import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaCustomReportsView extends StatefulWidget {
  const PmaCustomReportsView({super.key});

  @override
  State<PmaCustomReportsView> createState() => _PmaCustomReportsViewState();
}

class _PmaCustomReportsViewState extends State<PmaCustomReportsView> {
  int currentTab = 0;
  String selectedReportType = "summary";
  String selectedDateRange = "last_30_days";
  String selectedFormat = "pdf";
  String reportName = "";
  List<String> selectedMetrics = [];
  List<String> selectedProjects = [];
  bool includeCharts = true;
  bool includeTableData = true;
  bool includeAnalysis = false;

  final List<Map<String, dynamic>> reportTypes = [
    {"label": "Summary Report", "value": "summary"},
    {"label": "Performance Report", "value": "performance"},
    {"label": "Project Analysis", "value": "project_analysis"},
    {"label": "Team Productivity", "value": "team_productivity"},
    {"label": "Budget Analysis", "value": "budget_analysis"},
    {"label": "Time Tracking", "value": "time_tracking"},
    {"label": "Resource Utilization", "value": "resource_utilization"},
    {"label": "KPI Dashboard", "value": "kpi_dashboard"},
  ];

  final List<Map<String, dynamic>> dateRanges = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "Last Year", "value": "last_year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  final List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF Document", "value": "pdf"},
    {"label": "Excel Spreadsheet", "value": "excel"},
    {"label": "CSV File", "value": "csv"},
    {"label": "PowerPoint", "value": "ppt"},
    {"label": "Word Document", "value": "word"},
  ];

  final List<Map<String, dynamic>> availableMetrics = [
    {"label": "Project Completion Rate", "value": "completion_rate"},
    {"label": "Task Efficiency", "value": "task_efficiency"},
    {"label": "Budget Utilization", "value": "budget_utilization"},
    {"label": "Team Performance", "value": "team_performance"},
    {"label": "Resource Allocation", "value": "resource_allocation"},
    {"label": "Timeline Adherence", "value": "timeline_adherence"},
    {"label": "Quality Metrics", "value": "quality_metrics"},
    {"label": "Risk Assessment", "value": "risk_assessment"},
    {"label": "Cost Analysis", "value": "cost_analysis"},
    {"label": "Productivity Index", "value": "productivity_index"},
  ];

  final List<Map<String, dynamic>> availableProjects = [
    {"label": "E-commerce Platform", "value": "ecommerce_platform"},
    {"label": "Mobile App Development", "value": "mobile_app_dev"},
    {"label": "Website Redesign", "value": "website_redesign"},
    {"label": "Marketing Campaign", "value": "marketing_campaign"},
    {"label": "Infrastructure Upgrade", "value": "infrastructure_upgrade"},
    {"label": "Data Analytics", "value": "data_analytics"},
    {"label": "Customer Portal", "value": "customer_portal"},
    {"label": "Security Enhancement", "value": "security_enhancement"},
  ];

  final List<Map<String, dynamic>> recentReports = [
    {
      "name": "Q4 Project Summary",
      "type": "Summary Report",
      "created": "2024-01-15",
      "format": "PDF",
      "size": "2.4 MB",
      "status": "completed"
    },
    {
      "name": "Team Performance Analysis",
      "type": "Performance Report",
      "created": "2024-01-12",
      "format": "Excel",
      "size": "1.8 MB",
      "status": "completed"
    },
    {
      "name": "Budget Utilization Report",
      "type": "Budget Analysis",
      "created": "2024-01-10",
      "format": "PDF",
      "size": "3.1 MB",
      "status": "completed"
    },
    {
      "name": "KPI Dashboard Report",
      "type": "KPI Dashboard",
      "created": "2024-01-08",
      "format": "PowerPoint",
      "size": "4.2 MB",
      "status": "completed"
    },
    {
      "name": "Resource Analysis",
      "type": "Resource Utilization",
      "created": "2024-01-05",
      "format": "Excel",
      "size": "2.7 MB",
      "status": "processing"
    },
  ];

  final List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Executive Summary",
      "description": "High-level overview for stakeholders",
      "metrics": ["completion_rate", "budget_utilization", "timeline_adherence"],
      "category": "Executive"
    },
    {
      "name": "Project Manager Dashboard",
      "description": "Detailed project tracking and analysis",
      "metrics": ["task_efficiency", "team_performance", "resource_allocation"],
      "category": "Management"
    },
    {
      "name": "Team Performance Review",
      "description": "Individual and team productivity metrics",
      "metrics": ["team_performance", "productivity_index", "quality_metrics"],
      "category": "HR"
    },
    {
      "name": "Financial Analysis",
      "description": "Budget and cost analysis report",
      "metrics": ["budget_utilization", "cost_analysis", "resource_allocation"],
      "category": "Finance"
    },
    {
      "name": "Quality Assurance Report",
      "description": "Quality metrics and improvement areas",
      "metrics": ["quality_metrics", "completion_rate", "risk_assessment"],
      "category": "Quality"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Custom Reports",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Create Report", icon: Icon(Icons.add_chart)),
        Tab(text: "Recent Reports", icon: Icon(Icons.history)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildCreateReportTab(),
        _buildRecentReportsTab(),
        _buildTemplatesTab(),
        _buildScheduledTab(),
      ],
    );
  }

  Widget _buildCreateReportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Report Configuration Section
          Container(
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
                    Icon(Icons.settings, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Report Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Report Name",
                  value: reportName,
                  hint: "Enter custom report name",
                  onChanged: (value) {
                    reportName = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Report Type",
                  items: reportTypes,
                  value: selectedReportType,
                  onChanged: (value, label) {
                    selectedReportType = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Date Range",
                  items: dateRanges,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Export Format",
                  items: formatOptions,
                  value: selectedFormat,
                  onChanged: (value, label) {
                    selectedFormat = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Metrics Selection
          Container(
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
                    Icon(Icons.analytics, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Metrics Selection",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: availableMetrics.map((metric) {
                    bool isSelected = selectedMetrics.contains(metric["value"]);
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selectedMetrics.remove(metric["value"]);
                        } else {
                          selectedMetrics.add(metric["value"]);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          "${metric["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Project Selection
          Container(
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
                    Icon(Icons.folder_open, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Project Selection",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: availableProjects.map((project) {
                    bool isSelected = selectedProjects.contains(project["value"]);
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              if (value == true) {
                                selectedProjects.add(project["value"]);
                              } else {
                                selectedProjects.remove(project["value"]);
                              }
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              "${project["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Report Options
          Container(
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
                    Icon(Icons.tune, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Report Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Checkbox(
                      value: includeCharts,
                      onChanged: (value) {
                        includeCharts = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include Charts and Graphs",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: includeTableData,
                      onChanged: (value) {
                        includeTableData = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include Raw Data Tables",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: includeAnalysis,
                      onChanged: (value) {
                        includeAnalysis = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include AI Analysis & Recommendations",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Generate Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate Report",
              size: bs.md,
              onPressed: () {
                ss("Report generation started successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.all(spSm),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Reports", "127", Icons.description, successColor),
              _buildSummaryCard("This Month", "23", Icons.calendar_today, primaryColor),
              _buildSummaryCard("Processing", "3", Icons.hourglass_empty, warningColor),
              _buildSummaryCard("Storage Used", "2.1 GB", Icons.storage, infoColor),
            ],
          ),

          SizedBox(height: spMd),

          // Recent Reports List
          Container(
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
                    Icon(Icons.history, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Recent Reports",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...recentReports.map((report) => _buildReportItem(report)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "completed" 
        ? successColor 
        : report["status"] == "processing" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.description,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${report["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${report["type"]} • ${report["format"]} • ${report["size"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${report["status"].toString().toUpperCase()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${report["created"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Template Categories
          Container(
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
                    Icon(Icons.description, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
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
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...reportTemplates.map((template) => _buildTemplateItem(template)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
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
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
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
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            children: (template["metrics"] as List).map<Widget>((metric) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  metric.toString().replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: successColor,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Scheduled Reports",
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
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.schedule_send,
                        size: 60,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Scheduled Reports",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Create automated reports that generate on a schedule",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Schedule Report",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}

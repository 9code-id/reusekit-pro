import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCustomReportsView extends StatefulWidget {
  const TpmCustomReportsView({super.key});

  @override
  State<TpmCustomReportsView> createState() => _TpmCustomReportsViewState();
}

class _TpmCustomReportsViewState extends State<TpmCustomReportsView> {
  String reportName = "";
  String reportDescription = "";
  String selectedCategory = "Performance";
  String selectedType = "Chart";
  String selectedTimeRange = "Last 30 Days";
  List<String> selectedFields = [];
  List<String> selectedFilters = [];
  
  List<Map<String, dynamic>> availableFields = [
    {"name": "Project Name", "type": "text", "selected": false},
    {"name": "Team Member", "type": "text", "selected": false},
    {"name": "Task Status", "type": "status", "selected": false},
    {"name": "Progress Percentage", "type": "number", "selected": false},
    {"name": "Budget Used", "type": "currency", "selected": false},
    {"name": "Time Spent", "type": "duration", "selected": false},
    {"name": "Due Date", "type": "date", "selected": false},
    {"name": "Priority Level", "type": "priority", "selected": false},
    {"name": "Department", "type": "text", "selected": false},
    {"name": "Cost Per Hour", "type": "currency", "selected": false},
  ];

  List<Map<String, dynamic>> savedReports = [
    {
      "id": "1",
      "name": "Weekly Team Performance",
      "description": "Track team productivity and task completion rates",
      "category": "Performance",
      "type": "Chart",
      "createdDate": "2025-06-15",
      "lastRun": "2025-06-19",
      "isScheduled": true,
      "scheduleFrequency": "Weekly",
    },
    {
      "id": "2", 
      "name": "Project Budget Analysis",
      "description": "Monitor project expenses and budget utilization",
      "category": "Financial",
      "type": "Table",
      "createdDate": "2025-06-10",
      "lastRun": "2025-06-18",
      "isScheduled": false,
      "scheduleFrequency": "",
    },
    {
      "id": "3",
      "name": "Task Completion Timeline",
      "description": "Visual timeline of project milestones and deadlines",
      "category": "Timeline",
      "type": "Gantt",
      "createdDate": "2025-06-08",
      "lastRun": "2025-06-19",
      "isScheduled": true,
      "scheduleFrequency": "Daily",
    },
    {
      "id": "4",
      "name": "Resource Allocation Report",
      "description": "Team workload distribution and capacity planning",
      "category": "Resources",
      "type": "Chart",
      "createdDate": "2025-06-05",
      "lastRun": "2025-06-17",
      "isScheduled": false,
      "scheduleFrequency": "",
    },
  ];

  List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Project Status Summary",
      "description": "Overview of all active projects with key metrics",
      "fields": ["Project Name", "Progress Percentage", "Due Date", "Team Member"],
      "category": "Performance",
    },
    {
      "name": "Budget Utilization Report",
      "description": "Financial analysis of project spending and remaining budget",
      "fields": ["Project Name", "Budget Used", "Cost Per Hour", "Department"],
      "category": "Financial",
    },
    {
      "name": "Team Productivity Analysis",
      "description": "Individual and team performance metrics comparison",
      "fields": ["Team Member", "Time Spent", "Task Status", "Priority Level"],
      "category": "Performance",
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Performance", "value": "Performance"},
    {"label": "Financial", "value": "Financial"},
    {"label": "Timeline", "value": "Timeline"},
    {"label": "Resources", "value": "Resources"},
    {"label": "Quality", "value": "Quality"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "Chart", "value": "Chart"},
    {"label": "Table", "value": "Table"},
    {"label": "Gantt", "value": "Gantt"},
    {"label": "Dashboard", "value": "Dashboard"},
  ];

  List<Map<String, dynamic>> timeRangeItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  int currentTab = 0;
  bool showCreateForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCreateForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showCreateForm ? _buildCreateReportForm() : _buildReportsList(),
    );
  }

  Widget _buildCreateReportForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back, color: primaryColor),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  showCreateForm = false;
                  setState(() {});
                },
                child: Text(
                  "Back to Reports",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Create Custom Report",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QTextField(
                  label: "Report Name",
                  value: reportName,
                  hint: "Enter report name",
                  onChanged: (value) {
                    reportName = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Description",
                  value: reportDescription,
                  hint: "Describe what this report will show",
                  onChanged: (value) {
                    reportDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryItems,
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
                        label: "Report Type",
                        items: typeItems,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QDropdownField(
                  label: "Time Range",
                  items: timeRangeItems,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Select Fields to Include",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                ...availableFields.map((field) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: field["selected"],
                          onChanged: (value) {
                            field["selected"] = value ?? false;
                            setState(() {});
                          },
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${field["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Type: ${field["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
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
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Report Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Or start from a pre-built template",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),

                ...reportTemplates.map((template) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Use Template",
                              size: bs.sm,
                              onPressed: () {
                                _useTemplate(template);
                              },
                            ),
                          ],
                        ),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Fields: ${(template["fields"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledColor,
                  size: bs.md,
                  onPressed: () {
                    showCreateForm = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Report",
                  size: bs.md,
                  onPressed: () {
                    _createCustomReport();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.white, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Custom Reports",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Create personalized reports with custom fields and filters",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${savedReports.length} saved reports",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    QButton(
                      label: "Create New",
                      color: Colors.white,
                      size: bs.sm,
                      onPressed: () {
                        showCreateForm = true;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: savedReports.map((report) {
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
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(report["category"]).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            _getCategoryIcon(report["category"]),
                            color: _getCategoryColor(report["category"]),
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${report["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.more_vert, size: 16),
                          itemBuilder: (context) => [
                            PopupMenuItem(value: "run", child: Text("Run Report")),
                            PopupMenuItem(value: "edit", child: Text("Edit")),
                            PopupMenuItem(value: "duplicate", child: Text("Duplicate")),
                            PopupMenuItem(value: "delete", child: Text("Delete")),
                          ],
                          onSelected: (value) {
                            _handleReportAction(value, report);
                          },
                        ),
                      ],
                    ),

                    Text(
                      "${report["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Created:",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["createdDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Last Run:",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["lastRun"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (report["isScheduled"])
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Schedule:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, size: 12, color: successColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${report["scheduleFrequency"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Run Report",
                        size: bs.sm,
                        onPressed: () {
                          _runReport(report);
                        },
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Performance":
        return primaryColor;
      case "Financial":
        return successColor;
      case "Timeline":
        return warningColor;
      case "Resources":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Performance":
        return Icons.trending_up;
      case "Financial":
        return Icons.attach_money;
      case "Timeline":
        return Icons.timeline;
      case "Resources":
        return Icons.people;
      default:
        return Icons.analytics;
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    reportName = "${template["name"]}";
    reportDescription = "${template["description"]}";
    selectedCategory = "${template["category"]}";
    
    // Reset all fields
    for (var field in availableFields) {
      field["selected"] = false;
    }
    
    // Select template fields
    List<String> templateFields = List<String>.from(template["fields"]);
    for (var field in availableFields) {
      if (templateFields.contains(field["name"])) {
        field["selected"] = true;
      }
    }
    
    setState(() {});
    ss("Template applied successfully");
  }

  void _createCustomReport() {
    if (reportName.isEmpty) {
      se("Please enter a report name");
      return;
    }
    
    List<String> selectedFieldNames = availableFields
        .where((field) => field["selected"])
        .map((field) => field["name"] as String)
        .toList();
    
    if (selectedFieldNames.isEmpty) {
      se("Please select at least one field");
      return;
    }
    
    // Add new report to saved reports
    savedReports.insert(0, {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": reportName,
      "description": reportDescription,
      "category": selectedCategory,
      "type": selectedType,
      "createdDate": "2025-06-19",
      "lastRun": "",
      "isScheduled": false,
      "scheduleFrequency": "",
    });
    
    // Reset form
    reportName = "";
    reportDescription = "";
    selectedCategory = "Performance";
    selectedType = "Chart";
    selectedTimeRange = "Last 30 Days";
    
    for (var field in availableFields) {
      field["selected"] = false;
    }
    
    showCreateForm = false;
    setState(() {});
    ss("Custom report created successfully");
  }

  void _runReport(Map<String, dynamic> report) {
    report["lastRun"] = "2025-06-19";
    setState(() {});
    ss("Report '${report["name"]}' generated successfully");
  }

  void _handleReportAction(String action, Map<String, dynamic> report) {
    switch (action) {
      case "run":
        _runReport(report);
        break;
      case "edit":
        si("Edit functionality will be available soon");
        break;
      case "duplicate":
        Map<String, dynamic> duplicatedReport = Map.from(report);
        duplicatedReport["id"] = DateTime.now().millisecondsSinceEpoch.toString();
        duplicatedReport["name"] = "${report["name"]} (Copy)";
        duplicatedReport["createdDate"] = "2025-06-19";
        duplicatedReport["lastRun"] = "";
        savedReports.insert(0, duplicatedReport);
        setState(() {});
        ss("Report duplicated successfully");
        break;
      case "delete":
        savedReports.removeWhere((r) => r["id"] == report["id"]);
        setState(() {});
        ss("Report deleted successfully");
        break;
    }
  }
}

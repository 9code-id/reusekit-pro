import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshCustomReportsView extends StatefulWidget {
  const CshCustomReportsView({super.key});

  @override
  State<CshCustomReportsView> createState() => _CshCustomReportsViewState();
}

class _CshCustomReportsViewState extends State<CshCustomReportsView> {
  String reportName = "";
  String selectedTemplate = "";
  String selectedFormat = "PDF";
  String selectedFrequency = "One-time";
  List<String> selectedMetrics = [];
  List<String> selectedFilters = [];
  DateTime? startDate;
  DateTime? endDate;
  bool includeCharts = true;
  bool includeRawData = false;
  bool autoSchedule = false;
  
  List<Map<String, dynamic>> reportTemplates = [
    {"label": "Blank Report", "value": ""},
    {"label": "Agent Performance Report", "value": "agent_performance"},
    {"label": "Customer Satisfaction Report", "value": "satisfaction"},
    {"label": "Ticket Analysis Report", "value": "ticket_analysis"},
    {"label": "Channel Performance Report", "value": "channel_performance"},
    {"label": "SLA Compliance Report", "value": "sla_compliance"},
    {"label": "Resolution Time Report", "value": "resolution_time"},
  ];

  List<Map<String, dynamic>> formats = [
    {"label": "PDF Document", "value": "PDF"},
    {"label": "Excel Spreadsheet", "value": "Excel"},
    {"label": "CSV Data", "value": "CSV"},
    {"label": "PowerPoint Presentation", "value": "PowerPoint"},
    {"label": "JSON Data", "value": "JSON"},
  ];

  List<Map<String, dynamic>> frequencies = [
    {"label": "One-time", "value": "One-time"},
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
  ];

  List<Map<String, dynamic>> availableMetrics = [
    {"label": "Ticket Volume", "value": "ticket_volume", "checked": false},
    {"label": "Response Time", "value": "response_time", "checked": false},
    {"label": "Resolution Rate", "value": "resolution_rate", "checked": false},
    {"label": "Customer Satisfaction", "value": "satisfaction", "checked": false},
    {"label": "Agent Performance", "value": "agent_performance", "checked": false},
    {"label": "Channel Usage", "value": "channel_usage", "checked": false},
    {"label": "SLA Compliance", "value": "sla_compliance", "checked": false},
    {"label": "First Contact Resolution", "value": "fcr", "checked": false},
    {"label": "Escalation Rate", "value": "escalation_rate", "checked": false},
    {"label": "Cost per Ticket", "value": "cost_per_ticket", "checked": false},
  ];

  List<Map<String, dynamic>> availableFilters = [
    {"label": "Date Range", "value": "date_range", "checked": false},
    {"label": "Agent", "value": "agent", "checked": false},
    {"label": "Team", "value": "team", "checked": false},
    {"label": "Channel", "value": "channel", "checked": false},
    {"label": "Priority", "value": "priority", "checked": false},
    {"label": "Category", "value": "category", "checked": false},
    {"label": "Status", "value": "status", "checked": false},
    {"label": "Customer Segment", "value": "customer_segment", "checked": false},
    {"label": "Product", "value": "product", "checked": false},
    {"label": "Region", "value": "region", "checked": false},
  ];

  List<Map<String, dynamic>> savedReports = [
    {
      "name": "Weekly Agent Performance",
      "template": "Agent Performance Report",
      "format": "PDF",
      "frequency": "Weekly",
      "lastGenerated": "2 days ago",
      "status": "active",
      "metrics": 5,
      "subscribers": 8
    },
    {
      "name": "Monthly Satisfaction Analysis",
      "template": "Customer Satisfaction Report",
      "format": "Excel",
      "frequency": "Monthly",
      "lastGenerated": "1 week ago",
      "status": "active",
      "metrics": 3,
      "subscribers": 12
    },
    {
      "name": "Daily Ticket Summary",
      "template": "Ticket Analysis Report",
      "format": "CSV",
      "frequency": "Daily",
      "lastGenerated": "6 hours ago",
      "status": "active",
      "metrics": 7,
      "subscribers": 5
    },
    {
      "name": "Quarterly SLA Report",
      "template": "SLA Compliance Report",
      "format": "PowerPoint",
      "frequency": "Quarterly",
      "lastGenerated": "2 months ago",
      "status": "paused",
      "metrics": 4,
      "subscribers": 15
    },
  ];

  void _generateReport() async {
    if (reportName.isEmpty) {
      se("Please enter a report name");
      return;
    }

    if (selectedMetrics.isEmpty) {
      se("Please select at least one metric");
      return;
    }

    showLoading();
    
    // Simulate report generation
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Custom report '${reportName}' generated successfully!");
    
    // Reset form
    setState(() {
      reportName = "";
      selectedTemplate = "";
      selectedMetrics = [];
      selectedFilters = [];
      startDate = null;
      endDate = null;
      includeCharts = true;
      includeRawData = false;
      autoSchedule = false;
    });
  }

  void _saveTemplate() async {
    if (reportName.isEmpty) {
      se("Please enter a report name");
      return;
    }

    showLoading();
    
    // Simulate saving template
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    ss("Report template saved successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Report builder help documentation");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Builder Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.build,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Report Builder",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Basic Information
                  QTextField(
                    label: "Report Name",
                    value: reportName,
                    hint: "Enter a descriptive name for your report",
                    onChanged: (value) {
                      reportName = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Start with Template",
                    items: reportTemplates,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Export Format",
                          items: formats,
                          value: selectedFormat,
                          onChanged: (value, label) {
                            selectedFormat = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Frequency",
                          items: frequencies,
                          value: selectedFrequency,
                          onChanged: (value, label) {
                            selectedFrequency = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Metrics Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Metrics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: availableMetrics,
                    value: availableMetrics
                        .where((metric) => selectedMetrics.contains(metric["value"]))
                        .toList(),
                    onChanged: (values, ids) {
                      selectedMetrics = values.map((v) => v["value"] as String).toList();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Filters Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apply Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: availableFilters,
                    value: availableFilters
                        .where((filter) => selectedFilters.contains(filter["value"]))
                        .toList(),
                    onChanged: (values, ids) {
                      selectedFilters = values.map((v) => v["value"] as String).toList();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Date Range Selection (if date filter is selected)
            if (selectedFilters.contains("date_range"))
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date Range",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Start Date",
                            value: startDate ?? DateTime.now().subtract(Duration(days: 30)),
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "End Date",
                            value: endDate ?? DateTime.now(),
                            onChanged: (value) {
                              endDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Report Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Include Charts and Visualizations",
                        "value": "charts",
                        "checked": includeCharts,
                      }
                    ],
                    value: includeCharts
                        ? [{"label": "Include Charts and Visualizations", "value": "charts", "checked": true}]
                        : [],
                    onChanged: (values, ids) {
                      includeCharts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Include Raw Data Tables",
                        "value": "raw_data",
                        "checked": includeRawData,
                      }
                    ],
                    value: includeRawData
                        ? [{"label": "Include Raw Data Tables", "value": "raw_data", "checked": true}]
                        : [],
                    onChanged: (values, ids) {
                      includeRawData = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (selectedFrequency != "One-time")
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-schedule Report Generation",
                          "value": "schedule",
                          "checked": autoSchedule,
                        }
                      ],
                      value: autoSchedule
                          ? [{"label": "Auto-schedule Report Generation", "value": "schedule", "checked": true}]
                          : [],
                      onChanged: (values, ids) {
                        autoSchedule = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.play_arrow,
                    size: bs.md,
                    onPressed: _generateReport,
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Template",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: _saveTemplate,
                  ),
                ),
              ],
            ),

            // Saved Reports Section
            Text(
              "Saved Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: savedReports.map((report) {
                  int index = savedReports.indexOf(report);
                  bool isActive = report["status"] == "active";

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < savedReports.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
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
                                        "${report["name"]}",
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
                                          color: isActive
                                              ? successColor.withAlpha(20)
                                              : warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${report["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: isActive ? successColor : warningColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${report["template"]} • ${report["format"]} • ${report["frequency"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Last generated: ${report["lastGenerated"]}",
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
                                Row(
                                  spacing: spXs,
                                  children: [
                                    QButton(
                                      icon: Icons.play_arrow,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Report '${report["name"]}' generated");
                                      },
                                    ),
                                    QButton(
                                      icon: Icons.edit,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Editing report '${report["name"]}'");
                                      },
                                    ),
                                    QButton(
                                      icon: isActive ? Icons.pause : Icons.play_arrow,
                                      size: bs.sm,
                                      onPressed: () {
                                        String action = isActive ? "paused" : "resumed";
                                        ss("Report '${report["name"]}' ${action}");
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${report["metrics"]} metrics • ${report["subscribers"]} subscribers",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

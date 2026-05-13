import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomReportsView extends StatefulWidget {
  const CmaCustomReportsView({super.key});

  @override
  State<CmaCustomReportsView> createState() => _CmaCustomReportsViewState();
}

class _CmaCustomReportsViewState extends State<CmaCustomReportsView> {
  String reportName = "";
  String description = "";
  String selectedCategory = "sales";
  String selectedTimeRange = "last_30_days";
  String selectedFormat = "pdf";
  bool includeCharts = true;
  bool includeDetails = true;
  bool scheduleReport = false;
  String scheduleFrequency = "weekly";
  List<String> selectedMetrics = [];
  List<String> selectedFilters = [];
  
  List<Map<String, dynamic>> availableMetrics = [
    {"label": "Total Revenue", "value": "total_revenue", "category": "financial"},
    {"label": "Number of Sales", "value": "sales_count", "category": "sales"},
    {"label": "Average Order Value", "value": "avg_order_value", "category": "financial"},
    {"label": "Customer Acquisition", "value": "customer_acquisition", "category": "customer"},
    {"label": "Customer Retention", "value": "customer_retention", "category": "customer"},
    {"label": "Lead Conversion Rate", "value": "lead_conversion", "category": "sales"},
    {"label": "Product Performance", "value": "product_performance", "category": "product"},
    {"label": "Sales by Region", "value": "sales_region", "category": "geographic"},
    {"label": "Team Performance", "value": "team_performance", "category": "team"},
    {"label": "Monthly Growth", "value": "monthly_growth", "category": "growth"},
  ];
  
  List<Map<String, dynamic>> availableFilters = [
    {"label": "Date Range", "value": "date_range", "type": "date"},
    {"label": "Sales Team", "value": "sales_team", "type": "select"},
    {"label": "Product Category", "value": "product_category", "type": "select"},
    {"label": "Customer Segment", "value": "customer_segment", "type": "select"},
    {"label": "Region", "value": "region", "type": "select"},
    {"label": "Deal Size", "value": "deal_size", "type": "range"},
    {"label": "Customer Type", "value": "customer_type", "type": "select"},
    {"label": "Lead Source", "value": "lead_source", "type": "select"},
  ];
  
  List<Map<String, dynamic>> savedReports = [
    {
      "id": "1",
      "name": "Monthly Sales Performance",
      "description": "Comprehensive monthly sales analysis with team breakdown",
      "category": "sales",
      "format": "pdf",
      "last_generated": "2024-01-15",
      "schedule": "monthly",
      "status": "active"
    },
    {
      "id": "2", 
      "name": "Customer Acquisition Report",
      "description": "Weekly customer acquisition and retention metrics",
      "category": "customer",
      "format": "excel",
      "last_generated": "2024-01-18",
      "schedule": "weekly",
      "status": "active"
    },
    {
      "id": "3",
      "name": "Revenue Analysis Q1",
      "description": "Quarterly revenue breakdown by product and region",
      "category": "financial",
      "format": "pdf",
      "last_generated": "2024-01-10",
      "schedule": "quarterly",
      "status": "paused"
    },
    {
      "id": "4",
      "name": "Lead Conversion Dashboard",
      "description": "Daily lead conversion tracking and funnel analysis",
      "category": "leads",
      "format": "dashboard",
      "last_generated": "2024-01-19",
      "schedule": "daily",
      "status": "active"
    },
  ];
  
  int selectedTab = 0;
  String searchQuery = "";
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Custom Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Create Report", icon: Icon(Icons.add_chart)),
        Tab(text: "Saved Reports", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        _buildCreateReportTab(),
        _buildSavedReportsTab(),
      ],
    );
  }
  
  Widget _buildCreateReportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportBasicsSection(),
          _buildMetricsSelectionSection(),
          _buildFiltersSection(),
          _buildOptionsSection(),
          _buildSchedulingSection(),
          _buildPreviewSection(),
          _buildCreateActions(),
        ],
      ),
    );
  }
  
  Widget _buildReportBasicsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Report Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Report Name",
            value: reportName,
            hint: "Enter a descriptive name for your report",
            onChanged: (value) {
              reportName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe what this report will analyze",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Report Category",
            items: [
              {"label": "Sales Reports", "value": "sales"},
              {"label": "Financial Reports", "value": "financial"},
              {"label": "Customer Reports", "value": "customer"},
              {"label": "Product Reports", "value": "product"},
              {"label": "Team Performance", "value": "team"},
              {"label": "Marketing Reports", "value": "marketing"},
            ],
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildMetricsSelectionSection() {
    List<Map<String, dynamic>> filteredMetrics = availableMetrics;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Metrics to Include",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${selectedMetrics.length} selected",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredMetrics.map((metric) {
            bool isSelected = selectedMetrics.contains(metric["value"]);
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
                color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? primaryColor : disabledBoldColor,
                  size: 20,
                ),
                title: Text(
                  "${metric["label"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : Colors.black87,
                  ),
                ),
                subtitle: Text(
                  "Category: ${metric["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                onTap: () {
                  if (isSelected) {
                    selectedMetrics.remove(metric["value"]);
                  } else {
                    selectedMetrics.add(metric["value"]);
                  }
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
  
  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Available Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${selectedFilters.length} selected",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...availableFilters.map((filter) {
            bool isSelected = selectedFilters.contains(filter["value"]);
            IconData typeIcon = filter["type"] == "date" ? Icons.date_range :
                               filter["type"] == "select" ? Icons.list :
                               Icons.tune;
            
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
                color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? primaryColor : disabledBoldColor,
                  size: 20,
                ),
                title: Text(
                  "${filter["label"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  typeIcon,
                  size: 16,
                  color: disabledBoldColor,
                ),
                onTap: () {
                  if (isSelected) {
                    selectedFilters.remove(filter["value"]);
                  } else {
                    selectedFilters.add(filter["value"]);
                  }
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
  
  Widget _buildOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
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
          QDropdownField(
            label: "Time Range",
            items: [
              {"label": "Last 7 Days", "value": "last_7_days"},
              {"label": "Last 30 Days", "value": "last_30_days"},
              {"label": "Last 3 Months", "value": "last_3_months"},
              {"label": "Last 6 Months", "value": "last_6_months"},
              {"label": "Last Year", "value": "last_year"},
              {"label": "Custom Range", "value": "custom"},
            ],
            value: selectedTimeRange,
            onChanged: (value, label) {
              selectedTimeRange = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Export Format",
            items: [
              {"label": "PDF Document", "value": "pdf"},
              {"label": "Excel Spreadsheet", "value": "excel"},
              {"label": "CSV File", "value": "csv"},
              {"label": "Interactive Dashboard", "value": "dashboard"},
            ],
            value: selectedFormat,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Charts",
                      "value": true,
                      "checked": includeCharts,
                    }
                  ],
                  value: [
                    if (includeCharts)
                      {"label": "Include Charts", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    includeCharts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Details",
                      "value": true,
                      "checked": includeDetails,
                    }
                  ],
                  value: [
                    if (includeDetails)
                      {"label": "Include Details", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    includeDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSchedulingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Report Scheduling",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Schedule Report",
                      "value": true,
                      "checked": scheduleReport,
                    }
                  ],
                  value: [
                    if (scheduleReport)
                      {"label": "Schedule Report", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    scheduleReport = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (scheduleReport)
            QDropdownField(
              label: "Frequency",
              items: [
                {"label": "Daily", "value": "daily"},
                {"label": "Weekly", "value": "weekly"},
                {"label": "Monthly", "value": "monthly"},
                {"label": "Quarterly", "value": "quarterly"},
              ],
              value: scheduleFrequency,
              onChanged: (value, label) {
                scheduleFrequency = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildPreviewSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Report Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Report: ${reportName.isEmpty ? 'Untitled Report' : reportName}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                Divider(height: spSm),
                Text(
                  "Metrics: ${selectedMetrics.length} selected",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Filters: ${selectedFilters.length} selected",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Format: ${selectedFormat.toUpperCase()}",
                  style: TextStyle(fontSize: 12),
                ),
                if (scheduleReport)
                  Text(
                    "Schedule: ${scheduleFrequency}",
                    style: TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCreateActions() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Generate Preview",
                icon: Icons.visibility,
                size: bs.md,
                onPressed: () {
                  ss("Report preview generated successfully");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Save Template",
                icon: Icons.save,
                size: bs.md,
                onPressed: () {
                  if (reportName.isEmpty) {
                    se("Please enter a report name");
                    return;
                  }
                  ss("Report template saved successfully");
                },
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Report",
            icon: Icons.add_chart,
            size: bs.md,
            onPressed: () {
              if (reportName.isEmpty) {
                se("Please enter a report name");
                return;
              }
              if (selectedMetrics.isEmpty) {
                se("Please select at least one metric");
                return;
              }
              ss("Custom report created successfully");
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildSavedReportsTab() {
    List<Map<String, dynamic>> filteredReports = savedReports.where((report) {
      return "${report["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${report["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildReportsGrid(filteredReports),
        ],
      ),
    );
  }
  
  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Reports",
                  value: searchQuery,
                  hint: "Search by name or description",
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
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${savedReports.length} saved reports",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Report",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  selectedTab = 0;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildReportsGrid(List<Map<String, dynamic>> reports) {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: reports.map((report) {
        Color statusColor = report["status"] == "active" ? successColor :
                           report["status"] == "paused" ? warningColor : disabledBoldColor;
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(width: 4, color: statusColor),
            ),
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${report["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${report["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.category, size: 14, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${report["category"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.insert_drive_file, size: 14, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${report["format"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Divider(height: spSm),
              Row(
                children: [
                  Text(
                    "Last Generated:",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${report["last_generated"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Schedule:",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${report["schedule"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Generate",
                      icon: Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {
                        ss("Report generation started");
                      },
                    ),
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () => _showReportActions(report),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Reports"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Filter options coming soon..."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
  
  void _showReportActions(Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${report["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Report"),
              onTap: () {
                Navigator.pop(context);
                ss("Edit functionality coming soon");
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate Report"),
              onTap: () {
                Navigator.pop(context);
                ss("Report duplicated successfully");
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Download Latest"),
              onTap: () {
                Navigator.pop(context);
                ss("Download started");
              },
            ),
            ListTile(
              leading: Icon(
                report["status"] == "active" ? Icons.pause : Icons.play_arrow,
                color: report["status"] == "active" ? warningColor : successColor,
              ),
              title: Text(report["status"] == "active" ? "Pause Schedule" : "Resume Schedule"),
              onTap: () {
                Navigator.pop(context);
                String action = report["status"] == "active" ? "paused" : "resumed";
                ss("Report schedule $action");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Report"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this report?");
                if (isConfirmed) {
                  ss("Report deleted successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

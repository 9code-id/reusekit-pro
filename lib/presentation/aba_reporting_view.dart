import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaReportingView extends StatefulWidget {
  const AbaReportingView({super.key});

  @override
  State<AbaReportingView> createState() => _AbaReportingViewState();
}

class _AbaReportingViewState extends State<AbaReportingView> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedDepartment = "all";
  bool loading = false;

  List<Map<String, dynamic>> reportPeriods = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Operations", "value": "operations"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> reportTypes = [
    {
      "title": "Financial Reports",
      "description": "Comprehensive financial analysis and statements",
      "icon": Icons.account_balance,
      "color": Colors.blue,
      "reports": [
        {"name": "Profit & Loss", "type": "profit_loss"},
        {"name": "Balance Sheet", "type": "balance_sheet"},
        {"name": "Cash Flow", "type": "cash_flow"},
        {"name": "Budget Analysis", "type": "budget_analysis"},
      ]
    },
    {
      "title": "Tax Reports",
      "description": "Tax compliance and submission reports",
      "icon": Icons.receipt_long,
      "color": Colors.orange,
      "reports": [
        {"name": "Sales Tax Report", "type": "sales_tax"},
        {"name": "Income Tax Report", "type": "income_tax"},
        {"name": "Payroll Tax Report", "type": "payroll_tax"},
        {"name": "Tax Reconciliation", "type": "tax_reconciliation"},
      ]
    },
    {
      "title": "Operational Reports",
      "description": "Day-to-day operational metrics and KPIs",
      "icon": Icons.trending_up,
      "color": Colors.green,
      "reports": [
        {"name": "Sales Performance", "type": "sales_performance"},
        {"name": "Inventory Report", "type": "inventory"},
        {"name": "Customer Analytics", "type": "customer_analytics"},
        {"name": "Employee Performance", "type": "employee_performance"},
      ]
    },
    {
      "title": "Compliance Reports",
      "description": "Regulatory and compliance documentation",
      "icon": Icons.gavel,
      "color": Colors.purple,
      "reports": [
        {"name": "Audit Trail", "type": "audit_trail"},
        {"name": "Regulatory Compliance", "type": "regulatory"},
        {"name": "Risk Assessment", "type": "risk_assessment"},
        {"name": "Internal Controls", "type": "internal_controls"},
      ]
    },
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "name": "Monthly Financial Summary",
      "type": "Financial",
      "generatedDate": "2024-06-15",
      "status": "completed",
      "size": "2.4 MB",
    },
    {
      "name": "Q2 Sales Tax Report",
      "type": "Tax",
      "generatedDate": "2024-06-14",
      "status": "completed",
      "size": "1.8 MB",
    },
    {
      "name": "Weekly Operations Report",
      "type": "Operations",
      "generatedDate": "2024-06-13",
      "status": "processing",
      "size": "3.1 MB",
    },
    {
      "name": "Annual Compliance Review",
      "type": "Compliance",
      "generatedDate": "2024-06-12",
      "status": "failed",
      "size": "4.2 MB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reporting Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Generate", icon: Icon(Icons.add_chart)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildGenerateTab(),
        _buildRecentTab(),
        _buildScheduledTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialization if needed
      },
    );
  }

  Widget _buildGenerateTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReportFilters(),
                _buildReportCategories(),
              ],
            ),
          );
  }

  Widget _buildReportFilters() {
    return Container(
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
            "Report Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Report Period",
                  items: reportPeriods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departments,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
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

  Widget _buildReportCategories() {
    return Column(
      spacing: spMd,
      children: reportTypes.map((category) => _buildReportCategory(category)).toList(),
    );
  }

  Widget _buildReportCategory(Map<String, dynamic> category) {
    return Container(
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  category["icon"] as IconData,
                  color: category["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          ResponsiveGridView(
            minItemWidth: 250,
            children: (category["reports"] as List).map((report) => 
              _buildReportItem(report, category["color"] as Color)
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(Map<String, dynamic> report, Color categoryColor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${report["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          QButton(
            label: "Generate",
            size: bs.sm,
            onPressed: () => _generateReport(report["type"], report["name"]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentReports.map((report) => _buildRecentReportItem(report)),
        ],
      ),
    );
  }

  Widget _buildRecentReportItem(Map<String, dynamic> report) {
    Color statusColor = _getStatusColor(report["status"]);
    IconData statusIcon = _getStatusIcon(report["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${report["type"]} • ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${report["generatedDate"]} • ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${report["size"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${report["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (report["status"] == "completed") ...[
                    GestureDetector(
                      onTap: () => _downloadReport(report),
                      child: Icon(
                        Icons.download,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spXs),
                  ],
                  GestureDetector(
                    onTap: () => _shareReport(report),
                    child: Icon(
                      Icons.share,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ],
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
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Scheduled reports will be automatically generated and delivered to designated recipients.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Create Scheduled Report",
            icon: Icons.add_alarm,
            size: bs.md,
            onPressed: () => _createScheduledReport(),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "processing":
        return Icons.hourglass_empty;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  void _generateReport(String reportType, String reportName) async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("$reportName generated successfully");
  }

  void _downloadReport(Map<String, dynamic> report) async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("${report["name"]} downloaded successfully");
  }

  void _shareReport(Map<String, dynamic> report) async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("${report["name"]} shared successfully");
  }

  void _createScheduledReport() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Scheduled report created successfully");
  }
}

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmCustomReportsView extends StatefulWidget {
  const IwmCustomReportsView({super.key});

  @override
  State<IwmCustomReportsView> createState() => _IwmCustomReportsViewState();
}

class _IwmCustomReportsViewState extends State<IwmCustomReportsView> {
  int selectedTab = 0;
  String selectedReportType = "inventory";
  String selectedPeriod = "month";
  String selectedWarehouse = "all";
  bool loading = false;
  
  List<Map<String, dynamic>> reportTypes = [
    {"label": "Inventory Report", "value": "inventory"},
    {"label": "Movement Report", "value": "movement"},
    {"label": "Valuation Report", "value": "valuation"},
    {"label": "ABC Analysis", "value": "abc"},
    {"label": "Stock Aging", "value": "aging"},
  ];
  
  List<Map<String, dynamic>> timePeriods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
    {"label": "Custom Range", "value": "custom"},
  ];
  
  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Distribution Center", "value": "dist"},
    {"label": "Retail Store", "value": "retail"},
  ];
  
  List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Monthly Inventory Summary",
      "type": "Inventory",
      "description": "Complete inventory status with stock levels and valuation",
      "lastGenerated": "2024-01-15",
      "frequency": "Monthly",
      "format": "PDF",
      "recipients": 5,
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "name": "Stock Movement Analysis",
      "type": "Movement",
      "description": "Track all inventory movements including receipts and issues",
      "lastGenerated": "2024-01-14",
      "frequency": "Weekly",
      "format": "Excel",
      "recipients": 3,
      "icon": Icons.swap_horiz,
      "color": successColor
    },
    {
      "name": "ABC Classification Report",
      "type": "Analysis",
      "description": "Items categorized by value and movement frequency",
      "lastGenerated": "2024-01-10",
      "frequency": "Quarterly",
      "format": "PDF",
      "recipients": 8,
      "icon": Icons.analytics,
      "color": infoColor
    },
    {
      "name": "Stock Aging Report",
      "type": "Aging",
      "description": "Identify slow-moving and obsolete inventory",
      "lastGenerated": "2024-01-12",
      "frequency": "Monthly",
      "format": "Excel",
      "recipients": 4,
      "icon": Icons.schedule,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> recentReports = [
    {
      "name": "Inventory Valuation - January 2024",
      "type": "Valuation",
      "generatedDate": "2024-01-15 14:30",
      "generatedBy": "John Smith",
      "format": "PDF",
      "size": "2.4 MB",
      "downloads": 12,
      "status": "Ready"
    },
    {
      "name": "Stock Movement - Week 2",
      "type": "Movement",
      "generatedDate": "2024-01-14 09:15",
      "generatedBy": "Sarah Johnson",
      "format": "Excel",
      "size": "1.8 MB",
      "downloads": 8,
      "status": "Ready"
    },
    {
      "name": "ABC Analysis - Q4 2023",
      "type": "Analysis",
      "generatedDate": "2024-01-10 16:45",
      "generatedBy": "Mike Chen",
      "format": "PDF",
      "size": "3.2 MB",
      "downloads": 15,
      "status": "Ready"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Custom Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Generate", icon: Icon(Icons.add_chart)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildTemplatesTab(),
        _buildGenerateTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplateFilters(),
          _buildQuickStats(),
          _buildReportTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildGenerateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportBuilder(),
          _buildPreviewSection(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryFilters(),
          _buildRecentReportsList(),
        ],
      ),
    );
  }

  Widget _buildTemplateFilters() {
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
              label: "Report Type",
              items: reportTypes,
              value: selectedReportType,
              onChanged: (value, label) {
                selectedReportType = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            label: "New Template",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Total Templates", "value": "12", "icon": Icons.description, "color": primaryColor},
      {"title": "Active Reports", "value": "8", "icon": Icons.trending_up, "color": successColor},
      {"title": "Scheduled", "value": "5", "icon": Icons.schedule, "color": infoColor},
      {"title": "This Month", "value": "24", "icon": Icons.calendar_month, "color": warningColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportTemplatesList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Report Templates",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...reportTemplates.map((template) => _buildTemplateCard(template)),
      ],
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (template["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  template["icon"],
                  color: template["color"],
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      "${template["type"]} • ${template["frequency"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "${template["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${template["recipients"]} recipients",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.file_present, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${template["format"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Last: ${template["lastGenerated"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              QButton(
                label: "Generate",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportBuilder() {
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
          Text(
            "Report Builder",
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
                  label: "Report Type",
                  items: reportTypes,
                  value: selectedReportType,
                  onChanged: (value, label) {
                    selectedReportType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: timePeriods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Warehouse",
            items: warehouses,
            value: selectedWarehouse,
            onChanged: (value, label) {
              selectedWarehouse = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Preview Report",
                  size: bs.md,
                  onPressed: () => _previewReport(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  size: bs.md,
                  onPressed: () => _generateReport(),
                ),
              ),
            ],
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
          Text(
            "Report Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.preview,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Report Preview",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Select report parameters and click Preview",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
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
              label: "Period",
              items: timePeriods,
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
              label: "Report Type",
              items: reportTypes,
              value: selectedReportType,
              onChanged: (value, label) {
                selectedReportType = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReportsList() {
    return Column(
      spacing: spSm,
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
        ...recentReports.map((report) => _buildReportHistoryCard(report)),
      ],
    );
  }

  Widget _buildReportHistoryCard(Map<String, dynamic> report) {
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
              Container(
                padding: EdgeInsets.all(spXs),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${report["type"]} • ${report["format"]}",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${report["status"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${report["generatedBy"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.access_time, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${report["generatedDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "${report["size"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.download, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${report["downloads"]} downloads",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Download",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
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

  void _previewReport() {
    loading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Report preview generated successfully");
    });
  }

  void _generateReport() {
    loading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 3), () {
      loading = false;
      setState(() {});
      ss("Report generated and ready for download");
    });
  }
}

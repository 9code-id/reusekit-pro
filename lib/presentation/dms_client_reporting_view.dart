import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsClientReportingView extends StatefulWidget {
  const DmsClientReportingView({super.key});

  @override
  State<DmsClientReportingView> createState() => _DmsClientReportingViewState();
}

class _DmsClientReportingViewState extends State<DmsClientReportingView> {
  String selectedPeriod = "monthly";
  String selectedClient = "all";
  String selectedMetric = "overview";
  bool loading = false;

  List<Map<String, dynamic>> clients = [
    {"label": "All Clients", "value": "all"},
    {"label": "TechCorp Solutions", "value": "1"},
    {"label": "Global Marketing Inc", "value": "2"},
    {"label": "StartupXYZ", "value": "3"},
    {"label": "Enterprise Corp", "value": "4"},
  ];

  List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      "title": "Q2 Performance Report",
      "client": "TechCorp Solutions",
      "type": "Performance",
      "period": "Q2 2024",
      "generatedDate": "2024-06-19",
      "status": "completed",
      "metrics": {
        "revenue": 125000,
        "projects": 8,
        "satisfaction": 4.8,
        "growth": 15.5,
      },
    },
    {
      "id": 2,
      "title": "Monthly Analytics",
      "client": "Global Marketing Inc",
      "type": "Analytics",
      "period": "June 2024",
      "generatedDate": "2024-06-18",
      "status": "completed",
      "metrics": {
        "revenue": 78000,
        "projects": 5,
        "satisfaction": 4.5,
        "growth": 8.2,
      },
    },
    {
      "id": 3,
      "title": "Project Summary",
      "client": "StartupXYZ",
      "type": "Project",
      "period": "May 2024",
      "generatedDate": "2024-06-17",
      "status": "pending",
      "metrics": {
        "revenue": 25000,
        "projects": 2,
        "satisfaction": 4.2,
        "growth": -2.1,
      },
    },
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "Total Revenue",
      "value": 328000,
      "change": 12.5,
      "icon": Icons.attach_money,
      "color": successColor,
      "format": "currency",
    },
    {
      "title": "Active Projects",
      "value": 23,
      "change": 8.7,
      "icon": Icons.work,
      "color": primaryColor,
      "format": "number",
    },
    {
      "title": "Client Satisfaction",
      "value": 4.6,
      "change": 3.2,
      "icon": Icons.star,
      "color": warningColor,
      "format": "rating",
    },
    {
      "title": "Growth Rate",
      "value": 15.8,
      "change": 5.3,
      "icon": Icons.trending_up,
      "color": infoColor,
      "format": "percentage",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Reporting"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportReports(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReportFilters(),
                  SizedBox(height: spLg),
                  _buildKPIOverview(),
                  SizedBox(height: spLg),
                  _buildPerformanceCharts(),
                  SizedBox(height: spLg),
                  _buildReportsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildReportFilters() {
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
            "Report Filters",
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
                child: QDropdownField(
                  label: "Time Period",
                  items: [
                    {"label": "Weekly", "value": "weekly"},
                    {"label": "Monthly", "value": "monthly"},
                    {"label": "Quarterly", "value": "quarterly"},
                    {"label": "Yearly", "value": "yearly"},
                  ],
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
                  label: "Client",
                  items: clients,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: [
              {"label": "Overview", "value": "overview"},
              {"label": "Revenue", "value": "revenue"},
              {"label": "Projects", "value": "projects"},
              {"label": "Performance", "value": "performance"},
              {"label": "Satisfaction", "value": "satisfaction"},
            ],
            value: selectedMetric,
            onChanged: (index, label, value, item) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKPIOverview() {
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
            "Key Performance Indicators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: kpiData.map((kpi) => _buildKPICard(kpi)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(Map<String, dynamic> kpi) {
    String formattedValue;
    switch (kpi["format"]) {
      case "currency":
        formattedValue = "\$${((kpi["value"] as num) / 1000).toStringAsFixed(0)}K";
        break;
      case "percentage":
        formattedValue = "${(kpi["value"] as num).toStringAsFixed(1)}%";
        break;
      case "rating":
        formattedValue = "${(kpi["value"] as num).toStringAsFixed(1)}";
        break;
      default:
        formattedValue = "${kpi["value"]}";
    }

    final isPositive = (kpi["change"] as num) >= 0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: kpi["color"].withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: kpi["color"].withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                kpi["icon"],
                color: kpi["color"],
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive 
                      ? successColor.withAlpha(20) 
                      : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${isPositive ? '+' : ''}${(kpi["change"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            formattedValue,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kpi["color"],
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${kpi["title"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCharts() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Performance Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () => _viewFullChart(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                    color: primaryColor.withAlpha(50),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Revenue Trend Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive chart showing revenue performance over time",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildMiniChart("Client Growth", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildMiniChart("Project Completion", Icons.check_circle, primaryColor),
              SizedBox(width: spSm),
              _buildMiniChart("Satisfaction Score", Icons.star, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniChart(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsList() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Generated Reports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _generateNewReport(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...reports.map((report) => _buildReportCard(report)).toList(),
        ],
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    final metrics = report["metrics"] as Map<String, dynamic>;
    final isCompleted = report["status"] == "completed";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${report["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${report["client"]} • ${report["period"]}",
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
                  color: isCompleted 
                      ? successColor.withAlpha(20) 
                      : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${report["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildMetricItem("Revenue", "\$${((metrics["revenue"] as num) / 1000).toStringAsFixed(0)}K", successColor),
              SizedBox(width: spSm),
              _buildMetricItem("Projects", "${metrics["projects"]}", primaryColor),
              SizedBox(width: spSm),
              _buildMetricItem("Rating", "${metrics["satisfaction"]}", warningColor),
              SizedBox(width: spSm),
              _buildMetricItem("Growth", "${(metrics["growth"] as num) >= 0 ? '+' : ''}${(metrics["growth"] as num).toStringAsFixed(1)}%", 
                  (metrics["growth"] as num) >= 0 ? successColor : dangerColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Generated: ${report["generatedDate"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () => _viewReport(report),
                  ),
                  SizedBox(width: spXs),
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
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exportReports() {
    ss("Exporting all reports...");
  }

  void _viewFullChart() {
    // navigateTo('FullChartView')
  }

  void _generateNewReport() {
    // navigateTo('GenerateReportView')
  }

  void _viewReport(Map<String, dynamic> report) {
    // navigateTo('ReportDetailView')
  }

  void _downloadReport(Map<String, dynamic> report) {
    ss("Downloading ${report["title"]}...");
  }

  void _shareReport(Map<String, dynamic> report) {
    ss("Sharing ${report["title"]}...");
  }
}

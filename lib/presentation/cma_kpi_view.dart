import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaKpiView extends StatefulWidget {
  const CmaKpiView({super.key});

  @override
  State<CmaKpiView> createState() => _CmaKpiViewState();
}

class _CmaKpiViewState extends State<CmaKpiView> {
  String selectedPeriod = "This Month";
  String selectedDepartment = "All Departments";
  bool loading = false;

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "Revenue Growth",
      "value": 25.4,
      "target": 30.0,
      "trend": "up",
      "color": successColor,
      "icon": Icons.trending_up,
      "unit": "%"
    },
    {
      "title": "Customer Satisfaction",
      "value": 4.8,
      "target": 4.5,
      "trend": "up",
      "color": primaryColor,
      "icon": Icons.star,
      "unit": "/5"
    },
    {
      "title": "Employee Productivity",
      "value": 87.2,
      "target": 85.0,
      "trend": "up",
      "color": infoColor,
      "icon": Icons.people,
      "unit": "%"
    },
    {
      "title": "Cost Reduction",
      "value": 12.3,
      "target": 15.0,
      "trend": "down",
      "color": warningColor,
      "icon": Icons.money_off,
      "unit": "%"
    },
    {
      "title": "Market Share",
      "value": 18.5,
      "target": 20.0,
      "trend": "down",
      "color": dangerColor,
      "icon": Icons.pie_chart,
      "unit": "%"
    },
    {
      "title": "Innovation Index",
      "value": 73.6,
      "target": 75.0,
      "trend": "up",
      "color": secondaryColor,
      "icon": Icons.lightbulb,
      "unit": "%"
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Last Quarter", "value": "Last Quarter"}
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Finance", "value": "Finance"},
    {"label": "HR", "value": "HR"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KPI Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildFilters(),
                  _buildSummaryCards(),
                  _buildKpiGrid(),
                  _buildTrendAnalysis(),
                  _buildActionItems(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
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
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _filterKpis();
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    _filterKpis();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    int totalKpis = kpiData.length;
    int onTrack = kpiData.where((kpi) => (kpi["value"] as double) >= (kpi["target"] as double)).length;
    int atRisk = totalKpis - onTrack;
    double avgPerformance = (kpiData.map((kpi) => (kpi["value"] as double) / (kpi["target"] as double) * 100).reduce((a, b) => a + b)) / totalKpis;

    return Row(
      spacing: spSm,
      children: [
        _buildSummaryCard("Total KPIs", totalKpis.toString(), Icons.dashboard, primaryColor),
        _buildSummaryCard("On Track", onTrack.toString(), Icons.check_circle, successColor),
        _buildSummaryCard("At Risk", atRisk.toString(), Icons.warning, warningColor),
        _buildSummaryCard("Avg Performance", "${avgPerformance.toStringAsFixed(1)}%", Icons.trending_up, infoColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(icon, color: color, size: 24),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiGrid() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.assessment, color: primaryColor),
            SizedBox(width: spSm),
            Text(
              "Key Performance Indicators",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: kpiData.map((kpi) => _buildKpiCard(kpi)).toList(),
        ),
      ],
    );
  }

  Widget _buildKpiCard(Map<String, dynamic> kpi) {
    double value = kpi["value"] as double;
    double target = kpi["target"] as double;
    double percentage = (value / target) * 100;
    bool isOnTrack = value >= target;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: kpi["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                kpi["icon"] as IconData,
                color: kpi["color"] as Color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${kpi["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Icon(
                kpi["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                color: kpi["trend"] == "up" ? successColor : dangerColor,
                size: 16,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "${value.toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kpi["color"] as Color,
                ),
              ),
              Text(
                "${kpi["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Target: ${target.toStringAsFixed(1)}${kpi["unit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isOnTrack ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${percentage.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isOnTrack ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXs),
              color: disabledColor,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (percentage / 100).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusXs),
                  color: kpi["color"] as Color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
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
              Icon(Icons.timeline, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Trend Analysis",
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
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "Improving",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "${kpiData.where((kpi) => kpi["trend"] == "up").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "Declining",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "${kpiData.where((kpi) => kpi["trend"] == "down").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItems() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "Review Cost Reduction Strategy",
        "description": "Current performance is below target",
        "priority": "High",
        "kpi": "Cost Reduction"
      },
      {
        "title": "Analyze Market Share Decline",
        "description": "Investigate competitive factors",
        "priority": "High",
        "kpi": "Market Share"
      },
      {
        "title": "Boost Innovation Initiatives",
        "description": "Close to target but needs improvement",
        "priority": "Medium",
        "kpi": "Innovation Index"
      }
    ];

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
              Icon(Icons.assignment, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Recommended Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...actions.map((action) => _buildActionItem(action)),
        ],
      ),
    );
  }

  Widget _buildActionItem(Map<String, dynamic> action) {
    Color priorityColor = action["priority"] == "High" ? dangerColor : action["priority"] == "Medium" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${action["title"]}",
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
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${action["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${action["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Related to: ${action["kpi"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: disabledBoldColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  void _refreshData() {
    loading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Data refreshed successfully");
    });
  }

  void _filterKpis() {
    setState(() {});
  }
}

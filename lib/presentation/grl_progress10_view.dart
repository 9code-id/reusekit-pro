import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress10View extends StatefulWidget {
  @override
  State<GrlProgress10View> createState() => _GrlProgress10ViewState();
}

class _GrlProgress10ViewState extends State<GrlProgress10View> {
  String selectedMetric = "revenue";
  String selectedPeriod = "monthly";

  List<Map<String, dynamic>> metrics = [
    {"label": "Revenue", "value": "revenue"},
    {"label": "Sales", "value": "sales"},
    {"label": "Users", "value": "users"},
    {"label": "Performance", "value": "performance"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  Map<String, Map<String, List<Map<String, dynamic>>>> analyticsData = {
    "revenue": {
      "weekly": [
        {"period": "Week 1", "current": 25000, "target": 30000, "previous": 22000},
        {"period": "Week 2", "current": 28000, "target": 30000, "previous": 24000},
        {"period": "Week 3", "current": 32000, "target": 30000, "previous": 26000},
        {"period": "Week 4", "current": 29000, "target": 30000, "previous": 25000},
      ],
      "monthly": [
        {"period": "Jan", "current": 120000, "target": 150000, "previous": 110000},
        {"period": "Feb", "current": 135000, "target": 150000, "previous": 125000},
        {"period": "Mar", "current": 145000, "target": 150000, "previous": 130000},
        {"period": "Apr", "current": 160000, "target": 150000, "previous": 140000},
      ],
      "quarterly": [
        {"period": "Q1", "current": 400000, "target": 450000, "previous": 365000},
        {"period": "Q2", "current": 480000, "target": 450000, "previous": 420000},
        {"period": "Q3", "current": 520000, "target": 450000, "previous": 460000},
        {"period": "Q4", "current": 550000, "target": 450000, "previous": 490000},
      ],
      "yearly": [
        {"period": "2021", "current": 1800000, "target": 2000000, "previous": 1650000},
        {"period": "2022", "current": 2100000, "target": 2000000, "previous": 1800000},
        {"period": "2023", "current": 2350000, "target": 2000000, "previous": 2100000},
        {"period": "2024", "current": 1950000, "target": 2500000, "previous": 2350000},
      ],
    },
    "sales": {
      "weekly": [
        {"period": "Week 1", "current": 450, "target": 500, "previous": 420},
        {"period": "Week 2", "current": 480, "target": 500, "previous": 450},
        {"period": "Week 3", "current": 520, "target": 500, "previous": 470},
        {"period": "Week 4", "current": 495, "target": 500, "previous": 480},
      ],
      "monthly": [
        {"period": "Jan", "current": 1850, "target": 2000, "previous": 1700},
        {"period": "Feb", "current": 1920, "target": 2000, "previous": 1850},
        {"period": "Mar", "current": 2100, "target": 2000, "previous": 1920},
        {"period": "Apr", "current": 2250, "target": 2000, "previous": 2100},
      ],
    },
    "users": {
      "weekly": [
        {"period": "Week 1", "current": 12500, "target": 15000, "previous": 11200},
        {"period": "Week 2", "current": 13800, "target": 15000, "previous": 12500},
        {"period": "Week 3", "current": 14200, "target": 15000, "previous": 13800},
        {"period": "Week 4", "current": 15500, "target": 15000, "previous": 14200},
      ],
      "monthly": [
        {"period": "Jan", "current": 58000, "target": 60000, "previous": 52000},
        {"period": "Feb", "current": 62000, "target": 60000, "previous": 58000},
        {"period": "Mar", "current": 68000, "target": 60000, "previous": 62000},
        {"period": "Apr", "current": 72000, "target": 60000, "previous": 68000},
      ],
    },
    "performance": {
      "weekly": [
        {"period": "Week 1", "current": 85, "target": 90, "previous": 82},
        {"period": "Week 2", "current": 88, "target": 90, "previous": 85},
        {"period": "Week 3", "current": 92, "target": 90, "previous": 88},
        {"period": "Week 4", "current": 89, "target": 90, "previous": 92},
      ],
      "monthly": [
        {"period": "Jan", "current": 86, "target": 90, "previous": 83},
        {"period": "Feb", "current": 89, "target": 90, "previous": 86},
        {"period": "Mar", "current": 93, "target": 90, "previous": 89},
        {"period": "Apr", "current": 91, "target": 90, "previous": 93},
      ],
    },
  };

  List<Map<String, dynamic>> kpiCards = [
    {
      "title": "Total Revenue",
      "value": "2.4M",
      "change": 12.5,
      "icon": Icons.attach_money,
      "color": successColor,
      "subtitle": "vs last month"
    },
    {
      "title": "Active Users",
      "value": "72K",
      "change": 8.3,
      "icon": Icons.people,
      "color": infoColor,
      "subtitle": "monthly active"
    },
    {
      "title": "Conversion Rate",
      "value": "3.8%",
      "change": -2.1,
      "icon": Icons.trending_up,
      "color": warningColor,
      "subtitle": "needs attention"
    },
    {
      "title": "Performance Score",
      "value": "91",
      "change": 5.2,
      "icon": Icons.speed,
      "color": primaryColor,
      "subtitle": "overall rating"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = analyticsData[selectedMetric]?[selectedPeriod] ?? [];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // KPI Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: kpiCards.map((kpi) => _buildKPICard(kpi)).toList(),
            ),

            // Main Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${selectedMetric.toUpperCase()} ANALYSIS",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedPeriod.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Container(
                    height: 250,
                    child: _buildAnalyticsChart(currentData),
                  ),
                ],
              ),
            ),

            // Performance Metrics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Performance Indicators",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: List.generate(
                      currentData.length,
                      (index) => _buildPerformanceBar(currentData[index]),
                    ),
                  ),
                ],
              ),
            ),

            // Comparison Table
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Detailed Comparison",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Period")),
                        DataColumn(label: Text("Current")),
                        DataColumn(label: Text("Target")),
                        DataColumn(label: Text("Previous")),
                        DataColumn(label: Text("Growth")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: currentData.map((data) {
                        final current = data["current"] as num;
                        final previous = data["previous"] as num;
                        final target = data["target"] as num;
                        final growth = ((current - previous) / previous * 100);
                        final status = current >= target ? "On Target" : "Below Target";
                        
                        return DataRow(
                          cells: [
                            DataCell(Text("${data["period"]}")),
                            DataCell(Text(_formatValue(current))),
                            DataCell(Text(_formatValue(target))),
                            DataCell(Text(_formatValue(previous))),
                            DataCell(
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: growth >= 0 ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: growth >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: current >= target ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: current >= target ? successColor : warningColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Insights and Recommendations
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.insights,
                    size: 48,
                    color: Colors.white,
                  ),
                  Text(
                    "AI Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _getInsightText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Recommendations",
                          icon: Icons.auto_awesome,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          icon: Icons.file_download,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(Map<String, dynamic> kpi) {
    final change = kpi["change"] as num;
    final isPositive = change >= 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (kpi["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  kpi["icon"],
                  color: kpi["color"],
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: isPositive ? successColor : dangerColor,
                    ),
                    Text(
                      "${change.abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Text(
            "${kpi["value"]}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kpi["color"],
            ),
          ),
          
          Text(
            "${kpi["title"]}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          
          Text(
            "${kpi["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsChart(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return Container();
    
    final maxValue = data.map((d) => [d["current"], d["target"], d["previous"]]).expand((x) => x).reduce((a, b) => a > b ? a : b);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spMd,
            children: [
              _buildLegendItem("Current", primaryColor),
              _buildLegendItem("Target", warningColor),
              _buildLegendItem("Previous", successColor),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Chart
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(data.length, (index) {
                final item = data[index];
                final current = item["current"] as num;
                final target = item["target"] as num;
                final previous = item["previous"] as num;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 12,
                            height: (current / maxValue * 150).toDouble(),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 2),
                          Container(
                            width: 12,
                            height: (target / maxValue * 150).toDouble(),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 2),
                          Container(
                            width: 12,
                            height: (previous / maxValue * 150).toDouble(),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["period"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceBar(Map<String, dynamic> data) {
    final current = data["current"] as num;
    final target = data["target"] as num;
    final progress = (current / target * 100).clamp(0.0, 120.0);
    final isOverTarget = current > target;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data["period"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    _formatValue(current),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isOverTarget ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    " / ${_formatValue(target)}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              isOverTarget ? successColor : primaryColor,
            ),
            minHeight: 8,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${progress.toStringAsFixed(1)}% of target",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (isOverTarget)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "EXCEEDED",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatValue(num value) {
    if (selectedMetric == "revenue") {
      if (value >= 1000000) {
        return "\$${(value / 1000000).toStringAsFixed(1)}M";
      } else if (value >= 1000) {
        return "\$${(value / 1000).toStringAsFixed(0)}K";
      } else {
        return "\$${value.toStringAsFixed(0)}";
      }
    } else if (selectedMetric == "users") {
      if (value >= 1000) {
        return "${(value / 1000).toStringAsFixed(0)}K";
      } else {
        return "${value.toStringAsFixed(0)}";
      }
    } else if (selectedMetric == "performance") {
      return "${value.toStringAsFixed(1)}%";
    } else {
      return "${value.toStringAsFixed(0)}";
    }
  }

  String _getInsightText() {
    switch (selectedMetric) {
      case "revenue":
        return "Revenue shows strong growth trend with 12.5% increase. Consider scaling successful campaigns to maintain momentum.";
      case "sales":
        return "Sales conversion is performing well. Focus on lead quality to improve conversion rates further.";
      case "users":
        return "User acquisition is trending upward. Engagement metrics suggest good retention potential.";
      case "performance":
        return "Performance metrics are above target. Maintain current strategies and monitor for consistency.";
      default:
        return "Data analysis shows positive trends. Continue monitoring key metrics for optimization opportunities.";
    }
  }
}

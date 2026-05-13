import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaEfficiencyReportView extends StatefulWidget {
  const DlaEfficiencyReportView({super.key});

  @override
  State<DlaEfficiencyReportView> createState() => _DlaEfficiencyReportViewState();
}

class _DlaEfficiencyReportViewState extends State<DlaEfficiencyReportView> {
  String selectedPeriod = "this_month";
  String selectedMetric = "overall";
  
  final List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "This Quarter", "value": "this_quarter"},
    {"label": "This Year", "value": "this_year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  final List<Map<String, dynamic>> metricOptions = [
    {"label": "Overall Efficiency", "value": "overall"},
    {"label": "Delivery Performance", "value": "delivery"},
    {"label": "Warehouse Operations", "value": "warehouse"},
    {"label": "Route Optimization", "value": "route"},
    {"label": "Resource Utilization", "value": "resource"},
  ];

  final List<Map<String, dynamic>> efficiencyData = [
    {
      "category": "Delivery Performance",
      "current": 94.2,
      "previous": 91.8,
      "target": 95.0,
      "trend": "up",
      "icon": Icons.local_shipping,
    },
    {
      "category": "Warehouse Operations",
      "current": 88.7,
      "previous": 90.1,
      "target": 92.0,
      "trend": "down",
      "icon": Icons.inventory,
    },
    {
      "category": "Route Optimization",
      "current": 91.5,
      "previous": 89.3,
      "target": 90.0,
      "trend": "up",
      "icon": Icons.route,
    },
    {
      "category": "Resource Utilization",
      "current": 85.8,
      "previous": 87.2,
      "target": 88.0,
      "trend": "down",
      "icon": Icons.people,
    },
  ];

  final List<Map<String, dynamic>> kpiData = [
    {
      "title": "On-Time Delivery",
      "value": "94.2%",
      "change": "+2.4%",
      "positive": true,
    },
    {
      "title": "Order Accuracy",
      "value": "99.1%",
      "change": "+0.3%",
      "positive": true,
    },
    {
      "title": "Customer Satisfaction",
      "value": "4.7/5",
      "change": "+0.2",
      "positive": true,
    },
    {
      "title": "Cost per Delivery",
      "value": "\$12.45",
      "change": "-\$1.20",
      "positive": true,
    },
  ];

  Widget _buildFilters() {
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
          Text(
            "Report Filters",
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
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Metric Type",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
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

  Widget _buildKPICards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Key Performance Indicators",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          minItemWidth: 200,
          children: kpiData.map((kpi) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${kpi["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${kpi["value"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        (kpi["positive"] as bool) ? Icons.trending_up : Icons.trending_down,
                        size: 16,
                        color: (kpi["positive"] as bool) ? successColor : dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${kpi["change"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (kpi["positive"] as bool) ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEfficiencyChart() {
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
          Text(
            "Efficiency Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...efficiencyData.map((item) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Target: ${(item["target"] as double).toStringAsFixed(1)}%",
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
                        Text(
                          "${(item["current"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              (item["trend"] as String) == "up" ? Icons.trending_up : Icons.trending_down,
                              size: 14,
                              color: (item["trend"] as String) == "up" ? successColor : dangerColor,
                            ),
                            Text(
                              "${((item["current"] as double) - (item["previous"] as double)).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: (item["trend"] as String) == "up" ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: (item["current"] as double) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: (item["current"] as double) >= (item["target"] as double) 
                            ? successColor 
                            : (item["current"] as double) >= (item["target"] as double) * 0.8 
                                ? warningColor 
                                : dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReportActions() {
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
          Text(
            "Report Actions",
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
                child: QButton(
                  label: "Export PDF",
                  icon: Icons.picture_as_pdf,
                  size: bs.sm,
                  onPressed: () {
                    si("Exporting efficiency report as PDF");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Share Report",
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    si("Sharing efficiency report");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Schedule Report",
                  icon: Icons.schedule,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Scheduling automated reports");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Efficiency Report"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refreshing efficiency data");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildKPICards(),
            _buildEfficiencyChart(),
            _buildReportActions(),
          ],
        ),
      ),
    );
  }
}

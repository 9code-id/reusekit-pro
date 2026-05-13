import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaSupplierPerformanceView extends StatefulWidget {
  const ImaSupplierPerformanceView({super.key});

  @override
  State<ImaSupplierPerformanceView> createState() => _ImaSupplierPerformanceViewState();
}

class _ImaSupplierPerformanceViewState extends State<ImaSupplierPerformanceView> {
  String selectedSupplier = "";
  String selectedPeriod = "last_30_days";
  String selectedMetric = "overall";
  
  List<Map<String, dynamic>> suppliers = [
    {"label": "All Suppliers", "value": ""},
    {"label": "Global Electronics Supply Co.", "value": "SUP001"},
    {"label": "Advanced Components Inc.", "value": "SUP002"},
    {"label": "Industrial Materials Corp.", "value": "SUP003"},
    {"label": "Quick Delivery Services", "value": "SUP004"},
    {"label": "Office Solutions Plus", "value": "SUP005"},
  ];
  
  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 days", "value": "last_7_days"},
    {"label": "Last 30 days", "value": "last_30_days"},
    {"label": "Last 3 months", "value": "last_3_months"},
    {"label": "Last 6 months", "value": "last_6_months"},
    {"label": "Last year", "value": "last_year"},
  ];
  
  List<Map<String, dynamic>> metrics = [
    {"label": "Overall Performance", "value": "overall"},
    {"label": "Delivery Performance", "value": "delivery"},
    {"label": "Quality Metrics", "value": "quality"},
    {"label": "Financial Performance", "value": "financial"},
    {"label": "Communication", "value": "communication"},
  ];
  
  List<Map<String, dynamic>> performanceData = [
    {
      "supplier": "Global Electronics Supply Co.",
      "supplierId": "SUP001",
      "overallScore": 96.5,
      "onTimeDelivery": 98.5,
      "qualityScore": 96.2,
      "orderAccuracy": 97.8,
      "responseTime": 2.3,
      "costPerformance": 94.1,
      "totalOrders": 156,
      "totalValue": 2500000.0,
      "defectRate": 0.8,
      "returnRate": 1.2,
      "trend": "up",
      "rank": 1,
    },
    {
      "supplier": "Industrial Materials Corp.",
      "supplierId": "SUP003",
      "overallScore": 94.8,
      "onTimeDelivery": 96.2,
      "qualityScore": 95.5,
      "orderAccuracy": 96.1,
      "responseTime": 1.8,
      "costPerformance": 92.3,
      "totalOrders": 89,
      "totalValue": 1800000.0,
      "defectRate": 1.1,
      "returnRate": 1.8,
      "trend": "up",
      "rank": 2,
    },
    {
      "supplier": "Advanced Components Inc.",
      "supplierId": "SUP002",
      "overallScore": 89.2,
      "onTimeDelivery": 91.5,
      "qualityScore": 88.9,
      "orderAccuracy": 94.2,
      "responseTime": 4.1,
      "costPerformance": 87.6,
      "totalOrders": 67,
      "totalValue": 1200000.0,
      "defectRate": 2.3,
      "returnRate": 3.1,
      "trend": "stable",
      "rank": 3,
    },
    {
      "supplier": "Office Solutions Plus",
      "supplierId": "SUP005",
      "overallScore": 86.4,
      "onTimeDelivery": 88.7,
      "qualityScore": 85.2,
      "orderAccuracy": 92.8,
      "responseTime": 3.5,
      "costPerformance": 84.9,
      "totalOrders": 42,
      "totalValue": 450000.0,
      "defectRate": 3.2,
      "returnRate": 4.5,
      "trend": "down",
      "rank": 4,
    },
    {
      "supplier": "Quick Delivery Services",
      "supplierId": "SUP004",
      "overallScore": 82.1,
      "onTimeDelivery": 84.3,
      "qualityScore": 80.8,
      "orderAccuracy": 89.5,
      "responseTime": 6.2,
      "costPerformance": 78.4,
      "totalOrders": 28,
      "totalValue": 320000.0,
      "defectRate": 5.1,
      "returnRate": 6.8,
      "trend": "down",
      "rank": 5,
    },
  ];
  
  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Average Performance",
      "value": 89.8,
      "unit": "%",
      "trend": "up",
      "change": 2.3,
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "On-Time Delivery",
      "value": 91.8,
      "unit": "%",
      "trend": "up",
      "change": 1.5,
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "title": "Quality Score",
      "value": 89.3,
      "unit": "%",
      "trend": "stable",
      "change": 0.2,
      "icon": Icons.verified,
      "color": primaryColor,
    },
    {
      "title": "Cost Efficiency",
      "value": 87.5,
      "unit": "%",
      "trend": "up",
      "change": 3.1,
      "icon": Icons.monetization_on,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Performance"),
        actions: [
          IconButton(
            onPressed: () {
              _showReportOptions();
            },
            icon: Icon(Icons.file_download),
          ),
          IconButton(
            onPressed: () {
              _showPerformanceSettings();
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildKPIOverview(),
            SizedBox(height: spLg),
            _buildPerformanceRanking(),
            SizedBox(height: spLg),
            _buildDetailedMetrics(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Supplier",
                  items: suppliers,
                  value: selectedSupplier,
                  onChanged: (value, label) {
                    selectedSupplier = value;
                    _updatePerformanceData();
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _updatePerformanceData();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Metric Focus",
            items: metrics,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              _updatePerformanceData();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKPIOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Performance Indicators",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          minItemWidth: 200,
          children: kpiMetrics.map((kpi) {
            return Container(
              padding: EdgeInsets.all(spMd),
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (kpi["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          kpi["icon"],
                          color: kpi["color"],
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getTrendColor(kpi["trend"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getTrendIcon(kpi["trend"]),
                              color: _getTrendColor(kpi["trend"]),
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${kpi["change"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getTrendColor(kpi["trend"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${kpi["value"]}${kpi["unit"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${kpi["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "vs. previous period",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPerformanceRanking() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Text(
                "Performance Ranking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showDetailedRanking();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: performanceData.take(5).map((supplier) {
              return _buildRankingCard(supplier);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingCard(Map<String, dynamic> supplier) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
              color: _getRankColor(supplier["rank"]),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "#${supplier["rank"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${supplier["supplier"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Score: ${supplier["overallScore"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      _getTrendIcon(supplier["trend"]),
                      color: _getTrendColor(supplier["trend"]),
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${supplier["totalOrders"]} orders",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${((supplier["totalValue"] as double) / 1000000).toStringAsFixed(1)}M",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detailed Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Supplier", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Overall", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Quality", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Response", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Defects", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Returns", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: performanceData.map((supplier) {
                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 120,
                        child: Text(
                          "${supplier["supplier"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getScoreColor(supplier["overallScore"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${supplier["overallScore"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getScoreColor(supplier["overallScore"]),
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text("${supplier["onTimeDelivery"]}%")),
                    DataCell(Text("${supplier["qualityScore"]}%")),
                    DataCell(Text("${supplier["responseTime"]}h")),
                    DataCell(Text("${supplier["defectRate"]}%")),
                    DataCell(Text("${supplier["returnRate"]}%")),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return successColor;
      case 'down':
        return dangerColor;
      case 'stable':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.remove;
    }
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return warningColor; // Gold
      case 2:
        return disabledBoldColor; // Silver
      case 3:
        return warningColor.withAlpha(150); // Bronze
      default:
        return primaryColor;
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return successColor;
    if (score >= 80) return infoColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  void _updatePerformanceData() {
    setState(() {});
  }

  void _showDetailedRanking() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Detailed Performance Ranking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: performanceData.length,
                  itemBuilder: (context, index) {
                    return _buildDetailedRankingCard(performanceData[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailedRankingCard(Map<String, dynamic> supplier) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getRankColor(supplier["rank"]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "#${supplier["rank"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  "${supplier["supplier"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${supplier["overallScore"]}%",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(supplier["overallScore"]),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildMetricItem("On-Time Delivery", "${supplier["onTimeDelivery"]}%", Icons.schedule),
              _buildMetricItem("Quality Score", "${supplier["qualityScore"]}%", Icons.verified),
              _buildMetricItem("Order Accuracy", "${supplier["orderAccuracy"]}%", Icons.check_circle),
              _buildMetricItem("Response Time", "${supplier["responseTime"]}h", Icons.access_time),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showReportOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Export Performance Report",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.picture_as_pdf, "Export as PDF", () {}),
              _buildActionItem(Icons.table_chart, "Export as Excel", () {}),
              _buildActionItem(Icons.email, "Email Report", () {}),
              _buildActionItem(Icons.share, "Share Report", () {}),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  void _showPerformanceSettings() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Performance Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.tune, "Configure KPI Weights", () {}),
              _buildActionItem(Icons.notifications, "Set Performance Alerts", () {}),
              _buildActionItem(Icons.schedule, "Schedule Reports", () {}),
              _buildActionItem(Icons.group, "Benchmark Settings", () {}),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

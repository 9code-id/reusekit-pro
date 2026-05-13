import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmRevenueTrackingView extends StatefulWidget {
  const CrmRevenueTrackingView({super.key});

  @override
  State<CrmRevenueTrackingView> createState() => _CrmRevenueTrackingViewState();
}

class _CrmRevenueTrackingViewState extends State<CrmRevenueTrackingView> {
  String selectedPeriod = "monthly";
  String selectedMetric = "all";
  String selectedSegment = "all";
  bool showProjection = true;
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> metricItems = [
    {"label": "All Metrics", "value": "all"},
    {"label": "Total Revenue", "value": "total"},
    {"label": "Recurring Revenue", "value": "recurring"},
    {"label": "One-time Revenue", "value": "onetime"},
    {"label": "Subscription Revenue", "value": "subscription"},
  ];

  List<Map<String, dynamic>> segmentItems = [
    {"label": "All Segments", "value": "all"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "SMB", "value": "smb"},
    {"label": "Startup", "value": "startup"},
    {"label": "Government", "value": "government"},
  ];

  Map<String, dynamic> revenueOverview = {
    "totalRevenue": 12500000.0,
    "monthlyRecurring": 850000.0,
    "yearlyRecurring": 3200000.0,
    "oneTimeRevenue": 2800000.0,
    "projectedAnnual": 15200000.0,
    "growthRate": 0.18,
    "churnRate": 0.05,
    "averageContractValue": 45000.0,
  };

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "revenue": 980000.0, "recurring": 680000.0, "onetime": 300000.0, "target": 950000.0, "projection": 1020000.0},
    {"month": "Feb", "revenue": 1050000.0, "recurring": 720000.0, "onetime": 330000.0, "target": 980000.0, "projection": 1080000.0},
    {"month": "Mar", "revenue": 1120000.0, "recurring": 750000.0, "onetime": 370000.0, "target": 1020000.0, "projection": 1150000.0},
    {"month": "Apr", "revenue": 1180000.0, "recurring": 780000.0, "onetime": 400000.0, "target": 1100000.0, "projection": 1220000.0},
    {"month": "May", "revenue": 1250000.0, "recurring": 820000.0, "onetime": 430000.0, "target": 1150000.0, "projection": 1290000.0},
    {"month": "Jun", "revenue": 1320000.0, "recurring": 850000.0, "onetime": 470000.0, "target": 1200000.0, "projection": 1360000.0},
    {"month": "Jul", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1250000.0, "projection": 1430000.0},
    {"month": "Aug", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1300000.0, "projection": 1500000.0},
    {"month": "Sep", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1350000.0, "projection": 1570000.0},
    {"month": "Oct", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1400000.0, "projection": 1640000.0},
    {"month": "Nov", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1450000.0, "projection": 1710000.0},
    {"month": "Dec", "revenue": 0.0, "recurring": 0.0, "onetime": 0.0, "target": 1500000.0, "projection": 1780000.0},
  ];

  List<Map<String, dynamic>> revenueStreams = [
    {
      "name": "Software Licenses",
      "type": "recurring",
      "currentValue": 3200000.0,
      "monthlyGrowth": 0.08,
      "percentage": 0.35,
      "trend": "up",
      "segments": {"enterprise": 60, "smb": 30, "startup": 10},
    },
    {
      "name": "Professional Services",
      "type": "onetime",
      "currentValue": 2800000.0,
      "monthlyGrowth": 0.12,
      "percentage": 0.30,
      "trend": "up",
      "segments": {"enterprise": 70, "smb": 20, "startup": 10},
    },
    {
      "name": "Subscriptions",
      "type": "recurring",
      "currentValue": 2200000.0,
      "monthlyGrowth": 0.15,
      "percentage": 0.24,
      "trend": "up",
      "segments": {"enterprise": 40, "smb": 40, "startup": 20},
    },
    {
      "name": "Training & Support",
      "type": "recurring",
      "currentValue": 950000.0,
      "monthlyGrowth": 0.06,
      "percentage": 0.10,
      "trend": "stable",
      "segments": {"enterprise": 50, "smb": 35, "startup": 15},
    },
    {
      "name": "Hardware Sales",
      "type": "onetime",
      "currentValue": 120000.0,
      "monthlyGrowth": -0.02,
      "percentage": 0.01,
      "trend": "down",
      "segments": {"enterprise": 80, "smb": 15, "startup": 5},
    },
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "Enterprise",
      "customers": 125,
      "revenue": 6800000.0,
      "averageValue": 54400.0,
      "growth": 0.22,
      "churn": 0.03,
      "ltv": 485000.0,
    },
    {
      "segment": "SMB",
      "customers": 340,
      "revenue": 3900000.0,
      "averageValue": 11470.0,
      "growth": 0.18,
      "churn": 0.08,
      "ltv": 128000.0,
    },
    {
      "segment": "Startup",
      "customers": 580,
      "revenue": 1450000.0,
      "averageValue": 2500.0,
      "growth": 0.25,
      "churn": 0.12,
      "ltv": 18500.0,
    },
    {
      "segment": "Government",
      "customers": 45,
      "revenue": 350000.0,
      "averageValue": 7780.0,
      "growth": 0.08,
      "churn": 0.02,
      "ltv": 95000.0,
    },
  ];

  List<Map<String, dynamic>> regionalPerformance = [
    {"region": "North America", "revenue": 5800000.0, "growth": 0.19, "percentage": 0.46},
    {"region": "Europe", "revenue": 3200000.0, "growth": 0.15, "percentage": 0.26},
    {"region": "Asia Pacific", "revenue": 2100000.0, "growth": 0.28, "percentage": 0.17},
    {"region": "Latin America", "revenue": 950000.0, "growth": 0.22, "percentage": 0.08},
    {"region": "Middle East & Africa", "revenue": 450000.0, "growth": 0.31, "percentage": 0.03},
  ];

  void _updateFilters() {
    setState(() {});
  }

  void _refreshData() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Revenue data refreshed successfully");
  }

  void _exportReport() {
    si("Generating revenue report...");
  }

  void _createRevenueGoal() {
    showDialog(
      context: context,
      builder: (context) => _buildCreateGoalDialog(),
    );
  }

  String _getTrendIcon(String trend) {
    switch (trend) {
      case "up": return "↗";
      case "down": return "↘";
      case "stable": return "→";
      default: return "→";
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up": return successColor;
      case "down": return dangerColor;
      case "stable": return warningColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _createRevenueGoal,
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text("Set Goals"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                onTap: _exportReport,
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text("Export Report"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(showProjection ? Icons.visibility_off : Icons.visibility),
                  title: Text(showProjection ? "Hide Projections" : "Show Projections"),
                  contentPadding: EdgeInsets.zero,
                ),
                onTap: () {
                  showProjection = !showProjection;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildFiltersSection(),
              _buildOverviewCards(),
              _buildRevenueChart(),
              _buildRevenueStreams(),
              _buildCustomerSegments(),
              _buildRegionalPerformance(),
              _buildRevenueMetrics(),
            ],
          ),
        ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _updateFilters();
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Metric",
                  items: metricItems,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    _updateFilters();
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Customer Segment",
            items: segmentItems,
            value: selectedSegment,
            onChanged: (value, label) {
              selectedSegment = value;
              _updateFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    final overview = revenueOverview;
    
    return Column(
      spacing: spSm,
      children: [
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: _buildOverviewCard(
                "Total Revenue",
                "\$${((overview["totalRevenue"] as double) / 1000000).toStringAsFixed(1)}M",
                "${((overview["growthRate"] as double) * 100).toStringAsFixed(1)}% growth",
                Icons.monetization_on,
                primaryColor,
              ),
            ),
            Expanded(
              child: _buildOverviewCard(
                "Monthly Recurring",
                "\$${((overview["monthlyRecurring"] as double) / 1000).toStringAsFixed(0)}K",
                "MRR",
                Icons.repeat,
                successColor,
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: _buildOverviewCard(
                "Projected Annual",
                "\$${((overview["projectedAnnual"] as double) / 1000000).toStringAsFixed(1)}M",
                "vs \$${((overview["totalRevenue"] as double) / 1000000).toStringAsFixed(1)}M current",
                Icons.trending_up,
                infoColor,
              ),
            ),
            Expanded(
              child: _buildOverviewCard(
                "Avg Contract",
                "\$${((overview["averageContractValue"] as double) / 1000).toStringAsFixed(0)}K",
                "${((overview["churnRate"] as double) * 100).toStringAsFixed(1)}% churn rate",
                Icons.description,
                warningColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: spXs,
            children: [
              Icon(icon, color: color, size: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
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
              Text(
                "Monthly Revenue Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (showProjection)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "With Projections",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: monthlyData.map((data) {
                  final hasActual = (data["revenue"] as double) > 0;
                  final maxValue = monthlyData.map((d) => (d["projection"] as double)).reduce((a, b) => a > b ? a : b);
                  
                  final targetHeight = ((data["target"] as double) / maxValue) * 160;
                  final revenueHeight = hasActual ? ((data["revenue"] as double) / maxValue) * 160 : 0.0;
                  final projectionHeight = showProjection ? ((data["projection"] as double) / maxValue) * 160 : 0.0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      SizedBox(
                        height: 160,
                        width: 70,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Target line
                            Positioned(
                              bottom: targetHeight,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1,
                                color: disabledBoldColor,
                              ),
                            ),
                            // Actual revenue bar
                            if (hasActual)
                              Positioned(
                                bottom: 0,
                                left: 5,
                                child: Container(
                                  width: 20,
                                  height: revenueHeight,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            // Projection bar
                            if (showProjection)
                              Positioned(
                                bottom: 0,
                                right: 5,
                                child: Container(
                                  width: 15,
                                  height: projectionHeight,
                                  decoration: BoxDecoration(
                                    color: hasActual ? infoColor.withAlpha(120) : infoColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        "${data["month"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (hasActual)
                        Text(
                          "\$${((data["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 8,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else if (showProjection)
                        Text(
                          "\$${((data["projection"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 8,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Row(
            spacing: spMd,
            children: [
              _buildLegendItem("Actual", primaryColor),
              _buildLegendItem("Target", disabledBoldColor),
              if (showProjection) _buildLegendItem("Projection", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      spacing: spXs,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueStreams() {
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
            "Revenue Streams",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...revenueStreams.map((stream) => _buildRevenueStreamCard(stream)),
        ],
      ),
    );
  }

  Widget _buildRevenueStreamCard(Map<String, dynamic> stream) {
    final value = (stream["currentValue"] as double);
    final growth = (stream["monthlyGrowth"] as double);
    final percentage = (stream["percentage"] as double);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      spacing: spXs,
                      children: [
                        Text(
                          "${stream["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: stream["type"] == "recurring" ? successColor.withAlpha(20) : infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stream["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              color: stream["type"] == "recurring" ? successColor : infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${(value / 1000000).toStringAsFixed(1)}M • ${(percentage * 100).toStringAsFixed(1)}% of total",
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
                spacing: spXs,
                children: [
                  Row(
                    spacing: spXs,
                    children: [
                      Text(
                        _getTrendIcon(stream["trend"]),
                        style: TextStyle(
                          fontSize: 16,
                          color: _getTrendColor(stream["trend"]),
                        ),
                      ),
                      Text(
                        "${(growth * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getTrendColor(stream["trend"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "monthly growth",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              stream["trend"] == "up" ? successColor : 
              stream["trend"] == "down" ? dangerColor : warningColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              ...((stream["segments"] as Map<String, dynamic>).entries.map((entry) {
                return Expanded(
                  flex: entry.value as int,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: entry.key == "enterprise" ? primaryColor :
                             entry.key == "smb" ? successColor :
                             entry.key == "startup" ? warningColor : infoColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                );
              })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSegments() {
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
            "Customer Segments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: customerSegments.map((segment) {
              return _buildSegmentCard(segment);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentCard(Map<String, dynamic> segment) {
    final revenue = (segment["revenue"] as double);
    final growth = (segment["growth"] as double);
    final churn = (segment["churn"] as double);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${segment["segment"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: growth >= 0.2 ? successColor.withAlpha(20) :
                         growth >= 0.1 ? warningColor.withAlpha(20) :
                         dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(growth * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: growth >= 0.2 ? successColor :
                           growth >= 0.1 ? warningColor : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "\$${(revenue / 1000000).toStringAsFixed(1)}M revenue",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${segment["customers"]} customers",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((segment["averageValue"] as double) / 1000).toStringAsFixed(0)}K avg",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${(churn * 100).toStringAsFixed(1)}% churn",
                      style: TextStyle(
                        fontSize: 12,
                        color: churn <= 0.05 ? successColor : 
                               churn <= 0.1 ? warningColor : dangerColor,
                      ),
                    ),
                    Text(
                      "\$${((segment["ltv"] as double) / 1000).toStringAsFixed(0)}K LTV",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
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

  Widget _buildRegionalPerformance() {
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
            "Regional Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...regionalPerformance.map((region) => _buildRegionCard(region)),
        ],
      ),
    );
  }

  Widget _buildRegionCard(Map<String, dynamic> region) {
    final revenue = (region["revenue"] as double);
    final growth = (region["growth"] as double);
    final percentage = (region["percentage"] as double);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${region["region"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$${(revenue / 1000000).toStringAsFixed(1)}M • ${(percentage * 100).toStringAsFixed(0)}% of total",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 14, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${(growth * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueMetrics() {
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
            "Key Revenue Metrics",
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
                child: _buildMetricCard(
                  "ARR",
                  "\$${((revenueOverview["yearlyRecurring"] as double) / 1000000).toStringAsFixed(1)}M",
                  "Annual Recurring Revenue",
                  Icons.repeat,
                  successColor,
                ),
              ),
              Expanded(
                child: _buildMetricCard(
                  "CAC",
                  "\$2,450",
                  "Customer Acquisition Cost",
                  Icons.person_add,
                  warningColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildMetricCard(
                  "LTV:CAC",
                  "3.2:1",
                  "Lifetime Value to CAC Ratio",
                  Icons.balance,
                  successColor,
                ),
              ),
              Expanded(
                child: _buildMetricCard(
                  "Payback",
                  "14 months",
                  "Customer Payback Period",
                  Icons.schedule,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGoalDialog() {
    String goalType = "revenue";
    String period = "quarterly";
    String targetValue = "";
    String description = "";

    List<Map<String, dynamic>> goalTypeItems = [
      {"label": "Total Revenue", "value": "revenue"},
      {"label": "Monthly Recurring Revenue", "value": "mrr"},
      {"label": "Annual Recurring Revenue", "value": "arr"},
      {"label": "Customer Acquisition", "value": "acquisition"},
    ];

    List<Map<String, dynamic>> periodGoalItems = [
      {"label": "Monthly", "value": "monthly"},
      {"label": "Quarterly", "value": "quarterly"},
      {"label": "Yearly", "value": "yearly"},
    ];

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text("Create Revenue Goal"),
          content: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Goal Type",
                  items: goalTypeItems,
                  value: goalType,
                  onChanged: (value, label) {
                    goalType = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Period",
                  items: periodGoalItems,
                  value: period,
                  onChanged: (value, label) {
                    period = value;
                    setDialogState(() {});
                  },
                ),
                QNumberField(
                  label: "Target Value (\$)",
                  value: targetValue,
                  onChanged: (value) => targetValue = value,
                ),
                QMemoField(
                  label: "Description",
                  value: description,
                  onChanged: (value) => description = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create Goal",
              onPressed: () {
                if (targetValue.isNotEmpty) {
                  Navigator.pop(context);
                  ss("Revenue goal created successfully");
                }
              },
            ),
          ],
        );
      },
    );
  }
}

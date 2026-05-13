import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSupplierPerformanceView extends StatefulWidget {
  const IwmSupplierPerformanceView({super.key});

  @override
  State<IwmSupplierPerformanceView> createState() => _IwmSupplierPerformanceViewState();
}

class _IwmSupplierPerformanceViewState extends State<IwmSupplierPerformanceView> {
  int selectedTab = 0;
  String selectedPeriod = "this_month";
  String selectedMetric = "overall";
  String selectedSupplierFilter = "all";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "Last Year", "value": "last_year"},
  ];
  
  List<Map<String, dynamic>> metricItems = [
    {"label": "Overall Performance", "value": "overall"},
    {"label": "On-Time Delivery", "value": "delivery"},
    {"label": "Quality Score", "value": "quality"},
    {"label": "Cost Efficiency", "value": "cost"},
    {"label": "Response Time", "value": "response"},
  ];
  
  List<Map<String, dynamic>> supplierFilterItems = [
    {"label": "All Suppliers", "value": "all"},
    {"label": "Active Only", "value": "active"},
    {"label": "Top Performers", "value": "top_performers"},
    {"label": "Needs Improvement", "value": "needs_improvement"},
  ];

  List<Map<String, dynamic>> performanceOverview = [
    {
      "title": "Avg Performance",
      "value": 89,
      "unit": "%",
      "trend": "+2.3%",
      "trendUp": true,
      "icon": Icons.trending_up,
      "color": primaryColor
    },
    {
      "title": "On-Time Delivery",
      "value": 94,
      "unit": "%",
      "trend": "+1.5%",
      "trendUp": true,
      "icon": Icons.delivery_dining,
      "color": successColor
    },
    {
      "title": "Quality Score",
      "value": 87,
      "unit": "%",
      "trend": "-0.8%",
      "trendUp": false,
      "icon": Icons.verified,
      "color": infoColor
    },
    {
      "title": "Cost Efficiency",
      "value": 92,
      "unit": "%",
      "trend": "+3.2%",
      "trendUp": true,
      "icon": Icons.monetization_on,
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> supplierPerformance = [
    {
      "id": "SUP-001",
      "name": "Global Materials Inc.",
      "category": "Raw Materials",
      "overallScore": 94,
      "onTimeDelivery": 96,
      "qualityScore": 92,
      "costEfficiency": 89,
      "responseTime": 2.1,
      "rating": 4.8,
      "totalOrders": 145,
      "trend": "+5.2%",
      "trendUp": true,
      "status": "excellent",
      "logo": "https://picsum.photos/50/50?random=1&keyword=company"
    },
    {
      "id": "SUP-002",
      "name": "TechComponents Ltd",
      "category": "Components",
      "overallScore": 89,
      "onTimeDelivery": 94,
      "qualityScore": 88,
      "costEfficiency": 85,
      "responseTime": 3.2,
      "rating": 4.6,
      "totalOrders": 89,
      "trend": "+2.1%",
      "trendUp": true,
      "status": "good",
      "logo": "https://picsum.photos/50/50?random=2&keyword=technology"
    },
    {
      "id": "SUP-003",
      "name": "Asia Pacific Packaging",
      "category": "Packaging",
      "overallScore": 87,
      "onTimeDelivery": 91,
      "qualityScore": 85,
      "costEfficiency": 88,
      "responseTime": 2.8,
      "rating": 4.4,
      "totalOrders": 67,
      "trend": "+1.8%",
      "trendUp": true,
      "status": "good",
      "logo": "https://picsum.photos/50/50?random=3&keyword=packaging"
    },
    {
      "id": "SUP-004",
      "name": "Industrial Equipment Co",
      "category": "Equipment",
      "overallScore": 82,
      "onTimeDelivery": 88,
      "qualityScore": 81,
      "costEfficiency": 79,
      "responseTime": 4.1,
      "rating": 4.2,
      "totalOrders": 23,
      "trend": "-1.2%",
      "trendUp": false,
      "status": "needs_improvement",
      "logo": "https://picsum.photos/50/50?random=4&keyword=equipment"
    },
    {
      "id": "SUP-005",
      "name": "Euro Services Group",
      "category": "Services",
      "overallScore": 74,
      "onTimeDelivery": 82,
      "qualityScore": 76,
      "costEfficiency": 71,
      "responseTime": 5.3,
      "rating": 3.8,
      "totalOrders": 45,
      "trend": "-3.5%",
      "trendUp": false,
      "status": "needs_improvement",
      "logo": "https://picsum.photos/50/50?random=5&keyword=services"
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "metric": "On-Time Delivery Rate",
      "current": 94,
      "target": 95,
      "previous": 92,
      "unit": "%",
      "status": "approaching_target"
    },
    {
      "metric": "Quality Pass Rate",
      "current": 87,
      "target": 90,
      "previous": 88,
      "unit": "%",
      "status": "needs_improvement"
    },
    {
      "metric": "Order Accuracy",
      "current": 96,
      "target": 98,
      "previous": 94,
      "unit": "%",
      "status": "approaching_target"
    },
    {
      "metric": "Response Time",
      "current": 2.8,
      "target": 2.0,
      "previous": 3.2,
      "unit": "hours",
      "status": "improving"
    },
    {
      "metric": "Cost Variance",
      "current": 92,
      "target": 95,
      "previous": 89,
      "unit": "%",
      "status": "improving"
    },
  ];

  List<Map<String, dynamic>> benchmarkData = [
    {"category": "Raw Materials", "avgScore": 91, "topScore": 94, "supplierCount": 12},
    {"category": "Components", "avgScore": 86, "topScore": 89, "supplierCount": 8},
    {"category": "Packaging", "avgScore": 84, "topScore": 87, "supplierCount": 6},
    {"category": "Equipment", "avgScore": 79, "topScore": 82, "supplierCount": 4},
    {"category": "Services", "avgScore": 76, "topScore": 74, "supplierCount": 3},
  ];

  List<Map<String, dynamic>> get filteredSuppliers {
    List<Map<String, dynamic>> filtered = List.from(supplierPerformance);
    
    if (selectedSupplierFilter == "active") {
      // Filter active suppliers only (assuming all in this example are active)
    } else if (selectedSupplierFilter == "top_performers") {
      filtered = filtered.where((s) => (s["overallScore"] as int) >= 90).toList();
    } else if (selectedSupplierFilter == "needs_improvement") {
      filtered = filtered.where((s) => (s["overallScore"] as int) < 85).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Supplier Performance",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Rankings", icon: Icon(Icons.leaderboard)),
        Tab(text: "Metrics", icon: Icon(Icons.analytics)),
        Tab(text: "Benchmarks", icon: Icon(Icons.compare_arrows)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRankingsTab(),
        _buildMetricsTab(),
        _buildBenchmarksTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceFilters(),
          _buildPerformanceOverview(),
          _buildPerformanceChart(),
          _buildTopPerformers(),
          _buildPerformanceAlerts(),
        ],
      ),
    );
  }

  Widget _buildRankingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRankingFilters(),
          _buildSupplierRankings(),
        ],
      ),
    );
  }

  Widget _buildMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetricsOverview(),
          _buildDetailedMetrics(),
          _buildMetricsTrends(),
        ],
      ),
    );
  }

  Widget _buildBenchmarksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBenchmarkOverview(),
          _buildCategoryBenchmarks(),
          _buildIndustryComparison(),
        ],
      ),
    );
  }

  Widget _buildPerformanceFilters() {
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
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
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
                  label: "Metric",
                  items: metricItems,
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

  Widget _buildPerformanceOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: performanceOverview.map((overview) => _buildOverviewCard(overview)).toList(),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(Map<String, dynamic> overview) {
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
                  color: (overview["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  overview["icon"],
                  color: overview["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (overview["trendUp"] ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      overview["trendUp"] ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: overview["trendUp"] ? successColor : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${overview["trend"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: overview["trendUp"] ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${overview["value"]}${overview["unit"]}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${overview["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "vs last period",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
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
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
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
                    Icons.show_chart,
                    size: 64,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Trend Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Interactive chart showing supplier performance over time",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
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

  Widget _buildTopPerformers() {
    List<Map<String, dynamic>> topPerformers = List.from(supplierPerformance)
      ..sort((a, b) => (b["overallScore"] as int).compareTo(a["overallScore"] as int));

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
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topPerformers.take(3).map((supplier) => _buildTopPerformerCard(supplier)),
        ],
      ),
    );
  }

  Widget _buildTopPerformerCard(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${supplier["logo"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${supplier["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${supplier["category"]} • ${supplier["totalOrders"]} orders",
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
                "${supplier["overallScore"]}%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (supplier["trendUp"] ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${supplier["trend"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: supplier["trendUp"] ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAlerts() {
    List<Map<String, dynamic>> alerts = [
      {
        "type": "warning",
        "title": "Quality Score Decline",
        "message": "Euro Services Group quality score dropped by 5% this month",
        "supplier": "Euro Services Group",
        "time": "2 hours ago"
      },
      {
        "type": "success",
        "title": "Improved Delivery",
        "message": "Global Materials Inc. achieved 96% on-time delivery rate",
        "supplier": "Global Materials Inc.",
        "time": "5 hours ago"
      },
      {
        "type": "info",
        "title": "New Performance Record",
        "message": "TechComponents Ltd reached their highest monthly score",
        "supplier": "TechComponents Ltd",
        "time": "1 day ago"
      },
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
          Text(
            "Performance Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...alerts.map((alert) => _buildAlertCard(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color alertColor = _getAlertColor(alert["type"]);
    IconData alertIcon = _getAlertIcon(alert["type"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: alertColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: alertColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: alertColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              alertIcon,
              color: alertColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${alert["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${alert["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${alert["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingFilters() {
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
          QDropdownField(
            label: "Filter Suppliers",
            items: supplierFilterItems,
            value: selectedSupplierFilter,
            onChanged: (value, label) {
              selectedSupplierFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierRankings() {
    List<Map<String, dynamic>> rankedSuppliers = List.from(filteredSuppliers)
      ..sort((a, b) => (b["overallScore"] as int).compareTo(a["overallScore"] as int));

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Supplier Rankings (${rankedSuppliers.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...rankedSuppliers.asMap().map((index, supplier) => 
          MapEntry(index, _buildRankingCard(index + 1, supplier))).values,
      ],
    );
  }

  Widget _buildRankingCard(int rank, Map<String, dynamic> supplier) {
    Color rankColor = _getRankColor(rank);
    Color statusColor = _getPerformanceStatusColor(supplier["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: rankColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "$rank",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${supplier["logo"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${supplier["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${supplier["status"]}".replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${supplier["category"]} • ${supplier["totalOrders"]} orders • ★ ${supplier["rating"]}",
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
                "${supplier["overallScore"]}%",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (supplier["trendUp"] ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${supplier["trend"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: supplier["trendUp"] ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Key Performance Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...performanceMetrics.map((metric) => _buildMetricCard(metric)),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    Color statusColor = _getMetricStatusColor(metric["status"]);
    double progress = (metric["current"] as num).toDouble() / (metric["target"] as num).toDouble();
    if (metric["unit"] == "hours") {
      progress = (metric["target"] as num).toDouble() / (metric["current"] as num).toDouble();
    }
    progress = progress.clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${metric["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current: ${metric["current"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Target: ${metric["target"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Previous: ${metric["previous"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(progress * 100).toStringAsFixed(1)}% of target",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
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

  Widget _buildDetailedMetrics() {
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
            "Detailed Performance Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: supplierPerformance.take(3).map((supplier) => _buildDetailedMetricCard(supplier)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetricCard(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${supplier["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${supplier["name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          _buildMetricBar("On-Time", supplier["onTimeDelivery"], successColor),
          _buildMetricBar("Quality", supplier["qualityScore"], infoColor),
          _buildMetricBar("Cost Eff.", supplier["costEfficiency"], warningColor),
        ],
      ),
    );
  }

  Widget _buildMetricBar(String label, int value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value / 100.0,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          "$value%",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsTrends() {
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
            "Metrics Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
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
                    Icons.multiline_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Metrics Trend Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
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

  Widget _buildBenchmarkOverview() {
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
            "Industry Benchmarks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Compare your supplier performance against industry standards",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBenchmarks() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category Performance",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...benchmarkData.map((benchmark) => _buildBenchmarkCard(benchmark)),
      ],
    );
  }

  Widget _buildBenchmarkCard(Map<String, dynamic> benchmark) {
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
              Text(
                "${benchmark["category"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${benchmark["supplierCount"]} suppliers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${benchmark["avgScore"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${benchmark["topScore"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "Chart",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryComparison() {
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
            "Industry Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
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
                    Icons.compare_arrows,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Industry Comparison Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
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

  Color _getRankColor(int rank) {
    if (rank <= 3) return successColor;
    if (rank <= 6) return primaryColor;
    return warningColor;
  }

  Color _getPerformanceStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return primaryColor;
      case 'needs_improvement':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertColor(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return successColor;
      case 'warning':
        return warningColor;
      case 'error':
        return dangerColor;
      case 'info':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      case 'info':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  Color _getMetricStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
      case 'target_met':
        return successColor;
      case 'good':
      case 'approaching_target':
      case 'improving':
        return primaryColor;
      case 'needs_improvement':
        return warningColor;
      case 'poor':
      case 'declining':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}

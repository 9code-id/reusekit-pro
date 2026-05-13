import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPerformanceMetricsView extends StatefulWidget {
  const IwmPerformanceMetricsView({super.key});

  @override
  State<IwmPerformanceMetricsView> createState() => _IwmPerformanceMetricsViewState();
}

class _IwmPerformanceMetricsViewState extends State<IwmPerformanceMetricsView> {
  String selectedPeriod = "This Quarter";
  String selectedMetricCategory = "All Metrics";
  String selectedDepartment = "All Departments";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Quarter", "value": "Last Quarter"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> metricCategoryItems = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Efficiency", "value": "Efficiency"},
    {"label": "Accuracy", "value": "Accuracy"},
    {"label": "Speed", "value": "Speed"},
    {"label": "Quality", "value": "Quality"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Warehouse", "value": "Warehouse"},
    {"label": "Purchasing", "value": "Purchasing"},
    {"label": "Receiving", "value": "Receiving"},
    {"label": "Shipping", "value": "Shipping"},
  ];

  List<Map<String, dynamic>> keyMetrics = [
    {
      "title": "Order Fulfillment Rate",
      "value": 98.5,
      "unit": "%",
      "target": 95.0,
      "change": 2.3,
      "trend": "up",
      "icon": Icons.check_circle,
      "color": successColor,
      "category": "Efficiency",
    },
    {
      "title": "Inventory Accuracy",
      "value": 97.2,
      "unit": "%",
      "target": 95.0,
      "change": 1.8,
      "trend": "up",
      "icon": Icons.verified,
      "color": primaryColor,
      "category": "Accuracy",
    },
    {
      "title": "Average Pick Time",
      "value": 4.2,
      "unit": "minutes",
      "target": 5.0,
      "change": -12.5,
      "trend": "down",
      "icon": Icons.schedule,
      "color": warningColor,
      "category": "Speed",
    },
    {
      "title": "Stockout Rate",
      "value": 1.8,
      "unit": "%",
      "target": 2.0,
      "change": -0.5,
      "trend": "down",
      "icon": Icons.warning,
      "color": dangerColor,
      "category": "Quality",
    },
    {
      "title": "Return Rate",
      "value": 2.1,
      "unit": "%",
      "target": 3.0,
      "change": -1.2,
      "trend": "down",
      "icon": Icons.keyboard_return,
      "color": infoColor,
      "category": "Quality",
    },
    {
      "title": "Cost Per Order",
      "value": 12.50,
      "unit": "\$",
      "target": 15.00,
      "change": -8.3,
      "trend": "down",
      "icon": Icons.attach_money,
      "color": successColor,
      "category": "Efficiency",
    },
  ];

  List<Map<String, dynamic>> departmentMetrics = [
    {
      "department": "Warehouse",
      "efficiency": 92.5,
      "accuracy": 96.8,
      "productivity": 8.5,
      "staffCount": 24,
      "ordersProcessed": 1250,
    },
    {
      "department": "Purchasing",
      "efficiency": 88.2,
      "accuracy": 94.5,
      "productivity": 6.2,
      "staffCount": 8,
      "ordersProcessed": 180,
    },
    {
      "department": "Receiving",
      "efficiency": 94.8,
      "accuracy": 98.1,
      "productivity": 12.3,
      "staffCount": 12,
      "ordersProcessed": 890,
    },
    {
      "department": "Shipping",
      "efficiency": 91.3,
      "accuracy": 97.5,
      "productivity": 15.8,
      "staffCount": 16,
      "ordersProcessed": 1450,
    },
  ];

  List<Map<String, dynamic>> performanceTrends = [
    {"week": "Week 1", "fulfillment": 96.2, "accuracy": 95.8, "speed": 4.8},
    {"week": "Week 2", "fulfillment": 97.1, "accuracy": 96.3, "speed": 4.5},
    {"week": "Week 3", "fulfillment": 97.8, "accuracy": 96.9, "speed": 4.3},
    {"week": "Week 4", "fulfillment": 98.5, "accuracy": 97.2, "speed": 4.2},
  ];

  List<Map<String, dynamic>> benchmarkData = [
    {
      "metric": "Order Fulfillment Rate",
      "current": 98.5,
      "industry": 95.0,
      "target": 99.0,
      "ranking": "Top 10%",
    },
    {
      "metric": "Inventory Accuracy",
      "current": 97.2,
      "industry": 94.0,
      "target": 98.0,
      "ranking": "Top 25%",
    },
    {
      "metric": "Average Pick Time",
      "current": 4.2,
      "industry": 5.5,
      "target": 4.0,
      "ranking": "Top 15%",
    },
    {
      "metric": "Stockout Rate",
      "current": 1.8,
      "industry": 3.2,
      "target": 1.5,
      "ranking": "Top 20%",
    },
  ];

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    bool isOnTarget = metric["value"] >= metric["target"] || 
                      (metric["title"].contains("Time") || metric["title"].contains("Rate") && metric["title"].contains("Stock") || metric["title"].contains("Return")) && metric["value"] <= metric["target"];
    
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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isOnTarget 
                      ? successColor.withAlpha(25)
                      : warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isOnTarget ? "On Target" : "Below Target",
                  style: TextStyle(
                    fontSize: 10,
                    color: isOnTarget ? successColor : warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${metric["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: metric["trend"] == "up" 
                      ? successColor.withAlpha(25)
                      : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      metric["trend"] == "up" 
                          ? Icons.trending_up 
                          : Icons.trending_down,
                      size: 12,
                      color: metric["trend"] == "up" 
                          ? successColor 
                          : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: metric["trend"] == "up" 
                            ? successColor 
                            : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Target: ${metric["target"]}${metric["unit"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(Map<String, dynamic> dept) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
            children: [
              Expanded(
                child: Text(
                  "${dept["department"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${dept["staffCount"]} staff",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${dept["efficiency"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${dept["accuracy"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Accuracy",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${dept["productivity"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Orders/Hour",
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
          SizedBox(height: spSm),
          Text(
            "Orders Processed: ${dept["ordersProcessed"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkCard(Map<String, dynamic> benchmark) {
    bool performsWell = benchmark["current"] > benchmark["industry"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: performsWell ? successColor : warningColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${benchmark["metric"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: performsWell 
                      ? successColor.withAlpha(25) 
                      : warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${benchmark["ranking"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: performsWell ? successColor : warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current: ${benchmark["current"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Industry Avg: ${benchmark["industry"]}",
                      style: TextStyle(
                        fontSize: 13,
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
                    "Target: ${benchmark["target"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    performsWell 
                        ? "Above Industry" 
                        : "Below Industry",
                    style: TextStyle(
                      fontSize: 12,
                      color: performsWell ? successColor : dangerColor,
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Benchmarks", icon: Icon(Icons.compare_arrows)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Filters
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
                      label: "Metric Category",
                      items: metricCategoryItems,
                      value: selectedMetricCategory,
                      onChanged: (value, label) {
                        selectedMetricCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Key Metrics
              ResponsiveGridView(
                padding: EdgeInsets.all(0),
                minItemWidth: 200,
                children: keyMetrics
                    .where((metric) => selectedMetricCategory == "All Metrics" || metric["category"] == selectedMetricCategory)
                    .map((metric) => _buildMetricCard(metric))
                    .toList(),
              ),

              // Performance Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up, color: successColor),
                        SizedBox(width: spSm),
                        Text(
                          "Performance Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Overall performance is excellent with 83% of metrics meeting or exceeding targets",
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
        ),

        // Departments Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Department",
                      items: departmentItems,
                      value: selectedDepartment,
                      onChanged: (value, label) {
                        selectedDepartment = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...departmentMetrics
                        .where((dept) => selectedDepartment == "All Departments" || dept["department"] == selectedDepartment)
                        .map((dept) => _buildDepartmentCard(dept)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Trends Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "Performance Trends",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spLg),
                    Icon(
                      Icons.show_chart,
                      size: 64,
                      color: primaryColor.withAlpha(100),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Weekly Performance Trends",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Interactive charts showing fulfillment rate, accuracy, and speed trends",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      "Recent Trend Analysis",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...performanceTrends.map((trend) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(12),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${trend["week"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "Fulfillment: ${trend["fulfillment"]}% | Accuracy: ${trend["accuracy"]}% | Speed: ${trend["speed"]}min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Benchmarks Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
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
                    SizedBox(height: spSm),
                    ...benchmarkData.map((benchmark) => _buildBenchmarkCard(benchmark)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
